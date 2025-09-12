---
title: Cumulative update 10 for SQL Server 2016 SP1 (KB4341569)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 10 (KB4341569).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4341569
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
---

# KB4341569 - Cumulative Update 10 for SQL Server 2016 SP1

_Release Date:_ &nbsp; July 16, 2018  
_Version:_ &nbsp; 13.0.4514.0

This article describes cumulative update package 10 (build number: **13.0.4514.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference   | Description| Fix area  |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------|
| <a id=12108237>[12108237](#12108237) </a> | [FIX: Parallel redo does not   work after you disable Trace Flag 3459 in an instance of SQL   Server (KB4339858)](https://support.microsoft.com/help/4339858)  | High Availability |
| <a id=11963714>[11963714](#11963714) </a> | FIX: Access violation in cross   data center failover if you use Always On Availability Groups in SQL Server (KB4340986)   | High Availability |
| <a id=12162395>[12162395](#12162395) </a> | [FIX: VSS backup fails in   secondary replica of Basic Availability Groups in SQL Server   2016 (KB4341221)](https://support.microsoft.com/help/4341221)   | SQL Engine|
| <a id=12164652>[12164652](#12164652) </a> | [FIX: Event notifications for   AUDIT_LOGIN and AUDIT_LOGIN_FAILED events will cause an unusual growth of   TempDB in SQL Server 2016 (KB4341398)](https://support.microsoft.com/help/4341398) | SQL Engine|
| <a id=12007659>[12007659](#12007659) </a> | FIX: SSAS stops responding when   you run MDX queries and DirectQuery mode is enabled in SQL Server (KB4294660)| Analysis Services |
| <a id=12150033>[12150033](#12150033) </a> | FIX: The Excel   Add-in still appears on the MDS home page when the option is set to "No" in   MDS Configuration Manager (KB4340426)   | Data Quality   Services (DQS) |
| <a id=11965145>[11965145](#11965145) </a> | [FIX: No records are returned   when you run an MDX query after restarting SSAS   2016 (KB4340746)](https://support.microsoft.com/help/4340746)| Analysis Services |
| <a id=12110129>[12110129](#12110129) </a> | [FIX: Error 3906 when a hotfix   is applied on a SQL Server that has a database snapshot on a pull   subscription database (KB4340837)](https://support.microsoft.com/help/4340837)| SQL Engine|
| <a id=11922700>[11922700](#11922700) </a> | [FIX: "Corrupted   index" message and server disconnection when an update statistics query   uses hash aggregate on SQL   Server (KB4316858)](https://support.microsoft.com/help/4316858)  | SQL performance   |
| <a id=11888330>[11888330](#11888330) </a> | [FIX:   "PAGE_FAULT_IN_NONPAGED_AREA" Stop error when enumerating contents   in a SQL Server FileTable   directory (KB4338960)](https://support.microsoft.com/help/4338960)| SQL Engine|
| <a id=12101696>[12101696](#12101696) </a> | [FIX: Rectangle does not grow   vertically together with internal Textbox in the report in SSRS 2016 when you   set rc:Toolbar=False (KB4338040)](https://support.microsoft.com/help/4338040)  | Reporting Services|
| <a id=11919402>[11919402](#11919402) </a> | [FIX: Transaction delays on the   primary replica if database synchronization is reported incorrectly on a   secondary replica in SQL Server (KB4338576)](https://support.microsoft.com/help/4338576)  | High Availability |
| <a id=12108229>[12108229](#12108229) </a> | FIX: Query on a secondary   replica takes two times as long to run as on a primary replica in SQL Server (KB4340342)   | High Availability |
| <a id=11966745>[11966745](#11966745) </a> | [FIX: Assertion error occurs   when you add a database to an instance of SQL Server   2016 (KB4340730)](https://support.microsoft.com/help/4340730)| SQL Engine|
| <a id=11970228>[11970228](#11970228) </a> | [FIX: SQL Server may generate   EXCEPTION_ACCESS_VIOLATION dump file when you merge two partitions of   system-versioned temporal tables in SQL Server   2016 (KB4338761)](https://support.microsoft.com/help/4338761) | SQL Engine|
| <a id=11581433>[11581433](#11581433) </a> | [FIX: SSAS crashes when Process   Full is executed after Process Clear in SQL Server   2016 (KB4339447)](https://support.microsoft.com/help/4339447)   | Analysis Services |
| <a id=11887487>[11887487](#11887487) </a> | [Transparent Data Encryption   added for Log Shipping in SQL Server 2016 and   2017 (KB4099919)](https://support.microsoft.com/help/4099919)   | High Availability |
| <a id=11887486>[11887486](#11887486) </a> | [Improvement: Configure   SESSION_TIMEOUT value for a Distributed Availability Group replica in SQL   Server 2016 and 2017 (KB4090004)](https://support.microsoft.com/help/4090004)| High Availability |
| <a id=12104371>[12104371](#12104371) </a> | [FIX: Leakage of sensitive data   occurs when you enable DDM function in SQL Server 2016 and   2017 (KB4100582)](https://support.microsoft.com/help/4100582)   | SQL security  |
| <a id=12160103>[12160103](#12160103) </a> | Improvement that sets   distributed Always On Availability Groups to automatically seed to all   replicas when you add a new database in SQL Server (KB4341356)| High Availability |
| <a id=12059046>[12059046](#12059046) </a> | [FIX: Error 19432 when you use   Always On Availability Groups in SQL   Server (KB4338746)](https://support.microsoft.com/help/4338746)| High Availability |

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
| Instapi130.dll         | 2015.130.4514.0 | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Msmdredir.dll          | 2015.130.4514.0 | 6421680   | 23-Jun-2018 | 04:31 | x86      |
| Msmdsrv.rll            | 2015.130.4514.0 | 1296560   | 23-Jun-2018 | 04:30 | x86      |
| Msmdsrvi.rll           | 2015.130.4514.0 | 1293488   | 23-Jun-2018 | 04:30 | x86      |
| Sqlbrowser.exe         | 2015.130.4514.0 | 276656    | 23-Jun-2018 | 04:36 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Sqldumper.exe          | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4514.0  | 160432    | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                              | 2015.130.4514.0  | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Isacctchange.dll                            | 2015.130.4514.0  | 29360     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4514.0      | 1027248   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4514.0      | 1348784   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4514.0      | 702640    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4514.0      | 765616    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4514.0      | 520880    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4514.0      | 711856    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4514.0      | 37040     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4514.0      | 46256     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4514.0  | 72880     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4514.0      | 598704    | 23-Jun-2018 | 04:31 | x86      |
| Msasxpress.dll                              | 2015.130.4514.0  | 31920     | 23-Jun-2018 | 04:31 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4514.0  | 60080     | 23-Jun-2018 | 04:31 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4514.0  | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Sqldumper.exe                               | 2015.130.4514.0  | 107696    | 23-Jun-2018 | 04:36 | x86      |
| Sqlftacct.dll                               | 2015.130.4514.0  | 46768     | 23-Jun-2018 | 04:31 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 04:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4514.0  | 364208    | 23-Jun-2018 | 04:31 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4514.0  | 34992     | 23-Jun-2018 | 04:31 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4514.0  | 267440    | 23-Jun-2018 | 04:31 | x86      |
| Sqltdiagn.dll                               | 2015.130.4514.0  | 60592     | 23-Jun-2018 | 04:31 | x86      |
| Svrenumapi130.dll                           | 2015.130.4514.0  | 854192    | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4514.0  | 1876656   | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4514.0 | 121008    | 23-Jun-2018 | 04:36 | x86      |
| Dreplaycommon.dll              | 2015.130.4514.0 | 690856    | 23-Jun-2018 | 04:31 | x86      |
| Dreplayserverps.dll            | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:36 | x86      |
| Dreplayutil.dll                | 2015.130.4514.0 | 309936    | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                 | 2015.130.4514.0 | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Sqlresourceloader.dll          | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4514.0 | 690856    | 23-Jun-2018 | 04:31 | x86      |
| Dreplaycontroller.exe              | 2015.130.4514.0 | 350384    | 23-Jun-2018 | 04:36 | x86      |
| Dreplayprocess.dll                 | 2015.130.4514.0 | 171696    | 23-Jun-2018 | 04:36 | x86      |
| Dreplayserverps.dll                | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                     | 2015.130.4514.0 | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Sqlresourceloader.dll              | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4514.0 | 1311920   | 23-Jun-2018 | 04:36 | x86      |
| Ddsshapes.dll                                   | 2015.130.4514.0 | 135856    | 23-Jun-2018 | 04:36 | x86      |
| Dtaengine.exe                                   | 2015.130.4514.0 | 167088    | 23-Jun-2018 | 04:36 | x86      |
| Dteparse.dll                                    | 2015.130.4514.0 | 99504     | 23-Jun-2018 | 04:36 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4514.0 | 83624     | 23-Jun-2018 | 04:31 | x86      |
| Dtepkg.dll                                      | 2015.130.4514.0 | 115888    | 23-Jun-2018 | 04:36 | x86      |
| Dtexec.exe                                      | 2015.130.4514.0 | 66736     | 23-Jun-2018 | 04:36 | x86      |
| Dts.dll                                         | 2015.130.4514.0 | 2632880   | 23-Jun-2018 | 04:36 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4514.0 | 418992    | 23-Jun-2018 | 04:36 | x86      |
| Dtsconn.dll                                     | 2015.130.4514.0 | 392368    | 23-Jun-2018 | 04:36 | x86      |
| Dtshost.exe                                     | 2015.130.4514.0 | 76464     | 23-Jun-2018 | 04:36 | x86      |
| Dtslog.dll                                      | 2015.130.4514.0 | 103088    | 23-Jun-2018 | 04:36 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4514.0 | 541360    | 23-Jun-2018 | 04:36 | x86      |
| Dtspipeline.dll                                 | 2015.130.4514.0 | 1059504   | 23-Jun-2018 | 04:36 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4514.0 | 42160     | 23-Jun-2018 | 04:36 | x86      |
| Dtswizard.exe                                   | 13.0.4514.0     | 896176    | 23-Jun-2018 | 04:28 | x86      |
| Dtuparse.dll                                    | 2015.130.4514.0 | 80048     | 23-Jun-2018 | 04:36 | x86      |
| Dtutil.exe                                      | 2015.130.4514.0 | 115376    | 23-Jun-2018 | 04:36 | x86      |
| Exceldest.dll                                   | 2015.130.4514.0 | 216752    | 23-Jun-2018 | 04:36 | x86      |
| Excelsrc.dll                                    | 2015.130.4514.0 | 232624    | 23-Jun-2018 | 04:36 | x86      |
| Flatfiledest.dll                                | 2015.130.4514.0 | 334512    | 23-Jun-2018 | 04:36 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4514.0 | 345264    | 23-Jun-2018 | 04:36 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4514.0 | 80560     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4514.0     | 92336     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4514.0     | 1313456   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4514.0     | 696496    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4514.0     | 763568    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4514.0 | 2023088   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4514.0 | 42160     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4514.0     | 73384     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4514.0     | 186544    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4514.0     | 433840    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4514.0     | 2044592   | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4514.0     | 33456     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4514.0     | 249520    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4514.0     | 501936    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4514.0     | 106152    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4514.0 | 138928    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4514.0 | 144560    | 23-Jun-2018 | 04:30 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4514.0 | 89776     | 23-Jun-2018 | 04:31 | x86      |
| Msmdlocal.dll                                   | 2015.130.4514.0 | 37099184  | 23-Jun-2018 | 04:31 | x86      |
| Msmdpp.dll                                      | 2015.130.4514.0 | 6370480   | 23-Jun-2018 | 04:31 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4514.0 | 6507688   | 23-Jun-2018 | 04:31 | x86      |
| Msolap130.dll                                   | 2015.130.4514.0 | 7008944   | 23-Jun-2018 | 04:31 | x86      |
| Msolui130.dll                                   | 2015.130.4514.0 | 287408    | 23-Jun-2018 | 04:31 | x86      |
| Oledbdest.dll                                   | 2015.130.4514.0 | 216744    | 23-Jun-2018 | 04:31 | x86      |
| Oledbsrc.dll                                    | 2015.130.4514.0 | 235696    | 23-Jun-2018 | 04:31 | x86      |
| Profiler.exe                                    | 2015.130.4514.0 | 804528    | 23-Jun-2018 | 04:28 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Sqldumper.exe                                   | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36 | x86      |
| Sqlresld.dll                                    | 2015.130.4514.0 | 28848     | 23-Jun-2018 | 04:31 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |
| Sqlscm.dll                                      | 2015.130.4514.0 | 52912     | 23-Jun-2018 | 04:31 | x86      |
| Sqlsvc.dll                                      | 2015.130.4514.0 | 127144    | 23-Jun-2018 | 04:31 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4514.0 | 151216    | 23-Jun-2018 | 04:31 | x86      |
| Txdataconvert.dll                               | 2015.130.4514.0 | 255152    | 23-Jun-2018 | 04:31 | x86      |
| Xe.dll                                          | 2015.130.4514.0 | 558768    | 23-Jun-2018 | 04:30 | x86      |
| Xmlrw.dll                                       | 2015.130.4514.0 | 259760    | 23-Jun-2018 | 04:31 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4514.0 | 191664    | 23-Jun-2018 | 04:31 | x86      |
| Xmsrv.dll                                       | 2015.130.4514.0 | 32727728  | 23-Jun-2018 | 04:31 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4514.0 | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Keyfile.dll    | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:31 | x86      |
| Msmdredir.dll  | 2015.130.4514.0 | 6421680   | 23-Jun-2018 | 04:31 | x86      |
| Msmdsrv.rll    | 2015.130.4514.0 | 1296560   | 23-Jun-2018 | 04:30 | x86      |
| Msmdsrvi.rll   | 2015.130.4514.0 | 1293488   | 23-Jun-2018 | 04:30 | x86      |
| Sqlbrowser.exe | 2015.130.4514.0 | 276656    | 23-Jun-2018 | 04:36 | x86      |
| Sqldumper.exe  | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4514.0 | 61096     | 23-Jun-2018 | 04:31 | x64      |
| Sqlboot.dll           | 2015.130.4514.0 | 186544    | 23-Jun-2018 | 04:31 | x64      |
| Sqldumper.exe         | 2015.130.4514.0 | 127152    | 23-Jun-2018 | 04:30 | x64      |
| Sqlvdi.dll            | 2015.130.4514.0 | 197296    | 23-Jun-2018 | 04:31 | x64      |
| Sqlvdi.dll            | 2015.130.4514.0 | 168624    | 23-Jun-2018 | 04:31 | x86      |
| Sqlwriter.exe         | 2015.130.4514.0 | 131760    | 23-Jun-2018 | 04:31 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqlwvss.dll           | 2015.130.4514.0 | 342704    | 23-Jun-2018 | 04:48 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4514.0 | 26288     | 23-Jun-2018 | 04:48 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4514.0     | 1347760   | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4514.0     | 765608    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4514.0     | 521392    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787      | 239328    | 22-Jun-2018 | 15:38 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4514.0     | 989872    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4514.0     | 989872    | 23-Jun-2018 | 04:31  | x86      |
| Msmdctr130.dll                                     | 2015.130.4514.0 | 40112     | 23-Jun-2018 | 04:30  | x64      |
| Msmdlocal.dll                                      | 2015.130.4514.0 | 56208048  | 23-Jun-2018 | 04:31  | x64      |
| Msmdlocal.dll                                      | 2015.130.4514.0 | 37099184  | 23-Jun-2018 | 04:31  | x86      |
| Msmdpump.dll                                       | 2015.130.4514.0 | 7798960   | 23-Jun-2018 | 04:31  | x64      |
| Msmdredir.dll                                      | 2015.130.4514.0 | 6421680   | 23-Jun-2018 | 04:31  | x86      |
| Msmdsrv.exe                                        | 2015.130.4514.0 | 56746160  | 23-Jun-2018 | 04:31  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4514.0 | 7507120   | 23-Jun-2018 | 04:31  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4514.0 | 6507688   | 23-Jun-2018 | 04:31  | x86      |
| Msolap130.dll                                      | 2015.130.4514.0 | 8639664   | 23-Jun-2018 | 04:31  | x64      |
| Msolap130.dll                                      | 2015.130.4514.0 | 7008944   | 23-Jun-2018 | 04:31  | x86      |
| Msolui130.dll                                      | 2015.130.4514.0 | 310448    | 23-Jun-2018 | 04:31  | x64      |
| Msolui130.dll                                      | 2015.130.4514.0 | 287408    | 23-Jun-2018 | 04:31  | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30  | x64      |
| Sqlboot.dll                                        | 2015.130.4514.0 | 186544    | 23-Jun-2018 | 04:31  | x64      |
| Sqlceip.exe                                        | 13.0.4514.0     | 252592    | 23-Jun-2018 | 04:30  | x86      |
| Sqldumper.exe                                      | 2015.130.4514.0 | 127152    | 23-Jun-2018 | 04:30  | x64      |
| Sqldumper.exe                                      | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36  | x86      |
| Tmapi.dll                                          | 2015.130.4514.0 | 4346032   | 23-Jun-2018 | 04:48  | x64      |
| Tmcachemgr.dll                                     | 2015.130.4514.0 | 2826416   | 23-Jun-2018 | 04:48  | x64      |
| Tmpersistence.dll                                  | 2015.130.4514.0 | 1071280   | 23-Jun-2018 | 04:48  | x64      |
| Tmtransactions.dll                                 | 2015.130.4514.0 | 1352368   | 23-Jun-2018 | 04:48  | x64      |
| Xe.dll                                             | 2015.130.4514.0 | 626352    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrw.dll                                          | 2015.130.4514.0 | 319152    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrw.dll                                          | 2015.130.4514.0 | 259760    | 23-Jun-2018 | 04:31  | x86      |
| Xmlrwbin.dll                                       | 2015.130.4514.0 | 227504    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrwbin.dll                                       | 2015.130.4514.0 | 191664    | 23-Jun-2018 | 04:31  | x86      |
| Xmsrv.dll                                          | 2015.130.4514.0 | 32727728  | 23-Jun-2018 | 04:31  | x86      |
| Xmsrv.dll                                          | 2015.130.4514.0 | 24050864  | 23-Jun-2018 | 04:48  | x64      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4514.0  | 180912    | 23-Jun-2018 | 04:31 | x64      |
| Batchparser.dll                             | 2015.130.4514.0  | 160432    | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                              | 2015.130.4514.0  | 61096     | 23-Jun-2018 | 04:31 | x64      |
| Instapi130.dll                              | 2015.130.4514.0  | 53424     | 23-Jun-2018 | 04:36 | x86      |
| Isacctchange.dll                            | 2015.130.4514.0  | 30896     | 23-Jun-2018 | 04:30 | x64      |
| Isacctchange.dll                            | 2015.130.4514.0  | 29360     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4514.0      | 1027248   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4514.0      | 1027248   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4514.0      | 1348784   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4514.0      | 702640    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4514.0      | 765616    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4514.0      | 520880    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4514.0      | 711856    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4514.0      | 711856    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4514.0      | 37040     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4514.0      | 46256     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4514.0  | 75440     | 23-Jun-2018 | 04:30 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4514.0  | 72880     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4514.0      | 598704    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4514.0      | 598704    | 23-Jun-2018 | 04:31 | x86      |
| Msasxpress.dll                              | 2015.130.4514.0  | 36016     | 23-Jun-2018 | 04:30 | x64      |
| Msasxpress.dll                              | 2015.130.4514.0  | 31920     | 23-Jun-2018 | 04:31 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4514.0  | 72880     | 23-Jun-2018 | 04:31 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4514.0  | 60080     | 23-Jun-2018 | 04:31 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4514.0  | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                               | 2015.130.4514.0  | 127152    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                               | 2015.130.4514.0  | 107696    | 23-Jun-2018 | 04:36 | x86      |
| Sqlftacct.dll                               | 2015.130.4514.0  | 51888     | 23-Jun-2018 | 04:31 | x64      |
| Sqlftacct.dll                               | 2015.130.4514.0  | 46768     | 23-Jun-2018 | 04:31 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 05:18 | x64      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 04:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4514.0  | 364208    | 23-Jun-2018 | 04:31 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4514.0  | 404144    | 23-Jun-2018 | 04:48 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4514.0  | 34992     | 23-Jun-2018 | 04:31 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4514.0  | 37552     | 23-Jun-2018 | 04:48 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4514.0  | 267440    | 23-Jun-2018 | 04:31 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4514.0  | 348848    | 23-Jun-2018 | 04:48 | x64      |
| Sqltdiagn.dll                               | 2015.130.4514.0  | 60592     | 23-Jun-2018 | 04:31 | x86      |
| Sqltdiagn.dll                               | 2015.130.4514.0  | 67760     | 23-Jun-2018 | 04:48 | x64      |
| Svrenumapi130.dll                           | 2015.130.4514.0  | 854192    | 23-Jun-2018 | 04:31 | x86      |
| Svrenumapi130.dll                           | 2015.130.4514.0  | 1115824   | 23-Jun-2018 | 04:48 | x64      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4514.0  | 1876656   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4514.0  | 1876656   | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4514.0 | 121008    | 23-Jun-2018 | 04:36 | x86      |
| Dreplaycommon.dll              | 2015.130.4514.0 | 690856    | 23-Jun-2018 | 04:31 | x86      |
| Dreplayserverps.dll            | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:36 | x86      |
| Dreplayutil.dll                | 2015.130.4514.0 | 309936    | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                 | 2015.130.4514.0 | 61096     | 23-Jun-2018 | 04:31 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqlresourceloader.dll          | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4514.0 | 690856    | 23-Jun-2018 | 04:31 | x86      |
| Dreplaycontroller.exe              | 2015.130.4514.0 | 350384    | 23-Jun-2018 | 04:36 | x86      |
| Dreplayprocess.dll                 | 2015.130.4514.0 | 171696    | 23-Jun-2018 | 04:36 | x86      |
| Dreplayserverps.dll                | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:36 | x86      |
| Instapi130.dll                     | 2015.130.4514.0 | 61096     | 23-Jun-2018 | 04:31 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqlresourceloader.dll              | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4514.0     | 41136     | 23-Jun-2018 | 04:31  | x64      |
| Batchparser.dll                              | 2015.130.4514.0 | 180912    | 23-Jun-2018 | 04:31  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925360    | 23-Jun-2018 | 04:42  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341360   | 23-Jun-2018 | 04:42  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192176    | 23-Jun-2018 | 04:30  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 01:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4514.0 | 225448    | 23-Jun-2018 | 04:30  | x64      |
| Dcexec.exe                                   | 2015.130.4514.0 | 74416     | 23-Jun-2018 | 04:31  | x64      |
| Fssres.dll                                   | 2015.130.4514.0 | 81576     | 23-Jun-2018 | 04:30  | x64      |
| Hadrres.dll                                  | 2015.130.4514.0 | 177840    | 23-Jun-2018 | 04:31  | x64      |
| Hkcompile.dll                                | 2015.130.4514.0 | 1298096   | 23-Jun-2018 | 04:31  | x64      |
| Hkengine.dll                                 | 2015.130.4514.0 | 5600944   | 23-Jun-2018 | 04:42  | x64      |
| Hkruntime.dll                                | 2015.130.4514.0 | 158896    | 23-Jun-2018 | 04:42  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017520   | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787      | 239328    | 22-Jun-2018 | 15:38 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4514.0     | 235176    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4514.0     | 79536     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4514.0 | 391856    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4514.0 | 71344     | 23-Jun-2018 | 04:31  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4514.0 | 65200     | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4514.0 | 150192    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4514.0 | 158896    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4514.0 | 272048    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4514.0 | 74928     | 23-Jun-2018 | 04:30  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129712    | 23-Jun-2018 | 04:42  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559280    | 23-Jun-2018 | 04:42  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559280    | 23-Jun-2018 | 04:42  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661168    | 23-Jun-2018 | 04:42  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964784    | 23-Jun-2018 | 04:42  | x64      |
| Odsole70.dll                                 | 2015.130.4514.0 | 92848     | 23-Jun-2018 | 04:31  | x64      |
| Opends60.dll                                 | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:31  | x64      |
| Qds.dll                                      | 2015.130.4514.0 | 845488    | 23-Jun-2018 | 04:31  | x64      |
| Rsfxft.dll                                   | 2015.130.4514.0 | 34480     | 23-Jun-2018 | 04:31  | x64      |
| Sqagtres.dll                                 | 2015.130.4514.0 | 64688     | 23-Jun-2018 | 04:31  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30  | x64      |
| Sqlaamss.dll                                 | 2015.130.4514.0 | 80560     | 23-Jun-2018 | 04:31  | x64      |
| Sqlaccess.dll                                | 2015.130.4514.0 | 462512    | 23-Jun-2018 | 04:30  | x64      |
| Sqlagent.exe                                 | 2015.130.4514.0 | 566448    | 23-Jun-2018 | 04:31  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4514.0 | 44208     | 23-Jun-2018 | 04:30  | x86      |
| Sqlagentctr130.dll                           | 2015.130.4514.0 | 51888     | 23-Jun-2018 | 04:31  | x64      |
| Sqlagentlog.dll                              | 2015.130.4514.0 | 32944     | 23-Jun-2018 | 04:31  | x64      |
| Sqlagentmail.dll                             | 2015.130.4514.0 | 47792     | 23-Jun-2018 | 04:31  | x64      |
| Sqlboot.dll                                  | 2015.130.4514.0 | 186544    | 23-Jun-2018 | 04:31  | x64      |
| Sqlceip.exe                                  | 13.0.4514.0     | 252592    | 23-Jun-2018 | 04:30  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4514.0 | 60080     | 23-Jun-2018 | 04:31  | x64      |
| Sqlctr130.dll                                | 2015.130.4514.0 | 118448    | 23-Jun-2018 | 04:31  | x64      |
| Sqlctr130.dll                                | 2015.130.4514.0 | 103600    | 23-Jun-2018 | 04:31  | x86      |
| Sqldk.dll                                    | 2015.130.4514.0 | 2587312   | 23-Jun-2018 | 04:31  | x64      |
| Sqldtsss.dll                                 | 2015.130.4514.0 | 97456     | 23-Jun-2018 | 04:31  | x64      |
| Sqliosim.com                                 | 2015.130.4514.0 | 307888    | 23-Jun-2018 | 04:30  | x64      |
| Sqliosim.exe                                 | 2015.130.4514.0 | 3014320   | 23-Jun-2018 | 04:31  | x64      |
| Sqllang.dll                                  | 2015.130.4514.0 | 39442608  | 23-Jun-2018 | 04:31  | x64      |
| Sqlmin.dll                                   | 2015.130.4514.0 | 37693616  | 23-Jun-2018 | 04:48  | x64      |
| Sqlolapss.dll                                | 2015.130.4514.0 | 97968     | 23-Jun-2018 | 04:31  | x64      |
| Sqlos.dll                                    | 2015.130.4514.0 | 26288     | 23-Jun-2018 | 04:31  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4514.0 | 58544     | 23-Jun-2018 | 04:48  | x64      |
| Sqlrepss.dll                                 | 2015.130.4514.0 | 54960     | 23-Jun-2018 | 04:48  | x64      |
| Sqlresld.dll                                 | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48  | x64      |
| Sqlscm.dll                                   | 2015.130.4514.0 | 61104     | 23-Jun-2018 | 04:31  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4514.0 | 27824     | 23-Jun-2018 | 04:48  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4514.0 | 5798576   | 23-Jun-2018 | 04:31  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4514.0 | 732848    | 23-Jun-2018 | 04:31  | x64      |
| Sqlservr.exe                                 | 2015.130.4514.0 | 392880    | 23-Jun-2018 | 04:31  | x64      |
| Sqlsvc.dll                                   | 2015.130.4514.0 | 152240    | 23-Jun-2018 | 04:48  | x64      |
| Sqltses.dll                                  | 2015.130.4514.0 | 8896688   | 23-Jun-2018 | 04:48  | x64      |
| Sqsrvres.dll                                 | 2015.130.4514.0 | 251056    | 23-Jun-2018 | 04:48  | x64      |
| Stretchcodegen.exe                           | 13.0.4514.0     | 55984     | 23-Jun-2018 | 04:30  | x86      |
| Xe.dll                                       | 2015.130.4514.0 | 626352    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrw.dll                                    | 2015.130.4514.0 | 319152    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4514.0 | 227504    | 23-Jun-2018 | 04:31  | x64      |
| Xpadsi.exe                                   | 2015.130.4514.0 | 79024     | 23-Jun-2018 | 04:32  | x64      |
| Xplog70.dll                                  | 2015.130.4514.0 | 65712     | 23-Jun-2018 | 04:31  | x64      |
| Xpqueue.dll                                  | 2015.130.4514.0 | 74928     | 23-Jun-2018 | 04:48  | x64      |
| Xprepl.dll                                   | 2015.130.4514.0 | 91312     | 23-Jun-2018 | 04:48  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4514.0 | 33456     | 23-Jun-2018 | 04:31  | x64      |
| Xpstar.dll                                   | 2015.130.4514.0 | 422576    | 23-Jun-2018 | 04:31  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4514.0 | 180912    | 23-Jun-2018 | 04:31  | x64      |
| Batchparser.dll                                                    | 2015.130.4514.0 | 160432    | 23-Jun-2018 | 04:36  | x86      |
| Bcp.exe                                                            | 2015.130.4514.0 | 119984    | 23-Jun-2018 | 04:30  | x64      |
| Commanddest.dll                                                    | 2015.130.4514.0 | 249008    | 23-Jun-2018 | 04:30  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4514.0 | 115888    | 23-Jun-2018 | 04:30  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4514.0 | 188080    | 23-Jun-2018 | 04:30  | x64      |
| Distrib.exe                                                        | 2015.130.4514.0 | 191152    | 23-Jun-2018 | 04:31  | x64      |
| Dteparse.dll                                                       | 2015.130.4514.0 | 109744    | 23-Jun-2018 | 04:30  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:30  | x64      |
| Dtepkg.dll                                                         | 2015.130.4514.0 | 137392    | 23-Jun-2018 | 04:30  | x64      |
| Dtexec.exe                                                         | 2015.130.4514.0 | 72880     | 23-Jun-2018 | 04:31  | x64      |
| Dts.dll                                                            | 2015.130.4514.0 | 3146928   | 23-Jun-2018 | 04:30  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4514.0 | 477360    | 23-Jun-2018 | 04:30  | x64      |
| Dtsconn.dll                                                        | 2015.130.4514.0 | 492720    | 23-Jun-2018 | 04:30  | x64      |
| Dtshost.exe                                                        | 2015.130.4514.0 | 86704     | 23-Jun-2018 | 04:31  | x64      |
| Dtslog.dll                                                         | 2015.130.4514.0 | 120488    | 23-Jun-2018 | 04:30  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4514.0 | 545456    | 23-Jun-2018 | 04:30  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4514.0 | 1279152   | 23-Jun-2018 | 04:30  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4514.0 | 48304     | 23-Jun-2018 | 04:30  | x64      |
| Dtswizard.exe                                                      | 13.0.4514.0     | 895664    | 23-Jun-2018 | 04:30  | x64      |
| Dtuparse.dll                                                       | 2015.130.4514.0 | 87728     | 23-Jun-2018 | 04:30  | x64      |
| Dtutil.exe                                                         | 2015.130.4514.0 | 134832    | 23-Jun-2018 | 04:31  | x64      |
| Exceldest.dll                                                      | 2015.130.4514.0 | 263344    | 23-Jun-2018 | 04:30  | x64      |
| Excelsrc.dll                                                       | 2015.130.4514.0 | 285360    | 23-Jun-2018 | 04:30  | x64      |
| Execpackagetask.dll                                                | 2015.130.4514.0 | 166576    | 23-Jun-2018 | 04:30  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4514.0 | 389296    | 23-Jun-2018 | 04:30  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4514.0 | 401584    | 23-Jun-2018 | 04:30  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4514.0 | 96432     | 23-Jun-2018 | 04:30  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4514.0 | 59056     | 23-Jun-2018 | 04:31  | x64      |
| Logread.exe                                                        | 2015.130.4514.0 | 617136    | 23-Jun-2018 | 04:31  | x64      |
| Mergetxt.dll                                                       | 2015.130.4514.0 | 53936     | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4514.0     | 1313456   | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4514.0     | 696496    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4514.0     | 763568    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 14-Jun-2018 | 17:23 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4514.0     | 54448     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4514.0     | 89776     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4514.0     | 49840     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4514.0     | 43184     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4514.0     | 70832     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4514.0     | 35504     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4514.0     | 73392     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4514.0     | 63664     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4514.0     | 31408     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4514.0     | 131248    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4514.0     | 43696     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4514.0     | 57512     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4514.0     | 215216    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4514.0 | 1639080   | 23-Jun-2018 | 04:31  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4514.0 | 150192    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4514.0 | 158896    | 23-Jun-2018 | 04:30  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4514.0 | 101040    | 23-Jun-2018 | 04:30  | x64      |
| Msgprox.dll                                                        | 2015.130.4514.0 | 275632    | 23-Jun-2018 | 04:30  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4514.0 | 1494704   | 23-Jun-2018 | 04:31  | x64      |
| Oledbdest.dll                                                      | 2015.130.4514.0 | 264368    | 23-Jun-2018 | 04:31  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4514.0 | 290992    | 23-Jun-2018 | 04:31  | x64      |
| Osql.exe                                                           | 2015.130.4514.0 | 75440     | 23-Jun-2018 | 04:30  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4514.0 | 469168    | 23-Jun-2018 | 04:31  | x64      |
| Rawdest.dll                                                        | 2015.130.4514.0 | 209584    | 23-Jun-2018 | 04:31  | x64      |
| Rawsource.dll                                                      | 2015.130.4514.0 | 196784    | 23-Jun-2018 | 04:31  | x64      |
| Rdistcom.dll                                                       | 2015.130.4514.0 | 893616    | 23-Jun-2018 | 04:31  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4514.0 | 187056    | 23-Jun-2018 | 04:31  | x64      |
| Replagnt.dll                                                       | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:31  | x64      |
| Repldp.dll                                                         | 2015.130.4514.0 | 277168    | 23-Jun-2018 | 04:31  | x64      |
| Replerrx.dll                                                       | 2015.130.4514.0 | 144552    | 23-Jun-2018 | 04:31  | x64      |
| Replisapi.dll                                                      | 2015.130.4514.0 | 354480    | 23-Jun-2018 | 04:31  | x64      |
| Replmerg.exe                                                       | 2015.130.4514.0 | 518832    | 23-Jun-2018 | 04:31  | x64      |
| Replprov.dll                                                       | 2015.130.4514.0 | 812208    | 23-Jun-2018 | 04:31  | x64      |
| Replrec.dll                                                        | 2015.130.4514.0 | 1018536   | 23-Jun-2018 | 04:31  | x64      |
| Replsub.dll                                                        | 2015.130.4514.0 | 467632    | 23-Jun-2018 | 04:31  | x64      |
| Replsync.dll                                                       | 2015.130.4514.0 | 144048    | 23-Jun-2018 | 04:31  | x64      |
| Spresolv.dll                                                       | 2015.130.4514.0 | 245424    | 23-Jun-2018 | 04:31  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4514.0 | 249520    | 23-Jun-2018 | 04:30  | x64      |
| Sqldiag.exe                                                        | 2015.130.4514.0 | 1257648   | 23-Jun-2018 | 04:31  | x64      |
| Sqldistx.dll                                                       | 2015.130.4514.0 | 215728    | 23-Jun-2018 | 04:31  | x64      |
| Sqllogship.exe                                                     | 13.0.4514.0     | 100528    | 23-Jun-2018 | 04:30  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4514.0 | 346800    | 23-Jun-2018 | 04:48  | x64      |
| Sqlps.exe                                                          | 13.0.4514.0     | 60080     | 23-Jun-2018 | 04:28  | x86      |
| Sqlresld.dll                                                       | 2015.130.4514.0 | 28848     | 23-Jun-2018 | 04:31  | x86      |
| Sqlresld.dll                                                       | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48  | x64      |
| Sqlscm.dll                                                         | 2015.130.4514.0 | 61104     | 23-Jun-2018 | 04:31  | x64      |
| Sqlscm.dll                                                         | 2015.130.4514.0 | 52912     | 23-Jun-2018 | 04:31  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4514.0 | 127144    | 23-Jun-2018 | 04:31  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4514.0 | 152240    | 23-Jun-2018 | 04:48  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4514.0 | 180912    | 23-Jun-2018 | 04:48  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4514.0 | 105648    | 23-Jun-2018 | 04:48  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4514.0 | 33456     | 23-Jun-2018 | 04:48  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4514.0 | 216240    | 23-Jun-2018 | 04:48  | x64      |
| Ssradd.dll                                                         | 2015.130.4514.0 | 65200     | 23-Jun-2018 | 04:48  | x64      |
| Ssravg.dll                                                         | 2015.130.4514.0 | 65200     | 23-Jun-2018 | 04:48  | x64      |
| Ssrdown.dll                                                        | 2015.130.4514.0 | 50864     | 23-Jun-2018 | 04:48  | x64      |
| Ssrmax.dll                                                         | 2015.130.4514.0 | 63664     | 23-Jun-2018 | 04:48  | x64      |
| Ssrmin.dll                                                         | 2015.130.4514.0 | 63664     | 23-Jun-2018 | 04:48  | x64      |
| Ssrpub.dll                                                         | 2015.130.4514.0 | 51376     | 23-Jun-2018 | 04:48  | x64      |
| Ssrup.dll                                                          | 2015.130.4514.0 | 50856     | 23-Jun-2018 | 04:48  | x64      |
| Txagg.dll                                                          | 2015.130.4514.0 | 364720    | 23-Jun-2018 | 04:48  | x64      |
| Txbdd.dll                                                          | 2015.130.4514.0 | 172720    | 23-Jun-2018 | 04:48  | x64      |
| Txdatacollector.dll                                                | 2015.130.4514.0 | 367792    | 23-Jun-2018 | 04:48  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4514.0 | 296624    | 23-Jun-2018 | 04:48  | x64      |
| Txderived.dll                                                      | 2015.130.4514.0 | 607920    | 23-Jun-2018 | 04:48  | x64      |
| Txlookup.dll                                                       | 2015.130.4514.0 | 532144    | 23-Jun-2018 | 04:48  | x64      |
| Txmerge.dll                                                        | 2015.130.4514.0 | 230064    | 23-Jun-2018 | 04:48  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4514.0 | 278704    | 23-Jun-2018 | 04:48  | x64      |
| Txmulticast.dll                                                    | 2015.130.4514.0 | 128176    | 23-Jun-2018 | 04:48  | x64      |
| Txrowcount.dll                                                     | 2015.130.4514.0 | 126640    | 23-Jun-2018 | 04:48  | x64      |
| Txsort.dll                                                         | 2015.130.4514.0 | 258736    | 23-Jun-2018 | 04:48  | x64      |
| Txsplit.dll                                                        | 2015.130.4514.0 | 600752    | 23-Jun-2018 | 04:48  | x64      |
| Txunionall.dll                                                     | 2015.130.4514.0 | 181936    | 23-Jun-2018 | 04:48  | x64      |
| Xe.dll                                                             | 2015.130.4514.0 | 626352    | 23-Jun-2018 | 04:31  | x64      |
| Xmlrw.dll                                                          | 2015.130.4514.0 | 319152    | 23-Jun-2018 | 04:31  | x64      |
| Xmlsub.dll                                                         | 2015.130.4514.0 | 251056    | 23-Jun-2018 | 04:48  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4514.0 | 1013928   | 23-Jun-2018 | 04:30 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqlsatellite.dll              | 2015.130.4514.0 | 837296    | 23-Jun-2018 | 04:31 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4514.0 | 660144    | 23-Jun-2018 | 04:31 | x64      |
| Fdhost.exe               | 2015.130.4514.0 | 105136    | 23-Jun-2018 | 04:30 | x64      |
| Fdlauncher.exe           | 2015.130.4514.0 | 51376     | 23-Jun-2018 | 04:30 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqlft130ph.dll           | 2015.130.4514.0 | 58032     | 23-Jun-2018 | 04:31 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4514.0     | 23728     | 23-Jun-2018 | 04:30 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 12-Jun-2018 | 02:51  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 14-Jun-2018 | 17:23 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 12-Jun-2018 | 02:51  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 14-Jun-2018 | 17:23 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 12-Jun-2018 | 02:51  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 14-Jun-2018 | 17:23 | x86      |
| Commanddest.dll                                                    | 2015.130.4514.0 | 249008    | 23-Jun-2018 | 04:30  | x64      |
| Commanddest.dll                                                    | 2015.130.4514.0 | 202928    | 23-Jun-2018 | 04:36  | x86      |
| Dteparse.dll                                                       | 2015.130.4514.0 | 109744    | 23-Jun-2018 | 04:30  | x64      |
| Dteparse.dll                                                       | 2015.130.4514.0 | 99504     | 23-Jun-2018 | 04:36  | x86      |
| Dteparsemgd.dll                                                    | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:30  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4514.0 | 83624     | 23-Jun-2018 | 04:31  | x86      |
| Dtepkg.dll                                                         | 2015.130.4514.0 | 137392    | 23-Jun-2018 | 04:30  | x64      |
| Dtepkg.dll                                                         | 2015.130.4514.0 | 115888    | 23-Jun-2018 | 04:36  | x86      |
| Dtexec.exe                                                         | 2015.130.4514.0 | 72880     | 23-Jun-2018 | 04:31  | x64      |
| Dtexec.exe                                                         | 2015.130.4514.0 | 66736     | 23-Jun-2018 | 04:36  | x86      |
| Dts.dll                                                            | 2015.130.4514.0 | 3146928   | 23-Jun-2018 | 04:30  | x64      |
| Dts.dll                                                            | 2015.130.4514.0 | 2632880   | 23-Jun-2018 | 04:36  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4514.0 | 477360    | 23-Jun-2018 | 04:30  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4514.0 | 418992    | 23-Jun-2018 | 04:36  | x86      |
| Dtsconn.dll                                                        | 2015.130.4514.0 | 492720    | 23-Jun-2018 | 04:30  | x64      |
| Dtsconn.dll                                                        | 2015.130.4514.0 | 392368    | 23-Jun-2018 | 04:36  | x86      |
| Dtsdebughost.exe                                                   | 2015.130.4514.0 | 109744    | 23-Jun-2018 | 04:31  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4514.0 | 93864     | 23-Jun-2018 | 04:36  | x86      |
| Dtshost.exe                                                        | 2015.130.4514.0 | 86704     | 23-Jun-2018 | 04:31  | x64      |
| Dtshost.exe                                                        | 2015.130.4514.0 | 76464     | 23-Jun-2018 | 04:36  | x86      |
| Dtslog.dll                                                         | 2015.130.4514.0 | 120488    | 23-Jun-2018 | 04:30  | x64      |
| Dtslog.dll                                                         | 2015.130.4514.0 | 103088    | 23-Jun-2018 | 04:36  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4514.0 | 545456    | 23-Jun-2018 | 04:30  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4514.0 | 541360    | 23-Jun-2018 | 04:36  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4514.0 | 1279152   | 23-Jun-2018 | 04:30  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4514.0 | 1059504   | 23-Jun-2018 | 04:36  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4514.0 | 48304     | 23-Jun-2018 | 04:30  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4514.0 | 42160     | 23-Jun-2018 | 04:36  | x86      |
| Dtswizard.exe                                                      | 13.0.4514.0     | 896176    | 23-Jun-2018 | 04:28  | x86      |
| Dtswizard.exe                                                      | 13.0.4514.0     | 895664    | 23-Jun-2018 | 04:30  | x64      |
| Dtuparse.dll                                                       | 2015.130.4514.0 | 87728     | 23-Jun-2018 | 04:30  | x64      |
| Dtuparse.dll                                                       | 2015.130.4514.0 | 80048     | 23-Jun-2018 | 04:36  | x86      |
| Dtutil.exe                                                         | 2015.130.4514.0 | 134832    | 23-Jun-2018 | 04:31  | x64      |
| Dtutil.exe                                                         | 2015.130.4514.0 | 115376    | 23-Jun-2018 | 04:36  | x86      |
| Exceldest.dll                                                      | 2015.130.4514.0 | 263344    | 23-Jun-2018 | 04:30  | x64      |
| Exceldest.dll                                                      | 2015.130.4514.0 | 216752    | 23-Jun-2018 | 04:36  | x86      |
| Excelsrc.dll                                                       | 2015.130.4514.0 | 285360    | 23-Jun-2018 | 04:30  | x64      |
| Excelsrc.dll                                                       | 2015.130.4514.0 | 232624    | 23-Jun-2018 | 04:36  | x86      |
| Execpackagetask.dll                                                | 2015.130.4514.0 | 166576    | 23-Jun-2018 | 04:30  | x64      |
| Execpackagetask.dll                                                | 2015.130.4514.0 | 135344    | 23-Jun-2018 | 04:36  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4514.0 | 389296    | 23-Jun-2018 | 04:30  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4514.0 | 334512    | 23-Jun-2018 | 04:36  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4514.0 | 401584    | 23-Jun-2018 | 04:30  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4514.0 | 345264    | 23-Jun-2018 | 04:36  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4514.0 | 96432     | 23-Jun-2018 | 04:30  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4514.0 | 80560     | 23-Jun-2018 | 04:36  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4514.0     | 439984    | 23-Jun-2018 | 04:28  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4514.0     | 438960    | 23-Jun-2018 | 04:30  | x64      |
| Isserverexec.exe                                                   | 13.0.4514.0     | 132784    | 23-Jun-2018 | 04:28  | x86      |
| Isserverexec.exe                                                   | 13.0.4514.0     | 132272    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4514.0     | 1313456   | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4514.0     | 1313456   | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4514.0     | 696496    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4514.0     | 696496    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4514.0     | 763568    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4514.0     | 763568    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.6.0.6787      | 239328    | 22-Jun-2018 | 15:38 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 14-Jun-2018 | 17:23 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 15-Jun-18 | 16:26 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4514.0     | 73392     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4514.0 | 112304    | 23-Jun-2018 | 04:31  | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4514.0 | 107184    | 23-Jun-2018 | 04:36  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4514.0     | 54448     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4514.0     | 54440     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4514.0     | 89776     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4514.0     | 89776     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4514.0     | 43184     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4514.0     | 43184     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4514.0     | 35504     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4514.0     | 35496     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4514.0     | 73392     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4514.0     | 73392     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4514.0     | 31408     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4514.0     | 31408     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4514.0     | 469680    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4514.0     | 469680    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4514.0     | 43696     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4514.0     | 43688     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4514.0     | 57512     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4514.0     | 57520     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4514.0     | 52912     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4514.0     | 52912     | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4514.0 | 138928    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4514.0 | 150192    | 23-Jun-2018 | 04:30  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4514.0 | 144560    | 23-Jun-2018 | 04:30  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4514.0 | 158896    | 23-Jun-2018 | 04:30  | x64      |
| Msdtssrvr.exe                                                      | 13.0.4514.0     | 216752    | 23-Jun-2018 | 04:30  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4514.0 | 101040    | 23-Jun-2018 | 04:30  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4514.0 | 89776     | 23-Jun-2018 | 04:31  | x86      |
| Msmdpp.dll                                                         | 2015.130.4514.0 | 7646896   | 23-Jun-2018 | 04:31  | x64      |
| Oledbdest.dll                                                      | 2015.130.4514.0 | 264368    | 23-Jun-2018 | 04:31  | x64      |
| Oledbdest.dll                                                      | 2015.130.4514.0 | 216744    | 23-Jun-2018 | 04:31  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4514.0 | 290992    | 23-Jun-2018 | 04:31  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4514.0 | 235696    | 23-Jun-2018 | 04:31  | x86      |
| Rawdest.dll                                                        | 2015.130.4514.0 | 209584    | 23-Jun-2018 | 04:31  | x64      |
| Rawdest.dll                                                        | 2015.130.4514.0 | 168624    | 23-Jun-2018 | 04:31  | x86      |
| Rawsource.dll                                                      | 2015.130.4514.0 | 196784    | 23-Jun-2018 | 04:31  | x64      |
| Rawsource.dll                                                      | 2015.130.4514.0 | 155312    | 23-Jun-2018 | 04:31  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4514.0 | 187056    | 23-Jun-2018 | 04:31  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4514.0 | 151728    | 23-Jun-2018 | 04:31  | x86      |
| Sql_is_keyfile.dll                                                 | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30  | x64      |
| Sqlceip.exe                                                        | 13.0.4514.0     | 252592    | 23-Jun-2018 | 04:30  | x86      |
| Sqldest.dll                                                        | 2015.130.4514.0 | 263856    | 23-Jun-2018 | 04:31  | x64      |
| Sqldest.dll                                                        | 2015.130.4514.0 | 215728    | 23-Jun-2018 | 04:31  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4514.0 | 151216    | 23-Jun-2018 | 04:31  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4514.0 | 180912    | 23-Jun-2018 | 04:48  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4514.0 | 176808    | 23-Jun-2018 | 04:31  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4514.0 | 216240    | 23-Jun-2018 | 04:48  | x64      |
| Txagg.dll                                                          | 2015.130.4514.0 | 304816    | 23-Jun-2018 | 04:31  | x86      |
| Txagg.dll                                                          | 2015.130.4514.0 | 364720    | 23-Jun-2018 | 04:48  | x64      |
| Txbdd.dll                                                          | 2015.130.4514.0 | 137904    | 23-Jun-2018 | 04:31  | x86      |
| Txbdd.dll                                                          | 2015.130.4514.0 | 172720    | 23-Jun-2018 | 04:48  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4514.0 | 496304    | 23-Jun-2018 | 04:31  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4514.0 | 611504    | 23-Jun-2018 | 04:48  | x64      |
| Txcache.dll                                                        | 2015.130.4514.0 | 148144    | 23-Jun-2018 | 04:31  | x86      |
| Txcache.dll                                                        | 2015.130.4514.0 | 183472    | 23-Jun-2018 | 04:48  | x64      |
| Txcharmap.dll                                                      | 2015.130.4514.0 | 250544    | 23-Jun-2018 | 04:31  | x86      |
| Txcharmap.dll                                                      | 2015.130.4514.0 | 289968    | 23-Jun-2018 | 04:48  | x64      |
| Txcopymap.dll                                                      | 2015.130.4514.0 | 147632    | 23-Jun-2018 | 04:31  | x86      |
| Txcopymap.dll                                                      | 2015.130.4514.0 | 182960    | 23-Jun-2018 | 04:48  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4514.0 | 255152    | 23-Jun-2018 | 04:31  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4514.0 | 296624    | 23-Jun-2018 | 04:48  | x64      |
| Txderived.dll                                                      | 2015.130.4514.0 | 519344    | 23-Jun-2018 | 04:31  | x86      |
| Txderived.dll                                                      | 2015.130.4514.0 | 607920    | 23-Jun-2018 | 04:48  | x64      |
| Txfileextractor.dll                                                | 2015.130.4514.0 | 162992    | 23-Jun-2018 | 04:31  | x86      |
| Txfileextractor.dll                                                | 2015.130.4514.0 | 201904    | 23-Jun-2018 | 04:48  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4514.0 | 160944    | 23-Jun-2018 | 04:31  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4514.0 | 199856    | 23-Jun-2018 | 04:48  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4514.0 | 231600    | 23-Jun-2018 | 04:31  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4514.0 | 290992    | 23-Jun-2018 | 04:48  | x64      |
| Txlineage.dll                                                      | 2015.130.4514.0 | 109232    | 23-Jun-2018 | 04:31  | x86      |
| Txlineage.dll                                                      | 2015.130.4514.0 | 137392    | 23-Jun-2018 | 04:48  | x64      |
| Txlookup.dll                                                       | 2015.130.4514.0 | 449704    | 23-Jun-2018 | 04:31  | x86      |
| Txlookup.dll                                                       | 2015.130.4514.0 | 532144    | 23-Jun-2018 | 04:48  | x64      |
| Txmerge.dll                                                        | 2015.130.4514.0 | 176304    | 23-Jun-2018 | 04:31  | x86      |
| Txmerge.dll                                                        | 2015.130.4514.0 | 230064    | 23-Jun-2018 | 04:48  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4514.0 | 223920    | 23-Jun-2018 | 04:31  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4514.0 | 278704    | 23-Jun-2018 | 04:48  | x64      |
| Txmulticast.dll                                                    | 2015.130.4514.0 | 102064    | 23-Jun-2018 | 04:31  | x86      |
| Txmulticast.dll                                                    | 2015.130.4514.0 | 128176    | 23-Jun-2018 | 04:48  | x64      |
| Txpivot.dll                                                        | 2015.130.4514.0 | 181936    | 23-Jun-2018 | 04:31  | x86      |
| Txpivot.dll                                                        | 2015.130.4514.0 | 228016    | 23-Jun-2018 | 04:48  | x64      |
| Txrowcount.dll                                                     | 2015.130.4514.0 | 101552    | 23-Jun-2018 | 04:31  | x86      |
| Txrowcount.dll                                                     | 2015.130.4514.0 | 126640    | 23-Jun-2018 | 04:48  | x64      |
| Txsampling.dll                                                     | 2015.130.4514.0 | 134832    | 23-Jun-2018 | 04:31  | x86      |
| Txsampling.dll                                                     | 2015.130.4514.0 | 172208    | 23-Jun-2018 | 04:48  | x64      |
| Txscd.dll                                                          | 2015.130.4514.0 | 169648    | 23-Jun-2018 | 04:31  | x86      |
| Txscd.dll                                                          | 2015.130.4514.0 | 220336    | 23-Jun-2018 | 04:48  | x64      |
| Txsort.dll                                                         | 2015.130.4514.0 | 210608    | 23-Jun-2018 | 04:31  | x86      |
| Txsort.dll                                                         | 2015.130.4514.0 | 258736    | 23-Jun-2018 | 04:48  | x64      |
| Txsplit.dll                                                        | 2015.130.4514.0 | 513200    | 23-Jun-2018 | 04:31  | x86      |
| Txsplit.dll                                                        | 2015.130.4514.0 | 600752    | 23-Jun-2018 | 04:48  | x64      |
| Txtermextraction.dll                                               | 2015.130.4514.0 | 8615600   | 23-Jun-2018 | 04:31  | x86      |
| Txtermextraction.dll                                               | 2015.130.4514.0 | 8678064   | 23-Jun-2018 | 04:48  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4514.0 | 4106928   | 23-Jun-2018 | 04:31  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4514.0 | 4158640   | 23-Jun-2018 | 04:48  | x64      |
| Txunionall.dll                                                     | 2015.130.4514.0 | 138928    | 23-Jun-2018 | 04:31  | x86      |
| Txunionall.dll                                                     | 2015.130.4514.0 | 181936    | 23-Jun-2018 | 04:48  | x64      |
| Txunpivot.dll                                                      | 2015.130.4514.0 | 162480    | 23-Jun-2018 | 04:31  | x86      |
| Txunpivot.dll                                                      | 2015.130.4514.0 | 201904    | 23-Jun-2018 | 04:48  | x64      |
| Xe.dll                                                             | 2015.130.4514.0 | 558768    | 23-Jun-2018 | 04:30  | x86      |
| Xe.dll                                                             | 2015.130.4514.0 | 626352    | 23-Jun-2018 | 04:31  | x64      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 01:09 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 01:09 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 01:09 | x86      |
| Instapi130.dll                                                       | 2015.130.4514.0  | 61104     | 23-Jun-2018 | 04:48 | x64      |
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
| Mpdwinterop.dll                                                      | 2015.130.4514.0  | 394416    | 23-Jun-2018 | 04:30 | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4514.0  | 6614192   | 23-Jun-2018 | 04:32 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4514.0  | 2155184   | 23-Jun-2018 | 04:48 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 01:09 | x64      |
| Sqldk.dll                                                            | 2015.130.4514.0  | 2530472   | 23-Jun-2018 | 04:48 | x64      |
| Sqldumper.exe                                                        | 2015.130.4514.0  | 127144    | 23-Jun-2018 | 04:32 | x64      |
| Sqlos.dll                                                            | 2015.130.4514.0  | 26288     | 23-Jun-2018 | 04:48 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 01:09 | x64      |
| Sqltses.dll                                                          | 2015.130.4514.0  | 9064624   | 23-Jun-2018 | 04:48 | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.reportingservices.authorization.dll             | 13.0.4514.0     | 79024     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4514.0     | 210608    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4514.0     | 168624    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4514.0     | 1620144   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4514.0     | 657584    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4514.0     | 329904    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4514.0     | 1072304   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:29 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532136    | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4514.0     | 532144    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4514.0     | 161968    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4514.0     | 76464     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4514.0     | 76464     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4514.0     | 126128    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4514.0     | 106160    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4514.0     | 5959344   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420272   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420784   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4421296   | 23-Jun-2018 | 04:29 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420784   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4421296   | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4421296   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420784   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4421808   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420272   | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4514.0     | 4420784   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4514.0     | 10886320  | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4514.0     | 101040    | 23-Jun-2018 | 04:30 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4514.0     | 72880     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4514.0     | 5951656   | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4514.0     | 245936    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4514.0     | 298160    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4514.0     | 208560    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 44720     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:29 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 52912     | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 52904     | 23-Jun-2018 | 04:34 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 44720     | 23-Jun-2018 | 04:32 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4514.0     | 48816     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4514.0     | 510640    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4514.0 | 47792     | 23-Jun-2018 | 04:31 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4514.0     | 496816    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4514.0 | 391856    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4514.0 | 396976    | 23-Jun-2018 | 04:31 | x86      |
| Msmdlocal.dll                                             | 2015.130.4514.0 | 56208048  | 23-Jun-2018 | 04:31 | x64      |
| Msmdlocal.dll                                             | 2015.130.4514.0 | 37099184  | 23-Jun-2018 | 04:31 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4514.0 | 7507120   | 23-Jun-2018 | 04:31 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4514.0 | 6507688   | 23-Jun-2018 | 04:31 | x86      |
| Msolap130.dll                                             | 2015.130.4514.0 | 8639664   | 23-Jun-2018 | 04:31 | x64      |
| Msolap130.dll                                             | 2015.130.4514.0 | 7008944   | 23-Jun-2018 | 04:31 | x86      |
| Msolui130.dll                                             | 2015.130.4514.0 | 310448    | 23-Jun-2018 | 04:31 | x64      |
| Msolui130.dll                                             | 2015.130.4514.0 | 287408    | 23-Jun-2018 | 04:31 | x86      |
| Reportingservicescompression.dll                          | 2015.130.4514.0 | 62640     | 23-Jun-2018 | 04:31 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4514.0     | 84648     | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4514.0     | 2543792   | 23-Jun-2018 | 04:31 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4514.0 | 108720    | 23-Jun-2018 | 04:31 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4514.0 | 114352    | 23-Jun-2018 | 04:32 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4514.0 | 98992     | 23-Jun-2018 | 04:31 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4514.0 | 2573488   | 23-Jun-2018 | 04:31 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4514.0     | 2710704   | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 868016    | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872112    | 23-Jun-2018 | 04:32 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872112    | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872112    | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 876208    | 23-Jun-2018 | 04:30 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872112    | 23-Jun-2018 | 04:31 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872112    | 23-Jun-2018 | 04:30 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 884400    | 23-Jun-2018 | 04:30 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 868016    | 23-Jun-2018 | 04:30 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4514.0     | 872120    | 23-Jun-2018 | 04:30 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4514.0 | 3663024   | 23-Jun-2018 | 04:31 | x64      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4514.0 | 3590832   | 23-Jun-2018 | 04:31 | x86      |
| Rsconfigtool.exe                                          | 13.0.4514.0     | 1405616   | 23-Jun-2018 | 04:28 | x86      |
| Rsctr.dll                                                 | 2015.130.4514.0 | 58536     | 23-Jun-2018 | 04:31 | x64      |
| Rsctr.dll                                                 | 2015.130.4514.0 | 51376     | 23-Jun-2018 | 04:31 | x86      |
| Rshttpruntime.dll                                         | 2015.130.4514.0 | 99504     | 23-Jun-2018 | 04:31 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                                             | 2015.130.4514.0 | 127152    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                                             | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36 | x86      |
| Sqlrsos.dll                                               | 2015.130.4514.0 | 26280     | 23-Jun-2018 | 04:48 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4514.0 | 732848    | 23-Jun-2018 | 04:31 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4514.0 | 584368    | 23-Jun-2018 | 04:31 | x86      |
| Xmlrw.dll                                                 | 2015.130.4514.0 | 319152    | 23-Jun-2018 | 04:31 | x64      |
| Xmlrw.dll                                                 | 2015.130.4514.0 | 259760    | 23-Jun-2018 | 04:31 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4514.0 | 227504    | 23-Jun-2018 | 04:31 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4514.0 | 191664    | 23-Jun-2018 | 04:31 | x86      |
| Xmsrv.dll                                                 | 2015.130.4514.0 | 32727728  | 23-Jun-2018 | 04:31 | x86      |
| Xmsrv.dll                                                 | 2015.130.4514.0 | 24050864  | 23-Jun-2018 | 04:48 | x64      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.4514.0     | 23728     | 23-Jun-2018 | 04:31 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4514.0 | 1311920   | 23-Jun-2018 | 04:36 | x86      |
| Ddsshapes.dll                                   | 2015.130.4514.0 | 135856    | 23-Jun-2018 | 04:36 | x86      |
| Dtaengine.exe                                   | 2015.130.4514.0 | 167088    | 23-Jun-2018 | 04:36 | x86      |
| Dteparse.dll                                    | 2015.130.4514.0 | 109744    | 23-Jun-2018 | 04:30 | x64      |
| Dteparse.dll                                    | 2015.130.4514.0 | 99504     | 23-Jun-2018 | 04:36 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4514.0 | 88752     | 23-Jun-2018 | 04:30 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4514.0 | 83624     | 23-Jun-2018 | 04:31 | x86      |
| Dtepkg.dll                                      | 2015.130.4514.0 | 137392    | 23-Jun-2018 | 04:30 | x64      |
| Dtepkg.dll                                      | 2015.130.4514.0 | 115888    | 23-Jun-2018 | 04:36 | x86      |
| Dtexec.exe                                      | 2015.130.4514.0 | 72880     | 23-Jun-2018 | 04:31 | x64      |
| Dtexec.exe                                      | 2015.130.4514.0 | 66736     | 23-Jun-2018 | 04:36 | x86      |
| Dts.dll                                         | 2015.130.4514.0 | 3146928   | 23-Jun-2018 | 04:30 | x64      |
| Dts.dll                                         | 2015.130.4514.0 | 2632880   | 23-Jun-2018 | 04:36 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4514.0 | 477360    | 23-Jun-2018 | 04:30 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4514.0 | 418992    | 23-Jun-2018 | 04:36 | x86      |
| Dtsconn.dll                                     | 2015.130.4514.0 | 492720    | 23-Jun-2018 | 04:30 | x64      |
| Dtsconn.dll                                     | 2015.130.4514.0 | 392368    | 23-Jun-2018 | 04:36 | x86      |
| Dtshost.exe                                     | 2015.130.4514.0 | 86704     | 23-Jun-2018 | 04:31 | x64      |
| Dtshost.exe                                     | 2015.130.4514.0 | 76464     | 23-Jun-2018 | 04:36 | x86      |
| Dtslog.dll                                      | 2015.130.4514.0 | 120488    | 23-Jun-2018 | 04:30 | x64      |
| Dtslog.dll                                      | 2015.130.4514.0 | 103088    | 23-Jun-2018 | 04:36 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4514.0 | 545456    | 23-Jun-2018 | 04:30 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4514.0 | 541360    | 23-Jun-2018 | 04:36 | x86      |
| Dtspipeline.dll                                 | 2015.130.4514.0 | 1279152   | 23-Jun-2018 | 04:30 | x64      |
| Dtspipeline.dll                                 | 2015.130.4514.0 | 1059504   | 23-Jun-2018 | 04:36 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4514.0 | 48304     | 23-Jun-2018 | 04:30 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4514.0 | 42160     | 23-Jun-2018 | 04:36 | x86      |
| Dtswizard.exe                                   | 13.0.4514.0     | 896176    | 23-Jun-2018 | 04:28 | x86      |
| Dtswizard.exe                                   | 13.0.4514.0     | 895664    | 23-Jun-2018 | 04:30 | x64      |
| Dtuparse.dll                                    | 2015.130.4514.0 | 87728     | 23-Jun-2018 | 04:30 | x64      |
| Dtuparse.dll                                    | 2015.130.4514.0 | 80048     | 23-Jun-2018 | 04:36 | x86      |
| Dtutil.exe                                      | 2015.130.4514.0 | 134832    | 23-Jun-2018 | 04:31 | x64      |
| Dtutil.exe                                      | 2015.130.4514.0 | 115376    | 23-Jun-2018 | 04:36 | x86      |
| Exceldest.dll                                   | 2015.130.4514.0 | 263344    | 23-Jun-2018 | 04:30 | x64      |
| Exceldest.dll                                   | 2015.130.4514.0 | 216752    | 23-Jun-2018 | 04:36 | x86      |
| Excelsrc.dll                                    | 2015.130.4514.0 | 285360    | 23-Jun-2018 | 04:30 | x64      |
| Excelsrc.dll                                    | 2015.130.4514.0 | 232624    | 23-Jun-2018 | 04:36 | x86      |
| Flatfiledest.dll                                | 2015.130.4514.0 | 389296    | 23-Jun-2018 | 04:30 | x64      |
| Flatfiledest.dll                                | 2015.130.4514.0 | 334512    | 23-Jun-2018 | 04:36 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4514.0 | 401584    | 23-Jun-2018 | 04:30 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4514.0 | 345264    | 23-Jun-2018 | 04:36 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4514.0 | 96432     | 23-Jun-2018 | 04:30 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4514.0 | 80560     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4514.0     | 92336     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4514.0     | 1313456   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4514.0     | 696496    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4514.0     | 763568    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4514.0 | 2023088   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4514.0 | 42160     | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4514.0     | 73384     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4514.0     | 186544    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4514.0     | 433840    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4514.0     | 433840    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4514.0     | 2044592   | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4514.0     | 2044592   | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4514.0     | 33456     | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4514.0     | 33456     | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4514.0     | 249520    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4514.0     | 249520    | 23-Jun-2018 | 04:36 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4514.0     | 501936    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4514.0     | 606384    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4514.0     | 106152    | 23-Jun-2018 | 04:31 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4514.0 | 138928    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4514.0 | 150192    | 23-Jun-2018 | 04:30 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4514.0 | 144560    | 23-Jun-2018 | 04:30 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4514.0 | 158896    | 23-Jun-2018 | 04:30 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4514.0 | 101040    | 23-Jun-2018 | 04:30 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4514.0 | 89776     | 23-Jun-2018 | 04:31 | x86      |
| Msmdlocal.dll                                   | 2015.130.4514.0 | 56208048  | 23-Jun-2018 | 04:31 | x64      |
| Msmdlocal.dll                                   | 2015.130.4514.0 | 37099184  | 23-Jun-2018 | 04:31 | x86      |
| Msmdpp.dll                                      | 2015.130.4514.0 | 6370480   | 23-Jun-2018 | 04:31 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4514.0 | 7507120   | 23-Jun-2018 | 04:31 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4514.0 | 6507688   | 23-Jun-2018 | 04:31 | x86      |
| Msolap130.dll                                   | 2015.130.4514.0 | 8639664   | 23-Jun-2018 | 04:31 | x64      |
| Msolap130.dll                                   | 2015.130.4514.0 | 7008944   | 23-Jun-2018 | 04:31 | x86      |
| Msolui130.dll                                   | 2015.130.4514.0 | 310448    | 23-Jun-2018 | 04:31 | x64      |
| Msolui130.dll                                   | 2015.130.4514.0 | 287408    | 23-Jun-2018 | 04:31 | x86      |
| Oledbdest.dll                                   | 2015.130.4514.0 | 264368    | 23-Jun-2018 | 04:31 | x64      |
| Oledbdest.dll                                   | 2015.130.4514.0 | 216744    | 23-Jun-2018 | 04:31 | x86      |
| Oledbsrc.dll                                    | 2015.130.4514.0 | 290992    | 23-Jun-2018 | 04:31 | x64      |
| Oledbsrc.dll                                    | 2015.130.4514.0 | 235696    | 23-Jun-2018 | 04:31 | x86      |
| Profiler.exe                                    | 2015.130.4514.0 | 804528    | 23-Jun-2018 | 04:28 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4514.0 | 100520    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                                   | 2015.130.4514.0 | 127152    | 23-Jun-2018 | 04:30 | x64      |
| Sqldumper.exe                                   | 2015.130.4514.0 | 107696    | 23-Jun-2018 | 04:36 | x86      |
| Sqlresld.dll                                    | 2015.130.4514.0 | 28848     | 23-Jun-2018 | 04:31 | x86      |
| Sqlresld.dll                                    | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4514.0 | 28336     | 23-Jun-2018 | 04:31 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4514.0 | 30896     | 23-Jun-2018 | 04:48 | x64      |
| Sqlscm.dll                                      | 2015.130.4514.0 | 61104     | 23-Jun-2018 | 04:31 | x64      |
| Sqlscm.dll                                      | 2015.130.4514.0 | 52912     | 23-Jun-2018 | 04:31 | x86      |
| Sqlsvc.dll                                      | 2015.130.4514.0 | 127144    | 23-Jun-2018 | 04:31 | x86      |
| Sqlsvc.dll                                      | 2015.130.4514.0 | 152240    | 23-Jun-2018 | 04:48 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4514.0 | 151216    | 23-Jun-2018 | 04:31 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4514.0 | 180912    | 23-Jun-2018 | 04:48 | x64      |
| Txdataconvert.dll                               | 2015.130.4514.0 | 255152    | 23-Jun-2018 | 04:31 | x86      |
| Txdataconvert.dll                               | 2015.130.4514.0 | 296624    | 23-Jun-2018 | 04:48 | x64      |
| Xe.dll                                          | 2015.130.4514.0 | 558768    | 23-Jun-2018 | 04:30 | x86      |
| Xe.dll                                          | 2015.130.4514.0 | 626352    | 23-Jun-2018 | 04:31 | x64      |
| Xmlrw.dll                                       | 2015.130.4514.0 | 319152    | 23-Jun-2018 | 04:31 | x64      |
| Xmlrw.dll                                       | 2015.130.4514.0 | 259760    | 23-Jun-2018 | 04:31 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4514.0 | 227504    | 23-Jun-2018 | 04:31 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4514.0 | 191664    | 23-Jun-2018 | 04:31 | x86      |
| Xmsrv.dll                                       | 2015.130.4514.0 | 32727728  | 23-Jun-2018 | 04:31 | x86      |
| Xmsrv.dll                                       | 2015.130.4514.0 | 24050864  | 23-Jun-2018 | 04:48 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
