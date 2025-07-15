---
title: Cumulative update 2 for SQL Server 2016 (KB3182270)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2016 cumulative update 2 (KB3182270).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB3182270
appliesto:
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Express
- SQL Server 2016 Standard
- SQL Server 2016 Web
---

# KB3182270 - Cumulative Update 2 for SQL Server 2016

_Release Date:_ &nbsp; September 22, 2016  
_Version:_ &nbsp; 13.0.2164.0

This article describes cumulative update package 2 (build number: **13.0.2164.0**) for Microsoft SQL Server 2016. This update contains [fixes](#improvements-and-fixes-included-in-this-update) that were released after the release of SQL Server 2016.

## Improvements and fixes included in this update

| Bug reference | Description | Fix area |
|---|---|---|
| <a id=7990669>[7990669](#7990669)</a> | [Update to add a security warning message when you schedule data refresh for PowerPivot workbooks (KB3171516)](https://support.microsoft.com/help/3171516) | Analysis Services |
| <a id=7955222>[7955222](#7955222)</a> | [Error when you use SecurityFilteringBehavior enumeration in SQL Server 2016 Analysis Services (KB3183440)](https://support.microsoft.com/help/3183440) | Analysis Services |
| <a id=7990674>[7990674](#7990674)</a> | [PivotTable connects to incorrect data source in SQL Server PowerPivot for SharePoint (KB3178541)](https://support.microsoft.com/help/3178541) | Analysis Services |
| <a id=8198024>[8198024](#8198024)</a> | [FIX: Access violation occurs when you run and then cancel a query on distinct count partitions in SSAS (KB3025408)](https://support.microsoft.com/help/3025408) | Analysis Services |
| <a id=8208291>[8208291](#8208291)</a> | [FIX: Affinity mask doesn't work correctly for NUMA nodes in SQL Server 2016 Analysis Services (KB3187549)](https://support.microsoft.com/help/3187549) | Analysis Services |
| <a id=8208296>[8208296](#8208296)</a> | [FIX: DISCOVER_TABLE_STORAGE_COLUMN_SEGMENTS DMV returns an incorrect result of memory usage in SQL Server 2016 (KB3187493)](https://support.microsoft.com/help/3187493) | Analysis Services |
| <a id=8275709>[8275709](#8275709)</a> | [Standard edition of SQL Server 2016 Analysis Services (Tabular mode) ignores the 16 GB memory limit (KB3189060)](https://support.microsoft.com/help/3189060) | Analysis Services |
| <a id=8208448>[8208448](#8208448)</a> | Update to add support for the Analyze in Excel feature for some regions in Power BI (KB3187654) | Analysis Services |
| <a id=7762097>[7762097](#7762097)</a> | IntelliSense feature displays incomplete or incorrect information for the AMO library (KB3189055) | Analysis Services |
| <a id=8263466>[8263466](#8263466)</a> | Adds some changes to managed engine client libraries support SSAS in Azure. | Analysis Services |
| <a id=7990723>[7990723](#7990723)</a> | [FIX: SQL Server failover cluster diagnostic log doesn't accurately reflect the failure_condition_level setting (KB3170051)](https://support.microsoft.com/help/3170051) | High Availability |
| <a id=8198017>[8198017](#8198017)</a> | [FIX: Queries that run against secondary databases always get recompiled in SQL Server (KB3181444)](https://support.microsoft.com/help/3181444) | High Availability |
| <a id=8258545>[8258545](#8258545)</a> | [FIX: Access violation on secondary replica when there are too many parallel redo operations in SQL Server 2016 (KB3188368)](https://support.microsoft.com/help/3188368) | High Availability |
| <a id=7990651>[7990651](#7990651)</a> | [FIX: "'Salt' attribute for OraPassword is missing" error in SSIS in SQL Server 2012 or 2014 (KB3156452)](https://support.microsoft.com/help/3156452) | Integration Services |
| <a id=7990660>[7990660](#7990660)</a> | [FIX: A valid derived column expression may fail in SSIS 2012, 2014 and 2016 (KB3164404)](https://support.microsoft.com/help/3164404) | Integration Services |
| <a id=8198000>[8198000](#8198000)</a> | [An access violation occurs when you execute two parent packages that run the same child package in parallel in SQL Server 2014 or 2016 (KB3168740)](https://support.microsoft.com/help/3168740) | Integration Services |
| <a id=7855159>[7855159](#7855159)</a> | [FIX: Retention policy doesn't work when you use SQL Server Managed Backup to Windows Azure in SQL Server 2014 or 2016 (KB3168707)](https://support.microsoft.com/help/3168707) | Management Tools |
| <a id=7779870>[7779870](#7779870)</a> | [FIX: "The service is not available" error when you use SSRS 2016 Portal after you disconnect from the domain (KB3171505)](https://support.microsoft.com/help/3171505) | Reporting Services |
| <a id=7855195>[7855195](#7855195)</a> | [FIX: RDL report that's generated programmatically fails to run in SSRS (KB3157016)](https://support.microsoft.com/help/3157016) | Reporting Services |
| <a id=7873772>[7873772](#7873772)</a> | [Can't open a Reporting Services report from the SSRS portal when the host computer has FIPS compliance enabled (KB3184135)](https://support.microsoft.com/help/3184135) | Reporting Services |
| <a id=7944505>[7944505](#7944505)</a> | [FIX: Can't print a Reporting Services report from the SSRS 2016 web portal (KB3186433)](https://support.microsoft.com/help/3186433) | Reporting Services |
| <a id=7990720>[7990720](#7990720)</a> | [FIX: Shared data sources and stored credentials are removed by the SharePoint daily cleanup jobs in SSRS (KB3162396)](https://support.microsoft.com/help/3162396) | Reporting Services |
| <a id=8045133>[8045133](#8045133)</a> | ["The connection string is not valid" error occurs when you use a data source of type Microsoft SharePoint List in SQL Server 2016 Reporting Services (KB3183721)](https://support.microsoft.com/help/3183721) | Reporting Services |
| <a id=8073582>[8073582](#8073582)</a> | [FIX: SQL Server 2016 Database Mail doesn't work on a computer that doesn't have the .NET Framework 3.5 installed (KB3186435)](https://support.microsoft.com/help/3186435) | Reporting Services |
| <a id=8197974>[8197974](#8197974)</a> | [The file size of the PDF file generated by SSRS 2014 or 2016 is larger when compared to the earlier versions of SQL Server (KB3161403)](https://support.microsoft.com/help/3161403) | Reporting Services |
| <a id=8198030>[8198030](#8198030)</a> | [FIX: The "MSRS 2014 Windows Service: Active Session" counter incorrectly displays a very high value for SSRS 2014 or 2016 (KB3176993)](https://support.microsoft.com/help/3176993) | Reporting Services |
| <a id=8204190>[8204190](#8204190)</a> | [Data grid becomes blank when you scroll if the "Row numbers" option is set to Hide in a SQL Server 2016 Reporting Services mobile report (KB3192636)](https://support.microsoft.com/help/3192636) | Reporting Services |
| <a id=8258377>[8258377](#8258377)</a> | [Can't filter the mobile report correctly when the parameter contains special characters in SQL Server 2016 Reporting Services (KB3191515)](https://support.microsoft.com/help/3191515) | Reporting Services |
| <a id=7855169>[7855169](#7855169)</a> | FIX: Incorrect page numbers are displayed when you export an SSRS report to PDF or TIFF format (KB3160427) | Reporting Services |
| <a id=7990694>[7990694](#7990694)</a> | FIX: Can't create or manage data alert for a report if the report name or folder name contains a comma in SSRS (KB3177666) | Reporting Services |
| <a id=8048420>[8048420](#8048420)</a> | FIX: Duplicate mobile reports and KPIs are displayed in Power BI Mobile app (KB3188980) | Reporting Services |
| <a id=7990714>[7990714](#7990714)</a> | [FIX: Truncation errors when you use bcp command to import data from large text files on a Chinese version of Windows (KB3166545)](https://support.microsoft.com/help/3166545) | SQL connectivity |
| <a id=8198027>[8198027](#8198027)</a> | [An error occurs when you use ODBC driver to retrieve sql_variant data in SQL Server 2014 or 2016 (KB3178526)](https://support.microsoft.com/help/3178526) | SQL connectivity |
| <a id=7381655>[7381655](#7381655)</a> | `Sys.dm_db_index_operational_stats` may return incorrect value for `range_scan_count`. | SQL Engine |
| <a id=7765668>[7765668](#7765668)</a> | [FIX: High CPU usage causes performance issues in SQL Server 2016 (KB3195888)](https://support.microsoft.com/help/3195888) | SQL performance |
| <a id=8086115>[8086115](#8086115)</a> | [FIX: "Cannot bulk load" error when you run a query that contains an UPDATE statement in SQL Server 2016 (KB3188978)](https://support.microsoft.com/help/3188978) | SQL performance |
| <a id=8197993>[8197993](#8197993)</a> | [FIX: Query runs slowly when SQL Server uses hash aggregate in the query plan (KB3167159)](https://support.microsoft.com/help/3167159) | SQL performance |
| <a id=8208393>[8208393](#8208393)</a> | [A non-optimal query plan choice results in poor performance when values outside the range represented in statistics are searched in SQL Server 2016 (KB3192154)](https://support.microsoft.com/help/3192154) | SQL performance |
| <a id=8208458>[8208458](#8208458)</a> | [An access violation occurs when you execute a query if trace flag 4139 is enabled in SQL Server 2016 (KB3192117)](https://support.microsoft.com/help/3192117) | SQL performance |
| <a id=8275126>[8275126](#8275126)</a> | [Incorrect results are returned when you execute a query that contains a GROUP BY operation in SQL Server 2016 (KB3189264)](https://support.microsoft.com/help/3189264) | SQL performance |
| <a id=7855214>[7855214](#7855214)</a> | [FIX: An access violation occurs when you use the TDE and BPE features in SQL Server 2014 or 2016 (KB3106976)](https://support.microsoft.com/help/3106976) | SQL security |
| <a id=8058912>[8058912](#8058912)</a> | [FIX: Queries that contain recursive CROSS APPLY operations run slowly in SQL Server 2016 (KB3182868)](https://support.microsoft.com/help/3182868) | SQL security |
| <a id=8075960>[8075960](#8075960)</a> | [Error 33294 if a cursor is declared by using the OPTION (RECOMPILE) query hint in SQL Server 2016 (KB3189655)](https://support.microsoft.com/help/3189655) | SQL security |
| <a id=7504584>[7504584](#7504584)</a> | [FIX: Unable to execute FORMAT function if it's wrapped inside CLR in SQL Server (KB3165545)](https://support.microsoft.com/help/3165545) | SQL service |
| <a id=7837980>[7837980](#7837980)</a> | [FIX: Queries on Stretch Database enabled databases always involve a network round-trip to Azure in SQL Server 2016 (KB3174812)](https://support.microsoft.com/help/3174812) | SQL service |
| <a id=7855174>[7855174](#7855174)</a> | [FIX: Change tracking cleanup task fails if another database is offline in SQL Server 2014 or 2016 (KB3161119)](https://support.microsoft.com/help/3161119) | SQL service |
| <a id=7855176>[7855176](#7855176)</a> | [FIX: Service Broker UCS task leaks memory in SQL Server 2014 or 2016 (KB3154482)](https://support.microsoft.com/help/3154482) | SQL service |
| <a id=7855179>[7855179](#7855179)</a> | [FIX: High CPU usage on SQL queries after you install SQL Server (KB3162589)](https://support.microsoft.com/help/3162589) | SQL service |
| <a id=7855184>[7855184](#7855184)</a> | [SQL Server doesn't start after you configure the tempdb database to use a very small log file (KB3168709)](https://support.microsoft.com/help/3168709) | SQL service |
| <a id=7855191>[7855191](#7855191)</a> | [FIX: CONTEXT_INFO returns incorrect values when context_info ends with two trailing zeros in SQL Server 2014 or 2016 (KB3168710)](https://support.microsoft.com/help/3168710) | SQL service |
| <a id=7989907>[7989907](#7989907)</a> | [FIX: Access violation occurs when executing a query that contains many COUNT DISTINCT operations in SQL Server 2016 (KB3185650)](https://support.microsoft.com/help/3185650) | SQL service |
| <a id=7990705>[7990705](#7990705)</a> | [FIX: SQL Server crashes when you run a remote query in a stored procedure by using an invalid user name (KB3070382)](https://support.microsoft.com/help/3070382) | SQL service |
| <a id=8001820>[8001820](#8001820)</a> | [FIX: "Element not found" error occurs when you browse to the FileTable database directory in SQL Server 2012 or 2016 (KB3189229)](https://support.microsoft.com/help/3189229) | SQL service |
| <a id=8037273>[8037273](#8037273)</a> | [Calculation using two measure time values in iterations returns negative values in SQL Server 2014 or 2016 (KB3181526)](https://support.microsoft.com/help/3181526) | SQL service |
| <a id=8197968>[8197968](#8197968)</a> | [Operating system error 32 when you restore a database in SQL Server 2014 or 2016 (KB3153836)](https://support.microsoft.com/help/3153836) | SQL service |
| <a id=8197977>[8197977](#8197977)</a> | [FIX: DML statements are unexpectedly replicated to the subscribers in SQL Server 2014 or 2016 (KB3176440)](https://support.microsoft.com/help/3176440) | SQL service |
| <a id=8197987>[8197987](#8197987)</a> | [Change Data Capture function fn_cdc_get_net_changes_ incorrectly returns delete and update operation rows for an update operation in SQL Server (KB3165168)](https://support.microsoft.com/help/3165168) | SQL service |
| <a id=8198014>[8198014](#8198014)</a> | [FIX: Deadlock occurs when you acquire an SCH-M lock and alter a partition in SQL Server 2014 or 2016 (KB3174476)](https://support.microsoft.com/help/3174476) | SQL service |
| <a id=8198041>[8198041](#8198041)</a> | [A memory leak occurs when you use Azure Storage in SQL Server 2014 or 2016 (KB3174370)](https://support.microsoft.com/help/3174370) | SQL service |
| <a id=8255153>[8255153](#8255153)</a> | [Updating while compression is in progress can lead to nonclustered columnstore index corruption in SQL Server 2016 (KB3188950)](https://support.microsoft.com/help/3188950) | SQL service |
| <a id=8260699>[8260699](#8260699)</a> | [Query returns incorrect results from nonclustered columnstore index under snapshot isolation level in SQL Server 2016 (KB3189372)](https://support.microsoft.com/help/3189372) | SQL service |
| <a id=8273336>[8273336](#8273336)</a> | [Query Store returns unusual characters when a JOIN operator is used in SQL Server 2016 (KB3189364)](https://support.microsoft.com/help/3189364) | SQL service |
| <a id=8291010>[8291010](#8291010)</a> | ["The remote server '(null)' does not exist" error occurs after you remove an article from a publication in SQL Server (KB3184227)](https://support.microsoft.com/help/3184227) | SQL service |
| <a id=8268335>[8268335](#8268335)</a> | Adds the support to audit the information that's collected by the SQL Server Usage Feedback Collection (KB3189276) | SQL service |
| <a id=8197990>[8197990](#8197990)</a> | "Failed Assertion = 'm_pExclusiveOwner != pWorker'" is continuously logged in the SQL Server 2014 or 2016 error log (KB3179596) | SQL service |
| <a id=8357071>[8357071](#8357071)</a> | The `rxExec` function doesn't run the `rxDataStep` function in parallel on Windows operating systems (KB3192687) | SQL service |
| | [Supports DROP TABLE DDL for articles that are included in transactional replication in SQL Server 2014 or 2016 (KB3170123)](https://support.microsoft.com/help/3170123) | SQL service |

## How to obtain this cumulative update package

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for Microsoft SQL Server 2016 now](https://www.microsoft.com/download/details.aspx?id=53338)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
> After future cumulative updates are released for SQL Server 2016, this CU can be located and downloaded from the [Microsoft Windows Update Catalog](https://catalog.update.microsoft.com/search.aspx?q=sql%20server%202016). However, Microsoft recommends that you install the latest cumulative update available.

## Notes for this update

<details>
<summary><b>Cumulative update</b></summary>

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2016 is available at the Download Center.

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

To apply this cumulative update package, you must be running SQL Server 2016.

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

SQL Server 2016 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2164.0     | 1023176   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2164.0     | 1344200   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2164.0     | 702664    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2164.0     | 765640    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2164.0     | 707272    | 10-Sep-16 | 04:17 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2164.0 | 88776     | 10-Sep-16 | 04:19 | x86      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2164.0  | 473288    | 10-Sep-16 | 04:17 | x86      |

SQL Server 2016 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2164.0 | 2631880   | 10-Sep-16 | 04:19 | x86      |
| Dtspipeline.dll                                              | 2015.130.2164.0 | 1059528   | 10-Sep-16 | 04:19 | x86      |
| Dtswizard.exe                                                | 13.0.2164.0     | 895680    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2164.0     | 432840    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2164.0     | 2043592   | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2164.0     | 250056    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2164.0     | 33984     | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:19 | x86      |
| Msmdlocal.dll                                                | 2015.130.2164.0 | 37009600  | 10-Sep-16 | 04:20 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2164.0 | 6499528   | 10-Sep-16 | 04:17 | x86      |
| Msolap130.dll                                                | 2015.130.2164.0 | 6962888   | 10-Sep-16 | 04:20 | x86      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2164.0 | 88776     | 10-Sep-16 | 04:19 | x86      |
| Xmsrv.dll                                                    | 2015.130.2164.0 | 32693448  | 10-Sep-16 | 04:19 | x86      |

x64-based versions

SQL Server 2016 Business Intelligence Development Studio

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlsqm_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Writer

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Sqlboot.dll           | 2015.130.2164.0 | 186568    | 10-Sep-16 | 04:20 | x64      |
| Sqlwriter_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Analysis Services

|                   File name                   |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll    | 13.0.2164.0     | 1343688   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.server.tabular.dll | 13.0.2164.0     | 765640    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.data.edm.netfx35.dll                | 5.7.0.62516     | 667872    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.data.mashup.dll                     | 2.35.4399.541   | 186592    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 15-Jun-16 | 12:32 | x86      |
| Microsoft.data.odata.netfx35.dll              | 5.7.0.62516     | 1461464   | 16-Jun-16 | 11:34 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.data.odata.query.netfx35.dll        | 5.7.0.62516     | 188128    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 15-Jun-16 | 12:32 | x64      |
| Microsoft.mashup.container.exe                | 2.35.4399.541   | 27872     | 16-Jun-16 | 11:34 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:32 | x64      |
| Microsoft.mashup.container.netfx40.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 11:34 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 15-Jun-16 | 12:32 | x64      |
| Microsoft.mashup.container.netfx45.exe        | 2.35.4399.541   | 28384     | 16-Jun-16 | 11:34 | x64      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.mashup.eventsource.dll              | 2.35.4399.541   | 159456    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 15-Jun-16 | 12:32 | x86      |
| Microsoft.mashup.oauth.dll                    | 2.35.4399.541   | 63200     | 16-Jun-16 | 11:34 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll   | 1.0.0.0         | 143072    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 15-Jun-16 | 12:32 | x86      |
| Microsoft.mashupengine.dll                    | 2.35.4399.541   | 5652704   | 16-Jun-16 | 11:34 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 15-Jun-16 | 12:32 | x86      |
| Microsoft.odata.core.netfx35.dll              | 6.15.0.0        | 1444576   | 16-Jun-16 | 11:34 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.odata.edm.netfx35.dll               | 6.15.0.0        | 785632    | 16-Jun-16 | 11:34 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 15-Jun-16 | 12:32 | x86      |
| Microsoft.spatial.netfx35.dll                 | 6.15.0.0        | 133344    | 16-Jun-16 | 11:34 | x86      |
| Msmdlocal.dll                                 | 2015.130.2164.0 | 37009600  | 10-Sep-16 | 04:20 | x86      |
| Msmdlocal.dll                                 | 2015.130.2164.0 | 56077504  | 10-Sep-16 | 04:20 | x64      |
| Msmdsrv.exe                                   | 2015.130.2164.0 | 56623304  | 10-Sep-16 | 04:17 | x64      |
| Msmgdsrv.dll                                  | 2015.130.2164.0 | 6499528   | 10-Sep-16 | 04:17 | x86      |
| Msmgdsrv.dll                                  | 2015.130.2164.0 | 7503552   | 10-Sep-16 | 04:21 | x64      |
| Msolap130.dll                                 | 2015.130.2164.0 | 6962888   | 10-Sep-16 | 04:20 | x86      |
| Msolap130.dll                                 | 2015.130.2164.0 | 8583368   | 10-Sep-16 | 04:20 | x64      |
| Sql_as_keyfile.dll                            | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Sqlboot.dll                                   | 2015.130.2164.0 | 186568    | 10-Sep-16 | 04:20 | x64      |
| Sqlceip.exe                                   | 13.0.2164.0     | 242888    | 10-Sep-16 | 04:21 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 15-Jun-16 | 12:32 | x86      |
| System.spatial.netfx35.dll                    | 5.7.0.62516     | 124640    | 16-Jun-16 | 11:34 | x86      |
| Tmapi.dll                                     | 2015.130.2164.0 | 4344520   | 10-Sep-16 | 04:20 | x64      |
| Tmcachemgr.dll                                | 2015.130.2164.0 | 2825416   | 10-Sep-16 | 04:20 | x64      |
| Tmpersistence.dll                             | 2015.130.2164.0 | 1069768   | 10-Sep-16 | 04:20 | x64      |
| Tmtransactions.dll                            | 2015.130.2164.0 | 1348808   | 10-Sep-16 | 04:20 | x64      |
| Xmsrv.dll                                     | 2015.130.2164.0 | 32693448  | 10-Sep-16 | 04:19 | x86      |
| Xmsrv.dll                                     | 2015.130.2164.0 | 24013000  | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Database Services Common Core

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 13.0.2164.0     | 1023176   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 13.0.2164.0     | 1023176   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.core.dll        | 13.0.2164.0     | 1344200   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.dll             | 13.0.2164.0     | 702664    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.tabular.dll     | 13.0.2164.0     | 765640    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2164.0     | 707272    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.analysisservices.xmla.dll        | 13.0.2164.0     | 707272    | 10-Sep-16 | 04:17 | x86      |
| Sql_common_core_keyfile.dll                | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Data Quality

|           File name           | File version | File size |    Date   |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 13.0.2164.0  | 473288    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.ssdqs.cleansing.dll | 13.0.2164.0  | 473288    | 10-Sep-16 | 04:21 | x86      |

SQL Server 2016 Database Services Core Instance

|             File name            |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Hadrres.dll                      | 2015.130.2164.0 | 177864    | 10-Sep-16 | 04:20 | x64      |
| Hkcompile.dll                    | 2015.130.2164.0 | 1296584   | 10-Sep-16 | 04:20 | x64      |
| Hkengine.dll                     | 2015.130.2164.0 | 5596872   | 10-Sep-16 | 04:19 | x64      |
| Hkruntime.dll                    | 2015.130.2164.0 | 159432    | 10-Sep-16 | 04:19 | x64      |
| Qds.dll                          | 2015.130.2164.0 | 844992    | 10-Sep-16 | 04:20 | x64      |
| Rsfxft.dll                       | 2015.130.2164.0 | 34504     | 10-Sep-16 | 04:20 | x64      |
| Sql_engine_core_inst_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Sqlaccess.dll                    | 2015.130.2164.0 | 461512    | 10-Sep-16 | 04:21 | x64      |
| Sqlagent.exe                     | 2015.130.2164.0 | 565960    | 10-Sep-16 | 04:17 | x64      |
| Sqlboot.dll                      | 2015.130.2164.0 | 186568    | 10-Sep-16 | 04:20 | x64      |
| Sqlceip.exe                      | 13.0.2164.0     | 242888    | 10-Sep-16 | 04:21 | x86      |
| Sqldk.dll                        | 2015.130.2164.0 | 2583232   | 10-Sep-16 | 04:20 | x64      |
| Sqllang.dll                      | 2015.130.2164.0 | 39294152  | 10-Sep-16 | 04:20 | x64      |
| Sqlmin.dll                       | 2015.130.2164.0 | 37326024  | 10-Sep-16 | 04:20 | x64      |
| Sqlos.dll                        | 2015.130.2164.0 | 26312     | 10-Sep-16 | 04:20 | x64      |
| Sqlscriptdowngrade.dll           | 2015.130.2164.0 | 27848     | 10-Sep-16 | 04:20 | x64      |
| Sqlscriptupgrade.dll             | 2015.130.2164.0 | 5797064   | 10-Sep-16 | 04:20 | x64      |
| Sqlserverspatial130.dll          | 2015.130.2164.0 | 732872    | 10-Sep-16 | 04:20 | x64      |
| Sqlservr.exe                     | 2015.130.2164.0 | 392904    | 10-Sep-16 | 04:17 | x64      |
| Sqltses.dll                      | 2015.130.2164.0 | 8896712   | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2164.0 | 3145408   | 10-Sep-16 | 04:20 | x64      |
| Dtspipeline.dll                                              | 2015.130.2164.0 | 1278152   | 10-Sep-16 | 04:20 | x64      |
| Dtswizard.exe                                                | 13.0.2164.0     | 895176    | 10-Sep-16 | 04:21 | x64      |
| Logread.exe                                                  | 2015.130.2164.0 | 616648    | 10-Sep-16 | 04:17 | x64      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2164.0     | 33992     | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:21 | x86      |
| Repldp.dll                                                   | 2015.130.2164.0 | 276168    | 10-Sep-16 | 04:20 | x64      |
| Sql_engine_core_shared_keyfile.dll                           | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2015.130.2164.0 | 1012936   | 10-Sep-16 | 04:20 | x64      |
| Sql_extensibility_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Sqlsatellite.dll              | 2015.130.2164.0 | 836808    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Mswb7.dll                | 14.0.4763.1000  | 331672    | 23-Apr-15 | 02:40 | x64      |
| Prm0007.bin              | 14.0.4763.1000  | 11602944  | 23-Apr-15 | 02:40 | x64      |
| Prm0009.bin              | 14.0.4763.1000  | 5739008   | 23-Apr-15 | 02:40 | x64      |
| Prm0013.bin              | 14.0.4763.1000  | 9482240   | 23-Apr-15 | 02:40 | x64      |
| Sql_fulltext_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 13.0.2164.0     | 23752     | 10-Sep-16 | 04:17 | x86      |
| Sql_inst_mr_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                       | 2015.130.2164.0 | 2631880   | 10-Sep-16 | 04:19 | x86      |
| Dts.dll                                                       | 2015.130.2164.0 | 3145408   | 10-Sep-16 | 04:20 | x64      |
| Dtspipeline.dll                                               | 2015.130.2164.0 | 1059528   | 10-Sep-16 | 04:19 | x86      |
| Dtspipeline.dll                                               | 2015.130.2164.0 | 1278152   | 10-Sep-16 | 04:20 | x64      |
| Dtswizard.exe                                                 | 13.0.2164.0     | 895680    | 10-Sep-16 | 04:17 | x86      |
| Dtswizard.exe                                                 | 13.0.2164.0     | 895176    | 10-Sep-16 | 04:21 | x64      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2164.0     | 469704    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 13.0.2164.0     | 469704    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2164.0     | 33984     | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 13.0.2164.0     | 33992     | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                   | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:21 | x86      |
| Msdtssrvr.exe                                                 | 13.0.2164.0     | 216776    | 10-Sep-16 | 04:21 | x64      |
| Sql_is_keyfile.dll                                            | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Sqlceip.exe                                                   | 13.0.2164.0     | 242888    | 10-Sep-16 | 04:21 | x86      |

SQL Server 2016 Reporting Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.reportingservices.authorization.dll             | 13.0.2164.0     | 79048     | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.dataextensions.xmlaclient.dll | 13.0.2164.0     | 567496    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.datarendering.dll             | 13.0.2164.0     | 166080    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.diagnostics.dll               | 13.0.2164.0     | 1620672   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.hpbprocessing.dll             | 13.0.2164.0     | 329416    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.htmlrendering.dll             | 13.0.2164.0     | 1069256   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.imagerendering.dll            | 13.0.2164.0     | 161992    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2164.0     | 76480     | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.interfaces.dll                | 13.0.2164.0     | 76488     | 10-Sep-16 | 04:21 | x86      |
| Microsoft.reportingservices.portal.interfaces.dll         | 13.0.2164.0     | 122568    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.portal.odatawebapi.dll        | 13.0.2164.0     | 104128    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.portal.services.dll           | 13.0.2164.0     | 4904136   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.portal.web.dll                | 13.0.2164.0     | 9644232   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.portal.webhost.exe            | 13.0.2164.0     | 92872     | 10-Sep-16 | 04:21 | x64      |
| Microsoft.reportingservices.processingcore.dll            | 13.0.2164.0     | 5951176   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.sharepoint.server.dll         | 13.0.2164.0     | 245960    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.reportingservices.upgradescripts.dll            | 13.0.2164.0     | 500936    | 10-Sep-16 | 04:17 | x86      |
| Msmdlocal.dll                                             | 2015.130.2164.0 | 37009600  | 10-Sep-16 | 04:20 | x86      |
| Msmdlocal.dll                                             | 2015.130.2164.0 | 56077504  | 10-Sep-16 | 04:20 | x64      |
| Msmgdsrv.dll                                              | 2015.130.2164.0 | 6499528   | 10-Sep-16 | 04:17 | x86      |
| Msmgdsrv.dll                                              | 2015.130.2164.0 | 7503552   | 10-Sep-16 | 04:21 | x64      |
| Msolap130.dll                                             | 2015.130.2164.0 | 6962888   | 10-Sep-16 | 04:20 | x86      |
| Msolap130.dll                                             | 2015.130.2164.0 | 8583368   | 10-Sep-16 | 04:20 | x64      |
| Reportingserviceslibrary.dll                              | 13.0.2164.0     | 2518208   | 10-Sep-16 | 04:21 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2164.0 | 114376    | 10-Sep-16 | 04:17 | x86      |
| Reportingservicesnativeclient.dll                         | 2015.130.2164.0 | 108736    | 10-Sep-16 | 04:21 | x64      |
| Reportingservicesnativeserver.dll                         | 2015.130.2164.0 | 99016     | 10-Sep-16 | 04:21 | x64      |
| Reportingserviceswebserver.dll                            | 13.0.2164.0     | 2697920   | 10-Sep-16 | 04:21 | x86      |
| Sql_rs_keyfile.dll                                        | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2164.0 | 732872    | 10-Sep-16 | 04:20 | x64      |
| Sqlserverspatial130.dll                                   | 2015.130.2164.0 | 584392    | 10-Sep-16 | 04:20 | x86      |
| Xmsrv.dll                                                 | 2015.130.2164.0 | 32693448  | 10-Sep-16 | 04:19 | x86      |
| Xmsrv.dll                                                 | 2015.130.2164.0 | 24013000  | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 13.0.2164.0     | 23744     | 10-Sep-16 | 04:21 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |

SQL Server 2016 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                      | 2015.130.2164.0 | 2631880   | 10-Sep-16 | 04:19 | x86      |
| Dts.dll                                                      | 2015.130.2164.0 | 3145408   | 10-Sep-16 | 04:20 | x64      |
| Dtspipeline.dll                                              | 2015.130.2164.0 | 1059528   | 10-Sep-16 | 04:19 | x86      |
| Dtspipeline.dll                                              | 2015.130.2164.0 | 1278152   | 10-Sep-16 | 04:20 | x64      |
| Dtswizard.exe                                                | 13.0.2164.0     | 895680    | 10-Sep-16 | 04:17 | x86      |
| Dtswizard.exe                                                | 13.0.2164.0     | 895176    | 10-Sep-16 | 04:21 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2164.0     | 432840    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 13.0.2164.0     | 432840    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2164.0     | 2043592   | 10-Sep-16 | 04:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 13.0.2164.0     | 2043592   | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2164.0     | 250056    | 10-Sep-16 | 04:17 | x86      |
| Microsoft.sqlserver.deployment.dll                           | 13.0.2164.0     | 250056    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2164.0     | 33984     | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 13.0.2164.0     | 33992     | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                           | 13.0.2164.0     | 606408    | 10-Sep-16 | 04:21 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:19 | x86      |
| Microsoft.sqlserver.packageformatupdate.dll                  | 13.0.2164.0     | 445128    | 10-Sep-16 | 04:21 | x86      |
| Msmdlocal.dll                                                | 2015.130.2164.0 | 37009600  | 10-Sep-16 | 04:20 | x86      |
| Msmdlocal.dll                                                | 2015.130.2164.0 | 56077504  | 10-Sep-16 | 04:20 | x64      |
| Msmgdsrv.dll                                                 | 2015.130.2164.0 | 6499528   | 10-Sep-16 | 04:17 | x86      |
| Msmgdsrv.dll                                                 | 2015.130.2164.0 | 7503552   | 10-Sep-16 | 04:21 | x64      |
| Msolap130.dll                                                | 2015.130.2164.0 | 6962888   | 10-Sep-16 | 04:20 | x86      |
| Msolap130.dll                                                | 2015.130.2164.0 | 8583368   | 10-Sep-16 | 04:20 | x64      |
| Sql_tools_extensions_keyfile.dll                             | 2015.130.2164.0 | 100552    | 10-Sep-16 | 04:20 | x64      |
| Xmsrv.dll                                                    | 2015.130.2164.0 | 32693448  | 10-Sep-16 | 04:19 | x86      |
| Xmsrv.dll                                                    | 2015.130.2164.0 | 24013000  | 10-Sep-16 | 04:20 | x64      |

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [How to obtain the latest service pack for SQL Server 2016](https://support.microsoft.com/help/3177534)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
