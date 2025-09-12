---
title: Cumulative update 15 for SQL Server 2016 SP1 (KB4495257)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 15 (KB4495257).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4495257
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
---

# KB4495257 - Cumulative Update 15 for SQL Server 2016 SP1

_Release Date:_ &nbsp; May 16, 2019  
_Version:_ &nbsp; 13.0.4574.0

This article describes cumulative update package 15 (build number: 13.0.4574.0) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description| Fix area |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
| <a id=12865855>[12865855](#12865855) </a> | [FIX: SQL jobs fail due to blocking in SSISDB in SQL Server 2014 and 2016 (KB4338636)](https://support.microsoft.com/help/4338636) | Integration Services |
| <a id=12822162>[12822162](#12822162) </a> | [FIX: Filtered index may be corrupted when you rebuild index in parallel in SQL Server 2014 and 2016 (KB4489150)](https://support.microsoft.com/help/4489150)| SQL performance|
| <a id=12639822>[12639822](#12639822) </a> | [FIX: Manual failover between forwarder and secondary replica fails with all replicas synchronized in SQL Server 2016 (KB4492604)](https://support.microsoft.com/help/4492604) | High Availability|
| <a id=12816587>[12816587](#12816587) </a> | [FIX: Query against table with both clustered columnstore index and nonclustered rowstore index may return incorrect results in SQL Server 2016 (KB4497225)](https://support.microsoft.com/help/4497225) | SQL Engine |
| <a id=12865859>[12865859](#12865859) </a> | [FIX: Fail to join the secondary replica if the database has a defunct filegroup in SQL Server 2014 and 2016 (KB4497230)](https://support.microsoft.com/help/4497230)| High Availability|
| <a id=12865875>[12865875](#12865875) </a> | [FIX: Columnstore filter pushdown may return wrong results when there is an overflow in filter expressions in SQL Server 2014 and 2016 (KB4497701)](https://support.microsoft.com/help/4497701)| SQL Engine |
| <a id=12865872>[12865872](#12865872) </a> | [FIX: Log reader agent may fail after AG failover with TF 1448 enabled in SQL Server 2014 and 2016 (KB4499231)](https://support.microsoft.com/help/4499231)| SQL Engine |

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
| Instapi130.dll         | 2015.130.4574.0 | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Msmdredir.dll          | 2015.130.4574.0 | 6422104   | 28-Apr-2019 | 02:13 | x86      |
| Msmdsrv.rll            | 2015.130.4574.0 | 1296472   | 28-Apr-2019 | 02:18 | x86      |
| Msmdsrvi.rll           | 2015.130.4574.0 | 1293400   | 28-Apr-2019 | 02:21 | x86      |
| Sqlbrowser.exe         | 2015.130.4574.0 | 276576    | 28-Apr-2019 | 02:20 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4574.0 | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Sqldumper.exe          | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4574.0  | 160344    | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                              | 2015.130.4574.0  | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Isacctchange.dll                            | 2015.130.4574.0  | 29272     | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4574.0      | 1027376   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4574.0      | 1348912   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4574.0      | 702560    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4574.0      | 765528    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4574.0      | 521008    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4574.0      | 711768    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4574.0      | 36960     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4574.0      | 46176     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4574.0  | 72800     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4574.0      | 598624    | 28-Apr-2019 | 02:11 | x86      |
| Msasxpress.dll                              | 2015.130.4574.0  | 31832     | 28-Apr-2019 | 02:13 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4574.0  | 59992     | 28-Apr-2019 | 02:13 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4574.0  | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Sqldumper.exe                               | 2015.130.4574.0  | 107608    | 28-Apr-2019 | 02:15 | x86      |
| Sqlftacct.dll                               | 2015.130.4574.0  | 46688     | 28-Apr-2019 | 02:12 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4574.0  | 364128    | 28-Apr-2019 | 02:12 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4574.0  | 34912     | 28-Apr-2019 | 02:12 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4574.0  | 267360    | 28-Apr-2019 | 02:12 | x86      |
| Sqltdiagn.dll                               | 2015.130.4574.0  | 60720     | 28-Apr-2019 | 02:12 | x86      |
| Svrenumapi130.dll                           | 2015.130.4574.0  | 854104    | 28-Apr-2019 | 02:13 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4574.0  | 1876568   | 28-Apr-2019 | 02:15 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4574.0 | 120920    | 28-Apr-2019 | 02:17 | x86      |
| Dreplaycommon.dll              | 2015.130.4574.0 | 690992    | 28-Apr-2019 | 02:11 | x86      |
| Dreplayserverps.dll            | 2015.130.4574.0 | 32856     | 28-Apr-2019 | 02:15 | x86      |
| Dreplayutil.dll                | 2015.130.4574.0 | 309848    | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                 | 2015.130.4574.0 | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4574.0 | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Sqlresourceloader.dll          | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4574.0 | 690992    | 28-Apr-2019 | 02:11 | x86      |
| Dreplaycontroller.exe              | 2015.130.4574.0 | 350504    | 28-Apr-2019 | 02:17 | x86      |
| Dreplayprocess.dll                 | 2015.130.4574.0 | 171608    | 28-Apr-2019 | 02:15 | x86      |
| Dreplayserverps.dll                | 2015.130.4574.0 | 32856     | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                     | 2015.130.4574.0 | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4574.0 | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Sqlresourceloader.dll              | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4574.0 | 1312048   | 28-Apr-2019 | 02:16 | x86      |
| Ddsshapes.dll                                   | 2015.130.4574.0 | 135768    | 28-Apr-2019 | 02:15 | x86      |
| Dtaengine.exe                                   | 2015.130.4574.0 | 167000    | 28-Apr-2019 | 02:17 | x86      |
| Dteparse.dll                                    | 2015.130.4574.0 | 99416     | 28-Apr-2019 | 02:15 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4574.0 | 83552     | 28-Apr-2019 | 02:12 | x86      |
| Dtepkg.dll                                      | 2015.130.4574.0 | 115808    | 28-Apr-2019 | 02:15 | x86      |
| Dtexec.exe                                      | 2015.130.4574.0 | 66648     | 28-Apr-2019 | 02:17 | x86      |
| Dts.dll                                         | 2015.130.4574.0 | 2633008   | 28-Apr-2019 | 02:16 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4574.0 | 418904    | 28-Apr-2019 | 02:15 | x86      |
| Dtsconn.dll                                     | 2015.130.4574.0 | 392280    | 28-Apr-2019 | 02:15 | x86      |
| Dtshost.exe                                     | 2015.130.4574.0 | 76376     | 28-Apr-2019 | 02:17 | x86      |
| Dtslog.dll                                      | 2015.130.4574.0 | 103008    | 28-Apr-2019 | 02:15 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4574.0 | 541488    | 28-Apr-2019 | 02:16 | x86      |
| Dtspipeline.dll                                 | 2015.130.4574.0 | 1059632   | 28-Apr-2019 | 02:16 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4574.0 | 42288     | 28-Apr-2019 | 02:16 | x86      |
| Dtswizard.exe                                   | 13.0.4574.0     | 896304    | 28-Apr-2019 | 01:57 | x86      |
| Dtuparse.dll                                    | 2015.130.4574.0 | 79960     | 28-Apr-2019 | 02:15 | x86      |
| Dtutil.exe                                      | 2015.130.4574.0 | 115288    | 28-Apr-2019 | 02:17 | x86      |
| Exceldest.dll                                   | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:15 | x86      |
| Excelsrc.dll                                    | 2015.130.4574.0 | 232544    | 28-Apr-2019 | 02:15 | x86      |
| Flatfiledest.dll                                | 2015.130.4574.0 | 334632    | 28-Apr-2019 | 02:15 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4574.0 | 345176    | 28-Apr-2019 | 02:15 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4574.0 | 80472     | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4574.0     | 92256     | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4574.0     | 1313608   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4574.0     | 696416    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4574.0     | 763480    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4574.0 | 2023000   | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4574.0 | 42288     | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4574.0     | 71256     | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4574.0     | 186456    | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4574.0     | 435808    | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4574.0     | 2044720   | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4574.0     | 33376     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4574.0     | 249440    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4574.0     | 491312    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4574.0     | 606512    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4574.0     | 106288    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4574.0 | 139056    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4574.0 | 144472    | 28-Apr-2019 | 02:16 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4574.0 | 89688     | 28-Apr-2019 | 02:13 | x86      |
| Msmdlocal.dll                                   | 2015.130.4574.0 | 37103192  | 28-Apr-2019 | 02:13 | x86      |
| Msmdpp.dll                                      | 2015.130.4574.0 | 6370392   | 28-Apr-2019 | 02:13 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4574.0 | 6507824   | 28-Apr-2019 | 02:17 | x86      |
| Msolap130.dll                                   | 2015.130.4574.0 | 7008344   | 28-Apr-2019 | 02:13 | x86      |
| Msolui130.dll                                   | 2015.130.4574.0 | 287320    | 28-Apr-2019 | 02:13 | x86      |
| Oledbdest.dll                                   | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:13 | x86      |
| Oledbsrc.dll                                    | 2015.130.4574.0 | 235608    | 28-Apr-2019 | 02:13 | x86      |
| Profiler.exe                                    | 2015.130.4574.0 | 804656    | 28-Apr-2019 | 02:11 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4574.0 | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Sqldumper.exe                                   | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15 | x86      |
| Sqlresld.dll                                    | 2015.130.4574.0 | 28768     | 28-Apr-2019 | 02:12 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |
| Sqlscm.dll                                      | 2015.130.4574.0 | 52832     | 28-Apr-2019 | 02:12 | x86      |
| Sqlsvc.dll                                      | 2015.130.4574.0 | 127072    | 28-Apr-2019 | 02:12 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4574.0 | 151344    | 28-Apr-2019 | 02:12 | x86      |
| Txdataconvert.dll                               | 2015.130.4574.0 | 255072    | 28-Apr-2019 | 02:19 | x86      |
| Xe.dll                                          | 2015.130.4574.0 | 558688    | 28-Apr-2019 | 02:20 | x86      |
| Xmlrw.dll                                       | 2015.130.4574.0 | 259680    | 28-Apr-2019 | 02:19 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4574.0 | 191792    | 28-Apr-2019 | 02:19 | x86      |
| Xmsrv.dll                                       | 2015.130.4574.0 | 32727856  | 28-Apr-2019 | 02:21 | x86      |

**x64-based versions**

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4574.0 | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Keyfile.dll    | 2015.130.4574.0 | 88664     | 28-Apr-2019 | 02:13 | x86      |
| Msmdredir.dll  | 2015.130.4574.0 | 6422104   | 28-Apr-2019 | 02:13 | x86      |
| Msmdsrv.rll    | 2015.130.4574.0 | 1296472   | 28-Apr-2019 | 02:18 | x86      |
| Msmdsrvi.rll   | 2015.130.4574.0 | 1293400   | 28-Apr-2019 | 02:21 | x86      |
| Sqlbrowser.exe | 2015.130.4574.0 | 276576    | 28-Apr-2019 | 02:20 | x86      |
| Sqldumper.exe  | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4574.0 | 61016     | 28-Apr-2019 | 02:15 | x64      |
| Sqlboot.dll           | 2015.130.4574.0 | 186672    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe         | 2015.130.4574.0 | 127280    | 28-Apr-2019 | 02:13 | x64      |
| Sqlvdi.dll            | 2015.130.4574.0 | 168544    | 28-Apr-2019 | 02:12 | x86      |
| Sqlvdi.dll            | 2015.130.4574.0 | 197424    | 28-Apr-2019 | 02:15 | x64      |
| Sqlwriter.exe         | 2015.130.4574.0 | 131912    | 28-Apr-2019 | 02:10 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqlwvss.dll           | 2015.130.4574.0 | 340568    | 28-Apr-2019 | 02:02 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4574.0 | 26416     | 28-Apr-2019 | 02:02 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4574.0     | 1347888   | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4574.0     | 765768    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4574.0     | 521520    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4574.0     | 990000    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4574.0     | 990000    | 28-Apr-2019 | 02:21  | x86      |
| Msmdctr130.dll                                     | 2015.130.4574.0 | 40024     | 28-Apr-2019 | 02:12  | x64      |
| Msmdlocal.dll                                      | 2015.130.4574.0 | 37103192  | 28-Apr-2019 | 02:13  | x86      |
| Msmdlocal.dll                                      | 2015.130.4574.0 | 56207960  | 28-Apr-2019 | 02:17  | x64      |
| Msmdpump.dll                                       | 2015.130.4574.0 | 7799384   | 28-Apr-2019 | 02:12  | x64      |
| Msmdredir.dll                                      | 2015.130.4574.0 | 6422104   | 28-Apr-2019 | 02:13  | x86      |
| Msmdsrv.exe                                        | 2015.130.4574.0 | 56747104  | 28-Apr-2019 | 02:12  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4574.0 | 6507824   | 28-Apr-2019 | 02:17  | x86      |
| Msmgdsrv.dll                                       | 2015.130.4574.0 | 7507032   | 28-Apr-2019 | 02:18  | x64      |
| Msolap130.dll                                      | 2015.130.4574.0 | 7008344   | 28-Apr-2019 | 02:13  | x86      |
| Msolap130.dll                                      | 2015.130.4574.0 | 8639584   | 28-Apr-2019 | 02:13  | x64      |
| Msolui130.dll                                      | 2015.130.4574.0 | 310360    | 28-Apr-2019 | 02:12  | x64      |
| Msolui130.dll                                      | 2015.130.4574.0 | 287320    | 28-Apr-2019 | 02:13  | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13  | x64      |
| Sqlboot.dll                                        | 2015.130.4574.0 | 186672    | 28-Apr-2019 | 02:13  | x64      |
| Sqlceip.exe                                        | 13.0.4574.0     | 252512    | 28-Apr-2019 | 02:13  | x86      |
| Sqldumper.exe                                      | 2015.130.4574.0 | 127280    | 28-Apr-2019 | 02:13  | x64      |
| Sqldumper.exe                                      | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15  | x86      |
| Tmapi.dll                                          | 2015.130.4574.0 | 4345944   | 28-Apr-2019 | 02:02  | x64      |
| Tmcachemgr.dll                                     | 2015.130.4574.0 | 2826328   | 28-Apr-2019 | 02:02  | x64      |
| Tmpersistence.dll                                  | 2015.130.4574.0 | 1071408   | 28-Apr-2019 | 02:02  | x64      |
| Tmtransactions.dll                                 | 2015.130.4574.0 | 1352280   | 28-Apr-2019 | 02:02  | x64      |
| Xe.dll                                             | 2015.130.4574.0 | 626264    | 28-Apr-2019 | 02:15  | x64      |
| Xmlrw.dll                                          | 2015.130.4574.0 | 319072    | 28-Apr-2019 | 02:14  | x64      |
| Xmlrw.dll                                          | 2015.130.4574.0 | 259680    | 28-Apr-2019 | 02:19  | x86      |
| Xmlrwbin.dll                                       | 2015.130.4574.0 | 227416    | 28-Apr-2019 | 02:15  | x64      |
| Xmlrwbin.dll                                       | 2015.130.4574.0 | 191792    | 28-Apr-2019 | 02:19  | x86      |
| Xmsrv.dll                                          | 2015.130.4574.0 | 24050776  | 28-Apr-2019 | 02:02  | x64      |
| Xmsrv.dll                                          | 2015.130.4574.0 | 32727856  | 28-Apr-2019 | 02:21  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4574.0  | 180832    | 28-Apr-2019 | 02:14 | x64      |
| Batchparser.dll                             | 2015.130.4574.0  | 160344    | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                              | 2015.130.4574.0  | 61016     | 28-Apr-2019 | 02:15 | x64      |
| Instapi130.dll                              | 2015.130.4574.0  | 53336     | 28-Apr-2019 | 02:21 | x86      |
| Isacctchange.dll                            | 2015.130.4574.0  | 30816     | 28-Apr-2019 | 02:13 | x64      |
| Isacctchange.dll                            | 2015.130.4574.0  | 29272     | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4574.0      | 1027376   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4574.0      | 1027376   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4574.0      | 1348912   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4574.0      | 702560    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4574.0      | 765528    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4574.0      | 521008    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4574.0      | 711768    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4574.0      | 711984    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4574.0      | 36960     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4574.0      | 46176     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4574.0  | 72800     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4574.0  | 75568     | 28-Apr-2019 | 02:16 | x64      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4574.0      | 598624    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4574.0      | 598824    | 28-Apr-2019 | 02:17 | x86      |
| Msasxpress.dll                              | 2015.130.4574.0  | 35928     | 28-Apr-2019 | 02:12 | x64      |
| Msasxpress.dll                              | 2015.130.4574.0  | 31832     | 28-Apr-2019 | 02:13 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4574.0  | 59992     | 28-Apr-2019 | 02:13 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4574.0  | 73008     | 28-Apr-2019 | 02:13 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4574.0  | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                               | 2015.130.4574.0  | 127280    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                               | 2015.130.4574.0  | 107608    | 28-Apr-2019 | 02:15 | x86      |
| Sqlftacct.dll                               | 2015.130.4574.0  | 46688     | 28-Apr-2019 | 02:12 | x86      |
| Sqlftacct.dll                               | 2015.130.4574.0  | 52016     | 28-Apr-2019 | 02:14 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 04:18 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4574.0  | 404272    | 28-Apr-2019 | 02:02 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4574.0  | 364128    | 28-Apr-2019 | 02:12 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4574.0  | 37464     | 28-Apr-2019 | 02:02 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4574.0  | 34912     | 28-Apr-2019 | 02:12 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4574.0  | 349488    | 28-Apr-2019 | 02:02 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4574.0  | 267360    | 28-Apr-2019 | 02:12 | x86      |
| Sqltdiagn.dll                               | 2015.130.4574.0  | 67672     | 28-Apr-2019 | 02:02 | x64      |
| Sqltdiagn.dll                               | 2015.130.4574.0  | 60720     | 28-Apr-2019 | 02:12 | x86      |
| Svrenumapi130.dll                           | 2015.130.4574.0  | 1115736   | 28-Apr-2019 | 02:02 | x64      |
| Svrenumapi130.dll                           | 2015.130.4574.0  | 854104    | 28-Apr-2019 | 02:13 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4574.0  | 1876568   | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4574.0  | 1876568   | 28-Apr-2019 | 02:17 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4574.0 | 120920    | 28-Apr-2019 | 02:17 | x86      |
| Dreplaycommon.dll              | 2015.130.4574.0 | 690992    | 28-Apr-2019 | 02:11 | x86      |
| Dreplayserverps.dll            | 2015.130.4574.0 | 32856     | 28-Apr-2019 | 02:15 | x86      |
| Dreplayutil.dll                | 2015.130.4574.0 | 309848    | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                 | 2015.130.4574.0 | 61016     | 28-Apr-2019 | 02:15 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqlresourceloader.dll          | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4574.0 | 690992    | 28-Apr-2019 | 02:11 | x86      |
| Dreplaycontroller.exe              | 2015.130.4574.0 | 350504    | 28-Apr-2019 | 02:17 | x86      |
| Dreplayprocess.dll                 | 2015.130.4574.0 | 171608    | 28-Apr-2019 | 02:15 | x86      |
| Dreplayserverps.dll                | 2015.130.4574.0 | 32856     | 28-Apr-2019 | 02:15 | x86      |
| Instapi130.dll                     | 2015.130.4574.0 | 61016     | 28-Apr-2019 | 02:15 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqlresourceloader.dll              | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4574.0     | 41048     | 28-Apr-2019 | 02:10  | x64      |
| Batchparser.dll                              | 2015.130.4574.0 | 180832    | 28-Apr-2019 | 02:14  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925272    | 28-Apr-2019 | 02:17  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341272   | 28-Apr-2019 | 02:17  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192088    | 28-Apr-2019 | 02:14  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4574.0 | 225584    | 28-Apr-2019 | 02:13  | x64      |
| Dcexec.exe                                   | 2015.130.4574.0 | 74544     | 28-Apr-2019 | 02:10  | x64      |
| Fssres.dll                                   | 2015.130.4574.0 | 81504     | 28-Apr-2019 | 02:12  | x64      |
| Hadrres.dll                                  | 2015.130.4574.0 | 177760    | 28-Apr-2019 | 02:14  | x64      |
| Hkcompile.dll                                | 2015.130.4574.0 | 1298224   | 28-Apr-2019 | 02:14  | x64      |
| Hkengine.dll                                 | 2015.130.4574.0 | 5600856   | 28-Apr-2019 | 02:17  | x64      |
| Hkruntime.dll                                | 2015.130.4574.0 | 158808    | 28-Apr-2019 | 02:17  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017640   | 28-Apr-2019 | 02:13  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4574.0     | 234072    | 28-Apr-2019 | 02:15  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4574.0     | 79448     | 28-Apr-2019 | 02:15  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4574.0 | 391768    | 28-Apr-2019 | 02:18  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4574.0 | 72280     | 28-Apr-2019 | 02:17  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4574.0 | 65328     | 28-Apr-2019 | 02:17  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4574.0 | 150104    | 28-Apr-2019 | 02:17  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4574.0 | 159024    | 28-Apr-2019 | 02:16  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4574.0 | 271960    | 28-Apr-2019 | 02:18  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4574.0 | 74840     | 28-Apr-2019 | 02:19  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129624    | 28-Apr-2019 | 02:17  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559192    | 28-Apr-2019 | 02:17  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559192    | 28-Apr-2019 | 02:17  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661080    | 28-Apr-2019 | 02:17  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964696    | 28-Apr-2019 | 02:17  | x64      |
| Odsole70.dll                                 | 2015.130.4574.0 | 92768     | 28-Apr-2019 | 02:12  | x64      |
| Opends60.dll                                 | 2015.130.4574.0 | 32864     | 28-Apr-2019 | 02:14  | x64      |
| Qds.dll                                      | 2015.130.4574.0 | 845400    | 28-Apr-2019 | 02:13  | x64      |
| Rsfxft.dll                                   | 2015.130.4574.0 | 34400     | 28-Apr-2019 | 02:14  | x64      |
| Sqagtres.dll                                 | 2015.130.4574.0 | 64816     | 28-Apr-2019 | 02:13  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13  | x64      |
| Sqlaamss.dll                                 | 2015.130.4574.0 | 80688     | 28-Apr-2019 | 02:19  | x64      |
| Sqlaccess.dll                                | 2015.130.4574.0 | 462640    | 28-Apr-2019 | 02:17  | x64      |
| Sqlagent.exe                                 | 2015.130.4574.0 | 566576    | 28-Apr-2019 | 02:12  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4574.0 | 44128     | 28-Apr-2019 | 02:12  | x86      |
| Sqlagentctr130.dll                           | 2015.130.4574.0 | 52016     | 28-Apr-2019 | 02:13  | x64      |
| Sqlagentlog.dll                              | 2015.130.4574.0 | 32856     | 28-Apr-2019 | 02:12  | x64      |
| Sqlagentmail.dll                             | 2015.130.4574.0 | 47920     | 28-Apr-2019 | 02:15  | x64      |
| Sqlboot.dll                                  | 2015.130.4574.0 | 186672    | 28-Apr-2019 | 02:13  | x64      |
| Sqlceip.exe                                  | 13.0.4574.0     | 252512    | 28-Apr-2019 | 02:13  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4574.0 | 60000     | 28-Apr-2019 | 02:12  | x64      |
| Sqlctr130.dll                                | 2015.130.4574.0 | 103520    | 28-Apr-2019 | 02:13  | x86      |
| Sqlctr130.dll                                | 2015.130.4574.0 | 118576    | 28-Apr-2019 | 02:14  | x64      |
| Sqldk.dll                                    | 2015.130.4574.0 | 2586712   | 28-Apr-2019 | 02:12  | x64      |
| Sqldtsss.dll                                 | 2015.130.4574.0 | 97584     | 28-Apr-2019 | 02:16  | x64      |
| Sqliosim.com                                 | 2015.130.4574.0 | 308016    | 28-Apr-2019 | 02:16  | x64      |
| Sqliosim.exe                                 | 2015.130.4574.0 | 3014448   | 28-Apr-2019 | 02:11  | x64      |
| Sqllang.dll                                  | 2015.130.4574.0 | 39458904  | 28-Apr-2019 | 02:18  | x64      |
| Sqlmin.dll                                   | 2015.130.4574.0 | 37712712  | 28-Apr-2019 | 02:02  | x64      |
| Sqlolapss.dll                                | 2015.130.4574.0 | 98096     | 28-Apr-2019 | 02:16  | x64      |
| Sqlos.dll                                    | 2015.130.4574.0 | 26416     | 28-Apr-2019 | 02:14  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4574.0 | 58456     | 28-Apr-2019 | 02:02  | x64      |
| Sqlrepss.dll                                 | 2015.130.4574.0 | 54872     | 28-Apr-2019 | 02:02  | x64      |
| Sqlresld.dll                                 | 2015.130.4574.0 | 31016     | 28-Apr-2019 | 02:02  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4574.0 | 31024     | 28-Apr-2019 | 02:02  | x64      |
| Sqlscm.dll                                   | 2015.130.4574.0 | 61024     | 28-Apr-2019 | 02:14  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4574.0 | 27736     | 28-Apr-2019 | 02:02  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4574.0 | 5808432   | 28-Apr-2019 | 02:15  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4574.0 | 732760    | 28-Apr-2019 | 02:14  | x64      |
| Sqlservr.exe                                 | 2015.130.4574.0 | 393520    | 28-Apr-2019 | 02:10  | x64      |
| Sqlsvc.dll                                   | 2015.130.4574.0 | 152368    | 28-Apr-2019 | 02:02  | x64      |
| Sqltses.dll                                  | 2015.130.4574.0 | 8922200   | 28-Apr-2019 | 02:02  | x64      |
| Sqsrvres.dll                                 | 2015.130.4574.0 | 250968    | 28-Apr-2019 | 02:01  | x64      |
| Stretchcodegen.exe                           | 13.0.4574.0     | 56112     | 28-Apr-2019 | 02:14  | x86      |
| Xe.dll                                       | 2015.130.4574.0 | 626264    | 28-Apr-2019 | 02:15  | x64      |
| Xmlrw.dll                                    | 2015.130.4574.0 | 319072    | 28-Apr-2019 | 02:14  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4574.0 | 227416    | 28-Apr-2019 | 02:15  | x64      |
| Xpadsi.exe                                   | 2015.130.4574.0 | 78936     | 28-Apr-2019 | 02:15  | x64      |
| Xplog70.dll                                  | 2015.130.4574.0 | 65840     | 28-Apr-2019 | 02:15  | x64      |
| Xpqueue.dll                                  | 2015.130.4574.0 | 74840     | 28-Apr-2019 | 02:02  | x64      |
| Xprepl.dll                                   | 2015.130.4574.0 | 91224     | 28-Apr-2019 | 02:01  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4574.0 | 33376     | 28-Apr-2019 | 02:14  | x64      |
| Xpstar.dll                                   | 2015.130.4574.0 | 422704    | 28-Apr-2019 | 02:14  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4574.0 | 180832    | 28-Apr-2019 | 02:14  | x64      |
| Batchparser.dll                                                    | 2015.130.4574.0 | 160344    | 28-Apr-2019 | 02:15  | x86      |
| Bcp.exe                                                            | 2015.130.4574.0 | 120112    | 28-Apr-2019 | 02:14  | x64      |
| Commanddest.dll                                                    | 2015.130.4574.0 | 249160    | 28-Apr-2019 | 02:13  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4574.0 | 115808    | 28-Apr-2019 | 02:14  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4574.0 | 188208    | 28-Apr-2019 | 02:13  | x64      |
| Distrib.exe                                                        | 2015.130.4574.0 | 191280    | 28-Apr-2019 | 02:11  | x64      |
| Dteparse.dll                                                       | 2015.130.4574.0 | 109872    | 28-Apr-2019 | 02:13  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4574.0 | 88880     | 28-Apr-2019 | 02:11  | x64      |
| Dtepkg.dll                                                         | 2015.130.4574.0 | 137304    | 28-Apr-2019 | 02:13  | x64      |
| Dtexec.exe                                                         | 2015.130.4574.0 | 73032     | 28-Apr-2019 | 02:11  | x64      |
| Dts.dll                                                            | 2015.130.4574.0 | 3147056   | 28-Apr-2019 | 02:14  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4574.0 | 477488    | 28-Apr-2019 | 02:14  | x64      |
| Dtsconn.dll                                                        | 2015.130.4574.0 | 492872    | 28-Apr-2019 | 02:13  | x64      |
| Dtshost.exe                                                        | 2015.130.4574.0 | 86616     | 28-Apr-2019 | 02:10  | x64      |
| Dtslog.dll                                                         | 2015.130.4574.0 | 120408    | 28-Apr-2019 | 02:12  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4574.0 | 545368    | 28-Apr-2019 | 02:13  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4574.0 | 1279280   | 28-Apr-2019 | 02:13  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4574.0 | 48216     | 28-Apr-2019 | 02:13  | x64      |
| Dtswizard.exe                                                      | 13.0.4574.0     | 895576    | 28-Apr-2019 | 02:15  | x64      |
| Dtuparse.dll                                                       | 2015.130.4574.0 | 87640     | 28-Apr-2019 | 02:13  | x64      |
| Dtutil.exe                                                         | 2015.130.4574.0 | 134960    | 28-Apr-2019 | 02:11  | x64      |
| Exceldest.dll                                                      | 2015.130.4574.0 | 263768    | 28-Apr-2019 | 02:12  | x64      |
| Excelsrc.dll                                                       | 2015.130.4574.0 | 285272    | 28-Apr-2019 | 02:12  | x64      |
| Execpackagetask.dll                                                | 2015.130.4574.0 | 166488    | 28-Apr-2019 | 02:12  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4574.0 | 389208    | 28-Apr-2019 | 02:13  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4574.0 | 401712    | 28-Apr-2019 | 02:14  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4574.0 | 96344     | 28-Apr-2019 | 02:12  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4574.0 | 59184     | 28-Apr-2019 | 02:15  | x64      |
| Logread.exe                                                        | 2015.130.4574.0 | 617264    | 28-Apr-2019 | 02:11  | x64      |
| Mergetxt.dll                                                       | 2015.130.4574.0 | 53848     | 28-Apr-2019 | 02:13  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4574.0     | 1313584   | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4574.0     | 696624    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4574.0     | 763696    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 27-Apr-2019 | 17:01 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4574.0     | 54576     | 28-Apr-2019 | 02:17  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4574.0     | 89904     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4574.0     | 49752     | 28-Apr-2019 | 02:17  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4574.0     | 43312     | 28-Apr-2019 | 02:13  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4574.0     | 70744     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4574.0     | 35416     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4574.0     | 73520     | 28-Apr-2019 | 02:13  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4574.0     | 63792     | 28-Apr-2019 | 02:13  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4574.0     | 31320     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4574.0     | 131168    | 28-Apr-2019 | 02:20  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4574.0     | 43616     | 28-Apr-2019 | 02:20  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4574.0     | 57440     | 28-Apr-2019 | 02:20  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4574.0     | 606296    | 28-Apr-2019 | 02:19  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4574.0     | 215128    | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4574.0 | 1639000   | 28-Apr-2019 | 02:18  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4574.0 | 150104    | 28-Apr-2019 | 02:17  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4574.0 | 159024    | 28-Apr-2019 | 02:16  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4574.0 | 100952    | 28-Apr-2019 | 02:13  | x64      |
| Msgprox.dll                                                        | 2015.130.4574.0 | 275544    | 28-Apr-2019 | 02:12  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4574.0 | 1494624   | 28-Apr-2019 | 02:17  | x64      |
| Oledbdest.dll                                                      | 2015.130.4574.0 | 264280    | 28-Apr-2019 | 02:13  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4574.0 | 290912    | 28-Apr-2019 | 02:13  | x64      |
| Osql.exe                                                           | 2015.130.4574.0 | 75568     | 28-Apr-2019 | 02:14  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4574.0 | 469080    | 28-Apr-2019 | 02:10  | x64      |
| Rawdest.dll                                                        | 2015.130.4574.0 | 209504    | 28-Apr-2019 | 02:12  | x64      |
| Rawsource.dll                                                      | 2015.130.4574.0 | 196704    | 28-Apr-2019 | 02:12  | x64      |
| Rdistcom.dll                                                       | 2015.130.4574.0 | 894040    | 28-Apr-2019 | 02:13  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4574.0 | 187480    | 28-Apr-2019 | 02:12  | x64      |
| Replagnt.dll                                                       | 2015.130.4574.0 | 31024     | 28-Apr-2019 | 02:14  | x64      |
| Repldp.dll                                                         | 2015.130.4574.0 | 277088    | 28-Apr-2019 | 02:12  | x64      |
| Replerrx.dll                                                       | 2015.130.4574.0 | 144688    | 28-Apr-2019 | 02:13  | x64      |
| Replisapi.dll                                                      | 2015.130.4574.0 | 354392    | 28-Apr-2019 | 02:13  | x64      |
| Replmerg.exe                                                       | 2015.130.4574.0 | 518744    | 28-Apr-2019 | 02:10  | x64      |
| Replprov.dll                                                       | 2015.130.4574.0 | 812120    | 28-Apr-2019 | 02:13  | x64      |
| Replrec.dll                                                        | 2015.130.4574.0 | 1018696   | 28-Apr-2019 | 02:17  | x64      |
| Replsub.dll                                                        | 2015.130.4574.0 | 467552    | 28-Apr-2019 | 02:13  | x64      |
| Replsync.dll                                                       | 2015.130.4574.0 | 144200    | 28-Apr-2019 | 02:13  | x64      |
| Spresolv.dll                                                       | 2015.130.4574.0 | 245552    | 28-Apr-2019 | 02:13  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4574.0 | 249440    | 28-Apr-2019 | 02:14  | x64      |
| Sqldiag.exe                                                        | 2015.130.4574.0 | 1257776   | 28-Apr-2019 | 02:11  | x64      |
| Sqldistx.dll                                                       | 2015.130.4574.0 | 215648    | 28-Apr-2019 | 02:12  | x64      |
| Sqllogship.exe                                                     | 13.0.4574.0     | 100448    | 28-Apr-2019 | 02:14  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4574.0 | 346712    | 28-Apr-2019 | 02:02  | x64      |
| Sqlps.exe                                                          | 13.0.4574.0     | 59992     | 28-Apr-2019 | 02:12  | x86      |
| Sqlresld.dll                                                       | 2015.130.4574.0 | 31016     | 28-Apr-2019 | 02:02  | x64      |
| Sqlresld.dll                                                       | 2015.130.4574.0 | 28768     | 28-Apr-2019 | 02:12  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4574.0 | 31024     | 28-Apr-2019 | 02:02  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12  | x86      |
| Sqlscm.dll                                                         | 2015.130.4574.0 | 52832     | 28-Apr-2019 | 02:12  | x86      |
| Sqlscm.dll                                                         | 2015.130.4574.0 | 61024     | 28-Apr-2019 | 02:14  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4574.0 | 152368    | 28-Apr-2019 | 02:02  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4574.0 | 127072    | 28-Apr-2019 | 02:12  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4574.0 | 180824    | 28-Apr-2019 | 02:02  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4574.0 | 105768    | 28-Apr-2019 | 02:02  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4574.0 | 33608     | 28-Apr-2019 | 02:02  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4574.0 | 216152    | 28-Apr-2019 | 02:02  | x64      |
| Ssradd.dll                                                         | 2015.130.4574.0 | 65112     | 28-Apr-2019 | 02:02  | x64      |
| Ssravg.dll                                                         | 2015.130.4574.0 | 65112     | 28-Apr-2019 | 02:02  | x64      |
| Ssrdown.dll                                                        | 2015.130.4574.0 | 50776     | 28-Apr-2019 | 02:02  | x64      |
| Ssrmax.dll                                                         | 2015.130.4574.0 | 63792     | 28-Apr-2019 | 02:02  | x64      |
| Ssrmin.dll                                                         | 2015.130.4574.0 | 63576     | 28-Apr-2019 | 02:02  | x64      |
| Ssrpub.dll                                                         | 2015.130.4574.0 | 51288     | 28-Apr-2019 | 02:02  | x64      |
| Ssrup.dll                                                          | 2015.130.4574.0 | 50776     | 28-Apr-2019 | 02:02  | x64      |
| Txagg.dll                                                          | 2015.130.4574.0 | 364632    | 28-Apr-2019 | 02:02  | x64      |
| Txbdd.dll                                                          | 2015.130.4574.0 | 172872    | 28-Apr-2019 | 02:02  | x64      |
| Txdatacollector.dll                                                | 2015.130.4574.0 | 367704    | 28-Apr-2019 | 02:02  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4574.0 | 296536    | 28-Apr-2019 | 02:02  | x64      |
| Txderived.dll                                                      | 2015.130.4574.0 | 607832    | 28-Apr-2019 | 02:02  | x64      |
| Txlookup.dll                                                       | 2015.130.4574.0 | 532784    | 28-Apr-2019 | 02:02  | x64      |
| Txmerge.dll                                                        | 2015.130.4574.0 | 229976    | 28-Apr-2019 | 02:02  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4574.0 | 278616    | 28-Apr-2019 | 02:01  | x64      |
| Txmulticast.dll                                                    | 2015.130.4574.0 | 128600    | 28-Apr-2019 | 02:02  | x64      |
| Txrowcount.dll                                                     | 2015.130.4574.0 | 126552    | 28-Apr-2019 | 02:01  | x64      |
| Txsort.dll                                                         | 2015.130.4574.0 | 258648    | 28-Apr-2019 | 02:02  | x64      |
| Txsplit.dll                                                        | 2015.130.4574.0 | 600664    | 28-Apr-2019 | 02:02  | x64      |
| Txunionall.dll                                                     | 2015.130.4574.0 | 181848    | 28-Apr-2019 | 02:01  | x64      |
| Xe.dll                                                             | 2015.130.4574.0 | 626264    | 28-Apr-2019 | 02:15  | x64      |
| Xmlrw.dll                                                          | 2015.130.4574.0 | 319072    | 28-Apr-2019 | 02:14  | x64      |
| Xmlsub.dll                                                         | 2015.130.4574.0 | 250968    | 28-Apr-2019 | 02:02  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4574.0 | 1013848   | 28-Apr-2019 | 02:13 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqlsatellite.dll              | 2015.130.4574.0 | 837424    | 28-Apr-2019 | 02:14 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4574.0 | 660064    | 28-Apr-2019 | 02:14 | x64      |
| Fdhost.exe               | 2015.130.4574.0 | 105048    | 28-Apr-2019 | 02:14 | x64      |
| Fdlauncher.exe           | 2015.130.4574.0 | 51296     | 28-Apr-2019 | 02:14 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqlft130ph.dll           | 2015.130.4574.0 | 57944     | 28-Apr-2019 | 02:16 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4574.0     | 23856     | 28-Apr-2019 | 02:11 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.111       | 77944     | 26-Apr-2019 | 22:19 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.111       | 77944     | 27-Apr-2019 | 17:01 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.111       | 37496     | 26-Apr-2019 | 22:19 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.111       | 37496     | 27-Apr-2019 | 17:01 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.111       | 78456     | 26-Apr-2019 | 22:19 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.111       | 78456     | 27-Apr-2019 | 17:01 | x86      |
| Commanddest.dll                                                    | 2015.130.4574.0 | 249160    | 28-Apr-2019 | 02:13  | x64      |
| Commanddest.dll                                                    | 2015.130.4574.0 | 202840    | 28-Apr-2019 | 02:15  | x86      |
| Dteparse.dll                                                       | 2015.130.4574.0 | 109872    | 28-Apr-2019 | 02:13  | x64      |
| Dteparse.dll                                                       | 2015.130.4574.0 | 99416     | 28-Apr-2019 | 02:15  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4574.0 | 88880     | 28-Apr-2019 | 02:11  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4574.0 | 83552     | 28-Apr-2019 | 02:12  | x86      |
| Dtepkg.dll                                                         | 2015.130.4574.0 | 137304    | 28-Apr-2019 | 02:13  | x64      |
| Dtepkg.dll                                                         | 2015.130.4574.0 | 115808    | 28-Apr-2019 | 02:15  | x86      |
| Dtexec.exe                                                         | 2015.130.4574.0 | 73032     | 28-Apr-2019 | 02:11  | x64      |
| Dtexec.exe                                                         | 2015.130.4574.0 | 66648     | 28-Apr-2019 | 02:17  | x86      |
| Dts.dll                                                            | 2015.130.4574.0 | 3147056   | 28-Apr-2019 | 02:14  | x64      |
| Dts.dll                                                            | 2015.130.4574.0 | 2633008   | 28-Apr-2019 | 02:16  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4574.0 | 477488    | 28-Apr-2019 | 02:14  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4574.0 | 418904    | 28-Apr-2019 | 02:15  | x86      |
| Dtsconn.dll                                                        | 2015.130.4574.0 | 492872    | 28-Apr-2019 | 02:13  | x64      |
| Dtsconn.dll                                                        | 2015.130.4574.0 | 392280    | 28-Apr-2019 | 02:15  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4574.0 | 109872    | 28-Apr-2019 | 02:11  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4574.0 | 94000     | 28-Apr-2019 | 02:17  | x86      |
| Dtshost.exe                                                        | 2015.130.4574.0 | 86616     | 28-Apr-2019 | 02:10  | x64      |
| Dtshost.exe                                                        | 2015.130.4574.0 | 76376     | 28-Apr-2019 | 02:17  | x86      |
| Dtslog.dll                                                         | 2015.130.4574.0 | 120408    | 28-Apr-2019 | 02:12  | x64      |
| Dtslog.dll                                                         | 2015.130.4574.0 | 103008    | 28-Apr-2019 | 02:15  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4574.0 | 545368    | 28-Apr-2019 | 02:13  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4574.0 | 541488    | 28-Apr-2019 | 02:16  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4574.0 | 1279280   | 28-Apr-2019 | 02:13  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4574.0 | 1059632   | 28-Apr-2019 | 02:16  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4574.0 | 48216     | 28-Apr-2019 | 02:13  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4574.0 | 42288     | 28-Apr-2019 | 02:16  | x86      |
| Dtswizard.exe                                                      | 13.0.4574.0     | 896304    | 28-Apr-2019 | 01:57  | x86      |
| Dtswizard.exe                                                      | 13.0.4574.0     | 895576    | 28-Apr-2019 | 02:15  | x64      |
| Dtuparse.dll                                                       | 2015.130.4574.0 | 87640     | 28-Apr-2019 | 02:13  | x64      |
| Dtuparse.dll                                                       | 2015.130.4574.0 | 79960     | 28-Apr-2019 | 02:15  | x86      |
| Dtutil.exe                                                         | 2015.130.4574.0 | 134960    | 28-Apr-2019 | 02:11  | x64      |
| Dtutil.exe                                                         | 2015.130.4574.0 | 115288    | 28-Apr-2019 | 02:17  | x86      |
| Exceldest.dll                                                      | 2015.130.4574.0 | 263768    | 28-Apr-2019 | 02:12  | x64      |
| Exceldest.dll                                                      | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:15  | x86      |
| Excelsrc.dll                                                       | 2015.130.4574.0 | 285272    | 28-Apr-2019 | 02:12  | x64      |
| Excelsrc.dll                                                       | 2015.130.4574.0 | 232544    | 28-Apr-2019 | 02:15  | x86      |
| Execpackagetask.dll                                                | 2015.130.4574.0 | 166488    | 28-Apr-2019 | 02:12  | x64      |
| Execpackagetask.dll                                                | 2015.130.4574.0 | 135256    | 28-Apr-2019 | 02:15  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4574.0 | 389208    | 28-Apr-2019 | 02:13  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4574.0 | 334632    | 28-Apr-2019 | 02:15  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4574.0 | 401712    | 28-Apr-2019 | 02:14  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4574.0 | 345176    | 28-Apr-2019 | 02:15  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4574.0 | 96344     | 28-Apr-2019 | 02:12  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4574.0 | 80472     | 28-Apr-2019 | 02:15  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4574.0     | 439896    | 28-Apr-2019 | 01:57  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4574.0     | 438872    | 28-Apr-2019 | 02:15  | x64      |
| Isserverexec.exe                                                   | 13.0.4574.0     | 132696    | 28-Apr-2019 | 01:57  | x86      |
| Isserverexec.exe                                                   | 13.0.4574.0     | 132392    | 28-Apr-2019 | 02:14  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4574.0     | 1313584   | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4574.0     | 1313608   | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4574.0     | 696416    | 28-Apr-2019 | 02:10  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4574.0     | 696624    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4574.0     | 763480    | 28-Apr-2019 | 02:10  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4574.0     | 763696    | 28-Apr-2019 | 02:11  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 27-Apr-2019 | 17:01 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 27-Apr-2019 | 17:01 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4574.0     | 73304     | 28-Apr-2019 | 02:15  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4574.0 | 112456    | 28-Apr-2019 | 02:16  | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4574.0 | 107312    | 28-Apr-2019 | 02:22  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4574.0     | 54360     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4574.0     | 54576     | 28-Apr-2019 | 02:17  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4574.0     | 89688     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4574.0     | 89904     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4574.0     | 43096     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4574.0     | 43312     | 28-Apr-2019 | 02:13  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4574.0     | 35416     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4574.0     | 35416     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4574.0     | 73304     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4574.0     | 73520     | 28-Apr-2019 | 02:13  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4574.0     | 31320     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4574.0     | 31320     | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4574.0     | 477272    | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4574.0     | 477488    | 28-Apr-2019 | 02:14  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4574.0     | 43608     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4574.0     | 43616     | 28-Apr-2019 | 02:20  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4574.0     | 57432     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4574.0     | 57440     | 28-Apr-2019 | 02:20  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4574.0     | 52824     | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4574.0     | 53040     | 28-Apr-2019 | 02:21  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4574.0     | 606512    | 28-Apr-2019 | 02:12  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4574.0     | 606296    | 28-Apr-2019 | 02:19  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4574.0 | 150104    | 28-Apr-2019 | 02:17  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4574.0 | 139056    | 28-Apr-2019 | 02:19  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4574.0 | 144472    | 28-Apr-2019 | 02:16  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4574.0 | 159024    | 28-Apr-2019 | 02:16  | x64      |
| Msdtssrvr.exe                                                      | 13.0.4574.0     | 216880    | 28-Apr-2019 | 02:14  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4574.0 | 100952    | 28-Apr-2019 | 02:13  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4574.0 | 89688     | 28-Apr-2019 | 02:13  | x86      |
| Msmdpp.dll                                                         | 2015.130.4574.0 | 7647320   | 28-Apr-2019 | 02:13  | x64      |
| Oledbdest.dll                                                      | 2015.130.4574.0 | 264280    | 28-Apr-2019 | 02:13  | x64      |
| Oledbdest.dll                                                      | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:13  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4574.0 | 290912    | 28-Apr-2019 | 02:13  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4574.0 | 235608    | 28-Apr-2019 | 02:13  | x86      |
| Rawdest.dll                                                        | 2015.130.4574.0 | 209504    | 28-Apr-2019 | 02:12  | x64      |
| Rawdest.dll                                                        | 2015.130.4574.0 | 168536    | 28-Apr-2019 | 02:13  | x86      |
| Rawsource.dll                                                      | 2015.130.4574.0 | 196704    | 28-Apr-2019 | 02:12  | x64      |
| Rawsource.dll                                                      | 2015.130.4574.0 | 155224    | 28-Apr-2019 | 02:14  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4574.0 | 187480    | 28-Apr-2019 | 02:12  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4574.0 | 151640    | 28-Apr-2019 | 02:13  | x86      |
| Sql_is_keyfile.dll                                                 | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13  | x64      |
| Sqlceip.exe                                                        | 13.0.4574.0     | 252512    | 28-Apr-2019 | 02:13  | x86      |
| Sqldest.dll                                                        | 2015.130.4574.0 | 215648    | 28-Apr-2019 | 02:12  | x86      |
| Sqldest.dll                                                        | 2015.130.4574.0 | 263984    | 28-Apr-2019 | 02:14  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4574.0 | 180824    | 28-Apr-2019 | 02:02  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4574.0 | 151344    | 28-Apr-2019 | 02:12  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4574.0 | 216152    | 28-Apr-2019 | 02:02  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4574.0 | 176736    | 28-Apr-2019 | 02:12  | x86      |
| Txagg.dll                                                          | 2015.130.4574.0 | 364632    | 28-Apr-2019 | 02:02  | x64      |
| Txagg.dll                                                          | 2015.130.4574.0 | 304736    | 28-Apr-2019 | 02:20  | x86      |
| Txbdd.dll                                                          | 2015.130.4574.0 | 172872    | 28-Apr-2019 | 02:02  | x64      |
| Txbdd.dll                                                          | 2015.130.4574.0 | 138568    | 28-Apr-2019 | 02:22  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4574.0 | 611632    | 28-Apr-2019 | 02:02  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4574.0 | 496224    | 28-Apr-2019 | 02:20  | x86      |
| Txcache.dll                                                        | 2015.130.4574.0 | 183600    | 28-Apr-2019 | 02:02  | x64      |
| Txcache.dll                                                        | 2015.130.4574.0 | 148064    | 28-Apr-2019 | 02:21  | x86      |
| Txcharmap.dll                                                      | 2015.130.4574.0 | 290096    | 28-Apr-2019 | 02:02  | x64      |
| Txcharmap.dll                                                      | 2015.130.4574.0 | 250456    | 28-Apr-2019 | 02:21  | x86      |
| Txcopymap.dll                                                      | 2015.130.4574.0 | 183384    | 28-Apr-2019 | 02:02  | x64      |
| Txcopymap.dll                                                      | 2015.130.4574.0 | 147552    | 28-Apr-2019 | 02:20  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4574.0 | 296536    | 28-Apr-2019 | 02:02  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4574.0 | 255072    | 28-Apr-2019 | 02:19  | x86      |
| Txderived.dll                                                      | 2015.130.4574.0 | 607832    | 28-Apr-2019 | 02:02  | x64      |
| Txderived.dll                                                      | 2015.130.4574.0 | 519264    | 28-Apr-2019 | 02:20  | x86      |
| Txfileextractor.dll                                                | 2015.130.4574.0 | 202032    | 28-Apr-2019 | 02:02  | x64      |
| Txfileextractor.dll                                                | 2015.130.4574.0 | 162912    | 28-Apr-2019 | 02:20  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4574.0 | 199984    | 28-Apr-2019 | 02:02  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4574.0 | 160864    | 28-Apr-2019 | 02:21  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4574.0 | 290904    | 28-Apr-2019 | 02:02  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4574.0 | 231520    | 28-Apr-2019 | 02:20  | x86      |
| Txlineage.dll                                                      | 2015.130.4574.0 | 137304    | 28-Apr-2019 | 02:01  | x64      |
| Txlineage.dll                                                      | 2015.130.4574.0 | 109152    | 28-Apr-2019 | 02:19  | x86      |
| Txlookup.dll                                                       | 2015.130.4574.0 | 532784    | 28-Apr-2019 | 02:02  | x64      |
| Txlookup.dll                                                       | 2015.130.4574.0 | 449840    | 28-Apr-2019 | 02:22  | x86      |
| Txmerge.dll                                                        | 2015.130.4574.0 | 229976    | 28-Apr-2019 | 02:02  | x64      |
| Txmerge.dll                                                        | 2015.130.4574.0 | 176216    | 28-Apr-2019 | 02:21  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4574.0 | 278616    | 28-Apr-2019 | 02:01  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4574.0 | 223840    | 28-Apr-2019 | 02:20  | x86      |
| Txmulticast.dll                                                    | 2015.130.4574.0 | 128600    | 28-Apr-2019 | 02:02  | x64      |
| Txmulticast.dll                                                    | 2015.130.4574.0 | 101984    | 28-Apr-2019 | 02:19  | x86      |
| Txpivot.dll                                                        | 2015.130.4574.0 | 227928    | 28-Apr-2019 | 02:02  | x64      |
| Txpivot.dll                                                        | 2015.130.4574.0 | 181856    | 28-Apr-2019 | 02:19  | x86      |
| Txrowcount.dll                                                     | 2015.130.4574.0 | 126552    | 28-Apr-2019 | 02:01  | x64      |
| Txrowcount.dll                                                     | 2015.130.4574.0 | 101472    | 28-Apr-2019 | 02:20  | x86      |
| Txsampling.dll                                                     | 2015.130.4574.0 | 172120    | 28-Apr-2019 | 02:01  | x64      |
| Txsampling.dll                                                     | 2015.130.4574.0 | 134752    | 28-Apr-2019 | 02:21  | x86      |
| Txscd.dll                                                          | 2015.130.4574.0 | 220248    | 28-Apr-2019 | 02:01  | x64      |
| Txscd.dll                                                          | 2015.130.4574.0 | 169568    | 28-Apr-2019 | 02:20  | x86      |
| Txsort.dll                                                         | 2015.130.4574.0 | 258648    | 28-Apr-2019 | 02:02  | x64      |
| Txsort.dll                                                         | 2015.130.4574.0 | 210528    | 28-Apr-2019 | 02:19  | x86      |
| Txsplit.dll                                                        | 2015.130.4574.0 | 600664    | 28-Apr-2019 | 02:02  | x64      |
| Txsplit.dll                                                        | 2015.130.4574.0 | 513624    | 28-Apr-2019 | 02:20  | x86      |
| Txtermextraction.dll                                               | 2015.130.4574.0 | 8677976   | 28-Apr-2019 | 02:02  | x64      |
| Txtermextraction.dll                                               | 2015.130.4574.0 | 8615520   | 28-Apr-2019 | 02:20  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4574.0 | 4158552   | 28-Apr-2019 | 02:02  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4574.0 | 4107560   | 28-Apr-2019 | 02:19  | x86      |
| Txunionall.dll                                                     | 2015.130.4574.0 | 181848    | 28-Apr-2019 | 02:01  | x64      |
| Txunionall.dll                                                     | 2015.130.4574.0 | 138848    | 28-Apr-2019 | 02:19  | x86      |
| Txunpivot.dll                                                      | 2015.130.4574.0 | 202328    | 28-Apr-2019 | 02:02  | x64      |
| Txunpivot.dll                                                      | 2015.130.4574.0 | 162400    | 28-Apr-2019 | 02:19  | x86      |
| Xe.dll                                                             | 2015.130.4574.0 | 626264    | 28-Apr-2019 | 02:15  | x64      |
| Xe.dll                                                             | 2015.130.4574.0 | 558688    | 28-Apr-2019 | 02:20  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 00:09 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 00:09 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 00:09 | x86      |
| Instapi130.dll                                                       | 2015.130.4574.0  | 61232     | 28-Apr-2019 | 02:02 | x64      |
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
| Mpdwinterop.dll                                                      | 2015.130.4574.0  | 394336    | 28-Apr-2019 | 02:14 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4574.0  | 6613592   | 28-Apr-2019 | 02:15 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4574.0  | 2155312   | 28-Apr-2019 | 02:02 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 00:09 | x64      |
| Sqldk.dll                                                            | 2015.130.4574.0  | 2530392   | 28-Apr-2019 | 02:02 | x64      |
| Sqldumper.exe                                                        | 2015.130.4574.0  | 127064    | 28-Apr-2019 | 02:15 | x64      |
| Sqlos.dll                                                            | 2015.130.4574.0  | 26200     | 28-Apr-2019 | 02:02 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 00:09 | x64      |
| Sqltses.dll                                                          | 2015.130.4574.0  | 9091160   | 28-Apr-2019 | 02:02 | x64      |

SQL Server 2016 Reporting Services

| File name                                                 | File version    | File size | Date        | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-------------|-------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.4574.0     | 611120    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.authorization.dll             | 13.0.4574.0     | 79152     | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4574.0     | 210736    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4574.0     | 168752    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4574.0     | 1620272   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4574.0     | 657712    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4574.0     | 330032    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4574.0     | 1072432   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532064    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532064    | 28-Apr-2019 | 02:13 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532272    | 28-Apr-2019 | 02:14 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532056    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532056    | 28-Apr-2019 | 02:13 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532272    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532056    | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532056    | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532064    | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4574.0     | 532056    | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4574.0     | 48936     | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4574.0     | 163120    | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4574.0     | 76592     | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4574.0     | 76592     | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4574.0     | 126040    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4574.0     | 106072    | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4574.0     | 5959472   | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420184   | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420696   | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4421208   | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420696   | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4421208   | 28-Apr-2019 | 02:13 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4421424   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420912   | 28-Apr-2019 | 02:14 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4421928   | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420400   | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4574.0     | 4420696   | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4574.0     | 10886440  | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4574.0     | 100960    | 28-Apr-2019 | 02:14 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4574.0     | 73008     | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4574.0     | 5951816   | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4574.0     | 246064    | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4574.0     | 298072    | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4574.0     | 208688    | 28-Apr-2019 | 02:16 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 44640     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48728     | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48944     | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48728     | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 52824     | 28-Apr-2019 | 02:13 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48736     | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48944     | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 53040     | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 44640     | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4574.0     | 48728     | 28-Apr-2019 | 02:16 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4574.0     | 510768    | 28-Apr-2019 | 02:16 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4574.0 | 47944     | 28-Apr-2019 | 02:16 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4574.0     | 496728    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4574.0 | 396888    | 28-Apr-2019 | 02:13 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4574.0 | 391768    | 28-Apr-2019 | 02:18 | x86      |
| Msmdlocal.dll                                             | 2015.130.4574.0 | 37103192  | 28-Apr-2019 | 02:13 | x86      |
| Msmdlocal.dll                                             | 2015.130.4574.0 | 56207960  | 28-Apr-2019 | 02:17 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4574.0 | 6507824   | 28-Apr-2019 | 02:17 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4574.0 | 7507032   | 28-Apr-2019 | 02:18 | x64      |
| Msolap130.dll                                             | 2015.130.4574.0 | 7008344   | 28-Apr-2019 | 02:13 | x86      |
| Msolap130.dll                                             | 2015.130.4574.0 | 8639584   | 28-Apr-2019 | 02:13 | x64      |
| Msolui130.dll                                             | 2015.130.4574.0 | 310360    | 28-Apr-2019 | 02:12 | x64      |
| Msolui130.dll                                             | 2015.130.4574.0 | 287320    | 28-Apr-2019 | 02:13 | x86      |
| Reportingservicescompression.dll                          | 2015.130.4574.0 | 62560     | 28-Apr-2019 | 02:12 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4574.0     | 84568     | 28-Apr-2019 | 02:18 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4574.0     | 2543920   | 28-Apr-2019 | 02:17 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4574.0 | 114480    | 28-Apr-2019 | 02:15 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4574.0 | 108848    | 28-Apr-2019 | 02:16 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.4574.0 | 99120     | 28-Apr-2019 | 02:14 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4574.0 | 2573616   | 28-Apr-2019 | 02:12 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4574.0     | 2710616   | 28-Apr-2019 | 02:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 868168    | 28-Apr-2019 | 02:15 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872024    | 28-Apr-2019 | 02:14 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872240    | 28-Apr-2019 | 02:13 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872024    | 28-Apr-2019 | 02:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 876120    | 28-Apr-2019 | 02:16 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872024    | 28-Apr-2019 | 02:17 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872032    | 28-Apr-2019 | 02:12 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 884528    | 28-Apr-2019 | 02:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 867936    | 28-Apr-2019 | 02:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4574.0     | 872024    | 28-Apr-2019 | 02:17 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4574.0 | 3662936   | 28-Apr-2019 | 02:12 | x64      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4574.0 | 3590744   | 28-Apr-2019 | 02:13 | x86      |
| Rsconfigtool.exe                                          | 13.0.4574.0     | 1405536   | 28-Apr-2019 | 02:15 | x86      |
| Rsctr.dll                                                 | 2015.130.4574.0 | 58456     | 28-Apr-2019 | 02:12 | x64      |
| Rsctr.dll                                                 | 2015.130.4574.0 | 51288     | 28-Apr-2019 | 02:13 | x86      |
| Rshttpruntime.dll                                         | 2015.130.4574.0 | 99416     | 28-Apr-2019 | 02:18 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                                             | 2015.130.4574.0 | 127280    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                                             | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15 | x86      |
| Sqlrsos.dll                                               | 2015.130.4574.0 | 26440     | 28-Apr-2019 | 02:02 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4574.0 | 584288    | 28-Apr-2019 | 02:12 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.4574.0 | 732760    | 28-Apr-2019 | 02:14 | x64      |
| Xmlrw.dll                                                 | 2015.130.4574.0 | 319072    | 28-Apr-2019 | 02:14 | x64      |
| Xmlrw.dll                                                 | 2015.130.4574.0 | 259680    | 28-Apr-2019 | 02:19 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4574.0 | 227416    | 28-Apr-2019 | 02:15 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4574.0 | 191792    | 28-Apr-2019 | 02:19 | x86      |
| Xmsrv.dll                                                 | 2015.130.4574.0 | 24050776  | 28-Apr-2019 | 02:02 | x64      |
| Xmsrv.dll                                                 | 2015.130.4574.0 | 32727856  | 28-Apr-2019 | 02:21 | x86      |

SQL Server 2016 sql_shared_mr

| File name                          | File version    | File size | Date        | Time  | Platform |
|------------------------------------|-----------------|-----------|-------------|-------|----------|
| Smrdll.dll                         | 13.0.4574.0     | 23856     | 28-Apr-2019 | 02:16 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4574.0 | 1312048   | 28-Apr-2019 | 02:16 | x86      |
| Ddsshapes.dll                                   | 2015.130.4574.0 | 135768    | 28-Apr-2019 | 02:15 | x86      |
| Dtaengine.exe                                   | 2015.130.4574.0 | 167000    | 28-Apr-2019 | 02:17 | x86      |
| Dteparse.dll                                    | 2015.130.4574.0 | 109872    | 28-Apr-2019 | 02:13 | x64      |
| Dteparse.dll                                    | 2015.130.4574.0 | 99416     | 28-Apr-2019 | 02:15 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4574.0 | 88880     | 28-Apr-2019 | 02:11 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4574.0 | 83552     | 28-Apr-2019 | 02:12 | x86      |
| Dtepkg.dll                                      | 2015.130.4574.0 | 137304    | 28-Apr-2019 | 02:13 | x64      |
| Dtepkg.dll                                      | 2015.130.4574.0 | 115808    | 28-Apr-2019 | 02:15 | x86      |
| Dtexec.exe                                      | 2015.130.4574.0 | 73032     | 28-Apr-2019 | 02:11 | x64      |
| Dtexec.exe                                      | 2015.130.4574.0 | 66648     | 28-Apr-2019 | 02:17 | x86      |
| Dts.dll                                         | 2015.130.4574.0 | 3147056   | 28-Apr-2019 | 02:14 | x64      |
| Dts.dll                                         | 2015.130.4574.0 | 2633008   | 28-Apr-2019 | 02:16 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4574.0 | 477488    | 28-Apr-2019 | 02:14 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4574.0 | 418904    | 28-Apr-2019 | 02:15 | x86      |
| Dtsconn.dll                                     | 2015.130.4574.0 | 492872    | 28-Apr-2019 | 02:13 | x64      |
| Dtsconn.dll                                     | 2015.130.4574.0 | 392280    | 28-Apr-2019 | 02:15 | x86      |
| Dtshost.exe                                     | 2015.130.4574.0 | 86616     | 28-Apr-2019 | 02:10 | x64      |
| Dtshost.exe                                     | 2015.130.4574.0 | 76376     | 28-Apr-2019 | 02:17 | x86      |
| Dtslog.dll                                      | 2015.130.4574.0 | 120408    | 28-Apr-2019 | 02:12 | x64      |
| Dtslog.dll                                      | 2015.130.4574.0 | 103008    | 28-Apr-2019 | 02:15 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4574.0 | 545368    | 28-Apr-2019 | 02:13 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4574.0 | 541488    | 28-Apr-2019 | 02:16 | x86      |
| Dtspipeline.dll                                 | 2015.130.4574.0 | 1279280   | 28-Apr-2019 | 02:13 | x64      |
| Dtspipeline.dll                                 | 2015.130.4574.0 | 1059632   | 28-Apr-2019 | 02:16 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4574.0 | 48216     | 28-Apr-2019 | 02:13 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4574.0 | 42288     | 28-Apr-2019 | 02:16 | x86      |
| Dtswizard.exe                                   | 13.0.4574.0     | 896304    | 28-Apr-2019 | 01:57 | x86      |
| Dtswizard.exe                                   | 13.0.4574.0     | 895576    | 28-Apr-2019 | 02:15 | x64      |
| Dtuparse.dll                                    | 2015.130.4574.0 | 87640     | 28-Apr-2019 | 02:13 | x64      |
| Dtuparse.dll                                    | 2015.130.4574.0 | 79960     | 28-Apr-2019 | 02:15 | x86      |
| Dtutil.exe                                      | 2015.130.4574.0 | 134960    | 28-Apr-2019 | 02:11 | x64      |
| Dtutil.exe                                      | 2015.130.4574.0 | 115288    | 28-Apr-2019 | 02:17 | x86      |
| Exceldest.dll                                   | 2015.130.4574.0 | 263768    | 28-Apr-2019 | 02:12 | x64      |
| Exceldest.dll                                   | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:15 | x86      |
| Excelsrc.dll                                    | 2015.130.4574.0 | 285272    | 28-Apr-2019 | 02:12 | x64      |
| Excelsrc.dll                                    | 2015.130.4574.0 | 232544    | 28-Apr-2019 | 02:15 | x86      |
| Flatfiledest.dll                                | 2015.130.4574.0 | 389208    | 28-Apr-2019 | 02:13 | x64      |
| Flatfiledest.dll                                | 2015.130.4574.0 | 334632    | 28-Apr-2019 | 02:15 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4574.0 | 401712    | 28-Apr-2019 | 02:14 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4574.0 | 345176    | 28-Apr-2019 | 02:15 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4574.0 | 96344     | 28-Apr-2019 | 02:12 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4574.0 | 80472     | 28-Apr-2019 | 02:15 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4574.0     | 92256     | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4574.0     | 1313608   | 28-Apr-2019 | 02:11 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4574.0     | 696416    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4574.0     | 763480    | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4574.0 | 2023000   | 28-Apr-2019 | 02:10 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4574.0 | 42288     | 28-Apr-2019 | 02:21 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4574.0     | 71256     | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4574.0     | 186456    | 28-Apr-2019 | 02:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4574.0     | 435800    | 28-Apr-2019 | 02:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4574.0     | 435808    | 28-Apr-2019 | 02:20 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4574.0     | 2044720   | 28-Apr-2019 | 02:14 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4574.0     | 2044720   | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4574.0     | 33376     | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4574.0     | 33368     | 28-Apr-2019 | 02:14 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4574.0     | 249440    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4574.0     | 249440    | 28-Apr-2019 | 02:14 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4574.0     | 491312    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4574.0     | 606512    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4574.0     | 606296    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4574.0     | 106288    | 28-Apr-2019 | 02:12 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4574.0 | 150104    | 28-Apr-2019 | 02:17 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4574.0 | 139056    | 28-Apr-2019 | 02:19 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4574.0 | 144472    | 28-Apr-2019 | 02:16 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4574.0 | 159024    | 28-Apr-2019 | 02:16 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4574.0 | 100952    | 28-Apr-2019 | 02:13 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4574.0 | 89688     | 28-Apr-2019 | 02:13 | x86      |
| Msmdlocal.dll                                   | 2015.130.4574.0 | 37103192  | 28-Apr-2019 | 02:13 | x86      |
| Msmdlocal.dll                                   | 2015.130.4574.0 | 56207960  | 28-Apr-2019 | 02:17 | x64      |
| Msmdpp.dll                                      | 2015.130.4574.0 | 6370392   | 28-Apr-2019 | 02:13 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4574.0 | 6507824   | 28-Apr-2019 | 02:17 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4574.0 | 7507032   | 28-Apr-2019 | 02:18 | x64      |
| Msolap130.dll                                   | 2015.130.4574.0 | 7008344   | 28-Apr-2019 | 02:13 | x86      |
| Msolap130.dll                                   | 2015.130.4574.0 | 8639584   | 28-Apr-2019 | 02:13 | x64      |
| Msolui130.dll                                   | 2015.130.4574.0 | 310360    | 28-Apr-2019 | 02:12 | x64      |
| Msolui130.dll                                   | 2015.130.4574.0 | 287320    | 28-Apr-2019 | 02:13 | x86      |
| Oledbdest.dll                                   | 2015.130.4574.0 | 264280    | 28-Apr-2019 | 02:13 | x64      |
| Oledbdest.dll                                   | 2015.130.4574.0 | 216664    | 28-Apr-2019 | 02:13 | x86      |
| Oledbsrc.dll                                    | 2015.130.4574.0 | 290912    | 28-Apr-2019 | 02:13 | x64      |
| Oledbsrc.dll                                    | 2015.130.4574.0 | 235608    | 28-Apr-2019 | 02:13 | x86      |
| Profiler.exe                                    | 2015.130.4574.0 | 804656    | 28-Apr-2019 | 02:11 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4574.0 | 100448    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                                   | 2015.130.4574.0 | 127280    | 28-Apr-2019 | 02:13 | x64      |
| Sqldumper.exe                                   | 2015.130.4574.0 | 107608    | 28-Apr-2019 | 02:15 | x86      |
| Sqlresld.dll                                    | 2015.130.4574.0 | 31016     | 28-Apr-2019 | 02:02 | x64      |
| Sqlresld.dll                                    | 2015.130.4574.0 | 28768     | 28-Apr-2019 | 02:12 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4574.0 | 31024     | 28-Apr-2019 | 02:02 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4574.0 | 28256     | 28-Apr-2019 | 02:12 | x86      |
| Sqlscm.dll                                      | 2015.130.4574.0 | 52832     | 28-Apr-2019 | 02:12 | x86      |
| Sqlscm.dll                                      | 2015.130.4574.0 | 61024     | 28-Apr-2019 | 02:14 | x64      |
| Sqlsvc.dll                                      | 2015.130.4574.0 | 152368    | 28-Apr-2019 | 02:02 | x64      |
| Sqlsvc.dll                                      | 2015.130.4574.0 | 127072    | 28-Apr-2019 | 02:12 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4574.0 | 180824    | 28-Apr-2019 | 02:02 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4574.0 | 151344    | 28-Apr-2019 | 02:12 | x86      |
| Txdataconvert.dll                               | 2015.130.4574.0 | 296536    | 28-Apr-2019 | 02:02 | x64      |
| Txdataconvert.dll                               | 2015.130.4574.0 | 255072    | 28-Apr-2019 | 02:19 | x86      |
| Xe.dll                                          | 2015.130.4574.0 | 626264    | 28-Apr-2019 | 02:15 | x64      |
| Xe.dll                                          | 2015.130.4574.0 | 558688    | 28-Apr-2019 | 02:20 | x86      |
| Xmlrw.dll                                       | 2015.130.4574.0 | 319072    | 28-Apr-2019 | 02:14 | x64      |
| Xmlrw.dll                                       | 2015.130.4574.0 | 259680    | 28-Apr-2019 | 02:19 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4574.0 | 227416    | 28-Apr-2019 | 02:15 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4574.0 | 191792    | 28-Apr-2019 | 02:19 | x86      |
| Xmsrv.dll                                       | 2015.130.4574.0 | 24050776  | 28-Apr-2019 | 02:02 | x64      |
| Xmsrv.dll                                       | 2015.130.4574.0 | 32727856  | 28-Apr-2019 | 02:21 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
