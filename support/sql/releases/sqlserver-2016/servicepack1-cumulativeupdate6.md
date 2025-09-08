---
title: Cumulative update 6 for SQL Server 2016 SP1 (KB4037354)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 6 (KB4037354).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4037354
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Service Pack 1
---

# KB4037354 - Cumulative Update 6 for SQL Server 2016 SP1

_Release Date:_ &nbsp; November 21, 2017  
_Version:_ &nbsp; 13.0.4457.0

This article describes cumulative update package 6 (build number: **13.0.4457.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Improvements and fixes included in this update

> [!NOTE]
> The following table lists the status of individual Microsoft Knowledge Base articles. A separate Microsoft Knowledge Base article might not be created for each bug.

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=10864854>[10864854](#10864854)</a> | [FIX: SSAS 2016 crashes intermittently when you rename multi-dimensional database using script (KB4052572)](https://support.microsoft.com/help/4052572) | Analysis Services |
| <a id=10864945>[10864945](#10864945)</a> | [FIX: Non-admin role can't receive correct ChildCount estimates for parent/child dimension leaf members in SSAS (KB3010148)](https://support.microsoft.com/help/3010148) | Analysis Services |
| <a id=10868738>[10868738](#10868738)</a> | [FIX: SSAS crashes when you process an SSAS database or cube in SQL Server (KB4039509)](https://support.microsoft.com/help/4039509) | Analysis Services |
| <a id=10868776>[10868776](#10868776)</a> | [FIX: SQL Server 2016 or 2017 Analysis Services may crash in a specific situation (KB3208545)](https://support.microsoft.com/help/3208545) | Analysis Services |
| <a id=10965956>[10965956](#10965956)</a> | [FIX: An unexpected exception error occurs when an XIRR measure processes too many records in SSAS 2016 or 2017 (KB4034789)](https://support.microsoft.com/help/4034789) | Analysis Services |
| <a id=10868735>[10868735](#10868735)</a> | [FIX: Error when you export a DQS knowledge base that contains domains in the DQS client in SQL Server (KB4022483)](https://support.microsoft.com/help/4022483) | Data Quality Services (DQS) |
| <a id=10930335>[10930335](#10930335)</a> | [FIX: "Request timed out" error when you change security options for an MDS security group in SQL Server 2016 (KB4044064)](https://support.microsoft.com/help/4044064) | Data Quality Services (DQS) |
| <a id=10921921>[10921921](#10921921)</a> | [FIX: Access violation on primary replica of AlwaysOn AG in SQL Server 2016 (KB4048943)](https://support.microsoft.com/help/4048943) | High Availability |
| <a id=11031058>[11031058](#11031058)</a> | FIX: Access violation when DMV queries run against a distributed availability group in SQL Server (KB4052121) | High Availability |
| <a id=11052495>[11052495](#11052495)</a> | Fixes an access violation when querying DMVs (`sys.dm_hadr_availability_group_states`,` sys.availability_groups`) against a distributed Availability Group. | High Availability |
| <a id=11029968>[11029968](#11029968)</a> | [FIX: In-Memory database restore fails with errors in SQL Server 2016 (KB4051356)](https://support.microsoft.com/help/4051356) | In-Memory OLTP |
| <a id=10870250>[10870250](#10870250)</a> | FIX: SQL Server Integration Service packages randomly hang if custom logging is enabled (KB4040934) | Integration Services |
| <a id=10678621>[10678621](#10678621)</a> | [FIX: Policy-Based Management policy isn't working after you install CU2 for SQL Server 2016 SP1 (KB4037454)](https://support.microsoft.com/help/4037454) | Management Tools |
| <a id=11078704>[11078704](#11078704)</a> | [FIX: Can't change the password for a SQL Server 2014 or 2016 service account when additional LSA protection is enabled (KB4039592)](https://support.microsoft.com/help/4039592) | Management Tools |
| <a id=11124144>[11124144](#11124144)</a> | [FIX: Alert Engine reads entire Application Event Log and sends alerts on old events after Windows is restarted (KB4052127)](https://support.microsoft.com/help/4052127) | Management Tools |
| <a id=10868757>[10868757](#10868757)</a> | [FIX: Error when exporting a Reporting Services report to PDF in SQL Server 2017 (KB4040512)](https://support.microsoft.com/help/4040512) | Reporting Services |
| <a id=10918636>[10918636](#10918636)</a> | [FIX: "AdomdConnectionException" error when SSRS 2016 data source uses msmdpump.dll (KB4049027)](https://support.microsoft.com/help/4049027) | Reporting Services |
| <a id=11060168>[11060168](#11060168)</a> | [FIX: Sliding expiration for authentication cookie isn't working and fails to redirect to logon page in SSRS 2016 (KB4052123)](https://support.microsoft.com/help/4052123) | Reporting Services |
| <a id=11078718>[11078718](#11078718)</a> | [FIX: Bookmarks functionality doesn't work completely when you open a report in MHTML format through Outlook in SSRS 2014 and 2016 (KB4043947)](https://support.microsoft.com/help/4043947) | Reporting Services |
| <a id=10067707>[10067707](#10067707)</a> | [FIX: Queries against PolyBase external tables return duplicate rows in SQL Server 2016 and 2017 (KB4019840)](https://support.microsoft.com/help/4019840) | SQL Engine |
| <a id=10330560>[10330560](#10330560)</a> | [FIX: Processing XML message using Service Broker results in hung session in SQL Server 2016 (KB4053550)](https://support.microsoft.com/help/4053550) | SQL Engine |
| <a id=10362525>[10362525](#10362525)</a> | [FIX: Memory use with many databases in SQL Server 2016 is greater than in earlier versions (KB4035062)](https://support.microsoft.com/help/4035062) | SQL Engine |
| <a id=10820931>[10820931](#10820931)</a> | [FIX: "Stalled IOCP Listener" and "non-yielding IOCP listener" memory dumps generated SQL Server 2016 restart (KB4048942)](https://support.microsoft.com/help/4048942) | SQL Engine |
| <a id=10868722>[10868722](#10868722)</a> | [FIX: SQL Server Managed Backup doesn't delete old backups that are beyond the retention period in SQL Server (KB4038882)](https://support.microsoft.com/help/4038882) | SQL Engine |
| <a id=10868725>[10868725](#10868725)</a> | [FIX: Managed Backup fails intermittently because of SQLVDI error in SQL Server (KB4039511)](https://support.microsoft.com/help/4039511) | SQL Engine |
| <a id=10868732>[10868732](#10868732)</a> | [FIX: Managed Backup to Microsoft Azure stops after large database backup in SQL Server (KB4040376)](https://support.microsoft.com/help/4040376) | SQL Engine |
| <a id=10868748>[10868748](#10868748)</a> | [FIX: Access violation for spatial datatypes query via linked server in SQL Server (KB4040401)](https://support.microsoft.com/help/4040401) | SQL Engine |
| <a id=10881290>[10881290](#10881290)</a> | [FIX: DMV sys.dm_os_windows_info returns wrong values for Windows 10 and Windows Server 2016 (KB4052131)](https://support.microsoft.com/help/4052131) | SQL Engine |
| <a id=10971673>[10971673](#10971673)</a> | [FIX: Distributed Transactions in an AG database fails after restarting in SQL Server 2016 (KB4052119)](https://support.microsoft.com/help/4052119) | SQL Engine |
| <a id=10972567>[10972567](#10972567)</a> | [FIX: Change tracking manual cleanup fails with table non-existence error in SQL Server (KB4043624)](https://support.microsoft.com/help/4043624) | SQL Engine |
| <a id=11031436>[11031436](#11031436)</a> | [FIX: Access violation occurs when SQL Server 2016 tries to start Query Store Manager during startup (KB4052133)](https://support.microsoft.com/help/4052133) | SQL Engine |
| <a id=11047614>[11047614](#11047614)</a> | [FIX: Errors 33111 and 3013 when you back up a TDE-encrypted database in SQL Server (KB4052134)](https://support.microsoft.com/help/4052134) | SQL Engine |
| <a id=11052450>[11052450](#11052450)</a> | [FIX: Assertion occurs on accessing memory-optimized table through MARS (KB4046056)](https://support.microsoft.com/help/4046056) | SQL Engine |
| <a id=11078723>[11078723](#11078723)</a> | [FIX: Inconsistent behavior for returning trailing blanks at the end of CHAR and BINARY data in SQL Server (KB4055758)](https://support.microsoft.com/help/4055758) | SQL Engine |
| <a id=11127649>[11127649](#11127649)</a> | [FIX: Data retrieval queries using non-clustered index seek take much longer in SQL Server (KB4052625)](https://support.microsoft.com/help/4052625) | SQL Engine |
| <a id=10934352>[10934352](#10934352)</a> | FIX: Thread pool exhaustion and CMEMTHREAD contention in AAG with data seeding in SQL Server 2016 (KB4045795) | SQL Engine |
| <a id=10980994>[10980994](#10980994)</a> | FIX: A non-yielding scheduler issue occurs when you use the SQL Server Query Store feature in SQL Server (KB4052132) | SQL Engine |
| <a id=11019542>[11019542](#11019542)</a> | Fixes large virtual allocations the size of Max Server Memory causing out of memory errors. | SQL Engine |
| <a id=10868770>[10868770](#10868770)</a> | [FIX: "Non-yielding Scheduler" condition occurs for query with many expressions in SQL Server 2014 and 2016 (KB4039735)](https://support.microsoft.com/help/4039735) | SQL performance |
| <a id=10935673>[10935673](#10935673)</a> | [FIX: SELECT query that uses batch mode hash aggregate operator that counts multiple nullable columns returns incorrect results in SQL Server (KB4052633)](https://support.microsoft.com/help/4052633) | SQL performance |
| <a id=11018232>[11018232](#11018232)</a> | [FIX: Query that uses parallel query execution plan with "merge join" operation slow in Cumulative Update 3, 4 or 5 for SQL Server 2016 Service Pack 1 (KB4046858)](https://support.microsoft.com/help/4046858) | SQL performance |
| <a id=11078711>[11078711](#11078711)</a> | [FIX: Access violation when you cancel a pending query if the missing indexes feature is enabled in SQL Server 2014 and 2016 (KB4042232)](https://support.microsoft.com/help/4042232) | SQL performance |
| <a id=10855950>[10855950](#10855950)</a> | [FIX: Audit Log for ROLLBACK TRANSACTION event isn't available in SQL Server 2016 (KB4052125)](https://support.microsoft.com/help/4052125) | SQL security |
| <a id=10868767>[10868767](#10868767)</a> | [FIX: Access violation occurs when you use sp_xml_preparedocument to open XML documents in SQL Server (KB4039510)](https://support.microsoft.com/help/4039510) | XML |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2016 SP1 now](https://www.microsoft.com/download/details.aspx?id=54613)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 SP1 is available at the Download Center.

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

When you deploy the hotfixes to a hybrid environment (such as Always On, replication, cluster, and mirroring), we recommend that you refer to the following articles before you deploy the hotfixes:

- [Upgrade a failover cluster instance](/sql/sql-server/failover-clusters/windows/upgrade-a-sql-server-failover-cluster-instance)

    > [!NOTE]
    > If you don't want to use the rolling update process, follow these steps to apply a CU or SP:
    >
    > - Install the service pack on the passive node.
    > - Install the service pack on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply a CU or SP in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

- SQL Server Cumulative Updates are currently multilingual. Therefore, this cumulative update package isn't specific to one language. It applies to all supported languages.
- The "Download the latest cumulative update package for Microsoft SQL Server 2014 now" form displays the languages for which the update package is available. If you don't see your language, that's because a cumulative update package isn't available specifically for that language and the ENU download applies to all languages.

</details>

<details>
<summary><b>Components updated</b></summary>

One cumulative update package includes all the component packages. However, the cumulative update package updates only those components that are installed on the system.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a separate service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

</details>

<details>
<summary><b>How to uninstall this update</b></summary>

To do this, follow these steps:

1. In Control Panel, select **Add or Remove Programs**.

    > [!NOTE]
    > If you are running Windows 7 or a later version, select **Programs and Features** in Control Panel.

1. Locate the entry that corresponds to this cumulative update package.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

## Cumulative update package information

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2016 SP1.

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

This cumulative update package might not contain all the files that you must have to fully update a product to the latest build. This package contains only the files that you must have to correct the issues that are listed in this article.

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x86-based versions

SQL Server 2016 Browser Service

|        File name       |   File version  | File size |    Date   |  Time | Platform |
|:----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Msmdsrv.rll            | 2015.130.4457.0 | 1296560   | 09-Nov-17 | 03:18 | x86      |
| Msmdsrvi.rll           | 2015.130.4457.0 | 1293480   | 09-Nov-17 | 03:18 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4457.0 | 88752     | 09-Nov-17 | 03:16 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4457.0     | 1027248   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4457.0     | 1348776   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4457.0     | 702640    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4457.0     | 765616    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4457.0     | 520880    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4457.0     | 711856    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4457.0     | 37032     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4457.0     | 46256     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4457.0 | 72872     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4457.0     | 598704    | 09-Nov-17 | 03:17 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4457.0 | 60072     | 09-Nov-17 | 03:16 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4457.0 | 88752     | 09-Nov-17 | 03:16 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4457.0 | 364200    | 09-Nov-17 | 03:16 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4457.0 | 267432    | 09-Nov-17 | 03:16 | x86      |
| Sqltdiagn.dll                               | 2015.130.4457.0 | 60592     | 09-Nov-17 | 03:16 | x86      |
| Svrenumapi130.dll                           | 2015.130.4457.0 | 854192    | 09-Nov-17 | 03:16 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4457.0  | 1876656   | 09-Nov-17 | 03:17 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                    |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                         | 2015.130.4457.0 | 2631856   | 09-Nov-17 | 03:15 | x86      |
| Dtswizard.exe                                   | 13.0.4457.0     | 896168    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4457.0     | 1313456   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4457.0     | 696488    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4457.0     | 763568    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4457.0 | 2023080   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4457.0     | 72360     | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4457.0     | 186544    | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4457.0     | 433840    | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4457.0     | 2044584   | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4457.0     | 33456     | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4457.0     | 249512    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4457.0     | 501936    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4457.0     | 106152    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4457.0 | 138928    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4457.0 | 144560    | 09-Nov-17 | 03:14 | x86      |
| Msmdlocal.dll                                   | 2015.130.4457.0 | 37083824  | 09-Nov-17 | 03:16 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4457.0 | 6507688   | 09-Nov-17 | 03:17 | x86      |
| Msolap130.dll                                   | 2015.130.4457.0 | 7007408   | 09-Nov-17 | 03:16 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4457.0 | 88752     | 09-Nov-17 | 03:16 | x86      |
| Xe.dll                                          | 2015.130.4457.0 | 558768    | 09-Nov-17 | 03:17 | x86      |
| Xmsrv.dll                                       | 2015.130.4457.0 | 32718000  | 09-Nov-17 | 03:16 | x86      |

x64-based versions

SQL Server 2016 Browser Service

|   File name  |   File version  | File size |    Date   |  Time | Platform |
|:------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Keyfile.dll  | 2015.130.4457.0 | 88752     | 09-Nov-17 | 03:16 | x86      |
| Msmdsrv.rll  | 2015.130.4457.0 | 1296560   | 09-Nov-17 | 03:18 | x86      |
| Msmdsrvi.rll | 2015.130.4457.0 | 1293480   | 09-Nov-17 | 03:18 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlboot.dll           | 2015.130.4457.0 | 186536    | 09-Nov-17 | 03:20 | x64      |
| Sqlvdi.dll            | 2015.130.4457.0 | 168624    | 09-Nov-17 | 03:16 | x86      |
| Sqlvdi.dll            | 2015.130.4457.0 | 197288    | 09-Nov-17 | 03:19 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlwvss.dll           | 2015.130.4457.0 | 336040    | 09-Nov-17 | 03:14 | x64      |

SQL Server 2016 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll         | 13.0.4457.0     | 1347760   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4457.0     | 765616    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4457.0     | 521384    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4457.0     | 989872    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4457.0     | 989864    | 09-Nov-17 | 03:20 | x86      |
| Msmdctr130.dll                                     | 2015.130.4457.0 | 40104     | 09-Nov-17 | 03:20 | x64      |
| Msmdlocal.dll                                      | 2015.130.4457.0 | 37083824  | 09-Nov-17 | 03:16 | x86      |
| Msmdlocal.dll                                      | 2015.130.4457.0 | 56190640  | 09-Nov-17 | 03:20 | x64      |
| Msmdsrv.exe                                        | 2015.130.4457.0 | 56736424  | 09-Nov-17 | 03:18 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4457.0 | 6507688   | 09-Nov-17 | 03:17 | x86      |
| Msmgdsrv.dll                                       | 2015.130.4457.0 | 7507112   | 09-Nov-17 | 03:24 | x64      |
| Msolap130.dll                                      | 2015.130.4457.0 | 7007408   | 09-Nov-17 | 03:16 | x86      |
| Msolap130.dll                                      | 2015.130.4457.0 | 8638640   | 09-Nov-17 | 03:20 | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlboot.dll                                        | 2015.130.4457.0 | 186536    | 09-Nov-17 | 03:20 | x64      |
| Sqlceip.exe                                        | 13.0.4457.0     | 247976    | 09-Nov-17 | 03:14 | x86      |
| Tmapi.dll                                          | 2015.130.4457.0 | 4346032   | 09-Nov-17 | 03:14 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4457.0 | 2826416   | 09-Nov-17 | 03:14 | x64      |
| Tmpersistence.dll                                  | 2015.130.4457.0 | 1071272   | 09-Nov-17 | 03:14 | x64      |
| Tmtransactions.dll                                 | 2015.130.4457.0 | 1352368   | 09-Nov-17 | 03:14 | x64      |
| Xe.dll                                             | 2015.130.4457.0 | 626352    | 09-Nov-17 | 03:20 | x64      |
| Xmsrv.dll                                          | 2015.130.4457.0 | 24041136  | 09-Nov-17 | 03:14 | x64      |
| Xmsrv.dll                                          | 2015.130.4457.0 | 32718000  | 09-Nov-17 | 03:16 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4457.0     | 1027248   | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4457.0     | 1027248   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4457.0     | 1348776   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4457.0     | 702640    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4457.0     | 765616    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4457.0     | 520880    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4457.0     | 711856    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4457.0     | 711856    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4457.0     | 37032     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4457.0     | 46256     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4457.0 | 75432     | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4457.0 | 72872     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4457.0     | 598704    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4457.0     | 598704    | 09-Nov-17 | 03:24 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4457.0 | 60072     | 09-Nov-17 | 03:16 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4457.0 | 72880     | 09-Nov-17 | 03:20 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4457.0 | 404136    | 09-Nov-17 | 03:14 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4457.0 | 364200    | 09-Nov-17 | 03:16 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4457.0 | 348848    | 09-Nov-17 | 03:14 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4457.0 | 267432    | 09-Nov-17 | 03:16 | x86      |
| Sqltdiagn.dll                               | 2015.130.4457.0 | 67760     | 09-Nov-17 | 03:14 | x64      |
| Sqltdiagn.dll                               | 2015.130.4457.0 | 60592     | 09-Nov-17 | 03:16 | x86      |
| Svrenumapi130.dll                           | 2015.130.4457.0 | 1115824   | 09-Nov-17 | 03:14 | x64      |
| Svrenumapi130.dll                           | 2015.130.4457.0 | 854192    | 09-Nov-17 | 03:16 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4457.0  | 1876656   | 09-Nov-17 | 03:17 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4457.0  | 1876656   | 09-Nov-17 | 03:24 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.4457.0     | 41128     | 09-Nov-17 | 03:18 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-16 | 00:46 | x64      |
| Fssres.dll                                   | 2015.130.4457.0 | 81576     | 09-Nov-17 | 03:20 | x64      |
| Hadrres.dll                                  | 2015.130.4457.0 | 177832    | 09-Nov-17 | 03:19 | x64      |
| Hkcompile.dll                                | 2015.130.4457.0 | 1297064   | 09-Nov-17 | 03:19 | x64      |
| Hkengine.dll                                 | 2015.130.4457.0 | 5601456   | 09-Nov-17 | 03:21 | x64      |
| Hkruntime.dll                                | 2015.130.4457.0 | 158896    | 09-Nov-17 | 03:21 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4457.0     | 235176    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4457.0     | 79536     | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4457.0 | 391856    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4457.0 | 71336     | 09-Nov-17 | 03:24 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4457.0 | 65200     | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4457.0 | 150192    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4457.0 | 158896    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4457.0 | 272040    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4457.0 | 74928     | 09-Nov-17 | 03:17 | x64      |
| Msvcp120.dll                                 | 12.0.40649.5    | 660128    | 12-Sep-17 | 19:53 | x64      |
| Msvcr120.dll                                 | 12.0.40649.5    | 963744    | 12-Sep-17 | 19:53 | x64      |
| Qds.dll                                      | 2015.130.4457.0 | 844456    | 09-Nov-17 | 03:20 | x64      |
| Rsfxft.dll                                   | 2015.130.4457.0 | 34480     | 09-Nov-17 | 03:19 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlaccess.dll                                | 2015.130.4457.0 | 462504    | 09-Nov-17 | 03:17 | x64      |
| Sqlagent.exe                                 | 2015.130.4457.0 | 565936    | 09-Nov-17 | 03:18 | x64      |
| Sqlboot.dll                                  | 2015.130.4457.0 | 186536    | 09-Nov-17 | 03:20 | x64      |
| Sqlceip.exe                                  | 13.0.4457.0     | 247976    | 09-Nov-17 | 03:14 | x86      |
| Sqldk.dll                                    | 2015.130.4457.0 | 2586288   | 09-Nov-17 | 03:20 | x64      |
| Sqllang.dll                                  | 2015.130.4457.0 | 39390384  | 09-Nov-17 | 03:20 | x64      |
| Sqlmin.dll                                   | 2015.130.4457.0 | 37564592  | 09-Nov-17 | 03:14 | x64      |
| Sqlos.dll                                    | 2015.130.4457.0 | 26288     | 09-Nov-17 | 03:19 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4457.0 | 27824     | 09-Nov-17 | 03:14 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4457.0 | 5797544   | 09-Nov-17 | 03:19 | x64      |
| Sqlservr.exe                                 | 2015.130.4457.0 | 392872    | 09-Nov-17 | 03:18 | x64      |
| Sqltses.dll                                  | 2015.130.4457.0 | 8897200   | 09-Nov-17 | 03:14 | x64      |
| Sqsrvres.dll                                 | 2015.130.4457.0 | 251056    | 09-Nov-17 | 03:14 | x64      |
| Stretchcodegen.exe                           | 13.0.4457.0     | 55976     | 09-Nov-17 | 03:14 | x86      |
| Xe.dll                                       | 2015.130.4457.0 | 626352    | 09-Nov-17 | 03:20 | x64      |
| Xpstar.dll                                   | 2015.130.4457.0 | 422568    | 09-Nov-17 | 03:19 | x64      |

SQL Server 2016 Database Services Core Shared

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Bcp.exe                                                            | 2015.130.4457.0 | 119976    | 09-Nov-17 | 03:20 | x64      |
| Dts.dll                                                            | 2015.130.4457.0 | 3145392   | 09-Nov-17 | 03:20 | x64      |
| Dtswizard.exe                                                      | 13.0.4457.0     | 895664    | 09-Nov-17 | 03:14 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4457.0     | 1313456   | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4457.0     | 696488    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4457.0     | 763568    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4457.0     | 54448     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4457.0     | 89776     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4457.0     | 49832     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4457.0     | 43184     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4457.0     | 70824     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4457.0     | 35496     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4457.0     | 73392     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4457.0     | 63664     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4457.0     | 31400     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4457.0     | 131240    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4457.0     | 43696     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4457.0     | 57512     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4457.0     | 215216    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 22:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4457.0 | 1639088   | 09-Nov-17 | 03:24 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4457.0 | 150192    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4457.0 | 158896    | 09-Nov-17 | 03:17 | x64      |
| Msxmlsql.dll                                                       | 2015.130.4457.0 | 1497264   | 09-Nov-17 | 03:19 | x64      |
| Spresolv.dll                                                       | 2015.130.4457.0 | 245416    | 09-Nov-17 | 03:20 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlcmd.exe                                                         | 2015.130.4457.0 | 249512    | 09-Nov-17 | 03:20 | x64      |
| Sqllogship.exe                                                     | 13.0.4457.0     | 100520    | 09-Nov-17 | 03:14 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4457.0 | 346792    | 09-Nov-17 | 03:14 | x64      |
| Sqlps.exe                                                          | 13.0.4457.0     | 60080     | 09-Nov-17 | 03:20 | x86      |
| Sqlwep130.dll                                                      | 2015.130.4457.0 | 105648    | 09-Nov-17 | 03:14 | x64      |
| Ssradd.dll                                                         | 2015.130.4457.0 | 65200     | 09-Nov-17 | 03:14 | x64      |
| Ssravg.dll                                                         | 2015.130.4457.0 | 65200     | 09-Nov-17 | 03:14 | x64      |
| Ssrdown.dll                                                        | 2015.130.4457.0 | 50864     | 09-Nov-17 | 03:14 | x64      |
| Ssrmax.dll                                                         | 2015.130.4457.0 | 63664     | 09-Nov-17 | 03:14 | x64      |
| Ssrmin.dll                                                         | 2015.130.4457.0 | 63664     | 09-Nov-17 | 03:14 | x64      |
| Ssrpub.dll                                                         | 2015.130.4457.0 | 51368     | 09-Nov-17 | 03:14 | x64      |
| Ssrup.dll                                                          | 2015.130.4457.0 | 50856     | 09-Nov-17 | 03:14 | x64      |
| Txdatacollector.dll                                                | 2015.130.4457.0 | 367280    | 09-Nov-17 | 03:14 | x64      |
| Xe.dll                                                             | 2015.130.4457.0 | 626352    | 09-Nov-17 | 03:20 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4457.0 | 1013936   | 09-Nov-17 | 03:20 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlsatellite.dll              | 2015.130.4457.0 | 837288    | 09-Nov-17 | 03:19 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.130.4457.0 | 660136    | 09-Nov-17 | 03:19 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlft130ph.dll           | 2015.130.4457.0 | 58024     | 09-Nov-17 | 03:19 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4457.0     | 23720     | 09-Nov-17 | 03:14 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |

SQL Server 2016 Integration Services

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 25-Aug-17 | 02:09 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 12-Sep-17 | 19:50 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 25-Aug-17 | 02:09 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 12-Sep-17 | 19:50 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 25-Aug-17 | 02:09 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 12-Sep-17 | 19:50 | x86      |
| Dts.dll                                                            | 2015.130.4457.0 | 2631856   | 09-Nov-17 | 03:15 | x86      |
| Dts.dll                                                            | 2015.130.4457.0 | 3145392   | 09-Nov-17 | 03:20 | x64      |
| Dtswizard.exe                                                      | 13.0.4457.0     | 896168    | 09-Nov-17 | 03:14 | x86      |
| Dtswizard.exe                                                      | 13.0.4457.0     | 895664    | 09-Nov-17 | 03:14 | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4457.0     | 439984    | 09-Nov-17 | 03:14 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4457.0     | 438960    | 09-Nov-17 | 03:14 | x64      |
| Isserverexec.exe                                                   | 13.0.4457.0     | 132776    | 09-Nov-17 | 03:14 | x86      |
| Isserverexec.exe                                                   | 13.0.4457.0     | 132272    | 09-Nov-17 | 03:14 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4457.0     | 1313456   | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4457.0     | 1313456   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4457.0     | 696488    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4457.0     | 696488    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4457.0     | 763568    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4457.0     | 763568    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4457.0     | 72360     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4457.0     | 54448     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4457.0     | 54448     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4457.0     | 89776     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4457.0     | 89776     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4457.0     | 43184     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4457.0     | 43184     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4457.0     | 35496     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4457.0     | 35496     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4457.0     | 73392     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4457.0     | 73392     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4457.0     | 31400     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4457.0     | 31400     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4457.0     | 469680    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4457.0     | 469672    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4457.0     | 43696     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4457.0     | 43696     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4457.0     | 57512     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4457.0     | 57520     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4457.0     | 52904     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4457.0     | 52904     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4457.0 | 138928    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4457.0 | 150192    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4457.0 | 144560    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4457.0 | 158896    | 09-Nov-17 | 03:17 | x64      |
| Msdtssrvr.exe                                                      | 13.0.4457.0     | 216744    | 09-Nov-17 | 03:14 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlceip.exe                                                        | 13.0.4457.0     | 247976    | 09-Nov-17 | 03:14 | x86      |
| Xe.dll                                                             | 2015.130.4457.0 | 558768    | 09-Nov-17 | 03:17 | x86      |
| Xe.dll                                                             | 2015.130.4457.0 | 626352    | 09-Nov-17 | 03:20 | x64      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.36     | 483496    | 25-Sep-17 | 21:29 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.36 | 75432     | 25-Sep-17 | 21:29 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.36     | 44848     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.36     | 74408     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.36     | 201896    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.36     | 2347176   | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.36     | 101544    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.36     | 378536    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.36     | 185512    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.36     | 127144    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.36     | 62256     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.36     | 52392     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.36     | 87208     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.36     | 721576    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.36     | 87208     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.36     | 77992     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.36     | 40752     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.36     | 36520     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.36     | 47784     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.36     | 26416     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.36     | 32936     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.36     | 118952    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.36     | 94376     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.36     | 107312    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.36     | 256680    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 102056    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 115880    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 118952    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 115880    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 125608    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 117928    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 113320    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 145576    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 100008    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.36     | 114856    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.36     | 69288     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.36     | 28328     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.36     | 43688     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.36     | 82088     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.36     | 136872    | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.36     | 2155688   | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.36     | 3818664   | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 107688    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 119976    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 124584    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 121000    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 133288    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 121000    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 118440    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 152232    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 105128    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.36     | 119464    | 25-Sep-17 | 21:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.36     | 65840     | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.36     | 2755376   | 25-Sep-17 | 21:29 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.36     | 752296    | 25-Sep-17 | 21:29 | x86      |
| Sharedmemory.dll                                                     | 2014.120.8224.36 | 47272     | 25-Sep-17 | 21:29 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.36 | 4348072   | 25-Sep-17 | 21:30 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.4457.0     | 79024     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4457.0     | 168624    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4457.0     | 1620144   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4457.0     | 657576    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4457.0     | 329896    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4457.0     | 1070760   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532144    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532144    | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532144    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532144    | 09-Nov-17 | 03:18 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4457.0     | 532136    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4457.0     | 48808     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4457.0     | 161968    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4457.0     | 126128    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4457.0     | 106152    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4457.0     | 5959336   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420272   | 09-Nov-17 | 03:14 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420784   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4421296   | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420784   | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4421296   | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4421296   | 09-Nov-17 | 03:18 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420776   | 09-Nov-17 | 03:16 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4421808   | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420272   | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4457.0     | 4420776   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4457.0     | 10885800  | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4457.0     | 98992     | 09-Nov-17 | 03:14 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4457.0     | 72872     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4457.0     | 5951144   | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4457.0     | 245936    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4457.0     | 298152    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4457.0     | 208560    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 44712     | 09-Nov-17 | 03:14 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48816     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48808     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48808     | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 52912     | 09-Nov-17 | 03:17 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48816     | 09-Nov-17 | 03:18 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48808     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 52904     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 44712     | 09-Nov-17 | 03:19 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4457.0     | 48816     | 09-Nov-17 | 03:15 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4457.0     | 509096    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4457.0 | 391856    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4457.0 | 396976    | 09-Nov-17 | 03:21 | x86      |
| Msmdlocal.dll                                             | 2015.130.4457.0 | 37083824  | 09-Nov-17 | 03:16 | x86      |
| Msmdlocal.dll                                             | 2015.130.4457.0 | 56190640  | 09-Nov-17 | 03:20 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4457.0 | 6507688   | 09-Nov-17 | 03:17 | x86      |
| Msmgdsrv.dll                                              | 2015.130.4457.0 | 7507112   | 09-Nov-17 | 03:24 | x64      |
| Msolap130.dll                                             | 2015.130.4457.0 | 7007408   | 09-Nov-17 | 03:16 | x86      |
| Msolap130.dll                                             | 2015.130.4457.0 | 8638640   | 09-Nov-17 | 03:20 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4457.0     | 84656     | 09-Nov-17 | 03:24 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4457.0     | 2543792   | 09-Nov-17 | 03:24 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4457.0 | 114352    | 09-Nov-17 | 03:17 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4457.0 | 108720    | 09-Nov-17 | 03:24 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.4457.0 | 98984     | 09-Nov-17 | 03:24 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4457.0     | 2708656   | 09-Nov-17 | 03:24 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 868016    | 09-Nov-17 | 03:14 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872104    | 09-Nov-17 | 03:14 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872112    | 09-Nov-17 | 03:17 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872104    | 09-Nov-17 | 03:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 876208    | 09-Nov-17 | 03:19 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872104    | 09-Nov-17 | 03:20 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872104    | 09-Nov-17 | 03:15 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 880304    | 09-Nov-17 | 03:15 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 868008    | 09-Nov-17 | 03:18 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4457.0     | 872104    | 09-Nov-17 | 03:17 | x86      |
| Rsconfigtool.exe                                          | 13.0.4457.0     | 1405608   | 09-Nov-17 | 03:14 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Sqlrsos.dll                                               | 2015.130.4457.0 | 26280     | 09-Nov-17 | 03:14 | x64      |
| Xmsrv.dll                                                 | 2015.130.4457.0 | 24041136  | 09-Nov-17 | 03:14 | x64      |
| Xmsrv.dll                                                 | 2015.130.4457.0 | 32718000  | 09-Nov-17 | 03:16 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4457.0     | 23728     | 09-Nov-17 | 03:24 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                    |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                         | 2015.130.4457.0 | 2631856   | 09-Nov-17 | 03:15 | x86      |
| Dts.dll                                         | 2015.130.4457.0 | 3145392   | 09-Nov-17 | 03:20 | x64      |
| Dtswizard.exe                                   | 13.0.4457.0     | 896168    | 09-Nov-17 | 03:14 | x86      |
| Dtswizard.exe                                   | 13.0.4457.0     | 895664    | 09-Nov-17 | 03:14 | x64      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4457.0     | 1313456   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4457.0     | 696488    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4457.0     | 763568    | 09-Nov-17 | 03:20 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4457.0 | 2023080   | 09-Nov-17 | 03:20 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4457.0     | 72360     | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4457.0     | 186544    | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4457.0     | 433840    | 09-Nov-17 | 03:15 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4457.0     | 433840    | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4457.0     | 2044592   | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4457.0     | 2044584   | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4457.0     | 33448     | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4457.0     | 33456     | 09-Nov-17 | 03:21 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4457.0     | 249512    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4457.0     | 249512    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4457.0     | 501936    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:16 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4457.0     | 606376    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4457.0     | 106152    | 09-Nov-17 | 03:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4457.0 | 138928    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4457.0 | 150192    | 09-Nov-17 | 03:17 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4457.0 | 144560    | 09-Nov-17 | 03:14 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4457.0 | 158896    | 09-Nov-17 | 03:17 | x64      |
| Msmdlocal.dll                                   | 2015.130.4457.0 | 37083824  | 09-Nov-17 | 03:16 | x86      |
| Msmdlocal.dll                                   | 2015.130.4457.0 | 56190640  | 09-Nov-17 | 03:20 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4457.0 | 6507688   | 09-Nov-17 | 03:17 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4457.0 | 7507112   | 09-Nov-17 | 03:24 | x64      |
| Msolap130.dll                                   | 2015.130.4457.0 | 7007408   | 09-Nov-17 | 03:16 | x86      |
| Msolap130.dll                                   | 2015.130.4457.0 | 8638640   | 09-Nov-17 | 03:20 | x64      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4457.0 | 100528    | 09-Nov-17 | 03:20 | x64      |
| Xe.dll                                          | 2015.130.4457.0 | 558768    | 09-Nov-17 | 03:17 | x86      |
| Xe.dll                                          | 2015.130.4457.0 | 626352    | 09-Nov-17 | 03:20 | x64      |
| Xmsrv.dll                                       | 2015.130.4457.0 | 24041136  | 09-Nov-17 | 03:14 | x64      |
| Xmsrv.dll                                       | 2015.130.4457.0 | 32718000  | 09-Nov-17 | 03:16 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
