---
title: Cumulative update 7 for SQL Server 2016 SP1 (KB4057119)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 7 (KB4057119).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4057119
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Business Intelligence
---

# KB4057119 - Cumulative Update 7 for SQL Server 2016 SP1

_Release Date:_ &nbsp; January 04, 2018  
_Version:_ &nbsp; 13.0.4466.4

Cumulative Update 7 (CU7) for Microsoft SQL Server 2016 Service Pack 1 (SP1) was also released as a SQL Server Security Bulletin on January 4, 2018, KB4058561. See [KB4058561](https://support.microsoft.com/help/4058561) for more information. In other words, the same physical package (SQLServer2016-KB4057119-x64.exe) was made available both as CU7 (KB4057119) and the Security Bulletin (KB4058561).

Because of this, you may already have CU7 installed as part of that security bulletin release and installation of this CU is unnecessary. If you do try to install CU7 after ADV180002, you may receive the following message:

> There are no SQL Server instances or shared features that can be updated on this computer

This indicates that CU7 is already installed and no further action is required.

This article describes cumulative update package 7 (build number: **13.0.4466.4**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| <a id=11173911>[11173911](#11173911) </a> | [FIX: Assertion occurs when you pass memory-optimized table variable into a stored procedure as table-valued parameter in SQL Server 2016 (KB4056117)](https://support.microsoft.com/help/4056117) | SQL Engine |
| <a id=11199159>[11199159](#11199159) </a> | [FIX: Error 156 when SQL Server replication article contains either GEOGRAPHY_AUTO_GRID or GEOMETRY_AUTO_GRID (KB4037412)](https://support.microsoft.com/help/4037412) | SQL Engine |
| <a id=11177245>[11177245](#11177245) </a> | [FIX: Error 27231 occurs when SSIS package that contains localized language is deployed in SQL Server 2016 (KB4056831)](https://support.microsoft.com/help/4056831)| Integration Services |
| <a id=11289879>[11289879](#11289879) </a> | [FIX: Queries that casts string or binary data to XML take a long time to compile in SQL Server 2016 (KB4056955)](https://support.microsoft.com/help/4056955)| SQL security |
| <a id=11293964>[11293964](#11293964) </a> | [FIX: A deadlock occurs when you run a parallel query on a clustered columnstore index in SQL Server 2016 (KB4057055)](https://support.microsoft.com/help/4057055) | SQL Engine |
| <a id=11176971>[11176971](#11176971) </a> | [Update to enable PolyBase technology in SQL Server 2016 and 2017V (KB4053293)](https://support.microsoft.com/help/4053293) | SQL Engine |
| <a id=11303628>[11303628](#11303628) </a> | [FIX: Error 14684 when you reconfigure Management Data Warehouse in a named instance of SQL Server 2016 (KB4057190)](https://support.microsoft.com/help/4057190) | Management Tools |
| <a id=11272976>[11272976](#11272976) </a> | [FIX: Memory leak occurs when you back up a database that contains memory-optimized objects in SQL Server 2016 (KB4057212)](https://support.microsoft.com/help/4057212)| In-Memory OLTP |
| <a id=11317877>[11317877](#11317877) </a> | [FIX: High CPU usage when large index is used in a query on a memory-optimized table in SQL Server 2016 (KB4057280)](https://support.microsoft.com/help/4057280) | In-Memory OLTP |
| <a id=11204967>[11204967](#11204967) </a> | [FIX: Error when you rebuild a single partition of an index online in SQL Server 2014 and 2016 (KB4055556)](https://support.microsoft.com/help/4055556)| SQL performance|
| <a id=11229828>[11229828](#11229828) </a> | [FIX: DBCC CHECKDB returns consistency errors if SOUNDEX function is used in PERSISTED computed columns in SQL Server (KB4055735)](https://support.microsoft.com/help/4055735) | SQL Engine |
| <a id=11281512>[11281512](#11281512) </a> | [FIX: Data-driven subscription fails after you upgrade from SSRS 2008 to SSRS 2016 (KB4042948)](https://support.microsoft.com/help/4042948)| Reporting Services |
| <a id=11204967>[11204967](#11204967) </a> | [FIX: Unable to rebuild the partition online for a table that contains a computed partitioning column in SQL Server 2014 or 2016 (KB3213683)](https://support.microsoft.com/help/3213683)| SQL engine |
| <a id=10855390>[10855390](#10855390) </a> | [FIX: Recovery of database takes a long time when it contains memory-optimized tables in SQL Server 2016 (KB4055727)](https://support.microsoft.com/help/4055727)| In-Memory OLTP |
| <a id=11017620>[11017620](#11017620) </a> | [FIX: Heavy tempdb contention occurs in SQL Server 2016 (KB4058174)](https://support.microsoft.com/help/4058174) | SQL Engine |
| <a id=11057297>[11057297](#11057297) </a> | [FIX: "Parameter missing value" error when you use a drillthrough report in SharePoint in SSRS (KB2963836)](https://support.microsoft.com/help/2963836)| Reporting Services |
| <a id=11091931>[11091931](#11091931) </a> | [FIX: Missing logs for Analysis Services Processing tasks in SQL Server 2016 Integration Services (KB4055674)](https://support.microsoft.com/help/4055674) | Analysis Services|
| <a id=11296783>[11296783](#11296783) </a> | [FIX: Multidimensional mode randomly crashes and an access violation occurs in SSAS 2016 or in SSAS 2014 (KB4057307)](https://support.microsoft.com/help/4057307)| Analysis Services|
| <a id=11200450>[11200450](#11200450) </a> | [FIX: "Incompletely installed" error on Feature Selection page when you modify the current installation of SQL Server 2016 SP1 or SQL Server 2016 SP1 CU5 (KB4055456)](https://support.microsoft.com/help/4055456) | Setup & Install|
| <a id=11205782>[11205782](#11205782) </a> | [FIX: "Msg 3948" error when you run a query on secondary replica of secondary availability group in SQL Server 2016 (KB4055281)](https://support.microsoft.com/help/4055281) | High Availability|
| <a id=11217082>[11217082](#11217082) </a> | [FIX: Log shipping fails when you use it together with Always On Availability Groups in SQL Server 2016 (KB4056821)](https://support.microsoft.com/help/4056821) | High Availability|
| <a id=11295738>[11295738](#11295738) </a> | [FIX: Internal error when you drill down hierarchy members in SSAS 2016 in multidimensional mode (KB4057759)](https://support.microsoft.com/help/4057759)| Analysis Services|

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

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available for specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

   > [!NOTE]
   > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

2. Locate the entry that corresponds to this cumulative update package under Microsoft SQL Server 2016.

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

This cumulative update package may not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

| File   name            | File version    | File size | Date      | Time  | Platform |
|------------------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll         | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Msmdredir.dll          | 2015.130.4466.4 | 6420656   | 22-Dec-2017 | 20:52 | x86      |
| Msmdsrv.rll            | 2015.130.4466.4 | 1296560   | 22-Dec-2017 | 20:52 | x86      |
| Msmdsrvi.rll           | 2015.130.4466.4 | 1293488   | 22-Dec-2017 | 20:52 | x86      |
| Sqlbrowser.exe         | 2015.130.4466.4 | 276656    | 22-Dec-2017 | 20:52 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe          | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4466.4 | 160432    | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                              | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Isacctchange.dll                            | 2015.130.4466.4 | 29360     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4466.4     | 1027248   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4466.4     | 1348784   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4466.4     | 702640    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4466.4     | 765616    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4466.4     | 520880    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4466.4     | 711856    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4466.4     | 37040     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4466.4     | 46256     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4466.4     | 598704    | 22-Dec-2017 | 20:51 | x86      |
| Msasxpress.dll                              | 2015.130.4466.4 | 31920     | 22-Dec-2017 | 20:52 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4466.4 | 60080     | 22-Dec-2017 | 20:52 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                               | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqlftacct.dll                               | 2015.130.4466.4 | 46768     | 22-Dec-2017 | 20:52 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4466.4 | 364208    | 22-Dec-2017 | 20:52 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4466.4 | 34992     | 22-Dec-2017 | 20:52 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4466.4 | 267440    | 22-Dec-2017 | 20:52 | x86      |
| Sqltdiagn.dll                               | 2015.130.4466.4 | 60592     | 22-Dec-2017 | 20:52 | x86      |
| Svrenumapi130.dll                           | 2015.130.4466.4 | 854192    | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 Data Quality

| File name                 | File version | File size | Date        | Time  | Platform |
|---------------------------|--------------|-----------|-------------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4466.4  | 1876656   | 22-Dec-2017 | 20:51 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4466.4 | 121008    | 22-Dec-2017 | 20:52 | x86      |
| Dreplaycommon.dll              | 2015.130.4466.4 | 690864    | 22-Dec-2017 | 20:51 | x86      |
| Dreplayserverps.dll            | 2015.130.4466.4 | 32944     | 22-Dec-2017 | 20:52 | x86      |
| Dreplayutil.dll                | 2015.130.4466.4 | 309936    | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                 | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Sqlresourceloader.dll          | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.130.4466.4 | 690864    | 22-Dec-2017 | 20:51 | x86      |
| Dreplaycontroller.exe              | 2015.130.4466.4 | 350384    | 22-Dec-2017 | 20:52 | x86      |
| Dreplayprocess.dll                 | 2015.130.4466.4 | 171696    | 22-Dec-2017 | 20:52 | x86      |
| Dreplayserverps.dll                | 2015.130.4466.4 | 32944     | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                     | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Sqlresourceloader.dll              | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4466.4 | 1311920   | 22-Dec-2017 | 20:52 | x86      |
| Ddsshapes.dll                                   | 2015.130.4466.4 | 135856    | 22-Dec-2017 | 20:52 | x86      |
| Dtaengine.exe                                   | 2015.130.4466.4 | 167088    | 22-Dec-2017 | 20:52 | x86      |
| Dteparse.dll                                    | 2015.130.4466.4 | 99504     | 22-Dec-2017 | 20:52 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4466.4 | 83624     | 22-Dec-2017 | 20:51 | x86      |
| Dtepkg.dll                                      | 2015.130.4466.4 | 115888    | 22-Dec-2017 | 20:52 | x86      |
| Dtexec.exe                                      | 2015.130.4466.4 | 66736     | 22-Dec-2017 | 20:52 | x86      |
| Dts.dll                                         | 2015.130.4466.4 | 2632880   | 22-Dec-2017 | 20:52 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4466.4 | 418992    | 22-Dec-2017 | 20:52 | x86      |
| Dtsconn.dll                                     | 2015.130.4466.4 | 392368    | 22-Dec-2017 | 20:52 | x86      |
| Dtshost.exe                                     | 2015.130.4466.4 | 76464     | 22-Dec-2017 | 20:52 | x86      |
| Dtslog.dll                                      | 2015.130.4466.4 | 103088    | 22-Dec-2017 | 20:52 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4466.4 | 541360    | 22-Dec-2017 | 20:52 | x86      |
| Dtspipeline.dll                                 | 2015.130.4466.4 | 1059504   | 22-Dec-2017 | 20:52 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4466.4 | 42160     | 22-Dec-2017 | 20:52 | x86      |
| Dtswizard.exe                                   | 13.0.4466.4     | 896176    | 22-Dec-2017 | 20:45 | x86      |
| Dtuparse.dll                                    | 2015.130.4466.4 | 80048     | 22-Dec-2017 | 20:52 | x86      |
| Dtutil.exe                                      | 2015.130.4466.4 | 115376    | 22-Dec-2017 | 20:52 | x86      |
| Exceldest.dll                                   | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Excelsrc.dll                                    | 2015.130.4466.4 | 232624    | 22-Dec-2017 | 20:52 | x86      |
| Flatfiledest.dll                                | 2015.130.4466.4 | 334512    | 22-Dec-2017 | 20:52 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4466.4 | 345264    | 22-Dec-2017 | 20:52 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4466.4 | 80560     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4466.4     | 1313448   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4466.4     | 696496    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4466.4     | 763568    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4466.4 | 2023088   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4466.4 | 42160     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4466.4     | 72368     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4466.4     | 186544    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4466.4     | 433840    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4466.4     | 2044592   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4466.4     | 33456     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4466.4     | 249512    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4466.4     | 501936    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4466.4     | 606376    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4466.4     | 106160    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4466.4 | 138928    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4466.4 | 144560    | 22-Dec-2017 | 20:52 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4466.4 | 89776     | 22-Dec-2017 | 20:52 | x86      |
| Msmdlocal.dll                                   | 2015.130.4466.4 | 37097136  | 22-Dec-2017 | 20:52 | x86      |
| Msmdpp.dll                                      | 2015.130.4466.4 | 6370480   | 22-Dec-2017 | 20:52 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4466.4 | 6507696   | 22-Dec-2017 | 20:51 | x86      |
| Msolap130.dll                                   | 2015.130.4466.4 | 7007920   | 22-Dec-2017 | 20:52 | x86      |
| Msolui130.dll                                   | 2015.130.4466.4 | 287408    | 22-Dec-2017 | 20:52 | x86      |
| Oledbdest.dll                                   | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Oledbsrc.dll                                    | 2015.130.4466.4 | 235696    | 22-Dec-2017 | 20:52 | x86      |
| Profiler.exe                                    | 2015.130.4466.4 | 804528    | 22-Dec-2017 | 20:45 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                                   | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqlresld.dll                                    | 2015.130.4466.4 | 28848     | 22-Dec-2017 | 20:52 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |
| Sqlscm.dll                                      | 2015.130.4466.4 | 52912     | 22-Dec-2017 | 20:52 | x86      |
| Sqlsvc.dll                                      | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:52 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4466.4 | 151216    | 22-Dec-2017 | 20:52 | x86      |
| Txdataconvert.dll                               | 2015.130.4466.4 | 255152    | 22-Dec-2017 | 20:51 | x86      |
| Xe.dll                                          | 2015.130.4466.4 | 558768    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrw.dll                                       | 2015.130.4466.4 | 259760    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4466.4 | 191664    | 22-Dec-2017 | 20:51 | x86      |
| Xmsrv.dll                                       | 2015.130.4466.4 | 32718000  | 22-Dec-2017 | 20:51 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time  | Platform |
|----------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Keyfile.dll    | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x86      |
| Msmdredir.dll  | 2015.130.4466.4 | 6420656   | 22-Dec-2017 | 20:52 | x86      |
| Msmdsrv.rll    | 2015.130.4466.4 | 1296560   | 22-Dec-2017 | 20:52 | x86      |
| Msmdsrvi.rll   | 2015.130.4466.4 | 1293488   | 22-Dec-2017 | 20:52 | x86      |
| Sqlbrowser.exe | 2015.130.4466.4 | 276656    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe  | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll        | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sqlboot.dll           | 2015.130.4466.4 | 186536    | 22-Dec-2017 | 20:54 | x64      |
| Sqldumper.exe         | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:54 | x64      |
| Sqlvdi.dll            | 2015.130.4466.4 | 168624    | 22-Dec-2017 | 20:52 | x86      |
| Sqlvdi.dll            | 2015.130.4466.4 | 197296    | 22-Dec-2017 | 20:53 | x64      |
| Sqlwriter.exe         | 2015.130.4466.4 | 131760    | 22-Dec-2017 | 20:52 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlwvss.dll           | 2015.130.4466.4 | 336560    | 22-Dec-2017 | 20:50 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4466.4 | 26288     | 22-Dec-2017 | 20:50 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4466.4     | 1347760   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4466.4     | 765608    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4466.4     | 521384    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4466.4     | 989872    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4466.4     | 989872    | 22-Dec-2017 | 20:53 | x86      |
| Msmdctr130.dll                                     | 2015.130.4466.4 | 40112     | 22-Dec-2017 | 20:54 | x64      |
| Msmdlocal.dll                                      | 2015.130.4466.4 | 37097136  | 22-Dec-2017 | 20:52 | x86      |
| Msmdlocal.dll                                      | 2015.130.4466.4 | 56201904  | 22-Dec-2017 | 20:55 | x64      |
| Msmdpump.dll                                       | 2015.130.4466.4 | 7798960   | 22-Dec-2017 | 20:54 | x64      |
| Msmdredir.dll                                      | 2015.130.4466.4 | 6420656   | 22-Dec-2017 | 20:52 | x86      |
| Msmdsrv.exe                                        | 2015.130.4466.4 | 56742576  | 22-Dec-2017 | 20:52 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4466.4 | 6507696   | 22-Dec-2017 | 20:51 | x86      |
| Msmgdsrv.dll                                       | 2015.130.4466.4 | 7507120   | 22-Dec-2017 | 20:52 | x64      |
| Msolap130.dll                                      | 2015.130.4466.4 | 7007920   | 22-Dec-2017 | 20:52 | x86      |
| Msolap130.dll                                      | 2015.130.4466.4 | 8639152   | 22-Dec-2017 | 20:54 | x64      |
| Msolui130.dll                                      | 2015.130.4466.4 | 287408    | 22-Dec-2017 | 20:52 | x86      |
| Msolui130.dll                                      | 2015.130.4466.4 | 310448    | 22-Dec-2017 | 20:54 | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlboot.dll                                        | 2015.130.4466.4 | 186536    | 22-Dec-2017 | 20:54 | x64      |
| Sqlceip.exe                                        | 13.0.4466.4     | 247984    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                                      | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                                      | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:54 | x64      |
| Tmapi.dll                                          | 2015.130.4466.4 | 4346032   | 22-Dec-2017 | 20:50 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4466.4 | 2826416   | 22-Dec-2017 | 20:50 | x64      |
| Tmpersistence.dll                                  | 2015.130.4466.4 | 1071280   | 22-Dec-2017 | 20:50 | x64      |
| Tmtransactions.dll                                 | 2015.130.4466.4 | 1352368   | 22-Dec-2017 | 20:50 | x64      |
| Xe.dll                                             | 2015.130.4466.4 | 626352    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrw.dll                                          | 2015.130.4466.4 | 259760    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrw.dll                                          | 2015.130.4466.4 | 319152    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrwbin.dll                                       | 2015.130.4466.4 | 191664    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrwbin.dll                                       | 2015.130.4466.4 | 227504    | 22-Dec-2017 | 20:53 | x64      |
| Xmsrv.dll                                          | 2015.130.4466.4 | 24041648  | 22-Dec-2017 | 20:50 | x64      |
| Xmsrv.dll                                          | 2015.130.4466.4 | 32718000  | 22-Dec-2017 | 20:51 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4466.4 | 160432    | 22-Dec-2017 | 20:52 | x86      |
| Batchparser.dll                             | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:53 | x64      |
| Instapi130.dll                              | 2015.130.4466.4 | 53424     | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                              | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Isacctchange.dll                            | 2015.130.4466.4 | 29360     | 22-Dec-2017 | 20:52 | x86      |
| Isacctchange.dll                            | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:54 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4466.4     | 1027248   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4466.4     | 1027248   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4466.4     | 1348784   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4466.4     | 702640    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4466.4     | 765616    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4466.4     | 520880    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4466.4     | 711856    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4466.4     | 711856    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4466.4     | 37040     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4466.4     | 46256     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4466.4 | 75440     | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4466.4     | 598704    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4466.4     | 598704    | 22-Dec-2017 | 20:52 | x86      |
| Msasxpress.dll                              | 2015.130.4466.4 | 31920     | 22-Dec-2017 | 20:52 | x86      |
| Msasxpress.dll                              | 2015.130.4466.4 | 36016     | 22-Dec-2017 | 20:54 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4466.4 | 60080     | 22-Dec-2017 | 20:52 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:54 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqldumper.exe                               | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                               | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:54 | x64      |
| Sqlftacct.dll                               | 2015.130.4466.4 | 46768     | 22-Dec-2017 | 20:52 | x86      |
| Sqlftacct.dll                               | 2015.130.4466.4 | 51888     | 22-Dec-2017 | 20:54 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4466.4 | 404144    | 22-Dec-2017 | 20:50 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4466.4 | 364208    | 22-Dec-2017 | 20:52 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4466.4 | 37552     | 22-Dec-2017 | 20:50 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4466.4 | 34992     | 22-Dec-2017 | 20:52 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4466.4 | 348848    | 22-Dec-2017 | 20:50 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4466.4 | 267440    | 22-Dec-2017 | 20:52 | x86      |
| Sqltdiagn.dll                               | 2015.130.4466.4 | 67760     | 22-Dec-2017 | 20:50 | x64      |
| Sqltdiagn.dll                               | 2015.130.4466.4 | 60592     | 22-Dec-2017 | 20:52 | x86      |
| Svrenumapi130.dll                           | 2015.130.4466.4 | 1115824   | 22-Dec-2017 | 20:50 | x64      |
| Svrenumapi130.dll                           | 2015.130.4466.4 | 854192    | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4466.4  | 1876656   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4466.4  | 1876656   | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4466.4 | 121008    | 22-Dec-2017 | 20:52 | x86      |
| Dreplaycommon.dll              | 2015.130.4466.4 | 690864    | 22-Dec-2017 | 20:51 | x86      |
| Dreplayserverps.dll            | 2015.130.4466.4 | 32944     | 22-Dec-2017 | 20:52 | x86      |
| Dreplayutil.dll                | 2015.130.4466.4 | 309936    | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                 | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlresourceloader.dll          | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4466.4 | 121008    | 22-Dec-2017 | 20:52 | x86      |
| Dreplaycommon.dll              | 2015.130.4466.4 | 690864    | 22-Dec-2017 | 20:51 | x86      |
| Dreplayserverps.dll            | 2015.130.4466.4 | 32944     | 22-Dec-2017 | 20:52 | x86      |
| Dreplayutil.dll                | 2015.130.4466.4 | 309936    | 22-Dec-2017 | 20:52 | x86      |
| Instapi130.dll                 | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlresourceloader.dll          | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4466.4     | 41136     | 22-Dec-2017 | 20:52 | x64      |
| Batchparser.dll                              | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:53 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925360    | 22-Dec-2017 | 20:53 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341360   | 22-Dec-2017 | 20:53 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192176    | 22-Dec-2017 | 20:54 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 9-Dec-16  | 0:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4466.4 | 225456    | 22-Dec-2017 | 20:54 | x64      |
| Dcexec.exe                                   | 2015.130.4466.4 | 74416     | 22-Dec-2017 | 20:52 | x64      |
| Fssres.dll                                   | 2015.130.4466.4 | 81584     | 22-Dec-2017 | 20:54 | x64      |
| Hadrres.dll                                  | 2015.130.4466.4 | 177840    | 22-Dec-2017 | 20:53 | x64      |
| Hkcompile.dll                                | 2015.130.4466.4 | 1298096   | 22-Dec-2017 | 20:53 | x64      |
| Hkengine.dll                                 | 2015.130.4466.4 | 5601456   | 22-Dec-2017 | 20:53 | x64      |
| Hkruntime.dll                                | 2015.130.4466.4 | 158896    | 22-Dec-2017 | 20:53 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017520   | 22-Dec-2017 | 20:54 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4466.4     | 235184    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4466.4     | 79536     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4466.4 | 391856    | 22-Dec-2017 | 20:56 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4466.4 | 71344     | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4466.4 | 65200     | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4466.4 | 150192    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4466.4 | 158896    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4466.4 | 272048    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4466.4 | 74928     | 22-Dec-2017 | 20:56 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129712    | 22-Dec-2017 | 20:53 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559280    | 22-Dec-2017 | 20:53 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559280    | 22-Dec-2017 | 20:53 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661168    | 22-Dec-2017 | 20:53 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964784    | 22-Dec-2017 | 20:53 | x64      |
| Odsole70.dll                                 | 2015.130.4466.4 | 92848     | 22-Dec-2017 | 20:54 | x64      |
| Opends60.dll                                 | 2015.130.4466.4 | 32944     | 22-Dec-2017 | 20:53 | x64      |
| Qds.dll                                      | 2015.130.4466.4 | 845488    | 22-Dec-2017 | 20:54 | x64      |
| Rsfxft.dll                                   | 2015.130.4466.4 | 34480     | 22-Dec-2017 | 20:53 | x64      |
| Sqagtres.dll                                 | 2015.130.4466.4 | 64680     | 22-Dec-2017 | 20:54 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlaamss.dll                                 | 2015.130.4466.4 | 80560     | 22-Dec-2017 | 20:52 | x64      |
| Sqlaccess.dll                                | 2015.130.4466.4 | 462512    | 22-Dec-2017 | 20:56 | x64      |
| Sqlagent.exe                                 | 2015.130.4466.4 | 566448    | 22-Dec-2017 | 20:52 | x64      |
| Sqlagentctr130.dll                           | 2015.130.4466.4 | 44208     | 22-Dec-2017 | 20:51 | x86      |
| Sqlagentctr130.dll                           | 2015.130.4466.4 | 51888     | 22-Dec-2017 | 20:54 | x64      |
| Sqlagentlog.dll                              | 2015.130.4466.4 | 32936     | 22-Dec-2017 | 20:54 | x64      |
| Sqlagentmail.dll                             | 2015.130.4466.4 | 47792     | 22-Dec-2017 | 20:52 | x64      |
| Sqlboot.dll                                  | 2015.130.4466.4 | 186536    | 22-Dec-2017 | 20:54 | x64      |
| Sqlceip.exe                                  | 13.0.4466.4     | 247984    | 22-Dec-2017 | 20:52 | x86      |
| Sqlcmdss.dll                                 | 2015.130.4466.4 | 60080     | 22-Dec-2017 | 20:54 | x64      |
| Sqlctr130.dll                                | 2015.130.4466.4 | 103600    | 22-Dec-2017 | 20:52 | x86      |
| Sqlctr130.dll                                | 2015.130.4466.4 | 118448    | 22-Dec-2017 | 20:53 | x64      |
| Sqldk.dll                                    | 2015.130.4466.4 | 2587312   | 22-Dec-2017 | 20:54 | x64      |
| Sqldtsss.dll                                 | 2015.130.4466.4 | 97456     | 22-Dec-2017 | 20:52 | x64      |
| Sqliosim.com                                 | 2015.130.4466.4 | 307888    | 22-Dec-2017 | 20:51 | x64      |
| Sqliosim.exe                                 | 2015.130.4466.4 | 3014320   | 22-Dec-2017 | 20:52 | x64      |
| Sqllang.dll                                  | 2015.130.4466.4 | 39422640  | 22-Dec-2017 | 20:55 | x64      |
| Sqlmin.dll                                   | 2015.130.4466.4 | 37579440  | 22-Dec-2017 | 20:50 | x64      |
| Sqlolapss.dll                                | 2015.130.4466.4 | 97968     | 22-Dec-2017 | 20:52 | x64      |
| Sqlos.dll                                    | 2015.130.4466.4 | 26288     | 22-Dec-2017 | 20:53 | x64      |
| Sqlpowershellss.dll                          | 2015.130.4466.4 | 58536     | 22-Dec-2017 | 20:50 | x64      |
| Sqlrepss.dll                                 | 2015.130.4466.4 | 54960     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresld.dll                                 | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresourceloader.dll                        | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlscm.dll                                   | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4466.4 | 27824     | 22-Dec-2017 | 20:50 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4466.4 | 5797552   | 22-Dec-2017 | 20:53 | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4466.4 | 732848    | 22-Dec-2017 | 20:53 | x64      |
| Sqlservr.exe                                 | 2015.130.4466.4 | 392880    | 22-Dec-2017 | 20:52 | x64      |
| Sqlsvc.dll                                   | 2015.130.4466.4 | 152240    | 22-Dec-2017 | 20:50 | x64      |
| Sqltses.dll                                  | 2015.130.4466.4 | 8896688   | 22-Dec-2017 | 20:50 | x64      |
| Sqsrvres.dll                                 | 2015.130.4466.4 | 251056    | 22-Dec-2017 | 20:50 | x64      |
| Stretchcodegen.exe                           | 13.0.4466.4     | 55984     | 22-Dec-2017 | 20:52 | x86      |
| Xe.dll                                       | 2015.130.4466.4 | 626352    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrw.dll                                    | 2015.130.4466.4 | 319152    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrwbin.dll                                 | 2015.130.4466.4 | 227504    | 22-Dec-2017 | 20:53 | x64      |
| Xpadsi.exe                                   | 2015.130.4466.4 | 79024     | 22-Dec-2017 | 20:53 | x64      |
| Xplog70.dll                                  | 2015.130.4466.4 | 65712     | 22-Dec-2017 | 20:53 | x64      |
| Xpqueue.dll                                  | 2015.130.4466.4 | 74928     | 22-Dec-2017 | 20:50 | x64      |
| Xprepl.dll                                   | 2015.130.4466.4 | 91312     | 22-Dec-2017 | 20:50 | x64      |
| Xpsqlbot.dll                                 | 2015.130.4466.4 | 33456     | 22-Dec-2017 | 20:53 | x64      |
| Xpstar.dll                                   | 2015.130.4466.4 | 422576    | 22-Dec-2017 | 20:53 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4466.4 | 160432    | 22-Dec-2017 | 20:52 | x86      |
| Batchparser.dll                                                    | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:53 | x64      |
| Bcp.exe                                                            | 2015.130.4466.4 | 119984    | 22-Dec-2017 | 20:54 | x64      |
| Commanddest.dll                                                    | 2015.130.4466.4 | 249008    | 22-Dec-2017 | 20:54 | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4466.4 | 115888    | 22-Dec-2017 | 20:54 | x64      |
| Datacollectortasks.dll                                             | 2015.130.4466.4 | 188080    | 22-Dec-2017 | 20:54 | x64      |
| Distrib.exe                                                        | 2015.130.4466.4 | 191152    | 22-Dec-2017 | 20:52 | x64      |
| Dteparse.dll                                                       | 2015.130.4466.4 | 109744    | 22-Dec-2017 | 20:54 | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x64      |
| Dtepkg.dll                                                         | 2015.130.4466.4 | 137392    | 22-Dec-2017 | 20:54 | x64      |
| Dtexec.exe                                                         | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:52 | x64      |
| Dts.dll                                                            | 2015.130.4466.4 | 3146928   | 22-Dec-2017 | 20:54 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4466.4 | 477360    | 22-Dec-2017 | 20:54 | x64      |
| Dtsconn.dll                                                        | 2015.130.4466.4 | 492720    | 22-Dec-2017 | 20:54 | x64      |
| Dtshost.exe                                                        | 2015.130.4466.4 | 86704     | 22-Dec-2017 | 20:52 | x64      |
| Dtslog.dll                                                         | 2015.130.4466.4 | 120496    | 22-Dec-2017 | 20:54 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4466.4 | 545456    | 22-Dec-2017 | 20:54 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4466.4 | 1279152   | 22-Dec-2017 | 20:54 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4466.4 | 48304     | 22-Dec-2017 | 20:54 | x64      |
| Dtswizard.exe                                                      | 13.0.4466.4     | 895664    | 22-Dec-2017 | 20:52 | x64      |
| Dtuparse.dll                                                       | 2015.130.4466.4 | 87728     | 22-Dec-2017 | 20:54 | x64      |
| Dtutil.exe                                                         | 2015.130.4466.4 | 134832    | 22-Dec-2017 | 20:52 | x64      |
| Exceldest.dll                                                      | 2015.130.4466.4 | 263344    | 22-Dec-2017 | 20:54 | x64      |
| Excelsrc.dll                                                       | 2015.130.4466.4 | 285360    | 22-Dec-2017 | 20:54 | x64      |
| Execpackagetask.dll                                                | 2015.130.4466.4 | 166576    | 22-Dec-2017 | 20:54 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4466.4 | 389296    | 22-Dec-2017 | 20:54 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4466.4 | 401584    | 22-Dec-2017 | 20:54 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4466.4 | 96432     | 22-Dec-2017 | 20:54 | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4466.4 | 59056     | 22-Dec-2017 | 20:53 | x64      |
| Logread.exe                                                        | 2015.130.4466.4 | 617136    | 22-Dec-2017 | 20:52 | x64      |
| Mergetxt.dll                                                       | 2015.130.4466.4 | 53936     | 22-Dec-2017 | 20:54 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4466.4     | 1313456   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4466.4     | 696496    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4466.4     | 763568    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 22-Dec-2017 | 10:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4466.4     | 54448     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4466.4     | 89776     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4466.4     | 49840     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4466.4     | 43184     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4466.4     | 70832     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4466.4     | 35504     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4466.4     | 73392     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4466.4     | 63664     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4466.4     | 31408     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4466.4     | 131248    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4466.4     | 43696     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4466.4     | 57520     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4466.4     | 606384    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4466.4     | 215216    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 22:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4466.4 | 1639088   | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4466.4 | 150192    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4466.4 | 158896    | 22-Dec-2017 | 20:56 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4466.4 | 101040    | 22-Dec-2017 | 20:54 | x64      |
| Msgprox.dll                                                        | 2015.130.4466.4 | 275632    | 22-Dec-2017 | 20:54 | x64      |
| Msxmlsql.dll                                                       | 2015.130.4466.4 | 1494696   | 22-Dec-2017 | 20:53 | x64      |
| Oledbdest.dll                                                      | 2015.130.4466.4 | 264368    | 22-Dec-2017 | 20:54 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4466.4 | 290992    | 22-Dec-2017 | 20:54 | x64      |
| Osql.exe                                                           | 2015.130.4466.4 | 75440     | 22-Dec-2017 | 20:54 | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4466.4 | 469168    | 22-Dec-2017 | 20:52 | x64      |
| Rawdest.dll                                                        | 2015.130.4466.4 | 209584    | 22-Dec-2017 | 20:54 | x64      |
| Rawsource.dll                                                      | 2015.130.4466.4 | 196784    | 22-Dec-2017 | 20:54 | x64      |
| Rdistcom.dll                                                       | 2015.130.4466.4 | 893616    | 22-Dec-2017 | 20:54 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4466.4 | 187048    | 22-Dec-2017 | 20:54 | x64      |
| Replagnt.dll                                                       | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:54 | x64      |
| Repldp.dll                                                         | 2015.130.4466.4 | 277168    | 22-Dec-2017 | 20:54 | x64      |
| Replerrx.dll                                                       | 2015.130.4466.4 | 144560    | 22-Dec-2017 | 20:54 | x64      |
| Replisapi.dll                                                      | 2015.130.4466.4 | 354480    | 22-Dec-2017 | 20:54 | x64      |
| Replmerg.exe                                                       | 2015.130.4466.4 | 518832    | 22-Dec-2017 | 20:52 | x64      |
| Replprov.dll                                                       | 2015.130.4466.4 | 812208    | 22-Dec-2017 | 20:54 | x64      |
| Replrec.dll                                                        | 2015.130.4466.4 | 1018544   | 22-Dec-2017 | 20:52 | x64      |
| Replsub.dll                                                        | 2015.130.4466.4 | 467632    | 22-Dec-2017 | 20:54 | x64      |
| Replsync.dll                                                       | 2015.130.4466.4 | 144048    | 22-Dec-2017 | 20:54 | x64      |
| Spresolv.dll                                                       | 2015.130.4466.4 | 245424    | 22-Dec-2017 | 20:54 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlcmd.exe                                                         | 2015.130.4466.4 | 249520    | 22-Dec-2017 | 20:54 | x64      |
| Sqldiag.exe                                                        | 2015.130.4466.4 | 1257648   | 22-Dec-2017 | 20:52 | x64      |
| Sqldistx.dll                                                       | 2015.130.4466.4 | 215728    | 22-Dec-2017 | 20:54 | x64      |
| Sqllogship.exe                                                     | 13.0.4466.4     | 100528    | 22-Dec-2017 | 20:52 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4466.4 | 346800    | 22-Dec-2017 | 20:50 | x64      |
| Sqlps.exe                                                          | 13.0.4466.4     | 60080     | 22-Dec-2017 | 20:51 | x86      |
| Sqlresld.dll                                                       | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresld.dll                                                       | 2015.130.4466.4 | 28848     | 22-Dec-2017 | 20:52 | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |
| Sqlscm.dll                                                         | 2015.130.4466.4 | 52912     | 22-Dec-2017 | 20:52 | x86      |
| Sqlscm.dll                                                         | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4466.4 | 152240    | 22-Dec-2017 | 20:50 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:52 | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:50 | x64      |
| Sqlwep130.dll                                                      | 2015.130.4466.4 | 105648    | 22-Dec-2017 | 20:50 | x64      |
| Ssdebugps.dll                                                      | 2015.130.4466.4 | 33456     | 22-Dec-2017 | 20:50 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4466.4 | 216240    | 22-Dec-2017 | 20:50 | x64      |
| Ssradd.dll                                                         | 2015.130.4466.4 | 65200     | 22-Dec-2017 | 20:50 | x64      |
| Ssravg.dll                                                         | 2015.130.4466.4 | 65200     | 22-Dec-2017 | 20:50 | x64      |
| Ssrdown.dll                                                        | 2015.130.4466.4 | 50864     | 22-Dec-2017 | 20:50 | x64      |
| Ssrmax.dll                                                         | 2015.130.4466.4 | 63664     | 22-Dec-2017 | 20:50 | x64      |
| Ssrmin.dll                                                         | 2015.130.4466.4 | 63664     | 22-Dec-2017 | 20:50 | x64      |
| Ssrpub.dll                                                         | 2015.130.4466.4 | 51376     | 22-Dec-2017 | 20:50 | x64      |
| Ssrup.dll                                                          | 2015.130.4466.4 | 50864     | 22-Dec-2017 | 20:50 | x64      |
| Txagg.dll                                                          | 2015.130.4466.4 | 364720    | 22-Dec-2017 | 20:50 | x64      |
| Txbdd.dll                                                          | 2015.130.4466.4 | 172720    | 22-Dec-2017 | 20:50 | x64      |
| Txdatacollector.dll                                                | 2015.130.4466.4 | 367792    | 22-Dec-2017 | 20:50 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4466.4 | 296624    | 22-Dec-2017 | 20:50 | x64      |
| Txderived.dll                                                      | 2015.130.4466.4 | 607920    | 22-Dec-2017 | 20:50 | x64      |
| Txlookup.dll                                                       | 2015.130.4466.4 | 532144    | 22-Dec-2017 | 20:50 | x64      |
| Txmerge.dll                                                        | 2015.130.4466.4 | 230056    | 22-Dec-2017 | 20:50 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4466.4 | 278704    | 22-Dec-2017 | 20:50 | x64      |
| Txmulticast.dll                                                    | 2015.130.4466.4 | 128176    | 22-Dec-2017 | 20:50 | x64      |
| Txrowcount.dll                                                     | 2015.130.4466.4 | 126640    | 22-Dec-2017 | 20:50 | x64      |
| Txsort.dll                                                         | 2015.130.4466.4 | 258736    | 22-Dec-2017 | 20:50 | x64      |
| Txsplit.dll                                                        | 2015.130.4466.4 | 600752    | 22-Dec-2017 | 20:50 | x64      |
| Txunionall.dll                                                     | 2015.130.4466.4 | 181936    | 22-Dec-2017 | 20:50 | x64      |
| Xe.dll                                                             | 2015.130.4466.4 | 626352    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrw.dll                                                          | 2015.130.4466.4 | 319152    | 22-Dec-2017 | 20:53 | x64      |
| Xmlsub.dll                                                         | 2015.130.4466.4 | 251056    | 22-Dec-2017 | 20:50 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.4466.4 | 1013936   | 22-Dec-2017 | 20:54 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlsatellite.dll              | 2015.130.4466.4 | 836784    | 22-Dec-2017 | 20:53 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.4466.4 | 660144    | 22-Dec-2017 | 20:53 | x64      |
| Fdhost.exe               | 2015.130.4466.4 | 105136    | 22-Dec-2017 | 20:54 | x64      |
| Fdlauncher.exe           | 2015.130.4466.4 | 51376     | 22-Dec-2017 | 20:54 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlft130ph.dll           | 2015.130.4466.4 | 58032     | 22-Dec-2017 | 20:53 | x64      |

SQL Server 2016 sql_inst_mr

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.4466.4 | 660144    | 22-Dec-2017 | 20:53 | x64      |
| Fdhost.exe               | 2015.130.4466.4 | 105136    | 22-Dec-2017 | 20:54 | x64      |
| Fdlauncher.exe           | 2015.130.4466.4 | 51376     | 22-Dec-2017 | 20:54 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlft130ph.dll           | 2015.130.4466.4 | 58032     | 22-Dec-2017 | 20:53 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 22-Nov-2017 | 15:46 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 22-Dec-2017 | 10:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 22-Nov-2017 | 15:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 22-Dec-2017 | 10:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 22-Nov-2017 | 15:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 22-Dec-2017 | 10:46 | x86      |
| Commanddest.dll                                                    | 2015.130.4466.4 | 202920    | 22-Dec-2017 | 20:52 | x86      |
| Commanddest.dll                                                    | 2015.130.4466.4 | 249008    | 22-Dec-2017 | 20:54 | x64      |
| Dteparse.dll                                                       | 2015.130.4466.4 | 99504     | 22-Dec-2017 | 20:52 | x86      |
| Dteparse.dll                                                       | 2015.130.4466.4 | 109744    | 22-Dec-2017 | 20:54 | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4466.4 | 83624     | 22-Dec-2017 | 20:51 | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x64      |
| Dtepkg.dll                                                         | 2015.130.4466.4 | 115888    | 22-Dec-2017 | 20:52 | x86      |
| Dtepkg.dll                                                         | 2015.130.4466.4 | 137392    | 22-Dec-2017 | 20:54 | x64      |
| Dtexec.exe                                                         | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:52 | x64      |
| Dtexec.exe                                                         | 2015.130.4466.4 | 66736     | 22-Dec-2017 | 20:52 | x86      |
| Dts.dll                                                            | 2015.130.4466.4 | 2632880   | 22-Dec-2017 | 20:52 | x86      |
| Dts.dll                                                            | 2015.130.4466.4 | 3146928   | 22-Dec-2017 | 20:54 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4466.4 | 418992    | 22-Dec-2017 | 20:52 | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4466.4 | 477360    | 22-Dec-2017 | 20:54 | x64      |
| Dtsconn.dll                                                        | 2015.130.4466.4 | 392368    | 22-Dec-2017 | 20:52 | x86      |
| Dtsconn.dll                                                        | 2015.130.4466.4 | 492720    | 22-Dec-2017 | 20:54 | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4466.4 | 109744    | 22-Dec-2017 | 20:52 | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4466.4 | 93872     | 22-Dec-2017 | 20:52 | x86      |
| Dtshost.exe                                                        | 2015.130.4466.4 | 86704     | 22-Dec-2017 | 20:52 | x64      |
| Dtshost.exe                                                        | 2015.130.4466.4 | 76464     | 22-Dec-2017 | 20:52 | x86      |
| Dtslog.dll                                                         | 2015.130.4466.4 | 103088    | 22-Dec-2017 | 20:52 | x86      |
| Dtslog.dll                                                         | 2015.130.4466.4 | 120496    | 22-Dec-2017 | 20:54 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4466.4 | 541360    | 22-Dec-2017 | 20:52 | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4466.4 | 545456    | 22-Dec-2017 | 20:54 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4466.4 | 1059504   | 22-Dec-2017 | 20:52 | x86      |
| Dtspipeline.dll                                                    | 2015.130.4466.4 | 1279152   | 22-Dec-2017 | 20:54 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4466.4 | 42160     | 22-Dec-2017 | 20:52 | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4466.4 | 48304     | 22-Dec-2017 | 20:54 | x64      |
| Dtswizard.exe                                                      | 13.0.4466.4     | 896176    | 22-Dec-2017 | 20:45 | x86      |
| Dtswizard.exe                                                      | 13.0.4466.4     | 895664    | 22-Dec-2017 | 20:52 | x64      |
| Dtuparse.dll                                                       | 2015.130.4466.4 | 80048     | 22-Dec-2017 | 20:52 | x86      |
| Dtuparse.dll                                                       | 2015.130.4466.4 | 87728     | 22-Dec-2017 | 20:54 | x64      |
| Dtutil.exe                                                         | 2015.130.4466.4 | 134832    | 22-Dec-2017 | 20:52 | x64      |
| Dtutil.exe                                                         | 2015.130.4466.4 | 115376    | 22-Dec-2017 | 20:52 | x86      |
| Exceldest.dll                                                      | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Exceldest.dll                                                      | 2015.130.4466.4 | 263344    | 22-Dec-2017 | 20:54 | x64      |
| Excelsrc.dll                                                       | 2015.130.4466.4 | 232624    | 22-Dec-2017 | 20:52 | x86      |
| Excelsrc.dll                                                       | 2015.130.4466.4 | 285360    | 22-Dec-2017 | 20:54 | x64      |
| Execpackagetask.dll                                                | 2015.130.4466.4 | 135344    | 22-Dec-2017 | 20:52 | x86      |
| Execpackagetask.dll                                                | 2015.130.4466.4 | 166576    | 22-Dec-2017 | 20:54 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4466.4 | 334512    | 22-Dec-2017 | 20:52 | x86      |
| Flatfiledest.dll                                                   | 2015.130.4466.4 | 389296    | 22-Dec-2017 | 20:54 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4466.4 | 345264    | 22-Dec-2017 | 20:52 | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4466.4 | 401584    | 22-Dec-2017 | 20:54 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4466.4 | 80560     | 22-Dec-2017 | 20:52 | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4466.4 | 96432     | 22-Dec-2017 | 20:54 | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4466.4     | 439984    | 22-Dec-2017 | 20:45 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4466.4     | 438960    | 22-Dec-2017 | 20:52 | x64      |
| Isserverexec.exe                                                   | 13.0.4466.4     | 132784    | 22-Dec-2017 | 20:45 | x86      |
| Isserverexec.exe                                                   | 13.0.4466.4     | 132272    | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4466.4     | 1313448   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4466.4     | 1313456   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4466.4     | 696496    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4466.4     | 696496    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4466.4     | 763568    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4466.4     | 763568    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 7-Dec-17  | 22:30 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 22-Dec-2017 | 10:46 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4466.4     | 72368     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4466.4 | 112304    | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4466.4 | 107184    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4466.4     | 54448     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4466.4     | 54448     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4466.4     | 89776     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4466.4     | 89776     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4466.4     | 43176     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4466.4     | 43184     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4466.4     | 35504     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4466.4     | 35504     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4466.4     | 73392     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4466.4     | 73392     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4466.4     | 31408     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4466.4     | 31408     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4466.4     | 469680    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4466.4     | 469680    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4466.4     | 43696     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4466.4     | 43696     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4466.4     | 57520     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4466.4     | 57520     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4466.4     | 52912     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4466.4     | 52912     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4466.4     | 606376    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4466.4     | 606384    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4466.4 | 138928    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4466.4 | 150192    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4466.4 | 144560    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4466.4 | 158896    | 22-Dec-2017 | 20:56 | x64      |
| Msdtssrvr.exe                                                      | 13.0.4466.4     | 216752    | 22-Dec-2017 | 20:52 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4466.4 | 89776     | 22-Dec-2017 | 20:52 | x86      |
| Msdtssrvrutil.dll                                                  | 2015.130.4466.4 | 101040    | 22-Dec-2017 | 20:54 | x64      |
| Msmdpp.dll                                                         | 2015.130.4466.4 | 7646384   | 22-Dec-2017 | 20:54 | x64      |
| Oledbdest.dll                                                      | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Oledbdest.dll                                                      | 2015.130.4466.4 | 264368    | 22-Dec-2017 | 20:54 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4466.4 | 235696    | 22-Dec-2017 | 20:52 | x86      |
| Oledbsrc.dll                                                       | 2015.130.4466.4 | 290992    | 22-Dec-2017 | 20:54 | x64      |
| Rawdest.dll                                                        | 2015.130.4466.4 | 168624    | 22-Dec-2017 | 20:52 | x86      |
| Rawdest.dll                                                        | 2015.130.4466.4 | 209584    | 22-Dec-2017 | 20:54 | x64      |
| Rawsource.dll                                                      | 2015.130.4466.4 | 155312    | 22-Dec-2017 | 20:52 | x86      |
| Rawsource.dll                                                      | 2015.130.4466.4 | 196784    | 22-Dec-2017 | 20:54 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4466.4 | 151728    | 22-Dec-2017 | 20:52 | x86      |
| Recordsetdest.dll                                                  | 2015.130.4466.4 | 187048    | 22-Dec-2017 | 20:54 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqlceip.exe                                                        | 13.0.4466.4     | 247984    | 22-Dec-2017 | 20:52 | x86      |
| Sqldest.dll                                                        | 2015.130.4466.4 | 215728    | 22-Dec-2017 | 20:52 | x86      |
| Sqldest.dll                                                        | 2015.130.4466.4 | 263856    | 22-Dec-2017 | 20:54 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:50 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4466.4 | 151216    | 22-Dec-2017 | 20:52 | x86      |
| Ssisoledb.dll                                                      | 2015.130.4466.4 | 216240    | 22-Dec-2017 | 20:50 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4466.4 | 176816    | 22-Dec-2017 | 20:52 | x86      |
| Txagg.dll                                                          | 2015.130.4466.4 | 364720    | 22-Dec-2017 | 20:50 | x64      |
| Txagg.dll                                                          | 2015.130.4466.4 | 304816    | 22-Dec-2017 | 20:51 | x86      |
| Txbdd.dll                                                          | 2015.130.4466.4 | 172720    | 22-Dec-2017 | 20:50 | x64      |
| Txbdd.dll                                                          | 2015.130.4466.4 | 137904    | 22-Dec-2017 | 20:51 | x86      |
| Txbestmatch.dll                                                    | 2015.130.4466.4 | 611504    | 22-Dec-2017 | 20:50 | x64      |
| Txbestmatch.dll                                                    | 2015.130.4466.4 | 496304    | 22-Dec-2017 | 20:51 | x86      |
| Txcache.dll                                                        | 2015.130.4466.4 | 183472    | 22-Dec-2017 | 20:50 | x64      |
| Txcache.dll                                                        | 2015.130.4466.4 | 148144    | 22-Dec-2017 | 20:51 | x86      |
| Txcharmap.dll                                                      | 2015.130.4466.4 | 289968    | 22-Dec-2017 | 20:50 | x64      |
| Txcharmap.dll                                                      | 2015.130.4466.4 | 250544    | 22-Dec-2017 | 20:51 | x86      |
| Txcopymap.dll                                                      | 2015.130.4466.4 | 182960    | 22-Dec-2017 | 20:50 | x64      |
| Txcopymap.dll                                                      | 2015.130.4466.4 | 147624    | 22-Dec-2017 | 20:51 | x86      |
| Txdataconvert.dll                                                  | 2015.130.4466.4 | 296624    | 22-Dec-2017 | 20:50 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4466.4 | 255152    | 22-Dec-2017 | 20:51 | x86      |
| Txderived.dll                                                      | 2015.130.4466.4 | 607920    | 22-Dec-2017 | 20:50 | x64      |
| Txderived.dll                                                      | 2015.130.4466.4 | 519344    | 22-Dec-2017 | 20:51 | x86      |
| Txfileextractor.dll                                                | 2015.130.4466.4 | 201904    | 22-Dec-2017 | 20:50 | x64      |
| Txfileextractor.dll                                                | 2015.130.4466.4 | 162992    | 22-Dec-2017 | 20:51 | x86      |
| Txfileinserter.dll                                                 | 2015.130.4466.4 | 199856    | 22-Dec-2017 | 20:50 | x64      |
| Txfileinserter.dll                                                 | 2015.130.4466.4 | 160944    | 22-Dec-2017 | 20:51 | x86      |
| Txgroupdups.dll                                                    | 2015.130.4466.4 | 290992    | 22-Dec-2017 | 20:50 | x64      |
| Txgroupdups.dll                                                    | 2015.130.4466.4 | 231600    | 22-Dec-2017 | 20:51 | x86      |
| Txlineage.dll                                                      | 2015.130.4466.4 | 137392    | 22-Dec-2017 | 20:50 | x64      |
| Txlineage.dll                                                      | 2015.130.4466.4 | 109232    | 22-Dec-2017 | 20:51 | x86      |
| Txlookup.dll                                                       | 2015.130.4466.4 | 532144    | 22-Dec-2017 | 20:50 | x64      |
| Txlookup.dll                                                       | 2015.130.4466.4 | 449712    | 22-Dec-2017 | 20:51 | x86      |
| Txmerge.dll                                                        | 2015.130.4466.4 | 230056    | 22-Dec-2017 | 20:50 | x64      |
| Txmerge.dll                                                        | 2015.130.4466.4 | 176304    | 22-Dec-2017 | 20:51 | x86      |
| Txmergejoin.dll                                                    | 2015.130.4466.4 | 278704    | 22-Dec-2017 | 20:50 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4466.4 | 223920    | 22-Dec-2017 | 20:51 | x86      |
| Txmulticast.dll                                                    | 2015.130.4466.4 | 128176    | 22-Dec-2017 | 20:50 | x64      |
| Txmulticast.dll                                                    | 2015.130.4466.4 | 102064    | 22-Dec-2017 | 20:51 | x86      |
| Txpivot.dll                                                        | 2015.130.4466.4 | 228016    | 22-Dec-2017 | 20:50 | x64      |
| Txpivot.dll                                                        | 2015.130.4466.4 | 181928    | 22-Dec-2017 | 20:51 | x86      |
| Txrowcount.dll                                                     | 2015.130.4466.4 | 126640    | 22-Dec-2017 | 20:50 | x64      |
| Txrowcount.dll                                                     | 2015.130.4466.4 | 101552    | 22-Dec-2017 | 20:51 | x86      |
| Txsampling.dll                                                     | 2015.130.4466.4 | 172208    | 22-Dec-2017 | 20:50 | x64      |
| Txsampling.dll                                                     | 2015.130.4466.4 | 134832    | 22-Dec-2017 | 20:51 | x86      |
| Txscd.dll                                                          | 2015.130.4466.4 | 220336    | 22-Dec-2017 | 20:50 | x64      |
| Txscd.dll                                                          | 2015.130.4466.4 | 169648    | 22-Dec-2017 | 20:51 | x86      |
| Txsort.dll                                                         | 2015.130.4466.4 | 258736    | 22-Dec-2017 | 20:50 | x64      |
| Txsort.dll                                                         | 2015.130.4466.4 | 210608    | 22-Dec-2017 | 20:51 | x86      |
| Txsplit.dll                                                        | 2015.130.4466.4 | 600752    | 22-Dec-2017 | 20:50 | x64      |
| Txsplit.dll                                                        | 2015.130.4466.4 | 513200    | 22-Dec-2017 | 20:51 | x86      |
| Txtermextraction.dll                                               | 2015.130.4466.4 | 8678064   | 22-Dec-2017 | 20:50 | x64      |
| Txtermextraction.dll                                               | 2015.130.4466.4 | 8615600   | 22-Dec-2017 | 20:51 | x86      |
| Txtermlookup.dll                                                   | 2015.130.4466.4 | 4158640   | 22-Dec-2017 | 20:50 | x64      |
| Txtermlookup.dll                                                   | 2015.130.4466.4 | 4106928   | 22-Dec-2017 | 20:51 | x86      |
| Txunionall.dll                                                     | 2015.130.4466.4 | 181936    | 22-Dec-2017 | 20:50 | x64      |
| Txunionall.dll                                                     | 2015.130.4466.4 | 138928    | 22-Dec-2017 | 20:51 | x86      |
| Txunpivot.dll                                                      | 2015.130.4466.4 | 201896    | 22-Dec-2017 | 20:50 | x64      |
| Txunpivot.dll                                                      | 2015.130.4466.4 | 162480    | 22-Dec-2017 | 20:51 | x86      |
| Xe.dll                                                             | 2015.130.4466.4 | 558768    | 22-Dec-2017 | 20:51 | x86      |
| Xe.dll                                                             | 2015.130.4466.4 | 626352    | 22-Dec-2017 | 20:53 | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.42     | 483496    | 12-Dec-2017 | 19:40 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.42 | 75432     | 12-Dec-2017 | 19:40 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.42     | 45736     | 12-Dec-2017 | 19:40 | x86      |
| Instapi130.dll                                                       | 2015.130.4466.4  | 61104     | 22-Dec-2017 | 20:50 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.42     | 74408     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.42     | 201896    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.42     | 2347176   | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.42     | 102056    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.42     | 378536    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.42     | 185512    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.42     | 127144    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.42     | 63144     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.42     | 52392     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.42     | 87208     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.42     | 721576    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.42     | 87208     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.42     | 77992     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.42     | 41640     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.42     | 36520     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.42     | 47784     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.42     | 27304     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.42     | 32936     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.42     | 118952    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.42     | 94376     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.42     | 108200    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.42     | 256680    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 102056    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 115880    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 118952    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 115880    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 125608    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 117928    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 113320    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 145576    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 100008    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.42     | 114856    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.42     | 69288     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.42     | 28328     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.42     | 43688     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.42     | 82088     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.42     | 136872    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.42     | 2155688   | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.42     | 3818664   | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 107688    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 119976    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 124584    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 121000    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 133288    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 121000    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 118440    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 152232    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 105128    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.42     | 119464    | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.42     | 66728     | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.42     | 2756264   | 12-Dec-2017 | 19:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.42     | 752296    | 12-Dec-2017 | 19:40 | x86      |
| Mpdwinterop.dll                                                      | 2015.130.4466.4  | 394416    | 22-Dec-2017 | 20:53 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4466.4  | 6614192   | 22-Dec-2017 | 20:53 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4466.4  | 2155184   | 22-Dec-2017 | 20:50 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.42 | 47272     | 12-Dec-2017 | 19:40 | x64      |
| Sqldk.dll                                                            | 2015.130.4466.4  | 2529968   | 22-Dec-2017 | 20:50 | x64      |
| Sqldumper.exe                                                        | 2015.130.4466.4  | 127152    | 22-Dec-2017 | 20:53 | x64      |
| Sqlos.dll                                                            | 2015.130.4466.4  | 26288     | 22-Dec-2017 | 20:50 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.42 | 4348072   | 12-Dec-2017 | 19:40 | x64      |
| Sqltses.dll                                                          | 2015.130.4466.4  | 9064624   | 22-Dec-2017 | 20:50 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.4466.4     | 79024     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4466.4     | 168624    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4466.4     | 1620144   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4466.4     | 657584    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4466.4     | 329904    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4466.4     | 1071280   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532136    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532144    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4466.4     | 532136    | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4466.4     | 161968    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4466.4     | 126128    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4466.4     | 106152    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4466.4     | 5959344   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420272   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420784   | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4421296   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420784   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4421296   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4421296   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420784   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4421808   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420272   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4466.4     | 4420784   | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4466.4     | 10885808  | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4466.4     | 98992     | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4466.4     | 72880     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4466.4     | 5951152   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4466.4     | 245936    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4466.4     | 298160    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4466.4     | 208560    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 44720     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 52912     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 52912     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 44720     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4466.4     | 48816     | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4466.4     | 509104    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4466.4 | 47792     | 22-Dec-2017 | 20:52 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4466.4     | 496816    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4466.4 | 396976    | 22-Dec-2017 | 20:54 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4466.4 | 391856    | 22-Dec-2017 | 20:56 | x86      |
| Msmdlocal.dll                                             | 2015.130.4466.4 | 37097136  | 22-Dec-2017 | 20:52 | x86      |
| Msmdlocal.dll                                             | 2015.130.4466.4 | 56201904  | 22-Dec-2017 | 20:55 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4466.4 | 6507696   | 22-Dec-2017 | 20:51 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4466.4 | 7507120   | 22-Dec-2017 | 20:52 | x64      |
| Msolap130.dll                                             | 2015.130.4466.4 | 7007920   | 22-Dec-2017 | 20:52 | x86      |
| Msolap130.dll                                             | 2015.130.4466.4 | 8639152   | 22-Dec-2017 | 20:54 | x64      |
| Msolui130.dll                                             | 2015.130.4466.4 | 287408    | 22-Dec-2017 | 20:52 | x86      |
| Msolui130.dll                                             | 2015.130.4466.4 | 310448    | 22-Dec-2017 | 20:54 | x64      |
| Reportingservicescompression.dll                          | 2015.130.4466.4 | 62640     | 22-Dec-2017 | 20:54 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4466.4     | 84656     | 22-Dec-2017 | 20:52 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4466.4     | 2543792   | 22-Dec-2017 | 20:52 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4466.4 | 108720    | 22-Dec-2017 | 20:52 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4466.4 | 114352    | 22-Dec-2017 | 20:52 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4466.4 | 98992     | 22-Dec-2017 | 20:52 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4466.4 | 2573488   | 22-Dec-2017 | 20:52 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4466.4     | 2709680   | 22-Dec-2017 | 20:52 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 868016    | 22-Dec-2017 | 20:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872112    | 22-Dec-2017 | 20:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872104    | 22-Dec-2017 | 20:52 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872112    | 22-Dec-2017 | 20:54 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 876208    | 22-Dec-2017 | 20:56 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872112    | 22-Dec-2017 | 20:52 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872112    | 22-Dec-2017 | 20:53 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 880304    | 22-Dec-2017 | 20:51 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 868008    | 22-Dec-2017 | 20:53 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4466.4     | 872112    | 22-Dec-2017 | 20:56 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4466.4 | 3590832   | 22-Dec-2017 | 20:52 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4466.4 | 3663024   | 22-Dec-2017 | 20:54 | x64      |
| Rsconfigtool.exe                                          | 13.0.4466.4     | 1405616   | 22-Dec-2017 | 20:45 | x86      |
| Rsctr.dll                                                 | 2015.130.4466.4 | 51376     | 22-Dec-2017 | 20:52 | x86      |
| Rsctr.dll                                                 | 2015.130.4466.4 | 58536     | 22-Dec-2017 | 20:54 | x64      |
| Rshttpruntime.dll                                         | 2015.130.4466.4 | 99504     | 22-Dec-2017 | 20:52 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqldumper.exe                                             | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                                             | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:54 | x64      |
| Sqlrsos.dll                                               | 2015.130.4466.4 | 26288     | 22-Dec-2017 | 20:50 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4466.4 | 584368    | 22-Dec-2017 | 20:52 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.4466.4 | 732848    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrw.dll                                                 | 2015.130.4466.4 | 259760    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrw.dll                                                 | 2015.130.4466.4 | 319152    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4466.4 | 191664    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4466.4 | 227504    | 22-Dec-2017 | 20:53 | x64      |
| Xmsrv.dll                                                 | 2015.130.4466.4 | 24041648  | 22-Dec-2017 | 20:50 | x64      |
| Xmsrv.dll                                                 | 2015.130.4466.4 | 32718000  | 22-Dec-2017 | 20:51 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.4466.4     | 23728     | 22-Dec-2017 | 20:52 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4466.4 | 1311920   | 22-Dec-2017 | 20:52 | x86      |
| Ddsshapes.dll                                   | 2015.130.4466.4 | 135856    | 22-Dec-2017 | 20:52 | x86      |
| Dtaengine.exe                                   | 2015.130.4466.4 | 167088    | 22-Dec-2017 | 20:52 | x86      |
| Dteparse.dll                                    | 2015.130.4466.4 | 99504     | 22-Dec-2017 | 20:52 | x86      |
| Dteparse.dll                                    | 2015.130.4466.4 | 109744    | 22-Dec-2017 | 20:54 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4466.4 | 83624     | 22-Dec-2017 | 20:51 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4466.4 | 88752     | 22-Dec-2017 | 20:52 | x64      |
| Dtepkg.dll                                      | 2015.130.4466.4 | 115888    | 22-Dec-2017 | 20:52 | x86      |
| Dtepkg.dll                                      | 2015.130.4466.4 | 137392    | 22-Dec-2017 | 20:54 | x64      |
| Dtexec.exe                                      | 2015.130.4466.4 | 72880     | 22-Dec-2017 | 20:52 | x64      |
| Dtexec.exe                                      | 2015.130.4466.4 | 66736     | 22-Dec-2017 | 20:52 | x86      |
| Dts.dll                                         | 2015.130.4466.4 | 2632880   | 22-Dec-2017 | 20:52 | x86      |
| Dts.dll                                         | 2015.130.4466.4 | 3146928   | 22-Dec-2017 | 20:54 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4466.4 | 418992    | 22-Dec-2017 | 20:52 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4466.4 | 477360    | 22-Dec-2017 | 20:54 | x64      |
| Dtsconn.dll                                     | 2015.130.4466.4 | 392368    | 22-Dec-2017 | 20:52 | x86      |
| Dtsconn.dll                                     | 2015.130.4466.4 | 492720    | 22-Dec-2017 | 20:54 | x64      |
| Dtshost.exe                                     | 2015.130.4466.4 | 86704     | 22-Dec-2017 | 20:52 | x64      |
| Dtshost.exe                                     | 2015.130.4466.4 | 76464     | 22-Dec-2017 | 20:52 | x86      |
| Dtslog.dll                                      | 2015.130.4466.4 | 103088    | 22-Dec-2017 | 20:52 | x86      |
| Dtslog.dll                                      | 2015.130.4466.4 | 120496    | 22-Dec-2017 | 20:54 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4466.4 | 541360    | 22-Dec-2017 | 20:52 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4466.4 | 545456    | 22-Dec-2017 | 20:54 | x64      |
| Dtspipeline.dll                                 | 2015.130.4466.4 | 1059504   | 22-Dec-2017 | 20:52 | x86      |
| Dtspipeline.dll                                 | 2015.130.4466.4 | 1279152   | 22-Dec-2017 | 20:54 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4466.4 | 42160     | 22-Dec-2017 | 20:52 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4466.4 | 48304     | 22-Dec-2017 | 20:54 | x64      |
| Dtswizard.exe                                   | 13.0.4466.4     | 896176    | 22-Dec-2017 | 20:45 | x86      |
| Dtswizard.exe                                   | 13.0.4466.4     | 895664    | 22-Dec-2017 | 20:52 | x64      |
| Dtuparse.dll                                    | 2015.130.4466.4 | 80048     | 22-Dec-2017 | 20:52 | x86      |
| Dtuparse.dll                                    | 2015.130.4466.4 | 87728     | 22-Dec-2017 | 20:54 | x64      |
| Dtutil.exe                                      | 2015.130.4466.4 | 134832    | 22-Dec-2017 | 20:52 | x64      |
| Dtutil.exe                                      | 2015.130.4466.4 | 115376    | 22-Dec-2017 | 20:52 | x86      |
| Exceldest.dll                                   | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Exceldest.dll                                   | 2015.130.4466.4 | 263344    | 22-Dec-2017 | 20:54 | x64      |
| Excelsrc.dll                                    | 2015.130.4466.4 | 232624    | 22-Dec-2017 | 20:52 | x86      |
| Excelsrc.dll                                    | 2015.130.4466.4 | 285360    | 22-Dec-2017 | 20:54 | x64      |
| Flatfiledest.dll                                | 2015.130.4466.4 | 334512    | 22-Dec-2017 | 20:52 | x86      |
| Flatfiledest.dll                                | 2015.130.4466.4 | 389296    | 22-Dec-2017 | 20:54 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4466.4 | 345264    | 22-Dec-2017 | 20:52 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4466.4 | 401584    | 22-Dec-2017 | 20:54 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4466.4 | 80560     | 22-Dec-2017 | 20:52 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4466.4 | 96432     | 22-Dec-2017 | 20:54 | x64      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4466.4     | 1313448   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4466.4     | 696496    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4466.4     | 763568    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4466.4 | 2023088   | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4466.4 | 42160     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4466.4     | 72368     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4466.4     | 186544    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4466.4     | 433840    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4466.4     | 433840    | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4466.4     | 2044592   | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4466.4     | 2044592   | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4466.4     | 33456     | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4466.4     | 33456     | 22-Dec-2017 | 20:53 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4466.4     | 249512    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4466.4     | 249520    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4466.4     | 501936    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4466.4     | 606376    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4466.4     | 606384    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4466.4     | 106160    | 22-Dec-2017 | 20:51 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4466.4 | 138928    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4466.4 | 150192    | 22-Dec-2017 | 20:56 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4466.4 | 144560    | 22-Dec-2017 | 20:52 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4466.4 | 158896    | 22-Dec-2017 | 20:56 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4466.4 | 89776     | 22-Dec-2017 | 20:52 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4466.4 | 101040    | 22-Dec-2017 | 20:54 | x64      |
| Msmdlocal.dll                                   | 2015.130.4466.4 | 37097136  | 22-Dec-2017 | 20:52 | x86      |
| Msmdlocal.dll                                   | 2015.130.4466.4 | 56201904  | 22-Dec-2017 | 20:55 | x64      |
| Msmdpp.dll                                      | 2015.130.4466.4 | 6370480   | 22-Dec-2017 | 20:52 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4466.4 | 6507696   | 22-Dec-2017 | 20:51 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4466.4 | 7507120   | 22-Dec-2017 | 20:52 | x64      |
| Msolap130.dll                                   | 2015.130.4466.4 | 7007920   | 22-Dec-2017 | 20:52 | x86      |
| Msolap130.dll                                   | 2015.130.4466.4 | 8639152   | 22-Dec-2017 | 20:54 | x64      |
| Msolui130.dll                                   | 2015.130.4466.4 | 287408    | 22-Dec-2017 | 20:52 | x86      |
| Msolui130.dll                                   | 2015.130.4466.4 | 310448    | 22-Dec-2017 | 20:54 | x64      |
| Oledbdest.dll                                   | 2015.130.4466.4 | 216752    | 22-Dec-2017 | 20:52 | x86      |
| Oledbdest.dll                                   | 2015.130.4466.4 | 264368    | 22-Dec-2017 | 20:54 | x64      |
| Oledbsrc.dll                                    | 2015.130.4466.4 | 235696    | 22-Dec-2017 | 20:52 | x86      |
| Oledbsrc.dll                                    | 2015.130.4466.4 | 290992    | 22-Dec-2017 | 20:54 | x64      |
| Profiler.exe                                    | 2015.130.4466.4 | 804528    | 22-Dec-2017 | 20:45 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4466.4 | 100528    | 22-Dec-2017 | 20:54 | x64      |
| Sqldumper.exe                                   | 2015.130.4466.4 | 107696    | 22-Dec-2017 | 20:52 | x86      |
| Sqldumper.exe                                   | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:54 | x64      |
| Sqlresld.dll                                    | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresld.dll                                    | 2015.130.4466.4 | 28848     | 22-Dec-2017 | 20:52 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4466.4 | 30896     | 22-Dec-2017 | 20:50 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4466.4 | 28336     | 22-Dec-2017 | 20:52 | x86      |
| Sqlscm.dll                                      | 2015.130.4466.4 | 52912     | 22-Dec-2017 | 20:52 | x86      |
| Sqlscm.dll                                      | 2015.130.4466.4 | 61104     | 22-Dec-2017 | 20:53 | x64      |
| Sqlsvc.dll                                      | 2015.130.4466.4 | 152240    | 22-Dec-2017 | 20:50 | x64      |
| Sqlsvc.dll                                      | 2015.130.4466.4 | 127152    | 22-Dec-2017 | 20:52 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4466.4 | 180912    | 22-Dec-2017 | 20:50 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4466.4 | 151216    | 22-Dec-2017 | 20:52 | x86      |
| Txdataconvert.dll                               | 2015.130.4466.4 | 296624    | 22-Dec-2017 | 20:50 | x64      |
| Txdataconvert.dll                               | 2015.130.4466.4 | 255152    | 22-Dec-2017 | 20:51 | x86      |
| Xe.dll                                          | 2015.130.4466.4 | 558768    | 22-Dec-2017 | 20:51 | x86      |
| Xe.dll                                          | 2015.130.4466.4 | 626352    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrw.dll                                       | 2015.130.4466.4 | 259760    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrw.dll                                       | 2015.130.4466.4 | 319152    | 22-Dec-2017 | 20:53 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4466.4 | 191664    | 22-Dec-2017 | 20:51 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4466.4 | 227504    | 22-Dec-2017 | 20:53 | x64      |
| Xmsrv.dll                                       | 2015.130.4466.4 | 24041648  | 22-Dec-2017 | 20:50 | x64      |
| Xmsrv.dll                                       | 2015.130.4466.4 | 32718000  | 22-Dec-2017 | 20:51 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
