---
title: Cumulative update 2 for SQL Server 2016 SP2 (KB4340355)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 2 (SP2) cumulative update 2 (KB4340355).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4340355
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Express
- SQL Server 2016 Web
---

# KB4340355 - Cumulative Update 2 for SQL Server 2016 SP2

_Release Date:_ &nbsp; July 16, 2018  
_Version:_ &nbsp; 13.0.5153.0

This article describes Cumulative Update package 2 (CU2) (build number: **13.0.5153.0**) for Microsoft SQL Server 2016 Service Pack 2 (SP2). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the initial release of SQL Server 2016 SP2.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id="11983354">[11983354](#11983354)</a> | [FIX: SSAS crashes when Process Full mode is executed after Process Clear in SQL Server 2016 (KB4339447)](https://support.microsoft.com/help/4339447) | Analysis Services |
| <a id="12054640">[12054640](#12054640)</a> | [FIX: "Could not load file or assembly 'Microsoft.AnalysisServices.AdomdClientUI'" error when a "Process Full" operation is run in SQL Server (KB4134601)](https://support.microsoft.com/help/4134601) | Analysis Services |
| <a id="12089083">[12089083](#12089083)</a> | FIX: SSAS service crashes when you use the "Connect live" option in Power BI desktop (KB4337554) | Analysis Services |
| <a id="12150036">[12150036](#12150036)</a> | FIX: The Excel Add-in still appears on the MDS home page when the option is set to "`No`" in MDS Configuration Manager (KB4340426) | Data Quality Services (DQS) |
| <a id="11952695">[11952695](#11952695)</a> | [Transparent Data Encryption added for Log Shipping in SQL Server (KB4099919)](https://support.microsoft.com/help/4099919) | High Availability |
| <a id="11952697">[11952697](#11952697)</a> | [Improvement: Configure SESSION_TIMEOUT value for a Distributed Availability Group replica in SQL Server 2016 and 2017 (KB4090004)](https://support.microsoft.com/help/4090004) | High Availability |
| <a id="12059046">[12059046](#12059046)</a> | [FIX: Error 19432 when you use Always On Availability Groups in SQL Server (KB4338746)](https://support.microsoft.com/help/4338746) | High Availability |
| <a id="12108237">[12108237](#12108237)</a> | [FIX: Parallel redo doesn't work after you disable Trace Flag 3459 in an instance of SQL Server (KB4339858)](https://support.microsoft.com/help/4339858) | High Availability |
| <a id="12107108">[12107108](#12107108)</a> | FIX: Query on a secondary replica takes two times as long to run as on a primary replica in SQL Server (KB4340342) | High Availability |
| <a id="12097754">[12097754](#12097754)</a> | FIX: Redo delay occurs on the secondary replica when you commit transaction on XTP table of the primary replica in SQL Server 2016 (KB4456140) | In-Memory OLTP |
| <a id="12119927">[12119927](#12119927)</a> | [FIX: Deadlock errors when you run an SSIS package in parallel in SQL Server (KB4338773)](https://support.microsoft.com/help/4338773) | Integration Services |
| <a id="12105760">[12105760](#12105760)</a> | [FIX: Toggle item, font color and background color expressions don't work correctly when they're used together in SSRS (KB4338240)](https://support.microsoft.com/help/4338240) | Reporting Services |
| <a id="11630532">[11630532](#11630532)</a> | [FIX: Slow performance of SQL Server 2016 when Query Store is enabled (KB4340759)](https://support.microsoft.com/help/4340759) | SQL Engine |
| <a id="11964683">[11964683](#11964683)</a> | [FIX: "PAGE_FAULT_IN_NONPAGED_AREA" Stop error when enumerating contents in a SQL Server FileTable directory (KB4338960)](https://support.microsoft.com/help/4338960) | SQL Engine |
| <a id="12107389">[12107389](#12107389)</a> | [FIX: An instance of SQL Server may appear unresponsive then a "Non-yielding Scheduler" error may occur in SQL Server 2016 (KB4338890)](https://support.microsoft.com/help/4338890) | SQL Engine |
| <a id="12111716">[12111716](#12111716)</a> | [FIX: Error 3906 when a hotfix is applied on a SQL Server that has a database snapshot on a pull subscription database (KB4340837)](https://support.microsoft.com/help/4340837) | SQL Engine |
| <a id="12162394">[12162394](#12162394)</a> | [FIX: VSS backup fails in secondary replica of Basic Availability Groups in SQL Server 2016 (KB4341221)](https://support.microsoft.com/help/4341221) | SQL Engine |
| <a id="12164652">[12164652](#12164652)</a> | [FIX: Event notifications for AUDIT_LOGIN and AUDIT_LOGIN_FAILED events will cause an unusual growth of TempDB in SQL Server 2016 (KB4341398)](https://support.microsoft.com/help/4341398) | SQL Engine |
| <a id="12186134">[12186134](#12186134)</a> | [FIX: TDE enabled database backup with compression causes database corruption in SQL Server (KB4101502)](https://support.microsoft.com/help/4101502) | SQL Engine |
| <a id="12116513">[12116513](#12116513)</a> | FIX: Error 7320 occurs when you insert dates above 2038-01-20 or below 1970-01-01 into Hive ORC file format table in SQL Server 2016 (KB4341233) | SQL Engine |
| <a id="12118383">[12118383](#12118383)</a> | FIX: DMVs `sys.dm_db_log_stats` and `sys.dm_db_log_info` may return incorrect values for the last database of the SQL Server 2016 instance (KB4341253) | SQL Engine |
| <a id="11922715">[11922715](#11922715)</a> | [FIX: "Corrupted index" message and server disconnection when an update statistics query uses hash aggregate on SQL Server (KB4316858)](https://support.microsoft.com/help/4316858) | SQL performance |
| <a id="11965498">[11965498](#11965498)</a> | [FIX: Many xml_deadlock_report events are reported for one single intra-query deadlock occurrence in SQL Server 2016 (KB4338715)](https://support.microsoft.com/help/4338715) | SQL performance |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP2 now](https://www.microsoft.com/download/details.aspx?id=56975)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, we recommend that you always install the latest cumulative update that is available.

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

If other issues occur, or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

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

x64-based versions

SQL Server 2016 Browser Service

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll | 2015.131.5153.0 | 53432     | 29-Jun-18 | 02:36 | x86      |
| Keyfile.dll    | 2015.131.5153.0 | 88760     | 29-Jun-18 | 02:34 | x86      |
| Sqlbrowser.exe | 2015.131.5153.0 | 276656    | 29-Jun-18 | 02:36 | x86      |
| Sqldumper.exe  | 2015.131.5153.0 | 107696    | 29-Jun-18 | 02:36 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi130.dll        | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sqlboot.dll           | 2015.131.5153.0 | 186544    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe         | 2015.131.5153.0 | 127152    | 29-Jun-18 | 02:35 | x64      |
| Sqlvdi.dll            | 2015.131.5153.0 | 168624    | 29-Jun-18 | 02:34 | x86      |
| Sqlvdi.dll            | 2015.131.5153.0 | 197296    | 29-Jun-18 | 02:37 | x64      |
| Sqlwriter.exe         | 2015.131.5153.0 | 131760    | 29-Jun-18 | 02:38 | x64      |
| Sqlwriter_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlwvss.dll           | 2015.131.5153.0 | 342728    | 29-Jun-18 | 02:34 | x64      |
| Sqlwvss_xp.dll        | 2015.131.5153.0 | 26288     | 29-Jun-18 | 02:34 | x64      |

SQL Server 2016 Analysis Services

|             File name             |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.applicationinsights.dll | 2.6.0.6787      | 239328    | 28-Jun-18 | 10:16 | x86      |
| Msmdctr130.dll                    | 2015.131.5153.0 | 40112     | 29-Jun-18 | 02:35 | x64      |
| Msmdlocal.dll                     | 2015.131.5153.0 | 37099192  | 29-Jun-18 | 02:34 | x86      |
| Msmdlocal.dll                     | 2015.131.5153.0 | 56206512  | 29-Jun-18 | 02:35 | x64      |
| Msmdsrv.exe                       | 2015.131.5153.0 | 56744112  | 29-Jun-18 | 02:38 | x64      |
| Msmgdsrv.dll                      | 2015.131.5153.0 | 7507120   | 29-Jun-18 | 02:34 | x64      |
| Msmgdsrv.dll                      | 2015.131.5153.0 | 6507696   | 29-Jun-18 | 02:36 | x86      |
| Msolui130.dll                     | 2015.131.5153.0 | 287408    | 29-Jun-18 | 02:34 | x86      |
| Msolui130.dll                     | 2015.131.5153.0 | 310456    | 29-Jun-18 | 02:35 | x64      |
| Sql_as_keyfile.dll                | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlboot.dll                       | 2015.131.5153.0 | 186544    | 29-Jun-18 | 02:35 | x64      |
| Sqlceip.exe                       | 13.0.5153.0     | 256200    | 29-Jun-18 | 02:37 | x86      |
| Sqldumper.exe                     | 2015.131.5153.0 | 127152    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                     | 2015.131.5153.0 | 107696    | 29-Jun-18 | 02:36 | x86      |
| Tmapi.dll                         | 2015.131.5153.0 | 4346032   | 29-Jun-18 | 02:34 | x64      |
| Tmcachemgr.dll                    | 2015.131.5153.0 | 2826416   | 29-Jun-18 | 02:34 | x64      |
| Tmpersistence.dll                 | 2015.131.5153.0 | 1071280   | 29-Jun-18 | 02:34 | x64      |
| Tmtransactions.dll                | 2015.131.5153.0 | 1352368   | 29-Jun-18 | 02:34 | x64      |
| Xe.dll                            | 2015.131.5153.0 | 626352    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                         | 2015.131.5153.0 | 319152    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                         | 2015.131.5153.0 | 259760    | 29-Jun-18 | 02:38 | x86      |
| Xmlrwbin.dll                      | 2015.131.5153.0 | 227504    | 29-Jun-18 | 02:37 | x64      |
| Xmlrwbin.dll                      | 2015.131.5153.0 | 191664    | 29-Jun-18 | 02:38 | x86      |
| Xmsrv.dll                         | 2015.131.5153.0 | 24050864  | 29-Jun-18 | 02:34 | x64      |
| Xmsrv.dll                         | 2015.131.5153.0 | 32727728  | 29-Jun-18 | 02:38 | x86      |

SQL Server 2016 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2015.131.5153.0 | 160432    | 29-Jun-18 | 02:36 | x86      |
| Batchparser.dll                      | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:37 | x64      |
| Instapi130.dll                       | 2015.131.5153.0 | 53432     | 29-Jun-18 | 02:36 | x86      |
| Instapi130.dll                       | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Isacctchange.dll                     | 2015.131.5153.0 | 30920     | 29-Jun-18 | 02:35 | x64      |
| Isacctchange.dll                     | 2015.131.5153.0 | 29360     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.131.5153.0 | 75440     | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2015.131.5153.0 | 72880     | 29-Jun-18 | 02:36 | x86      |
| Msasxpress.dll                       | 2015.131.5153.0 | 31928     | 29-Jun-18 | 02:34 | x86      |
| Msasxpress.dll                       | 2015.131.5153.0 | 36016     | 29-Jun-18 | 02:35 | x64      |
| Pbsvcacctsync.dll                    | 2015.131.5153.0 | 60088     | 29-Jun-18 | 02:34 | x86      |
| Pbsvcacctsync.dll                    | 2015.131.5153.0 | 72880     | 29-Jun-18 | 02:35 | x64      |
| Sql_common_core_keyfile.dll          | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                        | 2015.131.5153.0 | 127152    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                        | 2015.131.5153.0 | 107696    | 29-Jun-18 | 02:36 | x86      |
| Sqlftacct.dll                        | 2015.131.5153.0 | 46776     | 29-Jun-18 | 02:34 | x86      |
| Sqlftacct.dll                        | 2015.131.5153.0 | 51912     | 29-Jun-18 | 02:35 | x64      |
| Sqlmgmprovider.dll                   | 2015.131.5153.0 | 404144    | 29-Jun-18 | 02:34 | x64      |
| Sqlmgmprovider.dll                   | 2015.131.5153.0 | 364216    | 29-Jun-18 | 02:34 | x86      |
| Sqlsecacctchg.dll                    | 2015.131.5153.0 | 37552     | 29-Jun-18 | 02:34 | x64      |
| Sqlsecacctchg.dll                    | 2015.131.5153.0 | 35000     | 29-Jun-18 | 02:34 | x86      |
| Sqltdiagn.dll                        | 2015.131.5153.0 | 67760     | 29-Jun-18 | 02:34 | x64      |
| Sqltdiagn.dll                        | 2015.131.5153.0 | 60616     | 29-Jun-18 | 02:34 | x86      |

SQL Server 2016 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2015.131.5153.0 | 121008    | 29-Jun-18 | 02:36 | x86      |
| Dreplaycommon.dll              | 2015.131.5153.0 | 690864    | 29-Jun-18 | 02:34 | x86      |
| Dreplayutil.dll                | 2015.131.5153.0 | 309936    | 29-Jun-18 | 02:36 | x86      |
| Instapi130.dll                 | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sql_dreplay_client_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlresourceloader.dll          | 2015.131.5153.0 | 28344     | 29-Jun-18 | 02:34 | x86      |

SQL Server 2016 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2015.131.5153.0 | 690864    | 29-Jun-18 | 02:34 | x86      |
| Dreplaycontroller.exe              | 2015.131.5153.0 | 350384    | 29-Jun-18 | 02:36 | x86      |
| Dreplayprocess.dll                 | 2015.131.5153.0 | 171696    | 29-Jun-18 | 02:36 | x86      |
| Instapi130.dll                     | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlresourceloader.dll              | 2015.131.5153.0 | 28344     | 29-Jun-18 | 02:34 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:37 | x64      |
| Datacollectorcontroller.dll                  | 2015.131.5153.0 | 225456    | 29-Jun-18 | 02:35 | x64      |
| Dcexec.exe                                   | 2015.131.5153.0 | 74416     | 29-Jun-18 | 02:38 | x64      |
| Fssres.dll                                   | 2015.131.5153.0 | 81584     | 29-Jun-18 | 02:35 | x64      |
| Hadrres.dll                                  | 2015.131.5153.0 | 177840    | 29-Jun-18 | 02:37 | x64      |
| Hkcompile.dll                                | 2015.131.5153.0 | 1298096   | 29-Jun-18 | 02:37 | x64      |
| Hkengine.dll                                 | 2015.131.5153.0 | 5600944   | 29-Jun-18 | 02:37 | x64      |
| Hkruntime.dll                                | 2015.131.5153.0 | 158896    | 29-Jun-18 | 02:37 | x64      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787      | 239328    | 28-Jun-18 | 10:16 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.131.5153.0 | 71344     | 29-Jun-18 | 02:34 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.131.5153.0 | 65200     | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5153.0 | 150192    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5153.0 | 158896    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.131.5153.0 | 272048    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.131.5153.0 | 74928     | 29-Jun-18 | 02:36 | x64      |
| Odsole70.dll                                 | 2015.131.5153.0 | 92848     | 29-Jun-18 | 02:35 | x64      |
| Opends60.dll                                 | 2015.131.5153.0 | 32944     | 29-Jun-18 | 02:37 | x64      |
| Qds.dll                                      | 2015.131.5153.0 | 862384    | 29-Jun-18 | 02:35 | x64      |
| Rsfxft.dll                                   | 2015.131.5153.0 | 34480     | 29-Jun-18 | 02:37 | x64      |
| Sqagtres.dll                                 | 2015.131.5153.0 | 64712     | 29-Jun-18 | 02:35 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlaamss.dll                                 | 2015.131.5153.0 | 80568     | 29-Jun-18 | 02:34 | x64      |
| Sqlaccess.dll                                | 2015.131.5153.0 | 462512    | 29-Jun-18 | 02:36 | x64      |
| Sqlagent.exe                                 | 2015.131.5153.0 | 566472    | 29-Jun-18 | 02:38 | x64      |
| Sqlagentctr130.dll                           | 2015.131.5153.0 | 44216     | 29-Jun-18 | 02:34 | x86      |
| Sqlagentctr130.dll                           | 2015.131.5153.0 | 51912     | 29-Jun-18 | 02:35 | x64      |
| Sqlagentlog.dll                              | 2015.131.5153.0 | 32944     | 29-Jun-18 | 02:35 | x64      |
| Sqlagentmail.dll                             | 2015.131.5153.0 | 47792     | 29-Jun-18 | 02:34 | x64      |
| Sqlboot.dll                                  | 2015.131.5153.0 | 186544    | 29-Jun-18 | 02:35 | x64      |
| Sqlceip.exe                                  | 13.0.5153.0     | 256200    | 29-Jun-18 | 02:37 | x86      |
| Sqlcmdss.dll                                 | 2015.131.5153.0 | 60080     | 29-Jun-18 | 02:35 | x64      |
| Sqldk.dll                                    | 2015.131.5153.0 | 2587824   | 29-Jun-18 | 02:35 | x64      |
| Sqldtsss.dll                                 | 2015.131.5153.0 | 97456     | 29-Jun-18 | 02:34 | x64      |
| Sqliosim.com                                 | 2015.131.5153.0 | 307888    | 29-Jun-18 | 02:35 | x64      |
| Sqliosim.exe                                 | 2015.131.5153.0 | 3014344   | 29-Jun-18 | 02:38 | x64      |
| Sqllang.dll                                  | 2015.131.5153.0 | 39511728  | 29-Jun-18 | 02:35 | x64      |
| Sqlmin.dll                                   | 2015.131.5153.0 | 37866672  | 29-Jun-18 | 02:34 | x64      |
| Sqlolapss.dll                                | 2015.131.5153.0 | 97968     | 29-Jun-18 | 02:34 | x64      |
| Sqlos.dll                                    | 2015.131.5153.0 | 26288     | 29-Jun-18 | 02:37 | x64      |
| Sqlpowershellss.dll                          | 2015.131.5153.0 | 58544     | 29-Jun-18 | 02:34 | x64      |
| Sqlrepss.dll                                 | 2015.131.5153.0 | 54960     | 29-Jun-18 | 02:34 | x64      |
| Sqlresld.dll                                 | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlscm.dll                                   | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.131.5153.0 | 27824     | 29-Jun-18 | 02:34 | x64      |
| Sqlscriptupgrade.dll                         | 2015.131.5153.0 | 5807792   | 29-Jun-18 | 02:37 | x64      |
| Sqlserverspatial130.dll                      | 2015.131.5153.0 | 732848    | 29-Jun-18 | 02:37 | x64      |
| Sqlservr.exe                                 | 2015.131.5153.0 | 392880    | 29-Jun-18 | 02:38 | x64      |
| Sqlsvc.dll                                   | 2015.131.5153.0 | 152240    | 29-Jun-18 | 02:34 | x64      |
| Sqltses.dll                                  | 2015.131.5153.0 | 8896688   | 29-Jun-18 | 02:34 | x64      |
| Sqsrvres.dll                                 | 2015.131.5153.0 | 251056    | 29-Jun-18 | 02:34 | x64      |
| Xe.dll                                       | 2015.131.5153.0 | 626352    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                    | 2015.131.5153.0 | 319152    | 29-Jun-18 | 02:37 | x64      |
| Xmlrwbin.dll                                 | 2015.131.5153.0 | 227504    | 29-Jun-18 | 02:37 | x64      |
| Xpadsi.exe                                   | 2015.131.5153.0 | 79024     | 29-Jun-18 | 02:37 | x64      |
| Xplog70.dll                                  | 2015.131.5153.0 | 65712     | 29-Jun-18 | 02:37 | x64      |
| Xpsqlbot.dll                                 | 2015.131.5153.0 | 33456     | 29-Jun-18 | 02:37 | x64      |
| Xpstar.dll                                   | 2015.131.5153.0 | 422576    | 29-Jun-18 | 02:37 | x64      |

SQL Server 2016 Database Services Core Shared

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2015.131.5153.0 | 160432    | 29-Jun-18 | 02:36 | x86      |
| Batchparser.dll                              | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:37 | x64      |
| Bcp.exe                                      | 2015.131.5153.0 | 119984    | 29-Jun-18 | 02:35 | x64      |
| Commanddest.dll                              | 2015.131.5153.0 | 249008    | 29-Jun-18 | 02:35 | x64      |
| Datacollectorenumerators.dll                 | 2015.131.5153.0 | 115888    | 29-Jun-18 | 02:35 | x64      |
| Datacollectortasks.dll                       | 2015.131.5153.0 | 188080    | 29-Jun-18 | 02:35 | x64      |
| Dteparse.dll                                 | 2015.131.5153.0 | 109744    | 29-Jun-18 | 02:35 | x64      |
| Dteparsemgd.dll                              | 2015.131.5153.0 | 88752     | 29-Jun-18 | 02:35 | x64      |
| Dtepkg.dll                                   | 2015.131.5153.0 | 137392    | 29-Jun-18 | 02:35 | x64      |
| Dtexec.exe                                   | 2015.131.5153.0 | 72880     | 29-Jun-18 | 02:38 | x64      |
| Dts.dll                                      | 2015.131.5153.0 | 3146928   | 29-Jun-18 | 02:35 | x64      |
| Dtscomexpreval.dll                           | 2015.131.5153.0 | 477360    | 29-Jun-18 | 02:35 | x64      |
| Dtsconn.dll                                  | 2015.131.5153.0 | 492720    | 29-Jun-18 | 02:35 | x64      |
| Dtshost.exe                                  | 2015.131.5153.0 | 86728     | 29-Jun-18 | 02:38 | x64      |
| Dtslog.dll                                   | 2015.131.5153.0 | 120496    | 29-Jun-18 | 02:35 | x64      |
| Dtsmsg130.dll                                | 2015.131.5153.0 | 545456    | 29-Jun-18 | 02:35 | x64      |
| Dtspipeline.dll                              | 2015.131.5153.0 | 1279152   | 29-Jun-18 | 02:35 | x64      |
| Dtspipelineperf130.dll                       | 2015.131.5153.0 | 48304     | 29-Jun-18 | 02:35 | x64      |
| Dtuparse.dll                                 | 2015.131.5153.0 | 87728     | 29-Jun-18 | 02:35 | x64      |
| Dtutil.exe                                   | 2015.131.5153.0 | 134832    | 29-Jun-18 | 02:38 | x64      |
| Exceldest.dll                                | 2015.131.5153.0 | 263344    | 29-Jun-18 | 02:35 | x64      |
| Excelsrc.dll                                 | 2015.131.5153.0 | 285360    | 29-Jun-18 | 02:35 | x64      |
| Execpackagetask.dll                          | 2015.131.5153.0 | 166576    | 29-Jun-18 | 02:35 | x64      |
| Flatfiledest.dll                             | 2015.131.5153.0 | 389296    | 29-Jun-18 | 02:35 | x64      |
| Flatfilesrc.dll                              | 2015.131.5153.0 | 401584    | 29-Jun-18 | 02:35 | x64      |
| Foreachfileenumerator.dll                    | 2015.131.5153.0 | 96432     | 29-Jun-18 | 02:35 | x64      |
| Hkengperfctrs.dll                            | 2015.131.5153.0 | 59056     | 29-Jun-18 | 02:37 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.131.5153.0 | 150192    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.131.5153.0 | 158896    | 29-Jun-18 | 02:36 | x64      |
| Msdtssrvrutil.dll                            | 2015.131.5153.0 | 101552    | 29-Jun-18 | 02:35 | x64      |
| Msxmlsql.dll                                 | 2015.131.5153.0 | 1494704   | 29-Jun-18 | 02:37 | x64      |
| Oledbdest.dll                                | 2015.131.5153.0 | 264368    | 29-Jun-18 | 02:35 | x64      |
| Oledbsrc.dll                                 | 2015.131.5153.0 | 290992    | 29-Jun-18 | 02:35 | x64      |
| Osql.exe                                     | 2015.131.5153.0 | 75440     | 29-Jun-18 | 02:35 | x64      |
| Rawdest.dll                                  | 2015.131.5153.0 | 209584    | 29-Jun-18 | 02:35 | x64      |
| Rawsource.dll                                | 2015.131.5153.0 | 196784    | 29-Jun-18 | 02:35 | x64      |
| Recordsetdest.dll                            | 2015.131.5153.0 | 187056    | 29-Jun-18 | 02:35 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlcmd.exe                                   | 2015.131.5153.0 | 249520    | 29-Jun-18 | 02:35 | x64      |
| Sqldiag.exe                                  | 2015.131.5153.0 | 1257648   | 29-Jun-18 | 02:38 | x64      |
| Sqllogship.exe                               | 13.0.5153.0     | 104632    | 29-Jun-18 | 02:37 | x64      |
| Sqlresld.dll                                 | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlresld.dll                                 | 2015.131.5153.0 | 28856     | 29-Jun-18 | 02:34 | x86      |
| Sqlresourceloader.dll                        | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlresourceloader.dll                        | 2015.131.5153.0 | 28344     | 29-Jun-18 | 02:34 | x86      |
| Sqlscm.dll                                   | 2015.131.5153.0 | 52920     | 29-Jun-18 | 02:34 | x86      |
| Sqlscm.dll                                   | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sqlsvc.dll                                   | 2015.131.5153.0 | 152240    | 29-Jun-18 | 02:34 | x64      |
| Sqlsvc.dll                                   | 2015.131.5153.0 | 127176    | 29-Jun-18 | 02:34 | x86      |
| Sqltaskconnections.dll                       | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:34 | x64      |
| Sqlwep130.dll                                | 2015.131.5153.0 | 105648    | 29-Jun-18 | 02:34 | x64      |
| Ssisoledb.dll                                | 2015.131.5153.0 | 216240    | 29-Jun-18 | 02:34 | x64      |
| Txagg.dll                                    | 2015.131.5153.0 | 364720    | 29-Jun-18 | 02:34 | x64      |
| Txbdd.dll                                    | 2015.131.5153.0 | 172720    | 29-Jun-18 | 02:34 | x64      |
| Txdatacollector.dll                          | 2015.131.5153.0 | 367792    | 29-Jun-18 | 02:34 | x64      |
| Txdataconvert.dll                            | 2015.131.5153.0 | 296648    | 29-Jun-18 | 02:34 | x64      |
| Txderived.dll                                | 2015.131.5153.0 | 607920    | 29-Jun-18 | 02:34 | x64      |
| Txlookup.dll                                 | 2015.131.5153.0 | 532144    | 29-Jun-18 | 02:34 | x64      |
| Txmerge.dll                                  | 2015.131.5153.0 | 230576    | 29-Jun-18 | 02:34 | x64      |
| Txmergejoin.dll                              | 2015.131.5153.0 | 278712    | 29-Jun-18 | 02:34 | x64      |
| Txmulticast.dll                              | 2015.131.5153.0 | 128176    | 29-Jun-18 | 02:34 | x64      |
| Txrowcount.dll                               | 2015.131.5153.0 | 126640    | 29-Jun-18 | 02:34 | x64      |
| Txsort.dll                                   | 2015.131.5153.0 | 259256    | 29-Jun-18 | 02:34 | x64      |
| Txsplit.dll                                  | 2015.131.5153.0 | 600752    | 29-Jun-18 | 02:34 | x64      |
| Txunionall.dll                               | 2015.131.5153.0 | 181936    | 29-Jun-18 | 02:34 | x64      |
| Xe.dll                                       | 2015.131.5153.0 | 626352    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                    | 2015.131.5153.0 | 319152    | 29-Jun-18 | 02:37 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.131.5153.0 | 1014960   | 29-Jun-18 | 02:35 | x64      |
| Sql_extensibility_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlsatellite.dll              | 2015.131.5153.0 | 837296    | 29-Jun-18 | 02:37 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.131.5153.0 | 660144    | 29-Jun-18 | 02:37 | x64      |
| Fdhost.exe               | 2015.131.5153.0 | 105136    | 29-Jun-18 | 02:35 | x64      |
| Fdlauncher.exe           | 2015.131.5153.0 | 51376     | 29-Jun-18 | 02:35 | x64      |
| Sql_fulltext_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlft130ph.dll           | 2015.131.5153.0 | 58032     | 29-Jun-18 | 02:37 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.5153.0     | 23728     | 29-Jun-18 | 02:35 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |

SQL Server 2016 Integration Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                    | 2015.131.5153.0 | 249008    | 29-Jun-18 | 02:35 | x64      |
| Commanddest.dll                                    | 2015.131.5153.0 | 202928    | 29-Jun-18 | 02:36 | x86      |
| Dteparse.dll                                       | 2015.131.5153.0 | 109744    | 29-Jun-18 | 02:35 | x64      |
| Dteparse.dll                                       | 2015.131.5153.0 | 99504     | 29-Jun-18 | 02:36 | x86      |
| Dteparsemgd.dll                                    | 2015.131.5153.0 | 83632     | 29-Jun-18 | 02:34 | x86      |
| Dteparsemgd.dll                                    | 2015.131.5153.0 | 88752     | 29-Jun-18 | 02:35 | x64      |
| Dtepkg.dll                                         | 2015.131.5153.0 | 137392    | 29-Jun-18 | 02:35 | x64      |
| Dtepkg.dll                                         | 2015.131.5153.0 | 115888    | 29-Jun-18 | 02:36 | x86      |
| Dtexec.exe                                         | 2015.131.5153.0 | 66736     | 29-Jun-18 | 02:36 | x86      |
| Dtexec.exe                                         | 2015.131.5153.0 | 72880     | 29-Jun-18 | 02:38 | x64      |
| Dts.dll                                            | 2015.131.5153.0 | 3146928   | 29-Jun-18 | 02:35 | x64      |
| Dts.dll                                            | 2015.131.5153.0 | 2632880   | 29-Jun-18 | 02:36 | x86      |
| Dtscomexpreval.dll                                 | 2015.131.5153.0 | 477360    | 29-Jun-18 | 02:35 | x64      |
| Dtscomexpreval.dll                                 | 2015.131.5153.0 | 419000    | 29-Jun-18 | 02:36 | x86      |
| Dtsconn.dll                                        | 2015.131.5153.0 | 492720    | 29-Jun-18 | 02:35 | x64      |
| Dtsconn.dll                                        | 2015.131.5153.0 | 392368    | 29-Jun-18 | 02:36 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5153.0 | 93872     | 29-Jun-18 | 02:36 | x86      |
| Dtsdebughost.exe                                   | 2015.131.5153.0 | 109744    | 29-Jun-18 | 02:38 | x64      |
| Dtshost.exe                                        | 2015.131.5153.0 | 76464     | 29-Jun-18 | 02:36 | x86      |
| Dtshost.exe                                        | 2015.131.5153.0 | 86728     | 29-Jun-18 | 02:38 | x64      |
| Dtslog.dll                                         | 2015.131.5153.0 | 120496    | 29-Jun-18 | 02:35 | x64      |
| Dtslog.dll                                         | 2015.131.5153.0 | 103088    | 29-Jun-18 | 02:36 | x86      |
| Dtsmsg130.dll                                      | 2015.131.5153.0 | 545456    | 29-Jun-18 | 02:35 | x64      |
| Dtsmsg130.dll                                      | 2015.131.5153.0 | 541360    | 29-Jun-18 | 02:36 | x86      |
| Dtspipeline.dll                                    | 2015.131.5153.0 | 1279152   | 29-Jun-18 | 02:35 | x64      |
| Dtspipeline.dll                                    | 2015.131.5153.0 | 1059504   | 29-Jun-18 | 02:36 | x86      |
| Dtspipelineperf130.dll                             | 2015.131.5153.0 | 48304     | 29-Jun-18 | 02:35 | x64      |
| Dtspipelineperf130.dll                             | 2015.131.5153.0 | 42168     | 29-Jun-18 | 02:36 | x86      |
| Dtuparse.dll                                       | 2015.131.5153.0 | 87728     | 29-Jun-18 | 02:35 | x64      |
| Dtuparse.dll                                       | 2015.131.5153.0 | 80072     | 29-Jun-18 | 02:36 | x86      |
| Dtutil.exe                                         | 2015.131.5153.0 | 115376    | 29-Jun-18 | 02:36 | x86      |
| Dtutil.exe                                         | 2015.131.5153.0 | 134832    | 29-Jun-18 | 02:38 | x64      |
| Exceldest.dll                                      | 2015.131.5153.0 | 263344    | 29-Jun-18 | 02:35 | x64      |
| Exceldest.dll                                      | 2015.131.5153.0 | 216752    | 29-Jun-18 | 02:36 | x86      |
| Excelsrc.dll                                       | 2015.131.5153.0 | 285360    | 29-Jun-18 | 02:35 | x64      |
| Excelsrc.dll                                       | 2015.131.5153.0 | 232624    | 29-Jun-18 | 02:36 | x86      |
| Execpackagetask.dll                                | 2015.131.5153.0 | 166576    | 29-Jun-18 | 02:35 | x64      |
| Execpackagetask.dll                                | 2015.131.5153.0 | 135344    | 29-Jun-18 | 02:36 | x86      |
| Flatfiledest.dll                                   | 2015.131.5153.0 | 389296    | 29-Jun-18 | 02:35 | x64      |
| Flatfiledest.dll                                   | 2015.131.5153.0 | 334512    | 29-Jun-18 | 02:36 | x86      |
| Flatfilesrc.dll                                    | 2015.131.5153.0 | 401584    | 29-Jun-18 | 02:35 | x64      |
| Flatfilesrc.dll                                    | 2015.131.5153.0 | 345264    | 29-Jun-18 | 02:36 | x86      |
| Foreachfileenumerator.dll                          | 2015.131.5153.0 | 96432     | 29-Jun-18 | 02:35 | x64      |
| Foreachfileenumerator.dll                          | 2015.131.5153.0 | 80560     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787      | 239328    | 28-Jun-18 | 10:16 | x86      |
| Microsoft.sqlserver.astasks.dll                    | 13.0.5153.0     | 73392     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5153.0 | 107184    | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll  | 2015.131.5153.0 | 112304    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5153.0     | 82616     | 28-Jun-18 | 18:50 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll | 13.0.5153.0     | 82608     | 29-Jun-18 | 02:34 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5153.0 | 150192    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll       | 2015.131.5153.0 | 138928    | 29-Jun-18 | 02:37 | x86      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5153.0 | 158896    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.dll                     | 2015.131.5153.0 | 144560    | 29-Jun-18 | 02:37 | x86      |
| Msdtssrvr.exe                                      | 13.0.5153.0     | 216776    | 29-Jun-18 | 02:37 | x64      |
| Msdtssrvrutil.dll                                  | 2015.131.5153.0 | 90296     | 29-Jun-18 | 02:34 | x86      |
| Msdtssrvrutil.dll                                  | 2015.131.5153.0 | 101552    | 29-Jun-18 | 02:35 | x64      |
| Oledbdest.dll                                      | 2015.131.5153.0 | 216760    | 29-Jun-18 | 02:34 | x86      |
| Oledbdest.dll                                      | 2015.131.5153.0 | 264368    | 29-Jun-18 | 02:35 | x64      |
| Oledbsrc.dll                                       | 2015.131.5153.0 | 235704    | 29-Jun-18 | 02:34 | x86      |
| Oledbsrc.dll                                       | 2015.131.5153.0 | 290992    | 29-Jun-18 | 02:35 | x64      |
| Rawdest.dll                                        | 2015.131.5153.0 | 168632    | 29-Jun-18 | 02:34 | x86      |
| Rawdest.dll                                        | 2015.131.5153.0 | 209584    | 29-Jun-18 | 02:35 | x64      |
| Rawsource.dll                                      | 2015.131.5153.0 | 155336    | 29-Jun-18 | 02:34 | x86      |
| Rawsource.dll                                      | 2015.131.5153.0 | 196784    | 29-Jun-18 | 02:35 | x64      |
| Recordsetdest.dll                                  | 2015.131.5153.0 | 151736    | 29-Jun-18 | 02:34 | x86      |
| Recordsetdest.dll                                  | 2015.131.5153.0 | 187056    | 29-Jun-18 | 02:35 | x64      |
| Sql_is_keyfile.dll                                 | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqlceip.exe                                        | 13.0.5153.0     | 256200    | 29-Jun-18 | 02:37 | x86      |
| Sqldest.dll                                        | 2015.131.5153.0 | 215728    | 29-Jun-18 | 02:34 | x86      |
| Sqldest.dll                                        | 2015.131.5153.0 | 263856    | 29-Jun-18 | 02:35 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:34 | x64      |
| Sqltaskconnections.dll                             | 2015.131.5153.0 | 151224    | 29-Jun-18 | 02:34 | x86      |
| Ssisoledb.dll                                      | 2015.131.5153.0 | 216240    | 29-Jun-18 | 02:34 | x64      |
| Ssisoledb.dll                                      | 2015.131.5153.0 | 176840    | 29-Jun-18 | 02:34 | x86      |
| Txagg.dll                                          | 2015.131.5153.0 | 364720    | 29-Jun-18 | 02:34 | x64      |
| Txagg.dll                                          | 2015.131.5153.0 | 304816    | 29-Jun-18 | 02:38 | x86      |
| Txbdd.dll                                          | 2015.131.5153.0 | 172720    | 29-Jun-18 | 02:34 | x64      |
| Txbdd.dll                                          | 2015.131.5153.0 | 137904    | 29-Jun-18 | 02:38 | x86      |
| Txbestmatch.dll                                    | 2015.131.5153.0 | 611504    | 29-Jun-18 | 02:34 | x64      |
| Txbestmatch.dll                                    | 2015.131.5153.0 | 496296    | 29-Jun-18 | 02:38 | x86      |
| Txcache.dll                                        | 2015.131.5153.0 | 183472    | 29-Jun-18 | 02:34 | x64      |
| Txcache.dll                                        | 2015.131.5153.0 | 148144    | 29-Jun-18 | 02:38 | x86      |
| Txcharmap.dll                                      | 2015.131.5153.0 | 289968    | 29-Jun-18 | 02:34 | x64      |
| Txcharmap.dll                                      | 2015.131.5153.0 | 250544    | 29-Jun-18 | 02:38 | x86      |
| Txcopymap.dll                                      | 2015.131.5153.0 | 182960    | 29-Jun-18 | 02:34 | x64      |
| Txcopymap.dll                                      | 2015.131.5153.0 | 147632    | 29-Jun-18 | 02:38 | x86      |
| Txdataconvert.dll                                  | 2015.131.5153.0 | 296648    | 29-Jun-18 | 02:34 | x64      |
| Txdataconvert.dll                                  | 2015.131.5153.0 | 255152    | 29-Jun-18 | 02:38 | x86      |
| Txderived.dll                                      | 2015.131.5153.0 | 607920    | 29-Jun-18 | 02:34 | x64      |
| Txderived.dll                                      | 2015.131.5153.0 | 519344    | 29-Jun-18 | 02:38 | x86      |
| Txfileextractor.dll                                | 2015.131.5153.0 | 201904    | 29-Jun-18 | 02:34 | x64      |
| Txfileextractor.dll                                | 2015.131.5153.0 | 162992    | 29-Jun-18 | 02:38 | x86      |
| Txfileinserter.dll                                 | 2015.131.5153.0 | 199856    | 29-Jun-18 | 02:34 | x64      |
| Txfileinserter.dll                                 | 2015.131.5153.0 | 160944    | 29-Jun-18 | 02:38 | x86      |
| Txgroupdups.dll                                    | 2015.131.5153.0 | 290992    | 29-Jun-18 | 02:34 | x64      |
| Txgroupdups.dll                                    | 2015.131.5153.0 | 231600    | 29-Jun-18 | 02:38 | x86      |
| Txlineage.dll                                      | 2015.131.5153.0 | 137904    | 29-Jun-18 | 02:34 | x64      |
| Txlineage.dll                                      | 2015.131.5153.0 | 109736    | 29-Jun-18 | 02:38 | x86      |
| Txlookup.dll                                       | 2015.131.5153.0 | 532144    | 29-Jun-18 | 02:34 | x64      |
| Txlookup.dll                                       | 2015.131.5153.0 | 449704    | 29-Jun-18 | 02:38 | x86      |
| Txmerge.dll                                        | 2015.131.5153.0 | 230576    | 29-Jun-18 | 02:34 | x64      |
| Txmerge.dll                                        | 2015.131.5153.0 | 176816    | 29-Jun-18 | 02:38 | x86      |
| Txmergejoin.dll                                    | 2015.131.5153.0 | 278712    | 29-Jun-18 | 02:34 | x64      |
| Txmergejoin.dll                                    | 2015.131.5153.0 | 223920    | 29-Jun-18 | 02:38 | x86      |
| Txmulticast.dll                                    | 2015.131.5153.0 | 128176    | 29-Jun-18 | 02:34 | x64      |
| Txmulticast.dll                                    | 2015.131.5153.0 | 102064    | 29-Jun-18 | 02:38 | x86      |
| Txpivot.dll                                        | 2015.131.5153.0 | 228016    | 29-Jun-18 | 02:34 | x64      |
| Txpivot.dll                                        | 2015.131.5153.0 | 181936    | 29-Jun-18 | 02:38 | x86      |
| Txrowcount.dll                                     | 2015.131.5153.0 | 126640    | 29-Jun-18 | 02:34 | x64      |
| Txrowcount.dll                                     | 2015.131.5153.0 | 101552    | 29-Jun-18 | 02:38 | x86      |
| Txsampling.dll                                     | 2015.131.5153.0 | 172208    | 29-Jun-18 | 02:34 | x64      |
| Txsampling.dll                                     | 2015.131.5153.0 | 134832    | 29-Jun-18 | 02:38 | x86      |
| Txscd.dll                                          | 2015.131.5153.0 | 220344    | 29-Jun-18 | 02:34 | x64      |
| Txscd.dll                                          | 2015.131.5153.0 | 169648    | 29-Jun-18 | 02:38 | x86      |
| Txsort.dll                                         | 2015.131.5153.0 | 259256    | 29-Jun-18 | 02:34 | x64      |
| Txsort.dll                                         | 2015.131.5153.0 | 211120    | 29-Jun-18 | 02:38 | x86      |
| Txsplit.dll                                        | 2015.131.5153.0 | 600752    | 29-Jun-18 | 02:34 | x64      |
| Txsplit.dll                                        | 2015.131.5153.0 | 513200    | 29-Jun-18 | 02:38 | x86      |
| Txtermextraction.dll                               | 2015.131.5153.0 | 8678064   | 29-Jun-18 | 02:34 | x64      |
| Txtermextraction.dll                               | 2015.131.5153.0 | 8615600   | 29-Jun-18 | 02:38 | x86      |
| Txtermlookup.dll                                   | 2015.131.5153.0 | 4158640   | 29-Jun-18 | 02:34 | x64      |
| Txtermlookup.dll                                   | 2015.131.5153.0 | 4106928   | 29-Jun-18 | 02:38 | x86      |
| Txunionall.dll                                     | 2015.131.5153.0 | 181936    | 29-Jun-18 | 02:34 | x64      |
| Txunionall.dll                                     | 2015.131.5153.0 | 138928    | 29-Jun-18 | 02:38 | x86      |
| Txunpivot.dll                                      | 2015.131.5153.0 | 201928    | 29-Jun-18 | 02:34 | x64      |
| Txunpivot.dll                                      | 2015.131.5153.0 | 162480    | 29-Jun-18 | 02:38 | x86      |
| Xe.dll                                             | 2015.131.5153.0 | 558792    | 29-Jun-18 | 02:35 | x86      |
| Xe.dll                                             | 2015.131.5153.0 | 626352    | 29-Jun-18 | 02:37 | x64      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.46     | 483504    | 18-Jun-18 | 22:50 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.46 | 75432     | 18-Jun-18 | 22:50 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.46     | 45736     | 18-Jun-18 | 22:50 | x86      |
| Instapi130.dll                                                       | 2015.131.5153.0  | 61104     | 29-Jun-18 | 02:34 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.46     | 74408     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.46     | 201896    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.46     | 2347184   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.46     | 102056    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.46     | 378544    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.46     | 185512    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.46     | 127152    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.46     | 63144     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.46     | 52392     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.46     | 87216     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.46     | 721584    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.46     | 87208     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.46     | 77992     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.46     | 41640     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.46     | 36528     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.46     | 47784     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.46     | 27312     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.46     | 32944     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.46     | 118952    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.46     | 94376     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.46     | 108200    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.46     | 256680    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 102056    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 115880    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 118952    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 115880    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 125616    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 117936    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 113328    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 145576    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 100016    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.46     | 114856    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.46     | 69288     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.46     | 28328     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.46     | 43696     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.46     | 82088     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.46     | 136872    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.46     | 2155688   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.46     | 3818672   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 107696    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 119984    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 124584    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 121000    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 133288    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 121000    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 118448    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 152240    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 105136    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.46     | 119464    | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.46     | 66728     | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.46     | 2756272   | 18-Jun-18 | 22:50 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.46     | 752296    | 18-Jun-18 | 22:50 | x86      |
| Mpdwinterop.dll                                                      | 2015.131.5153.0  | 394416    | 29-Jun-18 | 02:34 | x64      |
| Mpdwsvc.exe                                                          | 2015.131.5153.0  | 6616240   | 29-Jun-18 | 02:37 | x64      |
| Pdwodbcsql11.dll                                                     | 2015.131.5153.0  | 2229936   | 29-Jun-18 | 02:34 | x64      |
| Sharedmemory.dll                                                     | 2014.120.8224.46 | 47280     | 18-Jun-18 | 22:50 | x64      |
| Sqldk.dll                                                            | 2015.131.5153.0  | 2532016   | 29-Jun-18 | 02:34 | x64      |
| Sqldumper.exe                                                        | 2015.131.5153.0  | 127152    | 29-Jun-18 | 02:37 | x64      |
| Sqlos.dll                                                            | 2015.131.5153.0  | 26288     | 29-Jun-18 | 02:34 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.46 | 4348072   | 18-Jun-18 | 22:50 | x64      |
| Sqltses.dll                                                          | 2015.131.5153.0  | 9064624   | 29-Jun-18 | 02:34 | x64      |

SQL Server 2016 Reporting Services

|                        File name                        |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.modeling.dll                 | 13.0.5153.0     | 610992    | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.diagnostics.dll             | 13.0.5153.0     | 1620144   | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.dll           | 13.0.5153.0     | 1072304   | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:34 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532152    | 29-Jun-18 | 02:34 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:37 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532168    | 29-Jun-18 | 02:34 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:34 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:35 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll | 13.0.5153.0     | 532144    | 29-Jun-18 | 02:36 | x86      |
| Microsoft.reportingservices.portal.web.dll              | 13.0.5153.0     | 10886320  | 29-Jun-18 | 02:36 | x86      |
| Microsoft.reportingservices.portal.webhost.exe          | 13.0.5153.0     | 101048    | 29-Jun-18 | 02:37 | x64      |
| Microsoft.reportingservices.usagetracking.dll           | 2015.131.5153.0 | 47792     | 29-Jun-18 | 02:36 | x64      |
| Msmdlocal.dll                                           | 2015.131.5153.0 | 37099192  | 29-Jun-18 | 02:34 | x86      |
| Msmdlocal.dll                                           | 2015.131.5153.0 | 56206512  | 29-Jun-18 | 02:35 | x64      |
| Msmgdsrv.dll                                            | 2015.131.5153.0 | 7507120   | 29-Jun-18 | 02:34 | x64      |
| Msmgdsrv.dll                                            | 2015.131.5153.0 | 6507696   | 29-Jun-18 | 02:36 | x86      |
| Msolui130.dll                                           | 2015.131.5153.0 | 287408    | 29-Jun-18 | 02:34 | x86      |
| Msolui130.dll                                           | 2015.131.5153.0 | 310456    | 29-Jun-18 | 02:35 | x64      |
| Reportingservicescompression.dll                        | 2015.131.5153.0 | 62640     | 29-Jun-18 | 02:35 | x64      |
| Reportingservicesnativeclient.dll                       | 2015.131.5153.0 | 108720    | 29-Jun-18 | 02:34 | x64      |
| Reportingservicesnativeclient.dll                       | 2015.131.5153.0 | 114352    | 29-Jun-18 | 02:36 | x86      |
| Reportingservicesnativeserver.dll                       | 2015.131.5153.0 | 98992     | 29-Jun-18 | 02:34 | x64      |
| Reportingserviceswebserver.dll                          | 13.0.5153.0     | 2710728   | 29-Jun-18 | 02:34 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 868016    | 29-Jun-18 | 02:36 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:37 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:36 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:34 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 876208    | 29-Jun-18 | 02:36 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:36 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:35 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 884400    | 29-Jun-18 | 02:36 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 868024    | 29-Jun-18 | 02:34 | x86      |
| Reportingserviceswebserver.resources.dll                | 13.0.5153.0     | 872112    | 29-Jun-18 | 02:36 | x86      |
| Rshttpruntime.dll                                       | 2015.131.5153.0 | 99504     | 29-Jun-18 | 02:34 | x64      |
| Sql_rs_keyfile.dll                                      | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                                           | 2015.131.5153.0 | 127152    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                                           | 2015.131.5153.0 | 107696    | 29-Jun-18 | 02:36 | x86      |
| Sqlrsos.dll                                             | 2015.131.5153.0 | 26288     | 29-Jun-18 | 02:34 | x64      |
| Sqlserverspatial130.dll                                 | 2015.131.5153.0 | 584376    | 29-Jun-18 | 02:34 | x86      |
| Sqlserverspatial130.dll                                 | 2015.131.5153.0 | 732848    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                               | 2015.131.5153.0 | 319152    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                               | 2015.131.5153.0 | 259760    | 29-Jun-18 | 02:38 | x86      |
| Xmlrwbin.dll                                            | 2015.131.5153.0 | 227504    | 29-Jun-18 | 02:37 | x64      |
| Xmlrwbin.dll                                            | 2015.131.5153.0 | 191664    | 29-Jun-18 | 02:38 | x86      |
| Xmsrv.dll                                               | 2015.131.5153.0 | 24050864  | 29-Jun-18 | 02:34 | x64      |
| Xmsrv.dll                                               | 2015.131.5153.0 | 32727728  | 29-Jun-18 | 02:38 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.5153.0     | 23728     | 29-Jun-18 | 02:34 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2015.131.5153.0 | 1311944   | 29-Jun-18 | 02:36 | x86      |
| Ddsshapes.dll                                  | 2015.131.5153.0 | 135864    | 29-Jun-18 | 02:36 | x86      |
| Dtaengine.exe                                  | 2015.131.5153.0 | 167088    | 29-Jun-18 | 02:36 | x86      |
| Dteparse.dll                                   | 2015.131.5153.0 | 109744    | 29-Jun-18 | 02:35 | x64      |
| Dteparse.dll                                   | 2015.131.5153.0 | 99504     | 29-Jun-18 | 02:36 | x86      |
| Dteparsemgd.dll                                | 2015.131.5153.0 | 83632     | 29-Jun-18 | 02:34 | x86      |
| Dteparsemgd.dll                                | 2015.131.5153.0 | 88752     | 29-Jun-18 | 02:35 | x64      |
| Dtepkg.dll                                     | 2015.131.5153.0 | 137392    | 29-Jun-18 | 02:35 | x64      |
| Dtepkg.dll                                     | 2015.131.5153.0 | 115888    | 29-Jun-18 | 02:36 | x86      |
| Dtexec.exe                                     | 2015.131.5153.0 | 66736     | 29-Jun-18 | 02:36 | x86      |
| Dtexec.exe                                     | 2015.131.5153.0 | 72880     | 29-Jun-18 | 02:38 | x64      |
| Dts.dll                                        | 2015.131.5153.0 | 3146928   | 29-Jun-18 | 02:35 | x64      |
| Dts.dll                                        | 2015.131.5153.0 | 2632880   | 29-Jun-18 | 02:36 | x86      |
| Dtscomexpreval.dll                             | 2015.131.5153.0 | 477360    | 29-Jun-18 | 02:35 | x64      |
| Dtscomexpreval.dll                             | 2015.131.5153.0 | 419000    | 29-Jun-18 | 02:36 | x86      |
| Dtsconn.dll                                    | 2015.131.5153.0 | 492720    | 29-Jun-18 | 02:35 | x64      |
| Dtsconn.dll                                    | 2015.131.5153.0 | 392368    | 29-Jun-18 | 02:36 | x86      |
| Dtshost.exe                                    | 2015.131.5153.0 | 76464     | 29-Jun-18 | 02:36 | x86      |
| Dtshost.exe                                    | 2015.131.5153.0 | 86728     | 29-Jun-18 | 02:38 | x64      |
| Dtslog.dll                                     | 2015.131.5153.0 | 120496    | 29-Jun-18 | 02:35 | x64      |
| Dtslog.dll                                     | 2015.131.5153.0 | 103088    | 29-Jun-18 | 02:36 | x86      |
| Dtsmsg130.dll                                  | 2015.131.5153.0 | 545456    | 29-Jun-18 | 02:35 | x64      |
| Dtsmsg130.dll                                  | 2015.131.5153.0 | 541360    | 29-Jun-18 | 02:36 | x86      |
| Dtspipeline.dll                                | 2015.131.5153.0 | 1279152   | 29-Jun-18 | 02:35 | x64      |
| Dtspipeline.dll                                | 2015.131.5153.0 | 1059504   | 29-Jun-18 | 02:36 | x86      |
| Dtspipelineperf130.dll                         | 2015.131.5153.0 | 48304     | 29-Jun-18 | 02:35 | x64      |
| Dtspipelineperf130.dll                         | 2015.131.5153.0 | 42168     | 29-Jun-18 | 02:36 | x86      |
| Dtuparse.dll                                   | 2015.131.5153.0 | 87728     | 29-Jun-18 | 02:35 | x64      |
| Dtuparse.dll                                   | 2015.131.5153.0 | 80072     | 29-Jun-18 | 02:36 | x86      |
| Dtutil.exe                                     | 2015.131.5153.0 | 115376    | 29-Jun-18 | 02:36 | x86      |
| Dtutil.exe                                     | 2015.131.5153.0 | 134832    | 29-Jun-18 | 02:38 | x64      |
| Exceldest.dll                                  | 2015.131.5153.0 | 263344    | 29-Jun-18 | 02:35 | x64      |
| Exceldest.dll                                  | 2015.131.5153.0 | 216752    | 29-Jun-18 | 02:36 | x86      |
| Excelsrc.dll                                   | 2015.131.5153.0 | 285360    | 29-Jun-18 | 02:35 | x64      |
| Excelsrc.dll                                   | 2015.131.5153.0 | 232624    | 29-Jun-18 | 02:36 | x86      |
| Flatfiledest.dll                               | 2015.131.5153.0 | 389296    | 29-Jun-18 | 02:35 | x64      |
| Flatfiledest.dll                               | 2015.131.5153.0 | 334512    | 29-Jun-18 | 02:36 | x86      |
| Flatfilesrc.dll                                | 2015.131.5153.0 | 401584    | 29-Jun-18 | 02:35 | x64      |
| Flatfilesrc.dll                                | 2015.131.5153.0 | 345264    | 29-Jun-18 | 02:36 | x86      |
| Foreachfileenumerator.dll                      | 2015.131.5153.0 | 96432     | 29-Jun-18 | 02:35 | x64      |
| Foreachfileenumerator.dll                      | 2015.131.5153.0 | 80560     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.analysisservices.adomdclientui.dll   | 13.0.5153.0     | 92336     | 29-Jun-18 | 02:34 | x86      |
| Microsoft.analysisservices.project.dll         | 2015.131.5153.0 | 2023088   | 29-Jun-18 | 02:34 | x86      |
| Microsoft.analysisservices.projectui.dll       | 2015.131.5153.0 | 42160     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.astasks.dll                | 13.0.5153.0     | 73392     | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5153.0     | 433840    | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 13.0.5153.0     | 433840    | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5153.0     | 2044592   | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 13.0.5153.0     | 2044592   | 29-Jun-18 | 02:36 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5153.0 | 150192    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2015.131.5153.0 | 138928    | 29-Jun-18 | 02:37 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5153.0 | 158896    | 29-Jun-18 | 02:36 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2015.131.5153.0 | 144560    | 29-Jun-18 | 02:37 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5153.0 | 90296     | 29-Jun-18 | 02:34 | x86      |
| Msdtssrvrutil.dll                              | 2015.131.5153.0 | 101552    | 29-Jun-18 | 02:35 | x64      |
| Msmdlocal.dll                                  | 2015.131.5153.0 | 37099192  | 29-Jun-18 | 02:34 | x86      |
| Msmdlocal.dll                                  | 2015.131.5153.0 | 56206512  | 29-Jun-18 | 02:35 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5153.0 | 7507120   | 29-Jun-18 | 02:34 | x64      |
| Msmgdsrv.dll                                   | 2015.131.5153.0 | 6507696   | 29-Jun-18 | 02:36 | x86      |
| Msolui130.dll                                  | 2015.131.5153.0 | 287408    | 29-Jun-18 | 02:34 | x86      |
| Msolui130.dll                                  | 2015.131.5153.0 | 310456    | 29-Jun-18 | 02:35 | x64      |
| Oledbdest.dll                                  | 2015.131.5153.0 | 216760    | 29-Jun-18 | 02:34 | x86      |
| Oledbdest.dll                                  | 2015.131.5153.0 | 264368    | 29-Jun-18 | 02:35 | x64      |
| Oledbsrc.dll                                   | 2015.131.5153.0 | 235704    | 29-Jun-18 | 02:34 | x86      |
| Oledbsrc.dll                                   | 2015.131.5153.0 | 290992    | 29-Jun-18 | 02:35 | x64      |
| Profiler.exe                                   | 2015.131.5153.0 | 804528    | 29-Jun-18 | 02:34 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2015.131.5153.0 | 100528    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                                  | 2015.131.5153.0 | 127152    | 29-Jun-18 | 02:35 | x64      |
| Sqldumper.exe                                  | 2015.131.5153.0 | 107696    | 29-Jun-18 | 02:36 | x86      |
| Sqlresld.dll                                   | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlresld.dll                                   | 2015.131.5153.0 | 28856     | 29-Jun-18 | 02:34 | x86      |
| Sqlresourceloader.dll                          | 2015.131.5153.0 | 30896     | 29-Jun-18 | 02:34 | x64      |
| Sqlresourceloader.dll                          | 2015.131.5153.0 | 28344     | 29-Jun-18 | 02:34 | x86      |
| Sqlscm.dll                                     | 2015.131.5153.0 | 52920     | 29-Jun-18 | 02:34 | x86      |
| Sqlscm.dll                                     | 2015.131.5153.0 | 61104     | 29-Jun-18 | 02:37 | x64      |
| Sqlsvc.dll                                     | 2015.131.5153.0 | 152240    | 29-Jun-18 | 02:34 | x64      |
| Sqlsvc.dll                                     | 2015.131.5153.0 | 127176    | 29-Jun-18 | 02:34 | x86      |
| Sqltaskconnections.dll                         | 2015.131.5153.0 | 180912    | 29-Jun-18 | 02:34 | x64      |
| Sqltaskconnections.dll                         | 2015.131.5153.0 | 151224    | 29-Jun-18 | 02:34 | x86      |
| Txdataconvert.dll                              | 2015.131.5153.0 | 296648    | 29-Jun-18 | 02:34 | x64      |
| Txdataconvert.dll                              | 2015.131.5153.0 | 255152    | 29-Jun-18 | 02:38 | x86      |
| Xe.dll                                         | 2015.131.5153.0 | 558792    | 29-Jun-18 | 02:35 | x86      |
| Xe.dll                                         | 2015.131.5153.0 | 626352    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                      | 2015.131.5153.0 | 319152    | 29-Jun-18 | 02:37 | x64      |
| Xmlrw.dll                                      | 2015.131.5153.0 | 259760    | 29-Jun-18 | 02:38 | x86      |
| Xmlrwbin.dll                                   | 2015.131.5153.0 | 227504    | 29-Jun-18 | 02:37 | x64      |
| Xmlrwbin.dll                                   | 2015.131.5153.0 | 191664    | 29-Jun-18 | 02:38 | x86      |
| Xmsrv.dll                                      | 2015.131.5153.0 | 24050864  | 29-Jun-18 | 02:34 | x64      |
| Xmsrv.dll                                      | 2015.131.5153.0 | 32727728  | 29-Jun-18 | 02:38 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
