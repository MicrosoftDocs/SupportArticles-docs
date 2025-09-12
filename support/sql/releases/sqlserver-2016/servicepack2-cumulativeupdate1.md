---
title: Cumulative update 1 for SQL Server 2016 SP2 (KB4135048)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 1 (KB4135048).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4135048
appliesto:
- SQL Server 2016
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB4135048 - Cumulative Update 1 for SQL Server 2016 SP2

_Release Date:_ &nbsp; May 30, 2018  
_Version:_ &nbsp; 13.0.5149.0

This article describes Cumulative Update package 1 (CU1) (build number: **13.0.5149.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="11983360">[11983360](#11983360)</a> | [FIX: "An unexpected error occurred" when you use DAX measures in Power BI table visualizations in SQL Server (KB4094858)](https://support.microsoft.com/help/4094858) | Analysis Services |
| <a id="11983376">[11983376](#11983376)</a> | [FIX: A crash occurs when proactive caching is triggered for a dimension in SSAS (KB3028216)](https://support.microsoft.com/help/3028216) | Analysis Services |
| <a id="11983395">[11983395](#11983395)</a> | [FIX: Access violation occurs when executing a DAX query on a tabular model in SQL Server Analysis Services (KB4086173)](https://support.microsoft.com/help/4086173) | Analysis Services |
| <a id="11983359">[11983359](#11983359)</a> | FIX: Deploying an SSAS project in SSDT is frequently unsuccessful in SQL Server Analysis Services in Tabular mode (KB4132267) | Analysis Services |
| <a id="11983369">[11983369](#11983369)</a> | FIX: Processing a cube with many partitions generates lots of concurrent data source connections in SSAS (KB4134175) | Analysis Services |
| <a id="11983373">[11983373](#11983373)</a> | FIX: An internal exception access violation occurs and the SSAS server stops responding (KB4162814) | Analysis Services |
| <a id="11578522">[11578522](#11578522)</a> | [Improvement: Performance issue when upgrading MDS from SQL Server 2012 to 2016 (KB4089718)](https://support.microsoft.com/help/4089718) | Data Quality Services (DQS) |
| <a id="11684529">[11684529](#11684529)</a> | [FIX: Wrong user name appears when two users log on to MDS at different times in SQL Server (KB4164562)](https://support.microsoft.com/help/4164562) | Data Quality Services (DQS) |
| <a id="11983367">[11983367](#11983367)</a> | Fixes Error (System.Runtime.InteropServices.COMException (0x800A03EC): Exception from HRESULT: 0x800A03EC) with MDS add-in for Excel when using the German version of Excel. | Data Quality Services (DQS) |
| <a id="11983366">[11983366](#11983366)</a> | [FIX: Parallel redo in a secondary replica of an availability group that contains heap tables generates a runtime assert dump or the SQL Server crashes with an access violation error (KB4101554)](https://support.microsoft.com/help/4101554) | High Availability |
| <a id="11922532">[11922532](#11922532)</a> | [FIX: Floating point overflow error occurs when you execute a nested natively compiled module that uses EXP functions in SQL Server (KB4157948)](https://support.microsoft.com/help/4157948) | In-Memory OLTP |
| <a id="11983323">[11983323](#11983323)</a> | FIX: Error when a SQL Server Agent job executes a PowerShell command to enumerate permissions of the database (KB4133164) | Management Tools |
| <a id="11750742">[11750742](#11750742)</a> | FIX: Hidden parameters are included in reports when the Browser role is used in SSRS 2016 (KB4098762) | Reporting Services |
| <a id="11983363">[11983363](#11983363)</a> | Browser Role behavior change in Reporting Services for displaying parameter properties. | Reporting Services |
| <a id="11983372">[11983372](#11983372)</a> | Fixes a setup error when applying a SQL Server security patch on a Customized Cluster on the Passive Node. Note this isn't the Failover Cluster Instance of SQL Server. | Setup & Install |
| <a id="11983390">[11983390](#11983390)</a> | [PFS page round robin algorithm improvement in SQL Server 2016 (KB4099472)](https://support.microsoft.com/help/4099472) | SQL Engine |
| <a id="11057341">[11057341](#11057341)</a> | [FIX: RESTORE HEADERONLY statement for a TDE compressed backup takes a long time to complete in SQL Server (KB4052135)](https://support.microsoft.com/help/4052135) | SQL Engine |
| <a id="11516235">[11516235](#11516235)</a> | [FIX: Error 9002 when there's no sufficient disk space for critical log growth in SQL Server 2014, 2016, and 2017 (KB4087406)](https://support.microsoft.com/help/4087406) | SQL Engine |
| <a id="11695337">[11695337](#11695337)</a> | [FIX: "Cannot use SAVE TRANSACTION within a distributed transaction" error when you execute a stored procedure in SQL Server (KB4092554)](https://support.microsoft.com/help/4092554) | SQL Engine |
| <a id="11971819">[11971819](#11971819)</a> | [FIX: A memory assertion failure occurs and the server is unable to make any new connections in SQL Server (KB4230516)](https://support.microsoft.com/help/4230516) | SQL Engine |
| <a id="11983358">[11983358](#11983358)</a> | [FIX: Database can't be dropped after its storage is disconnected and reconnected in SQL Server (KB4094893)](https://support.microsoft.com/help/4094893) | SQL Engine |
| <a id="11983362">[11983362](#11983362)</a> | [FIX: One worker thread seems to hang after another worker thread is aborted when you run a parallel query in SQL Server (KB4094706)](https://support.microsoft.com/help/4094706) | SQL Engine |
| <a id="11983383">[11983383](#11983383)</a> | [FIX: Performance is slow for an Always On AG when you process a read query in SQL Server (KB4163087)](https://support.microsoft.com/help/4163087) | SQL Engine |
| <a id="11983392">[11983392](#11983392)</a> | [FIX: TDE-enabled database backup with compression causes database corruption in SQL Server 2016 (KB4101502)](https://support.microsoft.com/help/4101502) | SQL Engine |
| <a id="11983382">[11983382](#11983382)</a> | FIX: Restore of a TDE compressed backup is unsuccessful when using the VDI client (KB4230306) | SQL Engine |
| <a id="11983365">[11983365](#11983365)</a> | Fixes Msg 109 (A transport-level error has occurred when receiving results from the server) when you execute a linked server query. This error happens when the query processor gathers metadata about the remote table indexes. | SQL Engine |
| <a id="11983357">[11983357](#11983357)</a> | [FIX: Access violation occurs when you query a table with an integer column in SQL Server 2017 and SQL Server 2016 (KB4091245)](https://support.microsoft.com/help/4091245) | SQL performance |
| <a id="11983379">[11983379](#11983379)</a> | [FIX: An assertion failure occurs when you execute a nested select query against a columnstore index in SQL Server (KB4131960)](https://support.microsoft.com/help/4131960) | SQL performance |
| <a id="11983394">[11983394](#11983394)</a> | [FIX: An access violation occurs when incremental statistics are automatically updated on a table in SQL Server (KB4163478)](https://support.microsoft.com/help/4163478) | SQL performance |
| <a id="11983386">[11983386](#11983386)</a> | [FIX: TDE-enabled backup and restore operations are slow if the encryption key is stored in an EKM provider in SQL Server (KB4058175)](https://support.microsoft.com/help/4058175) | SQL security |
| <a id="11983381">[11983381](#11983381)</a> | FIX: TDE database goes offline during log flush operations when connectivity issues cause the EKM provider to become inaccessible in SQL Server (KB4293839) | SQL security |
| <a id="11983391">[11983391](#11983391)</a> | [Performance issues occur in the form of PAGELATCH_EX and PAGELATCH_SH waits in TempDB when you use SQL Server 2016 (KB4131193)](https://support.microsoft.com/help/4131193) | SQL Engine |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP2 now](https://www.microsoft.com/download/details.aspx?id=56975)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this and all previous CUs can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, we recommend that you always install the latest cumulative update that is available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 SP2 is available at the Download Center.

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

When you deploy an update to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the update:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply an update:
    >
    > - Install the update on the passive node.
    > - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2016 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

1. In Control Panel, select **View installed updates** under **Programs and Features**.
1. Locate the entry that corresponds to this cumulative update package under Microsoft SQL Server 2016.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP2.

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

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

|        File name       |   File version  | File size |    Date   |  Time | Platform |
|:----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll         | 2015.130.4474.0 | 53424     | 24-Feb-18 | 23:35 | x86      |
| Msmdredir.dll          | 2015.130.4474.0 | 6421680   | 24-Feb-18 | 23:35 | x86      |
| Msmdsrv.rll            | 2015.130.4474.0 | 1296560   | 24-Feb-18 | 23:35 | x86      |
| Msmdsrvi.rll           | 2015.130.4474.0 | 1293488   | 24-Feb-18 | 23:35 | x86      |
| Sqlbrowser.exe         | 2015.130.4474.0 | 276656    | 24-Feb-18 | 23:35 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-18 | 23:35 | x86      |
| Sqldumper.exe          | 2015.130.4474.0 | 107696    | 24-Feb-18 | 23:35 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                             | 2015.130.4474.0  | 160424    | 24-Feb-18 | 23:35 | x86      |
| Instapi130.dll                              | 2015.130.4474.0  | 53424     | 24-Feb-18 | 23:35 | x86      |
| Isacctchange.dll                            | 2015.130.4474.0  | 29360     | 24-Feb-18 | 23:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4474.0      | 1027248   | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4474.0      | 1348784   | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4474.0      | 702640    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4474.0      | 765616    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4474.0      | 520880    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4474.0      | 711856    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4474.0      | 37032     | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4474.0      | 46256     | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4474.0  | 72872     | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4474.0      | 598704    | 24-Feb-18 | 23:37 | x86      |
| Msasxpress.dll                              | 2015.130.4474.0  | 31920     | 24-Feb-18 | 23:35 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4474.0  | 60080     | 24-Feb-18 | 23:35 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4474.0  | 88752     | 24-Feb-18 | 23:35 | x86      |
| Sqldumper.exe                               | 2015.130.4474.0  | 107696    | 24-Feb-18 | 23:35 | x86      |
| Sqlftacct.dll                               | 2015.130.4474.0  | 46768     | 24-Feb-18 | 23:35 | x86      |
| Sqlmanager.dll                              | 2015.130.16111.4 | 607920    | 03-Jan-18 | 03:04 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4474.0  | 364208    | 24-Feb-18 | 23:35 | x86      |
| Sqlsecacctchg.dll                           | 2015.130.4474.0  | 34992     | 24-Feb-18 | 23:35 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4474.0  | 267440    | 24-Feb-18 | 23:35 | x86      |
| Sqltdiagn.dll                               | 2015.130.4474.0  | 60592     | 24-Feb-18 | 23:35 | x86      |
| Svrenumapi130.dll                           | 2015.130.4474.0  | 854192    | 24-Feb-18 | 23:35 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4474.0  | 1876656   | 24-Feb-18 | 23:37 | x86      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.130.4474.0 | 121008    | 24-Feb-18 | 23:35 | x86      |
| Dreplaycommon.dll              | 2015.130.4474.0 | 690864    | 24-Feb-18 | 23:36 | x86      |
| Dreplayserverps.dll            | 2015.130.4474.0 | 32944     | 24-Feb-18 | 23:35 | x86      |
| Dreplayutil.dll                | 2015.130.4474.0 | 309936    | 24-Feb-18 | 23:35 | x86      |
| Instapi130.dll                 | 2015.130.4474.0 | 53424     | 24-Feb-18 | 23:35 | x86      |
| Sql_dreplay_client_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-18 | 23:35 | x86      |
| Sqlresourceloader.dll          | 2015.130.4474.0 | 28336     | 24-Feb-18 | 23:35 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.130.4474.0 | 690864    | 24-Feb-18 | 23:36 | x86      |
| Dreplaycontroller.exe              | 2015.130.4474.0 | 350384    | 24-Feb-18 | 23:35 | x86      |
| Dreplayprocess.dll                 | 2015.130.4474.0 | 171696    | 24-Feb-18 | 23:35 | x86      |
| Dreplayserverps.dll                | 2015.130.4474.0 | 32944     | 24-Feb-18 | 23:35 | x86      |
| Instapi130.dll                     | 2015.130.4474.0 | 53424     | 24-Feb-18 | 23:35 | x86      |
| Sql_dreplay_controller_keyfile.dll | 2015.130.4474.0 | 88752     | 24-Feb-18 | 23:35 | x86      |
| Sqlresourceloader.dll              | 2015.130.4474.0 | 28336     | 24-Feb-18 | 23:35 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                    |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                   | 2015.130.4474.0 | 1311920   | 24-Feb-18 | 23:35 | x86      |
| Ddsshapes.dll                                   | 2015.130.4474.0 | 135856    | 24-Feb-18 | 23:35 | x86      |
| Dtaengine.exe                                   | 2015.130.4474.0 | 167088    | 24-Feb-18 | 23:35 | x86      |
| Dteparse.dll                                    | 2015.130.4474.0 | 99504     | 24-Feb-18 | 23:35 | x86      |
| Dteparsemgd.dll                                 | 2015.130.4474.0 | 83632     | 24-Feb-18 | 23:36 | x86      |
| Dtepkg.dll                                      | 2015.130.4474.0 | 115888    | 24-Feb-18 | 23:35 | x86      |
| Dtexec.exe                                      | 2015.130.4474.0 | 66736     | 24-Feb-18 | 23:35 | x86      |
| Dts.dll                                         | 2015.130.4474.0 | 2632880   | 24-Feb-18 | 23:35 | x86      |
| Dtscomexpreval.dll                              | 2015.130.4474.0 | 418984    | 24-Feb-18 | 23:35 | x86      |
| Dtsconn.dll                                     | 2015.130.4474.0 | 392368    | 24-Feb-18 | 23:35 | x86      |
| Dtshost.exe                                     | 2015.130.4474.0 | 76464     | 24-Feb-18 | 23:35 | x86      |
| Dtslog.dll                                      | 2015.130.4474.0 | 103088    | 24-Feb-18 | 23:35 | x86      |
| Dtsmsg130.dll                                   | 2015.130.4474.0 | 541360    | 24-Feb-18 | 23:35 | x86      |
| Dtspipeline.dll                                 | 2015.130.4474.0 | 1059504   | 24-Feb-18 | 23:35 | x86      |
| Dtspipelineperf130.dll                          | 2015.130.4474.0 | 42160     | 24-Feb-18 | 23:35 | x86      |
| Dtswizard.exe                                   | 13.0.4474.0     | 896176    | 24-Feb-18 | 23:28 | x86      |
| Dtuparse.dll                                    | 2015.130.4474.0 | 80048     | 24-Feb-18 | 23:35 | x86      |
| Dtutil.exe                                      | 2015.130.4474.0 | 115376    | 24-Feb-18 | 23:35 | x86      |
| Exceldest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-18 | 23:35 | x86      |
| Excelsrc.dll                                    | 2015.130.4474.0 | 232624    | 24-Feb-18 | 23:35 | x86      |
| Flatfiledest.dll                                | 2015.130.4474.0 | 334512    | 24-Feb-18 | 23:35 | x86      |
| Flatfilesrc.dll                                 | 2015.130.4474.0 | 345264    | 24-Feb-18 | 23:35 | x86      |
| Foreachfileenumerator.dll                       | 2015.130.4474.0 | 80560     | 24-Feb-18 | 23:35 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4474.0     | 1313456   | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4474.0     | 696496    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4474.0     | 763568    | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4474.0 | 2023088   | 24-Feb-18 | 23:36 | x86      |
| Microsoft.analysisservices.projectui.dll        | 2015.130.4474.0 | 42160     | 24-Feb-18 | 23:35 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4474.0     | 72368     | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4474.0     | 186544    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4474.0     | 433840    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4474.0     | 2044592   | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4474.0     | 33456     | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4474.0     | 249520    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4474.0     | 501928    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4474.0     | 606384    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4474.0     | 106160    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4474.0 | 138928    | 24-Feb-18 | 23:37 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4474.0 | 144560    | 24-Feb-18 | 23:37 | x86      |
| Msdtssrvrutil.dll                               | 2015.130.4474.0 | 89776     | 24-Feb-18 | 23:35 | x86      |
| Msmdlocal.dll                                   | 2015.130.4474.0 | 37097648  | 24-Feb-18 | 23:35 | x86      |
| Msmdpp.dll                                      | 2015.130.4474.0 | 6370480   | 24-Feb-18 | 23:35 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4474.0 | 6507696   | 24-Feb-18 | 23:37 | x86      |
| Msolap130.dll                                   | 2015.130.4474.0 | 7008432   | 24-Feb-18 | 23:35 | x86      |
| Msolui130.dll                                   | 2015.130.4474.0 | 287408    | 24-Feb-18 | 23:35 | x86      |
| Oledbdest.dll                                   | 2015.130.4474.0 | 216752    | 24-Feb-18 | 23:35 | x86      |
| Oledbsrc.dll                                    | 2015.130.4474.0 | 235696    | 24-Feb-18 | 23:35 | x86      |
| Profiler.exe                                    | 2015.130.4474.0 | 804528    | 24-Feb-18 | 23:28 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4474.0 | 88752     | 24-Feb-18 | 23:35 | x86      |
| Sqldumper.exe                                   | 2015.130.4474.0 | 107696    | 24-Feb-18 | 23:35 | x86      |
| Sqlresld.dll                                    | 2015.130.4474.0 | 28848     | 24-Feb-18 | 23:35 | x86      |
| Sqlresourceloader.dll                           | 2015.130.4474.0 | 28336     | 24-Feb-18 | 23:35 | x86      |
| Sqlscm.dll                                      | 2015.130.4474.0 | 52912     | 24-Feb-18 | 23:35 | x86      |
| Sqlsvc.dll                                      | 2015.130.4474.0 | 127144    | 24-Feb-18 | 23:35 | x86      |
| Sqltaskconnections.dll                          | 2015.130.4474.0 | 151216    | 24-Feb-18 | 23:35 | x86      |
| Txdataconvert.dll                               | 2015.130.4474.0 | 255152    | 24-Feb-18 | 23:36 | x86      |
| Xe.dll                                          | 2015.130.4474.0 | 558768    | 24-Feb-18 | 23:35 | x86      |
| Xmlrw.dll                                       | 2015.130.4474.0 | 259760    | 24-Feb-18 | 23:36 | x86      |
| Xmlrwbin.dll                                    | 2015.130.4474.0 | 191664    | 24-Feb-18 | 23:36 | x86      |
| Xmsrv.dll                                       | 2015.130.4474.0 | 32720560  | 24-Feb-18 | 23:36 | x86      |

x64-based versions

SQL Server 2016 Browser Service

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll | 2015.131.5149.0 | 53424     | 19-May-18 | 20:00 | x86      |
| Keyfile.dll    | 2015.131.5149.0 | 88752     | 19-May-18 | 20:00 | x86      |
| Sqlbrowser.exe | 2015.131.5149.0 | 276656    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe  | 2015.131.5149.0 | 107696    | 19-May-18 | 20:00 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sqlboot.dll           | 2015.131.5149.0 | 186544    | 19-May-18 | 20:01 | x64      |
| Sqldumper.exe         | 2015.131.5149.0 | 127152    | 19-May-18 | 20:01 | x64      |
| Sqlvdi.dll            | 2015.131.5149.0 | 168624    | 19-May-18 | 20:00 | x86      |
| Sqlvdi.dll            | 2015.131.5149.0 | 197296    | 19-May-18 | 20:01 | x64      |
| Sqlwriter.exe         | 2015.131.5149.0 | 131760    | 19-May-18 | 20:01 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlwvss.dll           | 2015.131.5149.0 | 336560    | 19-May-18 | 20:02 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5149.0 | 26288     | 19-May-18 | 20:02 | x64      |

SQL Server 2016 Analysis Services

|             File name             |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.applicationinsights.dll | 2.6.0.6787      | 239328    | 10-May-18 | 12:56 | x86      |
| Msmdctr130.dll                    | 2015.131.5149.0 | 40112     | 19-May-18 | 20:01 | x64      |
| Msmdlocal.dll                     | 2015.131.5149.0 | 37099184  | 19-May-18 | 20:00 | x86      |
| Msmdlocal.dll                     | 2015.131.5149.0 | 56206512  | 19-May-18 | 20:01 | x64      |
| Msmdsrv.exe                       | 2015.131.5149.0 | 56746160  | 19-May-18 | 20:01 | x64      |
| Msmgdsrv.dll                      | 2015.131.5149.0 | 7507120   | 19-May-18 | 20:00 | x64      |
| Msmgdsrv.dll                      | 2015.131.5149.0 | 6507688   | 19-May-18 | 20:23 | x86      |
| Msolui130.dll                     | 2015.131.5149.0 | 287408    | 19-May-18 | 20:00 | x86      |
| Msolui130.dll                     | 2015.131.5149.0 | 310448    | 19-May-18 | 20:01 | x64      |
| Sql_as_keyfile.dll                | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlboot.dll                       | 2015.131.5149.0 | 186544    | 19-May-18 | 20:01 | x64      |
| Sqlceip.exe                       | 13.0.5149.0     | 253616    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe                     | 2015.131.5149.0 | 107696    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe                     | 2015.131.5149.0 | 127152    | 19-May-18 | 20:01 | x64      |
| Tmapi.dll                         | 2015.131.5149.0 | 4346032   | 19-May-18 | 20:02 | x64      |
| Tmcachemgr.dll                    | 2015.131.5149.0 | 2826416   | 19-May-18 | 20:02 | x64      |
| Tmpersistence.dll                 | 2015.131.5149.0 | 1071280   | 19-May-18 | 20:02 | x64      |
| Tmtransactions.dll                | 2015.131.5149.0 | 1352368   | 19-May-18 | 20:02 | x64      |
| Xe.dll                            | 2015.131.5149.0 | 626352    | 19-May-18 | 20:01 | x64      |
| Xmlrw.dll                         | 2015.131.5149.0 | 259760    | 19-May-18 | 20:00 | x86      |
| Xmlrw.dll                         | 2015.131.5149.0 | 319144    | 19-May-18 | 20:01 | x64      |
| Xmlrwbin.dll                      | 2015.131.5149.0 | 191664    | 19-May-18 | 20:00 | x86      |
| Xmlrwbin.dll                      | 2015.131.5149.0 | 227504    | 19-May-18 | 20:01 | x64      |
| Xmsrv.dll                         | 2015.131.5149.0 | 32727216  | 19-May-18 | 20:00 | x86      |
| Xmsrv.dll                         | 2015.131.5149.0 | 24050856  | 19-May-18 | 20:02 | x64      |

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2015.131.5149.0 | 160424    | 19-May-18 | 20:00 | x86      |
| Batchparser.dll                      | 2015.131.5149.0 | 180912    | 19-May-18 | 20:01 | x64      |
| Instapi130.dll                       | 2015.131.5149.0 | 53424     | 19-May-18 | 20:00 | x86      |
| Instapi130.dll                       | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Isacctchange.dll                     | 2015.131.5149.0 | 29360     | 19-May-18 | 20:00 | x86      |
| Isacctchange.dll                     | 2015.131.5149.0 | 30896     | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.131.5149.0 | 75440     | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.131.5149.0 | 72880     | 19-May-18 | 20:03 | x86      |
| Msasxpress.dll                       | 2015.131.5149.0 | 31920     | 19-May-18 | 20:00 | x86      |
| Msasxpress.dll                       | 2015.131.5149.0 | 36016     | 19-May-18 | 20:01 | x64      |
| Pbsvcacctsync.dll                    | 2015.131.5149.0 | 60072     | 19-May-18 | 20:00 | x86      |
| Pbsvcacctsync.dll                    | 2015.131.5149.0 | 72880     | 19-May-18 | 20:01 | x64      |
| Sql_common_core_keyfile.dll          | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqldumper.exe                        | 2015.131.5149.0 | 107696    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe                        | 2015.131.5149.0 | 127152    | 19-May-18 | 20:01 | x64      |
| Sqlftacct.dll                        | 2015.131.5149.0 | 46768     | 19-May-18 | 20:00 | x86      |
| Sqlftacct.dll                        | 2015.131.5149.0 | 51888     | 19-May-18 | 20:01 | x64      |
| Sqlmgmprovider.dll                   | 2015.131.5149.0 | 364208    | 19-May-18 | 20:00 | x86      |
| Sqlmgmprovider.dll                   | 2015.131.5149.0 | 404144    | 19-May-18 | 20:02 | x64      |
| Sqlsecacctchg.dll                    | 2015.131.5149.0 | 34992     | 19-May-18 | 20:00 | x86      |
| Sqlsecacctchg.dll                    | 2015.131.5149.0 | 37552     | 19-May-18 | 20:02 | x64      |
| Sqltdiagn.dll                        | 2015.131.5149.0 | 60592     | 19-May-18 | 20:00 | x86      |
| Sqltdiagn.dll                        | 2015.131.5149.0 | 67752     | 19-May-18 | 20:02 | x64      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5149.0 | 121008    | 19-May-18 | 20:00 | x86      |
| Dreplaycommon.dll              | 2015.131.5149.0 | 690864    | 19-May-18 | 20:01 | x86      |
| Dreplayutil.dll                | 2015.131.5149.0 | 309936    | 19-May-18 | 20:00 | x86      |
| Instapi130.dll                 | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlresourceloader.dll          | 2015.131.5149.0 | 28328     | 19-May-18 | 20:00 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5149.0 | 690864    | 19-May-18 | 20:01 | x86      |
| Dreplaycontroller.exe              | 2015.131.5149.0 | 350384    | 19-May-18 | 20:00 | x86      |
| Dreplayprocess.dll                 | 2015.131.5149.0 | 171696    | 19-May-18 | 20:00 | x86      |
| Instapi130.dll                     | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlresourceloader.dll              | 2015.131.5149.0 | 28328     | 19-May-18 | 20:00 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5149.0 | 180912    | 19-May-18 | 20:01 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5149.0 | 225456    | 19-May-18 | 20:01 | x64      |
| Dcexec.exe                                   | 2015.131.5149.0 | 74416     | 19-May-18 | 20:01 | x64      |
| Fssres.dll                                   | 2015.131.5149.0 | 81584     | 19-May-18 | 20:01 | x64      |
| Hadrres.dll                                  | 2015.131.5149.0 | 177840    | 19-May-18 | 20:01 | x64      |
| Hkcompile.dll                                | 2015.131.5149.0 | 1298096   | 19-May-18 | 20:01 | x64      |
| Hkengine.dll                                 | 2015.131.5149.0 | 5600944   | 19-May-18 | 20:01 | x64      |
| Hkruntime.dll                                | 2015.131.5149.0 | 158888    | 19-May-18 | 20:01 | x64      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787      | 239328    | 10-May-18 | 12:56 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5149.0 | 71344     | 19-May-18 | 20:00 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5149.0 | 65200     | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5149.0 | 150192    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5149.0 | 158896    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5149.0 | 272048    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5149.0 | 74928     | 19-May-18 | 20:01 | x64      |
| Odsole70.dll                                 | 2015.131.5149.0 | 92848     | 19-May-18 | 20:01 | x64      |
| Opends60.dll                                 | 2015.131.5149.0 | 32944     | 19-May-18 | 20:01 | x64      |
| Qds.dll                                      | 2015.131.5149.0 | 845488    | 19-May-18 | 20:01 | x64      |
| Rsfxft.dll                                   | 2015.131.5149.0 | 34480     | 19-May-18 | 20:01 | x64      |
| Sqagtres.dll                                 | 2015.131.5149.0 | 64688     | 19-May-18 | 20:01 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlaamss.dll                                 | 2015.131.5149.0 | 80560     | 19-May-18 | 20:00 | x64      |
| Sqlaccess.dll                                | 2015.131.5149.0 | 462512    | 19-May-18 | 20:01 | x64      |
| Sqlagent.exe                                 | 2015.131.5149.0 | 566448    | 19-May-18 | 20:01 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5149.0 | 44208     | 19-May-18 | 20:00 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5149.0 | 51888     | 19-May-18 | 20:00 | x64      |
| Sqlagentlog.dll                              | 2015.131.5149.0 | 32944     | 19-May-18 | 20:01 | x64      |
| Sqlagentmail.dll                             | 2015.131.5149.0 | 47792     | 19-May-18 | 20:00 | x64      |
| Sqlboot.dll                                  | 2015.131.5149.0 | 186544    | 19-May-18 | 20:01 | x64      |
| Sqlceip.exe                                  | 13.0.5149.0     | 253616    | 19-May-18 | 20:00 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5149.0 | 60080     | 19-May-18 | 20:01 | x64      |
| Sqldk.dll                                    | 2015.131.5149.0 | 2587312   | 19-May-18 | 20:01 | x64      |
| Sqldtsss.dll                                 | 2015.131.5149.0 | 97456     | 19-May-18 | 20:00 | x64      |
| Sqliosim.com                                 | 2015.131.5149.0 | 307888    | 19-May-18 | 20:00 | x64      |
| Sqliosim.exe                                 | 2015.131.5149.0 | 3014320   | 19-May-18 | 20:01 | x64      |
| Sqllang.dll                                  | 2015.131.5149.0 | 39492784  | 19-May-18 | 20:01 | x64      |
| Sqlmin.dll                                   | 2015.131.5149.0 | 37749936  | 19-May-18 | 20:02 | x64      |
| Sqlolapss.dll                                | 2015.131.5149.0 | 97968     | 19-May-18 | 20:00 | x64      |
| Sqlos.dll                                    | 2015.131.5149.0 | 26288     | 19-May-18 | 20:01 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5149.0 | 58544     | 19-May-18 | 20:02 | x64      |
| Sqlrepss.dll                                 | 2015.131.5149.0 | 54960     | 19-May-18 | 20:02 | x64      |
| Sqlresld.dll                                 | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlscm.dll                                   | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5149.0 | 27824     | 19-May-18 | 20:02 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5149.0 | 5799600   | 19-May-18 | 20:01 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5149.0 | 732848    | 19-May-18 | 20:01 | x64      |
| Sqlservr.exe                                 | 2015.131.5149.0 | 393392    | 19-May-18 | 20:01 | x64      |
| Sqlsvc.dll                                   | 2015.131.5149.0 | 152240    | 19-May-18 | 20:02 | x64      |
| Sqltses.dll                                  | 2015.131.5149.0 | 8896688   | 19-May-18 | 20:02 | x64      |
| Sqsrvres.dll                                 | 2015.131.5149.0 | 251056    | 19-May-18 | 20:02 | x64      |
| Xe.dll                                       | 2015.131.5149.0 | 626352    | 19-May-18 | 20:01 | x64      |
| Xmlrw.dll                                    | 2015.131.5149.0 | 319144    | 19-May-18 | 20:01 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5149.0 | 227504    | 19-May-18 | 20:01 | x64      |
| Xpadsi.exe                                   | 2015.131.5149.0 | 79024     | 19-May-18 | 20:45 | x64      |
| Xplog70.dll                                  | 2015.131.5149.0 | 65712     | 19-May-18 | 20:01 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5149.0 | 33456     | 19-May-18 | 20:01 | x64      |
| Xpstar.dll                                   | 2015.131.5149.0 | 422576    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5149.0 | 160424    | 19-May-18 | 20:00 | x86      |
| Batchparser.dll                              | 2015.131.5149.0 | 180912    | 19-May-18 | 20:01 | x64      |
| Bcp.exe                                      | 2015.131.5149.0 | 119984    | 19-May-18 | 20:01 | x64      |
| Commanddest.dll                              | 2015.131.5149.0 | 249008    | 19-May-18 | 20:01 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5149.0 | 115888    | 19-May-18 | 20:01 | x64      |
| Datacollectortasks.dll                       | 2015.131.5149.0 | 188080    | 19-May-18 | 20:01 | x64      |
| Dteparse.dll                                 | 2015.131.5149.0 | 109744    | 19-May-18 | 20:01 | x64      |
| Dteparsemgd.dll                              | 2015.131.5149.0 | 88752     | 19-May-18 | 20:00 | x64      |
| Dtepkg.dll                                   | 2015.131.5149.0 | 137392    | 19-May-18 | 20:01 | x64      |
| Dtexec.exe                                   | 2015.131.5149.0 | 72880     | 19-May-18 | 20:01 | x64      |
| Dts.dll                                      | 2015.131.5149.0 | 3146928   | 19-May-18 | 20:01 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5149.0 | 477360    | 19-May-18 | 20:01 | x64      |
| Dtsconn.dll                                  | 2015.131.5149.0 | 492720    | 19-May-18 | 20:01 | x64      |
| Dtshost.exe                                  | 2015.131.5149.0 | 86704     | 19-May-18 | 20:01 | x64      |
| Dtslog.dll                                   | 2015.131.5149.0 | 120496    | 19-May-18 | 20:01 | x64      |
| Dtsmsg130.dll                                | 2015.131.5149.0 | 545456    | 19-May-18 | 20:01 | x64      |
| Dtspipeline.dll                              | 2015.131.5149.0 | 1279152   | 19-May-18 | 20:01 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5149.0 | 48304     | 19-May-18 | 20:01 | x64      |
| Dtuparse.dll                                 | 2015.131.5149.0 | 87720     | 19-May-18 | 20:01 | x64      |
| Dtutil.exe                                   | 2015.131.5149.0 | 134832    | 19-May-18 | 20:01 | x64      |
| Exceldest.dll                                | 2015.131.5149.0 | 263344    | 19-May-18 | 20:01 | x64      |
| Excelsrc.dll                                 | 2015.131.5149.0 | 285360    | 19-May-18 | 20:01 | x64      |
| Execpackagetask.dll                          | 2015.131.5149.0 | 166576    | 19-May-18 | 20:01 | x64      |
| Flatfiledest.dll                             | 2015.131.5149.0 | 389296    | 19-May-18 | 20:01 | x64      |
| Flatfilesrc.dll                              | 2015.131.5149.0 | 401584    | 19-May-18 | 20:01 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5149.0 | 96432     | 19-May-18 | 20:01 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5149.0 | 59056     | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5149.0 | 150192    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5149.0 | 158896    | 19-May-18 | 20:01 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5149.0 | 101552    | 19-May-18 | 20:01 | x64      |
| Msxmlsql.dll                                 | 2015.131.5149.0 | 1494704   | 19-May-18 | 20:01 | x64      |
| Oledbdest.dll                                | 2015.131.5149.0 | 264368    | 19-May-18 | 20:01 | x64      |
| Oledbsrc.dll                                 | 2015.131.5149.0 | 290992    | 19-May-18 | 20:01 | x64      |
| Osql.exe                                     | 2015.131.5149.0 | 75440     | 19-May-18 | 20:01 | x64      |
| Rawdest.dll                                  | 2015.131.5149.0 | 209584    | 19-May-18 | 20:01 | x64      |
| Rawsource.dll                                | 2015.131.5149.0 | 196784    | 19-May-18 | 20:01 | x64      |
| Recordsetdest.dll                            | 2015.131.5149.0 | 187056    | 19-May-18 | 20:01 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlcmd.exe                                   | 2015.131.5149.0 | 249520    | 19-May-18 | 20:01 | x64      |
| Sqldiag.exe                                  | 2015.131.5149.0 | 1257648   | 19-May-18 | 20:01 | x64      |
| Sqlresld.dll                                 | 2015.131.5149.0 | 28848     | 19-May-18 | 20:00 | x86      |
| Sqlresld.dll                                 | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5149.0 | 28328     | 19-May-18 | 20:00 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlscm.dll                                   | 2015.131.5149.0 | 52912     | 19-May-18 | 20:00 | x86      |
| Sqlscm.dll                                   | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sqlsvc.dll                                   | 2015.131.5149.0 | 127152    | 19-May-18 | 20:00 | x86      |
| Sqlsvc.dll                                   | 2015.131.5149.0 | 152240    | 19-May-18 | 20:02 | x64      |
| Sqltaskconnections.dll                       | 2015.131.5149.0 | 180912    | 19-May-18 | 20:02 | x64      |
| Sqlwep130.dll                                | 2015.131.5149.0 | 105648    | 19-May-18 | 20:02 | x64      |
| Ssisoledb.dll                                | 2015.131.5149.0 | 216240    | 19-May-18 | 20:02 | x64      |
| Txagg.dll                                    | 2015.131.5149.0 | 364720    | 19-May-18 | 20:02 | x64      |
| Txbdd.dll                                    | 2015.131.5149.0 | 172720    | 19-May-18 | 20:02 | x64      |
| Txdatacollector.dll                          | 2015.131.5149.0 | 367792    | 19-May-18 | 20:02 | x64      |
| Txdataconvert.dll                            | 2015.131.5149.0 | 296624    | 19-May-18 | 20:02 | x64      |
| Txderived.dll                                | 2015.131.5149.0 | 607920    | 19-May-18 | 20:02 | x64      |
| Txlookup.dll                                 | 2015.131.5149.0 | 532144    | 19-May-18 | 20:02 | x64      |
| Txmerge.dll                                  | 2015.131.5149.0 | 230576    | 19-May-18 | 20:02 | x64      |
| Txmergejoin.dll                              | 2015.131.5149.0 | 278704    | 19-May-18 | 20:02 | x64      |
| Txmulticast.dll                              | 2015.131.5149.0 | 128176    | 19-May-18 | 20:02 | x64      |
| Txrowcount.dll                               | 2015.131.5149.0 | 126640    | 19-May-18 | 20:02 | x64      |
| Txsort.dll                                   | 2015.131.5149.0 | 259248    | 19-May-18 | 20:02 | x64      |
| Txsplit.dll                                  | 2015.131.5149.0 | 600752    | 19-May-18 | 20:02 | x64      |
| Txunionall.dll                               | 2015.131.5149.0 | 181936    | 19-May-18 | 20:02 | x64      |
| Xe.dll                                       | 2015.131.5149.0 | 626352    | 19-May-18 | 20:01 | x64      |
| Xmlrw.dll                                    | 2015.131.5149.0 | 319144    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5149.0 | 1014960   | 19-May-18 | 20:01 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlsatellite.dll              | 2015.131.5149.0 | 837296    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5149.0 | 660144    | 19-May-18 | 20:01 | x64      |
| Fdhost.exe               | 2015.131.5149.0 | 105136    | 19-May-18 | 20:01 | x64      |
| Fdlauncher.exe           | 2015.131.5149.0 | 51376     | 19-May-18 | 20:01 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlft130ph.dll           | 2015.131.5149.0 | 58032     | 19-May-18 | 20:01 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5149.0     | 23728     | 19-May-18 | 20:00 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                    | 2015.131.5149.0 | 202928    | 19-May-18 | 20:00 | x86      |
| Commanddest.dll                                    | 2015.131.5149.0 | 249008    | 19-May-18 | 20:01 | x64      |
| Dteparse.dll                                       | 2015.131.5149.0 | 99504     | 19-May-18 | 20:00 | x86      |
| Dteparse.dll                                       | 2015.131.5149.0 | 109744    | 19-May-18 | 20:01 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5149.0 | 88752     | 19-May-18 | 20:00 | x64      |
| Dteparsemgd.dll                                    | 2015.131.5149.0 | 83632     | 19-May-18 | 20:01 | x86      |
| Dtepkg.dll                                         | 2015.131.5149.0 | 115888    | 19-May-18 | 20:00 | x86      |
| Dtepkg.dll                                         | 2015.131.5149.0 | 137392    | 19-May-18 | 20:01 | x64      |
| Dtexec.exe                                         | 2015.131.5149.0 | 66736     | 19-May-18 | 20:00 | x86      |
| Dtexec.exe                                         | 2015.131.5149.0 | 72880     | 19-May-18 | 20:01 | x64      |
| Dts.dll                                            | 2015.131.5149.0 | 2632880   | 19-May-18 | 20:00 | x86      |
| Dts.dll                                            | 2015.131.5149.0 | 3146928   | 19-May-18 | 20:01 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5149.0 | 418992    | 19-May-18 | 20:00 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5149.0 | 477360    | 19-May-18 | 20:01 | x64      |
| Dtsconn.dll                                        | 2015.131.5149.0 | 392368    | 19-May-18 | 20:00 | x86      |
| Dtsconn.dll                                        | 2015.131.5149.0 | 492720    | 19-May-18 | 20:01 | x64      |
| Dtsdebughost.exe                                   | 2015.131.5149.0 | 93872     | 19-May-18 | 20:00 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5149.0 | 109744    | 19-May-18 | 20:01 | x64      |
| Dtshost.exe                                        | 2015.131.5149.0 | 76464     | 19-May-18 | 20:00 | x86      |
| Dtshost.exe                                        | 2015.131.5149.0 | 86704     | 19-May-18 | 20:01 | x64      |
| Dtslog.dll                                         | 2015.131.5149.0 | 103088    | 19-May-18 | 20:00 | x86      |
| Dtslog.dll                                         | 2015.131.5149.0 | 120496    | 19-May-18 | 20:01 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5149.0 | 541360    | 19-May-18 | 20:00 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5149.0 | 545456    | 19-May-18 | 20:01 | x64      |
| Dtspipeline.dll                                    | 2015.131.5149.0 | 1059504   | 19-May-18 | 20:00 | x86      |
| Dtspipeline.dll                                    | 2015.131.5149.0 | 1279152   | 19-May-18 | 20:01 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5149.0 | 42160     | 19-May-18 | 20:00 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5149.0 | 48304     | 19-May-18 | 20:01 | x64      |
| Dtuparse.dll                                       | 2015.131.5149.0 | 80048     | 19-May-18 | 20:00 | x86      |
| Dtuparse.dll                                       | 2015.131.5149.0 | 87720     | 19-May-18 | 20:01 | x64      |
| Dtutil.exe                                         | 2015.131.5149.0 | 115376    | 19-May-18 | 20:00 | x86      |
| Dtutil.exe                                         | 2015.131.5149.0 | 134832    | 19-May-18 | 20:01 | x64      |
| Exceldest.dll                                      | 2015.131.5149.0 | 216752    | 19-May-18 | 20:00 | x86      |
| Exceldest.dll                                      | 2015.131.5149.0 | 263344    | 19-May-18 | 20:01 | x64      |
| Excelsrc.dll                                       | 2015.131.5149.0 | 232624    | 19-May-18 | 20:00 | x86      |
| Excelsrc.dll                                       | 2015.131.5149.0 | 285360    | 19-May-18 | 20:01 | x64      |
| Execpackagetask.dll                                | 2015.131.5149.0 | 135344    | 19-May-18 | 20:00 | x86      |
| Execpackagetask.dll                                | 2015.131.5149.0 | 166576    | 19-May-18 | 20:01 | x64      |
| Flatfiledest.dll                                   | 2015.131.5149.0 | 334512    | 19-May-18 | 20:00 | x86      |
| Flatfiledest.dll                                   | 2015.131.5149.0 | 389296    | 19-May-18 | 20:01 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5149.0 | 345264    | 19-May-18 | 20:00 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5149.0 | 401584    | 19-May-18 | 20:01 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5149.0 | 80560     | 19-May-18 | 20:00 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5149.0 | 96432     | 19-May-18 | 20:01 | x64      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787      | 239328    | 10-May-18 | 12:56 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5149.0     | 73384     | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5149.0 | 112304    | 19-May-18 | 20:00 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5149.0 | 107176    | 19-May-18 | 20:01 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5149.0     | 82608     | 19-May-18 | 11:22 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5149.0     | 82608     | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5149.0 | 138928    | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5149.0 | 150192    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5149.0 | 144552    | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5149.0 | 158896    | 19-May-18 | 20:01 | x64      |
| Msdtssrvr.exe                                      | 13.0.5149.0     | 216752    | 19-May-18 | 20:00 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5149.0 | 90288     | 19-May-18 | 20:00 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5149.0 | 101552    | 19-May-18 | 20:01 | x64      |
| Oledbdest.dll                                      | 2015.131.5149.0 | 216752    | 19-May-18 | 20:00 | x86      |
| Oledbdest.dll                                      | 2015.131.5149.0 | 264368    | 19-May-18 | 20:01 | x64      |
| Oledbsrc.dll                                       | 2015.131.5149.0 | 235696    | 19-May-18 | 20:00 | x86      |
| Oledbsrc.dll                                       | 2015.131.5149.0 | 290992    | 19-May-18 | 20:01 | x64      |
| Rawdest.dll                                        | 2015.131.5149.0 | 168624    | 19-May-18 | 20:00 | x86      |
| Rawdest.dll                                        | 2015.131.5149.0 | 209584    | 19-May-18 | 20:01 | x64      |
| Rawsource.dll                                      | 2015.131.5149.0 | 155304    | 19-May-18 | 20:00 | x86      |
| Rawsource.dll                                      | 2015.131.5149.0 | 196784    | 19-May-18 | 20:01 | x64      |
| Recordsetdest.dll                                  | 2015.131.5149.0 | 151728    | 19-May-18 | 20:00 | x86      |
| Recordsetdest.dll                                  | 2015.131.5149.0 | 187056    | 19-May-18 | 20:01 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqlceip.exe                                        | 13.0.5149.0     | 253616    | 19-May-18 | 20:00 | x86      |
| Sqldest.dll                                        | 2015.131.5149.0 | 215728    | 19-May-18 | 20:00 | x86      |
| Sqldest.dll                                        | 2015.131.5149.0 | 263856    | 19-May-18 | 20:01 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5149.0 | 151216    | 19-May-18 | 20:00 | x86      |
| Sqltaskconnections.dll                             | 2015.131.5149.0 | 180912    | 19-May-18 | 20:02 | x64      |
| Ssisoledb.dll                                      | 2015.131.5149.0 | 176816    | 19-May-18 | 20:00 | x86      |
| Ssisoledb.dll                                      | 2015.131.5149.0 | 216240    | 19-May-18 | 20:02 | x64      |
| Txagg.dll                                          | 2015.131.5149.0 | 304816    | 19-May-18 | 20:00 | x86      |
| Txagg.dll                                          | 2015.131.5149.0 | 364720    | 19-May-18 | 20:02 | x64      |
| Txbdd.dll                                          | 2015.131.5149.0 | 137904    | 19-May-18 | 20:00 | x86      |
| Txbdd.dll                                          | 2015.131.5149.0 | 172720    | 19-May-18 | 20:02 | x64      |
| Txbestmatch.dll                                    | 2015.131.5149.0 | 496304    | 19-May-18 | 20:00 | x86      |
| Txbestmatch.dll                                    | 2015.131.5149.0 | 611504    | 19-May-18 | 20:02 | x64      |
| Txcache.dll                                        | 2015.131.5149.0 | 148144    | 19-May-18 | 20:00 | x86      |
| Txcache.dll                                        | 2015.131.5149.0 | 183472    | 19-May-18 | 20:02 | x64      |
| Txcharmap.dll                                      | 2015.131.5149.0 | 250544    | 19-May-18 | 20:00 | x86      |
| Txcharmap.dll                                      | 2015.131.5149.0 | 289968    | 19-May-18 | 20:02 | x64      |
| Txcopymap.dll                                      | 2015.131.5149.0 | 147632    | 19-May-18 | 20:00 | x86      |
| Txcopymap.dll                                      | 2015.131.5149.0 | 182960    | 19-May-18 | 20:02 | x64      |
| Txdataconvert.dll                                  | 2015.131.5149.0 | 255152    | 19-May-18 | 20:00 | x86      |
| Txdataconvert.dll                                  | 2015.131.5149.0 | 296624    | 19-May-18 | 20:02 | x64      |
| Txderived.dll                                      | 2015.131.5149.0 | 519344    | 19-May-18 | 20:00 | x86      |
| Txderived.dll                                      | 2015.131.5149.0 | 607920    | 19-May-18 | 20:02 | x64      |
| Txfileextractor.dll                                | 2015.131.5149.0 | 162992    | 19-May-18 | 20:00 | x86      |
| Txfileextractor.dll                                | 2015.131.5149.0 | 201904    | 19-May-18 | 20:02 | x64      |
| Txfileinserter.dll                                 | 2015.131.5149.0 | 160944    | 19-May-18 | 20:00 | x86      |
| Txfileinserter.dll                                 | 2015.131.5149.0 | 199848    | 19-May-18 | 20:02 | x64      |
| Txgroupdups.dll                                    | 2015.131.5149.0 | 231600    | 19-May-18 | 20:00 | x86      |
| Txgroupdups.dll                                    | 2015.131.5149.0 | 290984    | 19-May-18 | 20:02 | x64      |
| Txlineage.dll                                      | 2015.131.5149.0 | 109744    | 19-May-18 | 20:00 | x86      |
| Txlineage.dll                                      | 2015.131.5149.0 | 137904    | 19-May-18 | 20:02 | x64      |
| Txlookup.dll                                       | 2015.131.5149.0 | 449712    | 19-May-18 | 20:00 | x86      |
| Txlookup.dll                                       | 2015.131.5149.0 | 532144    | 19-May-18 | 20:02 | x64      |
| Txmerge.dll                                        | 2015.131.5149.0 | 176816    | 19-May-18 | 20:00 | x86      |
| Txmerge.dll                                        | 2015.131.5149.0 | 230576    | 19-May-18 | 20:02 | x64      |
| Txmergejoin.dll                                    | 2015.131.5149.0 | 223920    | 19-May-18 | 20:00 | x86      |
| Txmergejoin.dll                                    | 2015.131.5149.0 | 278704    | 19-May-18 | 20:02 | x64      |
| Txmulticast.dll                                    | 2015.131.5149.0 | 102064    | 19-May-18 | 20:00 | x86      |
| Txmulticast.dll                                    | 2015.131.5149.0 | 128176    | 19-May-18 | 20:02 | x64      |
| Txpivot.dll                                        | 2015.131.5149.0 | 181936    | 19-May-18 | 20:00 | x86      |
| Txpivot.dll                                        | 2015.131.5149.0 | 228016    | 19-May-18 | 20:02 | x64      |
| Txrowcount.dll                                     | 2015.131.5149.0 | 101552    | 19-May-18 | 20:00 | x86      |
| Txrowcount.dll                                     | 2015.131.5149.0 | 126640    | 19-May-18 | 20:02 | x64      |
| Txsampling.dll                                     | 2015.131.5149.0 | 134832    | 19-May-18 | 20:00 | x86      |
| Txsampling.dll                                     | 2015.131.5149.0 | 172208    | 19-May-18 | 20:02 | x64      |
| Txscd.dll                                          | 2015.131.5149.0 | 169648    | 19-May-18 | 20:00 | x86      |
| Txscd.dll                                          | 2015.131.5149.0 | 220336    | 19-May-18 | 20:02 | x64      |
| Txsort.dll                                         | 2015.131.5149.0 | 211120    | 19-May-18 | 20:00 | x86      |
| Txsort.dll                                         | 2015.131.5149.0 | 259248    | 19-May-18 | 20:02 | x64      |
| Txsplit.dll                                        | 2015.131.5149.0 | 513200    | 19-May-18 | 20:00 | x86      |
| Txsplit.dll                                        | 2015.131.5149.0 | 600752    | 19-May-18 | 20:02 | x64      |
| Txtermextraction.dll                               | 2015.131.5149.0 | 8615600   | 19-May-18 | 20:00 | x86      |
| Txtermextraction.dll                               | 2015.131.5149.0 | 8678056   | 19-May-18 | 20:02 | x64      |
| Txtermlookup.dll                                   | 2015.131.5149.0 | 4106928   | 19-May-18 | 20:00 | x86      |
| Txtermlookup.dll                                   | 2015.131.5149.0 | 4158632   | 19-May-18 | 20:02 | x64      |
| Txunionall.dll                                     | 2015.131.5149.0 | 138928    | 19-May-18 | 20:00 | x86      |
| Txunionall.dll                                     | 2015.131.5149.0 | 181936    | 19-May-18 | 20:02 | x64      |
| Txunpivot.dll                                      | 2015.131.5149.0 | 162480    | 19-May-18 | 20:00 | x86      |
| Txunpivot.dll                                      | 2015.131.5149.0 | 201904    | 19-May-18 | 20:02 | x64      |
| Xe.dll                                             | 2015.131.5149.0 | 558768    | 19-May-18 | 20:00 | x86      |
| Xe.dll                                             | 2015.131.5149.0 | 626352    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 sql_polybase_core_inst

|     File name    |   File version  | File size |    Date   |  Time | Platform |
|:----------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll   | 2015.131.5149.0 | 61104     | 19-May-18 | 20:02 | x64      |
| Mpdwinterop.dll  | 2015.131.5149.0 | 394416    | 19-May-18 | 20:02 | x64      |
| Mpdwsvc.exe      | 2015.131.5149.0 | 6616240   | 19-May-18 | 20:45 | x64      |
| Pdwodbcsql11.dll | 2015.131.5149.0 | 2229936   | 19-May-18 | 20:02 | x64      |
| Sqldk.dll        | 2015.131.5149.0 | 2530480   | 19-May-18 | 20:02 | x64      |
| Sqldumper.exe    | 2015.131.5149.0 | 127144    | 19-May-18 | 20:45 | x64      |
| Sqlos.dll        | 2015.131.5149.0 | 26288     | 19-May-18 | 20:02 | x64      |
| Sqltses.dll      | 2015.131.5149.0 | 9064624   | 19-May-18 | 20:02 | x64      |

SQL Server 2016 Reporting Services

|                        File name                        |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                 | 13.0.5149.0     | 610992    | 19-May-18 | 20:00 | x86      |
| Microsoft.reportingservices.diagnostics.dll             | 13.0.5149.0     | 1620144   | 19-May-18 | 20:00 | x86      |
| Microsoft.reportingservices.htmlrendering.dll           | 13.0.5149.0     | 1072304   | 19-May-18 | 20:00 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532136    | 19-May-18 | 20:24 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532136    | 19-May-18 | 20:22 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:01 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:01 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:02 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532136    | 19-May-18 | 20:24 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532136    | 19-May-18 | 20:24 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5149.0     | 532144    | 19-May-18 | 20:01 | x86      |
| Microsoft.reportingservices.portal.web.dll              | 13.0.5149.0     | 10886312  | 19-May-18 | 20:00 | x86      |
| Microsoft.reportingservices.portal.webhost.exe          | 13.0.5149.0     | 101040    | 19-May-18 | 20:00 | x64      |
| Microsoft.reportingservices.usagetracking.dll           | 2015.131.5149.0 | 47792     | 19-May-18 | 20:00 | x64      |
| Msmdlocal.dll                                           | 2015.131.5149.0 | 37099184  | 19-May-18 | 20:00 | x86      |
| Msmdlocal.dll                                           | 2015.131.5149.0 | 56206512  | 19-May-18 | 20:01 | x64      |
| Msmgdsrv.dll                                            | 2015.131.5149.0 | 7507120   | 19-May-18 | 20:00 | x64      |
| Msmgdsrv.dll                                            | 2015.131.5149.0 | 6507688   | 19-May-18 | 20:23 | x86      |
| Msolui130.dll                                           | 2015.131.5149.0 | 287408    | 19-May-18 | 20:00 | x86      |
| Msolui130.dll                                           | 2015.131.5149.0 | 310448    | 19-May-18 | 20:01 | x64      |
| Reportingservicescompression.dll                        | 2015.131.5149.0 | 62640     | 19-May-18 | 20:01 | x64      |
| Reportingservicesnativeclient.dll                       | 2015.131.5149.0 | 108720    | 19-May-18 | 20:00 | x64      |
| Reportingservicesnativeclient.dll                       | 2015.131.5149.0 | 114344    | 19-May-18 | 20:23 | x86      |
| Reportingservicesnativeserver.dll                       | 2015.131.5149.0 | 98984     | 19-May-18 | 20:00 | x64      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 868016    | 19-May-18 | 20:00 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872112    | 19-May-18 | 20:01 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872112    | 19-May-18 | 20:02 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872112    | 19-May-18 | 20:02 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 876208    | 19-May-18 | 20:02 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872112    | 19-May-18 | 20:01 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872112    | 19-May-18 | 20:00 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 884392    | 19-May-18 | 20:01 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 868016    | 19-May-18 | 20:02 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5149.0     | 872104    | 19-May-18 | 20:01 | x86      |
| Rshttpruntime.dll                                       | 2015.131.5149.0 | 99504     | 19-May-18 | 20:00 | x64      |
| Sql_rs_keyfile.dll                                      | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqldumper.exe                                           | 2015.131.5149.0 | 107696    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe                                           | 2015.131.5149.0 | 127152    | 19-May-18 | 20:01 | x64      |
| Sqlrsos.dll                                             | 2015.131.5149.0 | 26288     | 19-May-18 | 20:02 | x64      |
| Sqlserverspatial130.dll                                 | 2015.131.5149.0 | 584368    | 19-May-18 | 20:00 | x86      |
| Sqlserverspatial130.dll                                 | 2015.131.5149.0 | 732848    | 19-May-18 | 20:01 | x64      |
| Xmlrw.dll                                               | 2015.131.5149.0 | 259760    | 19-May-18 | 20:00 | x86      |
| Xmlrw.dll                                               | 2015.131.5149.0 | 319144    | 19-May-18 | 20:01 | x64      |
| Xmlrwbin.dll                                            | 2015.131.5149.0 | 191664    | 19-May-18 | 20:00 | x86      |
| Xmlrwbin.dll                                            | 2015.131.5149.0 | 227504    | 19-May-18 | 20:01 | x64      |
| Xmsrv.dll                                               | 2015.131.5149.0 | 32727216  | 19-May-18 | 20:00 | x86      |
| Xmsrv.dll                                               | 2015.131.5149.0 | 24050856  | 19-May-18 | 20:02 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5149.0     | 23728     | 19-May-18 | 20:00 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5149.0 | 1311920   | 19-May-18 | 20:00 | x86      |
| Ddsshapes.dll                                  | 2015.131.5149.0 | 135856    | 19-May-18 | 20:00 | x86      |
| Dtaengine.exe                                  | 2015.131.5149.0 | 167088    | 19-May-18 | 20:00 | x86      |
| Dteparse.dll                                   | 2015.131.5149.0 | 99504     | 19-May-18 | 20:00 | x86      |
| Dteparse.dll                                   | 2015.131.5149.0 | 109744    | 19-May-18 | 20:01 | x64      |
| Dteparsemgd.dll                                | 2015.131.5149.0 | 88752     | 19-May-18 | 20:00 | x64      |
| Dteparsemgd.dll                                | 2015.131.5149.0 | 83632     | 19-May-18 | 20:01 | x86      |
| Dtepkg.dll                                     | 2015.131.5149.0 | 115888    | 19-May-18 | 20:00 | x86      |
| Dtepkg.dll                                     | 2015.131.5149.0 | 137392    | 19-May-18 | 20:01 | x64      |
| Dtexec.exe                                     | 2015.131.5149.0 | 66736     | 19-May-18 | 20:00 | x86      |
| Dtexec.exe                                     | 2015.131.5149.0 | 72880     | 19-May-18 | 20:01 | x64      |
| Dts.dll                                        | 2015.131.5149.0 | 2632880   | 19-May-18 | 20:00 | x86      |
| Dts.dll                                        | 2015.131.5149.0 | 3146928   | 19-May-18 | 20:01 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5149.0 | 418992    | 19-May-18 | 20:00 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5149.0 | 477360    | 19-May-18 | 20:01 | x64      |
| Dtsconn.dll                                    | 2015.131.5149.0 | 392368    | 19-May-18 | 20:00 | x86      |
| Dtsconn.dll                                    | 2015.131.5149.0 | 492720    | 19-May-18 | 20:01 | x64      |
| Dtshost.exe                                    | 2015.131.5149.0 | 76464     | 19-May-18 | 20:00 | x86      |
| Dtshost.exe                                    | 2015.131.5149.0 | 86704     | 19-May-18 | 20:01 | x64      |
| Dtslog.dll                                     | 2015.131.5149.0 | 103088    | 19-May-18 | 20:00 | x86      |
| Dtslog.dll                                     | 2015.131.5149.0 | 120496    | 19-May-18 | 20:01 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5149.0 | 541360    | 19-May-18 | 20:00 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5149.0 | 545456    | 19-May-18 | 20:01 | x64      |
| Dtspipeline.dll                                | 2015.131.5149.0 | 1059504   | 19-May-18 | 20:00 | x86      |
| Dtspipeline.dll                                | 2015.131.5149.0 | 1279152   | 19-May-18 | 20:01 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5149.0 | 42160     | 19-May-18 | 20:00 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5149.0 | 48304     | 19-May-18 | 20:01 | x64      |
| Dtuparse.dll                                   | 2015.131.5149.0 | 80048     | 19-May-18 | 20:00 | x86      |
| Dtuparse.dll                                   | 2015.131.5149.0 | 87720     | 19-May-18 | 20:01 | x64      |
| Dtutil.exe                                     | 2015.131.5149.0 | 115376    | 19-May-18 | 20:00 | x86      |
| Dtutil.exe                                     | 2015.131.5149.0 | 134832    | 19-May-18 | 20:01 | x64      |
| Exceldest.dll                                  | 2015.131.5149.0 | 216752    | 19-May-18 | 20:00 | x86      |
| Exceldest.dll                                  | 2015.131.5149.0 | 263344    | 19-May-18 | 20:01 | x64      |
| Excelsrc.dll                                   | 2015.131.5149.0 | 232624    | 19-May-18 | 20:00 | x86      |
| Excelsrc.dll                                   | 2015.131.5149.0 | 285360    | 19-May-18 | 20:01 | x64      |
| Flatfiledest.dll                               | 2015.131.5149.0 | 334512    | 19-May-18 | 20:00 | x86      |
| Flatfiledest.dll                               | 2015.131.5149.0 | 389296    | 19-May-18 | 20:01 | x64      |
| Flatfilesrc.dll                                | 2015.131.5149.0 | 345264    | 19-May-18 | 20:00 | x86      |
| Flatfilesrc.dll                                | 2015.131.5149.0 | 401584    | 19-May-18 | 20:01 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5149.0 | 80560     | 19-May-18 | 20:00 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5149.0 | 96432     | 19-May-18 | 20:01 | x64      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5149.0     | 92336     | 19-May-18 | 20:01 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5149.0 | 2023088   | 19-May-18 | 20:01 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5149.0 | 42160     | 19-May-18 | 20:01 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5149.0     | 73392     | 19-May-18 | 20:01 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5149.0     | 433840    | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5149.0     | 433840    | 19-May-18 | 20:01 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5149.0     | 2044592   | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5149.0     | 2044592   | 19-May-18 | 20:01 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5149.0 | 138928    | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5149.0 | 150192    | 19-May-18 | 20:01 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5149.0 | 144552    | 19-May-18 | 20:00 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5149.0 | 158896    | 19-May-18 | 20:01 | x64      |
| Msdtssrvrutil.dll                              | 2015.131.5149.0 | 90288     | 19-May-18 | 20:00 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5149.0 | 101552    | 19-May-18 | 20:01 | x64      |
| Msmdlocal.dll                                  | 2015.131.5149.0 | 37099184  | 19-May-18 | 20:00 | x86      |
| Msmdlocal.dll                                  | 2015.131.5149.0 | 56206512  | 19-May-18 | 20:01 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5149.0 | 7507120   | 19-May-18 | 20:00 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5149.0 | 6507688   | 19-May-18 | 20:23 | x86      |
| Msolui130.dll                                  | 2015.131.5149.0 | 287408    | 19-May-18 | 20:00 | x86      |
| Msolui130.dll                                  | 2015.131.5149.0 | 310448    | 19-May-18 | 20:01 | x64      |
| Oledbdest.dll                                  | 2015.131.5149.0 | 216752    | 19-May-18 | 20:00 | x86      |
| Oledbdest.dll                                  | 2015.131.5149.0 | 264368    | 19-May-18 | 20:01 | x64      |
| Oledbsrc.dll                                   | 2015.131.5149.0 | 235696    | 19-May-18 | 20:00 | x86      |
| Oledbsrc.dll                                   | 2015.131.5149.0 | 290992    | 19-May-18 | 20:01 | x64      |
| Profiler.exe                                   | 2015.131.5149.0 | 804528    | 19-May-18 | 20:01 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5149.0 | 100528    | 19-May-18 | 20:01 | x64      |
| Sqldumper.exe                                  | 2015.131.5149.0 | 107696    | 19-May-18 | 20:00 | x86      |
| Sqldumper.exe                                  | 2015.131.5149.0 | 127152    | 19-May-18 | 20:01 | x64      |
| Sqlresld.dll                                   | 2015.131.5149.0 | 28848     | 19-May-18 | 20:00 | x86      |
| Sqlresld.dll                                   | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5149.0 | 28328     | 19-May-18 | 20:00 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5149.0 | 30896     | 19-May-18 | 20:02 | x64      |
| Sqlscm.dll                                     | 2015.131.5149.0 | 52912     | 19-May-18 | 20:00 | x86      |
| Sqlscm.dll                                     | 2015.131.5149.0 | 61104     | 19-May-18 | 20:01 | x64      |
| Sqlsvc.dll                                     | 2015.131.5149.0 | 127152    | 19-May-18 | 20:00 | x86      |
| Sqlsvc.dll                                     | 2015.131.5149.0 | 152240    | 19-May-18 | 20:02 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5149.0 | 151216    | 19-May-18 | 20:00 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5149.0 | 180912    | 19-May-18 | 20:02 | x64      |
| Txdataconvert.dll                              | 2015.131.5149.0 | 255152    | 19-May-18 | 20:00 | x86      |
| Txdataconvert.dll                              | 2015.131.5149.0 | 296624    | 19-May-18 | 20:02 | x64      |
| Xe.dll                                         | 2015.131.5149.0 | 558768    | 19-May-18 | 20:00 | x86      |
| Xe.dll                                         | 2015.131.5149.0 | 626352    | 19-May-18 | 20:01 | x64      |
| Xmlrw.dll                                      | 2015.131.5149.0 | 259760    | 19-May-18 | 20:00 | x86      |
| Xmlrw.dll                                      | 2015.131.5149.0 | 319144    | 19-May-18 | 20:01 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5149.0 | 191664    | 19-May-18 | 20:00 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5149.0 | 227504    | 19-May-18 | 20:01 | x64      |
| Xmsrv.dll                                      | 2015.131.5149.0 | 32727216  | 19-May-18 | 20:00 | x86      |
| Xmsrv.dll                                      | 2015.131.5149.0 | 24050856  | 19-May-18 | 20:02 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
