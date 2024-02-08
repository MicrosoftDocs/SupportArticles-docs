---
title: Cumulative update 14 for SQL Server 2016 SP1 (KB4488535)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 14 (KB4488535).
ms.date: 10/26/2023
ms.custom: KB4488535
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
---

# KB4488535 - Cumulative Update 14 for SQL Server 2016 SP1

_Release Date:_ &nbsp; March 19, 2019  
_Version:_ &nbsp; 13.0.4560.0

This article describes cumulative update package 14 (build number: 13.0.4560.0) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| <a id=12491205>[12491205](#12491205) </a> | [FIX: Intermittent failures when you back up to Azure storage from SQL Server 2014, 2016 and 2017 (KB4463320)](https://support.microsoft.com/help/4463320)| SQL Engine |
| <a id=12656913>[12656913](#12656913) </a> | [FIX: Assertion occurs when a parallel query deletes from a Filestream table in SQL Server 2014 and 2016 (KB4488809)](https://support.microsoft.com/help/4488809) | SQL Engine |
| <a id=12677809>[12677809](#12677809) </a> | [FIX: Filtered NCI over a CCI may not be maintained when the table is updated in a way that none of the key or included columns of the NCI are changed (KB4490138)](https://support.microsoft.com/help/4490138) | SQL performance|
| <a id=12750916>[12750916](#12750916) </a> | [FIX: "The given key was not present in the dictionary" occurs if you do a preview in the CDC Source in SQL Server 2016 (KB4490435)](https://support.microsoft.com/help/4490435)| Integration Services |
| <a id=12673774>[12673774](#12673774) </a> | [FIX: Floating point exception error 3628 occurs when you query DMV sys.dm_db_xtp_hash_index_stats in SQL Server 2016 (KB4491696)](https://support.microsoft.com/help/4491696)| In-Memory OLTP |
| <a id=12644869>[12644869](#12644869) </a> | [FIX: Error occurs when sp_addarticle is used to add article for transactional replication to memory-optimized table on subscriber in SQL Server 2016 (KB4493329)](https://support.microsoft.com/help/4493329)| SQL Engine |
| <a id=12746393>[12746393](#12746393) </a> | [FIX: A specially crafted query run by a low privileged user may expose the masked data in SQL Server 2016 (KB4493363)](https://support.microsoft.com/help/4493363) | SQL security |

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
| Instapi130.dll         | 2015.130.4560.0 | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Msmdredir.dll          | 2015.130.4560.0 | 6422096   | 12-Mar-2019 | 10:54 | x86      |
| Msmdsrv.rll            | 2015.130.4560.0 | 1296464   | 12-Mar-2019 | 10:54 | x86      |
| Msmdsrvi.rll           | 2015.130.4560.0 | 1293392   | 12-Mar-2019 | 10:54 | x86      |
| Sqlbrowser.exe         | 2015.130.4560.0 | 276560    | 12-Mar-2019 | 10:54 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe          | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4560.0  | 160336    | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                              | 2015.130.4560.0  | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Isacctchange.dll                            | 2015.130.4560.0  | 29264     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4560.0      | 1027152   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4560.0      | 1348688   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4560.0      | 702544    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4560.0      | 765520    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4560.0      | 520784    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4560.0      | 711760    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4560.0      | 36944     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4560.0      | 46160     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4560.0  | 72784     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4560.0      | 598608    | 12-Mar-2019 | 10:58 | x86      |
| Msasxpress.dll                              | 2015.130.4560.0  | 31824     | 12-Mar-2019 | 10:54 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4560.0  | 59984     | 12-Mar-2019 | 10:54 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4560.0  | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                               | 2015.130.4560.0  | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqlftacct.dll                               | 2015.130.4560.0  | 46672     | 12-Mar-2019 | 10:54 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04  | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4560.0  | 364112    | 12-Mar-2019 | 10:54 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4560.0  | 34896     | 12-Mar-2019 | 10:54 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4560.0  | 267344    | 12-Mar-2019 | 10:54 | x86      |
| Sqltdiagn.dll                               | 2015.130.4560.0  | 60496     | 12-Mar-2019 | 10:54 | x86      |
| Svrenumapi130.dll                           | 2015.130.4560.0  | 853584    | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4560.0  | 1876560   | 12-Mar-2019 | 10:53 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4560.0 | 120912    | 12-Mar-2019 | 10:54 | x86      |
| Dreplaycommon.dll              | 2015.130.4560.0 | 690768    | 12-Mar-2019 | 10:53 | x86      |
| Dreplayserverps.dll            | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:54 | x86      |
| Dreplayutil.dll                | 2015.130.4560.0 | 309840    | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                 | 2015.130.4560.0 | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Sqlresourceloader.dll          | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.130.4560.0 | 690768    | 12-Mar-2019 | 10:53 | x86      |
| Dreplaycontroller.exe              | 2015.130.4560.0 | 350288    | 12-Mar-2019 | 10:54 | x86      |
| Dreplayprocess.dll                 | 2015.130.4560.0 | 171600    | 12-Mar-2019 | 10:54 | x86      |
| Dreplayserverps.dll                | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                     | 2015.130.4560.0 | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Sqlresourceloader.dll              | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4560.0 | 1311824   | 12-Mar-2019 | 10:54 | x86      |
| Ddsshapes.dll                                   | 2015.130.4560.0 | 135760    | 12-Mar-2019 | 10:54 | x86      |
| Dtaengine.exe                                   | 2015.130.4560.0 | 166992    | 12-Mar-2019 | 10:54 | x86      |
| Dteparse.dll                                    | 2015.130.4560.0 | 99408     | 12-Mar-2019 | 10:54 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4560.0 | 83536     | 12-Mar-2019 | 10:53 | x86      |
| Dtepkg.dll                                      | 2015.130.4560.0 | 115792    | 12-Mar-2019 | 10:54 | x86      |
| Dtexec.exe                                      | 2015.130.4560.0 | 66640     | 12-Mar-2019 | 10:54 | x86      |
| Dts.dll                                         | 2015.130.4560.0 | 2632784   | 12-Mar-2019 | 10:54 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4560.0 | 418896    | 12-Mar-2019 | 10:54 | x86      |
| Dtsconn.dll                                     | 2015.130.4560.0 | 392272    | 12-Mar-2019 | 10:54 | x86      |
| Dtshost.exe                                     | 2015.130.4560.0 | 76368     | 12-Mar-2019 | 10:54 | x86      |
| Dtslog.dll                                      | 2015.130.4560.0 | 102992    | 12-Mar-2019 | 10:54 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4560.0 | 541264    | 12-Mar-2019 | 10:54 | x86      |
| Dtspipeline.dll                                 | 2015.130.4560.0 | 1059408   | 12-Mar-2019 | 10:54 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4560.0 | 42064     | 12-Mar-2019 | 10:54 | x86      |
| Dtswizard.exe                                   | 13.0.4560.0     | 896088    | 12-Mar-2019 | 10:41 | x86      |
| Dtuparse.dll                                    | 2015.130.4560.0 | 79952     | 12-Mar-2019 | 10:54 | x86      |
| Dtutil.exe                                      | 2015.130.4560.0 | 115280    | 12-Mar-2019 | 10:54 | x86      |
| Exceldest.dll                                   | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Excelsrc.dll                                    | 2015.130.4560.0 | 232528    | 12-Mar-2019 | 10:54 | x86      |
| Flatfiledest.dll                                | 2015.130.4560.0 | 334416    | 12-Mar-2019 | 10:54 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4560.0 | 345168    | 12-Mar-2019 | 10:54 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4560.0 | 80464     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4560.0     | 92240     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4560.0     | 1313360   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4560.0     | 696400    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4560.0     | 763472    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4560.0 | 2022992   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4560.0 | 42064     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4560.0     | 186448    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4560.0     | 435792    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4560.0     | 2044496   | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4560.0     | 33360     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4560.0     | 249424    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4560.0     | 501840    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4560.0     | 106064    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4560.0 | 138832    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4560.0 | 144464    | 12-Mar-2019 | 10:52 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4560.0 | 89680     | 12-Mar-2019 | 10:54 | x86      |
| Msmdlocal.dll                                   | 2015.130.4560.0 | 37103184  | 12-Mar-2019 | 10:54 | x86      |
| Msmdpp.dll                                      | 2015.130.4560.0 | 6370384   | 12-Mar-2019 | 10:54 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4560.0 | 6507600   | 12-Mar-2019 | 10:53 | x86      |
| Msolap130.dll                                   | 2015.130.4560.0 | 7008336   | 12-Mar-2019 | 10:54 | x86      |
| Msolui130.dll                                   | 2015.130.4560.0 | 287312    | 12-Mar-2019 | 10:54 | x86      |
| Oledbdest.dll                                   | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Oledbsrc.dll                                    | 2015.130.4560.0 | 235600    | 12-Mar-2019 | 10:54 | x86      |
| Profiler.exe                                    | 2015.130.4560.0 | 804432    | 12-Mar-2019 | 10:53 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                                   | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqlresld.dll                                    | 2015.130.4560.0 | 28752     | 12-Mar-2019 | 10:54 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |
| Sqlscm.dll                                      | 2015.130.4560.0 | 52816     | 12-Mar-2019 | 10:54 | x86      |
| Sqlsvc.dll                                      | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:54 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4560.0 | 151120    | 12-Mar-2019 | 10:54 | x86      |
| Txdataconvert.dll                               | 2015.130.4560.0 | 255056    | 12-Mar-2019 | 10:58 | x86      |
| Xe.dll                                          | 2015.130.4560.0 | 558672    | 12-Mar-2019 | 10:54 | x86      |
| Xmlrw.dll                                       | 2015.130.4560.0 | 259664    | 12-Mar-2019 | 10:58 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4560.0 | 191568    | 12-Mar-2019 | 10:58 | x86      |
| Xmsrv.dll                                       | 2015.130.4560.0 | 32727632  | 12-Mar-2019 | 10:58 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time  | Platform |
|----------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll | 2015.130.4560.0 | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Keyfile.dll    | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:54 | x86      |
| Msmdredir.dll  | 2015.130.4560.0 | 6422096   | 12-Mar-2019 | 10:54 | x86      |
| Msmdsrv.rll    | 2015.130.4560.0 | 1296464   | 12-Mar-2019 | 10:54 | x86      |
| Msmdsrvi.rll   | 2015.130.4560.0 | 1293392   | 12-Mar-2019 | 10:54 | x86      |
| Sqlbrowser.exe | 2015.130.4560.0 | 276560    | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe  | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time  | Platform |
|-----------------------|-----------------|-----------|-----------|-------|----------|
| Instapi130.dll        | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sqlboot.dll           | 2015.130.4560.0 | 186448    | 12-Mar-2019 | 10:59 | x64      |
| Sqldumper.exe         | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:58 | x64      |
| Sqlvdi.dll            | 2015.130.4560.0 | 168528    | 12-Mar-2019 | 10:54 | x86      |
| Sqlvdi.dll            | 2015.130.4560.0 | 197200    | 12-Mar-2019 | 10:58 | x64      |
| Sqlwriter.exe         | 2015.130.4560.0 | 131664    | 12-Mar-2019 | 10:53 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlwvss.dll           | 2015.130.4560.0 | 340560    | 12-Mar-2019 | 10:53 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4560.0 | 26192     | 12-Mar-2019 | 10:53 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4560.0     | 1347664   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4560.0     | 765520    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4560.0     | 521296    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4560.0     | 989776    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4560.0     | 989776    | 12-Mar-2019 | 10:55 | x86      |
| Msmdctr130.dll                                     | 2015.130.4560.0 | 40016     | 12-Mar-2019 | 10:59 | x64      |
| Msmdlocal.dll                                      | 2015.130.4560.0 | 37103184  | 12-Mar-2019 | 10:54 | x86      |
| Msmdlocal.dll                                      | 2015.130.4560.0 | 56207952  | 12-Mar-2019 | 10:59 | x64      |
| Msmdpump.dll                                       | 2015.130.4560.0 | 7799376   | 12-Mar-2019 | 10:59 | x64      |
| Msmdredir.dll                                      | 2015.130.4560.0 | 6422096   | 12-Mar-2019 | 10:54 | x86      |
| Msmdsrv.exe                                        | 2015.130.4560.0 | 56747088  | 12-Mar-2019 | 10:53 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4560.0 | 7507024   | 12-Mar-2019 | 10:53 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4560.0 | 6507600   | 12-Mar-2019 | 10:53 | x86      |
| Msolap130.dll                                      | 2015.130.4560.0 | 7008336   | 12-Mar-2019 | 10:54 | x86      |
| Msolap130.dll                                      | 2015.130.4560.0 | 8639568   | 12-Mar-2019 | 10:59 | x64      |
| Msolui130.dll                                      | 2015.130.4560.0 | 287312    | 12-Mar-2019 | 10:54 | x86      |
| Msolui130.dll                                      | 2015.130.4560.0 | 310352    | 12-Mar-2019 | 10:59 | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlboot.dll                                        | 2015.130.4560.0 | 186448    | 12-Mar-2019 | 10:59 | x64      |
| Sqlceip.exe                                        | 13.0.4560.0     | 252496    | 12-Mar-2019 | 10:52 | x86      |
| Sqldumper.exe                                      | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                                      | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:58 | x64      |
| Tmapi.dll                                          | 2015.130.4560.0 | 4345936   | 12-Mar-2019 | 10:53 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4560.0 | 2826320   | 12-Mar-2019 | 10:53 | x64      |
| Tmpersistence.dll                                  | 2015.130.4560.0 | 1071184   | 12-Mar-2019 | 10:53 | x64      |
| Tmtransactions.dll                                 | 2015.130.4560.0 | 1352272   | 12-Mar-2019 | 10:53 | x64      |
| Xe.dll                                             | 2015.130.4560.0 | 626256    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                          | 2015.130.4560.0 | 319056    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                          | 2015.130.4560.0 | 259664    | 12-Mar-2019 | 10:58 | x86      |
| Xmlrwbin.dll                                       | 2015.130.4560.0 | 227408    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrwbin.dll                                       | 2015.130.4560.0 | 191568    | 12-Mar-2019 | 10:58 | x86      |
| Xmsrv.dll                                          | 2015.130.4560.0 | 24050768  | 12-Mar-2019 | 10:53 | x64      |
| Xmsrv.dll                                          | 2015.130.4560.0 | 32727632  | 12-Mar-2019 | 10:58 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                             | 2015.130.4560.0  | 160336    | 12-Mar-2019 | 10:54 | x86      |
| Batchparser.dll                             | 2015.130.4560.0  | 180816    | 12-Mar-2019 | 10:58 | x64      |
| Instapi130.dll                              | 2015.130.4560.0  | 53328     | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                              | 2015.130.4560.0  | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Isacctchange.dll                            | 2015.130.4560.0  | 29264     | 12-Mar-2019 | 10:54 | x86      |
| Isacctchange.dll                            | 2015.130.4560.0  | 30800     | 12-Mar-2019 | 10:58 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4560.0      | 1027152   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4560.0      | 1027152   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4560.0      | 1348688   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4560.0      | 702544    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4560.0      | 765520    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4560.0      | 520784    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4560.0      | 711760    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4560.0      | 711760    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4560.0      | 36944     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4560.0      | 46160     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4560.0  | 75344     | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4560.0  | 72784     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4560.0      | 598608    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4560.0      | 598608    | 12-Mar-2019 | 10:58 | x86      |
| Msasxpress.dll                              | 2015.130.4560.0  | 31824     | 12-Mar-2019 | 10:54 | x86      |
| Msasxpress.dll                              | 2015.130.4560.0  | 35920     | 12-Mar-2019 | 10:59 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4560.0  | 59984     | 12-Mar-2019 | 10:54 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4560.0  | 72784     | 12-Mar-2019 | 10:59 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4560.0  | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqldumper.exe                               | 2015.130.4560.0  | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                               | 2015.130.4560.0  | 127056    | 12-Mar-2019 | 10:58 | x64      |
| Sqlftacct.dll                               | 2015.130.4560.0  | 46672     | 12-Mar-2019 | 10:54 | x86      |
| Sqlftacct.dll                               | 2015.130.4560.0  | 51792     | 12-Mar-2019 | 10:59 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04  | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 04:18  | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4560.0  | 404048    | 12-Mar-2019 | 10:53 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4560.0  | 364112    | 12-Mar-2019 | 10:54 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4560.0  | 37456     | 12-Mar-2019 | 10:53 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4560.0  | 34896     | 12-Mar-2019 | 10:54 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4560.0  | 348752    | 12-Mar-2019 | 10:53 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4560.0  | 267344    | 12-Mar-2019 | 10:54 | x86      |
| Sqltdiagn.dll                               | 2015.130.4560.0  | 67664     | 12-Mar-2019 | 10:53 | x64      |
| Sqltdiagn.dll                               | 2015.130.4560.0  | 60496     | 12-Mar-2019 | 10:54 | x86      |
| Svrenumapi130.dll                           | 2015.130.4560.0  | 1115728   | 12-Mar-2019 | 10:53 | x64      |
| Svrenumapi130.dll                           | 2015.130.4560.0  | 853584    | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time  | Platform |
|---------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4560.0  | 1876560   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4560.0  | 1876560   | 12-Mar-2019 | 10:53 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time  | Platform |
|--------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2015.130.4560.0 | 120912    | 12-Mar-2019 | 10:54 | x86      |
| Dreplaycommon.dll              | 2015.130.4560.0 | 690768    | 12-Mar-2019 | 10:53 | x86      |
| Dreplayserverps.dll            | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:54 | x86      |
| Dreplayutil.dll                | 2015.130.4560.0 | 309840    | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                 | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlresourceloader.dll          | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2015.130.4560.0 | 690768    | 12-Mar-2019 | 10:53 | x86      |
| Dreplaycontroller.exe              | 2015.130.4560.0 | 350288    | 12-Mar-2019 | 10:54 | x86      |
| Dreplayprocess.dll                 | 2015.130.4560.0 | 171600    | 12-Mar-2019 | 10:54 | x86      |
| Dreplayserverps.dll                | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:54 | x86      |
| Instapi130.dll                     | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlresourceloader.dll              | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4560.0     | 41040     | 12-Mar-2019 | 10:53 | x64      |
| Batchparser.dll                              | 2015.130.4560.0 | 180816    | 12-Mar-2019 | 10:58 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925264    | 12-Mar-2019 | 10:58 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341264   | 12-Mar-2019 | 10:58 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192080    | 12-Mar-2019 | 10:58 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4560.0 | 225360    | 12-Mar-2019 | 10:58 | x64      |
| Dcexec.exe                                   | 2015.130.4560.0 | 74320     | 12-Mar-2019 | 10:53 | x64      |
| Fssres.dll                                   | 2015.130.4560.0 | 81488     | 12-Mar-2019 | 10:58 | x64      |
| Hadrres.dll                                  | 2015.130.4560.0 | 177744    | 12-Mar-2019 | 10:58 | x64      |
| Hkcompile.dll                                | 2015.130.4560.0 | 1298000   | 12-Mar-2019 | 10:58 | x64      |
| Hkengine.dll                                 | 2015.130.4560.0 | 5600848   | 12-Mar-2019 | 10:58 | x64      |
| Hkruntime.dll                                | 2015.130.4560.0 | 158800    | 12-Mar-2019 | 10:58 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017424   | 12-Mar-2019 | 10:58 | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4560.0     | 234064    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4560.0     | 79440     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4560.0 | 391760    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4560.0 | 72272     | 12-Mar-2019 | 10:53 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4560.0 | 65104     | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4560.0 | 150096    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4560.0 | 158800    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4560.0 | 271952    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4560.0 | 74832     | 12-Mar-2019 | 10:55 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129616    | 12-Mar-2019 | 10:58 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559184    | 12-Mar-2019 | 10:58 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559184    | 12-Mar-2019 | 10:58 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661072    | 12-Mar-2019 | 10:58 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964688    | 12-Mar-2019 | 10:58 | x64      |
| Odsole70.dll                                 | 2015.130.4560.0 | 92752     | 12-Mar-2019 | 10:59 | x64      |
| Opends60.dll                                 | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:58 | x64      |
| Qds.dll                                      | 2015.130.4560.0 | 845392    | 12-Mar-2019 | 10:59 | x64      |
| Rsfxft.dll                                   | 2015.130.4560.0 | 34384     | 12-Mar-2019 | 10:58 | x64      |
| Sqagtres.dll                                 | 2015.130.4560.0 | 64592     | 12-Mar-2019 | 10:59 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlaamss.dll                                 | 2015.130.4560.0 | 80464     | 12-Mar-2019 | 10:53 | x64      |
| Sqlaccess.dll                                | 2015.130.4560.0 | 462416    | 12-Mar-2019 | 10:55 | x64      |
| Sqlagent.exe                                 | 2015.130.4560.0 | 566352    | 12-Mar-2019 | 10:53 | x64      |
| Sqlagentctr130.dll                           | 2015.130.4560.0 | 44112     | 12-Mar-2019 | 10:54 | x86      |
| Sqlagentctr130.dll                           | 2015.130.4560.0 | 51792     | 12-Mar-2019 | 10:59 | x64      |
| Sqlagentlog.dll                              | 2015.130.4560.0 | 32848     | 12-Mar-2019 | 10:59 | x64      |
| Sqlagentmail.dll                             | 2015.130.4560.0 | 47696     | 12-Mar-2019 | 10:53 | x64      |
| Sqlboot.dll                                  | 2015.130.4560.0 | 186448    | 12-Mar-2019 | 10:59 | x64      |
| Sqlceip.exe                                  | 13.0.4560.0     | 252496    | 12-Mar-2019 | 10:52 | x86      |
| Sqlcmdss.dll                                 | 2015.130.4560.0 | 59984     | 12-Mar-2019 | 10:59 | x64      |
| Sqlctr130.dll                                | 2015.130.4560.0 | 103504    | 12-Mar-2019 | 10:54 | x86      |
| Sqlctr130.dll                                | 2015.130.4560.0 | 118352    | 12-Mar-2019 | 10:58 | x64      |
| Sqldk.dll                                    | 2015.130.4560.0 | 2587216   | 12-Mar-2019 | 10:59 | x64      |
| Sqldtsss.dll                                 | 2015.130.4560.0 | 97360     | 12-Mar-2019 | 10:53 | x64      |
| Sqliosim.com                                 | 2015.130.4560.0 | 307792    | 12-Mar-2019 | 10:54 | x64      |
| Sqliosim.exe                                 | 2015.130.4560.0 | 3014224   | 12-Mar-2019 | 10:53 | x64      |
| Sqllang.dll                                  | 2015.130.4560.0 | 39448656  | 12-Mar-2019 | 10:59 | x64      |
| Sqlmin.dll                                   | 2015.130.4560.0 | 37710928  | 12-Mar-2019 | 10:53 | x64      |
| Sqlolapss.dll                                | 2015.130.4560.0 | 97872     | 12-Mar-2019 | 10:53 | x64      |
| Sqlos.dll                                    | 2015.130.4560.0 | 26192     | 12-Mar-2019 | 10:58 | x64      |
| Sqlpowershellss.dll                          | 2015.130.4560.0 | 58448     | 12-Mar-2019 | 10:53 | x64      |
| Sqlrepss.dll                                 | 2015.130.4560.0 | 54864     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresld.dll                                 | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresourceloader.dll                        | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlscm.dll                                   | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4560.0 | 27728     | 12-Mar-2019 | 10:53 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4560.0 | 5800016   | 12-Mar-2019 | 10:58 | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4560.0 | 732752    | 12-Mar-2019 | 10:58 | x64      |
| Sqlservr.exe                                 | 2015.130.4560.0 | 393296    | 12-Mar-2019 | 10:53 | x64      |
| Sqlsvc.dll                                   | 2015.130.4560.0 | 152144    | 12-Mar-2019 | 10:53 | x64      |
| Sqltses.dll                                  | 2015.130.4560.0 | 8922192   | 12-Mar-2019 | 10:53 | x64      |
| Sqsrvres.dll                                 | 2015.130.4560.0 | 250960    | 12-Mar-2019 | 10:53 | x64      |
| Stretchcodegen.exe                           | 13.0.4560.0     | 55888     | 12-Mar-2019 | 10:52 | x86      |
| Xe.dll                                       | 2015.130.4560.0 | 626256    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                    | 2015.130.4560.0 | 319056    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrwbin.dll                                 | 2015.130.4560.0 | 227408    | 12-Mar-2019 | 10:58 | x64      |
| Xpadsi.exe                                   | 2015.130.4560.0 | 78928     | 12-Mar-2019 | 10:59 | x64      |
| Xplog70.dll                                  | 2015.130.4560.0 | 65616     | 12-Mar-2019 | 10:58 | x64      |
| Xpqueue.dll                                  | 2015.130.4560.0 | 74832     | 12-Mar-2019 | 10:53 | x64      |
| Xprepl.dll                                   | 2015.130.4560.0 | 91216     | 12-Mar-2019 | 10:53 | x64      |
| Xpsqlbot.dll                                 | 2015.130.4560.0 | 33360     | 12-Mar-2019 | 10:58 | x64      |
| Xpstar.dll                                   | 2015.130.4560.0 | 422480    | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4560.0 | 160336    | 12-Mar-2019 | 10:54 | x86      |
| Batchparser.dll                                                    | 2015.130.4560.0 | 180816    | 12-Mar-2019 | 10:58 | x64      |
| Bcp.exe                                                            | 2015.130.4560.0 | 119888    | 12-Mar-2019 | 10:58 | x64      |
| Commanddest.dll                                                    | 2015.130.4560.0 | 248912    | 12-Mar-2019 | 10:58 | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4560.0 | 115792    | 12-Mar-2019 | 10:58 | x64      |
| Datacollectortasks.dll                                             | 2015.130.4560.0 | 187984    | 12-Mar-2019 | 10:58 | x64      |
| Distrib.exe                                                        | 2015.130.4560.0 | 191056    | 12-Mar-2019 | 10:53 | x64      |
| Dteparse.dll                                                       | 2015.130.4560.0 | 109648    | 12-Mar-2019 | 10:58 | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:55 | x64      |
| Dtepkg.dll                                                         | 2015.130.4560.0 | 137296    | 12-Mar-2019 | 10:58 | x64      |
| Dtexec.exe                                                         | 2015.130.4560.0 | 72784     | 12-Mar-2019 | 10:53 | x64      |
| Dts.dll                                                            | 2015.130.4560.0 | 3146832   | 12-Mar-2019 | 10:58 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4560.0 | 477264    | 12-Mar-2019 | 10:58 | x64      |
| Dtsconn.dll                                                        | 2015.130.4560.0 | 492624    | 12-Mar-2019 | 10:58 | x64      |
| Dtshost.exe                                                        | 2015.130.4560.0 | 86608     | 12-Mar-2019 | 10:53 | x64      |
| Dtslog.dll                                                         | 2015.130.4560.0 | 120400    | 12-Mar-2019 | 10:58 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4560.0 | 545360    | 12-Mar-2019 | 10:58 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4560.0 | 1279056   | 12-Mar-2019 | 10:58 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4560.0 | 48208     | 12-Mar-2019 | 10:58 | x64      |
| Dtswizard.exe                                                      | 13.0.4560.0     | 895568    | 12-Mar-2019 | 10:52 | x64      |
| Dtuparse.dll                                                       | 2015.130.4560.0 | 87632     | 12-Mar-2019 | 10:58 | x64      |
| Dtutil.exe                                                         | 2015.130.4560.0 | 134736    | 12-Mar-2019 | 10:53 | x64      |
| Exceldest.dll                                                      | 2015.130.4560.0 | 263760    | 12-Mar-2019 | 10:58 | x64      |
| Excelsrc.dll                                                       | 2015.130.4560.0 | 285264    | 12-Mar-2019 | 10:58 | x64      |
| Execpackagetask.dll                                                | 2015.130.4560.0 | 166480    | 12-Mar-2019 | 10:58 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4560.0 | 389200    | 12-Mar-2019 | 10:58 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4560.0 | 401488    | 12-Mar-2019 | 10:58 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4560.0 | 96336     | 12-Mar-2019 | 10:58 | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4560.0 | 58960     | 12-Mar-2019 | 10:58 | x64      |
| Logread.exe                                                        | 2015.130.4560.0 | 617040    | 12-Mar-2019 | 10:53 | x64      |
| Mergetxt.dll                                                       | 2015.130.4560.0 | 53840     | 12-Mar-2019 | 10:58 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4560.0     | 1313360   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4560.0     | 696400    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4560.0     | 763472    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 11-Mar-2019 | 20:46 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4560.0     | 54352     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4560.0     | 89680     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4560.0     | 49744     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4560.0     | 43088     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4560.0     | 70736     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4560.0     | 35408     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4560.0     | 63568     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4560.0     | 31312     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4560.0     | 131152    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4560.0     | 43600     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4560.0     | 57424     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4560.0     | 215120    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4560.0 | 1638992   | 12-Mar-2019 | 10:53 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4560.0 | 150096    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4560.0 | 158800    | 12-Mar-2019 | 10:55 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4560.0 | 100944    | 12-Mar-2019 | 10:59 | x64      |
| Msgprox.dll                                                        | 2015.130.4560.0 | 275536    | 12-Mar-2019 | 10:59 | x64      |
| Msxmlsql.dll                                                       | 2015.130.4560.0 | 1494608   | 12-Mar-2019 | 10:58 | x64      |
| Oledbdest.dll                                                      | 2015.130.4560.0 | 264272    | 12-Mar-2019 | 10:59 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4560.0 | 290896    | 12-Mar-2019 | 10:59 | x64      |
| Osql.exe                                                           | 2015.130.4560.0 | 75344     | 12-Mar-2019 | 10:58 | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4560.0 | 469072    | 12-Mar-2019 | 10:53 | x64      |
| Rawdest.dll                                                        | 2015.130.4560.0 | 209488    | 12-Mar-2019 | 10:59 | x64      |
| Rawsource.dll                                                      | 2015.130.4560.0 | 196688    | 12-Mar-2019 | 10:59 | x64      |
| Rdistcom.dll                                                       | 2015.130.4560.0 | 894032    | 12-Mar-2019 | 10:59 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4560.0 | 187472    | 12-Mar-2019 | 10:59 | x64      |
| Replagnt.dll                                                       | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:59 | x64      |
| Repldp.dll                                                         | 2015.130.4560.0 | 277072    | 12-Mar-2019 | 10:59 | x64      |
| Replerrx.dll                                                       | 2015.130.4560.0 | 144464    | 12-Mar-2019 | 10:59 | x64      |
| Replisapi.dll                                                      | 2015.130.4560.0 | 354384    | 12-Mar-2019 | 10:59 | x64      |
| Replmerg.exe                                                       | 2015.130.4560.0 | 518736    | 12-Mar-2019 | 10:53 | x64      |
| Replprov.dll                                                       | 2015.130.4560.0 | 812112    | 12-Mar-2019 | 10:59 | x64      |
| Replrec.dll                                                        | 2015.130.4560.0 | 1018448   | 12-Mar-2019 | 10:53 | x64      |
| Replsub.dll                                                        | 2015.130.4560.0 | 467536    | 12-Mar-2019 | 10:59 | x64      |
| Replsync.dll                                                       | 2015.130.4560.0 | 143952    | 12-Mar-2019 | 10:59 | x64      |
| Spresolv.dll                                                       | 2015.130.4560.0 | 245328    | 12-Mar-2019 | 10:59 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlcmd.exe                                                         | 2015.130.4560.0 | 249424    | 12-Mar-2019 | 10:58 | x64      |
| Sqldiag.exe                                                        | 2015.130.4560.0 | 1257552   | 12-Mar-2019 | 10:53 | x64      |
| Sqldistx.dll                                                       | 2015.130.4560.0 | 215632    | 12-Mar-2019 | 10:59 | x64      |
| Sqllogship.exe                                                     | 13.0.4560.0     | 100432    | 12-Mar-2019 | 10:52 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4560.0 | 346704    | 12-Mar-2019 | 10:53 | x64      |
| Sqlps.exe                                                          | 13.0.4560.0     | 59984     | 12-Mar-2019 | 10:53 | x86      |
| Sqlresld.dll                                                       | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresld.dll                                                       | 2015.130.4560.0 | 28752     | 12-Mar-2019 | 10:54 | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |
| Sqlscm.dll                                                         | 2015.130.4560.0 | 52816     | 12-Mar-2019 | 10:54 | x86      |
| Sqlscm.dll                                                         | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4560.0 | 152144    | 12-Mar-2019 | 10:53 | x64      |
| Sqlsvc.dll                                                         | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:54 | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4560.0 | 180816    | 12-Mar-2019 | 10:53 | x64      |
| Sqlwep130.dll                                                      | 2015.130.4560.0 | 105552    | 12-Mar-2019 | 10:53 | x64      |
| Ssdebugps.dll                                                      | 2015.130.4560.0 | 33360     | 12-Mar-2019 | 10:53 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4560.0 | 216144    | 12-Mar-2019 | 10:53 | x64      |
| Ssradd.dll                                                         | 2015.130.4560.0 | 65104     | 12-Mar-2019 | 10:53 | x64      |
| Ssravg.dll                                                         | 2015.130.4560.0 | 65104     | 12-Mar-2019 | 10:53 | x64      |
| Ssrdown.dll                                                        | 2015.130.4560.0 | 50768     | 12-Mar-2019 | 10:53 | x64      |
| Ssrmax.dll                                                         | 2015.130.4560.0 | 63568     | 12-Mar-2019 | 10:53 | x64      |
| Ssrmin.dll                                                         | 2015.130.4560.0 | 63568     | 12-Mar-2019 | 10:53 | x64      |
| Ssrpub.dll                                                         | 2015.130.4560.0 | 51280     | 12-Mar-2019 | 10:53 | x64      |
| Ssrup.dll                                                          | 2015.130.4560.0 | 50768     | 12-Mar-2019 | 10:53 | x64      |
| Txagg.dll                                                          | 2015.130.4560.0 | 364624    | 12-Mar-2019 | 10:53 | x64      |
| Txbdd.dll                                                          | 2015.130.4560.0 | 172624    | 12-Mar-2019 | 10:53 | x64      |
| Txdatacollector.dll                                                | 2015.130.4560.0 | 367696    | 12-Mar-2019 | 10:53 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4560.0 | 296528    | 12-Mar-2019 | 10:53 | x64      |
| Txderived.dll                                                      | 2015.130.4560.0 | 607824    | 12-Mar-2019 | 10:53 | x64      |
| Txlookup.dll                                                       | 2015.130.4560.0 | 532560    | 12-Mar-2019 | 10:53 | x64      |
| Txmerge.dll                                                        | 2015.130.4560.0 | 229968    | 12-Mar-2019 | 10:53 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4560.0 | 278608    | 12-Mar-2019 | 10:53 | x64      |
| Txmulticast.dll                                                    | 2015.130.4560.0 | 128592    | 12-Mar-2019 | 10:53 | x64      |
| Txrowcount.dll                                                     | 2015.130.4560.0 | 126544    | 12-Mar-2019 | 10:53 | x64      |
| Txsort.dll                                                         | 2015.130.4560.0 | 258640    | 12-Mar-2019 | 10:53 | x64      |
| Txsplit.dll                                                        | 2015.130.4560.0 | 600656    | 12-Mar-2019 | 10:53 | x64      |
| Txunionall.dll                                                     | 2015.130.4560.0 | 181840    | 12-Mar-2019 | 10:53 | x64      |
| Xe.dll                                                             | 2015.130.4560.0 | 626256    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                                          | 2015.130.4560.0 | 319056    | 12-Mar-2019 | 10:58 | x64      |
| Xmlsub.dll                                                         | 2015.130.4560.0 | 250960    | 12-Mar-2019 | 10:53 | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time  | Platform |
|-------------------------------|-----------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2015.130.4560.0 | 1013840   | 12-Mar-2019 | 10:58 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlsatellite.dll              | 2015.130.4560.0 | 837200    | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2015.130.4560.0 | 660048    | 12-Mar-2019 | 10:58 | x64      |
| Fdhost.exe               | 2015.130.4560.0 | 105040    | 12-Mar-2019 | 10:58 | x64      |
| Fdlauncher.exe           | 2015.130.4560.0 | 51280     | 12-Mar-2019 | 10:58 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlft130ph.dll           | 2015.130.4560.0 | 57936     | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time  | Platform |
|-------------------------|-----------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 13.0.4560.0     | 23632     | 12-Mar-2019 | 10:55 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.111       | 77944     | 11-Mar-2019 | 20:46 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.111       | 77944     | 12-Mar-2019 | 02:08  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.111       | 37496     | 11-Mar-2019 | 20:46 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.111       | 37496     | 12-Mar-2019 | 02:08  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.111       | 78456     | 11-Mar-2019 | 20:46 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.111       | 78456     | 12-Mar-2019 | 02:08  | x86      |
| Commanddest.dll                                                    | 2015.130.4560.0 | 202832    | 12-Mar-2019 | 10:54 | x86      |
| Commanddest.dll                                                    | 2015.130.4560.0 | 248912    | 12-Mar-2019 | 10:58 | x64      |
| Dteparse.dll                                                       | 2015.130.4560.0 | 99408     | 12-Mar-2019 | 10:54 | x86      |
| Dteparse.dll                                                       | 2015.130.4560.0 | 109648    | 12-Mar-2019 | 10:58 | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4560.0 | 83536     | 12-Mar-2019 | 10:53 | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:55 | x64      |
| Dtepkg.dll                                                         | 2015.130.4560.0 | 115792    | 12-Mar-2019 | 10:54 | x86      |
| Dtepkg.dll                                                         | 2015.130.4560.0 | 137296    | 12-Mar-2019 | 10:58 | x64      |
| Dtexec.exe                                                         | 2015.130.4560.0 | 72784     | 12-Mar-2019 | 10:53 | x64      |
| Dtexec.exe                                                         | 2015.130.4560.0 | 66640     | 12-Mar-2019 | 10:54 | x86      |
| Dts.dll                                                            | 2015.130.4560.0 | 2632784   | 12-Mar-2019 | 10:54 | x86      |
| Dts.dll                                                            | 2015.130.4560.0 | 3146832   | 12-Mar-2019 | 10:58 | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4560.0 | 418896    | 12-Mar-2019 | 10:54 | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4560.0 | 477264    | 12-Mar-2019 | 10:58 | x64      |
| Dtsconn.dll                                                        | 2015.130.4560.0 | 392272    | 12-Mar-2019 | 10:54 | x86      |
| Dtsconn.dll                                                        | 2015.130.4560.0 | 492624    | 12-Mar-2019 | 10:58 | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4560.0 | 109648    | 12-Mar-2019 | 10:53 | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4560.0 | 93776     | 12-Mar-2019 | 10:54 | x86      |
| Dtshost.exe                                                        | 2015.130.4560.0 | 86608     | 12-Mar-2019 | 10:53 | x64      |
| Dtshost.exe                                                        | 2015.130.4560.0 | 76368     | 12-Mar-2019 | 10:54 | x86      |
| Dtslog.dll                                                         | 2015.130.4560.0 | 102992    | 12-Mar-2019 | 10:54 | x86      |
| Dtslog.dll                                                         | 2015.130.4560.0 | 120400    | 12-Mar-2019 | 10:58 | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4560.0 | 541264    | 12-Mar-2019 | 10:54 | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4560.0 | 545360    | 12-Mar-2019 | 10:58 | x64      |
| Dtspipeline.dll                                                    | 2015.130.4560.0 | 1059408   | 12-Mar-2019 | 10:54 | x86      |
| Dtspipeline.dll                                                    | 2015.130.4560.0 | 1279056   | 12-Mar-2019 | 10:58 | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4560.0 | 42064     | 12-Mar-2019 | 10:54 | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4560.0 | 48208     | 12-Mar-2019 | 10:58 | x64      |
| Dtswizard.exe                                                      | 13.0.4560.0     | 896088    | 12-Mar-2019 | 10:41 | x86      |
| Dtswizard.exe                                                      | 13.0.4560.0     | 895568    | 12-Mar-2019 | 10:52 | x64      |
| Dtuparse.dll                                                       | 2015.130.4560.0 | 79952     | 12-Mar-2019 | 10:54 | x86      |
| Dtuparse.dll                                                       | 2015.130.4560.0 | 87632     | 12-Mar-2019 | 10:58 | x64      |
| Dtutil.exe                                                         | 2015.130.4560.0 | 134736    | 12-Mar-2019 | 10:53 | x64      |
| Dtutil.exe                                                         | 2015.130.4560.0 | 115280    | 12-Mar-2019 | 10:54 | x86      |
| Exceldest.dll                                                      | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Exceldest.dll                                                      | 2015.130.4560.0 | 263760    | 12-Mar-2019 | 10:58 | x64      |
| Excelsrc.dll                                                       | 2015.130.4560.0 | 232528    | 12-Mar-2019 | 10:54 | x86      |
| Excelsrc.dll                                                       | 2015.130.4560.0 | 285264    | 12-Mar-2019 | 10:58 | x64      |
| Execpackagetask.dll                                                | 2015.130.4560.0 | 135248    | 12-Mar-2019 | 10:54 | x86      |
| Execpackagetask.dll                                                | 2015.130.4560.0 | 166480    | 12-Mar-2019 | 10:58 | x64      |
| Flatfiledest.dll                                                   | 2015.130.4560.0 | 334416    | 12-Mar-2019 | 10:54 | x86      |
| Flatfiledest.dll                                                   | 2015.130.4560.0 | 389200    | 12-Mar-2019 | 10:58 | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4560.0 | 345168    | 12-Mar-2019 | 10:54 | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4560.0 | 401488    | 12-Mar-2019 | 10:58 | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4560.0 | 80464     | 12-Mar-2019 | 10:54 | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4560.0 | 96336     | 12-Mar-2019 | 10:58 | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4560.0     | 439896    | 12-Mar-2019 | 10:41 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4560.0     | 438864    | 12-Mar-2019 | 10:52 | x64      |
| Isserverexec.exe                                                   | 13.0.4560.0     | 132696    | 12-Mar-2019 | 10:41 | x86      |
| Isserverexec.exe                                                   | 13.0.4560.0     | 132176    | 12-Mar-2019 | 10:52 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4560.0     | 1313360   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4560.0     | 1313360   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4560.0     | 696400    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4560.0     | 696400    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4560.0     | 763472    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4560.0     | 763472    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.applicationinsights.dll                                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 11-Mar-2019 | 20:46 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 12-Mar-2019 | 02:08  | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4560.0 | 107088    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4560.0 | 112208    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4560.0     | 54352     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4560.0     | 54352     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4560.0     | 89680     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4560.0     | 89680     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4560.0     | 43088     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4560.0     | 43088     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4560.0     | 35408     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4560.0     | 35408     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4560.0     | 31312     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4560.0     | 31312     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4560.0     | 469584    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4560.0     | 469584    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4560.0     | 43600     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4560.0     | 43600     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4560.0     | 57424     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4560.0     | 57424     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4560.0     | 52816     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4560.0     | 52816     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4560.0 | 138832    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4560.0 | 150096    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4560.0 | 144464    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4560.0 | 158800    | 12-Mar-2019 | 10:55 | x64      |
| Msdtssrvr.exe                                                      | 13.0.4560.0     | 216656    | 12-Mar-2019 | 10:52 | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4560.0 | 89680     | 12-Mar-2019 | 10:54 | x86      |
| Msdtssrvrutil.dll                                                  | 2015.130.4560.0 | 100944    | 12-Mar-2019 | 10:59 | x64      |
| Msmdpp.dll                                                         | 2015.130.4560.0 | 7647312   | 12-Mar-2019 | 10:59 | x64      |
| Oledbdest.dll                                                      | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Oledbdest.dll                                                      | 2015.130.4560.0 | 264272    | 12-Mar-2019 | 10:59 | x64      |
| Oledbsrc.dll                                                       | 2015.130.4560.0 | 235600    | 12-Mar-2019 | 10:54 | x86      |
| Oledbsrc.dll                                                       | 2015.130.4560.0 | 290896    | 12-Mar-2019 | 10:59 | x64      |
| Rawdest.dll                                                        | 2015.130.4560.0 | 168528    | 12-Mar-2019 | 10:54 | x86      |
| Rawdest.dll                                                        | 2015.130.4560.0 | 209488    | 12-Mar-2019 | 10:59 | x64      |
| Rawsource.dll                                                      | 2015.130.4560.0 | 155216    | 12-Mar-2019 | 10:54 | x86      |
| Rawsource.dll                                                      | 2015.130.4560.0 | 196688    | 12-Mar-2019 | 10:59 | x64      |
| Recordsetdest.dll                                                  | 2015.130.4560.0 | 151632    | 12-Mar-2019 | 10:54 | x86      |
| Recordsetdest.dll                                                  | 2015.130.4560.0 | 187472    | 12-Mar-2019 | 10:59 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqlceip.exe                                                        | 13.0.4560.0     | 252496    | 12-Mar-2019 | 10:52 | x86      |
| Sqldest.dll                                                        | 2015.130.4560.0 | 215632    | 12-Mar-2019 | 10:54 | x86      |
| Sqldest.dll                                                        | 2015.130.4560.0 | 263760    | 12-Mar-2019 | 10:59 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4560.0 | 180816    | 12-Mar-2019 | 10:53 | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4560.0 | 151120    | 12-Mar-2019 | 10:54 | x86      |
| Ssisoledb.dll                                                      | 2015.130.4560.0 | 216144    | 12-Mar-2019 | 10:53 | x64      |
| Ssisoledb.dll                                                      | 2015.130.4560.0 | 176720    | 12-Mar-2019 | 10:54 | x86      |
| Txagg.dll                                                          | 2015.130.4560.0 | 364624    | 12-Mar-2019 | 10:53 | x64      |
| Txagg.dll                                                          | 2015.130.4560.0 | 304720    | 12-Mar-2019 | 10:58 | x86      |
| Txbdd.dll                                                          | 2015.130.4560.0 | 172624    | 12-Mar-2019 | 10:53 | x64      |
| Txbdd.dll                                                          | 2015.130.4560.0 | 138320    | 12-Mar-2019 | 10:58 | x86      |
| Txbestmatch.dll                                                    | 2015.130.4560.0 | 611408    | 12-Mar-2019 | 10:53 | x64      |
| Txbestmatch.dll                                                    | 2015.130.4560.0 | 496208    | 12-Mar-2019 | 10:58 | x86      |
| Txcache.dll                                                        | 2015.130.4560.0 | 183376    | 12-Mar-2019 | 10:53 | x64      |
| Txcache.dll                                                        | 2015.130.4560.0 | 148048    | 12-Mar-2019 | 10:58 | x86      |
| Txcharmap.dll                                                      | 2015.130.4560.0 | 289872    | 12-Mar-2019 | 10:53 | x64      |
| Txcharmap.dll                                                      | 2015.130.4560.0 | 250448    | 12-Mar-2019 | 10:58 | x86      |
| Txcopymap.dll                                                      | 2015.130.4560.0 | 183376    | 12-Mar-2019 | 10:53 | x64      |
| Txcopymap.dll                                                      | 2015.130.4560.0 | 147536    | 12-Mar-2019 | 10:58 | x86      |
| Txdataconvert.dll                                                  | 2015.130.4560.0 | 296528    | 12-Mar-2019 | 10:53 | x64      |
| Txdataconvert.dll                                                  | 2015.130.4560.0 | 255056    | 12-Mar-2019 | 10:58 | x86      |
| Txderived.dll                                                      | 2015.130.4560.0 | 607824    | 12-Mar-2019 | 10:53 | x64      |
| Txderived.dll                                                      | 2015.130.4560.0 | 519248    | 12-Mar-2019 | 10:58 | x86      |
| Txfileextractor.dll                                                | 2015.130.4560.0 | 201808    | 12-Mar-2019 | 10:53 | x64      |
| Txfileextractor.dll                                                | 2015.130.4560.0 | 162896    | 12-Mar-2019 | 10:58 | x86      |
| Txfileinserter.dll                                                 | 2015.130.4560.0 | 199760    | 12-Mar-2019 | 10:53 | x64      |
| Txfileinserter.dll                                                 | 2015.130.4560.0 | 160848    | 12-Mar-2019 | 10:58 | x86      |
| Txgroupdups.dll                                                    | 2015.130.4560.0 | 290896    | 12-Mar-2019 | 10:53 | x64      |
| Txgroupdups.dll                                                    | 2015.130.4560.0 | 231504    | 12-Mar-2019 | 10:58 | x86      |
| Txlineage.dll                                                      | 2015.130.4560.0 | 137296    | 12-Mar-2019 | 10:53 | x64      |
| Txlineage.dll                                                      | 2015.130.4560.0 | 109136    | 12-Mar-2019 | 10:58 | x86      |
| Txlookup.dll                                                       | 2015.130.4560.0 | 532560    | 12-Mar-2019 | 10:53 | x64      |
| Txlookup.dll                                                       | 2015.130.4560.0 | 449616    | 12-Mar-2019 | 10:58 | x86      |
| Txmerge.dll                                                        | 2015.130.4560.0 | 229968    | 12-Mar-2019 | 10:53 | x64      |
| Txmerge.dll                                                        | 2015.130.4560.0 | 176208    | 12-Mar-2019 | 10:58 | x86      |
| Txmergejoin.dll                                                    | 2015.130.4560.0 | 278608    | 12-Mar-2019 | 10:53 | x64      |
| Txmergejoin.dll                                                    | 2015.130.4560.0 | 223824    | 12-Mar-2019 | 10:58 | x86      |
| Txmulticast.dll                                                    | 2015.130.4560.0 | 128592    | 12-Mar-2019 | 10:53 | x64      |
| Txmulticast.dll                                                    | 2015.130.4560.0 | 101968    | 12-Mar-2019 | 10:58 | x86      |
| Txpivot.dll                                                        | 2015.130.4560.0 | 227920    | 12-Mar-2019 | 10:53 | x64      |
| Txpivot.dll                                                        | 2015.130.4560.0 | 181840    | 12-Mar-2019 | 10:58 | x86      |
| Txrowcount.dll                                                     | 2015.130.4560.0 | 126544    | 12-Mar-2019 | 10:53 | x64      |
| Txrowcount.dll                                                     | 2015.130.4560.0 | 101456    | 12-Mar-2019 | 10:58 | x86      |
| Txsampling.dll                                                     | 2015.130.4560.0 | 172112    | 12-Mar-2019 | 10:53 | x64      |
| Txsampling.dll                                                     | 2015.130.4560.0 | 134736    | 12-Mar-2019 | 10:58 | x86      |
| Txscd.dll                                                          | 2015.130.4560.0 | 220240    | 12-Mar-2019 | 10:53 | x64      |
| Txscd.dll                                                          | 2015.130.4560.0 | 169552    | 12-Mar-2019 | 10:58 | x86      |
| Txsort.dll                                                         | 2015.130.4560.0 | 258640    | 12-Mar-2019 | 10:53 | x64      |
| Txsort.dll                                                         | 2015.130.4560.0 | 210512    | 12-Mar-2019 | 10:58 | x86      |
| Txsplit.dll                                                        | 2015.130.4560.0 | 600656    | 12-Mar-2019 | 10:53 | x64      |
| Txsplit.dll                                                        | 2015.130.4560.0 | 513616    | 12-Mar-2019 | 10:58 | x86      |
| Txtermextraction.dll                                               | 2015.130.4560.0 | 8677968   | 12-Mar-2019 | 10:53 | x64      |
| Txtermextraction.dll                                               | 2015.130.4560.0 | 8615504   | 12-Mar-2019 | 10:58 | x86      |
| Txtermlookup.dll                                                   | 2015.130.4560.0 | 4158544   | 12-Mar-2019 | 10:53 | x64      |
| Txtermlookup.dll                                                   | 2015.130.4560.0 | 4107344   | 12-Mar-2019 | 10:58 | x86      |
| Txunionall.dll                                                     | 2015.130.4560.0 | 181840    | 12-Mar-2019 | 10:53 | x64      |
| Txunionall.dll                                                     | 2015.130.4560.0 | 138832    | 12-Mar-2019 | 10:58 | x86      |
| Txunpivot.dll                                                      | 2015.130.4560.0 | 202320    | 12-Mar-2019 | 10:53 | x64      |
| Txunpivot.dll                                                      | 2015.130.4560.0 | 162384    | 12-Mar-2019 | 10:58 | x86      |
| Xe.dll                                                             | 2015.130.4560.0 | 558672    | 12-Mar-2019 | 10:54 | x86      |
| Xe.dll                                                             | 2015.130.4560.0 | 626256    | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 00:09  | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 00:09  | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 00:09  | x86      |
| Instapi130.dll                                                       | 2015.130.4560.0  | 61008     | 12-Mar-2019 | 10:53 | x64      |
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
| Mpdwinterop.dll                                                      | 2015.130.4560.0  | 394320    | 12-Mar-2019 | 10:54 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4560.0  | 6613584   | 12-Mar-2019 | 10:59 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4560.0  | 2155088   | 12-Mar-2019 | 10:53 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 00:09  | x64      |
| Sqldk.dll                                                            | 2015.130.4560.0  | 2530384   | 12-Mar-2019 | 10:53 | x64      |
| Sqldumper.exe                                                        | 2015.130.4560.0  | 127056    | 12-Mar-2019 | 10:59 | x64      |
| Sqlos.dll                                                            | 2015.130.4560.0  | 26192     | 12-Mar-2019 | 10:53 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 00:09  | x64      |
| Sqltses.dll                                                          | 2015.130.4560.0  | 9091152   | 12-Mar-2019 | 10:53 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.4560.0     | 610896    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.authorization.dll             | 13.0.4560.0     | 78928     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4560.0     | 210512    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4560.0     | 168528    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4560.0     | 1620048   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4560.0     | 657488    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4560.0     | 329808    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4560.0     | 1072208   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4560.0     | 532048    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4560.0     | 162896    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4560.0     | 76368     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4560.0     | 76368     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4560.0     | 126032    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4560.0     | 106064    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4560.0     | 5959248   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420176   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420688   | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4421200   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420688   | 12-Mar-2019 | 10:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4421200   | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4421200   | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420688   | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4421712   | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420176   | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4560.0     | 4420688   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4560.0     | 10886224  | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4560.0     | 100944    | 12-Mar-2019 | 10:52 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4560.0     | 72784     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4560.0     | 5951568   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4560.0     | 245840    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4560.0     | 298064    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4560.0     | 208464    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 44624     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 52816     | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 52816     | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 44624     | 12-Mar-2019 | 10:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4560.0     | 48720     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4560.0     | 510544    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4560.0 | 47696     | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4560.0     | 496720    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4560.0 | 396880    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4560.0 | 391760    | 12-Mar-2019 | 10:55 | x86      |
| Msmdlocal.dll                                             | 2015.130.4560.0 | 37103184  | 12-Mar-2019 | 10:54 | x86      |
| Msmdlocal.dll                                             | 2015.130.4560.0 | 56207952  | 12-Mar-2019 | 10:59 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4560.0 | 7507024   | 12-Mar-2019 | 10:53 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4560.0 | 6507600   | 12-Mar-2019 | 10:53 | x86      |
| Msolap130.dll                                             | 2015.130.4560.0 | 7008336   | 12-Mar-2019 | 10:54 | x86      |
| Msolap130.dll                                             | 2015.130.4560.0 | 8639568   | 12-Mar-2019 | 10:59 | x64      |
| Msolui130.dll                                             | 2015.130.4560.0 | 287312    | 12-Mar-2019 | 10:54 | x86      |
| Msolui130.dll                                             | 2015.130.4560.0 | 310352    | 12-Mar-2019 | 10:59 | x64      |
| Reportingservicescompression.dll                          | 2015.130.4560.0 | 62544     | 12-Mar-2019 | 10:59 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4560.0     | 84560     | 12-Mar-2019 | 10:53 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4560.0     | 2543696   | 12-Mar-2019 | 10:53 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4560.0 | 108624    | 12-Mar-2019 | 10:53 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4560.0 | 114256    | 12-Mar-2019 | 10:53 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4560.0 | 98896     | 12-Mar-2019 | 10:53 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4560.0 | 2573392   | 12-Mar-2019 | 10:53 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4560.0     | 2710608   | 12-Mar-2019 | 10:53 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 867920    | 12-Mar-2019 | 10:54 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:54 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 876112    | 12-Mar-2019 | 10:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:54 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 884304    | 12-Mar-2019 | 10:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 867920    | 12-Mar-2019 | 10:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4560.0     | 872016    | 12-Mar-2019 | 10:54 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4560.0 | 3590736   | 12-Mar-2019 | 10:54 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4560.0 | 3662928   | 12-Mar-2019 | 10:59 | x64      |
| Rsconfigtool.exe                                          | 13.0.4560.0     | 1405520   | 12-Mar-2019 | 10:53 | x86      |
| Rsctr.dll                                                 | 2015.130.4560.0 | 51280     | 12-Mar-2019 | 10:54 | x86      |
| Rsctr.dll                                                 | 2015.130.4560.0 | 58448     | 12-Mar-2019 | 10:59 | x64      |
| Rshttpruntime.dll                                         | 2015.130.4560.0 | 99408     | 12-Mar-2019 | 10:53 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqldumper.exe                                             | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                                             | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:58 | x64      |
| Sqlrsos.dll                                               | 2015.130.4560.0 | 26192     | 12-Mar-2019 | 10:53 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4560.0 | 584272    | 12-Mar-2019 | 10:54 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.4560.0 | 732752    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                                 | 2015.130.4560.0 | 319056    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                                 | 2015.130.4560.0 | 259664    | 12-Mar-2019 | 10:58 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4560.0 | 227408    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4560.0 | 191568    | 12-Mar-2019 | 10:58 | x86      |
| Xmsrv.dll                                                 | 2015.130.4560.0 | 24050768  | 12-Mar-2019 | 10:53 | x64      |
| Xmsrv.dll                                                 | 2015.130.4560.0 | 32727632  | 12-Mar-2019 | 10:54 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time  | Platform |
|------------------------------------|-----------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 13.0.4560.0     | 23632     | 12-Mar-2019 | 10:53 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                   | 2015.130.4560.0 | 1311824   | 12-Mar-2019 | 10:54 | x86      |
| Ddsshapes.dll                                   | 2015.130.4560.0 | 135760    | 12-Mar-2019 | 10:54 | x86      |
| Dtaengine.exe                                   | 2015.130.4560.0 | 166992    | 12-Mar-2019 | 10:54 | x86      |
| Dteparse.dll                                    | 2015.130.4560.0 | 99408     | 12-Mar-2019 | 10:54 | x86      |
| Dteparse.dll                                    | 2015.130.4560.0 | 109648    | 12-Mar-2019 | 10:58 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4560.0 | 83536     | 12-Mar-2019 | 10:53 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4560.0 | 88656     | 12-Mar-2019 | 10:55 | x64      |
| Dtepkg.dll                                      | 2015.130.4560.0 | 115792    | 12-Mar-2019 | 10:54 | x86      |
| Dtepkg.dll                                      | 2015.130.4560.0 | 137296    | 12-Mar-2019 | 10:58 | x64      |
| Dtexec.exe                                      | 2015.130.4560.0 | 72784     | 12-Mar-2019 | 10:53 | x64      |
| Dtexec.exe                                      | 2015.130.4560.0 | 66640     | 12-Mar-2019 | 10:54 | x86      |
| Dts.dll                                         | 2015.130.4560.0 | 2632784   | 12-Mar-2019 | 10:54 | x86      |
| Dts.dll                                         | 2015.130.4560.0 | 3146832   | 12-Mar-2019 | 10:58 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4560.0 | 418896    | 12-Mar-2019 | 10:54 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4560.0 | 477264    | 12-Mar-2019 | 10:58 | x64      |
| Dtsconn.dll                                     | 2015.130.4560.0 | 392272    | 12-Mar-2019 | 10:54 | x86      |
| Dtsconn.dll                                     | 2015.130.4560.0 | 492624    | 12-Mar-2019 | 10:58 | x64      |
| Dtshost.exe                                     | 2015.130.4560.0 | 86608     | 12-Mar-2019 | 10:53 | x64      |
| Dtshost.exe                                     | 2015.130.4560.0 | 76368     | 12-Mar-2019 | 10:54 | x86      |
| Dtslog.dll                                      | 2015.130.4560.0 | 102992    | 12-Mar-2019 | 10:54 | x86      |
| Dtslog.dll                                      | 2015.130.4560.0 | 120400    | 12-Mar-2019 | 10:58 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4560.0 | 541264    | 12-Mar-2019 | 10:54 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4560.0 | 545360    | 12-Mar-2019 | 10:58 | x64      |
| Dtspipeline.dll                                 | 2015.130.4560.0 | 1059408   | 12-Mar-2019 | 10:54 | x86      |
| Dtspipeline.dll                                 | 2015.130.4560.0 | 1279056   | 12-Mar-2019 | 10:58 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4560.0 | 42064     | 12-Mar-2019 | 10:54 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4560.0 | 48208     | 12-Mar-2019 | 10:58 | x64      |
| Dtswizard.exe                                   | 13.0.4560.0     | 896088    | 12-Mar-2019 | 10:41 | x86      |
| Dtswizard.exe                                   | 13.0.4560.0     | 895568    | 12-Mar-2019 | 10:52 | x64      |
| Dtuparse.dll                                    | 2015.130.4560.0 | 79952     | 12-Mar-2019 | 10:54 | x86      |
| Dtuparse.dll                                    | 2015.130.4560.0 | 87632     | 12-Mar-2019 | 10:58 | x64      |
| Dtutil.exe                                      | 2015.130.4560.0 | 134736    | 12-Mar-2019 | 10:53 | x64      |
| Dtutil.exe                                      | 2015.130.4560.0 | 115280    | 12-Mar-2019 | 10:54 | x86      |
| Exceldest.dll                                   | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Exceldest.dll                                   | 2015.130.4560.0 | 263760    | 12-Mar-2019 | 10:58 | x64      |
| Excelsrc.dll                                    | 2015.130.4560.0 | 232528    | 12-Mar-2019 | 10:54 | x86      |
| Excelsrc.dll                                    | 2015.130.4560.0 | 285264    | 12-Mar-2019 | 10:58 | x64      |
| Flatfiledest.dll                                | 2015.130.4560.0 | 334416    | 12-Mar-2019 | 10:54 | x86      |
| Flatfiledest.dll                                | 2015.130.4560.0 | 389200    | 12-Mar-2019 | 10:58 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4560.0 | 345168    | 12-Mar-2019 | 10:54 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4560.0 | 401488    | 12-Mar-2019 | 10:58 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4560.0 | 80464     | 12-Mar-2019 | 10:54 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4560.0 | 96336     | 12-Mar-2019 | 10:58 | x64      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4560.0     | 92240     | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4560.0     | 1313360   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4560.0     | 696400    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4560.0     | 763472    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4560.0 | 2022992   | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4560.0 | 42064     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4560.0     | 73296     | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4560.0     | 186448    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4560.0     | 435792    | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4560.0     | 435792    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4560.0     | 2044496   | 12-Mar-2019 | 10:54 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4560.0     | 2044496   | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4560.0     | 33360     | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4560.0     | 33360     | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4560.0     | 249424    | 12-Mar-2019 | 10:55 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4560.0     | 249424    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4560.0     | 501840    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:53 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4560.0     | 606288    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4560.0     | 106064    | 12-Mar-2019 | 10:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4560.0 | 138832    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4560.0 | 150096    | 12-Mar-2019 | 10:55 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4560.0 | 144464    | 12-Mar-2019 | 10:52 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4560.0 | 158800    | 12-Mar-2019 | 10:55 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4560.0 | 89680     | 12-Mar-2019 | 10:54 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4560.0 | 100944    | 12-Mar-2019 | 10:59 | x64      |
| Msmdlocal.dll                                   | 2015.130.4560.0 | 37103184  | 12-Mar-2019 | 10:54 | x86      |
| Msmdlocal.dll                                   | 2015.130.4560.0 | 56207952  | 12-Mar-2019 | 10:59 | x64      |
| Msmdpp.dll                                      | 2015.130.4560.0 | 6370384   | 12-Mar-2019 | 10:54 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4560.0 | 7507024   | 12-Mar-2019 | 10:53 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4560.0 | 6507600   | 12-Mar-2019 | 10:53 | x86      |
| Msolap130.dll                                   | 2015.130.4560.0 | 7008336   | 12-Mar-2019 | 10:54 | x86      |
| Msolap130.dll                                   | 2015.130.4560.0 | 8639568   | 12-Mar-2019 | 10:59 | x64      |
| Msolui130.dll                                   | 2015.130.4560.0 | 287312    | 12-Mar-2019 | 10:54 | x86      |
| Msolui130.dll                                   | 2015.130.4560.0 | 310352    | 12-Mar-2019 | 10:59 | x64      |
| Oledbdest.dll                                   | 2015.130.4560.0 | 216656    | 12-Mar-2019 | 10:54 | x86      |
| Oledbdest.dll                                   | 2015.130.4560.0 | 264272    | 12-Mar-2019 | 10:59 | x64      |
| Oledbsrc.dll                                    | 2015.130.4560.0 | 235600    | 12-Mar-2019 | 10:54 | x86      |
| Oledbsrc.dll                                    | 2015.130.4560.0 | 290896    | 12-Mar-2019 | 10:59 | x64      |
| Profiler.exe                                    | 2015.130.4560.0 | 804432    | 12-Mar-2019 | 10:53 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4560.0 | 100432    | 12-Mar-2019 | 10:58 | x64      |
| Sqldumper.exe                                   | 2015.130.4560.0 | 107600    | 12-Mar-2019 | 10:54 | x86      |
| Sqldumper.exe                                   | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:58 | x64      |
| Sqlresld.dll                                    | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresld.dll                                    | 2015.130.4560.0 | 28752     | 12-Mar-2019 | 10:54 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4560.0 | 30800     | 12-Mar-2019 | 10:53 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4560.0 | 28240     | 12-Mar-2019 | 10:54 | x86      |
| Sqlscm.dll                                      | 2015.130.4560.0 | 52816     | 12-Mar-2019 | 10:54 | x86      |
| Sqlscm.dll                                      | 2015.130.4560.0 | 61008     | 12-Mar-2019 | 10:58 | x64      |
| Sqlsvc.dll                                      | 2015.130.4560.0 | 152144    | 12-Mar-2019 | 10:53 | x64      |
| Sqlsvc.dll                                      | 2015.130.4560.0 | 127056    | 12-Mar-2019 | 10:54 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4560.0 | 180816    | 12-Mar-2019 | 10:53 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4560.0 | 151120    | 12-Mar-2019 | 10:54 | x86      |
| Txdataconvert.dll                               | 2015.130.4560.0 | 296528    | 12-Mar-2019 | 10:53 | x64      |
| Txdataconvert.dll                               | 2015.130.4560.0 | 255056    | 12-Mar-2019 | 10:58 | x86      |
| Xe.dll                                          | 2015.130.4560.0 | 558672    | 12-Mar-2019 | 10:54 | x86      |
| Xe.dll                                          | 2015.130.4560.0 | 626256    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                       | 2015.130.4560.0 | 319056    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrw.dll                                       | 2015.130.4560.0 | 259664    | 12-Mar-2019 | 10:58 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4560.0 | 227408    | 12-Mar-2019 | 10:58 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4560.0 | 191568    | 12-Mar-2019 | 10:58 | x86      |
| Xmsrv.dll                                       | 2015.130.4560.0 | 24050768  | 12-Mar-2019 | 10:53 | x64      |
| Xmsrv.dll                                       | 2015.130.4560.0 | 32727632  | 12-Mar-2019 | 10:58 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
