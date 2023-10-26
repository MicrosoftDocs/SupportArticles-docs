---
title: Cumulative update 5 for SQL Server 2016 SP1 (KB4040714)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 Service Pack 1 (SP1) cumulative update 5 (KB4040714).
ms.date: 10/26/2023
ms.custom: KB4040714
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
- SQL Server 2016 Web
- SQL Server 2016 Express
- SQL Server 2016 Business Intelligence
- SQL Server 2016 Service Pack 1
---

# KB4040714 - Cumulative Update 5 for SQL Server 2016 SP1

_Release Date:_ &nbsp; September 18, 2017  
_Version:_ &nbsp; 13.0.4451.0

This article describes cumulative update package 5 (build number: **13.0.4451.0**) for Microsoft SQL Server 2016 Service Pack 1 (SP1). This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016 SP1.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=10365499>[10365499](#10365499)</a> | [FIX: "Ambiguous paths" error when deploying tabular model database to Analysis Services in SQL Server 2016 (KB4040085)](https://support.microsoft.com/help/4040085) | Analysis Services |
| <a id=10665155>[10665155](#10665155)</a> | [FIX: A memory leak may occur when you perform Process Update operations in SSAS 2014 or 2016 (KB4033789)](https://support.microsoft.com/help/4033789) | Analysis Services |
| <a id=10682272>[10682272](#10682272)</a> | [FIX: SSAS 2014 or 2016 crashes when you execute an MDX query that refers to a calculated member which is a child member of another hierarchy (KB4022753)](https://support.microsoft.com/help/4022753) | Analysis Services |
| <a id=10988063>[10988063](#10988063)</a> | FIX: Change Data Capture functionality doesn't work in SQL Server (KB4038932) | Change Data Capture |
| <a id=10682297>[10682297](#10682297)</a> | [FIX: Excel crashes when you save a workbook as a PDF file by using the Adobe Acrobat PDFMaker add-in if the MDS add-in for Excel in SQL Server 2014 or 2016 is also installed (KB4022895)](https://support.microsoft.com/help/4022895) | Data Quality Services (DQS) |
| <a id=10682310>[10682310](#10682310)</a> | [FIX: Expanding the Entities folder on the Manage Groups page takes a long time in SQL Server 2016 MDS (KB4023865)](https://support.microsoft.com/help/4023865) | Data Quality Services (DQS) |
| <a id=10762336>[10762336](#10762336)</a> | [FIX: "An unknown error" for "Show More Members" on Entity Dependencies explorer page in SQL Server 2016 Master Data Services (KB4042962)](https://support.microsoft.com/help/4042962) | Data Quality Services (DQS) |
| <a id=10682313>[10682313](#10682313)</a> | FIX: Load data from staging tables takes a much longer time to finish when recursive hierarchy is used in SQL Server 2016 Master Data Services (KB4043103) | Data Quality Services (DQS) |
| <a id=10331946>[10331946](#10331946)</a> | [FIX: Database mirroring failover fails with error 3456 in SQL Server 2016 (KB4042251)](https://support.microsoft.com/help/4042251) | High Availability |
| <a id=10357715>[10357715](#10357715)</a> | [FIX: Automatic seeding in Availability Groups randomly causes error 41169 in SQL Server 2016 (KB4040519)](https://support.microsoft.com/help/4040519) | High Availability |
| <a id=10407522>[10407522](#10407522)</a> | [FIX: Access violation occurs when you query the sys.availability_groups catalog view in SQL Server 2016 (KB4037435)](https://support.microsoft.com/help/4037435) | High Availability |
| <a id=10729324>[10729324](#10729324)</a> | [FIX: Fails to resume a suspended availability database after a write error in SQL Server 2014 or 2016 (KB4022935)](https://support.microsoft.com/help/4022935) | High Availability |
| <a id=10686654>[10686654](#10686654)</a> | [FIX: Performance drop when using In-Memory OLTP with Always On availability groups in SQL Server 2016 (KB4039868)](https://support.microsoft.com/help/4039868) | In-Memory OLTP |
| <a id=10755057>[10755057](#10755057)</a> | [FIX: Incorrect behavior when you use memory-optimized tables with "where exists" statement in SQL Server 2016 (KB4039776)](https://support.microsoft.com/help/4039776) | In-Memory OLTP |
| <a id=10713456>[10713456](#10713456)</a> | [FIX: SSIS package that contains German umlauts characters fails on execution after Incremental Package Deployment in SQL Server 2016 (KB4038590)](https://support.microsoft.com/help/4038590) | Integration Services |
| <a id=10988055>[10988055](#10988055)</a> | [FIX: CDC components in SSIS don't function in SQL Server after a cumulative update is applied (KB4053693)](https://support.microsoft.com/help/4053693) | Integration Services |
| <a id=10661031>[10661031](#10661031)</a> | [FIX: Log chain break in the "managed_backup.fn_available_backups" table in SQL Server 2016 (KB4040530)](https://support.microsoft.com/help/4040530) | Management Tools |
| <a id=10682260>[10682260](#10682260)</a> | [FIX: Error 574 when you try to install Service Pack 2 for SQL Server 2014 (KB4023170)](https://support.microsoft.com/help/4023170) | Management Tools |
| <a id=10333557>[10333557](#10333557)</a> | [FIX: Memory spike in LSASS.EXE when you enable Basic Authentication mode in SSRS 2016 (KB4039124)](https://support.microsoft.com/help/4039124) | Reporting Services |
| <a id=10407829>[10407829](#10407829)</a> | [FIX: Horizontal scroll bar is missing from the Subscription page in SSRS 2016 web portal (KB4039126)](https://support.microsoft.com/help/4039126) | Reporting Services |
| <a id=10531816>[10531816](#10531816)</a> | [FIX: "The folder ... does not exist" error when deleting a folder in web portal of SQL Server 2016 Reporting Service (KB4039125)](https://support.microsoft.com/help/4039125) | Reporting Services |
| <a id=10657005>[10657005](#10657005)</a> | [FIX: Report Viewer Web Part doesn't allow a full vertical scrollbar after you set a specific web part height (KB4039058)](https://support.microsoft.com/help/4039058) | Reporting Services |
| <a id=10682284>[10682284](#10682284)</a> | [FIX: Unhandled exception when you export an SSRS report to a .pdf file if the page height is set to 8.5 inches in SQL Server 2014 or 2016 (KB4024563)](https://support.microsoft.com/help/4024563) | Reporting Services |
| <a id=10729321>[10729321](#10729321)</a> | FIX: Reporting Services "SortExpression" causes `rsComparisonError` when there's a NULL value in a column set as "`DataTimeOffset`" (KB4017827) | Reporting Services |
| <a id=10270914>[10270914](#10270914)</a> | [FIX: Backup of availability database via VSS-based application may fail in SQL Server 2016 (KB4040108)](https://support.microsoft.com/help/4040108) | SQL Engine |
| <a id=10571964>[10571964](#10571964)</a> | [FIX: Constraint violation error returned by the managed_backup.fn_available_backups function after you install the Cumulative Update 2 for SQL Server 2016 SP1 (KB4040531)](https://support.microsoft.com/help/4040531) | SQL Engine |
| <a id=10646166>[10646166](#10646166)</a> | [FIX: Error when you configure an Azure SQL database to subscribe to a transactional publication that contains spatial indexes in SQL Server 2016 (KB4037412)](https://support.microsoft.com/help/4037412) | SQL Engine |
| <a id=10679744>[10679744](#10679744)</a> | [FIX: Returns incorrect results when computed column is queried after installing hotfix that's described in KB 3213683 and enabling TF 176 in SQL Server 2016 (KB4040533)](https://support.microsoft.com/help/4040533) | SQL Engine |
| <a id=10682252>[10682252](#10682252)</a> | [FIX: Access violation with query to retrieve data from a clustered columnstore index in SQL Server 2014 or 2016 (KB4024184)](https://support.microsoft.com/help/4024184) | SQL Engine |
| <a id=10682268>[10682268](#10682268)</a> | [FIX: Timeout when you back up a large database to URL in SQL Server 2014 or 2016 (KB4023679)](https://support.microsoft.com/help/4023679) | SQL Engine |
| <a id=10682301>[10682301](#10682301)</a> | [FIX: "Non-yielding Scheduler" condition occurs on spinlock contention in Microsoft SQL Server 2014 or 2016 (KB4024311)](https://support.microsoft.com/help/4024311) | SQL Engine |
| <a id=10682303>[10682303](#10682303)</a> | [FIX: Unable to drop stored procedure execution article from P2P publication in SQL Server 2014 or 2016 (KB4023926)](https://support.microsoft.com/help/4023926) | SQL Engine |
| <a id=10682322>[10682322](#10682322)</a> | [FIX: Couldn't disable "change data capture" if any column is encrypted by "Always Encrypted" feature of SQL Server 2016 (KB4034376)](https://support.microsoft.com/help/4034376) | SQL Engine |
| <a id=10716344>[10716344](#10716344)</a> | [FIX: Access violation occurs when a DDL trigger is raised by the CREATE EXTERNAL TABLE command in SQL Server 2016 (KB4039966)](https://support.microsoft.com/help/4039966) | SQL Engine |
| <a id=10739035>[10739035](#10739035)</a> | [FIX: SSIS package doesn't start when it's run by a CLR stored procedure whose user doesn't have SYSADMIN permissions (KB4039736)](https://support.microsoft.com/help/4039736) | SQL Engine |
| <a id=10765165>[10765165](#10765165)</a> | [FIX: SQL Server Managed Backups don't run a scheduled log backup in SQL Server 2016 (KB4040535)](https://support.microsoft.com/help/4040535) | SQL Engine |
| <a id=10775059>[10775059](#10775059)</a> | [FIX: A dump file is generated when you run a sp_execute_external_script statement in parallel mode in SQL Server 2016 (KB4040510)](https://support.microsoft.com/help/4040510) | SQL Engine |
| <a id=10817762>[10817762](#10817762)</a> | [FIX: Indirect checkpoints on the tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 (KB4040276)](https://support.microsoft.com/help/4040276) | SQL Engine |
| <a id=10821558>[10821558](#10821558)</a> | [FIX: EXCEPTION_ACCESS_VIOLATION error when you execute the sys.sp_MScdc_capture_job stored procedure in SQL Server 2016 (KB4039089)](https://support.microsoft.com/help/4039089) | SQL Engine |
| <a id=10823774>[10823774](#10823774)</a> | [FIX: Error message when you use the sp_execute_external_script stored procedure to insert data and specify @parallel value to 1 in SQL Server 2016 (KB4040539)](https://support.microsoft.com/help/4040539) | SQL Engine |
| <a id=10865719>[10865719](#10865719)</a> | [FIX: Assertion error occurs on the secondary replica when you resume a suspended availability database in SQL Server 2016 (KB4024393)](https://support.microsoft.com/help/4024393) | SQL Engine |
| <a id=10682257>[10682257](#10682257)</a> | FIX: `DBCC CHECKFILEGROUP` reports false inconsistency error 5283 on a database that contains a partitioned table in SQL Server (KB3108537) | SQL Engine |
| <a id=9900110>[9900110](#9900110)</a> | [Update to improve the performance for columnstore dynamic management views "column_store_row_groups" and "dm_db_column_store_row_group_physical_stats" in SQL Server 2016 (KB4024860)](https://support.microsoft.com/help/4024860) | SQL performance |
| <a id=10660258>[10660258](#10660258)</a> | [FIX: EXCEPTION_ACCESS_VIOLATION for query using sys.dm_os_memory_objects statement in SQL Server 2016 (KB4038113)](https://support.microsoft.com/help/4038113) | SQL performance |
| <a id=10764990>[10764990](#10764990)</a> | [FIX: Query that joins a view and contains UNION ALL slow in SQL Server 2016 (KB4040014)](https://support.microsoft.com/help/4040014) | SQL performance |

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
| Msmdsrv.rll            | 2015.130.4451.0 | 1296576   | 06-Sep-17 | 08:54 | x86      |
| Msmdsrvi.rll           | 2015.130.4451.0 | 1293512   | 06-Sep-17 | 08:54 | x86      |
| Sqlbrowser_keyfile.dll | 2015.130.4451.0 | 88776     | 06-Sep-17 | 08:54 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4451.0     | 1027272   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4451.0     | 1348808   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4451.0     | 702656    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4451.0     | 765640    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4451.0     | 520904    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4451.0     | 711872    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4451.0     | 37056     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4451.0     | 46280     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4451.0 | 72896     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4451.0     | 598728    | 06-Sep-17 | 08:56 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4451.0 | 60104     | 06-Sep-17 | 08:54 | x86      |
| Sql_common_core_keyfile.dll                 | 2015.130.4451.0 | 88776     | 06-Sep-17 | 08:54 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4451.0 | 364232    | 06-Sep-17 | 08:55 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4451.0 | 267456    | 06-Sep-17 | 08:55 | x86      |
| Sqltdiagn.dll                               | 2015.130.4451.0 | 60616     | 06-Sep-17 | 08:55 | x86      |
| Svrenumapi130.dll                           | 2015.130.4451.0 | 853696    | 06-Sep-17 | 08:55 | x86      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4451.0  | 1876672   | 06-Sep-17 | 08:56 | x86      |

SQL Server 2016 sql_tools_extensions

|                    File name                    |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                         | 2015.130.4451.0 | 2631880   | 06-Sep-17 | 08:54 | x86      |
| Dtswizard.exe                                   | 13.0.4451.0     | 896200    | 06-Sep-17 | 08:47 | x86      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4451.0     | 1313480   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4451.0     | 696512    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4451.0     | 763592    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4451.0 | 2023112   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4451.0     | 72392     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4451.0     | 186568    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4451.0     | 433856    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4451.0     | 2044616   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4451.0     | 33472     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4451.0     | 249544    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4451.0     | 501960    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4451.0     | 606408    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4451.0     | 106184    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4451.0 | 138952    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4451.0 | 144584    | 06-Sep-17 | 08:56 | x86      |
| Msmdlocal.dll                                   | 2015.130.4451.0 | 37079752  | 06-Sep-17 | 08:54 | x86      |
| Msmgdsrv.dll                                    | 2015.130.4451.0 | 6507720   | 06-Sep-17 | 08:56 | x86      |
| Msolap130.dll                                   | 2015.130.4451.0 | 7007432   | 06-Sep-17 | 08:54 | x86      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4451.0 | 88776     | 06-Sep-17 | 08:54 | x86      |
| Xe.dll                                          | 2015.130.4451.0 | 558792    | 06-Sep-17 | 08:55 | x86      |
| Xmsrv.dll                                       | 2015.130.4451.0 | 32717504  | 06-Sep-17 | 08:56 | x86      |

x64-based versions

SQL Server 2016 Browser Service

|   File name  |   File version  | File size |    Date   |  Time | Platform |
|:------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Keyfile.dll  | 2015.130.4451.0 | 88776     | 06-Sep-17 | 08:54 | x86      |
| Msmdsrv.rll  | 2015.130.4451.0 | 1296576   | 06-Sep-17 | 08:54 | x86      |
| Msmdsrvi.rll | 2015.130.4451.0 | 1293512   | 06-Sep-17 | 08:54 | x86      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlboot.dll           | 2015.130.4451.0 | 186568    | 06-Sep-17 | 08:56 | x64      |
| Sqlvdi.dll            | 2015.130.4451.0 | 168648    | 06-Sep-17 | 08:55 | x86      |
| Sqlvdi.dll            | 2015.130.4451.0 | 197312    | 06-Sep-17 | 08:55 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlwvss.dll           | 2015.130.4451.0 | 336064    | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll         | 13.0.4451.0     | 1347784   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 13.0.4451.0     | 765632    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 13.0.4451.0     | 521408    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4451.0     | 989896    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 13.0.4451.0     | 989896    | 06-Sep-17 | 08:55 | x86      |
| Msmdctr130.dll                                     | 2015.130.4451.0 | 40136     | 06-Sep-17 | 08:56 | x64      |
| Msmdlocal.dll                                      | 2015.130.4451.0 | 37079752  | 06-Sep-17 | 08:54 | x86      |
| Msmdlocal.dll                                      | 2015.130.4451.0 | 56182984  | 06-Sep-17 | 08:56 | x64      |
| Msmdsrv.exe                                        | 2015.130.4451.0 | 56727744  | 06-Sep-17 | 08:55 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4451.0 | 7507136   | 06-Sep-17 | 08:55 | x64      |
| Msmgdsrv.dll                                       | 2015.130.4451.0 | 6507720   | 06-Sep-17 | 08:56 | x86      |
| Msolap130.dll                                      | 2015.130.4451.0 | 7007432   | 06-Sep-17 | 08:54 | x86      |
| Msolap130.dll                                      | 2015.130.4451.0 | 8638656   | 06-Sep-17 | 08:56 | x64      |
| Sql_as_keyfile.dll                                 | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlboot.dll                                        | 2015.130.4451.0 | 186568    | 06-Sep-17 | 08:56 | x64      |
| Sqlceip.exe                                        | 13.0.4451.0     | 246984    | 06-Sep-17 | 08:56 | x86      |
| Tmapi.dll                                          | 2015.130.4451.0 | 4346056   | 06-Sep-17 | 08:55 | x64      |
| Tmcachemgr.dll                                     | 2015.130.4451.0 | 2826432   | 06-Sep-17 | 08:55 | x64      |
| Tmpersistence.dll                                  | 2015.130.4451.0 | 1071296   | 06-Sep-17 | 08:55 | x64      |
| Tmtransactions.dll                                 | 2015.130.4451.0 | 1352392   | 06-Sep-17 | 08:55 | x64      |
| Xe.dll                                             | 2015.130.4451.0 | 626368    | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                          | 2015.130.4451.0 | 24041160  | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                          | 2015.130.4451.0 | 32717504  | 06-Sep-17 | 08:56 | x86      |

SQL Server 2016 Database Services Common Core

|                  File name                  |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4451.0     | 1027272   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.adomdclient.dll  | 13.0.4451.0     | 1027272   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.analysisservices.core.dll         | 13.0.4451.0     | 1348808   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.dll              | 13.0.4451.0     | 702656    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.tabular.dll      | 13.0.4451.0     | 765640    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.tabular.json.dll | 13.0.4451.0     | 520904    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4451.0     | 711872    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.xmla.dll         | 13.0.4451.0     | 711872    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.edition.dll             | 13.0.4451.0     | 37056     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.instapi.dll             | 13.0.4451.0     | 46280     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4451.0 | 75456     | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll        | 2015.130.4451.0 | 72896     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4451.0     | 598728    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.wizardframework.dll     | 13.0.4451.0     | 598728    | 06-Sep-17 | 08:56 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4451.0 | 60104     | 06-Sep-17 | 08:54 | x86      |
| Pbsvcacctsync.dll                           | 2015.130.4451.0 | 72904     | 06-Sep-17 | 08:56 | x64      |
| Sql_common_core_keyfile.dll                 | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlmgmprovider.dll                          | 2015.130.4451.0 | 364232    | 06-Sep-17 | 08:55 | x86      |
| Sqlmgmprovider.dll                          | 2015.130.4451.0 | 404160    | 06-Sep-17 | 08:55 | x64      |
| Sqlsvcsync.dll                              | 2015.130.4451.0 | 267456    | 06-Sep-17 | 08:55 | x86      |
| Sqlsvcsync.dll                              | 2015.130.4451.0 | 348872    | 06-Sep-17 | 08:55 | x64      |
| Sqltdiagn.dll                               | 2015.130.4451.0 | 60616     | 06-Sep-17 | 08:55 | x86      |
| Sqltdiagn.dll                               | 2015.130.4451.0 | 67784     | 06-Sep-17 | 08:55 | x64      |
| Svrenumapi130.dll                           | 2015.130.4451.0 | 853696    | 06-Sep-17 | 08:55 | x86      |
| Svrenumapi130.dll                           | 2015.130.4451.0 | 1115848   | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.infra.dll | 13.0.4451.0  | 1876672   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.ssdqs.infra.dll | 13.0.4451.0  | 1876672   | 06-Sep-17 | 08:56 | x86      |

SQL Server 2016 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 13.0.4451.0     | 41160     | 06-Sep-17 | 08:55 | x64      |
| Databasemail.exe                             | 13.0.16100.4    | 29888     | 09-Dec-16 | 01:46 | x64      |
| Fssres.dll                                   | 2015.130.4451.0 | 81600     | 06-Sep-17 | 08:56 | x64      |
| Hadrres.dll                                  | 2015.130.4451.0 | 177856    | 06-Sep-17 | 08:55 | x64      |
| Hkcompile.dll                                | 2015.130.4451.0 | 1297088   | 06-Sep-17 | 08:55 | x64      |
| Hkengine.dll                                 | 2015.130.4451.0 | 5601472   | 06-Sep-17 | 08:54 | x64      |
| Hkruntime.dll                                | 2015.130.4451.0 | 158912    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 13.0.4451.0     | 232640    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 13.0.4451.0     | 79552     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.types.dll                | 2015.130.4451.0 | 391880    | 06-Sep-17 | 08:54 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2015.130.4451.0 | 71368     | 06-Sep-17 | 08:55 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2015.130.4451.0 | 65216     | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2015.130.4451.0 | 150216    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2015.130.4451.0 | 158912    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2015.130.4451.0 | 272072    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2015.130.4451.0 | 74944     | 06-Sep-17 | 08:54 | x64      |
| Msvcp120.dll                                 | 12.0.40649.5    | 660128    | 15-May-17 | 07:43 | x64      |
| Msvcr120.dll                                 | 12.0.40649.5    | 963744    | 15-May-17 | 07:43 | x64      |
| Qds.dll                                      | 2015.130.4451.0 | 843968    | 06-Sep-17 | 08:56 | x64      |
| Rsfxft.dll                                   | 2015.130.4451.0 | 34496     | 06-Sep-17 | 08:55 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlaccess.dll                                | 2015.130.4451.0 | 462536    | 06-Sep-17 | 08:54 | x64      |
| Sqlagent.exe                                 | 2015.130.4451.0 | 565952    | 06-Sep-17 | 08:55 | x64      |
| Sqlboot.dll                                  | 2015.130.4451.0 | 186568    | 06-Sep-17 | 08:56 | x64      |
| Sqlceip.exe                                  | 13.0.4451.0     | 246984    | 06-Sep-17 | 08:56 | x86      |
| Sqldk.dll                                    | 2015.130.4451.0 | 2585792   | 06-Sep-17 | 08:56 | x64      |
| Sqllang.dll                                  | 2015.130.4451.0 | 39387328  | 06-Sep-17 | 08:56 | x64      |
| Sqlmin.dll                                   | 2015.130.4451.0 | 37539016  | 06-Sep-17 | 08:55 | x64      |
| Sqlos.dll                                    | 2015.130.4451.0 | 26304     | 06-Sep-17 | 08:55 | x64      |
| Sqlscriptdowngrade.dll                       | 2015.130.4451.0 | 27840     | 06-Sep-17 | 08:55 | x64      |
| Sqlscriptupgrade.dll                         | 2015.130.4451.0 | 5797568   | 06-Sep-17 | 08:55 | x64      |
| Sqlservr.exe                                 | 2015.130.4451.0 | 392896    | 06-Sep-17 | 08:55 | x64      |
| Sqltses.dll                                  | 2015.130.4451.0 | 8897216   | 06-Sep-17 | 08:55 | x64      |
| Sqsrvres.dll                                 | 2015.130.4451.0 | 251080    | 06-Sep-17 | 08:55 | x64      |
| Stretchcodegen.exe                           | 13.0.4451.0     | 56008     | 06-Sep-17 | 08:56 | x86      |
| Xe.dll                                       | 2015.130.4451.0 | 626368    | 06-Sep-17 | 08:55 | x64      |
| Xpstar.dll                                   | 2015.130.4451.0 | 422592    | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 Database Services Core Shared

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Bcp.exe                                                            | 2015.130.4451.0 | 120000    | 06-Sep-17 | 08:56 | x64      |
| Dts.dll                                                            | 2015.130.4451.0 | 3145416   | 06-Sep-17 | 08:56 | x64      |
| Dtswizard.exe                                                      | 13.0.4451.0     | 895680    | 06-Sep-17 | 08:56 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4451.0     | 1313480   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4451.0     | 696512    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4451.0     | 763592    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4451.0     | 54472     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4451.0     | 89792     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.ui.dll     | 13.0.4451.0     | 49864     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4451.0     | 43200     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.ui.dll    | 13.0.4451.0     | 70848     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4451.0     | 35528     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4451.0     | 73408     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.ui.dll          | 13.0.4451.0     | 63680     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4451.0     | 31424     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.odata.ui.dll               | 13.0.4451.0     | 131272    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4451.0     | 43720     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4451.0     | 57536     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4451.0     | 606400    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.management.pssnapins.dll                       | 13.0.4451.0     | 215232    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.management.sdk.scripting.dll                   | 13.0.16107.4    | 30912     | 20-Mar-17 | 23:54 | x86      |
| Microsoft.sqlserver.replication.dll                                | 2015.130.4451.0 | 1639112   | 06-Sep-17 | 08:55 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4451.0 | 150216    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4451.0 | 158912    | 06-Sep-17 | 08:54 | x64      |
| Spresolv.dll                                                       | 2015.130.4451.0 | 245440    | 06-Sep-17 | 08:56 | x64      |
| Sql_engine_core_shared_keyfile.dll                                 | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlcmd.exe                                                         | 2015.130.4451.0 | 249544    | 06-Sep-17 | 08:56 | x64      |
| Sqllogship.exe                                                     | 13.0.4451.0     | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlmergx.dll                                                       | 2015.130.4451.0 | 346816    | 06-Sep-17 | 08:55 | x64      |
| Sqlps.exe                                                          | 13.0.4451.0     | 60096     | 06-Sep-17 | 08:55 | x86      |
| Sqlwep130.dll                                                      | 2015.130.4451.0 | 105664    | 06-Sep-17 | 08:55 | x64      |
| Ssradd.dll                                                         | 2015.130.4451.0 | 65216     | 06-Sep-17 | 08:55 | x64      |
| Ssravg.dll                                                         | 2015.130.4451.0 | 65216     | 06-Sep-17 | 08:55 | x64      |
| Ssrdown.dll                                                        | 2015.130.4451.0 | 50888     | 06-Sep-17 | 08:55 | x64      |
| Ssrmax.dll                                                         | 2015.130.4451.0 | 63680     | 06-Sep-17 | 08:55 | x64      |
| Ssrmin.dll                                                         | 2015.130.4451.0 | 63688     | 06-Sep-17 | 08:55 | x64      |
| Ssrpub.dll                                                         | 2015.130.4451.0 | 51400     | 06-Sep-17 | 08:55 | x64      |
| Ssrup.dll                                                          | 2015.130.4451.0 | 50888     | 06-Sep-17 | 08:55 | x64      |
| Txdatacollector.dll                                                | 2015.130.4451.0 | 367296    | 06-Sep-17 | 08:55 | x64      |
| Xe.dll                                                             | 2015.130.4451.0 | 626368    | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.4451.0 | 1013952   | 06-Sep-17 | 08:56 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlsatellite.dll              | 2015.130.4451.0 | 837320    | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2015.130.4451.0 | 660160    | 06-Sep-17 | 08:55 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlft130ph.dll           | 2015.130.4451.0 | 58048     | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.4451.0     | 23752     | 06-Sep-17 | 08:56 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |

SQL Server 2016 Integration Services

|                              File name                             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 25-Aug-17 | 16:00 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                              | 4.0.0.89        | 77936     | 25-Aug-17 | 16:00 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 25-Aug-17 | 16:00 | x86      |
| Attunity.sqlserver.cdcsplit.dll                                    | 4.0.0.89        | 37488     | 25-Aug-17 | 16:00 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 25-Aug-17 | 16:00 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                      | 4.0.0.89        | 78448     | 25-Aug-17 | 16:00 | x86      |
| Dts.dll                                                            | 2015.130.4451.0 | 2631880   | 06-Sep-17 | 08:54 | x86      |
| Dts.dll                                                            | 2015.130.4451.0 | 3145416   | 06-Sep-17 | 08:56 | x64      |
| Dtswizard.exe                                                      | 13.0.4451.0     | 896200    | 06-Sep-17 | 08:47 | x86      |
| Dtswizard.exe                                                      | 13.0.4451.0     | 895680    | 06-Sep-17 | 08:56 | x64      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4451.0     | 440008    | 06-Sep-17 | 08:47 | x86      |
| Isdatafeedpublishingwizard.exe                                     | 13.0.4451.0     | 438976    | 06-Sep-17 | 08:56 | x64      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4451.0     | 1313480   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.core.dll                       | 13.0.4451.0     | 1313480   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4451.0     | 696512    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.dll                            | 13.0.4451.0     | 696512    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4451.0     | 763592    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll                    | 13.0.4451.0     | 763592    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.astasks.dll                                    | 13.0.4451.0     | 72392     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4451.0     | 54472     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll           | 13.0.4451.0     | 54472     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4451.0     | 89792     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll        | 13.0.4451.0     | 89800     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4451.0     | 43200     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopconnections.dll       | 13.0.4451.0     | 43208     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4451.0     | 35528     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopenumerators.dll       | 13.0.4451.0     | 35528     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4451.0     | 73408     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll             | 13.0.4451.0     | 73416     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4451.0     | 31424     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.azureutil.dll              | 13.0.4451.0     | 31432     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4451.0     | 469704    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll      | 13.0.4451.0     | 469696    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4451.0     | 43720     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.odataconnectionmanager.dll | 13.0.4451.0     | 43712     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4451.0     | 57536     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.odatasrc.dll               | 13.0.4451.0     | 57536     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4451.0     | 52928     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.integrationservices.server.shared.dll          | 13.0.4451.0     | 52936     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4451.0     | 606400    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.manageddts.dll                                 | 13.0.4451.0     | 606408    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4451.0 | 150216    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                       | 2015.130.4451.0 | 138952    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4451.0 | 158912    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.dll                                     | 2015.130.4451.0 | 144584    | 06-Sep-17 | 08:56 | x86      |
| Msdtssrvr.exe                                                      | 13.0.4451.0     | 216768    | 06-Sep-17 | 08:56 | x64      |
| Sql_is_keyfile.dll                                                 | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlceip.exe                                                        | 13.0.4451.0     | 246984    | 06-Sep-17 | 08:56 | x86      |
| Xe.dll                                                             | 2015.130.4451.0 | 558792    | 06-Sep-17 | 08:55 | x86      |
| Xe.dll                                                             | 2015.130.4451.0 | 626368    | 06-Sep-17 | 08:55 | x64      |

SQL Server 2016 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 10.0.8224.34     | 483520    | 24-Aug-17 | 18:13 | x86      |
| Dmsnative.dll                                                        | 2014.120.8224.34 | 75456     | 24-Aug-17 | 18:13 | x64      |
| Dwengineservice.dll                                                  | 10.0.8224.34     | 45760     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 10.0.8224.34     | 74432     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 10.0.8224.34     | 201920    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 10.0.8224.34     | 2347200   | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 10.0.8224.34     | 101568    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 10.0.8224.34     | 378560    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 10.0.8224.34     | 185536    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 10.0.8224.34     | 127168    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 10.0.8224.34     | 63168     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 10.0.8224.34     | 52416     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 10.0.8224.34     | 87232     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 10.0.8224.34     | 721600    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 10.0.8224.34     | 87232     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 10.0.8224.34     | 78016     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 10.0.8224.34     | 41664     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 10.0.8224.34     | 36544     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 10.0.8224.34     | 47808     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 10.0.8224.34     | 27328     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 10.0.8224.34     | 32960     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 10.0.8224.34     | 118976    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 10.0.8224.34     | 94400     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 10.0.8224.34     | 108224    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 10.0.8224.34     | 256704    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 102080    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 118976    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 115904    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 125632    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 117952    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 113344    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 145600    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 100032    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 10.0.8224.34     | 114880    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 10.0.8224.34     | 69312     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 10.0.8224.34     | 28352     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 10.0.8224.34     | 43712     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 10.0.8224.34     | 82112     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 10.0.8224.34     | 136896    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 10.0.8224.34     | 2155712   | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 10.0.8224.34     | 3818688   | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 107712    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 120000    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 124608    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 133312    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 121024    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 118464    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 152256    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 105152    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 10.0.8224.34     | 119488    | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 10.0.8224.34     | 66752     | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 10.0.8224.34     | 2756288   | 24-Aug-17 | 18:13 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 10.0.8224.34     | 752320    | 24-Aug-17 | 18:13 | x86      |
| Sharedmemory.dll                                                     | 2014.120.8224.34 | 47296     | 24-Aug-17 | 18:13 | x64      |
| Sqlsortpdw.dll                                                       | 2014.120.8224.34 | 4348096   | 24-Aug-17 | 18:13 | x64      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.4451.0     | 79048     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.4451.0     | 168648    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.4451.0     | 1620160   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.excelrendering.dll            | 13.0.4451.0     | 657608    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.4451.0     | 329928    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.4451.0     | 1070280   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532160    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532160    | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532160    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.htmlrendering.resources.dll   | 13.0.4451.0     | 532168    | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.hybrid.dll                    | 13.0.4451.0     | 48840     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.4451.0     | 161984    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.4451.0     | 126152    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.4451.0     | 106184    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.4451.0     | 5959360   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420288   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420808   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4421320   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420808   | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4421320   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4421320   | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420808   | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4421832   | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420288   | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.portal.services.resources.dll | 13.0.4451.0     | 4420800   | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.4451.0     | 10882240  | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.4451.0     | 97480     | 06-Sep-17 | 08:56 | x64      |
| Microsoft.reportingservices.powerpointrendering.dll       | 13.0.4451.0     | 72904     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.4451.0     | 5951168   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.4451.0     | 245960    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.spbprocessing.dll             | 13.0.4451.0     | 298184    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.storage.dll                   | 13.0.4451.0     | 208576    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 44736     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48840     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48832     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48832     | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 52936     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48832     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48840     | 06-Sep-17 | 08:54 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 52928     | 06-Sep-17 | 08:56 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 44744     | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.storage.resources.dll         | 13.0.4451.0     | 48840     | 06-Sep-17 | 08:57 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.4451.0     | 509120    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4451.0 | 391880    | 06-Sep-17 | 08:54 | x86      |
| Microsoft.sqlserver.types.dll                             | 2015.130.4451.0 | 396992    | 06-Sep-17 | 08:55 | x86      |
| Msmdlocal.dll                                             | 2015.130.4451.0 | 37079752  | 06-Sep-17 | 08:54 | x86      |
| Msmdlocal.dll                                             | 2015.130.4451.0 | 56182984  | 06-Sep-17 | 08:56 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4451.0 | 7507136   | 06-Sep-17 | 08:55 | x64      |
| Msmgdsrv.dll                                              | 2015.130.4451.0 | 6507720   | 06-Sep-17 | 08:56 | x86      |
| Msolap130.dll                                             | 2015.130.4451.0 | 7007432   | 06-Sep-17 | 08:54 | x86      |
| Msolap130.dll                                             | 2015.130.4451.0 | 8638656   | 06-Sep-17 | 08:56 | x64      |
| Reportingservicesemaildeliveryprovider.dll                | 13.0.4451.0     | 83656     | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceslibrary.dll                              | 13.0.4451.0     | 2543304   | 06-Sep-17 | 08:55 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.4451.0 | 108744    | 06-Sep-17 | 08:55 | x64      |
| Reportingservicesnativeclient.dll                         | 2015.130.4451.0 | 114376    | 06-Sep-17 | 08:55 | x86      |
| Reportingservicesnativeserver.dll                         | 2015.130.4451.0 | 99008     | 06-Sep-17 | 08:55 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.4451.0     | 2708672   | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 868040    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872136    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872136    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872136    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 876224    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872136    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872128    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 880320    | 06-Sep-17 | 08:54 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 868040    | 06-Sep-17 | 08:55 | x86      |
| Reportingserviceswebserver.resources.dll                  | 13.0.4451.0     | 872136    | 06-Sep-17 | 08:56 | x86      |
| Rsconfigtool.exe                                          | 13.0.4451.0     | 1405640   | 06-Sep-17 | 08:47 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Sqlrsos.dll                                               | 2015.130.4451.0 | 26304     | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                                 | 2015.130.4451.0 | 24041160  | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                                 | 2015.130.4451.0 | 32717504  | 06-Sep-17 | 08:56 | x86      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.4451.0     | 23744     | 06-Sep-17 | 08:55 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |

SQL Server 2016 sql_tools_extensions

|                    File name                    |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                         | 2015.130.4451.0 | 2631880   | 06-Sep-17 | 08:54 | x86      |
| Dts.dll                                         | 2015.130.4451.0 | 3145416   | 06-Sep-17 | 08:56 | x64      |
| Dtswizard.exe                                   | 13.0.4451.0     | 896200    | 06-Sep-17 | 08:47 | x86      |
| Dtswizard.exe                                   | 13.0.4451.0     | 895680    | 06-Sep-17 | 08:56 | x64      |
| Microsoft.analysisservices.applocal.core.dll    | 13.0.4451.0     | 1313480   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.dll         | 13.0.4451.0     | 696512    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.applocal.tabular.dll | 13.0.4451.0     | 763592    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.analysisservices.project.dll          | 2015.130.4451.0 | 2023112   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.astasks.dll                 | 13.0.4451.0     | 72392     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.astasksui.dll               | 13.0.4451.0     | 186568    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4451.0     | 433856    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll  | 13.0.4451.0     | 433864    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4451.0     | 2044616   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll       | 13.0.4451.0     | 2044608   | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4451.0     | 33472     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.configuration.sstring.dll   | 13.0.4451.0     | 33480     | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4451.0     | 249544    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.deployment.dll              | 13.0.4451.0     | 249544    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.dmquerytaskui.dll           | 13.0.4451.0     | 501960    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4451.0     | 606400    | 06-Sep-17 | 08:55 | x86      |
| Microsoft.sqlserver.manageddts.dll              | 13.0.4451.0     | 606408    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.olapenum.dll                | 13.0.4451.0     | 106184    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4451.0 | 150216    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll    | 2015.130.4451.0 | 138952    | 06-Sep-17 | 08:56 | x86      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4451.0 | 158912    | 06-Sep-17 | 08:54 | x64      |
| Microsoft.sqlserver.xevent.dll                  | 2015.130.4451.0 | 144584    | 06-Sep-17 | 08:56 | x86      |
| Msmdlocal.dll                                   | 2015.130.4451.0 | 37079752  | 06-Sep-17 | 08:54 | x86      |
| Msmdlocal.dll                                   | 2015.130.4451.0 | 56182984  | 06-Sep-17 | 08:56 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4451.0 | 7507136   | 06-Sep-17 | 08:55 | x64      |
| Msmgdsrv.dll                                    | 2015.130.4451.0 | 6507720   | 06-Sep-17 | 08:56 | x86      |
| Msolap130.dll                                   | 2015.130.4451.0 | 7007432   | 06-Sep-17 | 08:54 | x86      |
| Msolap130.dll                                   | 2015.130.4451.0 | 8638656   | 06-Sep-17 | 08:56 | x64      |
| Sql_tools_extensions_keyfile.dll                | 2015.130.4451.0 | 100552    | 06-Sep-17 | 08:56 | x64      |
| Xe.dll                                          | 2015.130.4451.0 | 558792    | 06-Sep-17 | 08:55 | x86      |
| Xe.dll                                          | 2015.130.4451.0 | 626368    | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                       | 2015.130.4451.0 | 24041160  | 06-Sep-17 | 08:55 | x64      |
| Xmsrv.dll                                       | 2015.130.4451.0 | 32717504  | 06-Sep-17 | 08:56 | x86      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
