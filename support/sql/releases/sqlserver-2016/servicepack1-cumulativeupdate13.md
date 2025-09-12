---
title: Cumulative update 13 for SQL Server 2016 SP1 (KB4475775)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 13 (KB4475775).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4475775
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
---

# KB4475775 - Cumulative Update 13 for SQL Server 2016 SP1

_Release Date:_ &nbsp; January 23, 2019  
_Version:_ &nbsp; 13.0.4550.1

This article describes cumulative update package 13 (build number: 13.0.4550.1) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area|
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|
| <a id=12488504>[12488504](#12488504) </a> | [FIX: Missing logs for Analysis Services Processing tasks in SQL Server 2016 and 2017 Integration Services (KB4055674)](https://support.microsoft.com/help/4055674)| Analysis services |
| <a id=12488510>[12488510](#12488510) </a> | [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2014, 2016 and 2017 Multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032)| Analysis services |
| <a id=12488518>[12488518](#12488518) </a> | [FIX: Error occurs when you run sp_send_dbmail stored procedure that contains comma in sender email address and name in SQL Server (KB4346803)](https://support.microsoft.com/help/4346803)| Management Tools|
| <a id=12482227>[12482227](#12482227) </a> | [FIX: Access violation when you run a query that uses the XML data type in SQL Server 2014, 2016 and 2017 (KB4460112)](https://support.microsoft.com/help/4460112) | XML |
| <a id=12557137>[12557137](#12557137) </a> | [FIX: Assertion error occurs when you run a MERGE statement with an OUTPUT clause in SQL Server 2016 and 2017 (KB4465745)](https://support.microsoft.com/help/4465745) | SQL Engine|
| <a id=12578032>[12578032](#12578032) </a> | [FIX: "Non-yielding" error occurs when there is a heavy use of prepared statements in SQL Server 2014 and 2016 (KB4475322)](https://support.microsoft.com/help/4475322)| SQL Engine|
| <a id=12575120>[12575120](#12575120) </a> | [FIX: Error 18204 during automatic backup in virtual machines when the backup file is split into multiple files (KB4480709)](https://support.microsoft.com/help/4480709) | Management Tools|
| <a id=12507748>[12507748](#12507748) </a> | [FIX: Access violation when you run a query that contains a batch-mode hash join on Clustered Columnstore Index table in SQL Server 2016 (KB4486852)](https://support.microsoft.com/help/4486852)| SQL Engine|
| <a id=12210652>[12210652](#12210652) </a> | [FIX: Users are incorrectly permitted to create incremental statistics on nonclustered indexes that are not aligned to the base table in SQL Server 2016 (KB4486932)](https://support.microsoft.com/help/4486932) | SQL performance |

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
| Instapi130.dll         | 2015.130.4550.1 | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Msmdredir.dll          | 2015.130.4550.1 | 6422312   | 11-Jan-2019 | 05:19 | x86      |
| Msmdsrv.rll            | 2015.130.4550.1 | 1296472   | 11-Jan-2019 | 05:20 | x86      |
| Msmdsrvi.rll           | 2015.130.4550.1 | 1293400   | 11-Jan-2019 | 05:20 | x86      |
| Sqlbrowser.exe         | 2015.130.4550.1 | 276560    | 11-Jan-2019 | 05:18 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Sqldumper.exe          | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4550.1  | 160336    | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                              | 2015.130.4550.1  | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Isacctchange.dll                            | 2015.130.4550.1  | 29264     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4550.1      | 1027160   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4550.1      | 1348696   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4550.1      | 702552    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4550.1      | 765528    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4550.1      | 520792    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4550.1      | 711768    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4550.1      | 36944     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4550.1      | 46160     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4550.1  | 72784     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4550.1      | 598608    | 11-Jan-2019 | 05:20 | x86      |
| Msasxpress.dll                              | 2015.130.4550.1  | 32040     | 11-Jan-2019 | 05:19 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4550.1  | 60200     | 11-Jan-2019 | 05:19 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4550.1  | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Sqldumper.exe                               | 2015.130.4550.1  | 107600    | 11-Jan-2019 | 05:18 | x86      |
| Sqlftacct.dll                               | 2015.130.4550.1  | 46888     | 11-Jan-2019 | 05:19 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4550.1  | 364328    | 11-Jan-2019 | 05:19 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4550.1  | 35104     | 11-Jan-2019 | 05:19 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4550.1  | 267560    | 11-Jan-2019 | 05:19 | x86      |
| Sqltdiagn.dll                               | 2015.130.4550.1  | 60704     | 11-Jan-2019 | 05:19 | x86      |
| Svrenumapi130.dll                           | 2015.130.4550.1  | 854304    | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4550.1  | 1876776   | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4550.1 | 120912    | 11-Jan-2019 | 05:18 | x86      |
| Dreplaycommon.dll              | 2015.130.4550.1 | 690776    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayserverps.dll            | 2015.130.4550.1 | 32848     | 11-Jan-2019 | 05:18 | x86      |
| Dreplayutil.dll                | 2015.130.4550.1 | 309840    | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                 | 2015.130.4550.1 | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Sqlresourceloader.dll          | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4550.1 | 690776    | 11-Jan-2019 | 05:18 | x86      |
| Dreplaycontroller.exe              | 2015.130.4550.1 | 350288    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayprocess.dll                 | 2015.130.4550.1 | 171600    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayserverps.dll                | 2015.130.4550.1 | 32848     | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                     | 2015.130.4550.1 | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Sqlresourceloader.dll              | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4550.1 | 1311824   | 11-Jan-2019 | 05:18 | x86      |
| Ddsshapes.dll                                   | 2015.130.4550.1 | 135760    | 11-Jan-2019 | 05:18 | x86      |
| Dtaengine.exe                                   | 2015.130.4550.1 | 166992    | 11-Jan-2019 | 05:18 | x86      |
| Dteparse.dll                                    | 2015.130.4550.1 | 99408     | 11-Jan-2019 | 05:18 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4550.1 | 83544     | 11-Jan-2019 | 05:18 | x86      |
| Dtepkg.dll                                      | 2015.130.4550.1 | 115792    | 11-Jan-2019 | 05:18 | x86      |
| Dtexec.exe                                      | 2015.130.4550.1 | 66640     | 11-Jan-2019 | 05:18 | x86      |
| Dts.dll                                         | 2015.130.4550.1 | 2632784   | 11-Jan-2019 | 05:18 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4550.1 | 418896    | 11-Jan-2019 | 05:18 | x86      |
| Dtsconn.dll                                     | 2015.130.4550.1 | 392272    | 11-Jan-2019 | 05:18 | x86      |
| Dtshost.exe                                     | 2015.130.4550.1 | 76368     | 11-Jan-2019 | 05:18 | x86      |
| Dtslog.dll                                      | 2015.130.4550.1 | 102992    | 11-Jan-2019 | 05:18 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4550.1 | 541264    | 11-Jan-2019 | 05:18 | x86      |
| Dtspipeline.dll                                 | 2015.130.4550.1 | 1059408   | 11-Jan-2019 | 05:18 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4550.1 | 42064     | 11-Jan-2019 | 05:18 | x86      |
| Dtswizard.exe                                   | 13.0.4550.1     | 896080    | 11-Jan-2019 | 05:08 | x86      |
| Dtuparse.dll                                    | 2015.130.4550.1 | 79952     | 11-Jan-2019 | 05:18 | x86      |
| Dtutil.exe                                      | 2015.130.4550.1 | 115280    | 11-Jan-2019 | 05:18 | x86      |
| Exceldest.dll                                   | 2015.130.4550.1 | 216656    | 11-Jan-2019 | 05:18 | x86      |
| Excelsrc.dll                                    | 2015.130.4550.1 | 232528    | 11-Jan-2019 | 05:18 | x86      |
| Flatfiledest.dll                                | 2015.130.4550.1 | 334416    | 11-Jan-2019 | 05:18 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4550.1 | 345168    | 11-Jan-2019 | 05:18 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4550.1 | 80464     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4550.1     | 92248     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4550.1     | 1313368   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4550.1     | 696408    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4550.1     | 763480    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4550.1 | 2023000   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4550.1 | 42072     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4550.1     | 73296     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4550.1     | 186448    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4550.1     | 435792    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4550.1     | 2044496   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4550.1     | 33360     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4550.1     | 249424    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4550.1     | 501840    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4550.1     | 606288    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4550.1     | 106064    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4550.1 | 138832    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4550.1 | 144464    | 11-Jan-2019 | 05:19 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4550.1 | 89896     | 11-Jan-2019 | 05:19 | x86      |
| Msmdlocal.dll                                   | 2015.130.4550.1 | 37103400  | 11-Jan-2019 | 05:19 | x86      |
| Msmdpp.dll                                      | 2015.130.4550.1 | 6370600   | 11-Jan-2019 | 05:19 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4550.1 | 6507816   | 11-Jan-2019 | 05:19 | x86      |
| Msolap130.dll                                   | 2015.130.4550.1 | 7008552   | 11-Jan-2019 | 05:19 | x86      |
| Msolui130.dll                                   | 2015.130.4550.1 | 287528    | 11-Jan-2019 | 05:19 | x86      |
| Oledbdest.dll                                   | 2015.130.4550.1 | 216872    | 11-Jan-2019 | 05:19 | x86      |
| Oledbsrc.dll                                    | 2015.130.4550.1 | 235816    | 11-Jan-2019 | 05:19 | x86      |
| Profiler.exe                                    | 2015.130.4550.1 | 804440    | 11-Jan-2019 | 05:18 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Sqldumper.exe                                   | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18 | x86      |
| Sqlresld.dll                                    | 2015.130.4550.1 | 28960     | 11-Jan-2019 | 05:19 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |
| Sqlscm.dll                                      | 2015.130.4550.1 | 53024     | 11-Jan-2019 | 05:19 | x86      |
| Sqlsvc.dll                                      | 2015.130.4550.1 | 127264    | 11-Jan-2019 | 05:19 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4550.1 | 151328    | 11-Jan-2019 | 05:19 | x86      |
| Txdataconvert.dll                               | 2015.130.4550.1 | 255272    | 11-Jan-2019 | 05:21 | x86      |
| Xe.dll                                          | 2015.130.4550.1 | 558888    | 11-Jan-2019 | 05:18 | x86      |
| Xmlrw.dll                                       | 2015.130.4550.1 | 259880    | 11-Jan-2019 | 05:21 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4550.1 | 191784    | 11-Jan-2019 | 05:21 | x86      |
| Xmsrv.dll                                       | 2015.130.4550.1 | 32727848  | 11-Jan-2019 | 05:21 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4550.1 | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Keyfile.dll    | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x86      |
| Msmdredir.dll  | 2015.130.4550.1 | 6422312   | 11-Jan-2019 | 05:19 | x86      |
| Msmdsrv.rll    | 2015.130.4550.1 | 1296472   | 11-Jan-2019 | 05:20 | x86      |
| Msmdsrvi.rll   | 2015.130.4550.1 | 1293400   | 11-Jan-2019 | 05:20 | x86      |
| Sqlbrowser.exe | 2015.130.4550.1 | 276560    | 11-Jan-2019 | 05:18 | x86      |
| Sqldumper.exe  | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4550.1 | 61248     | 11-Jan-2019 | 05:18 | x64      |
| Sqlboot.dll           | 2015.130.4550.1 | 186448    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe         | 2015.130.4550.1 | 127056    | 11-Jan-2019 | 05:18 | x64      |
| Sqlvdi.dll            | 2015.130.4550.1 | 197416    | 11-Jan-2019 | 05:18 | x64      |
| Sqlvdi.dll            | 2015.130.4550.1 | 168736    | 11-Jan-2019 | 05:19 | x86      |
| Sqlwriter.exe         | 2015.130.4550.1 | 131664    | 11-Jan-2019 | 05:18 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqlwvss.dll           | 2015.130.4550.1 | 340568    | 11-Jan-2019 | 05:21 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4550.1 | 26200     | 11-Jan-2019 | 05:21 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4550.1     | 1347880   | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4550.1     | 765736    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4550.1     | 521512    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4550.1     | 989776    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4550.1     | 989992    | 11-Jan-2019 | 05:19  | x86      |
| Msmdctr130.dll                                     | 2015.130.4550.1 | 40016     | 11-Jan-2019 | 05:18  | x64      |
| Msmdlocal.dll                                      | 2015.130.4550.1 | 56207952  | 11-Jan-2019 | 05:18  | x64      |
| Msmdlocal.dll                                      | 2015.130.4550.1 | 37103400  | 11-Jan-2019 | 05:19  | x86      |
| Msmdpump.dll                                       | 2015.130.4550.1 | 7799376   | 11-Jan-2019 | 05:18  | x64      |
| Msmdredir.dll                                      | 2015.130.4550.1 | 6422312   | 11-Jan-2019 | 05:19  | x86      |
| Msmdsrv.exe                                        | 2015.130.4550.1 | 56747600  | 11-Jan-2019 | 05:18  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4550.1 | 7507240   | 11-Jan-2019 | 05:18  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4550.1 | 6507816   | 11-Jan-2019 | 05:19  | x86      |
| Msolap130.dll                                      | 2015.130.4550.1 | 8639568   | 11-Jan-2019 | 05:18  | x64      |
| Msolap130.dll                                      | 2015.130.4550.1 | 7008552   | 11-Jan-2019 | 05:19  | x86      |
| Msolui130.dll                                      | 2015.130.4550.1 | 310352    | 11-Jan-2019 | 05:18  | x64      |
| Msolui130.dll                                      | 2015.130.4550.1 | 287528    | 11-Jan-2019 | 05:19  | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18  | x64      |
| Sqlboot.dll                                        | 2015.130.4550.1 | 186448    | 11-Jan-2019 | 05:18  | x64      |
| Sqlceip.exe                                        | 13.0.4550.1     | 252496    | 11-Jan-2019 | 05:19  | x86      |
| Sqldumper.exe                                      | 2015.130.4550.1 | 127056    | 11-Jan-2019 | 05:18  | x64      |
| Sqldumper.exe                                      | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18  | x86      |
| Tmapi.dll                                          | 2015.130.4550.1 | 4345944   | 11-Jan-2019 | 05:21  | x64      |
| Tmcachemgr.dll                                     | 2015.130.4550.1 | 2826328   | 11-Jan-2019 | 05:21  | x64      |
| Tmpersistence.dll                                  | 2015.130.4550.1 | 1071192   | 11-Jan-2019 | 05:21  | x64      |
| Tmtransactions.dll                                 | 2015.130.4550.1 | 1352280   | 11-Jan-2019 | 05:21  | x64      |
| Xe.dll                                             | 2015.130.4550.1 | 626472    | 11-Jan-2019 | 05:19  | x64      |
| Xmlrw.dll                                          | 2015.130.4550.1 | 319272    | 11-Jan-2019 | 05:18  | x64      |
| Xmlrw.dll                                          | 2015.130.4550.1 | 259880    | 11-Jan-2019 | 05:21  | x86      |
| Xmlrwbin.dll                                       | 2015.130.4550.1 | 227624    | 11-Jan-2019 | 05:18  | x64      |
| Xmlrwbin.dll                                       | 2015.130.4550.1 | 191784    | 11-Jan-2019 | 05:21  | x86      |
| Xmsrv.dll                                          | 2015.130.4550.1 | 24050776  | 11-Jan-2019 | 05:21  | x64      |
| Xmsrv.dll                                          | 2015.130.4550.1 | 32727848  | 11-Jan-2019 | 05:21  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4550.1  | 160336    | 11-Jan-2019 | 05:18 | x86      |
| Batchparser.dll                             | 2015.130.4550.1  | 181032    | 11-Jan-2019 | 05:18 | x64      |
| Instapi130.dll                              | 2015.130.4550.1  | 53328     | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                              | 2015.130.4550.1  | 61248     | 11-Jan-2019 | 05:18 | x64      |
| Isacctchange.dll                            | 2015.130.4550.1  | 30800     | 11-Jan-2019 | 05:18 | x64      |
| Isacctchange.dll                            | 2015.130.4550.1  | 29264     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4550.1      | 1027160   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4550.1      | 1027368   | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4550.1      | 1348696   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4550.1      | 702552    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4550.1      | 765528    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4550.1      | 520792    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4550.1      | 711768    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4550.1      | 711976    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4550.1      | 36944     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4550.1      | 46160     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4550.1  | 75560     | 11-Jan-2019 | 05:18 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4550.1  | 72784     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4550.1      | 598824    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4550.1      | 598608    | 11-Jan-2019 | 05:20 | x86      |
| Msasxpress.dll                              | 2015.130.4550.1  | 35920     | 11-Jan-2019 | 05:18 | x64      |
| Msasxpress.dll                              | 2015.130.4550.1  | 32040     | 11-Jan-2019 | 05:19 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4550.1  | 72784     | 11-Jan-2019 | 05:18 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4550.1  | 60200     | 11-Jan-2019 | 05:19 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4550.1  | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                               | 2015.130.4550.1  | 127056    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                               | 2015.130.4550.1  | 107600    | 11-Jan-2019 | 05:18 | x86      |
| Sqlftacct.dll                               | 2015.130.4550.1  | 51792     | 11-Jan-2019 | 05:18 | x64      |
| Sqlftacct.dll                               | 2015.130.4550.1  | 46888     | 11-Jan-2019 | 05:19 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 04:18 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4550.1  | 364328    | 11-Jan-2019 | 05:19 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4550.1  | 404056    | 11-Jan-2019 | 05:21 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4550.1  | 35104     | 11-Jan-2019 | 05:19 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4550.1  | 37464     | 11-Jan-2019 | 05:21 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4550.1  | 267560    | 11-Jan-2019 | 05:19 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4550.1  | 348760    | 11-Jan-2019 | 05:21 | x64      |
| Sqltdiagn.dll                               | 2015.130.4550.1  | 60704     | 11-Jan-2019 | 05:19 | x86      |
| Sqltdiagn.dll                               | 2015.130.4550.1  | 67672     | 11-Jan-2019 | 05:21 | x64      |
| Svrenumapi130.dll                           | 2015.130.4550.1  | 854304    | 11-Jan-2019 | 05:19 | x86      |
| Svrenumapi130.dll                           | 2015.130.4550.1  | 1115736   | 11-Jan-2019 | 05:21 | x64      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4550.1  | 1876776   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4550.1  | 1876776   | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4550.1 | 120912    | 11-Jan-2019 | 05:18 | x86      |
| Dreplaycommon.dll              | 2015.130.4550.1 | 690776    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayserverps.dll            | 2015.130.4550.1 | 32848     | 11-Jan-2019 | 05:18 | x86      |
| Dreplayutil.dll                | 2015.130.4550.1 | 309840    | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                 | 2015.130.4550.1 | 61248     | 11-Jan-2019 | 05:18 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqlresourceloader.dll          | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4550.1 | 690776    | 11-Jan-2019 | 05:18 | x86      |
| Dreplaycontroller.exe              | 2015.130.4550.1 | 350288    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayprocess.dll                 | 2015.130.4550.1 | 171600    | 11-Jan-2019 | 05:18 | x86      |
| Dreplayserverps.dll                | 2015.130.4550.1 | 32848     | 11-Jan-2019 | 05:18 | x86      |
| Instapi130.dll                     | 2015.130.4550.1 | 61248     | 11-Jan-2019 | 05:18 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqlresourceloader.dll              | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4550.1     | 41040     | 11-Jan-2019 | 05:18  | x64      |
| Batchparser.dll                              | 2015.130.4550.1 | 181032    | 11-Jan-2019 | 05:18  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925264    | 11-Jan-2019 | 05:18  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341264   | 11-Jan-2019 | 05:18  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192080    | 11-Jan-2019 | 05:18  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4550.1 | 225360    | 11-Jan-2019 | 05:18  | x64      |
| Dcexec.exe                                   | 2015.130.4550.1 | 74320     | 11-Jan-2019 | 05:18  | x64      |
| Fssres.dll                                   | 2015.130.4550.1 | 81488     | 11-Jan-2019 | 05:18  | x64      |
| Hadrres.dll                                  | 2015.130.4550.1 | 177960    | 11-Jan-2019 | 05:18  | x64      |
| Hkcompile.dll                                | 2015.130.4550.1 | 1298216   | 11-Jan-2019 | 05:18  | x64      |
| Hkengine.dll                                 | 2015.130.4550.1 | 5600848   | 11-Jan-2019 | 05:18  | x64      |
| Hkruntime.dll                                | 2015.130.4550.1 | 158800    | 11-Jan-2019 | 05:18  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017424   | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4550.1     | 234280    | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4550.1     | 79440     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4550.1 | 391976    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4550.1 | 71464     | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4550.1 | 65112     | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4550.1 | 150104    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4550.1 | 158808    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4550.1 | 271960    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4550.1 | 74840     | 11-Jan-2019 | 05:18  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129616    | 11-Jan-2019 | 05:18  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559184    | 11-Jan-2019 | 05:18  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559184    | 11-Jan-2019 | 05:18  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661072    | 11-Jan-2019 | 05:18  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964688    | 11-Jan-2019 | 05:18  | x64      |
| Odsole70.dll                                 | 2015.130.4550.1 | 92752     | 11-Jan-2019 | 05:18  | x64      |
| Opends60.dll                                 | 2015.130.4550.1 | 33064     | 11-Jan-2019 | 05:18  | x64      |
| Qds.dll                                      | 2015.130.4550.1 | 845392    | 11-Jan-2019 | 05:18  | x64      |
| Rsfxft.dll                                   | 2015.130.4550.1 | 34600     | 11-Jan-2019 | 05:18  | x64      |
| Sqagtres.dll                                 | 2015.130.4550.1 | 64592     | 11-Jan-2019 | 05:18  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18  | x64      |
| Sqlaamss.dll                                 | 2015.130.4550.1 | 80672     | 11-Jan-2019 | 05:18  | x64      |
| Sqlaccess.dll                                | 2015.130.4550.1 | 462656    | 11-Jan-2019 | 05:18  | x64      |
| Sqlagent.exe                                 | 2015.130.4550.1 | 566352    | 11-Jan-2019 | 05:18  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4550.1 | 44328     | 11-Jan-2019 | 05:19  | x86      |
| Sqlagentctr130.dll                           | 2015.130.4550.1 | 51800     | 11-Jan-2019 | 05:20  | x64      |
| Sqlagentlog.dll                              | 2015.130.4550.1 | 32848     | 11-Jan-2019 | 05:18  | x64      |
| Sqlagentmail.dll                             | 2015.130.4550.1 | 47912     | 11-Jan-2019 | 05:18  | x64      |
| Sqlboot.dll                                  | 2015.130.4550.1 | 186448    | 11-Jan-2019 | 05:18  | x64      |
| Sqlceip.exe                                  | 13.0.4550.1     | 252496    | 11-Jan-2019 | 05:19  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4550.1 | 59984     | 11-Jan-2019 | 05:18  | x64      |
| Sqlctr130.dll                                | 2015.130.4550.1 | 118592    | 11-Jan-2019 | 05:18  | x64      |
| Sqlctr130.dll                                | 2015.130.4550.1 | 103720    | 11-Jan-2019 | 05:19  | x86      |
| Sqldk.dll                                    | 2015.130.4550.1 | 2586704   | 11-Jan-2019 | 05:18  | x64      |
| Sqldtsss.dll                                 | 2015.130.4550.1 | 97576     | 11-Jan-2019 | 05:18  | x64      |
| Sqliosim.com                                 | 2015.130.4550.1 | 307800    | 11-Jan-2019 | 05:20  | x64      |
| Sqliosim.exe                                 | 2015.130.4550.1 | 3014224   | 11-Jan-2019 | 05:18  | x64      |
| Sqllang.dll                                  | 2015.130.4550.1 | 39458384  | 11-Jan-2019 | 05:18  | x64      |
| Sqlmin.dll                                   | 2015.130.4550.1 | 37709912  | 11-Jan-2019 | 05:21  | x64      |
| Sqlolapss.dll                                | 2015.130.4550.1 | 98088     | 11-Jan-2019 | 05:18  | x64      |
| Sqlos.dll                                    | 2015.130.4550.1 | 26408     | 11-Jan-2019 | 05:18  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4550.1 | 58456     | 11-Jan-2019 | 05:21  | x64      |
| Sqlrepss.dll                                 | 2015.130.4550.1 | 54872     | 11-Jan-2019 | 05:21  | x64      |
| Sqlresld.dll                                 | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21  | x64      |
| Sqlscm.dll                                   | 2015.130.4550.1 | 61224     | 11-Jan-2019 | 05:18  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4550.1 | 27736     | 11-Jan-2019 | 05:21  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4550.1 | 5800232   | 11-Jan-2019 | 05:18  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4550.1 | 732968    | 11-Jan-2019 | 05:18  | x64      |
| Sqlservr.exe                                 | 2015.130.4550.1 | 392784    | 11-Jan-2019 | 05:18  | x64      |
| Sqlsvc.dll                                   | 2015.130.4550.1 | 152152    | 11-Jan-2019 | 05:21  | x64      |
| Sqltses.dll                                  | 2015.130.4550.1 | 8922200   | 11-Jan-2019 | 05:21  | x64      |
| Sqsrvres.dll                                 | 2015.130.4550.1 | 250968    | 11-Jan-2019 | 05:21  | x64      |
| Stretchcodegen.exe                           | 13.0.4550.1     | 55888     | 11-Jan-2019 | 05:19  | x86      |
| Xe.dll                                       | 2015.130.4550.1 | 626472    | 11-Jan-2019 | 05:19  | x64      |
| Xmlrw.dll                                    | 2015.130.4550.1 | 319272    | 11-Jan-2019 | 05:18  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4550.1 | 227624    | 11-Jan-2019 | 05:18  | x64      |
| Xpadsi.exe                                   | 2015.130.4550.1 | 78928     | 11-Jan-2019 | 05:24  | x64      |
| Xplog70.dll                                  | 2015.130.4550.1 | 65832     | 11-Jan-2019 | 05:18  | x64      |
| Xpqueue.dll                                  | 2015.130.4550.1 | 74840     | 11-Jan-2019 | 05:21  | x64      |
| Xprepl.dll                                   | 2015.130.4550.1 | 91224     | 11-Jan-2019 | 05:21  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4550.1 | 33576     | 11-Jan-2019 | 05:18  | x64      |
| Xpstar.dll                                   | 2015.130.4550.1 | 422696    | 11-Jan-2019 | 05:18  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4550.1 | 160336    | 11-Jan-2019 | 05:18  | x86      |
| Batchparser.dll                                                    | 2015.130.4550.1 | 181032    | 11-Jan-2019 | 05:18  | x64      |
| Bcp.exe                                                            | 2015.130.4550.1 | 119888    | 11-Jan-2019 | 05:18  | x64      |
| Commanddest.dll                                                    | 2015.130.4550.1 | 248912    | 11-Jan-2019 | 05:18  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4550.1 | 115792    | 11-Jan-2019 | 05:18  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4550.1 | 187984    | 11-Jan-2019 | 05:18  | x64      |
| Distrib.exe                                                        | 2015.130.4550.1 | 191056    | 11-Jan-2019 | 05:18  | x64      |
| Dteparse.dll                                                       | 2015.130.4550.1 | 109648    | 11-Jan-2019 | 05:18  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19  | x64      |
| Dtepkg.dll                                                         | 2015.130.4550.1 | 137296    | 11-Jan-2019 | 05:18  | x64      |
| Dtexec.exe                                                         | 2015.130.4550.1 | 72784     | 11-Jan-2019 | 05:18  | x64      |
| Dts.dll                                                            | 2015.130.4550.1 | 3146832   | 11-Jan-2019 | 05:18  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4550.1 | 477264    | 11-Jan-2019 | 05:18  | x64      |
| Dtsconn.dll                                                        | 2015.130.4550.1 | 492624    | 11-Jan-2019 | 05:18  | x64      |
| Dtshost.exe                                                        | 2015.130.4550.1 | 86608     | 11-Jan-2019 | 05:18  | x64      |
| Dtslog.dll                                                         | 2015.130.4550.1 | 120400    | 11-Jan-2019 | 05:18  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4550.1 | 545360    | 11-Jan-2019 | 05:18  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4550.1 | 1279056   | 11-Jan-2019 | 05:18  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4550.1 | 48208     | 11-Jan-2019 | 05:18  | x64      |
| Dtswizard.exe                                                      | 13.0.4550.1     | 895568    | 11-Jan-2019 | 05:19  | x64      |
| Dtuparse.dll                                                       | 2015.130.4550.1 | 87632     | 11-Jan-2019 | 05:18  | x64      |
| Dtutil.exe                                                         | 2015.130.4550.1 | 134736    | 11-Jan-2019 | 05:18  | x64      |
| Exceldest.dll                                                      | 2015.130.4550.1 | 263760    | 11-Jan-2019 | 05:18  | x64      |
| Excelsrc.dll                                                       | 2015.130.4550.1 | 285264    | 11-Jan-2019 | 05:18  | x64      |
| Execpackagetask.dll                                                | 2015.130.4550.1 | 166480    | 11-Jan-2019 | 05:18  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4550.1 | 389200    | 11-Jan-2019 | 05:18  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4550.1 | 401488    | 11-Jan-2019 | 05:18  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4550.1 | 96336     | 11-Jan-2019 | 05:18  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4550.1 | 59176     | 11-Jan-2019 | 05:18  | x64      |
| Logread.exe                                                        | 2015.130.4550.1 | 617040    | 11-Jan-2019 | 05:18  | x64      |
| Mergetxt.dll                                                       | 2015.130.4550.1 | 53840     | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4550.1     | 1313576   | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4550.1     | 696616    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4550.1     | 763688    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 20-Dec-2018 | 15:36 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4550.1     | 54568     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4550.1     | 89896     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4550.1     | 49960     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4550.1     | 43304     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4550.1     | 70952     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4550.1     | 35624     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4550.1     | 73512     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4550.1     | 63784     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4550.1     | 31528     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4550.1     | 131368    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4550.1     | 43816     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4550.1     | 57640     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4550.1     | 606504    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4550.1     | 215120    | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4550.1 | 1639208   | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4550.1 | 150104    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4550.1 | 158808    | 11-Jan-2019 | 05:18  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4550.1 | 100944    | 11-Jan-2019 | 05:18  | x64      |
| Msgprox.dll                                                        | 2015.130.4550.1 | 275536    | 11-Jan-2019 | 05:18  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4550.1 | 1494848   | 11-Jan-2019 | 05:18  | x64      |
| Oledbdest.dll                                                      | 2015.130.4550.1 | 264272    | 11-Jan-2019 | 05:18  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4550.1 | 290896    | 11-Jan-2019 | 05:18  | x64      |
| Osql.exe                                                           | 2015.130.4550.1 | 75344     | 11-Jan-2019 | 05:18  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4550.1 | 469072    | 11-Jan-2019 | 05:18  | x64      |
| Rawdest.dll                                                        | 2015.130.4550.1 | 209488    | 11-Jan-2019 | 05:18  | x64      |
| Rawsource.dll                                                      | 2015.130.4550.1 | 196688    | 11-Jan-2019 | 05:18  | x64      |
| Rdistcom.dll                                                       | 2015.130.4550.1 | 894032    | 11-Jan-2019 | 05:18  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4550.1 | 187472    | 11-Jan-2019 | 05:18  | x64      |
| Replagnt.dll                                                       | 2015.130.4550.1 | 30800     | 11-Jan-2019 | 05:18  | x64      |
| Repldp.dll                                                         | 2015.130.4550.1 | 277072    | 11-Jan-2019 | 05:18  | x64      |
| Replerrx.dll                                                       | 2015.130.4550.1 | 144464    | 11-Jan-2019 | 05:18  | x64      |
| Replisapi.dll                                                      | 2015.130.4550.1 | 354384    | 11-Jan-2019 | 05:18  | x64      |
| Replmerg.exe                                                       | 2015.130.4550.1 | 518736    | 11-Jan-2019 | 05:18  | x64      |
| Replprov.dll                                                       | 2015.130.4550.1 | 812112    | 11-Jan-2019 | 05:18  | x64      |
| Replrec.dll                                                        | 2015.130.4550.1 | 1018664   | 11-Jan-2019 | 05:18  | x64      |
| Replsub.dll                                                        | 2015.130.4550.1 | 467536    | 11-Jan-2019 | 05:18  | x64      |
| Replsync.dll                                                       | 2015.130.4550.1 | 143952    | 11-Jan-2019 | 05:18  | x64      |
| Spresolv.dll                                                       | 2015.130.4550.1 | 245328    | 11-Jan-2019 | 05:18  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4550.1 | 249424    | 11-Jan-2019 | 05:18  | x64      |
| Sqldiag.exe                                                        | 2015.130.4550.1 | 1257552   | 11-Jan-2019 | 05:18  | x64      |
| Sqldistx.dll                                                       | 2015.130.4550.1 | 215632    | 11-Jan-2019 | 05:18  | x64      |
| Sqllogship.exe                                                     | 13.0.4550.1     | 100432    | 11-Jan-2019 | 05:19  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4550.1 | 346712    | 11-Jan-2019 | 05:21  | x64      |
| Sqlps.exe                                                          | 13.0.4550.1     | 59992     | 11-Jan-2019 | 05:18  | x86      |
| Sqlresld.dll                                                       | 2015.130.4550.1 | 28960     | 11-Jan-2019 | 05:19  | x86      |
| Sqlresld.dll                                                       | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21  | x64      |
| Sqlscm.dll                                                         | 2015.130.4550.1 | 61224     | 11-Jan-2019 | 05:18  | x64      |
| Sqlscm.dll                                                         | 2015.130.4550.1 | 53024     | 11-Jan-2019 | 05:19  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4550.1 | 127264    | 11-Jan-2019 | 05:19  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4550.1 | 152152    | 11-Jan-2019 | 05:21  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4550.1 | 180824    | 11-Jan-2019 | 05:21  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4550.1 | 105560    | 11-Jan-2019 | 05:21  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4550.1 | 33368     | 11-Jan-2019 | 05:21  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4550.1 | 216152    | 11-Jan-2019 | 05:21  | x64      |
| Ssradd.dll                                                         | 2015.130.4550.1 | 65104     | 11-Jan-2019 | 05:21  | x64      |
| Ssravg.dll                                                         | 2015.130.4550.1 | 65112     | 11-Jan-2019 | 05:21  | x64      |
| Ssrdown.dll                                                        | 2015.130.4550.1 | 50776     | 11-Jan-2019 | 05:21  | x64      |
| Ssrmax.dll                                                         | 2015.130.4550.1 | 63576     | 11-Jan-2019 | 05:21  | x64      |
| Ssrmin.dll                                                         | 2015.130.4550.1 | 63576     | 11-Jan-2019 | 05:21  | x64      |
| Ssrpub.dll                                                         | 2015.130.4550.1 | 51288     | 11-Jan-2019 | 05:21  | x64      |
| Ssrup.dll                                                          | 2015.130.4550.1 | 50776     | 11-Jan-2019 | 05:21  | x64      |
| Txagg.dll                                                          | 2015.130.4550.1 | 364632    | 11-Jan-2019 | 05:21  | x64      |
| Txbdd.dll                                                          | 2015.130.4550.1 | 172632    | 11-Jan-2019 | 05:21  | x64      |
| Txdatacollector.dll                                                | 2015.130.4550.1 | 367704    | 11-Jan-2019 | 05:21  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4550.1 | 296536    | 11-Jan-2019 | 05:21  | x64      |
| Txderived.dll                                                      | 2015.130.4550.1 | 607832    | 11-Jan-2019 | 05:21  | x64      |
| Txlookup.dll                                                       | 2015.130.4550.1 | 532568    | 11-Jan-2019 | 05:21  | x64      |
| Txmerge.dll                                                        | 2015.130.4550.1 | 229976    | 11-Jan-2019 | 05:21  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4550.1 | 278616    | 11-Jan-2019 | 05:21  | x64      |
| Txmulticast.dll                                                    | 2015.130.4550.1 | 128600    | 11-Jan-2019 | 05:21  | x64      |
| Txrowcount.dll                                                     | 2015.130.4550.1 | 126552    | 11-Jan-2019 | 05:21  | x64      |
| Txsort.dll                                                         | 2015.130.4550.1 | 258648    | 11-Jan-2019 | 05:21  | x64      |
| Txsplit.dll                                                        | 2015.130.4550.1 | 600664    | 11-Jan-2019 | 05:21  | x64      |
| Txunionall.dll                                                     | 2015.130.4550.1 | 181848    | 11-Jan-2019 | 05:21  | x64      |
| Xe.dll                                                             | 2015.130.4550.1 | 626472    | 11-Jan-2019 | 05:19  | x64      |
| Xmlrw.dll                                                          | 2015.130.4550.1 | 319272    | 11-Jan-2019 | 05:18  | x64      |
| Xmlsub.dll                                                         | 2015.130.4550.1 | 250968    | 11-Jan-2019 | 05:21  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4550.1 | 1013840   | 11-Jan-2019 | 05:18 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqlsatellite.dll              | 2015.130.4550.1 | 837416    | 11-Jan-2019 | 05:18 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4550.1 | 660264    | 11-Jan-2019 | 05:18 | x64      |
| Fdhost.exe               | 2015.130.4550.1 | 105040    | 11-Jan-2019 | 05:18 | x64      |
| Fdlauncher.exe           | 2015.130.4550.1 | 51280     | 11-Jan-2019 | 05:18 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqlft130ph.dll           | 2015.130.4550.1 | 58152     | 11-Jan-2019 | 05:18 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4550.1     | 23848     | 11-Jan-2019 | 05:19 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 17-Aug-2018 | 02:49  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 19-Aug-2018 | 07:30  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 17-Aug-2018 | 02:49  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 19-Aug-2018 | 07:30  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 17-Aug-2018 | 02:49  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 19-Aug-2018 | 07:30  | x86      |
| Commanddest.dll                                                    | 2015.130.4550.1 | 248912    | 11-Jan-2019 | 05:18  | x64      |
| Commanddest.dll                                                    | 2015.130.4550.1 | 202832    | 11-Jan-2019 | 05:18  | x86      |
| Dteparse.dll                                                       | 2015.130.4550.1 | 109648    | 11-Jan-2019 | 05:18  | x64      |
| Dteparse.dll                                                       | 2015.130.4550.1 | 99408     | 11-Jan-2019 | 05:18  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4550.1 | 83544     | 11-Jan-2019 | 05:18  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19  | x64      |
| Dtepkg.dll                                                         | 2015.130.4550.1 | 137296    | 11-Jan-2019 | 05:18  | x64      |
| Dtepkg.dll                                                         | 2015.130.4550.1 | 115792    | 11-Jan-2019 | 05:18  | x86      |
| Dtexec.exe                                                         | 2015.130.4550.1 | 66640     | 11-Jan-2019 | 05:18  | x86      |
| Dtexec.exe                                                         | 2015.130.4550.1 | 72784     | 11-Jan-2019 | 05:18  | x64      |
| Dts.dll                                                            | 2015.130.4550.1 | 3146832   | 11-Jan-2019 | 05:18  | x64      |
| Dts.dll                                                            | 2015.130.4550.1 | 2632784   | 11-Jan-2019 | 05:18  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4550.1 | 477264    | 11-Jan-2019 | 05:18  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4550.1 | 418896    | 11-Jan-2019 | 05:18  | x86      |
| Dtsconn.dll                                                        | 2015.130.4550.1 | 492624    | 11-Jan-2019 | 05:18  | x64      |
| Dtsconn.dll                                                        | 2015.130.4550.1 | 392272    | 11-Jan-2019 | 05:18  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4550.1 | 93776     | 11-Jan-2019 | 05:18  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4550.1 | 109648    | 11-Jan-2019 | 05:18  | x64      |
| Dtshost.exe                                                        | 2015.130.4550.1 | 76368     | 11-Jan-2019 | 05:18  | x86      |
| Dtshost.exe                                                        | 2015.130.4550.1 | 86608     | 11-Jan-2019 | 05:18  | x64      |
| Dtslog.dll                                                         | 2015.130.4550.1 | 120400    | 11-Jan-2019 | 05:18  | x64      |
| Dtslog.dll                                                         | 2015.130.4550.1 | 102992    | 11-Jan-2019 | 05:18  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4550.1 | 545360    | 11-Jan-2019 | 05:18  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4550.1 | 541264    | 11-Jan-2019 | 05:18  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4550.1 | 1279056   | 11-Jan-2019 | 05:18  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4550.1 | 1059408   | 11-Jan-2019 | 05:18  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4550.1 | 48208     | 11-Jan-2019 | 05:18  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4550.1 | 42064     | 11-Jan-2019 | 05:18  | x86      |
| Dtswizard.exe                                                      | 13.0.4550.1     | 896080    | 11-Jan-2019 | 05:08  | x86      |
| Dtswizard.exe                                                      | 13.0.4550.1     | 895568    | 11-Jan-2019 | 05:19  | x64      |
| Dtuparse.dll                                                       | 2015.130.4550.1 | 87632     | 11-Jan-2019 | 05:18  | x64      |
| Dtuparse.dll                                                       | 2015.130.4550.1 | 79952     | 11-Jan-2019 | 05:18  | x86      |
| Dtutil.exe                                                         | 2015.130.4550.1 | 115280    | 11-Jan-2019 | 05:18  | x86      |
| Dtutil.exe                                                         | 2015.130.4550.1 | 134736    | 11-Jan-2019 | 05:18  | x64      |
| Exceldest.dll                                                      | 2015.130.4550.1 | 263760    | 11-Jan-2019 | 05:18  | x64      |
| Exceldest.dll                                                      | 2015.130.4550.1 | 216656    | 11-Jan-2019 | 05:18  | x86      |
| Excelsrc.dll                                                       | 2015.130.4550.1 | 285264    | 11-Jan-2019 | 05:18  | x64      |
| Excelsrc.dll                                                       | 2015.130.4550.1 | 232528    | 11-Jan-2019 | 05:18  | x86      |
| Execpackagetask.dll                                                | 2015.130.4550.1 | 166480    | 11-Jan-2019 | 05:18  | x64      |
| Execpackagetask.dll                                                | 2015.130.4550.1 | 135248    | 11-Jan-2019 | 05:18  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4550.1 | 389200    | 11-Jan-2019 | 05:18  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4550.1 | 334416    | 11-Jan-2019 | 05:18  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4550.1 | 401488    | 11-Jan-2019 | 05:18  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4550.1 | 345168    | 11-Jan-2019 | 05:18  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4550.1 | 96336     | 11-Jan-2019 | 05:18  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4550.1 | 80464     | 11-Jan-2019 | 05:18  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4550.1     | 439888    | 11-Jan-2019 | 05:08  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4550.1     | 438864    | 11-Jan-2019 | 05:19  | x64      |
| Isserverexec.exe                                                   | 13.0.4550.1     | 132688    | 11-Jan-2019 | 05:08  | x86      |
| Isserverexec.exe                                                   | 13.0.4550.1     | 132176    | 11-Jan-2019 | 05:19  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4550.1     | 1313368   | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4550.1     | 1313576   | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4550.1     | 696408    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4550.1     | 696616    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4550.1     | 763480    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4550.1     | 763688    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 20-Dec-2018 | 15:36 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 21-Dec-2018 | 14:10 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4550.1     | 73512     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4550.1 | 107088    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4550.1 | 112424    | 11-Jan-2019 | 05:20  | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4550.1     | 54352     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4550.1     | 54568     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4550.1     | 89680     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4550.1     | 89896     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4550.1     | 43088     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4550.1     | 43304     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4550.1     | 35408     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4550.1     | 35624     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4550.1     | 73296     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4550.1     | 73512     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4550.1     | 31312     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4550.1     | 31528     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4550.1     | 469584    | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4550.1     | 469800    | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4550.1     | 43816     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4550.1     | 43600     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4550.1     | 57640     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4550.1     | 57424     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4550.1     | 53032     | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4550.1     | 52816     | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4550.1     | 606504    | 11-Jan-2019 | 05:18  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4550.1     | 606288    | 11-Jan-2019 | 05:20  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4550.1 | 150104    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4550.1 | 138832    | 11-Jan-2019 | 05:19  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4550.1 | 158808    | 11-Jan-2019 | 05:18  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4550.1 | 144464    | 11-Jan-2019 | 05:19  | x86      |
| Msdtssrvr.exe                                                      | 13.0.4550.1     | 216656    | 11-Jan-2019 | 05:19  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4550.1 | 100944    | 11-Jan-2019 | 05:18  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4550.1 | 89896     | 11-Jan-2019 | 05:19  | x86      |
| Msmdpp.dll                                                         | 2015.130.4550.1 | 7647312   | 11-Jan-2019 | 05:18  | x64      |
| Oledbdest.dll                                                      | 2015.130.4550.1 | 264272    | 11-Jan-2019 | 05:18  | x64      |
| Oledbdest.dll                                                      | 2015.130.4550.1 | 216872    | 11-Jan-2019 | 05:19  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4550.1 | 290896    | 11-Jan-2019 | 05:18  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4550.1 | 235816    | 11-Jan-2019 | 05:19  | x86      |
| Rawdest.dll                                                        | 2015.130.4550.1 | 209488    | 11-Jan-2019 | 05:18  | x64      |
| Rawdest.dll                                                        | 2015.130.4550.1 | 168744    | 11-Jan-2019 | 05:19  | x86      |
| Rawsource.dll                                                      | 2015.130.4550.1 | 196688    | 11-Jan-2019 | 05:18  | x64      |
| Rawsource.dll                                                      | 2015.130.4550.1 | 155432    | 11-Jan-2019 | 05:19  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4550.1 | 187472    | 11-Jan-2019 | 05:18  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4550.1 | 151848    | 11-Jan-2019 | 05:19  | x86      |
| Sql_is_keyfile.dll                                                 | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18  | x64      |
| Sqlceip.exe                                                        | 13.0.4550.1     | 252496    | 11-Jan-2019 | 05:19  | x86      |
| Sqldest.dll                                                        | 2015.130.4550.1 | 263760    | 11-Jan-2019 | 05:18  | x64      |
| Sqldest.dll                                                        | 2015.130.4550.1 | 215848    | 11-Jan-2019 | 05:19  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4550.1 | 151328    | 11-Jan-2019 | 05:19  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4550.1 | 180824    | 11-Jan-2019 | 05:21  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4550.1 | 176936    | 11-Jan-2019 | 05:19  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4550.1 | 216152    | 11-Jan-2019 | 05:21  | x64      |
| Txagg.dll                                                          | 2015.130.4550.1 | 364632    | 11-Jan-2019 | 05:21  | x64      |
| Txagg.dll                                                          | 2015.130.4550.1 | 304936    | 11-Jan-2019 | 05:21  | x86      |
| Txbdd.dll                                                          | 2015.130.4550.1 | 172632    | 11-Jan-2019 | 05:21  | x64      |
| Txbdd.dll                                                          | 2015.130.4550.1 | 138536    | 11-Jan-2019 | 05:21  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4550.1 | 611416    | 11-Jan-2019 | 05:21  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4550.1 | 496424    | 11-Jan-2019 | 05:21  | x86      |
| Txcache.dll                                                        | 2015.130.4550.1 | 183384    | 11-Jan-2019 | 05:21  | x64      |
| Txcache.dll                                                        | 2015.130.4550.1 | 148264    | 11-Jan-2019 | 05:21  | x86      |
| Txcharmap.dll                                                      | 2015.130.4550.1 | 289880    | 11-Jan-2019 | 05:21  | x64      |
| Txcharmap.dll                                                      | 2015.130.4550.1 | 250664    | 11-Jan-2019 | 05:21  | x86      |
| Txcopymap.dll                                                      | 2015.130.4550.1 | 183384    | 11-Jan-2019 | 05:21  | x64      |
| Txcopymap.dll                                                      | 2015.130.4550.1 | 147752    | 11-Jan-2019 | 05:21  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4550.1 | 296536    | 11-Jan-2019 | 05:21  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4550.1 | 255272    | 11-Jan-2019 | 05:21  | x86      |
| Txderived.dll                                                      | 2015.130.4550.1 | 607832    | 11-Jan-2019 | 05:21  | x64      |
| Txderived.dll                                                      | 2015.130.4550.1 | 519464    | 11-Jan-2019 | 05:21  | x86      |
| Txfileextractor.dll                                                | 2015.130.4550.1 | 201816    | 11-Jan-2019 | 05:21  | x64      |
| Txfileextractor.dll                                                | 2015.130.4550.1 | 163112    | 11-Jan-2019 | 05:21  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4550.1 | 199768    | 11-Jan-2019 | 05:21  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4550.1 | 161064    | 11-Jan-2019 | 05:21  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4550.1 | 290904    | 11-Jan-2019 | 05:21  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4550.1 | 231720    | 11-Jan-2019 | 05:21  | x86      |
| Txlineage.dll                                                      | 2015.130.4550.1 | 137304    | 11-Jan-2019 | 05:21  | x64      |
| Txlineage.dll                                                      | 2015.130.4550.1 | 109376    | 11-Jan-2019 | 05:21  | x86      |
| Txlookup.dll                                                       | 2015.130.4550.1 | 532568    | 11-Jan-2019 | 05:21  | x64      |
| Txlookup.dll                                                       | 2015.130.4550.1 | 449832    | 11-Jan-2019 | 05:21  | x86      |
| Txmerge.dll                                                        | 2015.130.4550.1 | 229976    | 11-Jan-2019 | 05:21  | x64      |
| Txmerge.dll                                                        | 2015.130.4550.1 | 176424    | 11-Jan-2019 | 05:21  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4550.1 | 278616    | 11-Jan-2019 | 05:21  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4550.1 | 224040    | 11-Jan-2019 | 05:21  | x86      |
| Txmulticast.dll                                                    | 2015.130.4550.1 | 128600    | 11-Jan-2019 | 05:21  | x64      |
| Txmulticast.dll                                                    | 2015.130.4550.1 | 102184    | 11-Jan-2019 | 05:21  | x86      |
| Txpivot.dll                                                        | 2015.130.4550.1 | 227928    | 11-Jan-2019 | 05:21  | x64      |
| Txpivot.dll                                                        | 2015.130.4550.1 | 182056    | 11-Jan-2019 | 05:21  | x86      |
| Txrowcount.dll                                                     | 2015.130.4550.1 | 126552    | 11-Jan-2019 | 05:21  | x64      |
| Txrowcount.dll                                                     | 2015.130.4550.1 | 101672    | 11-Jan-2019 | 05:21  | x86      |
| Txsampling.dll                                                     | 2015.130.4550.1 | 172120    | 11-Jan-2019 | 05:21  | x64      |
| Txsampling.dll                                                     | 2015.130.4550.1 | 134952    | 11-Jan-2019 | 05:21  | x86      |
| Txscd.dll                                                          | 2015.130.4550.1 | 220248    | 11-Jan-2019 | 05:21  | x64      |
| Txscd.dll                                                          | 2015.130.4550.1 | 169768    | 11-Jan-2019 | 05:21  | x86      |
| Txsort.dll                                                         | 2015.130.4550.1 | 258648    | 11-Jan-2019 | 05:21  | x64      |
| Txsort.dll                                                         | 2015.130.4550.1 | 210728    | 11-Jan-2019 | 05:21  | x86      |
| Txsplit.dll                                                        | 2015.130.4550.1 | 600664    | 11-Jan-2019 | 05:21  | x64      |
| Txsplit.dll                                                        | 2015.130.4550.1 | 513832    | 11-Jan-2019 | 05:21  | x86      |
| Txtermextraction.dll                                               | 2015.130.4550.1 | 8677976   | 11-Jan-2019 | 05:21  | x64      |
| Txtermextraction.dll                                               | 2015.130.4550.1 | 8615720   | 11-Jan-2019 | 05:21  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4550.1 | 4158552   | 11-Jan-2019 | 05:21  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4550.1 | 4107560   | 11-Jan-2019 | 05:21  | x86      |
| Txunionall.dll                                                     | 2015.130.4550.1 | 181848    | 11-Jan-2019 | 05:21  | x64      |
| Txunionall.dll                                                     | 2015.130.4550.1 | 139048    | 11-Jan-2019 | 05:21  | x86      |
| Txunpivot.dll                                                      | 2015.130.4550.1 | 202328    | 11-Jan-2019 | 05:21  | x64      |
| Txunpivot.dll                                                      | 2015.130.4550.1 | 162624    | 11-Jan-2019 | 05:21  | x86      |
| Xe.dll                                                             | 2015.130.4550.1 | 558888    | 11-Jan-2019 | 05:18  | x86      |
| Xe.dll                                                             | 2015.130.4550.1 | 626472    | 11-Jan-2019 | 05:19  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    |02-Feb-2018  | 00:09 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     |02-Feb-2018  | 00:09 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     |02-Feb-2018  | 00:09 | x86      |
| Instapi130.dll                                                       | 2015.130.4550.1  | 61016     | 11-Jan-2019 | 05:21 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.43     | 74416     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.43     | 201896    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.43     | 2347184   |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.43     | 102064    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.43     | 378544    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.43     | 185512    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.43     | 127144    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.43     | 63152     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.43     | 52400     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.43     | 87208     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.43     | 721584    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.43     | 87208     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.43     | 78000     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.43     | 41640     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.43     | 36528     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.43     | 47792     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.43     | 27304     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.43     | 32936     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.43     | 118952    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.43     | 94384     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.43     | 108208    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.43     | 256680    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 102056    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 118952    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 125608    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 117928    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 113328    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 145576    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 100016    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 114864    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.43     | 69296     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.43     | 28336     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.43     | 43696     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.43     | 82096     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.43     | 136872    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.43     | 2155688   |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.43     | 3818672   |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 107688    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119976    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 124592    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121008    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 133296    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121000    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 118448    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 152240    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 105136    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119472    |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.43     | 66736     |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.43     | 2756272   |02-Feb-2018  | 00:09 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.43     | 752296    |02-Feb-2018  | 00:09 | x86      |
| Mpdwinterop.dll                                                      | 2015.130.4550.1  | 394536    | 11-Jan-2019 | 05:20 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4550.1  | 6613584   | 11-Jan-2019 | 05:24 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4550.1  | 2155096   | 11-Jan-2019 | 05:21 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     |02-Feb-2018  | 00:09 | x64      |
| Sqldk.dll                                                            | 2015.130.4550.1  | 2530392   | 11-Jan-2019 | 05:21 | x64      |
| Sqldumper.exe                                                        | 2015.130.4550.1  | 127056    | 11-Jan-2019 | 05:24 | x64      |
| Sqlos.dll                                                            | 2015.130.4550.1  | 26200     | 11-Jan-2019 | 05:21 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   |02-Feb-2018  | 00:09 | x64      |
| Sqltses.dll                                                          | 2015.130.4550.1  | 9091160   | 11-Jan-2019 | 05:21 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.4550.1     | 611112    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.authorization.dll             | 13.0.4550.1     | 79144     | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4550.1     | 210728    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4550.1     | 168744    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4550.1     | 1620264   | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4550.1     | 657704    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4550.1     | 330024    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4550.1     | 1072424   | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532264    | 11-Jan-2019 | 05:17 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532048    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532264    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532056    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532264    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532048    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532264    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532048    | 11-Jan-2019 | 05:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532048    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4550.1     | 532264    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4550.1     | 48936     | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4550.1     | 163112    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4550.1     | 76368     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4550.1     | 76584     | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4550.1     | 126248    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4550.1     | 106280    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4550.1     | 5959464   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420392   | 11-Jan-2019 | 05:17 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420688   | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4421416   | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420696   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4421416   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4421200   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420904   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4421712   | 11-Jan-2019 | 05:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420176   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4550.1     | 4420904   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4550.1     | 10886440  | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4550.1     | 100944    | 11-Jan-2019 | 05:19 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4550.1     | 73024     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4550.1     | 5951784   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4550.1     | 246056    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4550.1     | 298280    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4550.1     | 208680    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 44840     | 11-Jan-2019 | 05:17 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48720     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48936     | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48728     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 53032     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48936     | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48728     | 11-Jan-2019 | 05:21 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 52816     | 11-Jan-2019 | 05:21 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 44624     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4550.1     | 48936     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4550.1     | 510760    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4550.1 | 47912     | 11-Jan-2019 | 05:20 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4550.1     | 496936    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4550.1 | 391976    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4550.1 | 397096    | 11-Jan-2019 | 05:19 | x86      |
| Msmdlocal.dll                                             | 2015.130.4550.1 | 56207952  | 11-Jan-2019 | 05:18 | x64      |
| Msmdlocal.dll                                             | 2015.130.4550.1 | 37103400  | 11-Jan-2019 | 05:19 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4550.1 | 7507240   | 11-Jan-2019 | 05:18 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4550.1 | 6507816   | 11-Jan-2019 | 05:19 | x86      |
| Msolap130.dll                                             | 2015.130.4550.1 | 8639568   | 11-Jan-2019 | 05:18 | x64      |
| Msolap130.dll                                             | 2015.130.4550.1 | 7008552   | 11-Jan-2019 | 05:19 | x86      |
| Msolui130.dll                                             | 2015.130.4550.1 | 310352    | 11-Jan-2019 | 05:18 | x64      |
| Msolui130.dll                                             | 2015.130.4550.1 | 287528    | 11-Jan-2019 | 05:19 | x86      |
| Reportingservicescompression.dll                          | 2015.130.4550.1 | 62544     | 11-Jan-2019 | 05:18 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4550.1     | 84776     | 11-Jan-2019 | 05:18 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4550.1     | 2543912   | 11-Jan-2019 | 05:18 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4550.1 | 108864    | 11-Jan-2019 | 05:18 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4550.1 | 114472    | 11-Jan-2019 | 05:19 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4550.1 | 99112     | 11-Jan-2019 | 05:18 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4550.1 | 2573392   | 11-Jan-2019 | 05:18 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4550.1     | 2710816   | 11-Jan-2019 | 05:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 867920    | 11-Jan-2019 | 05:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872016    | 11-Jan-2019 | 05:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872232    | 11-Jan-2019 | 05:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872016    | 11-Jan-2019 | 05:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 876112    | 11-Jan-2019 | 05:17 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872016    | 11-Jan-2019 | 05:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872024    | 11-Jan-2019 | 05:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 884520    | 11-Jan-2019 | 05:21 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 867928    | 11-Jan-2019 | 05:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4550.1     | 872024    | 11-Jan-2019 | 05:18 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4550.1 | 3662928   | 11-Jan-2019 | 05:18 | x64      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4550.1 | 3590952   | 11-Jan-2019 | 05:19 | x86      |
| Rsconfigtool.exe                                          | 13.0.4550.1     | 1405528   | 11-Jan-2019 | 05:18 | x86      |
| Rsctr.dll                                                 | 2015.130.4550.1 | 58448     | 11-Jan-2019 | 05:18 | x64      |
| Rsctr.dll                                                 | 2015.130.4550.1 | 51496     | 11-Jan-2019 | 05:19 | x86      |
| Rshttpruntime.dll                                         | 2015.130.4550.1 | 99616     | 11-Jan-2019 | 05:18 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                                             | 2015.130.4550.1 | 127056    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                                             | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18 | x86      |
| Sqlrsos.dll                                               | 2015.130.4550.1 | 26200     | 11-Jan-2019 | 05:21 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4550.1 | 732968    | 11-Jan-2019 | 05:18 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4550.1 | 584480    | 11-Jan-2019 | 05:19 | x86      |
| Xmlrw.dll                                                 | 2015.130.4550.1 | 319272    | 11-Jan-2019 | 05:18 | x64      |
| Xmlrw.dll                                                 | 2015.130.4550.1 | 259880    | 11-Jan-2019 | 05:21 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4550.1 | 227624    | 11-Jan-2019 | 05:18 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4550.1 | 191784    | 11-Jan-2019 | 05:21 | x86      |
| Xmsrv.dll                                                 | 2015.130.4550.1 | 24050776  | 11-Jan-2019 | 05:21 | x64      |
| Xmsrv.dll                                                 | 2015.130.4550.1 | 32727848  | 11-Jan-2019 | 05:21 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.4550.1     | 23848     | 11-Jan-2019 | 05:18 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4550.1 | 1311824   | 11-Jan-2019 | 05:18 | x86      |
| Ddsshapes.dll                                   | 2015.130.4550.1 | 135760    | 11-Jan-2019 | 05:18 | x86      |
| Dtaengine.exe                                   | 2015.130.4550.1 | 166992    | 11-Jan-2019 | 05:18 | x86      |
| Dteparse.dll                                    | 2015.130.4550.1 | 109648    | 11-Jan-2019 | 05:18 | x64      |
| Dteparse.dll                                    | 2015.130.4550.1 | 99408     | 11-Jan-2019 | 05:18 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4550.1 | 83544     | 11-Jan-2019 | 05:18 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4550.1 | 88872     | 11-Jan-2019 | 05:19 | x64      |
| Dtepkg.dll                                      | 2015.130.4550.1 | 137296    | 11-Jan-2019 | 05:18 | x64      |
| Dtepkg.dll                                      | 2015.130.4550.1 | 115792    | 11-Jan-2019 | 05:18 | x86      |
| Dtexec.exe                                      | 2015.130.4550.1 | 66640     | 11-Jan-2019 | 05:18 | x86      |
| Dtexec.exe                                      | 2015.130.4550.1 | 72784     | 11-Jan-2019 | 05:18 | x64      |
| Dts.dll                                         | 2015.130.4550.1 | 3146832   | 11-Jan-2019 | 05:18 | x64      |
| Dts.dll                                         | 2015.130.4550.1 | 2632784   | 11-Jan-2019 | 05:18 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4550.1 | 477264    | 11-Jan-2019 | 05:18 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4550.1 | 418896    | 11-Jan-2019 | 05:18 | x86      |
| Dtsconn.dll                                     | 2015.130.4550.1 | 492624    | 11-Jan-2019 | 05:18 | x64      |
| Dtsconn.dll                                     | 2015.130.4550.1 | 392272    | 11-Jan-2019 | 05:18 | x86      |
| Dtshost.exe                                     | 2015.130.4550.1 | 76368     | 11-Jan-2019 | 05:18 | x86      |
| Dtshost.exe                                     | 2015.130.4550.1 | 86608     | 11-Jan-2019 | 05:18 | x64      |
| Dtslog.dll                                      | 2015.130.4550.1 | 120400    | 11-Jan-2019 | 05:18 | x64      |
| Dtslog.dll                                      | 2015.130.4550.1 | 102992    | 11-Jan-2019 | 05:18 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4550.1 | 545360    | 11-Jan-2019 | 05:18 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4550.1 | 541264    | 11-Jan-2019 | 05:18 | x86      |
| Dtspipeline.dll                                 | 2015.130.4550.1 | 1279056   | 11-Jan-2019 | 05:18 | x64      |
| Dtspipeline.dll                                 | 2015.130.4550.1 | 1059408   | 11-Jan-2019 | 05:18 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4550.1 | 48208     | 11-Jan-2019 | 05:18 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4550.1 | 42064     | 11-Jan-2019 | 05:18 | x86      |
| Dtswizard.exe                                   | 13.0.4550.1     | 896080    | 11-Jan-2019 | 05:08 | x86      |
| Dtswizard.exe                                   | 13.0.4550.1     | 895568    | 11-Jan-2019 | 05:19 | x64      |
| Dtuparse.dll                                    | 2015.130.4550.1 | 87632     | 11-Jan-2019 | 05:18 | x64      |
| Dtuparse.dll                                    | 2015.130.4550.1 | 79952     | 11-Jan-2019 | 05:18 | x86      |
| Dtutil.exe                                      | 2015.130.4550.1 | 115280    | 11-Jan-2019 | 05:18 | x86      |
| Dtutil.exe                                      | 2015.130.4550.1 | 134736    | 11-Jan-2019 | 05:18 | x64      |
| Exceldest.dll                                   | 2015.130.4550.1 | 263760    | 11-Jan-2019 | 05:18 | x64      |
| Exceldest.dll                                   | 2015.130.4550.1 | 216656    | 11-Jan-2019 | 05:18 | x86      |
| Excelsrc.dll                                    | 2015.130.4550.1 | 285264    | 11-Jan-2019 | 05:18 | x64      |
| Excelsrc.dll                                    | 2015.130.4550.1 | 232528    | 11-Jan-2019 | 05:18 | x86      |
| Flatfiledest.dll                                | 2015.130.4550.1 | 389200    | 11-Jan-2019 | 05:18 | x64      |
| Flatfiledest.dll                                | 2015.130.4550.1 | 334416    | 11-Jan-2019 | 05:18 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4550.1 | 401488    | 11-Jan-2019 | 05:18 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4550.1 | 345168    | 11-Jan-2019 | 05:18 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4550.1 | 96336     | 11-Jan-2019 | 05:18 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4550.1 | 80464     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4550.1     | 92248     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4550.1     | 1313368   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4550.1     | 696408    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4550.1     | 763480    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4550.1 | 2023000   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4550.1 | 42072     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4550.1     | 73296     | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4550.1     | 186448    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4550.1     | 435792    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4550.1     | 436032    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4550.1     | 2044496   | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4550.1     | 2044712   | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4550.1     | 33360     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4550.1     | 33576     | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4550.1     | 249424    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4550.1     | 249640    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4550.1     | 501840    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4550.1     | 606504    | 11-Jan-2019 | 05:18 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4550.1     | 606288    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4550.1     | 106064    | 11-Jan-2019 | 05:20 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4550.1 | 150104    | 11-Jan-2019 | 05:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4550.1 | 138832    | 11-Jan-2019 | 05:19 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4550.1 | 158808    | 11-Jan-2019 | 05:18 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4550.1 | 144464    | 11-Jan-2019 | 05:19 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4550.1 | 100944    | 11-Jan-2019 | 05:18 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4550.1 | 89896     | 11-Jan-2019 | 05:19 | x86      |
| Msmdlocal.dll                                   | 2015.130.4550.1 | 56207952  | 11-Jan-2019 | 05:18 | x64      |
| Msmdlocal.dll                                   | 2015.130.4550.1 | 37103400  | 11-Jan-2019 | 05:19 | x86      |
| Msmdpp.dll                                      | 2015.130.4550.1 | 6370600   | 11-Jan-2019 | 05:19 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4550.1 | 7507240   | 11-Jan-2019 | 05:18 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4550.1 | 6507816   | 11-Jan-2019 | 05:19 | x86      |
| Msolap130.dll                                   | 2015.130.4550.1 | 8639568   | 11-Jan-2019 | 05:18 | x64      |
| Msolap130.dll                                   | 2015.130.4550.1 | 7008552   | 11-Jan-2019 | 05:19 | x86      |
| Msolui130.dll                                   | 2015.130.4550.1 | 310352    | 11-Jan-2019 | 05:18 | x64      |
| Msolui130.dll                                   | 2015.130.4550.1 | 287528    | 11-Jan-2019 | 05:19 | x86      |
| Oledbdest.dll                                   | 2015.130.4550.1 | 264272    | 11-Jan-2019 | 05:18 | x64      |
| Oledbdest.dll                                   | 2015.130.4550.1 | 216872    | 11-Jan-2019 | 05:19 | x86      |
| Oledbsrc.dll                                    | 2015.130.4550.1 | 290896    | 11-Jan-2019 | 05:18 | x64      |
| Oledbsrc.dll                                    | 2015.130.4550.1 | 235816    | 11-Jan-2019 | 05:19 | x86      |
| Profiler.exe                                    | 2015.130.4550.1 | 804440    | 11-Jan-2019 | 05:18 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4550.1 | 100432    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                                   | 2015.130.4550.1 | 127056    | 11-Jan-2019 | 05:18 | x64      |
| Sqldumper.exe                                   | 2015.130.4550.1 | 107600    | 11-Jan-2019 | 05:18 | x86      |
| Sqlresld.dll                                    | 2015.130.4550.1 | 28960     | 11-Jan-2019 | 05:19 | x86      |
| Sqlresld.dll                                    | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4550.1 | 28448     | 11-Jan-2019 | 05:19 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4550.1 | 30808     | 11-Jan-2019 | 05:21 | x64      |
| Sqlscm.dll                                      | 2015.130.4550.1 | 61224     | 11-Jan-2019 | 05:18 | x64      |
| Sqlscm.dll                                      | 2015.130.4550.1 | 53024     | 11-Jan-2019 | 05:19 | x86      |
| Sqlsvc.dll                                      | 2015.130.4550.1 | 127264    | 11-Jan-2019 | 05:19 | x86      |
| Sqlsvc.dll                                      | 2015.130.4550.1 | 152152    | 11-Jan-2019 | 05:21 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4550.1 | 151328    | 11-Jan-2019 | 05:19 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4550.1 | 180824    | 11-Jan-2019 | 05:21 | x64      |
| Txdataconvert.dll                               | 2015.130.4550.1 | 296536    | 11-Jan-2019 | 05:21 | x64      |
| Txdataconvert.dll                               | 2015.130.4550.1 | 255272    | 11-Jan-2019 | 05:21 | x86      |
| Xe.dll                                          | 2015.130.4550.1 | 558888    | 11-Jan-2019 | 05:18 | x86      |
| Xe.dll                                          | 2015.130.4550.1 | 626472    | 11-Jan-2019 | 05:19 | x64      |
| Xmlrw.dll                                       | 2015.130.4550.1 | 319272    | 11-Jan-2019 | 05:18 | x64      |
| Xmlrw.dll                                       | 2015.130.4550.1 | 259880    | 11-Jan-2019 | 05:21 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4550.1 | 227624    | 11-Jan-2019 | 05:18 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4550.1 | 191784    | 11-Jan-2019 | 05:21 | x86      |
| Xmsrv.dll                                       | 2015.130.4550.1 | 24050776  | 11-Jan-2019 | 05:21 | x64      |
| Xmsrv.dll                                       | 2015.130.4550.1 | 32727848  | 11-Jan-2019 | 05:21 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
