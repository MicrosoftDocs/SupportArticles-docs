---
title: Cumulative update 9 for SQL Server 2016 SP1 (KB4100997)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 9 (KB4100997).
ms.date: 10/26/2023
ms.custom: KB4100997
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB4100997 - Cumulative Update 9 for SQL Server 2016 SP1

_Release Date:_ &nbsp; May 30, 2018  
_Version:_ &nbsp; 13.0.4502.0

This article describes cumulative update package 9 (build number: **13.0.4502.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area|
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=11814294>[11814294](#11814294) </a> | [PFS page round robin algorithm improvement in SQL Server 2016 (KB4099472)](https://support.microsoft.com/help/4099472) | SQL Engine|
| <a id=11231756>[11231756](#11231756) </a> | FIX: Error when a SQL Server Agent job executes a PowerShell command to enumerate permissions of the database (KB4133164) | Management Tools|
| <a id=11701139>[11701139](#11701139) </a> | [FIX: Access violation occurs when executing a DAX query on a tabular model in SQL Server Analysis Services (KB4086173)](https://support.microsoft.com/help/4086173)| Analysis Services |
| <a id=11814333>[11814333](#11814333) </a> | [Performance issues occur in the form of PAGELATCH_EX and PAGELATCH_SH waits in TempDB when you use SQL Server 2016 (KB4131193)](https://support.microsoft.com/help/4131193)| SQL Engine|
| <a id=11829791>[11829791](#11829791) </a> | [FIX: A crash occurs when proactive caching is triggered for a dimension in SSAS (KB3028216)](https://support.microsoft.com/help/3028216) | Analysis Services |
| <a id=11829056>[11829056](#11829056) </a> | [FIX: Change tracking record is inconsistent during an update on a table that has a cluster/unique index in SQL Server (KB4135113)](https://support.microsoft.com/help/4135113)| SQL Engine|
| <a id=11918578>[11918578](#11918578) </a> | FIX: TDE database goes offline during log flush operations when connectivity issues cause the EKM provider to become inaccessible in SQL Server (KB4293839) | SQL security|
| <a id=11810404>[11810404](#11810404) </a> | FIX: A dead latch condition occurs when you perform an online index rebuild or execute a merge command in SQL Server (KB4230730)| SQL Engine|
| <a id=11793118>[11793118](#11793118) </a> | [FIX: An access violation occurs when incremental statistics are automatically updated on a table in SQL Server (KB4163478)](https://support.microsoft.com/help/4163478)| SQL performance |
| <a id=11923632>[11923632](#11923632) </a> | FIX: Restore of a TDE compressed backup is unsuccessful when using the VDI client (KB4230306) | SQL Engine|
| <a id=11924460>[11924460](#11924460) </a> | [FIX: Performance is slow for an Always On AG when you process a read query in SQL Server (KB4163087)](https://support.microsoft.com/help/4163087)| SQL Engine|
| <a id=11684528>[11684528](#11684528) </a> | [FIX: Wrong user name appears when two users log on to MDS at different times in SQL Server (KB4164562)](https://support.microsoft.com/help/4164562)| Data Quality Services (DQS) |
| <a id=11634113>[11634113](#11634113) </a> | [FIX: Database cannot be dropped after its storage is disconnected and reconnected in SQL Server (KB4094893)](https://support.microsoft.com/help/4094893) | SQL Engine|
| <a id=11708639>[11708639](#11708639) </a> | FIX: An internal exception access violation occurs and the SSAS server stops responding (KB4162814) | Analysis Services |
| <a id=11637501>[11637501](#11637501) </a> | FIX: Deploying an SSAS project in SSDT is frequently unsuccessful in SQL Server Analysis Services in Tabular mode (KB4132267)| Analysis Services |
| <a id=11797887>[11797887](#11797887) </a> | [FIX: Parallel redo in a secondary replica of an availability group that contains heap tables generates a runtime assert dump or the SQL Server crashes with an access violation error (KB4101554)](https://support.microsoft.com/help/4101554) | High Availability |
| <a id=11750742>[11750742](#11750742) </a> | FIX: Hidden parameters are included in reports when the Browser role is used in SSRS 2016 (KB4098762) | Reporting Services|
| <a id=11830380>[11830380](#11830380) </a> | FIX: Processing a cube with many partitions generates lots of concurrent data source connections in SSAS (KB4134175)| Analysis Services |
| <a id=11591371>[11591371](#11591371) </a> | [FIX: Access violation occurs when you query a table with an integer column in SQL Server 2017 and SQL Server 2016 (KB4091245)](https://support.microsoft.com/help/4091245) | SQL performance |
| <a id=11714686>[11714686](#11714686) </a> | [FIX: One worker thread seems to hang after another worker thread is aborted when you run a parallel query in SQL Server (KB4094706)](https://support.microsoft.com/help/4094706) | SQL Engine|
| <a id=11953725>[11953725](#11953725) </a> | [FIX: TDE enabled database backup and restore operations are slow when the encryption key is stored in an EKM provider in SQL Server (KB4058175)](https://support.microsoft.com/help/4058175) | SQL Engine|
| <a id=11833599>[11833599](#11833599) </a> | [FIX: An access violation occurs when you execute a nested select query against a columnstore index in SQL Server (KB4131960)](https://support.microsoft.com/help/4131960)| SQL Engine|
| <a id=11676935>[11676935](#11676935) </a> | [FIX: "An unexpected error occurred" when you use DAX measures in Power BI table visualizations in SQL Server (KB4094858)](https://support.microsoft.com/help/4094858)| Analysis Services |
| <a id=11791348>[11791348](#11791348) </a> | [FIX: TDE enabled database backup with compression causes database corruption in SQL Server 2016 (KB4101502)](https://support.microsoft.com/help/4101502) | SQL Engine|
| <a id=11701153>[11701153](#11701153) </a> | Fixes a setup error when applying a SQL Server security patch on a Customized Cluster on the Passive Node. **Note**: This isn't the Failover Cluster Instance of SQL Server.| Setup & Install |
| <a id=11797609>[11797609](#11797609) </a> | Fixes Msg 109 (A transport-level error has occurred when receiving results from the server) when you execute a linked server query. This error happens when the query processor gathers metadata about the remote table indexes. | SQL Engine|
| <a id=11801446>[11801446](#11801446) </a> | Fixes Error (System.Runtime.InteropServices.COMException (0x800A03EC): Exception from HRESULT: 0x800A03EC) with MDS add-in for Excel when using the German version of Excel.| Data Quality Services (DQS) |

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
| Instapi130.dll         | 2015.130.4502.0 | 53424     | 15-May-2018 | 00:57 | x86      |
| Msmdredir.dll          | 2015.130.4502.0 | 6421680   | 15-May-2018 | 00:58 | x86      |
| Msmdsrv.rll            | 2015.130.4502.0 | 1296560   | 15-May-2018 | 00:58 | x86      |
| Msmdsrvi.rll           | 2015.130.4502.0 | 1293488   | 15-May-2018 | 00:58 | x86      |
| Sqlbrowser.exe         | 2015.130.4502.0 | 276656    | 15-May-2018 | 00:57 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x86      |
| Sqldumper.exe          | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4502.0  | 160432    | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                              | 2015.130.4502.0  | 53424     | 15-May-2018 | 00:57 | x86      |
| Isacctchange.dll                            | 2015.130.4502.0  | 29360     | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4502.0      | 1027248   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4502.0      | 1348784   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4502.0      | 702640    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4502.0      | 765616    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4502.0      | 520880    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4502.0      | 711856    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4502.0      | 37040     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4502.0      | 46256     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4502.0  | 72880     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4502.0      | 598704    | 15-May-2018 | 00:58 | x86      |
| Msasxpress.dll                              | 2015.130.4502.0  | 31920     | 15-May-2018 | 00:58 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4502.0  | 60080     | 15-May-2018 | 00:58 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4502.0  | 88752     | 15-May-2018 | 00:57 | x86      |
| Sqldumper.exe                               | 2015.130.4502.0  | 107688    | 15-May-2018 | 00:57 | x86      |
| Sqlftacct.dll                               | 2015.130.4502.0  | 46768     | 15-May-2018 | 00:58 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 04:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4502.0  | 364208    | 15-May-2018 | 00:58 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4502.0  | 34984     | 15-May-2018 | 00:58 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4502.0  | 267440    | 15-May-2018 | 00:58 | x86      |
| Sqltdiagn.dll                               | 2015.130.4502.0  | 60584     | 15-May-2018 | 00:58 | x86      |
| Svrenumapi130.dll                           | 2015.130.4502.0  | 854192    | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4502.0  | 1876648   | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4502.0 | 121008    | 15-May-2018 | 00:57 | x86      |
| Dreplaycommon.dll              | 2015.130.4502.0 | 690864    | 15-May-2018 | 00:58 | x86      |
| Dreplayserverps.dll            | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:57 | x86      |
| Dreplayutil.dll                | 2015.130.4502.0 | 309936    | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                 | 2015.130.4502.0 | 53424     | 15-May-2018 | 00:57 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x86      |
| Sqlresourceloader.dll          | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4502.0 | 690864    | 15-May-2018 | 00:58 | x86      |
| Dreplaycontroller.exe              | 2015.130.4502.0 | 350384    | 15-May-2018 | 00:57 | x86      |
| Dreplayprocess.dll                 | 2015.130.4502.0 | 171696    | 15-May-2018 | 00:57 | x86      |
| Dreplayserverps.dll                | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                     | 2015.130.4502.0 | 53424     | 15-May-2018 | 00:57 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x86      |
| Sqlresourceloader.dll              | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4502.0 | 1311920   | 15-May-2018 | 00:57 | x86      |
| Ddsshapes.dll                                   | 2015.130.4502.0 | 135856    | 15-May-2018 | 00:57 | x86      |
| Dtaengine.exe                                   | 2015.130.4502.0 | 167088    | 15-May-2018 | 00:57 | x86      |
| Dteparse.dll                                    | 2015.130.4502.0 | 99504     | 15-May-2018 | 00:57 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4502.0 | 83632     | 15-May-2018 | 00:58 | x86      |
| Dtepkg.dll                                      | 2015.130.4502.0 | 115880    | 15-May-2018 | 00:57 | x86      |
| Dtexec.exe                                      | 2015.130.4502.0 | 66736     | 15-May-2018 | 00:57 | x86      |
| Dts.dll                                         | 2015.130.4502.0 | 2632880   | 15-May-2018 | 00:57 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4502.0 | 418992    | 15-May-2018 | 00:57 | x86      |
| Dtsconn.dll                                     | 2015.130.4502.0 | 392368    | 15-May-2018 | 00:57 | x86      |
| Dtshost.exe                                     | 2015.130.4502.0 | 76464     | 15-May-2018 | 00:57 | x86      |
| Dtslog.dll                                      | 2015.130.4502.0 | 103088    | 15-May-2018 | 00:57 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4502.0 | 541360    | 15-May-2018 | 00:57 | x86      |
| Dtspipeline.dll                                 | 2015.130.4502.0 | 1059504   | 15-May-2018 | 00:57 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4502.0 | 42160     | 15-May-2018 | 00:57 | x86      |
| Dtswizard.exe                                   | 13.0.4502.0     | 896176    | 15-May-2018 | 00:51 | x86      |
| Dtuparse.dll                                    | 2015.130.4502.0 | 80048     | 15-May-2018 | 00:57 | x86      |
| Dtutil.exe                                      | 2015.130.4502.0 | 115376    | 15-May-2018 | 00:57 | x86      |
| Exceldest.dll                                   | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:57 | x86      |
| Excelsrc.dll                                    | 2015.130.4502.0 | 232624    | 15-May-2018 | 00:57 | x86      |
| Flatfiledest.dll                                | 2015.130.4502.0 | 334512    | 15-May-2018 | 00:57 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4502.0 | 345264    | 15-May-2018 | 00:57 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4502.0 | 80560     | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4502.0     | 92336     | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4502.0     | 1313456   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4502.0     | 696488    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4502.0     | 763568    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4502.0 | 2023088   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4502.0 | 42160     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4502.0     | 186544    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4502.0     | 433840    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4502.0     | 2044592   | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4502.0     | 33456     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4502.0     | 249520    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4502.0     | 501936    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4502.0     | 106160    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4502.0 | 138928    | 15-May-2018 | 00:57 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4502.0 | 144552    | 15-May-2018 | 00:57 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4502.0 | 89776     | 15-May-2018 | 00:58 | x86      |
| Msmdlocal.dll                                   | 2015.130.4502.0 | 37099184  | 15-May-2018 | 00:58 | x86      |
| Msmdpp.dll                                      | 2015.130.4502.0 | 6370480   | 15-May-2018 | 00:58 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4502.0 | 6507696   | 15-May-2018 | 00:58 | x86      |
| Msolap130.dll                                   | 2015.130.4502.0 | 7008944   | 15-May-2018 | 00:58 | x86      |
| Msolui130.dll                                   | 2015.130.4502.0 | 287408    | 15-May-2018 | 00:58 | x86      |
| Oledbdest.dll                                   | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:58 | x86      |
| Oledbsrc.dll                                    | 2015.130.4502.0 | 235696    | 15-May-2018 | 00:58 | x86      |
| Profiler.exe                                    | 2015.130.4502.0 | 804528    | 15-May-2018 | 00:51 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x86      |
| Sqldumper.exe                                   | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |
| Sqlresld.dll                                    | 2015.130.4502.0 | 28848     | 15-May-2018 | 00:58 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |
| Sqlscm.dll                                      | 2015.130.4502.0 | 52912     | 15-May-2018 | 00:58 | x86      |
| Sqlsvc.dll                                      | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:58 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4502.0 | 151208    | 15-May-2018 | 00:58 | x86      |
| Txdataconvert.dll                               | 2015.130.4502.0 | 255152    | 15-May-2018 | 00:56 | x86      |
| Xe.dll                                          | 2015.130.4502.0 | 558760    | 15-May-2018 | 00:57 | x86      |
| Xmlrw.dll                                       | 2015.130.4502.0 | 259760    | 15-May-2018 | 00:56 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4502.0 | 191656    | 15-May-2018 | 00:56 | x86      |
| Xmsrv.dll                                       | 2015.130.4502.0 | 32727720  | 15-May-2018 | 00:56 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4502.0 | 53424     | 15-May-2018 | 00:57 | x86      |
| Keyfile.dll    | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x86      |
| Msmdredir.dll  | 2015.130.4502.0 | 6421680   | 15-May-2018 | 00:58 | x86      |
| Msmdsrv.rll    | 2015.130.4502.0 | 1296560   | 15-May-2018 | 00:58 | x86      |
| Msmdsrvi.rll   | 2015.130.4502.0 | 1293488   | 15-May-2018 | 00:58 | x86      |
| Sqlbrowser.exe | 2015.130.4502.0 | 276656    | 15-May-2018 | 00:57 | x86      |
| Sqldumper.exe  | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58 | x64      |
| Sqlboot.dll           | 2015.130.4502.0 | 186544    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe         | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:56 | x64      |
| Sqlvdi.dll            | 2015.130.4502.0 | 168624    | 15-May-2018 | 00:58 | x86      |
| Sqlvdi.dll            | 2015.130.4502.0 | 197296    | 15-May-2018 | 00:58 | x64      |
| Sqlwriter.exe         | 2015.130.4502.0 | 131760    | 15-May-2018 | 00:57 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlwvss.dll           | 2015.130.4502.0 | 336560    | 15-May-2018 | 00:56 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4502.0 | 26288     | 15-May-2018 | 00:56 | x64      |

SQL Server 2016 Analysis Services

| File name                                          | File version    | File size | Date        | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-------------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4502.0     | 1347760   | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4502.0     | 765616    | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4502.0     | 521392    | 15-May-2018 | 00:57 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787      | 239328    | 10-May-2018 | 13:11 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4502.0     | 989872    | 15-May-2018 | 00:58 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4502.0     | 989872    | 15-May-2018 | 00:58 | x86      |
| Msmdctr130.dll                                     | 2015.130.4502.0 | 40104     | 15-May-2018 | 00:56 | x64      |
| Msmdlocal.dll                                      | 2015.130.4502.0 | 56207024  | 15-May-2018 | 00:56 | x64      |
| Msmdlocal.dll                                      | 2015.130.4502.0 | 37099184  | 15-May-2018 | 00:58 | x86      |
| Msmdpump.dll                                       | 2015.130.4502.0 | 7798960   | 15-May-2018 | 00:56 | x64      |
| Msmdredir.dll                                      | 2015.130.4502.0 | 6421680   | 15-May-2018 | 00:58 | x86      |
| Msmdsrv.exe                                        | 2015.130.4502.0 | 56745136  | 15-May-2018 | 00:57 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4502.0 | 7507120   | 15-May-2018 | 00:56 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4502.0 | 6507696   | 15-May-2018 | 00:58 | x86      |
| Msolap130.dll                                      | 2015.130.4502.0 | 8639664   | 15-May-2018 | 00:56 | x64      |
| Msolap130.dll                                      | 2015.130.4502.0 | 7008944   | 15-May-2018 | 00:58 | x86      |
| Msolui130.dll                                      | 2015.130.4502.0 | 310448    | 15-May-2018 | 00:56 | x64      |
| Msolui130.dll                                      | 2015.130.4502.0 | 287408    | 15-May-2018 | 00:58 | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlboot.dll                                        | 2015.130.4502.0 | 186544    | 15-May-2018 | 00:56 | x64      |
| Sqlceip.exe                                        | 13.0.4502.0     | 250544    | 15-May-2018 | 00:57 | x86      |
| Sqldumper.exe                                      | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                      | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |
| Tmapi.dll                                          | 2015.130.4502.0 | 4346032   | 15-May-2018 | 00:56 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4502.0 | 2826408   | 15-May-2018 | 00:56 | x64      |
| Tmpersistence.dll                                  | 2015.130.4502.0 | 1071280   | 15-May-2018 | 00:56 | x64      |
| Tmtransactions.dll                                 | 2015.130.4502.0 | 1352368   | 15-May-2018 | 00:56 | x64      |
| Xe.dll                                             | 2015.130.4502.0 | 626352    | 15-May-2018 | 00:58 | x64      |
| Xmlrw.dll                                          | 2015.130.4502.0 | 259760    | 15-May-2018 | 00:56 | x86      |
| Xmlrw.dll                                          | 2015.130.4502.0 | 319152    | 15-May-2018 | 00:58 | x64      |
| Xmlrwbin.dll                                       | 2015.130.4502.0 | 191656    | 15-May-2018 | 00:56 | x86      |
| Xmlrwbin.dll                                       | 2015.130.4502.0 | 227504    | 15-May-2018 | 00:58 | x64      |
| Xmsrv.dll                                          | 2015.130.4502.0 | 32727720  | 15-May-2018 | 00:56 | x86      |
| Xmsrv.dll                                          | 2015.130.4502.0 | 24050864  | 15-May-2018 | 00:56 | x64      |

SQL Server 2016 Database Services Common Core

| File name                                   | File version     | File size | Date        | Time  | Platform |
|---------------------------------------------|------------------|-----------|-------------|-------|----------|
| Batchparser.dll                             | 2015.130.4502.0  | 160432    | 15-May-2018 | 00:57 | x86      |
| Batchparser.dll                             | 2015.130.4502.0  | 180912    | 15-May-2018 | 00:58 | x64      |
| Instapi130.dll                              | 2015.130.4502.0  | 53424     | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                              | 2015.130.4502.0  | 61104     | 15-May-2018 | 00:58 | x64      |
| Isacctchange.dll                            | 2015.130.4502.0  | 30896     | 15-May-2018 | 00:56 | x64      |
| Isacctchange.dll                            | 2015.130.4502.0  | 29360     | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4502.0      | 1027248   | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4502.0      | 1027248   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4502.0      | 1348784   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4502.0      | 702640    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4502.0      | 765616    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4502.0      | 520880    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4502.0      | 711856    | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4502.0      | 711856    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4502.0      | 37040     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4502.0      | 46256     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4502.0  | 75440     | 15-May-2018 | 00:56 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4502.0  | 72880     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4502.0      | 598704    | 15-May-2018 | 00:56 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4502.0      | 598704    | 15-May-2018 | 00:58 | x86      |
| Msasxpress.dll                              | 2015.130.4502.0  | 36016     | 15-May-2018 | 00:56 | x64      |
| Msasxpress.dll                              | 2015.130.4502.0  | 31920     | 15-May-2018 | 00:58 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4502.0  | 72880     | 15-May-2018 | 00:56 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4502.0  | 60080     | 15-May-2018 | 00:58 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4502.0  | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                               | 2015.130.4502.0  | 127152    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                               | 2015.130.4502.0  | 107688    | 15-May-2018 | 00:57 | x86      |
| Sqlftacct.dll                               | 2015.130.4502.0  | 51888     | 15-May-2018 | 00:56 | x64      |
| Sqlftacct.dll                               | 2015.130.4502.0  | 46768     | 15-May-2018 | 00:58 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018 | 05:18 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018 | 04:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4502.0  | 404144    | 15-May-2018 | 00:56 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4502.0  | 364208    | 15-May-2018 | 00:58 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4502.0  | 37552     | 15-May-2018 | 00:56 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4502.0  | 34984     | 15-May-2018 | 00:58 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4502.0  | 348848    | 15-May-2018 | 00:56 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4502.0  | 267440    | 15-May-2018 | 00:58 | x86      |
| Sqltdiagn.dll                               | 2015.130.4502.0  | 67760     | 15-May-2018 | 00:56 | x64      |
| Sqltdiagn.dll                               | 2015.130.4502.0  | 60584     | 15-May-2018 | 00:58 | x86      |
| Svrenumapi130.dll                           | 2015.130.4502.0  | 1115824   | 15-May-2018 | 00:56 | x64      |
| Svrenumapi130.dll                           | 2015.130.4502.0  | 854192    | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4502.0  | 1876656   | 15-May-2018 | 00:56 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4502.0  | 1876648   | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4502.0 | 121008    | 15-May-2018 | 00:57 | x86      |
| Dreplaycommon.dll              | 2015.130.4502.0 | 690864    | 15-May-2018 | 00:58 | x86      |
| Dreplayserverps.dll            | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:57 | x86      |
| Dreplayutil.dll                | 2015.130.4502.0 | 309936    | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                 | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlresourceloader.dll          | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4502.0 | 690864    | 15-May-2018 | 00:58 | x86      |
| Dreplaycontroller.exe              | 2015.130.4502.0 | 350384    | 15-May-2018 | 00:57 | x86      |
| Dreplayprocess.dll                 | 2015.130.4502.0 | 171696    | 15-May-2018 | 00:57 | x86      |
| Dreplayserverps.dll                | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:57 | x86      |
| Instapi130.dll                     | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlresourceloader.dll              | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4502.0     | 41136     | 15-May-2018 | 00:57  | x64      |
| Batchparser.dll                              | 2015.130.4502.0 | 180912    | 15-May-2018 | 00:58  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925360    | 15-May-2018 | 00:56  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341360   | 15-May-2018 | 00:56  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192176    | 15-May-2018 | 00:56  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 01:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4502.0 | 225456    | 15-May-2018 | 00:56  | x64      |
| Dcexec.exe                                   | 2015.130.4502.0 | 74416     | 15-May-2018 | 00:57  | x64      |
| Fssres.dll                                   | 2015.130.4502.0 | 81584     | 15-May-2018 | 00:56  | x64      |
| Hadrres.dll                                  | 2015.130.4502.0 | 177840    | 15-May-2018 | 00:58  | x64      |
| Hkcompile.dll                                | 2015.130.4502.0 | 1298096   | 15-May-2018 | 00:58  | x64      |
| Hkengine.dll                                 | 2015.130.4502.0 | 5600944   | 15-May-2018 | 00:56  | x64      |
| Hkruntime.dll                                | 2015.130.4502.0 | 158896    | 15-May-2018 | 00:56  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017520   | 15-May-2018 | 00:56  | x64      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787      | 239328    | 10-May-2018 | 13:11 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4502.0     | 235184    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4502.0     | 79528     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4502.0 | 391856    | 15-May-2018 | 00:56  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4502.0 | 71344     | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4502.0 | 65200     | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4502.0 | 150192    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4502.0 | 158896    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4502.0 | 272048    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4502.0 | 74928     | 15-May-2018 | 00:56  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129712    | 15-May-2018 | 00:56  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559280    | 15-May-2018 | 00:56  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559280    | 15-May-2018 | 00:56  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661168    | 15-May-2018 | 00:56  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964784    | 15-May-2018 | 00:56  | x64      |
| Odsole70.dll                                 | 2015.130.4502.0 | 92848     | 15-May-2018 | 00:56  | x64      |
| Opends60.dll                                 | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:58  | x64      |
| Qds.dll                                      | 2015.130.4502.0 | 845488    | 15-May-2018 | 00:56  | x64      |
| Rsfxft.dll                                   | 2015.130.4502.0 | 34480     | 15-May-2018 | 00:58  | x64      |
| Sqagtres.dll                                 | 2015.130.4502.0 | 64688     | 15-May-2018 | 00:56  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56  | x64      |
| Sqlaamss.dll                                 | 2015.130.4502.0 | 80560     | 15-May-2018 | 00:56  | x64      |
| Sqlaccess.dll                                | 2015.130.4502.0 | 462512    | 15-May-2018 | 00:56  | x64      |
| Sqlagent.exe                                 | 2015.130.4502.0 | 566448    | 15-May-2018 | 00:57  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4502.0 | 51888     | 15-May-2018 | 00:57  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4502.0 | 44208     | 15-May-2018 | 00:58  | x86      |
| Sqlagentlog.dll                              | 2015.130.4502.0 | 32944     | 15-May-2018 | 00:56  | x64      |
| Sqlagentmail.dll                             | 2015.130.4502.0 | 47792     | 15-May-2018 | 00:56  | x64      |
| Sqlboot.dll                                  | 2015.130.4502.0 | 186544    | 15-May-2018 | 00:56  | x64      |
| Sqlceip.exe                                  | 13.0.4502.0     | 250544    | 15-May-2018 | 00:57  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4502.0 | 60080     | 15-May-2018 | 00:56  | x64      |
| Sqlctr130.dll                                | 2015.130.4502.0 | 103600    | 15-May-2018 | 00:58  | x86      |
| Sqlctr130.dll                                | 2015.130.4502.0 | 118448    | 15-May-2018 | 00:58  | x64      |
| Sqldk.dll                                    | 2015.130.4502.0 | 2586800   | 15-May-2018 | 00:56  | x64      |
| Sqldtsss.dll                                 | 2015.130.4502.0 | 97456     | 15-May-2018 | 00:56  | x64      |
| Sqliosim.com                                 | 2015.130.4502.0 | 307888    | 15-May-2018 | 00:57  | x64      |
| Sqliosim.exe                                 | 2015.130.4502.0 | 3014320   | 15-May-2018 | 00:57  | x64      |
| Sqllang.dll                                  | 2015.130.4502.0 | 39441072  | 15-May-2018 | 00:56  | x64      |
| Sqlmin.dll                                   | 2015.130.4502.0 | 37582512  | 15-May-2018 | 00:56  | x64      |
| Sqlolapss.dll                                | 2015.130.4502.0 | 97960     | 15-May-2018 | 00:56  | x64      |
| Sqlos.dll                                    | 2015.130.4502.0 | 26288     | 15-May-2018 | 00:58  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4502.0 | 58544     | 15-May-2018 | 00:56  | x64      |
| Sqlrepss.dll                                 | 2015.130.4502.0 | 54960     | 15-May-2018 | 00:56  | x64      |
| Sqlresld.dll                                 | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56  | x64      |
| Sqlscm.dll                                   | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4502.0 | 27824     | 15-May-2018 | 00:56  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4502.0 | 5798576   | 15-May-2018 | 00:58  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4502.0 | 732848    | 15-May-2018 | 00:58  | x64      |
| Sqlservr.exe                                 | 2015.130.4502.0 | 393392    | 15-May-2018 | 00:57  | x64      |
| Sqlsvc.dll                                   | 2015.130.4502.0 | 152240    | 15-May-2018 | 00:56  | x64      |
| Sqltses.dll                                  | 2015.130.4502.0 | 8896688   | 15-May-2018 | 00:56  | x64      |
| Sqsrvres.dll                                 | 2015.130.4502.0 | 251056    | 15-May-2018 | 00:56  | x64      |
| Stretchcodegen.exe                           | 13.0.4502.0     | 55984     | 15-May-2018 | 00:57  | x86      |
| Xe.dll                                       | 2015.130.4502.0 | 626352    | 15-May-2018 | 00:58  | x64      |
| Xmlrw.dll                                    | 2015.130.4502.0 | 319152    | 15-May-2018 | 00:58  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4502.0 | 227504    | 15-May-2018 | 00:58  | x64      |
| Xpadsi.exe                                   | 2015.130.4502.0 | 79024     | 15-May-2018 | 00:58  | x64      |
| Xplog70.dll                                  | 2015.130.4502.0 | 65712     | 15-May-2018 | 00:58  | x64      |
| Xpqueue.dll                                  | 2015.130.4502.0 | 74928     | 15-May-2018 | 00:56  | x64      |
| Xprepl.dll                                   | 2015.130.4502.0 | 91312     | 15-May-2018 | 00:56  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4502.0 | 33456     | 15-May-2018 | 00:58  | x64      |
| Xpstar.dll                                   | 2015.130.4502.0 | 422576    | 15-May-2018 | 00:58  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4502.0 | 160432    | 15-May-2018 | 00:57  | x86      |
| Batchparser.dll                                                    | 2015.130.4502.0 | 180912    | 15-May-2018 | 00:58  | x64      |
| Bcp.exe                                                            | 2015.130.4502.0 | 119984    | 15-May-2018 | 00:56  | x64      |
| Commanddest.dll                                                    | 2015.130.4502.0 | 249008    | 15-May-2018 | 00:56  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4502.0 | 115888    | 15-May-2018 | 00:56  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4502.0 | 188080    | 15-May-2018 | 00:56  | x64      |
| Distrib.exe                                                        | 2015.130.4502.0 | 191152    | 15-May-2018 | 00:57  | x64      |
| Dteparse.dll                                                       | 2015.130.4502.0 | 109744    | 15-May-2018 | 00:56  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57  | x64      |
| Dtepkg.dll                                                         | 2015.130.4502.0 | 137392    | 15-May-2018 | 00:56  | x64      |
| Dtexec.exe                                                         | 2015.130.4502.0 | 72880     | 15-May-2018 | 00:57  | x64      |
| Dts.dll                                                            | 2015.130.4502.0 | 3146928   | 15-May-2018 | 00:56  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4502.0 | 477360    | 15-May-2018 | 00:56  | x64      |
| Dtsconn.dll                                                        | 2015.130.4502.0 | 492720    | 15-May-2018 | 00:56  | x64      |
| Dtshost.exe                                                        | 2015.130.4502.0 | 86704     | 15-May-2018 | 00:57  | x64      |
| Dtslog.dll                                                         | 2015.130.4502.0 | 120496    | 15-May-2018 | 00:56  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4502.0 | 545456    | 15-May-2018 | 00:56  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4502.0 | 1279152   | 15-May-2018 | 00:56  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4502.0 | 48304     | 15-May-2018 | 00:56  | x64      |
| Dtswizard.exe                                                      | 13.0.4502.0     | 895664    | 15-May-2018 | 00:57  | x64      |
| Dtuparse.dll                                                       | 2015.130.4502.0 | 87728     | 15-May-2018 | 00:56  | x64      |
| Dtutil.exe                                                         | 2015.130.4502.0 | 134832    | 15-May-2018 | 00:57  | x64      |
| Exceldest.dll                                                      | 2015.130.4502.0 | 263336    | 15-May-2018 | 00:56  | x64      |
| Excelsrc.dll                                                       | 2015.130.4502.0 | 285352    | 15-May-2018 | 00:56  | x64      |
| Execpackagetask.dll                                                | 2015.130.4502.0 | 166576    | 15-May-2018 | 00:56  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4502.0 | 389296    | 15-May-2018 | 00:56  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4502.0 | 401584    | 15-May-2018 | 00:56  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4502.0 | 96432     | 15-May-2018 | 00:56  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4502.0 | 59056     | 15-May-2018 | 00:58  | x64      |
| Logread.exe                                                        | 2015.130.4502.0 | 617136    | 15-May-2018 | 00:57  | x64      |
| Mergetxt.dll                                                       | 2015.130.4502.0 | 53936     | 15-May-2018 | 00:56  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4502.0     | 1313456   | 15-May-2018 | 00:57  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4502.0     | 696496    | 15-May-2018 | 00:57  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4502.0     | 763568    | 15-May-2018 | 00:57  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 14-May-2018 | 13:40 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4502.0     | 54448     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4502.0     | 89776     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4502.0     | 49840     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4502.0     | 43184     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4502.0     | 70832     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4502.0     | 35504     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4502.0     | 63664     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4502.0     | 31408     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4502.0     | 131248    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4502.0     | 43696     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4502.0     | 57520     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4502.0     | 215216    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4502.0 | 1639088   | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4502.0 | 150192    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4502.0 | 158896    | 15-May-2018 | 00:56  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4502.0 | 101040    | 15-May-2018 | 00:56  | x64      |
| Msgprox.dll                                                        | 2015.130.4502.0 | 275632    | 15-May-2018 | 00:56  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4502.0 | 1494704   | 15-May-2018 | 00:58  | x64      |
| Oledbdest.dll                                                      | 2015.130.4502.0 | 264360    | 15-May-2018 | 00:56  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4502.0 | 290992    | 15-May-2018 | 00:56  | x64      |
| Osql.exe                                                           | 2015.130.4502.0 | 75440     | 15-May-2018 | 00:56  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4502.0 | 469168    | 15-May-2018 | 00:57  | x64      |
| Rawdest.dll                                                        | 2015.130.4502.0 | 209584    | 15-May-2018 | 00:56  | x64      |
| Rawsource.dll                                                      | 2015.130.4502.0 | 196784    | 15-May-2018 | 00:56  | x64      |
| Rdistcom.dll                                                       | 2015.130.4502.0 | 893616    | 15-May-2018 | 00:56  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4502.0 | 187056    | 15-May-2018 | 00:56  | x64      |
| Replagnt.dll                                                       | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56  | x64      |
| Repldp.dll                                                         | 2015.130.4502.0 | 277168    | 15-May-2018 | 00:56  | x64      |
| Replerrx.dll                                                       | 2015.130.4502.0 | 144552    | 15-May-2018 | 00:56  | x64      |
| Replisapi.dll                                                      | 2015.130.4502.0 | 354472    | 15-May-2018 | 00:56  | x64      |
| Replmerg.exe                                                       | 2015.130.4502.0 | 518832    | 15-May-2018 | 00:57  | x64      |
| Replprov.dll                                                       | 2015.130.4502.0 | 812208    | 15-May-2018 | 00:56  | x64      |
| Replrec.dll                                                        | 2015.130.4502.0 | 1018544   | 15-May-2018 | 00:56  | x64      |
| Replsub.dll                                                        | 2015.130.4502.0 | 467632    | 15-May-2018 | 00:56  | x64      |
| Replsync.dll                                                       | 2015.130.4502.0 | 144048    | 15-May-2018 | 00:56  | x64      |
| Spresolv.dll                                                       | 2015.130.4502.0 | 245424    | 15-May-2018 | 00:56  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4502.0 | 249520    | 15-May-2018 | 00:56  | x64      |
| Sqldiag.exe                                                        | 2015.130.4502.0 | 1257648   | 15-May-2018 | 00:57  | x64      |
| Sqldistx.dll                                                       | 2015.130.4502.0 | 215728    | 15-May-2018 | 00:56  | x64      |
| Sqllogship.exe                                                     | 13.0.4502.0     | 100528    | 15-May-2018 | 00:57  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4502.0 | 346800    | 15-May-2018 | 00:56  | x64      |
| Sqlps.exe                                                          | 13.0.4502.0     | 60080     | 15-May-2018 | 00:51  | x86      |
| Sqlresld.dll                                                       | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56  | x64      |
| Sqlresld.dll                                                       | 2015.130.4502.0 | 28848     | 15-May-2018 | 00:58  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58  | x86      |
| Sqlscm.dll                                                         | 2015.130.4502.0 | 52912     | 15-May-2018 | 00:58  | x86      |
| Sqlscm.dll                                                         | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4502.0 | 152240    | 15-May-2018 | 00:56  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:58  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4502.0 | 180912    | 15-May-2018 | 00:56  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4502.0 | 105648    | 15-May-2018 | 00:56  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4502.0 | 33456     | 15-May-2018 | 00:56  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4502.0 | 216240    | 15-May-2018 | 00:56  | x64      |
| Ssradd.dll                                                         | 2015.130.4502.0 | 65200     | 15-May-2018 | 00:56  | x64      |
| Ssravg.dll                                                         | 2015.130.4502.0 | 65200     | 15-May-2018 | 00:56  | x64      |
| Ssrdown.dll                                                        | 2015.130.4502.0 | 50864     | 15-May-2018 | 00:56  | x64      |
| Ssrmax.dll                                                         | 2015.130.4502.0 | 63664     | 15-May-2018 | 00:56  | x64      |
| Ssrmin.dll                                                         | 2015.130.4502.0 | 63656     | 15-May-2018 | 00:56  | x64      |
| Ssrpub.dll                                                         | 2015.130.4502.0 | 51376     | 15-May-2018 | 00:56  | x64      |
| Ssrup.dll                                                          | 2015.130.4502.0 | 50864     | 15-May-2018 | 00:56  | x64      |
| Txagg.dll                                                          | 2015.130.4502.0 | 364720    | 15-May-2018 | 00:56  | x64      |
| Txbdd.dll                                                          | 2015.130.4502.0 | 172720    | 15-May-2018 | 00:56  | x64      |
| Txdatacollector.dll                                                | 2015.130.4502.0 | 367792    | 15-May-2018 | 00:56  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4502.0 | 296624    | 15-May-2018 | 00:56  | x64      |
| Txderived.dll                                                      | 2015.130.4502.0 | 607920    | 15-May-2018 | 00:56  | x64      |
| Txlookup.dll                                                       | 2015.130.4502.0 | 532144    | 15-May-2018 | 00:56  | x64      |
| Txmerge.dll                                                        | 2015.130.4502.0 | 230064    | 15-May-2018 | 00:56  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4502.0 | 278704    | 15-May-2018 | 00:56  | x64      |
| Txmulticast.dll                                                    | 2015.130.4502.0 | 128176    | 15-May-2018 | 00:56  | x64      |
| Txrowcount.dll                                                     | 2015.130.4502.0 | 126640    | 15-May-2018 | 00:56  | x64      |
| Txsort.dll                                                         | 2015.130.4502.0 | 258736    | 15-May-2018 | 00:56  | x64      |
| Txsplit.dll                                                        | 2015.130.4502.0 | 600752    | 15-May-2018 | 00:56  | x64      |
| Txunionall.dll                                                     | 2015.130.4502.0 | 181936    | 15-May-2018 | 00:56  | x64      |
| Xe.dll                                                             | 2015.130.4502.0 | 626352    | 15-May-2018 | 00:58  | x64      |
| Xmlrw.dll                                                          | 2015.130.4502.0 | 319152    | 15-May-2018 | 00:58  | x64      |
| Xmlsub.dll                                                         | 2015.130.4502.0 | 251056    | 15-May-2018 | 00:56  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4502.0 | 1013936   | 15-May-2018 | 00:56 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlsatellite.dll              | 2015.130.4502.0 | 837296    | 15-May-2018 | 00:58 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4502.0 | 660144    | 15-May-2018 | 00:58 | x64      |
| Fdhost.exe               | 2015.130.4502.0 | 105136    | 15-May-2018 | 00:56 | x64      |
| Fdlauncher.exe           | 2015.130.4502.0 | 51376     | 15-May-2018 | 00:56 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqlft130ph.dll           | 2015.130.4502.0 | 58032     | 15-May-2018 | 00:58 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4502.0     | 23728     | 15-May-2018 | 00:57 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 06-Apr-2018  | 11:09 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 08-Apr-2018  | 00:02  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 06-Apr-2018  | 11:09 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 08-Apr-2018  | 00:02  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 06-Apr-2018  | 11:09 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 08-Apr-2018  | 00:02  | x86      |
| Commanddest.dll                                                    | 2015.130.4502.0 | 249008    | 15-May-2018 | 00:56  | x64      |
| Commanddest.dll                                                    | 2015.130.4502.0 | 202928    | 15-May-2018 | 00:57  | x86      |
| Dteparse.dll                                                       | 2015.130.4502.0 | 109744    | 15-May-2018 | 00:56  | x64      |
| Dteparse.dll                                                       | 2015.130.4502.0 | 99504     | 15-May-2018 | 00:57  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4502.0 | 83632     | 15-May-2018 | 00:58  | x86      |
| Dtepkg.dll                                                         | 2015.130.4502.0 | 137392    | 15-May-2018 | 00:56  | x64      |
| Dtepkg.dll                                                         | 2015.130.4502.0 | 115880    | 15-May-2018 | 00:57  | x86      |
| Dtexec.exe                                                         | 2015.130.4502.0 | 72880     | 15-May-2018 | 00:57  | x64      |
| Dtexec.exe                                                         | 2015.130.4502.0 | 66736     | 15-May-2018 | 00:57  | x86      |
| Dts.dll                                                            | 2015.130.4502.0 | 3146928   | 15-May-2018 | 00:56  | x64      |
| Dts.dll                                                            | 2015.130.4502.0 | 2632880   | 15-May-2018 | 00:57  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4502.0 | 477360    | 15-May-2018 | 00:56  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4502.0 | 418992    | 15-May-2018 | 00:57  | x86      |
| Dtsconn.dll                                                        | 2015.130.4502.0 | 492720    | 15-May-2018 | 00:56  | x64      |
| Dtsconn.dll                                                        | 2015.130.4502.0 | 392368    | 15-May-2018 | 00:57  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4502.0 | 109744    | 15-May-2018 | 00:57  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4502.0 | 93872     | 15-May-2018 | 00:57  | x86      |
| Dtshost.exe                                                        | 2015.130.4502.0 | 86704     | 15-May-2018 | 00:57  | x64      |
| Dtshost.exe                                                        | 2015.130.4502.0 | 76464     | 15-May-2018 | 00:57  | x86      |
| Dtslog.dll                                                         | 2015.130.4502.0 | 120496    | 15-May-2018 | 00:56  | x64      |
| Dtslog.dll                                                         | 2015.130.4502.0 | 103088    | 15-May-2018 | 00:57  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4502.0 | 545456    | 15-May-2018 | 00:56  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4502.0 | 541360    | 15-May-2018 | 00:57  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4502.0 | 1279152   | 15-May-2018 | 00:56  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4502.0 | 1059504   | 15-May-2018 | 00:57  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4502.0 | 48304     | 15-May-2018 | 00:56  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4502.0 | 42160     | 15-May-2018 | 00:57  | x86      |
| Dtswizard.exe                                                      | 13.0.4502.0     | 896176    | 15-May-2018 | 00:51  | x86      |
| Dtswizard.exe                                                      | 13.0.4502.0     | 895664    | 15-May-2018 | 00:57  | x64      |
| Dtuparse.dll                                                       | 2015.130.4502.0 | 87728     | 15-May-2018 | 00:56  | x64      |
| Dtuparse.dll                                                       | 2015.130.4502.0 | 80048     | 15-May-2018 | 00:57  | x86      |
| Dtutil.exe                                                         | 2015.130.4502.0 | 134832    | 15-May-2018 | 00:57  | x64      |
| Dtutil.exe                                                         | 2015.130.4502.0 | 115376    | 15-May-2018 | 00:57  | x86      |
| Exceldest.dll                                                      | 2015.130.4502.0 | 263336    | 15-May-2018 | 00:56  | x64      |
| Exceldest.dll                                                      | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:57  | x86      |
| Excelsrc.dll                                                       | 2015.130.4502.0 | 285352    | 15-May-2018 | 00:56  | x64      |
| Excelsrc.dll                                                       | 2015.130.4502.0 | 232624    | 15-May-2018 | 00:57  | x86      |
| Execpackagetask.dll                                                | 2015.130.4502.0 | 166576    | 15-May-2018 | 00:56  | x64      |
| Execpackagetask.dll                                                | 2015.130.4502.0 | 135344    | 15-May-2018 | 00:57  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4502.0 | 389296    | 15-May-2018 | 00:56  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4502.0 | 334512    | 15-May-2018 | 00:57  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4502.0 | 401584    | 15-May-2018 | 00:56  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4502.0 | 345264    | 15-May-2018 | 00:57  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4502.0 | 96432     | 15-May-2018 | 00:56  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4502.0 | 80560     | 15-May-2018 | 00:57  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4502.0     | 439984    | 15-May-2018 | 00:51  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4502.0     | 438960    | 15-May-2018 | 00:57  | x64      |
| Isserverexec.exe                                                   | 13.0.4502.0     | 132784    | 15-May-2018 | 00:51  | x86      |
| Isserverexec.exe                                                   | 13.0.4502.0     | 132272    | 15-May-2018 | 00:57  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4502.0     | 1313456   | 15-May-2018 | 00:57  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4502.0     | 1313456   | 15-May-2018 | 00:58  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4502.0     | 696496    | 15-May-2018 | 00:57  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4502.0     | 696488    | 15-May-2018 | 00:58  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4502.0     | 763568    | 15-May-2018 | 00:57  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4502.0     | 763568    | 15-May-2018 | 00:58  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.6.0.6787      | 239328    | 10-May-2018 | 13:11 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 14-May-2018 | 13:31 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 14-May-2018 | 13:40 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4502.0 | 112304    | 15-May-2018 | 00:58  | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4502.0 | 107184    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4502.0     | 54448     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4502.0     | 54448     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4502.0     | 89776     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4502.0     | 89776     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4502.0     | 43184     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4502.0     | 43184     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4502.0     | 35504     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4502.0     | 35504     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4502.0     | 31408     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4502.0     | 31408     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4502.0     | 469680    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4502.0     | 469680    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4502.0     | 43696     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4502.0     | 43696     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4502.0     | 57520     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4502.0     | 57520     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4502.0     | 52912     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4502.0     | 52912     | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4502.0 | 150192    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4502.0 | 138928    | 15-May-2018 | 00:57  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4502.0 | 158896    | 15-May-2018 | 00:56  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4502.0 | 144552    | 15-May-2018 | 00:57  | x86      |
| Msdtssrvr.exe                                                      | 13.0.4502.0     | 216752    | 15-May-2018 | 00:57  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4502.0 | 101040    | 15-May-2018 | 00:56  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4502.0 | 89776     | 15-May-2018 | 00:58  | x86      |
| Msmdpp.dll                                                         | 2015.130.4502.0 | 7646896   | 15-May-2018 | 00:56  | x64      |
| Oledbdest.dll                                                      | 2015.130.4502.0 | 264360    | 15-May-2018 | 00:56  | x64      |
| Oledbdest.dll                                                      | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:58  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4502.0 | 290992    | 15-May-2018 | 00:56  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4502.0 | 235696    | 15-May-2018 | 00:58  | x86      |
| Rawdest.dll                                                        | 2015.130.4502.0 | 209584    | 15-May-2018 | 00:56  | x64      |
| Rawdest.dll                                                        | 2015.130.4502.0 | 168624    | 15-May-2018 | 00:58  | x86      |
| Rawsource.dll                                                      | 2015.130.4502.0 | 196784    | 15-May-2018 | 00:56  | x64      |
| Rawsource.dll                                                      | 2015.130.4502.0 | 155312    | 15-May-2018 | 00:58  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4502.0 | 187056    | 15-May-2018 | 00:56  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4502.0 | 151728    | 15-May-2018 | 00:58  | x86      |
| Sql_is_keyfile.dll                                                 | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56  | x64      |
| Sqlceip.exe                                                        | 13.0.4502.0     | 250544    | 15-May-2018 | 00:57  | x86      |
| Sqldest.dll                                                        | 2015.130.4502.0 | 263856    | 15-May-2018 | 00:56  | x64      |
| Sqldest.dll                                                        | 2015.130.4502.0 | 215728    | 15-May-2018 | 00:58  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4502.0 | 180912    | 15-May-2018 | 00:56  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4502.0 | 151208    | 15-May-2018 | 00:58  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4502.0 | 216240    | 15-May-2018 | 00:56  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4502.0 | 176816    | 15-May-2018 | 00:58  | x86      |
| Txagg.dll                                                          | 2015.130.4502.0 | 304816    | 15-May-2018 | 00:56  | x86      |
| Txagg.dll                                                          | 2015.130.4502.0 | 364720    | 15-May-2018 | 00:56  | x64      |
| Txbdd.dll                                                          | 2015.130.4502.0 | 137904    | 15-May-2018 | 00:56  | x86      |
| Txbdd.dll                                                          | 2015.130.4502.0 | 172720    | 15-May-2018 | 00:56  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4502.0 | 496304    | 15-May-2018 | 00:56  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4502.0 | 611504    | 15-May-2018 | 00:56  | x64      |
| Txcache.dll                                                        | 2015.130.4502.0 | 148144    | 15-May-2018 | 00:56  | x86      |
| Txcache.dll                                                        | 2015.130.4502.0 | 183472    | 15-May-2018 | 00:56  | x64      |
| Txcharmap.dll                                                      | 2015.130.4502.0 | 250544    | 15-May-2018 | 00:56  | x86      |
| Txcharmap.dll                                                      | 2015.130.4502.0 | 289968    | 15-May-2018 | 00:56  | x64      |
| Txcopymap.dll                                                      | 2015.130.4502.0 | 147632    | 15-May-2018 | 00:56  | x86      |
| Txcopymap.dll                                                      | 2015.130.4502.0 | 182952    | 15-May-2018 | 00:56  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4502.0 | 255152    | 15-May-2018 | 00:56  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4502.0 | 296624    | 15-May-2018 | 00:56  | x64      |
| Txderived.dll                                                      | 2015.130.4502.0 | 519344    | 15-May-2018 | 00:56  | x86      |
| Txderived.dll                                                      | 2015.130.4502.0 | 607920    | 15-May-2018 | 00:56  | x64      |
| Txfileextractor.dll                                                | 2015.130.4502.0 | 162992    | 15-May-2018 | 00:56  | x86      |
| Txfileextractor.dll                                                | 2015.130.4502.0 | 201904    | 15-May-2018 | 00:56  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4502.0 | 160936    | 15-May-2018 | 00:56  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4502.0 | 199856    | 15-May-2018 | 00:56  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4502.0 | 231600    | 15-May-2018 | 00:56  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4502.0 | 290992    | 15-May-2018 | 00:56  | x64      |
| Txlineage.dll                                                      | 2015.130.4502.0 | 109232    | 15-May-2018 | 00:56  | x86      |
| Txlineage.dll                                                      | 2015.130.4502.0 | 137392    | 15-May-2018 | 00:56  | x64      |
| Txlookup.dll                                                       | 2015.130.4502.0 | 449712    | 15-May-2018 | 00:56  | x86      |
| Txlookup.dll                                                       | 2015.130.4502.0 | 532144    | 15-May-2018 | 00:56  | x64      |
| Txmerge.dll                                                        | 2015.130.4502.0 | 176304    | 15-May-2018 | 00:56  | x86      |
| Txmerge.dll                                                        | 2015.130.4502.0 | 230064    | 15-May-2018 | 00:56  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4502.0 | 223920    | 15-May-2018 | 00:56  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4502.0 | 278704    | 15-May-2018 | 00:56  | x64      |
| Txmulticast.dll                                                    | 2015.130.4502.0 | 102064    | 15-May-2018 | 00:56  | x86      |
| Txmulticast.dll                                                    | 2015.130.4502.0 | 128176    | 15-May-2018 | 00:56  | x64      |
| Txpivot.dll                                                        | 2015.130.4502.0 | 181936    | 15-May-2018 | 00:56  | x86      |
| Txpivot.dll                                                        | 2015.130.4502.0 | 228016    | 15-May-2018 | 00:56  | x64      |
| Txrowcount.dll                                                     | 2015.130.4502.0 | 101552    | 15-May-2018 | 00:56  | x86      |
| Txrowcount.dll                                                     | 2015.130.4502.0 | 126640    | 15-May-2018 | 00:56  | x64      |
| Txsampling.dll                                                     | 2015.130.4502.0 | 134832    | 15-May-2018 | 00:56  | x86      |
| Txsampling.dll                                                     | 2015.130.4502.0 | 172208    | 15-May-2018 | 00:56  | x64      |
| Txscd.dll                                                          | 2015.130.4502.0 | 169648    | 15-May-2018 | 00:56  | x86      |
| Txscd.dll                                                          | 2015.130.4502.0 | 220336    | 15-May-2018 | 00:56  | x64      |
| Txsort.dll                                                         | 2015.130.4502.0 | 210608    | 15-May-2018 | 00:56  | x86      |
| Txsort.dll                                                         | 2015.130.4502.0 | 258736    | 15-May-2018 | 00:56  | x64      |
| Txsplit.dll                                                        | 2015.130.4502.0 | 513200    | 15-May-2018 | 00:56  | x86      |
| Txsplit.dll                                                        | 2015.130.4502.0 | 600752    | 15-May-2018 | 00:56  | x64      |
| Txtermextraction.dll                                               | 2015.130.4502.0 | 8615600   | 15-May-2018 | 00:56  | x86      |
| Txtermextraction.dll                                               | 2015.130.4502.0 | 8678064   | 15-May-2018 | 00:56  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4502.0 | 4106928   | 15-May-2018 | 00:56  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4502.0 | 4158640   | 15-May-2018 | 00:56  | x64      |
| Txunionall.dll                                                     | 2015.130.4502.0 | 138928    | 15-May-2018 | 00:56  | x86      |
| Txunionall.dll                                                     | 2015.130.4502.0 | 181936    | 15-May-2018 | 00:56  | x64      |
| Txunpivot.dll                                                      | 2015.130.4502.0 | 162480    | 15-May-2018 | 00:56  | x86      |
| Txunpivot.dll                                                      | 2015.130.4502.0 | 201904    | 15-May-2018 | 00:56  | x64      |
| Xe.dll                                                             | 2015.130.4502.0 | 558760    | 15-May-2018 | 00:57  | x86      |
| Xe.dll                                                             | 2015.130.4502.0 | 626352    | 15-May-2018 | 00:58  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 01:09 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 01:09 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 01:09 | x86      |
| Instapi130.dll                                                       | 2015.130.4502.0  | 61104     | 15-May-2018 | 00:56 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.43     | 74416     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.43     | 201896    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.43     | 2347184   | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.43     | 102064    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.43     | 378544    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.43     | 185512    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.43     | 127144    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.43     | 63152     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.43     | 52400     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.43     | 87208     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.43     | 721584    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.43     | 87208     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.43     | 78000     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.43     | 41640     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.43     | 36528     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.43     | 47792     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.43     | 27304     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.43     | 32936     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.43     | 118952    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.43     | 94384     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.43     | 108208    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.43     | 256680    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 102056    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 118952    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 115888    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 125608    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 117928    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 113328    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 145576    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 100016    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.43     | 114864    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.43     | 69296     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.43     | 28336     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.43     | 43696     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.43     | 82096     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.43     | 136872    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.43     | 2155688   | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.43     | 3818672   | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 107688    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119976    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 124592    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121008    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 133296    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 121000    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 118448    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 152240    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 105136    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.43     | 119472    | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.43     | 66736     | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.43     | 2756272   | 02-Feb-2018  | 01:09 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.43     | 752296    | 02-Feb-2018  | 01:09 | x86      |
| Mpdwinterop.dll                                                      | 2015.130.4502.0  | 394416    | 15-May-2018 | 00:56 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4502.0  | 6614192   | 15-May-2018 | 00:58 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4502.0  | 2155184   | 15-May-2018 | 00:56 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 01:09 | x64      |
| Sqldk.dll                                                            | 2015.130.4502.0  | 2530480   | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                                        | 2015.130.4502.0  | 127152    | 15-May-2018 | 00:58 | x64      |
| Sqlos.dll                                                            | 2015.130.4502.0  | 26288     | 15-May-2018 | 00:56 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 01:09 | x64      |
| Sqltses.dll                                                          | 2015.130.4502.0  | 9064624   | 15-May-2018 | 00:56 | x64      |

SQL Server 2016 Reporting Services

| File name                                                 | File version    | File size | Date        | Time  | Platform |
|-----------------------------------------------------------|-----------------|-----------|-------------|-------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.4502.0     | 79024     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4502.0     | 210608    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4502.0     | 168624    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4502.0     | 1620144   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4502.0     | 657584    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4502.0     | 329904    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4502.0     | 1072304   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4502.0     | 532144    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4502.0     | 48816     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4502.0     | 161968    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4502.0     | 76464     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4502.0     | 76464     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4502.0     | 126128    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4502.0     | 106160    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4502.0     | 5959344   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420272   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420784   | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4421296   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420784   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4421296   | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4421296   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420784   | 15-May-2018 | 00:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4421808   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420272   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4502.0     | 4420784   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4502.0     | 10886320  | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4502.0     | 101040    | 15-May-2018 | 00:57 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4502.0     | 72880     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4502.0     | 5951664   | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4502.0     | 245928    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4502.0     | 298160    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4502.0     | 208560    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 44720     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48816     | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48816     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48816     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 52904     | 15-May-2018 | 00:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48816     | 15-May-2018 | 00:59 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48816     | 15-May-2018 | 00:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 52912     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 44720     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4502.0     | 48808     | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4502.0     | 510640    | 15-May-2018 | 00:58 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4502.0 | 47792     | 15-May-2018 | 00:58 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4502.0     | 496816    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4502.0 | 391856    | 15-May-2018 | 00:56 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4502.0 | 396976    | 15-May-2018 | 00:57 | x86      |
| Msmdlocal.dll                                             | 2015.130.4502.0 | 56207024  | 15-May-2018 | 00:56 | x64      |
| Msmdlocal.dll                                             | 2015.130.4502.0 | 37099184  | 15-May-2018 | 00:58 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4502.0 | 7507120   | 15-May-2018 | 00:56 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4502.0 | 6507696   | 15-May-2018 | 00:58 | x86      |
| Msolap130.dll                                             | 2015.130.4502.0 | 8639664   | 15-May-2018 | 00:56 | x64      |
| Msolap130.dll                                             | 2015.130.4502.0 | 7008944   | 15-May-2018 | 00:58 | x86      |
| Msolui130.dll                                             | 2015.130.4502.0 | 310448    | 15-May-2018 | 00:56 | x64      |
| Msolui130.dll                                             | 2015.130.4502.0 | 287408    | 15-May-2018 | 00:58 | x86      |
| Reportingservicescompression.dll                          | 2015.130.4502.0 | 62640     | 15-May-2018 | 00:56 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4502.0     | 84656     | 15-May-2018 | 00:56 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4502.0     | 2543792   | 15-May-2018 | 00:56 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4502.0 | 108720    | 15-May-2018 | 00:56 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4502.0 | 114352    | 15-May-2018 | 01:01 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4502.0 | 98992     | 15-May-2018 | 00:56 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4502.0 | 2573488   | 15-May-2018 | 00:57 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4502.0     | 2710704   | 15-May-2018 | 00:56 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 868008    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 876208    | 15-May-2018 | 00:59 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 884400    | 15-May-2018 | 00:56 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 868016    | 15-May-2018 | 00:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4502.0     | 872112    | 15-May-2018 | 00:57 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4502.0 | 3663024   | 15-May-2018 | 00:56 | x64      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4502.0 | 3590832   | 15-May-2018 | 00:58 | x86      |
| Rsconfigtool.exe                                          | 13.0.4502.0     | 1405616   | 15-May-2018 | 000:51 | x86      |
| Rsctr.dll                                                 | 2015.130.4502.0 | 58544     | 15-May-2018 | 00:56 | x64      |
| Rsctr.dll                                                 | 2015.130.4502.0 | 51376     | 15-May-2018 | 00:58 | x86      |
| Rshttpruntime.dll                                         | 2015.130.4502.0 | 99504     | 15-May-2018 | 00:56 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                             | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                             | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |
| Sqlrsos.dll                                               | 2015.130.4502.0 | 26288     | 15-May-2018 | 00:56 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4502.0 | 584368    | 15-May-2018 | 00:58 | x86      |
| Sqlserverspatial130.dll                                   | 2015.130.4502.0 | 732848    | 15-May-2018 | 00:58 | x64      |
| Xmlrw.dll                                                 | 2015.130.4502.0 | 259760    | 15-May-2018 | 00:56 | x86      |
| Xmlrw.dll                                                 | 2015.130.4502.0 | 319152    | 15-May-2018 | 00:58 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4502.0 | 191656    | 15-May-2018 | 00:56 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4502.0 | 227504    | 15-May-2018 | 00:58 | x64      |
| Xmsrv.dll                                                 | 2015.130.4502.0 | 32727720  | 15-May-2018 | 00:56 | x86      |
| Xmsrv.dll                                                 | 2015.130.4502.0 | 24050864  | 15-May-2018 |  00:56| x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.4502.0     | 23728     | 15-May-2018 | 00:56 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4502.0 | 1311920   | 15-May-2018 | 00:57 | x86      |
| Ddsshapes.dll                                   | 2015.130.4502.0 | 135856    | 15-May-2018 | 00:57 | x86      |
| Dtaengine.exe                                   | 2015.130.4502.0 | 167088    | 15-May-2018 | 00:57 | x86      |
| Dteparse.dll                                    | 2015.130.4502.0 | 109744    | 15-May-2018 | 00:56 | x64      |
| Dteparse.dll                                    | 2015.130.4502.0 | 99504     | 15-May-2018 | 00:57 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4502.0 | 88752     | 15-May-2018 | 00:57 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4502.0 | 83632     | 15-May-2018 | 00:58 | x86      |
| Dtepkg.dll                                      | 2015.130.4502.0 | 137392    | 15-May-2018 | 00:56 | x64      |
| Dtepkg.dll                                      | 2015.130.4502.0 | 115880    | 15-May-2018 | 00:57 | x86      |
| Dtexec.exe                                      | 2015.130.4502.0 | 72880     | 15-May-2018 | 00:57 | x64      |
| Dtexec.exe                                      | 2015.130.4502.0 | 66736     | 15-May-2018 | 00:57 | x86      |
| Dts.dll                                         | 2015.130.4502.0 | 3146928   | 15-May-2018 | 00:56 | x64      |
| Dts.dll                                         | 2015.130.4502.0 | 2632880   | 15-May-2018 | 00:57 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4502.0 | 477360    | 15-May-2018 | 00:56 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4502.0 | 418992    | 15-May-2018 | 00:57 | x86      |
| Dtsconn.dll                                     | 2015.130.4502.0 | 492720    | 15-May-2018 | 00:56 | x64      |
| Dtsconn.dll                                     | 2015.130.4502.0 | 392368    | 15-May-2018 | 00:57 | x86      |
| Dtshost.exe                                     | 2015.130.4502.0 | 86704     | 15-May-2018 | 00:57 | x64      |
| Dtshost.exe                                     | 2015.130.4502.0 | 76464     | 15-May-2018 | 00:57 | x86      |
| Dtslog.dll                                      | 2015.130.4502.0 | 120496    | 15-May-2018 | 00:56 | x64      |
| Dtslog.dll                                      | 2015.130.4502.0 | 103088    | 15-May-2018 | 00:57 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4502.0 | 545456    | 15-May-2018 | 00:56 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4502.0 | 541360    | 15-May-2018 | 00:57 | x86      |
| Dtspipeline.dll                                 | 2015.130.4502.0 | 1279152   | 15-May-2018 | 00:56 | x64      |
| Dtspipeline.dll                                 | 2015.130.4502.0 | 1059504   | 15-May-2018 | 00:57 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4502.0 | 48304     | 15-May-2018 | 00:56 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4502.0 | 42160     | 15-May-2018 | 00:57 | x86      |
| Dtswizard.exe                                   | 13.0.4502.0     | 896176    | 15-May-2018 | 00:51 | x86      |
| Dtswizard.exe                                   | 13.0.4502.0     | 895664    | 15-May-2018 | 00:57 | x64      |
| Dtuparse.dll                                    | 2015.130.4502.0 | 87728     | 15-May-2018 | 00:56 | x64      |
| Dtuparse.dll                                    | 2015.130.4502.0 | 80048     | 15-May-2018 | 00:57 | x86      |
| Dtutil.exe                                      | 2015.130.4502.0 | 134832    | 15-May-2018 | 00:57 | x64      |
| Dtutil.exe                                      | 2015.130.4502.0 | 115376    | 15-May-2018 | 00:57 | x86      |
| Exceldest.dll                                   | 2015.130.4502.0 | 263336    | 15-May-2018 | 00:56 | x64      |
| Exceldest.dll                                   | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:57 | x86      |
| Excelsrc.dll                                    | 2015.130.4502.0 | 285352    | 15-May-2018 | 00:56 | x64      |
| Excelsrc.dll                                    | 2015.130.4502.0 | 232624    | 15-May-2018 | 00:57 | x86      |
| Flatfiledest.dll                                | 2015.130.4502.0 | 389296    | 15-May-2018 | 00:56 | x64      |
| Flatfiledest.dll                                | 2015.130.4502.0 | 334512    | 15-May-2018 | 00:57 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4502.0 | 401584    | 15-May-2018 | 00:56 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4502.0 | 345264    | 15-May-2018 | 00:57 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4502.0 | 96432     | 15-May-2018 | 00:56 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4502.0 | 80560     | 15-May-2018 | 00:57 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4502.0     | 92336     | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4502.0     | 1313456   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4502.0     | 696488    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4502.0     | 763568    | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4502.0 | 2023088   | 15-May-2018 | 00:58 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4502.0 | 42160     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4502.0     | 73392     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4502.0     | 186544    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4502.0     | 433840    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4502.0     | 433840    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4502.0     | 2044592   | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4502.0     | 2044592   | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4502.0     | 33456     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4502.0     | 33456     | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4502.0     | 249520    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4502.0     | 249520    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4502.0     | 501936    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4502.0     | 606384    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4502.0     | 106160    | 15-May-2018 | 00:58 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4502.0 | 150192    | 15-May-2018 | 00:56 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4502.0 | 138928    | 15-May-2018 | 00:57 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4502.0 | 158896    | 15-May-2018 | 00:56 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4502.0 | 144552    | 15-May-2018 | 00:57 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4502.0 | 101040    | 15-May-2018 | 00:56 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4502.0 | 89776     | 15-May-2018 | 00:58 | x86      |
| Msmdlocal.dll                                   | 2015.130.4502.0 | 56207024  | 15-May-2018 | 00:56 | x64      |
| Msmdlocal.dll                                   | 2015.130.4502.0 | 37099184  | 15-May-2018 | 00:58 | x86      |
| Msmdpp.dll                                      | 2015.130.4502.0 | 6370480   | 15-May-2018 | 00:58 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4502.0 | 7507120   | 15-May-2018 | 00:56 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4502.0 | 6507696   | 15-May-2018 | 00:58 | x86      |
| Msolap130.dll                                   | 2015.130.4502.0 | 8639664   | 15-May-2018 | 00:56 | x64      |
| Msolap130.dll                                   | 2015.130.4502.0 | 7008944   | 15-May-2018 | 00:58 | x86      |
| Msolui130.dll                                   | 2015.130.4502.0 | 310448    | 15-May-2018 | 00:56 | x64      |
| Msolui130.dll                                   | 2015.130.4502.0 | 287408    | 15-May-2018 | 00:58 | x86      |
| Oledbdest.dll                                   | 2015.130.4502.0 | 264360    | 15-May-2018 | 00:56 | x64      |
| Oledbdest.dll                                   | 2015.130.4502.0 | 216752    | 15-May-2018 | 00:58 | x86      |
| Oledbsrc.dll                                    | 2015.130.4502.0 | 290992    | 15-May-2018 | 00:56 | x64      |
| Oledbsrc.dll                                    | 2015.130.4502.0 | 235696    | 15-May-2018 | 00:58 | x86      |
| Profiler.exe                                    | 2015.130.4502.0 | 804528    | 15-May-2018 | 00:51 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4502.0 | 100528    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                   | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:56 | x64      |
| Sqldumper.exe                                   | 2015.130.4502.0 | 107688    | 15-May-2018 | 00:57 | x86      |
| Sqlresld.dll                                    | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56 | x64      |
| Sqlresld.dll                                    | 2015.130.4502.0 | 28848     | 15-May-2018 | 00:58 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4502.0 | 30896     | 15-May-2018 | 00:56 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4502.0 | 28336     | 15-May-2018 | 00:58 | x86      |
| Sqlscm.dll                                      | 2015.130.4502.0 | 52912     | 15-May-2018 | 00:58 | x86      |
| Sqlscm.dll                                      | 2015.130.4502.0 | 61104     | 15-May-2018 | 00:58 | x64      |
| Sqlsvc.dll                                      | 2015.130.4502.0 | 152240    | 15-May-2018 | 00:56 | x64      |
| Sqlsvc.dll                                      | 2015.130.4502.0 | 127152    | 15-May-2018 | 00:58 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4502.0 | 180912    | 15-May-2018 | 00:56 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4502.0 | 151208    | 15-May-2018 | 00:58 | x86      |
| Txdataconvert.dll                               | 2015.130.4502.0 | 255152    | 15-May-2018 | 00:56 | x86      |
| Txdataconvert.dll                               | 2015.130.4502.0 | 296624    | 15-May-2018 | 00:56 | x64      |
| Xe.dll                                          | 2015.130.4502.0 | 558760    | 15-May-2018 | 00:57 | x86      |
| Xe.dll                                          | 2015.130.4502.0 | 626352    | 15-May-2018 | 00:58 | x64      |
| Xmlrw.dll                                       | 2015.130.4502.0 | 259760    | 15-May-2018 | 00:56 | x86      |
| Xmlrw.dll                                       | 2015.130.4502.0 | 319152    | 15-May-2018 | 00:58 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4502.0 | 191656    | 15-May-2018 | 00:56 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4502.0 | 227504    | 15-May-2018 | 00:58 | x64      |
| Xmsrv.dll                                       | 2015.130.4502.0 | 32727720  | 15-May-2018 | 00:56 | x86      |
| Xmsrv.dll                                       | 2015.130.4502.0 | 24050864  | 15-May-2018 | 00:56 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
