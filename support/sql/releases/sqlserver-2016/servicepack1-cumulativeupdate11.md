---
title: Cumulative update 11 for SQL Server 2016 SP1 (KB4459676)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 SP1 cumulative update 11 (KB4459676).
ms.date: 10/26/2023
ms.custom: KB4459676
appliesto:
- SQL Server 2016 Service pack 1
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
---

# KB4459676 - Cumulative Update 11 for SQL Server 2016 SP1

_Release Date:_ &nbsp; September 17, 2018  
_Version:_ &nbsp; 13.0.4528.0

This article describes cumulative update package 11 (build number: **13.0.4528.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference  | Description  | Fix area |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|
| <a id=12180193>[12180193](#12180193) </a> | [FIX: Circular dependency   between column names for a calculated table that summarizes the partition   query dataset in SQL Server (KB4338204)](https://support.microsoft.com/help/4338204) | Analysis Services|
| <a id=12177840>[12177840](#12177840) </a> | [FIX: A memory leak occurs in   sqlwepxxx.dll causes the WmiPrvSe.exe process to   crash (KB4133191)](https://support.microsoft.com/help/4133191)| SQL Engine   |
| <a id=12278211>[12278211](#12278211) </a> | [FIX: Access violations and   unhandled exceptions when you set automatic seeding for secondary replica or   Distributed Availability Group replica in SQL   Server (KB4457953)](https://support.microsoft.com/help/4457953) | High Availability|
| <a id=12319581>[12319581](#12319581) </a> | [FIX: "9003 error, sev 20, state   1" error when a backup operation fails on a secondary replica that is running   under asynchronous-commit mode (KB4458880)](https://support.microsoft.com/help/4458880)   | SQL Engine   |
| <a id=12177846>[12177846](#12177846) </a> | [FIX: Thai characters in SSAS   for SQL Server exported to a PDF file are displayed   incorrectly (KB4131251)](https://support.microsoft.com/help/4131251)   | Reporting   Services |
| <a id=12267691>[12267691](#12267691) </a> | FIX: Masked data is exposed   when a query that uses sp_cursorfetch is run in SQL Server if Dynamic Data   Masking is enabled (KB4459535)  | SQL security |
| <a id=12264620>[12264620](#12264620) </a> | [FIX: Error occurs when   encryption is enabled on a database that uses an  Azure Key vault in SQL   Server 2016 (KB4463125)](https://support.microsoft.com/help/4463125)| SQL security |
| <a id=12043568>[12043568](#12043568) </a> | FIX: "An unexpected   exception occurred" when you run an MDX query after you run an XMLA   query to process a dimension in   SSAS (KB4463328) | Analysis Services|
| <a id=12228212>[12228212](#12228212) </a> | Improves error messages 1412 and   1478 by adding LSN values (BackupLSN, FlushedLSN, RedoLSN, TruncationLSN,   HardenedLSN). | High Availability|

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
| Instapi130.dll         | 2015.130.4528.0 | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Msmdredir.dll          | 2015.130.4528.0 | 6423616   | 31-Aug-2018 | 09:58 | x86      |
| Msmdsrv.rll            | 2015.130.4528.0 | 1296648   | 31-Aug-2018 | 09:57 | x86      |
| Msmdsrvi.rll           | 2015.130.4528.0 | 1293584   | 31-Aug-2018 | 09:57 | x86      |
| Sqlbrowser.exe         | 2015.130.4528.0 | 276736    | 31-Aug-2018 | 09:56 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4528.0 | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Sqldumper.exe          | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56 | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4528.0  | 160512    | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                              | 2015.130.4528.0  | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Isacctchange.dll                            | 2015.130.4528.0  | 29440     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4528.0      | 1027360   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4528.0      | 1348872   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4528.0      | 702752    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4528.0      | 765704    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4528.0      | 520968    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4528.0      | 711944    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4528.0      | 37120     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4528.0      | 46336     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4528.0  | 72960     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4528.0      | 598784    | 31-Aug-2018 | 09:57 | x86      |
| Msasxpress.dll                              | 2015.130.4528.0  | 33344     | 31-Aug-2018 | 09:58 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4528.0  | 61504     | 31-Aug-2018 | 09:58 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4528.0  | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Sqldumper.exe                               | 2015.130.4528.0  | 107776    | 31-Aug-2018 | 09:56 | x86      |
| Sqlftacct.dll                               | 2015.130.4528.0  | 48192     | 31-Aug-2018 | 09:58 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4528.0  | 365632    | 31-Aug-2018 | 09:58 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4528.0  | 36416     | 31-Aug-2018 | 09:58 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4528.0  | 268864    | 31-Aug-2018 | 09:58 | x86      |
| Sqltdiagn.dll                               | 2015.130.4528.0  | 62016     | 31-Aug-2018 | 09:58 | x86      |
| Svrenumapi130.dll                           | 2015.130.4528.0  | 855104    | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4528.0  | 1876736   | 31-Aug-2018 | 09:57 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4528.0 | 121088    | 31-Aug-2018 | 09:56 | x86      |
| Dreplaycommon.dll              | 2015.130.4528.0 | 690960    | 31-Aug-2018 | 09:59 | x86      |
| Dreplayserverps.dll            | 2015.130.4528.0 | 33024     | 31-Aug-2018 | 09:56 | x86      |
| Dreplayutil.dll                | 2015.130.4528.0 | 310016    | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                 | 2015.130.4528.0 | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4528.0 | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Sqlresourceloader.dll          | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4528.0 | 690960    | 31-Aug-2018 | 09:59 | x86      |
| Dreplaycontroller.exe              | 2015.130.4528.0 | 350464    | 31-Aug-2018 | 09:56 | x86      |
| Dreplayprocess.dll                 | 2015.130.4528.0 | 171776    | 31-Aug-2018 | 09:56 | x86      |
| Dreplayserverps.dll                | 2015.130.4528.0 | 33024     | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                     | 2015.130.4528.0 | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4528.0 | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Sqlresourceloader.dll              | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4528.0 | 1312000   | 31-Aug-2018 | 09:56 | x86      |
| Ddsshapes.dll                                   | 2015.130.4528.0 | 135936    | 31-Aug-2018 | 09:56 | x86      |
| Dtaengine.exe                                   | 2015.130.4528.0 | 167168    | 31-Aug-2018 | 09:56 | x86      |
| Dteparse.dll                                    | 2015.130.4528.0 | 99584     | 31-Aug-2018 | 09:56 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4528.0 | 83728     | 31-Aug-2018 | 09:59 | x86      |
| Dtepkg.dll                                      | 2015.130.4528.0 | 115968    | 31-Aug-2018 | 09:56 | x86      |
| Dtexec.exe                                      | 2015.130.4528.0 | 66816     | 31-Aug-2018 | 09:56 | x86      |
| Dts.dll                                         | 2015.130.4528.0 | 2632960   | 31-Aug-2018 | 09:56 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4528.0 | 419072    | 31-Aug-2018 | 09:56 | x86      |
| Dtsconn.dll                                     | 2015.130.4528.0 | 392448    | 31-Aug-2018 | 09:56 | x86      |
| Dtshost.exe                                     | 2015.130.4528.0 | 76544     | 31-Aug-2018 | 09:56 | x86      |
| Dtslog.dll                                      | 2015.130.4528.0 | 103168    | 31-Aug-2018 | 09:56 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4528.0 | 541440    | 31-Aug-2018 | 09:56 | x86      |
| Dtspipeline.dll                                 | 2015.130.4528.0 | 1059584   | 31-Aug-2018 | 09:56 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4528.0 | 42240     | 31-Aug-2018 | 09:56 | x86      |
| Dtswizard.exe                                   | 13.0.4528.0     | 899040    | 31-Aug-2018 | 09:46 | x86      |
| Dtuparse.dll                                    | 2015.130.4528.0 | 80128     | 31-Aug-2018 | 09:56 | x86      |
| Dtutil.exe                                      | 2015.130.4528.0 | 115456    | 31-Aug-2018 | 09:56 | x86      |
| Exceldest.dll                                   | 2015.130.4528.0 | 216832    | 31-Aug-2018 | 09:56 | x86      |
| Excelsrc.dll                                    | 2015.130.4528.0 | 232704    | 31-Aug-2018 | 09:56 | x86      |
| Flatfiledest.dll                                | 2015.130.4528.0 | 334592    | 31-Aug-2018 | 09:56 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4528.0 | 345344    | 31-Aug-2018 | 09:56 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4528.0 | 80640     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4528.0     | 92424     | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4528.0     | 1313544   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4528.0     | 696608    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4528.0     | 763656    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4528.0 | 2023176   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4528.0 | 42248     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4528.0     | 74816     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4528.0     | 187968    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4528.0     | 435264    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4528.0     | 2046016   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4528.0     | 33536     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4528.0     | 249600    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4528.0     | 502016    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4528.0     | 606464    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4528.0     | 106240    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4528.0 | 139016    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4528.0 | 144648    | 31-Aug-2018 | 09:56 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4528.0 | 91200     | 31-Aug-2018 | 09:58 | x86      |
| Msmdlocal.dll                                   | 2015.130.4528.0 | 37104704  | 31-Aug-2018 | 09:58 | x86      |
| Msmdpp.dll                                      | 2015.130.4528.0 | 6371904   | 31-Aug-2018 | 09:58 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4528.0 | 6507776   | 31-Aug-2018 | 09:57 | x86      |
| Msolap130.dll                                   | 2015.130.4528.0 | 7009856   | 31-Aug-2018 | 09:58 | x86      |
| Msolui130.dll                                   | 2015.130.4528.0 | 288832    | 31-Aug-2018 | 09:58 | x86      |
| Oledbdest.dll                                   | 2015.130.4528.0 | 218176    | 31-Aug-2018 | 09:58 | x86      |
| Oledbsrc.dll                                    | 2015.130.4528.0 | 237120    | 31-Aug-2018 | 09:58 | x86      |
| Profiler.exe                                    | 2015.130.4528.0 | 804616    | 31-Aug-2018 | 09:59 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4528.0 | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Sqldumper.exe                                   | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56 | x86      |
| Sqlresld.dll                                    | 2015.130.4528.0 | 30272     | 31-Aug-2018 | 09:58 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |
| Sqlscm.dll                                      | 2015.130.4528.0 | 54336     | 31-Aug-2018 | 09:58 | x86      |
| Sqlsvc.dll                                      | 2015.130.4528.0 | 128576    | 31-Aug-2018 | 09:58 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4528.0 | 152640    | 31-Aug-2018 | 09:58 | x86      |
| Txdataconvert.dll                               | 2015.130.4528.0 | 255240    | 31-Aug-2018 | 09:57 | x86      |
| Xe.dll                                          | 2015.130.4528.0 | 558848    | 31-Aug-2018 | 09:57 | x86      |
| Xmlrw.dll                                       | 2015.130.4528.0 | 259856    | 31-Aug-2018 | 09:57 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4528.0 | 191752    | 31-Aug-2018 | 09:57 | x86      |
| Xmsrv.dll                                       | 2015.130.4528.0 | 32727840  | 31-Aug-2018 | 09:57 | x86      |

x64-based versions

SQL Server 2016 Browser Service

| File   name    | File version    | File size | Date      | Time | Platform |
|----------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll | 2015.130.4528.0 | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Keyfile.dll    | 2015.130.4528.0 | 90176     | 31-Aug-2018 | 09:58 | x86      |
| Msmdredir.dll  | 2015.130.4528.0 | 6423616   | 31-Aug-2018 | 09:58 | x86      |
| Msmdsrv.rll    | 2015.130.4528.0 | 1296648   | 31-Aug-2018 | 09:57 | x86      |
| Msmdsrvi.rll   | 2015.130.4528.0 | 1293584   | 31-Aug-2018 | 09:57 | x86      |
| Sqlbrowser.exe | 2015.130.4528.0 | 276736    | 31-Aug-2018 | 09:56 | x86      |
| Sqldumper.exe  | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56 | x86      |

SQL Server 2016 Writer

| File   name           | File version    | File size | Date      | Time | Platform |
|-----------------------|-----------------|-----------|-----------|------|----------|
| Instapi130.dll        | 2015.130.4528.0 | 61192     | 31-Aug-2018 | 09:57 | x64      |
| Sqlboot.dll           | 2015.130.4528.0 | 186632    | 31-Aug-2018 | 09:57 | x64      |
| Sqldumper.exe         | 2015.130.4528.0 | 127248    | 31-Aug-2018 | 09:57 | x64      |
| Sqlvdi.dll            | 2015.130.4528.0 | 197384    | 31-Aug-2018 | 09:57 | x64      |
| Sqlvdi.dll            | 2015.130.4528.0 | 170048    | 31-Aug-2018 | 09:58 | x86      |
| Sqlwriter.exe         | 2015.130.4528.0 | 133184    | 31-Aug-2018 | 09:56 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqlwvss.dll           | 2015.130.4528.0 | 344128    | 31-Aug-2018 | 09:57 | x64      |
| Sqlwvss_xp.dll        | 2015.130.4528.0 | 27712     | 31-Aug-2018 | 09:57 | x64      |

SQL Server 2016 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Microsoft.analysisservices.server.core.dll         | 13.0.4528.0     | 1347848   | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4528.0     | 765704    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4528.0     | 521480    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4528.0     | 991296    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4528.0     | 989960    | 31-Aug-2018 | 09:56  | x86      |
| Msmdctr130.dll                                     | 2015.130.4528.0 | 40200     | 31-Aug-2018 | 09:57  | x64      |
| Msmdlocal.dll                                      | 2015.130.4528.0 | 56208136  | 31-Aug-2018 | 09:57  | x64      |
| Msmdlocal.dll                                      | 2015.130.4528.0 | 37104704  | 31-Aug-2018 | 09:58  | x86      |
| Msmdpump.dll                                       | 2015.130.4528.0 | 7799560   | 31-Aug-2018 | 09:57  | x64      |
| Msmdredir.dll                                      | 2015.130.4528.0 | 6423616   | 31-Aug-2018 | 09:58  | x86      |
| Msmdsrv.exe                                        | 2015.130.4528.0 | 56748608  | 31-Aug-2018 | 09:56  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4528.0 | 7507208   | 31-Aug-2018 | 09:57  | x64      |
| Msmgdsrv.dll                                       | 2015.130.4528.0 | 6507776   | 31-Aug-2018 | 09:57  | x86      |
| Msolap130.dll                                      | 2015.130.4528.0 | 8639752   | 31-Aug-2018 | 09:57  | x64      |
| Msolap130.dll                                      | 2015.130.4528.0 | 7009856   | 31-Aug-2018 | 09:58  | x86      |
| Msolui130.dll                                      | 2015.130.4528.0 | 310536    | 31-Aug-2018 | 09:57  | x64      |
| Msolui130.dll                                      | 2015.130.4528.0 | 288832    | 31-Aug-2018 | 09:58  | x86      |
| Sql_as_keyfile.dll                                 | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57  | x64      |
| Sqlboot.dll                                        | 2015.130.4528.0 | 186632    | 31-Aug-2018 | 09:57  | x64      |
| Sqlceip.exe                                        | 13.0.4528.0     | 252680    | 31-Aug-2018 | 09:56  | x86      |
| Sqldumper.exe                                      | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56  | x86      |
| Sqldumper.exe                                      | 2015.130.4528.0 | 127248    | 31-Aug-2018 | 09:57  | x64      |
| Tmapi.dll                                          | 2015.130.4528.0 | 4347456   | 31-Aug-2018 | 09:57  | x64      |
| Tmcachemgr.dll                                     | 2015.130.4528.0 | 2827840   | 31-Aug-2018 | 09:57  | x64      |
| Tmpersistence.dll                                  | 2015.130.4528.0 | 1072704   | 31-Aug-2018 | 09:57  | x64      |
| Tmtransactions.dll                                 | 2015.130.4528.0 | 1353792   | 31-Aug-2018 | 09:57  | x64      |
| Xe.dll                                             | 2015.130.4528.0 | 626440    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrw.dll                                          | 2015.130.4528.0 | 319248    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrw.dll                                          | 2015.130.4528.0 | 259856    | 31-Aug-2018 | 09:57  | x86      |
| Xmlrwbin.dll                                       | 2015.130.4528.0 | 227600    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrwbin.dll                                       | 2015.130.4528.0 | 191752    | 31-Aug-2018 | 09:57  | x86      |
| Xmsrv.dll                                          | 2015.130.4528.0 | 24052288  | 31-Aug-2018 | 09:57  | x64      |
| Xmsrv.dll                                          | 2015.130.4528.0 | 32727840  | 31-Aug-2018 | 09:57  | x86      |

SQL Server 2016 Database Services Common Core

| File   name                                 | File version     | File size | Date      | Time | Platform |
|---------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                             | 2015.130.4528.0  | 160512    | 31-Aug-2018 | 09:56 | x86      |
| Batchparser.dll                             | 2015.130.4528.0  | 181000    | 31-Aug-2018 | 09:57 | x64      |
| Instapi130.dll                              | 2015.130.4528.0  | 53504     | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                              | 2015.130.4528.0  | 61192     | 31-Aug-2018 | 09:57 | x64      |
| Isacctchange.dll                            | 2015.130.4528.0  | 29440     | 31-Aug-2018 | 09:56 | x86      |
| Isacctchange.dll                            | 2015.130.4528.0  | 30984     | 31-Aug-2018 | 09:57 | x64      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4528.0      | 1027360   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4528.0      | 1027360   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4528.0      | 1348872   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4528.0      | 702752    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4528.0      | 765704    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4528.0      | 520968    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4528.0      | 711944    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4528.0      | 711944    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4528.0      | 37120     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4528.0      | 46336     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4528.0  | 72960     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4528.0  | 75528     | 31-Aug-2018 | 09:58 | x64      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4528.0      | 598792    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4528.0      | 598784    | 31-Aug-2018 | 09:57 | x86      |
| Msasxpress.dll                              | 2015.130.4528.0  | 36104     | 31-Aug-2018 | 09:57 | x64      |
| Msasxpress.dll                              | 2015.130.4528.0  | 33344     | 31-Aug-2018 | 09:58 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4528.0  | 72968     | 31-Aug-2018 | 09:57 | x64      |
| Pbsvcacctsync.dll                           | 2015.130.4528.0  | 61504     | 31-Aug-2018 | 09:58 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4528.0  | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqldumper.exe                               | 2015.130.4528.0  | 107776    | 31-Aug-2018 | 09:56 | x86      |
| Sqldumper.exe                               | 2015.130.4528.0  | 127248    | 31-Aug-2018 | 09:57 | x64      |
| Sqlftacct.dll                               | 2015.130.4528.0  | 51984     | 31-Aug-2018 | 09:57 | x64      |
| Sqlftacct.dll                               | 2015.130.4528.0  | 48192     | 31-Aug-2018 | 09:58 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-2018  | 03:04 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 732336    | 03-Jan-2018  | 04:18 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4528.0  | 405568    | 31-Aug-2018 | 09:57 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4528.0  | 365632    | 31-Aug-2018 | 09:58 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4528.0  | 38976     | 31-Aug-2018 | 09:57 | x64      |
| Sqlsecacctchg.dll                           | 2015.130.4528.0  | 36416     | 31-Aug-2018 | 09:58 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4528.0  | 350272    | 31-Aug-2018 | 09:57 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4528.0  | 268864    | 31-Aug-2018 | 09:58 | x86      |
| Sqltdiagn.dll                               | 2015.130.4528.0  | 69184     | 31-Aug-2018 | 09:57 | x64      |
| Sqltdiagn.dll                               | 2015.130.4528.0  | 62016     | 31-Aug-2018 | 09:58 | x86      |
| Svrenumapi130.dll                           | 2015.130.4528.0  | 1117248   | 31-Aug-2018 | 09:57 | x64      |
| Svrenumapi130.dll                           | 2015.130.4528.0  | 855104    | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 Data Quality

| File   name               | File version | File size | Date      | Time | Platform |
|---------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.ssdqs.infra.dll | 13.0.4528.0  | 1876768   | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4528.0  | 1876736   | 31-Aug-2018 | 09:57 | x86      |

SQL Server 2016 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2015.130.4528.0 | 121088    | 31-Aug-2018 | 09:56 | x86      |
| Dreplaycommon.dll              | 2015.130.4528.0 | 690960    | 31-Aug-2018 | 09:59 | x86      |
| Dreplayserverps.dll            | 2015.130.4528.0 | 33024     | 31-Aug-2018 | 09:56 | x86      |
| Dreplayutil.dll                | 2015.130.4528.0 | 310016    | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                 | 2015.130.4528.0 | 61192     | 31-Aug-2018 | 09:57 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqlresourceloader.dll          | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2015.130.4528.0 | 690960    | 31-Aug-2018 | 09:59 | x86      |
| Dreplaycontroller.exe              | 2015.130.4528.0 | 350464    | 31-Aug-2018 | 09:56 | x86      |
| Dreplayprocess.dll                 | 2015.130.4528.0 | 171776    | 31-Aug-2018 | 09:56 | x86      |
| Dreplayserverps.dll                | 2015.130.4528.0 | 33024     | 31-Aug-2018 | 09:56 | x86      |
| Instapi130.dll                     | 2015.130.4528.0 | 61192     | 31-Aug-2018 | 09:57 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqlresourceloader.dll              | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |

SQL Server 2016 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 13.0.4528.0     | 42560     | 31-Aug-2018 | 09:56  | x64      |
| Batchparser.dll                              | 2015.130.4528.0 | 181000    | 31-Aug-2018 | 09:57  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925440    | 31-Aug-2018 | 09:58  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341448   | 31-Aug-2018 | 09:58  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192272    | 31-Aug-2018 | 09:57  | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-2016  | 00:46  | x64      |
| Datacollectorcontroller.dll                  | 2015.130.4528.0 | 225544    | 31-Aug-2018 | 09:57  | x64      |
| Dcexec.exe                                   | 2015.130.4528.0 | 75840     | 31-Aug-2018 | 09:56  | x64      |
| Fssres.dll                                   | 2015.130.4528.0 | 81672     | 31-Aug-2018 | 09:57  | x64      |
| Hadrres.dll                                  | 2015.130.4528.0 | 177928    | 31-Aug-2018 | 09:57  | x64      |
| Hkcompile.dll                                | 2015.130.4528.0 | 1298184   | 31-Aug-2018 | 09:57  | x64      |
| Hkengine.dll                                 | 2015.130.4528.0 | 5601032   | 31-Aug-2018 | 09:58  | x64      |
| Hkruntime.dll                                | 2015.130.4528.0 | 158992    | 31-Aug-2018 | 09:58  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017608   | 31-Aug-2018 | 09:57  | x64      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4528.0     | 235280    | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4528.0     | 79624     | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4528.0 | 391952    | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4528.0 | 71432     | 31-Aug-2018 | 09:57  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4528.0 | 65288     | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4528.0 | 150280    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4528.0 | 158984    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4528.0 | 272136    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4528.0 | 75016     | 31-Aug-2018 | 09:58  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129808    | 31-Aug-2018 | 09:58  | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559368    | 31-Aug-2018 | 09:58  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559368    | 31-Aug-2018 | 09:58  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661256    | 31-Aug-2018 | 09:58  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964872    | 31-Aug-2018 | 09:58  | x64      |
| Odsole70.dll                                 | 2015.130.4528.0 | 92936     | 31-Aug-2018 | 09:57  | x64      |
| Opends60.dll                                 | 2015.130.4528.0 | 33032     | 31-Aug-2018 | 09:57  | x64      |
| Qds.dll                                      | 2015.130.4528.0 | 845576    | 31-Aug-2018 | 09:57  | x64      |
| Rsfxft.dll                                   | 2015.130.4528.0 | 34576     | 31-Aug-2018 | 09:57  | x64      |
| Sqagtres.dll                                 | 2015.130.4528.0 | 64776     | 31-Aug-2018 | 09:57  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57  | x64      |
| Sqlaamss.dll                                 | 2015.130.4528.0 | 80672     | 31-Aug-2018 | 09:57  | x64      |
| Sqlaccess.dll                                | 2015.130.4528.0 | 462600    | 31-Aug-2018 | 09:58  | x64      |
| Sqlagent.exe                                 | 2015.130.4528.0 | 567872    | 31-Aug-2018 | 09:56  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4528.0 | 51968     | 31-Aug-2018 | 09:58  | x64      |
| Sqlagentctr130.dll                           | 2015.130.4528.0 | 45632     | 31-Aug-2018 | 09:58  | x86      |
| Sqlagentlog.dll                              | 2015.130.4528.0 | 33032     | 31-Aug-2018 | 09:57  | x64      |
| Sqlagentmail.dll                             | 2015.130.4528.0 | 47880     | 31-Aug-2018 | 09:57  | x64      |
| Sqlboot.dll                                  | 2015.130.4528.0 | 186632    | 31-Aug-2018 | 09:57  | x64      |
| Sqlceip.exe                                  | 13.0.4528.0     | 252680    | 31-Aug-2018 | 09:56  | x86      |
| Sqlcmdss.dll                                 | 2015.130.4528.0 | 60168     | 31-Aug-2018 | 09:57  | x64      |
| Sqlctr130.dll                                | 2015.130.4528.0 | 118536    | 31-Aug-2018 | 09:57  | x64      |
| Sqlctr130.dll                                | 2015.130.4528.0 | 105024    | 31-Aug-2018 | 09:58  | x86      |
| Sqldk.dll                                    | 2015.130.4528.0 | 2587920   | 31-Aug-2018 | 09:57  | x64      |
| Sqldtsss.dll                                 | 2015.130.4528.0 | 97544     | 31-Aug-2018 | 09:57  | x64      |
| Sqliosim.com                                 | 2015.130.4528.0 | 307968    | 31-Aug-2018 | 09:58  | x64      |
| Sqliosim.exe                                 | 2015.130.4528.0 | 3015744   | 31-Aug-2018 | 09:56  | x64      |
| Sqllang.dll                                  | 2015.130.4528.0 | 39457544  | 31-Aug-2018 | 09:57  | x64      |
| Sqlmin.dll                                   | 2015.130.4528.0 | 37705792  | 31-Aug-2018 | 09:57  | x64      |
| Sqlolapss.dll                                | 2015.130.4528.0 | 98056     | 31-Aug-2018 | 09:57  | x64      |
| Sqlos.dll                                    | 2015.130.4528.0 | 26400     | 31-Aug-2018 | 09:57  | x64      |
| Sqlpowershellss.dll                          | 2015.130.4528.0 | 59968     | 31-Aug-2018 | 09:57  | x64      |
| Sqlrepss.dll                                 | 2015.130.4528.0 | 56384     | 31-Aug-2018 | 09:57  | x64      |
| Sqlresld.dll                                 | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57  | x64      |
| Sqlresourceloader.dll                        | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57  | x64      |
| Sqlscm.dll                                   | 2015.130.4528.0 | 61200     | 31-Aug-2018 | 09:57  | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4528.0 | 29248     | 31-Aug-2018 | 09:57  | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4528.0 | 5798664   | 31-Aug-2018 | 09:57  | x64      |
| Sqlserverspatial130.dll                      | 2015.130.4528.0 | 732944    | 31-Aug-2018 | 09:57  | x64      |
| Sqlservr.exe                                 | 2015.130.4528.0 | 394304    | 31-Aug-2018 | 09:56  | x64      |
| Sqlsvc.dll                                   | 2015.130.4528.0 | 153664    | 31-Aug-2018 | 09:57  | x64      |
| Sqltses.dll                                  | 2015.130.4528.0 | 8923712   | 31-Aug-2018 | 09:57  | x64      |
| Sqsrvres.dll                                 | 2015.130.4528.0 | 252480    | 31-Aug-2018 | 09:57  | x64      |
| Stretchcodegen.exe                           | 13.0.4528.0     | 56072     | 31-Aug-2018 | 09:56  | x86      |
| Xe.dll                                       | 2015.130.4528.0 | 626440    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrw.dll                                    | 2015.130.4528.0 | 319248    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrwbin.dll                                 | 2015.130.4528.0 | 227600    | 31-Aug-2018 | 09:57  | x64      |
| Xpadsi.exe                                   | 2015.130.4528.0 | 79104     | 31-Aug-2018 | 10:02 | x64      |
| Xplog70.dll                                  | 2015.130.4528.0 | 65808     | 31-Aug-2018 | 09:57  | x64      |
| Xpqueue.dll                                  | 2015.130.4528.0 | 76352     | 31-Aug-2018 | 09:57  | x64      |
| Xprepl.dll                                   | 2015.130.4528.0 | 92736     | 31-Aug-2018 | 09:57  | x64      |
| Xpsqlbot.dll                                 | 2015.130.4528.0 | 33568     | 31-Aug-2018 | 09:57  | x64      |
| Xpstar.dll                                   | 2015.130.4528.0 | 422672    | 31-Aug-2018 | 09:57  | x64      |

SQL Server 2016 Database Services Core Shared

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                                    | 2015.130.4528.0 | 160512    | 31-Aug-2018 | 09:56  | x86      |
| Batchparser.dll                                                    | 2015.130.4528.0 | 181000    | 31-Aug-2018 | 09:57  | x64      |
| Bcp.exe                                                            | 2015.130.4528.0 | 120072    | 31-Aug-2018 | 09:57  | x64      |
| Commanddest.dll                                                    | 2015.130.4528.0 | 249104    | 31-Aug-2018 | 09:57  | x64      |
| Datacollectorenumerators.dll                                       | 2015.130.4528.0 | 115976    | 31-Aug-2018 | 09:57  | x64      |
| Datacollectortasks.dll                                             | 2015.130.4528.0 | 188168    | 31-Aug-2018 | 09:57  | x64      |
| Distrib.exe                                                        | 2015.130.4528.0 | 192576    | 31-Aug-2018 | 09:56  | x64      |
| Dteparse.dll                                                       | 2015.130.4528.0 | 109832    | 31-Aug-2018 | 09:57  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4528.0 | 88840     | 31-Aug-2018 | 09:56  | x64      |
| Dtepkg.dll                                                         | 2015.130.4528.0 | 137480    | 31-Aug-2018 | 09:57  | x64      |
| Dtexec.exe                                                         | 2015.130.4528.0 | 74304     | 31-Aug-2018 | 09:56  | x64      |
| Dts.dll                                                            | 2015.130.4528.0 | 3147040   | 31-Aug-2018 | 09:57  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4528.0 | 477456    | 31-Aug-2018 | 09:57  | x64      |
| Dtsconn.dll                                                        | 2015.130.4528.0 | 492808    | 31-Aug-2018 | 09:57  | x64      |
| Dtshost.exe                                                        | 2015.130.4528.0 | 88128     | 31-Aug-2018 | 09:56  | x64      |
| Dtslog.dll                                                         | 2015.130.4528.0 | 120584    | 31-Aug-2018 | 09:57  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4528.0 | 545544    | 31-Aug-2018 | 09:57  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4528.0 | 1279240   | 31-Aug-2018 | 09:57  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4528.0 | 48392     | 31-Aug-2018 | 09:57  | x64      |
| Dtswizard.exe                                                      | 13.0.4528.0     | 895752    | 31-Aug-2018 | 09:56  | x64      |
| Dtuparse.dll                                                       | 2015.130.4528.0 | 87824     | 31-Aug-2018 | 09:57  | x64      |
| Dtutil.exe                                                         | 2015.130.4528.0 | 136256    | 31-Aug-2018 | 09:56  | x64      |
| Exceldest.dll                                                      | 2015.130.4528.0 | 263944    | 31-Aug-2018 | 09:57  | x64      |
| Excelsrc.dll                                                       | 2015.130.4528.0 | 285448    | 31-Aug-2018 | 09:57  | x64      |
| Execpackagetask.dll                                                | 2015.130.4528.0 | 166664    | 31-Aug-2018 | 09:57  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4528.0 | 389384    | 31-Aug-2018 | 09:57  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4528.0 | 401672    | 31-Aug-2018 | 09:57  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4528.0 | 96544     | 31-Aug-2018 | 09:57  | x64      |
| Hkengperfctrs.dll                                                  | 2015.130.4528.0 | 59144     | 31-Aug-2018 | 09:57  | x64      |
| Logread.exe                                                        | 2015.130.4528.0 | 618560    | 31-Aug-2018 | 09:56  | x64      |
| Mergetxt.dll                                                       | 2015.130.4528.0 | 54024     | 31-Aug-2018 | 09:57  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4528.0     | 1313544   | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4528.0     | 696584    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4528.0     | 763656    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 30-Aug-2018 | 21:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4528.0     | 54536     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4528.0     | 89864     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4528.0     | 49936     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4528.0     | 43272     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4528.0     | 70928     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4528.0     | 35592     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4528.0     | 73480     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4528.0     | 63752     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4528.0     | 31504     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4528.0     | 131336    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4528.0     | 43784     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4528.0     | 57608     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4528.0     | 606472    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4528.0     | 215296    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-2017 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4528.0 | 1639176   | 31-Aug-2018 | 09:57  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4528.0 | 150280    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4528.0 | 158984    | 31-Aug-2018 | 09:58  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4528.0 | 101128    | 31-Aug-2018 | 09:57  | x64      |
| Msgprox.dll                                                        | 2015.130.4528.0 | 275720    | 31-Aug-2018 | 09:57  | x64      |
| Msxmlsql.dll                                                       | 2015.130.4528.0 | 1494792   | 31-Aug-2018 | 09:57  | x64      |
| Oledbdest.dll                                                      | 2015.130.4528.0 | 264456    | 31-Aug-2018 | 09:57  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4528.0 | 291080    | 31-Aug-2018 | 09:57  | x64      |
| Osql.exe                                                           | 2015.130.4528.0 | 75528     | 31-Aug-2018 | 09:57  | x64      |
| Qrdrsvc.exe                                                        | 2015.130.4528.0 | 470592    | 31-Aug-2018 | 09:56  | x64      |
| Rawdest.dll                                                        | 2015.130.4528.0 | 209672    | 31-Aug-2018 | 09:57  | x64      |
| Rawsource.dll                                                      | 2015.130.4528.0 | 196872    | 31-Aug-2018 | 09:57  | x64      |
| Rdistcom.dll                                                       | 2015.130.4528.0 | 893704    | 31-Aug-2018 | 09:57  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4528.0 | 187656    | 31-Aug-2018 | 09:57  | x64      |
| Replagnt.dll                                                       | 2015.130.4528.0 | 30984     | 31-Aug-2018 | 09:57  | x64      |
| Repldp.dll                                                         | 2015.130.4528.0 | 277256    | 31-Aug-2018 | 09:57  | x64      |
| Replerrx.dll                                                       | 2015.130.4528.0 | 144648    | 31-Aug-2018 | 09:57  | x64      |
| Replisapi.dll                                                      | 2015.130.4528.0 | 354568    | 31-Aug-2018 | 09:57  | x64      |
| Replmerg.exe                                                       | 2015.130.4528.0 | 520256    | 31-Aug-2018 | 09:56  | x64      |
| Replprov.dll                                                       | 2015.130.4528.0 | 812296    | 31-Aug-2018 | 09:57  | x64      |
| Replrec.dll                                                        | 2015.130.4528.0 | 1018656   | 31-Aug-2018 | 09:57  | x64      |
| Replsub.dll                                                        | 2015.130.4528.0 | 467720    | 31-Aug-2018 | 09:57  | x64      |
| Replsync.dll                                                       | 2015.130.4528.0 | 144136    | 31-Aug-2018 | 09:57  | x64      |
| Spresolv.dll                                                       | 2015.130.4528.0 | 245512    | 31-Aug-2018 | 09:57  | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57  | x64      |
| Sqlcmd.exe                                                         | 2015.130.4528.0 | 249608    | 31-Aug-2018 | 09:57  | x64      |
| Sqldiag.exe                                                        | 2015.130.4528.0 | 1259072   | 31-Aug-2018 | 09:56  | x64      |
| Sqldistx.dll                                                       | 2015.130.4528.0 | 215816    | 31-Aug-2018 | 09:57  | x64      |
| Sqllogship.exe                                                     | 13.0.4528.0     | 100616    | 31-Aug-2018 | 09:56  | x64      |
| Sqlmergx.dll                                                       | 2015.130.4528.0 | 348224    | 31-Aug-2018 | 09:57  | x64      |
| Sqlps.exe                                                          | 13.0.4528.0     | 60192     | 31-Aug-2018 | 09:59  | x86      |
| Sqlresld.dll                                                       | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57  | x64      |
| Sqlresld.dll                                                       | 2015.130.4528.0 | 30272     | 31-Aug-2018 | 09:58  | x86      |
| Sqlresourceloader.dll                                              | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57  | x64      |
| Sqlresourceloader.dll                                              | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58  | x86      |
| Sqlscm.dll                                                         | 2015.130.4528.0 | 61200     | 31-Aug-2018 | 09:57  | x64      |
| Sqlscm.dll                                                         | 2015.130.4528.0 | 54336     | 31-Aug-2018 | 09:58  | x86      |
| Sqlsvc.dll                                                         | 2015.130.4528.0 | 153664    | 31-Aug-2018 | 09:57  | x64      |
| Sqlsvc.dll                                                         | 2015.130.4528.0 | 128576    | 31-Aug-2018 | 09:58  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4528.0 | 182336    | 31-Aug-2018 | 09:57  | x64      |
| Sqlwep130.dll                                                      | 2015.130.4528.0 | 107072    | 31-Aug-2018 | 09:57  | x64      |
| Ssdebugps.dll                                                      | 2015.130.4528.0 | 34880     | 31-Aug-2018 | 09:57  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4528.0 | 217664    | 31-Aug-2018 | 09:57  | x64      |
| Ssradd.dll                                                         | 2015.130.4528.0 | 66624     | 31-Aug-2018 | 09:57  | x64      |
| Ssravg.dll                                                         | 2015.130.4528.0 | 66624     | 31-Aug-2018 | 09:57  | x64      |
| Ssrdown.dll                                                        | 2015.130.4528.0 | 52288     | 31-Aug-2018 | 09:57  | x64      |
| Ssrmax.dll                                                         | 2015.130.4528.0 | 65088     | 31-Aug-2018 | 09:57  | x64      |
| Ssrmin.dll                                                         | 2015.130.4528.0 | 65088     | 31-Aug-2018 | 09:57  | x64      |
| Ssrpub.dll                                                         | 2015.130.4528.0 | 52800     | 31-Aug-2018 | 09:57  | x64      |
| Ssrup.dll                                                          | 2015.130.4528.0 | 52288     | 31-Aug-2018 | 09:57  | x64      |
| Txagg.dll                                                          | 2015.130.4528.0 | 366144    | 31-Aug-2018 | 09:57  | x64      |
| Txbdd.dll                                                          | 2015.130.4528.0 | 174144    | 31-Aug-2018 | 09:57  | x64      |
| Txdatacollector.dll                                                | 2015.130.4528.0 | 369216    | 31-Aug-2018 | 09:57  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4528.0 | 298048    | 31-Aug-2018 | 09:57  | x64      |
| Txderived.dll                                                      | 2015.130.4528.0 | 609344    | 31-Aug-2018 | 09:57  | x64      |
| Txlookup.dll                                                       | 2015.130.4528.0 | 534080    | 31-Aug-2018 | 09:57  | x64      |
| Txmerge.dll                                                        | 2015.130.4528.0 | 231488    | 31-Aug-2018 | 09:57  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4528.0 | 280128    | 31-Aug-2018 | 09:57  | x64      |
| Txmulticast.dll                                                    | 2015.130.4528.0 | 130112    | 31-Aug-2018 | 09:57  | x64      |
| Txrowcount.dll                                                     | 2015.130.4528.0 | 128064    | 31-Aug-2018 | 09:57  | x64      |
| Txsort.dll                                                         | 2015.130.4528.0 | 260160    | 31-Aug-2018 | 09:57  | x64      |
| Txsplit.dll                                                        | 2015.130.4528.0 | 602176    | 31-Aug-2018 | 09:57  | x64      |
| Txunionall.dll                                                     | 2015.130.4528.0 | 183360    | 31-Aug-2018 | 09:57  | x64      |
| Xe.dll                                                             | 2015.130.4528.0 | 626440    | 31-Aug-2018 | 09:57  | x64      |
| Xmlrw.dll                                                          | 2015.130.4528.0 | 319248    | 31-Aug-2018 | 09:57  | x64      |
| Xmlsub.dll                                                         | 2015.130.4528.0 | 252480    | 31-Aug-2018 | 09:57  | x64      |

SQL Server 2016 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2015.130.4528.0 | 1014024   | 31-Aug-2018 | 09:57 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqlsatellite.dll              | 2015.130.4528.0 | 837392    | 31-Aug-2018 | 09:57 | x64      |

SQL Server 2016 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2015.130.4528.0 | 660232    | 31-Aug-2018 | 09:57 | x64      |
| Fdhost.exe               | 2015.130.4528.0 | 105224    | 31-Aug-2018 | 09:57 | x64      |
| Fdlauncher.exe           | 2015.130.4528.0 | 51464     | 31-Aug-2018 | 09:57 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqlft130ph.dll           | 2015.130.4528.0 | 58120     | 31-Aug-2018 | 09:57 | x64      |

SQL Server 2016 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 13.0.4528.0     | 23816     | 31-Aug-2018 | 09:56 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |

SQL Server 2016 Integration Services

| File   name                                                        | File version    | File size | Date      | Time  | Platform |
|--------------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 19-Aug-2018 | 03:24  | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 20-Aug-2018 | 10:01 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 19-Aug-2018 | 03:24  | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 20-Aug-2018 | 10:01 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 19-Aug-2018 | 03:24  | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 20-Aug-2018 | 10:01 | x86      |
| Commanddest.dll                                                    | 2015.130.4528.0 | 203008    | 31-Aug-2018 | 09:56  | x86      |
| Commanddest.dll                                                    | 2015.130.4528.0 | 249104    | 31-Aug-2018 | 09:57  | x64      |
| Dteparse.dll                                                       | 2015.130.4528.0 | 99584     | 31-Aug-2018 | 09:56  | x86      |
| Dteparse.dll                                                       | 2015.130.4528.0 | 109832    | 31-Aug-2018 | 09:57  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4528.0 | 88840     | 31-Aug-2018 | 09:56  | x64      |
| Dteparsemgd.dll                                                    | 2015.130.4528.0 | 83728     | 31-Aug-2018 | 09:59  | x86      |
| Dtepkg.dll                                                         | 2015.130.4528.0 | 115968    | 31-Aug-2018 | 09:56  | x86      |
| Dtepkg.dll                                                         | 2015.130.4528.0 | 137480    | 31-Aug-2018 | 09:57  | x64      |
| Dtexec.exe                                                         | 2015.130.4528.0 | 74304     | 31-Aug-2018 | 09:56  | x64      |
| Dtexec.exe                                                         | 2015.130.4528.0 | 66816     | 31-Aug-2018 | 09:56  | x86      |
| Dts.dll                                                            | 2015.130.4528.0 | 2632960   | 31-Aug-2018 | 09:56  | x86      |
| Dts.dll                                                            | 2015.130.4528.0 | 3147040   | 31-Aug-2018 | 09:57  | x64      |
| Dtscomexpreval.dll                                                 | 2015.130.4528.0 | 419072    | 31-Aug-2018 | 09:56  | x86      |
| Dtscomexpreval.dll                                                 | 2015.130.4528.0 | 477456    | 31-Aug-2018 | 09:57  | x64      |
| Dtsconn.dll                                                        | 2015.130.4528.0 | 392448    | 31-Aug-2018 | 09:56  | x86      |
| Dtsconn.dll                                                        | 2015.130.4528.0 | 492808    | 31-Aug-2018 | 09:57  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4528.0 | 111168    | 31-Aug-2018 | 09:56  | x64      |
| Dtsdebughost.exe                                                   | 2015.130.4528.0 | 93952     | 31-Aug-2018 | 09:56  | x86      |
| Dtshost.exe                                                        | 2015.130.4528.0 | 88128     | 31-Aug-2018 | 09:56  | x64      |
| Dtshost.exe                                                        | 2015.130.4528.0 | 76544     | 31-Aug-2018 | 09:56  | x86      |
| Dtslog.dll                                                         | 2015.130.4528.0 | 103168    | 31-Aug-2018 | 09:56  | x86      |
| Dtslog.dll                                                         | 2015.130.4528.0 | 120584    | 31-Aug-2018 | 09:57  | x64      |
| Dtsmsg130.dll                                                      | 2015.130.4528.0 | 541440    | 31-Aug-2018 | 09:56  | x86      |
| Dtsmsg130.dll                                                      | 2015.130.4528.0 | 545544    | 31-Aug-2018 | 09:57  | x64      |
| Dtspipeline.dll                                                    | 2015.130.4528.0 | 1059584   | 31-Aug-2018 | 09:56  | x86      |
| Dtspipeline.dll                                                    | 2015.130.4528.0 | 1279240   | 31-Aug-2018 | 09:57  | x64      |
| Dtspipelineperf130.dll                                             | 2015.130.4528.0 | 42240     | 31-Aug-2018 | 09:56  | x86      |
| Dtspipelineperf130.dll                                             | 2015.130.4528.0 | 48392     | 31-Aug-2018 | 09:57  | x64      |
| Dtswizard.exe                                                      | 13.0.4528.0     | 899040    | 31-Aug-2018 | 09:46  | x86      |
| Dtswizard.exe                                                      | 13.0.4528.0     | 895752    | 31-Aug-2018 | 09:56  | x64      |
| Dtuparse.dll                                                       | 2015.130.4528.0 | 80128     | 31-Aug-2018 | 09:56  | x86      |
| Dtuparse.dll                                                       | 2015.130.4528.0 | 87824     | 31-Aug-2018 | 09:57  | x64      |
| Dtutil.exe                                                         | 2015.130.4528.0 | 136256    | 31-Aug-2018 | 09:56  | x64      |
| Dtutil.exe                                                         | 2015.130.4528.0 | 115456    | 31-Aug-2018 | 09:56  | x86      |
| Exceldest.dll                                                      | 2015.130.4528.0 | 216832    | 31-Aug-2018 | 09:56  | x86      |
| Exceldest.dll                                                      | 2015.130.4528.0 | 263944    | 31-Aug-2018 | 09:57  | x64      |
| Excelsrc.dll                                                       | 2015.130.4528.0 | 232704    | 31-Aug-2018 | 09:56  | x86      |
| Excelsrc.dll                                                       | 2015.130.4528.0 | 285448    | 31-Aug-2018 | 09:57  | x64      |
| Execpackagetask.dll                                                | 2015.130.4528.0 | 135424    | 31-Aug-2018 | 09:56  | x86      |
| Execpackagetask.dll                                                | 2015.130.4528.0 | 166664    | 31-Aug-2018 | 09:57  | x64      |
| Flatfiledest.dll                                                   | 2015.130.4528.0 | 334592    | 31-Aug-2018 | 09:56  | x86      |
| Flatfiledest.dll                                                   | 2015.130.4528.0 | 389384    | 31-Aug-2018 | 09:57  | x64      |
| Flatfilesrc.dll                                                    | 2015.130.4528.0 | 345344    | 31-Aug-2018 | 09:56  | x86      |
| Flatfilesrc.dll                                                    | 2015.130.4528.0 | 401672    | 31-Aug-2018 | 09:57  | x64      |
| Foreachfileenumerator.dll                                          | 2015.130.4528.0 | 80640     | 31-Aug-2018 | 09:56  | x86      |
| Foreachfileenumerator.dll                                          | 2015.130.4528.0 | 96544     | 31-Aug-2018 | 09:57  | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4528.0     | 442848    | 31-Aug-2018 | 09:46  | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4528.0     | 439048    | 31-Aug-2018 | 09:56  | x64      |
| Isserverexec.exe                                                   | 13.0.4528.0     | 135648    | 31-Aug-2018 | 09:46  | x86      |
| Isserverexec.exe                                                   | 13.0.4528.0     | 132360    | 31-Aug-2018 | 09:56  | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4528.0     | 1313544   | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4528.0     | 1313544   | 31-Aug-2018 | 09:59  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4528.0     | 696584    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4528.0     | 696608    | 31-Aug-2018 | 09:59  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4528.0     | 763656    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4528.0     | 763656    | 31-Aug-2018 | 09:59  | x86      |
| Microsoft.applicationinsights.dll                                  | 2.7.0.13435     | 329872    | 06-Jul-2018  | 22:33 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 30-Aug-2018 | 21:18 | x86      |
| Microsoft.data.datafeedclient.dll                                  | 13.1.1.0        | 171208    | 30-Aug-2018 | 21:18 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4528.0     | 73480     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4528.0 | 108608    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll                  | 2015.130.4528.0 | 112416    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4528.0     | 54528     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4528.0     | 54536     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4528.0     | 89856     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4528.0     | 89864     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4528.0     | 43264     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4528.0     | 43272     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4528.0     | 35584     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4528.0     | 35592     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4528.0     | 73472     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4528.0     | 73480     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4528.0     | 31488     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4528.0     | 31504     | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4528.0     | 469760    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4528.0     | 469768    | 31-Aug-2018 | 09:58  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4528.0     | 43784     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4528.0     | 43776     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4528.0     | 57608     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4528.0     | 57600     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4528.0     | 53000     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4528.0     | 52992     | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4528.0     | 606472    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4528.0     | 606464    | 31-Aug-2018 | 09:57  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4528.0 | 139016    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4528.0 | 150280    | 31-Aug-2018 | 09:58  | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4528.0 | 144648    | 31-Aug-2018 | 09:56  | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4528.0 | 158984    | 31-Aug-2018 | 09:58  | x64      |
| Msdtssrvr.exe                                                      | 13.0.4528.0     | 216848    | 31-Aug-2018 | 09:56  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4528.0 | 101128    | 31-Aug-2018 | 09:57  | x64      |
| Msdtssrvrutil.dll                                                  | 2015.130.4528.0 | 91200     | 31-Aug-2018 | 09:58  | x86      |
| Msmdpp.dll                                                         | 2015.130.4528.0 | 7647496   | 31-Aug-2018 | 09:57  | x64      |
| Oledbdest.dll                                                      | 2015.130.4528.0 | 264456    | 31-Aug-2018 | 09:57  | x64      |
| Oledbdest.dll                                                      | 2015.130.4528.0 | 218176    | 31-Aug-2018 | 09:58  | x86      |
| Oledbsrc.dll                                                       | 2015.130.4528.0 | 291080    | 31-Aug-2018 | 09:57  | x64      |
| Oledbsrc.dll                                                       | 2015.130.4528.0 | 237120    | 31-Aug-2018 | 09:58  | x86      |
| Rawdest.dll                                                        | 2015.130.4528.0 | 209672    | 31-Aug-2018 | 09:57  | x64      |
| Rawdest.dll                                                        | 2015.130.4528.0 | 170048    | 31-Aug-2018 | 09:58  | x86      |
| Rawsource.dll                                                      | 2015.130.4528.0 | 196872    | 31-Aug-2018 | 09:57  | x64      |
| Rawsource.dll                                                      | 2015.130.4528.0 | 156736    | 31-Aug-2018 | 09:58  | x86      |
| Recordsetdest.dll                                                  | 2015.130.4528.0 | 187656    | 31-Aug-2018 | 09:57  | x64      |
| Recordsetdest.dll                                                  | 2015.130.4528.0 | 153152    | 31-Aug-2018 | 09:58  | x86      |
| Sql_is_keyfile.dll                                                 | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57  | x64      |
| Sqlceip.exe                                                        | 13.0.4528.0     | 252680    | 31-Aug-2018 | 09:56  | x86      |
| Sqldest.dll                                                        | 2015.130.4528.0 | 263952    | 31-Aug-2018 | 09:57  | x64      |
| Sqldest.dll                                                        | 2015.130.4528.0 | 217152    | 31-Aug-2018 | 09:58  | x86      |
| Sqltaskconnections.dll                                             | 2015.130.4528.0 | 182336    | 31-Aug-2018 | 09:57  | x64      |
| Sqltaskconnections.dll                                             | 2015.130.4528.0 | 152640    | 31-Aug-2018 | 09:58  | x86      |
| Ssisoledb.dll                                                      | 2015.130.4528.0 | 217664    | 31-Aug-2018 | 09:57  | x64      |
| Ssisoledb.dll                                                      | 2015.130.4528.0 | 178240    | 31-Aug-2018 | 09:58  | x86      |
| Txagg.dll                                                          | 2015.130.4528.0 | 366144    | 31-Aug-2018 | 09:57  | x64      |
| Txagg.dll                                                          | 2015.130.4528.0 | 304904    | 31-Aug-2018 | 09:57  | x86      |
| Txbdd.dll                                                          | 2015.130.4528.0 | 174144    | 31-Aug-2018 | 09:57  | x64      |
| Txbdd.dll                                                          | 2015.130.4528.0 | 138504    | 31-Aug-2018 | 09:57  | x86      |
| Txbestmatch.dll                                                    | 2015.130.4528.0 | 612928    | 31-Aug-2018 | 09:57  | x64      |
| Txbestmatch.dll                                                    | 2015.130.4528.0 | 496416    | 31-Aug-2018 | 09:57  | x86      |
| Txcache.dll                                                        | 2015.130.4528.0 | 184896    | 31-Aug-2018 | 09:57  | x64      |
| Txcache.dll                                                        | 2015.130.4528.0 | 148232    | 31-Aug-2018 | 09:57  | x86      |
| Txcharmap.dll                                                      | 2015.130.4528.0 | 291392    | 31-Aug-2018 | 09:57  | x64      |
| Txcharmap.dll                                                      | 2015.130.4528.0 | 250632    | 31-Aug-2018 | 09:57  | x86      |
| Txcopymap.dll                                                      | 2015.130.4528.0 | 184896    | 31-Aug-2018 | 09:57  | x64      |
| Txcopymap.dll                                                      | 2015.130.4528.0 | 147720    | 31-Aug-2018 | 09:57  | x86      |
| Txdataconvert.dll                                                  | 2015.130.4528.0 | 298048    | 31-Aug-2018 | 09:57  | x64      |
| Txdataconvert.dll                                                  | 2015.130.4528.0 | 255240    | 31-Aug-2018 | 09:57  | x86      |
| Txderived.dll                                                      | 2015.130.4528.0 | 609344    | 31-Aug-2018 | 09:57  | x64      |
| Txderived.dll                                                      | 2015.130.4528.0 | 519432    | 31-Aug-2018 | 09:57  | x86      |
| Txfileextractor.dll                                                | 2015.130.4528.0 | 203328    | 31-Aug-2018 | 09:57  | x64      |
| Txfileextractor.dll                                                | 2015.130.4528.0 | 163080    | 31-Aug-2018 | 09:57  | x86      |
| Txfileinserter.dll                                                 | 2015.130.4528.0 | 201280    | 31-Aug-2018 | 09:57  | x64      |
| Txfileinserter.dll                                                 | 2015.130.4528.0 | 161056    | 31-Aug-2018 | 09:57  | x86      |
| Txgroupdups.dll                                                    | 2015.130.4528.0 | 292416    | 31-Aug-2018 | 09:57  | x64      |
| Txgroupdups.dll                                                    | 2015.130.4528.0 | 231688    | 31-Aug-2018 | 09:57  | x86      |
| Txlineage.dll                                                      | 2015.130.4528.0 | 138816    | 31-Aug-2018 | 09:57  | x64      |
| Txlineage.dll                                                      | 2015.130.4528.0 | 109344    | 31-Aug-2018 | 09:57  | x86      |
| Txlookup.dll                                                       | 2015.130.4528.0 | 534080    | 31-Aug-2018 | 09:57  | x64      |
| Txlookup.dll                                                       | 2015.130.4528.0 | 449808    | 31-Aug-2018 | 09:57  | x86      |
| Txmerge.dll                                                        | 2015.130.4528.0 | 231488    | 31-Aug-2018 | 09:57  | x64      |
| Txmerge.dll                                                        | 2015.130.4528.0 | 176392    | 31-Aug-2018 | 09:57  | x86      |
| Txmergejoin.dll                                                    | 2015.130.4528.0 | 280128    | 31-Aug-2018 | 09:57  | x64      |
| Txmergejoin.dll                                                    | 2015.130.4528.0 | 224016    | 31-Aug-2018 | 09:57  | x86      |
| Txmulticast.dll                                                    | 2015.130.4528.0 | 130112    | 31-Aug-2018 | 09:57  | x64      |
| Txmulticast.dll                                                    | 2015.130.4528.0 | 102152    | 31-Aug-2018 | 09:57  | x86      |
| Txpivot.dll                                                        | 2015.130.4528.0 | 229440    | 31-Aug-2018 | 09:57  | x64      |
| Txpivot.dll                                                        | 2015.130.4528.0 | 182032    | 31-Aug-2018 | 09:57  | x86      |
| Txrowcount.dll                                                     | 2015.130.4528.0 | 128064    | 31-Aug-2018 | 09:57  | x64      |
| Txrowcount.dll                                                     | 2015.130.4528.0 | 101640    | 31-Aug-2018 | 09:57  | x86      |
| Txsampling.dll                                                     | 2015.130.4528.0 | 173632    | 31-Aug-2018 | 09:57  | x64      |
| Txsampling.dll                                                     | 2015.130.4528.0 | 134920    | 31-Aug-2018 | 09:57  | x86      |
| Txscd.dll                                                          | 2015.130.4528.0 | 221760    | 31-Aug-2018 | 09:57  | x64      |
| Txscd.dll                                                          | 2015.130.4528.0 | 169736    | 31-Aug-2018 | 09:57  | x86      |
| Txsort.dll                                                         | 2015.130.4528.0 | 260160    | 31-Aug-2018 | 09:57  | x64      |
| Txsort.dll                                                         | 2015.130.4528.0 | 210696    | 31-Aug-2018 | 09:57  | x86      |
| Txsplit.dll                                                        | 2015.130.4528.0 | 602176    | 31-Aug-2018 | 09:57  | x64      |
| Txsplit.dll                                                        | 2015.130.4528.0 | 513800    | 31-Aug-2018 | 09:57  | x86      |
| Txtermextraction.dll                                               | 2015.130.4528.0 | 8679488   | 31-Aug-2018 | 09:57  | x64      |
| Txtermextraction.dll                                               | 2015.130.4528.0 | 8615688   | 31-Aug-2018 | 09:57  | x86      |
| Txtermlookup.dll                                                   | 2015.130.4528.0 | 4160064   | 31-Aug-2018 | 09:57  | x64      |
| Txtermlookup.dll                                                   | 2015.130.4528.0 | 4107528   | 31-Aug-2018 | 09:57  | x86      |
| Txunionall.dll                                                     | 2015.130.4528.0 | 183360    | 31-Aug-2018 | 09:57  | x64      |
| Txunionall.dll                                                     | 2015.130.4528.0 | 139016    | 31-Aug-2018 | 09:57  | x86      |
| Txunpivot.dll                                                      | 2015.130.4528.0 | 203840    | 31-Aug-2018 | 09:57  | x64      |
| Txunpivot.dll                                                      | 2015.130.4528.0 | 162576    | 31-Aug-2018 | 09:57  | x86      |
| Xe.dll                                                             | 2015.130.4528.0 | 626440    | 31-Aug-2018 | 09:57  | x64      |
| Xe.dll                                                             | 2015.130.4528.0 | 558848    | 31-Aug-2018 | 09:57  | x86      |

SQL Server 2016 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 10.0.8224.43     | 483496    | 02-Feb-2018  | 00:09  | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.43 | 75440     | 02-Feb-2018  | 00:09  | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.43     | 45744     | 02-Feb-2018  | 00:09  | x86      |
| Instapi130.dll                                                       | 2015.130.4528.0  | 62528     | 31-Aug-2018 | 09:57  | x64      |
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
| Mpdwinterop.dll                                                      | 2015.130.4528.0  | 394504    | 31-Aug-2018 | 09:56  | x64      |
| Mpdwsvc.exe                                                          | 2015.130.4528.0  | 6614272   | 31-Aug-2018 | 10:02 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.130.4528.0  | 2156608   | 31-Aug-2018 | 09:57  | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.43 | 47280     | 02-Feb-2018  | 00:09  | x64      |
| Sqldk.dll                                                            | 2015.130.4528.0  | 2531904   | 31-Aug-2018 | 09:57  | x64      |
| Sqldumper.exe                                                        | 2015.130.4528.0  | 127232    | 31-Aug-2018 | 10:02 | x64      |
| Sqlos.dll                                                            | 2015.130.4528.0  | 27712     | 31-Aug-2018 | 09:57  | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.43 | 4348072   | 02-Feb-2018  | 00:09  | x64      |
| Sqltses.dll                                                          | 2015.130.4528.0  | 9093184   | 31-Aug-2018 | 09:57  | x64      |

SQL Server 2016 Reporting Services

| File   name                                               | File version    | File size | Date      | Time | Platform |
|-----------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Microsoft.analysisservices.modeling.dll                   | 13.0.4528.0     | 611080    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.authorization.dll             | 13.0.4528.0     | 79112     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.dataextensions.dll            | 13.0.4528.0     | 210696    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4528.0     | 168712    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4528.0     | 1620232   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4528.0     | 657672    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4528.0     | 329992    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4528.0     | 1072392   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532224    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532232    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 533568    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532232    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532232    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532224    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532232    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 533568    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532240    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4528.0     | 532232    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4528.0     | 48904     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4528.0     | 163080    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4528.0     | 77888     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.4528.0     | 76552     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4528.0     | 126216    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4528.0     | 106248    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4528.0     | 5959440   | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420352   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420872   | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4422720   | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420872   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4421384   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4421376   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420872   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4423232   | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420360   | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4528.0     | 4420872   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4528.0     | 10886408  | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4528.0     | 101128    | 31-Aug-2018 | 09:56 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4528.0     | 72968     | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4528.0     | 5951752   | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4528.0     | 246024    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4528.0     | 298248    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4528.0     | 208648    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 44800     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 48896     | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 48904     | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 48928     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 53000     | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 50240     | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 50240     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 54336     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 44808     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4528.0     | 48904     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4528.0     | 510728    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.reportingservices.usagetracking.dll             | 2015.130.4528.0 | 47904     | 31-Aug-2018 | 09:58 | x64      |
| Microsoft.reportingservices.wordrendering.dll             | 13.0.4528.0     | 496904    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4528.0 | 397064    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4528.0 | 391952    | 31-Aug-2018 | 09:58 | x86      |
| Msmdlocal.dll                                             | 2015.130.4528.0 | 56208136  | 31-Aug-2018 | 09:57 | x64      |
| Msmdlocal.dll                                             | 2015.130.4528.0 | 37104704  | 31-Aug-2018 | 09:58 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4528.0 | 7507208   | 31-Aug-2018 | 09:57 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4528.0 | 6507776   | 31-Aug-2018 | 09:57 | x86      |
| Msolap130.dll                                             | 2015.130.4528.0 | 8639752   | 31-Aug-2018 | 09:57 | x64      |
| Msolap130.dll                                             | 2015.130.4528.0 | 7009856   | 31-Aug-2018 | 09:58 | x86      |
| Msolui130.dll                                             | 2015.130.4528.0 | 310536    | 31-Aug-2018 | 09:57 | x64      |
| Msolui130.dll                                             | 2015.130.4528.0 | 288832    | 31-Aug-2018 | 09:58 | x86      |
| Reportingservicescompression.dll                          | 2015.130.4528.0 | 62736     | 31-Aug-2018 | 09:57 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4528.0     | 84744     | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4528.0     | 2543880   | 31-Aug-2018 | 09:57 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4528.0 | 108808    | 31-Aug-2018 | 09:57 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4528.0 | 114432    | 31-Aug-2018 | 09:57 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4528.0 | 99104     | 31-Aug-2018 | 09:57 | x64      |
| Reportingservicesservice.exe                              | 2015.130.4528.0 | 2574912   | 31-Aug-2018 | 09:56 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4528.0     | 2710792   | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 868112    | 31-Aug-2018 | 09:56 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 872184    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 872192    | 31-Aug-2018 | 09:56 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 873536    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 876320    | 31-Aug-2018 | 09:58 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 873536    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 873536    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 884496    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 868096    | 31-Aug-2018 | 09:57 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4528.0     | 872192    | 31-Aug-2018 | 09:58 | x86      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4528.0 | 3663112   | 31-Aug-2018 | 09:57 | x64      |
| Reportingserviceswmiprovider.dll                          | 2015.130.4528.0 | 3592256   | 31-Aug-2018 | 09:58 | x86      |
| Rsconfigtool.exe                                          | 13.0.4528.0     | 1405704   | 31-Aug-2018 | 09:59 | x86      |
| Rsctr.dll                                                 | 2015.130.4528.0 | 58632     | 31-Aug-2018 | 09:57 | x64      |
| Rsctr.dll                                                 | 2015.130.4528.0 | 52800     | 31-Aug-2018 | 09:58 | x86      |
| Rshttpruntime.dll                                         | 2015.130.4528.0 | 99592     | 31-Aug-2018 | 09:57 | x64      |
| Sql_rs_keyfile.dll                                        | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqldumper.exe                                             | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56 | x86      |
| Sqldumper.exe                                             | 2015.130.4528.0 | 127248    | 31-Aug-2018 | 09:57 | x64      |
| Sqlrsos.dll                                               | 2015.130.4528.0 | 27712     | 31-Aug-2018 | 09:57 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4528.0 | 732944    | 31-Aug-2018 | 09:57 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.4528.0 | 585792    | 31-Aug-2018 | 09:58 | x86      |
| Xmlrw.dll                                                 | 2015.130.4528.0 | 319248    | 31-Aug-2018 | 09:57 | x64      |
| Xmlrw.dll                                                 | 2015.130.4528.0 | 259856    | 31-Aug-2018 | 09:57 | x86      |
| Xmlrwbin.dll                                              | 2015.130.4528.0 | 227600    | 31-Aug-2018 | 09:57 | x64      |
| Xmlrwbin.dll                                              | 2015.130.4528.0 | 191752    | 31-Aug-2018 | 09:57 | x86      |
| Xmsrv.dll                                                 | 2015.130.4528.0 | 24052288  | 31-Aug-2018 | 09:57 | x64      |
| Xmsrv.dll                                                 | 2015.130.4528.0 | 32727840  | 31-Aug-2018 | 09:57 | x86      |

SQL Server 2016 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 13.0.4528.0     | 23816     | 31-Aug-2018 | 09:57 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |

SQL Server 2016 sql_tools_extensions

| File   name                                     | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                   | 2015.130.4528.0 | 1312000   | 31-Aug-2018 | 09:56 | x86      |
| Ddsshapes.dll                                   | 2015.130.4528.0 | 135936    | 31-Aug-2018 | 09:56 | x86      |
| Dtaengine.exe                                   | 2015.130.4528.0 | 167168    | 31-Aug-2018 | 09:56 | x86      |
| Dteparse.dll                                    | 2015.130.4528.0 | 99584     | 31-Aug-2018 | 09:56 | x86      |
| Dteparse.dll                                    | 2015.130.4528.0 | 109832    | 31-Aug-2018 | 09:57 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4528.0 | 88840     | 31-Aug-2018 | 09:56 | x64      |
| Dteparsemgd.dll                                 | 2015.130.4528.0 | 83728     | 31-Aug-2018 | 09:59 | x86      |
| Dtepkg.dll                                      | 2015.130.4528.0 | 115968    | 31-Aug-2018 | 09:56 | x86      |
| Dtepkg.dll                                      | 2015.130.4528.0 | 137480    | 31-Aug-2018 | 09:57 | x64      |
| Dtexec.exe                                      | 2015.130.4528.0 | 74304     | 31-Aug-2018 | 09:56 | x64      |
| Dtexec.exe                                      | 2015.130.4528.0 | 66816     | 31-Aug-2018 | 09:56 | x86      |
| Dts.dll                                         | 2015.130.4528.0 | 2632960   | 31-Aug-2018 | 09:56 | x86      |
| Dts.dll                                         | 2015.130.4528.0 | 3147040   | 31-Aug-2018 | 09:57 | x64      |
| Dtscomexpreval.dll                              | 2015.130.4528.0 | 419072    | 31-Aug-2018 | 09:56 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4528.0 | 477456    | 31-Aug-2018 | 09:57 | x64      |
| Dtsconn.dll                                     | 2015.130.4528.0 | 392448    | 31-Aug-2018 | 09:56 | x86      |
| Dtsconn.dll                                     | 2015.130.4528.0 | 492808    | 31-Aug-2018 | 09:57 | x64      |
| Dtshost.exe                                     | 2015.130.4528.0 | 88128     | 31-Aug-2018 | 09:56 | x64      |
| Dtshost.exe                                     | 2015.130.4528.0 | 76544     | 31-Aug-2018 | 09:56 | x86      |
| Dtslog.dll                                      | 2015.130.4528.0 | 103168    | 31-Aug-2018 | 09:56 | x86      |
| Dtslog.dll                                      | 2015.130.4528.0 | 120584    | 31-Aug-2018 | 09:57 | x64      |
| Dtsmsg130.dll                                   | 2015.130.4528.0 | 541440    | 31-Aug-2018 | 09:56 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4528.0 | 545544    | 31-Aug-2018 | 09:57 | x64      |
| Dtspipeline.dll                                 | 2015.130.4528.0 | 1059584   | 31-Aug-2018 | 09:56 | x86      |
| Dtspipeline.dll                                 | 2015.130.4528.0 | 1279240   | 31-Aug-2018 | 09:57 | x64      |
| Dtspipelineperf130.dll                          | 2015.130.4528.0 | 42240     | 31-Aug-2018 | 09:56 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4528.0 | 48392     | 31-Aug-2018 | 09:57 | x64      |
| Dtswizard.exe                                   | 13.0.4528.0     | 899040    | 31-Aug-2018 | 09:46 | x86      |
| Dtswizard.exe                                   | 13.0.4528.0     | 895752    | 31-Aug-2018 | 09:56 | x64      |
| Dtuparse.dll                                    | 2015.130.4528.0 | 80128     | 31-Aug-2018 | 09:56 | x86      |
| Dtuparse.dll                                    | 2015.130.4528.0 | 87824     | 31-Aug-2018 | 09:57 | x64      |
| Dtutil.exe                                      | 2015.130.4528.0 | 136256    | 31-Aug-2018 | 09:56 | x64      |
| Dtutil.exe                                      | 2015.130.4528.0 | 115456    | 31-Aug-2018 | 09:56 | x86      |
| Exceldest.dll                                   | 2015.130.4528.0 | 216832    | 31-Aug-2018 | 09:56 | x86      |
| Exceldest.dll                                   | 2015.130.4528.0 | 263944    | 31-Aug-2018 | 09:57 | x64      |
| Excelsrc.dll                                    | 2015.130.4528.0 | 232704    | 31-Aug-2018 | 09:56 | x86      |
| Excelsrc.dll                                    | 2015.130.4528.0 | 285448    | 31-Aug-2018 | 09:57 | x64      |
| Flatfiledest.dll                                | 2015.130.4528.0 | 334592    | 31-Aug-2018 | 09:56 | x86      |
| Flatfiledest.dll                                | 2015.130.4528.0 | 389384    | 31-Aug-2018 | 09:57 | x64      |
| Flatfilesrc.dll                                 | 2015.130.4528.0 | 345344    | 31-Aug-2018 | 09:56 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4528.0 | 401672    | 31-Aug-2018 | 09:57 | x64      |
| Foreachfileenumerator.dll                       | 2015.130.4528.0 | 80640     | 31-Aug-2018 | 09:56 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4528.0 | 96544     | 31-Aug-2018 | 09:57 | x64      |
| Microsoft.analysisservices.adomdclientui.dll    | 13.0.4528.0     | 92424     | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4528.0     | 1313544   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4528.0     | 696608    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4528.0     | 763656    | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4528.0 | 2023176   | 31-Aug-2018 | 09:59 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4528.0 | 42248     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4528.0     | 74816     | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4528.0     | 187968    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4528.0     | 435264    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4528.0     | 433928    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4528.0     | 2046016   | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4528.0     | 2044680   | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4528.0     | 33536     | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4528.0     | 33544     | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4528.0     | 249600    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4528.0     | 249616    | 31-Aug-2018 | 09:58 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4528.0     | 502016    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4528.0     | 606472    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4528.0     | 606464    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4528.0     | 106240    | 31-Aug-2018 | 09:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4528.0 | 139016    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4528.0 | 150280    | 31-Aug-2018 | 09:58 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4528.0 | 144648    | 31-Aug-2018 | 09:56 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4528.0 | 158984    | 31-Aug-2018 | 09:58 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4528.0 | 101128    | 31-Aug-2018 | 09:57 | x64      |
| Msdtssrvrutil.dll                               | 2015.130.4528.0 | 91200     | 31-Aug-2018 | 09:58 | x86      |
| Msmdlocal.dll                                   | 2015.130.4528.0 | 56208136  | 31-Aug-2018 | 09:57 | x64      |
| Msmdlocal.dll                                   | 2015.130.4528.0 | 37104704  | 31-Aug-2018 | 09:58 | x86      |
| Msmdpp.dll                                      | 2015.130.4528.0 | 6371904   | 31-Aug-2018 | 09:58 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4528.0 | 7507208   | 31-Aug-2018 | 09:57 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4528.0 | 6507776   | 31-Aug-2018 | 09:57 | x86      |
| Msolap130.dll                                   | 2015.130.4528.0 | 8639752   | 31-Aug-2018 | 09:57 | x64      |
| Msolap130.dll                                   | 2015.130.4528.0 | 7009856   | 31-Aug-2018 | 09:58 | x86      |
| Msolui130.dll                                   | 2015.130.4528.0 | 310536    | 31-Aug-2018 | 09:57 | x64      |
| Msolui130.dll                                   | 2015.130.4528.0 | 288832    | 31-Aug-2018 | 09:58 | x86      |
| Oledbdest.dll                                   | 2015.130.4528.0 | 264456    | 31-Aug-2018 | 09:57 | x64      |
| Oledbdest.dll                                   | 2015.130.4528.0 | 218176    | 31-Aug-2018 | 09:58 | x86      |
| Oledbsrc.dll                                    | 2015.130.4528.0 | 291080    | 31-Aug-2018 | 09:57 | x64      |
| Oledbsrc.dll                                    | 2015.130.4528.0 | 237120    | 31-Aug-2018 | 09:58 | x86      |
| Profiler.exe                                    | 2015.130.4528.0 | 804616    | 31-Aug-2018 | 09:59 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4528.0 | 100616    | 31-Aug-2018 | 09:57 | x64      |
| Sqldumper.exe                                   | 2015.130.4528.0 | 107776    | 31-Aug-2018 | 09:56 | x86      |
| Sqldumper.exe                                   | 2015.130.4528.0 | 127248    | 31-Aug-2018 | 09:57 | x64      |
| Sqlresld.dll                                    | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57 | x64      |
| Sqlresld.dll                                    | 2015.130.4528.0 | 30272     | 31-Aug-2018 | 09:58 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4528.0 | 32320     | 31-Aug-2018 | 09:57 | x64      |
| Sqlresourceloader.dll                           | 2015.130.4528.0 | 29760     | 31-Aug-2018 | 09:58 | x86      |
| Sqlscm.dll                                      | 2015.130.4528.0 | 61200     | 31-Aug-2018 | 09:57 | x64      |
| Sqlscm.dll                                      | 2015.130.4528.0 | 54336     | 31-Aug-2018 | 09:58 | x86      |
| Sqlsvc.dll                                      | 2015.130.4528.0 | 153664    | 31-Aug-2018 | 09:57 | x64      |
| Sqlsvc.dll                                      | 2015.130.4528.0 | 128576    | 31-Aug-2018 | 09:58 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4528.0 | 182336    | 31-Aug-2018 | 09:57 | x64      |
| Sqltaskconnections.dll                          | 2015.130.4528.0 | 152640    | 31-Aug-2018 | 09:58 | x86      |
| Txdataconvert.dll                               | 2015.130.4528.0 | 298048    | 31-Aug-2018 | 09:57 | x64      |
| Txdataconvert.dll                               | 2015.130.4528.0 | 255240    | 31-Aug-2018 | 09:57 | x86      |
| Xe.dll                                          | 2015.130.4528.0 | 626440    | 31-Aug-2018 | 09:57 | x64      |
| Xe.dll                                          | 2015.130.4528.0 | 558848    | 31-Aug-2018 | 09:57 | x86      |
| Xmlrw.dll                                       | 2015.130.4528.0 | 319248    | 31-Aug-2018 | 09:57 | x64      |
| Xmlrw.dll                                       | 2015.130.4528.0 | 259856    | 31-Aug-2018 | 09:57 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4528.0 | 227600    | 31-Aug-2018 | 09:57 | x64      |
| Xmlrwbin.dll                                    | 2015.130.4528.0 | 191752    | 31-Aug-2018 | 09:57 | x86      |
| Xmsrv.dll                                       | 2015.130.4528.0 | 24052288  | 31-Aug-2018 | 09:57 | x64      |
| Xmsrv.dll                                       | 2015.130.4528.0 | 32727840  | 31-Aug-2018 | 09:57 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)

- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)

- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)

- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)

- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)

- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
