---
title: Cumulative update 8 for SQL Server 2019 (KB4577194)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 8 (KB4577194).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4577194
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4577194 - Cumulative Update 8 for SQL Server 2019

_Release Date:_ &nbsp; October 01  
_Version:_ &nbsp; 15.0.4073.23

## Summary

This article describes Cumulative Update package 8 (CU8) for Microsoft SQL Server 2019. This update contains 28 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 7, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4073.23**, file version: **2019.150.4073.23**
- Analysis Services - Product version: **15.0.34.27**, file version: **2018.150.34.27**

## Known issues in this update

**SQL Server 2019 CU8 contains the fix for the reliability issue that affected SQL Server 2019 CU7.**

If you applied Microsoft SQL Server 2019 CU7, and you're using the database snapshot feature explicitly together with the "`CREATE DATABASE … AS SNAPSHOT OF`" syntax, please recreate the snapshot after you apply CU8.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13680555">[13680555](#13680555)</a> | Fixed an unexpected error that occurs when you deploy a 1500 compatibility mode model with relationship and Direct Query mode `ON`. </br></br>An unexpected error occurred (file '\<FileName>', line \<LineNumber>, function '\<FunctionName>') | Analysis Services | Analysis Services | Windows |
| <a id="13696226">[13696226](#13696226)</a> | SSAS Multidimensional deployment mode may encounter Access Violation (AV) upon Excel grouping with Create Session cube followed by `MDSCHEMA_MEMBERS`. AV exception may occur many times that SSAS may reach the maximum exception limit and eventually terminate. | Analysis Services | Analysis Services | Windows |
| <a id="13714531">[13714531](#13714531)</a> | Fixed an issue in SQL Server Analysis Services to allow users to use `AVERAGE` function with extension columns. | Analysis Services | Analysis Services | Windows |
| <a id="13598903">[13598903](#13598903)</a> | Fixed long package execution time involving SSIS task of type `TransferSqlServerObjectsTask` when database contains tens of thousands of tables and the db user isn't `db_owner`. | Integration Services | Tasks_Components | Windows |
| <a id="13659834">[13659834](#13659834)</a> | Fixed Web UI Explorer display issue in SQL Server 2019 Master Data Services (MDS) in which the column width remains constant irrespective of any display width configured at attribute level. | Master Data Services | Client | Windows |
| <a id="13697891">[13697891](#13697891)</a> | Fixed Master Data Services (MDS) Filter for Business Rule Validation which doesn't show a reason for failure after 'x' number of records. | Master Data Services | Client | Windows |
| <a id="13671396">[13671396](#13671396)</a> | XEvent `sqlsni.sni_trace` doesn't fire unless `sqlsni.trace` is enabled in SQL Server 2019. | SQL Server Connectivity | Protocols | Windows |
| <a id="13679282">[13679282](#13679282)</a> | [Improvement: Availability Group listener without the load balancer in SQL Server 2019 (KB4578579)](https://support.microsoft.com/help/4578579) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13703114">[13703114](#13703114)</a> | [FIX: Deadlock occurs between Availability Group Configuration and Replica Transport State Lock in SQL Server 2019 (KB4580413)](https://support.microsoft.com/help/4580413) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13703115">[13703115](#13703115)</a> | This change improves external lease renew time for `EXTERNAL` cluster type in SQL Server 2019. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13708440">[13708440](#13708440)</a> | Fixed issue where `ALTER AVAILABILITY GROUP SET (ROLE=SECONDARY)` raises an error 41104. However, it doesn't impact the Always On Availability Group health. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13703025">[13703025](#13703025)</a> | [FIX: Incorrect results occur when you run INSERT INTO SELECT statement on memory-optimized table variables in SQL Server 2016 (KB4580397)](https://support.microsoft.com/help/4580397) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13695986">[13695986](#13695986)</a> | When an extended event that outputs a query plan is enabled, execution of a natively compiled stored procedure incorrectly included actual execution plan information in the output, which could cause errors if the client application doesn't expect such output. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13644860">[13644860](#13644860)</a> | [FIX: SQL Server 2019 service fails to start in Linux operating system (KB4582558)](https://support.microsoft.com/help/4582558) | SQL Server Engine | Linux | Linux |
| <a id="13667151">[13667151](#13667151)</a> | [FIX: Joins not getting pushed down for PolyBase query that joins multiple external tables (KB4581886)](https://support.microsoft.com/help/4581886) | SQL Server Engine | PolyBase | Windows |
| <a id="13691465">[13691465](#13691465)</a> | [FIX: PolyBase processes will be started to avoid dump during provisioning in SQL Server 2019 (KB4579223)](https://support.microsoft.com/help/4579223) | SQL Server Engine | PolyBase | All |
| <a id="13693311">[13693311](#13693311)</a> | [FIX: Errors may occur or PolyBase services fail to start when you run PolyBase queries on a non-English OS (KB4580648)](https://support.microsoft.com/help/4580648) | SQL Server Engine | PolyBase | All |
| <a id="13704325">[13704325](#13704325)</a> | [FIX: PolyBase queries can now be run with EXECUTE AS impersonation context in SQL Server 2019 (KB4580639)](https://support.microsoft.com/help/4580639) | SQL Server Engine | PolyBase | All |
| <a id="13684475">[13684475](#13684475)</a> | Updated error messages to remove inconsistent use of word SQL. | SQL Server Engine | PolyBase | All |
| <a id="13624044">[13624044](#13624044)</a> | [FIX: Different result set for the same query using dm_sql_referenced_entities in SQL Server 2019 (KB4578267)](https://support.microsoft.com/help/4578267) | SQL Server Engine | Programmability | Windows |
| <a id="13642562">[13642562](#13642562)</a> | `PATINDEX` returns wrong result for non-Latin input string when you use `Latin1_General_100_BIN2_UTF8` collation. | SQL Server Engine | Programmability | All |
| <a id="13678273">[13678273](#13678273)</a> | Fixed issue where a plan doesn't get cached (no `SP:CacheInsert` in trace) when the Interleaved Execution for MSTVFs feature is used and the MSTVF contains a LOB parameter that requires a conversion. | SQL Server Engine | Programmability | Windows |
| <a id="13663200">[13663200](#13663200)</a> | Query Store scalability improvement for adhoc workloads. Query Store now imposes internal limits to the amount of memory it can use and automatically changes the operation mode to `READ-ONLY` until enough memory has been returned to the Database Engine, preventing performance issues. | SQL Server Engine | Query Store | All |
| <a id="13521037">[13521037](#13521037)</a> | [FIX: Snapshot agent fails when you create Transactional Publication with all tables and UDFs in SQL Server 2019 (KB4580949)](https://support.microsoft.com/help/4580949) | SQL Server Engine | Replication | Windows |
| <a id="13694925">[13694925](#13694925)</a> | [FIX: Severe spinlock contention occurs in SQL Server 2019 (KB4538688)](https://support.microsoft.com/help/4538688) | SQL Server Engine | SQL OS | Windows |
| <a id="13582779">[13582779](#13582779)</a> | Fixed an issue that reduced throughput and caused higher CPU when you run workloads that frequently allocate and release memory, such as XML related functions. | SQL Server Engine | SQL OS | All |
| <a id="13703268">[13703268](#13703268)</a> | [FIX: SQL Server error log receives several ADR enabled/disabled messages even when ADR isn't explicitly enabled/disabled (KB4580915)](https://support.microsoft.com/help/4580915) | SQL Server Engine | Transaction Services | Windows |
| <a id="13713444">[13713444](#13713444)</a> | Fixed an issue with excessive number of informational messages in the Error log when Accelerated Database Recovery (ADR) is disabled for a database. | SQL Server Engine | Transaction Services | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU8 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/10/sqlserver2019-kb4577194-x64_a09e2537b854ae384d965e998e53ce33cdc34f16.exe)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202019) contains this SQL Server 2019 CU and previously released SQL Server 2019 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2019 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2019 Release Notes](/sql/linux/sql-server-linux-release-notes-2019).

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update for Big Data Clusters (BDC)</b></summary>

To upgrade Microsoft SQL Server 2019 Big Data Clusters (BDC) on Linux to the latest CU, see the [Big Data Clusters Deployment Guidance](/sql/big-data-cluster/deployment-guidance).

Starting in SQL Server 2019 CU1, you can perform in-place upgrades for Big Data Clusters from the production supported releases (SQL Server 2019 GDR1). For more information, see [How to upgrade SQL Server Big Data Clusters](/sql/big-data-cluster/deployment-upgrade).

For more information, see the [Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2019-KB4577194-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4577194-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4577194-x64.exe| A92DBE0A85BA9F2EBEA6DBA76AFE7B30CA689BDEA841BE44AF16FEEBCB44F1B2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.27   | 291736    | 23-Sep-20 | 16:42 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 23-Sep-20 | 16:42 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.27       | 757144    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 174488    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 198552    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 201112    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 197512    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 213896    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 196496    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 192408    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 251272    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 172936    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.27       | 195992    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.27       | 1097112   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.27       | 479640    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 53656     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 58264     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 58776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 57752     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 60824     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 57240     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 57240     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 66456     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 52632     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.27       | 57240     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16784     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16792     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16784     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 17808     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.27       | 16776     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 23-Sep-20 | 16:42 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 23-Sep-20 | 16:42 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 23-Sep-20 | 16:42 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 23-Sep-20 | 16:42 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 23-Sep-20 | 16:42 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 23-Sep-20 | 16:42 | x86      |
| Msmdctr.dll                                               | 2018.150.34.27   | 37256     | 23-Sep-20 | 16:42 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.27   | 47781264  | 23-Sep-20 | 16:42 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.27   | 66288016  | 23-Sep-20 | 16:42 | x64      |
| Msmdpump.dll                                              | 2018.150.34.27   | 10187656  | 23-Sep-20 | 16:42 | x64      |
| Msmdredir.dll                                             | 2018.150.34.27   | 7955864   | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 15768     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 15752     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 16264     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 15752     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 16280     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 16272     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 16264     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 17296     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 15768     | 23-Sep-20 | 16:42 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.27       | 15760     | 23-Sep-20 | 16:42 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.27   | 65825160  | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 832392    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1627016   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1452936   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1641864   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1607560   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1000344   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 991624    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1535888   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1520520   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 809864    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.27   | 1595288   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 831384    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1623432   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1449880   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1636760   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1603464   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 997768    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 990088    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1531784   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1516944   | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 808840    | 23-Sep-20 | 16:42 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.27   | 1590680   | 23-Sep-20 | 16:42 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.27   | 10185112  | 23-Sep-20 | 16:42 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.27   | 8277896   | 23-Sep-20 | 16:42 | x86      |
| Msolap.dll                                                | 2018.150.34.27   | 11014552  | 23-Sep-20 | 16:42 | x64      |
| Msolap.dll                                                | 2018.150.34.27   | 8607128   | 23-Sep-20 | 16:42 | x86      |
| Msolui.dll                                                | 2018.150.34.27   | 285080    | 23-Sep-20 | 16:42 | x86      |
| Msolui.dll                                                | 2018.150.34.27   | 305544    | 23-Sep-20 | 16:42 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 23-Sep-20 | 16:42 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 23-Sep-20 | 16:42 | x64      |
| Sqlboot.dll                                               | 2019.150.4073.23 | 213904    | 23-Sep-20 | 16:42 | x64      |
| Sqlceip.exe                                               | 15.0.4073.23     | 283528    | 23-Sep-20 | 16:42 | x86      |
| Sqldumper.exe                                             | 2019.150.4073.23 | 152456    | 23-Sep-20 | 16:42 | x86      |
| Sqldumper.exe                                             | 2019.150.4073.23 | 185216    | 23-Sep-20 | 16:42 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 23-Sep-20 | 16:42 | x86      |
| Tmapi.dll                                                 | 2018.150.34.27   | 6177160   | 23-Sep-20 | 16:42 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.27   | 4916632   | 23-Sep-20 | 16:42 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.27   | 1183624   | 23-Sep-20 | 16:42 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.27   | 6802312   | 23-Sep-20 | 16:42 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.27   | 26024328  | 23-Sep-20 | 16:42 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.27   | 35459480  | 23-Sep-20 | 16:42 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                       | 2019.150.4073.23 | 74640     | 23-Sep-20 | 17:00 | x86      |
| Instapi150.dll                       | 2019.150.4073.23 | 86928     | 23-Sep-20 | 17:00 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4073.23 | 86936     | 23-Sep-20 | 17:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4073.23 | 99216     | 23-Sep-20 | 17:00 | x64      |
| Msasxpress.dll                       | 2018.150.34.27   | 25992     | 23-Sep-20 | 16:45 | x86      |
| Msasxpress.dll                       | 2018.150.34.27   | 31112     | 23-Sep-20 | 16:45 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4073.23 | 74640     | 23-Sep-20 | 17:00 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4073.23 | 86920     | 23-Sep-20 | 17:00 | x64      |
| Sqldumper.exe                        | 2019.150.4073.23 | 152456    | 23-Sep-20 | 17:00 | x86      |
| Sqldumper.exe                        | 2019.150.4073.23 | 185216    | 23-Sep-20 | 17:00 | x64      |
| Sqlftacct.dll                        | 2019.150.4073.23 | 58248     | 23-Sep-20 | 17:00 | x86      |
| Sqlftacct.dll                        | 2019.150.4073.23 | 78736     | 23-Sep-20 | 17:00 | x64      |
| Sqlmanager.dll                       | 2019.150.4073.23 | 742296    | 23-Sep-20 | 17:00 | x86      |
| Sqlmanager.dll                       | 2019.150.4073.23 | 877448    | 23-Sep-20 | 17:00 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4073.23 | 377736    | 23-Sep-20 | 17:00 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4073.23 | 430992    | 23-Sep-20 | 17:00 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4073.23 | 275344    | 23-Sep-20 | 17:00 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4073.23 | 357272    | 23-Sep-20 | 17:00 | x64      |
| Svrenumapi150.dll                    | 2019.150.4073.23 | 1160080   | 23-Sep-20 | 17:00 | x64      |
| Svrenumapi150.dll                    | 2019.150.4073.23 | 910216    | 23-Sep-20 | 17:00 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4073.23 | 136080    | 23-Sep-20 | 16:42 | x86      |
| Dreplaycommon.dll     | 2019.150.4073.23 | 665480    | 23-Sep-20 | 16:42 | x86      |
| Dreplayutil.dll       | 2019.150.4073.23 | 304008    | 23-Sep-20 | 16:42 | x86      |
| Instapi150.dll        | 2019.150.4073.23 | 86928     | 23-Sep-20 | 16:42 | x64      |
| Sqlresourceloader.dll | 2019.150.4073.23 | 37768     | 23-Sep-20 | 16:42 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version   | File size |    Date   |  Time | Platform |
|:---------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4073.23 | 665480    | 23-Sep-20 | 16:43 | x86      |
| Dreplaycontroller.exe | 2019.150.4073.23 | 365448    | 23-Sep-20 | 16:43 | x86      |
| Instapi150.dll        | 2019.150.4073.23 | 86928     | 23-Sep-20 | 16:43 | x64      |
| Sqlresourceloader.dll | 2019.150.4073.23 | 37768     | 23-Sep-20 | 16:43 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4073.23 | 4652936   | 23-Sep-20 | 18:02 | x64      |
| Aetm-enclave.dll                           | 2019.150.4073.23 | 4603744   | 23-Sep-20 | 18:02 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4073.23 | 4924656   | 23-Sep-20 | 18:02 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4073.23 | 4866248   | 23-Sep-20 | 18:02 | x64      |
| Azureattest.dll                            | 10.0.18965.1000  | 255056    | 23-Sep-20 | 16:42 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000  | 97528     | 23-Sep-20 | 16:42 | x64      |
| C1.dll                                     | 19.16.27034.0    | 2438520   | 23-Sep-20 | 18:03 | x64      |
| C2.dll                                     | 19.16.27034.0    | 7239032   | 23-Sep-20 | 18:03 | x64      |
| Cl.exe                                     | 19.16.27034.0    | 424360    | 23-Sep-20 | 18:03 | x64      |
| Clui.dll                                   | 19.16.27034.0    | 541048    | 23-Sep-20 | 18:03 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4073.23 | 279432    | 23-Sep-20 | 18:03 | x64      |
| Dcexec.exe                                 | 2019.150.4073.23 | 86920     | 23-Sep-20 | 18:03 | x64      |
| Fssres.dll                                 | 2019.150.4073.23 | 95112     | 23-Sep-20 | 18:03 | x64      |
| Hadrres.dll                                | 2019.150.4073.23 | 201600    | 23-Sep-20 | 18:02 | x64      |
| Hkcompile.dll                              | 2019.150.4073.23 | 1291144   | 23-Sep-20 | 18:03 | x64      |
| Hkengine.dll                               | 2019.150.4073.23 | 5784456   | 23-Sep-20 | 18:02 | x64      |
| Hkruntime.dll                              | 2019.150.4073.23 | 181128    | 23-Sep-20 | 18:02 | x64      |
| Hktempdb.dll                               | 2019.150.4073.23 | 62344     | 23-Sep-20 | 18:02 | x64      |
| Link.exe                                   | 14.16.27034.0    | 1707936   | 23-Sep-20 | 18:03 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4073.23     | 234376    | 23-Sep-20 | 18:03 | x86      |
| Msobj140.dll                               | 14.16.27034.0    | 134008    | 23-Sep-20 | 18:03 | x64      |
| Mspdb140.dll                               | 14.16.27034.0    | 632184    | 23-Sep-20 | 18:03 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0    | 632184    | 23-Sep-20 | 18:03 | x64      |
| Msvcp140.dll                               | 14.16.27034.0    | 628200    | 23-Sep-20 | 18:03 | x64      |
| Qds.dll                                    | 2019.150.4073.23 | 1180560   | 23-Sep-20 | 18:03 | x64      |
| Rsfxft.dll                                 | 2019.150.4073.23 | 50064     | 23-Sep-20 | 18:03 | x64      |
| Secforwarder.dll                           | 2019.150.4073.23 | 78736     | 23-Sep-20 | 18:02 | x64      |
| Sqagtres.dll                               | 2019.150.4073.23 | 86928     | 23-Sep-20 | 18:03 | x64      |
| Sqlaamss.dll                               | 2019.150.4073.23 | 107400    | 23-Sep-20 | 18:03 | x64      |
| Sqlaccess.dll                              | 2019.150.4073.23 | 492424    | 23-Sep-20 | 18:02 | x64      |
| Sqlagent.exe                               | 2019.150.4073.23 | 729992    | 23-Sep-20 | 18:03 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4073.23 | 66440     | 23-Sep-20 | 18:03 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4073.23 | 78728     | 23-Sep-20 | 18:03 | x64      |
| Sqlboot.dll                                | 2019.150.4073.23 | 213904    | 23-Sep-20 | 18:02 | x64      |
| Sqlceip.exe                                | 15.0.4073.23     | 283528    | 23-Sep-20 | 18:02 | x86      |
| Sqlcmdss.dll                               | 2019.150.4073.23 | 86920     | 23-Sep-20 | 18:03 | x64      |
| Sqlctr150.dll                              | 2019.150.4073.23 | 140168    | 23-Sep-20 | 18:02 | x64      |
| Sqlctr150.dll                              | 2019.150.4073.23 | 115600    | 23-Sep-20 | 18:03 | x86      |
| Sqldk.dll                                  | 2019.150.4073.23 | 3150736   | 23-Sep-20 | 18:03 | x64      |
| Sqldtsss.dll                               | 2019.150.4073.23 | 107408    | 23-Sep-20 | 18:03 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 1586056   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3490696   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3683208   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 4146072   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 4264840   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3400600   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3568536   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 4141976   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3998608   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 4047752   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 2212760   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 2163608   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3855240   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3531672   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3998616   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3806088   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3806088   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3601304   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3486600   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 1532808   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 3892104   | 23-Sep-20 | 18:02 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4073.23 | 4014992   | 23-Sep-20 | 18:02 | x64      |
| Sqllang.dll                                | 2019.150.4073.23 | 39826320  | 23-Sep-20 | 18:02 | x64      |
| Sqlmin.dll                                 | 2019.150.4073.23 | 40357776  | 23-Sep-20 | 18:02 | x64      |
| Sqlolapss.dll                              | 2019.150.4073.23 | 103304    | 23-Sep-20 | 18:03 | x64      |
| Sqlos.dll                                  | 2019.150.4073.23 | 41872     | 23-Sep-20 | 18:02 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4073.23 | 82824     | 23-Sep-20 | 18:02 | x64      |
| Sqlrepss.dll                               | 2019.150.4073.23 | 82824     | 23-Sep-20 | 18:03 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4073.23 | 50072     | 23-Sep-20 | 18:02 | x64      |
| Sqlscm.dll                                 | 2019.150.4073.23 | 86920     | 23-Sep-20 | 18:02 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4073.23 | 37768     | 23-Sep-20 | 18:02 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4073.23 | 5792656   | 23-Sep-20 | 18:03 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4073.23 | 672648    | 23-Sep-20 | 18:02 | x64      |
| Sqlservr.exe                               | 2019.150.4073.23 | 623504    | 23-Sep-20 | 18:03 | x64      |
| Sqlsvc.dll                                 | 2019.150.4073.23 | 181128    | 23-Sep-20 | 18:02 | x64      |
| Sqltses.dll                                | 2019.150.4073.23 | 9077640   | 23-Sep-20 | 18:03 | x64      |
| Sqsrvres.dll                               | 2019.150.4073.23 | 279432    | 23-Sep-20 | 18:02 | x64      |
| Svl.dll                                    | 2019.150.4073.23 | 160656    | 23-Sep-20 | 18:02 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0    | 85992     | 23-Sep-20 | 18:03 | x64      |
| Xe.dll                                     | 2019.150.4073.23 | 721800    | 23-Sep-20 | 18:02 | x64      |
| Xpadsi.exe                                 | 2019.150.4073.23 | 115592    | 23-Sep-20 | 18:03 | x64      |
| Xplog70.dll                                | 2019.150.4073.23 | 91016     | 23-Sep-20 | 18:03 | x64      |
| Xprepl.dll                                 | 2019.150.4073.23 | 119688    | 23-Sep-20 | 18:02 | x64      |
| Xpstar.dll                                 | 2019.150.4073.23 | 471960    | 23-Sep-20 | 18:03 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                          | 2019.150.4073.23 | 263056    | 23-Sep-20 | 16:41 | x64      |
| Datacollectortasks.dll                                   | 2019.150.4073.23 | 226184    | 23-Sep-20 | 16:42 | x64      |
| Distrib.exe                                              | 2019.150.4073.23 | 234384    | 23-Sep-20 | 16:41 | x64      |
| Dteparse.dll                                             | 2019.150.4073.23 | 123792    | 23-Sep-20 | 16:41 | x64      |
| Dteparsemgd.dll                                          | 2019.150.4073.23 | 131984    | 23-Sep-20 | 16:20 | x64      |
| Dtepkg.dll                                               | 2019.150.4073.23 | 148360    | 23-Sep-20 | 16:41 | x64      |
| Dtexec.exe                                               | 2019.150.4073.23 | 71560     | 23-Sep-20 | 16:41 | x64      |
| Dts.dll                                                  | 2019.150.4073.23 | 3142536   | 23-Sep-20 | 16:41 | x64      |
| Dtscomexpreval.dll                                       | 2019.150.4073.23 | 500616    | 23-Sep-20 | 16:41 | x64      |
| Dtsconn.dll                                              | 2019.150.4073.23 | 525192    | 23-Sep-20 | 16:41 | x64      |
| Dtshost.exe                                              | 2019.150.4073.23 | 104328    | 23-Sep-20 | 16:41 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4073.23 | 566168    | 23-Sep-20 | 16:41 | x64      |
| Dtspipeline.dll                                          | 2019.150.4073.23 | 1328008   | 23-Sep-20 | 16:41 | x64      |
| Dtswizard.exe                                            | 15.0.4073.23     | 885648    | 23-Sep-20 | 16:41 | x64      |
| Dtuparse.dll                                             | 2019.150.4073.23 | 99208     | 23-Sep-20 | 16:43 | x64      |
| Dtutil.exe                                               | 2019.150.4073.23 | 147336    | 23-Sep-20 | 16:41 | x64      |
| Exceldest.dll                                            | 2019.150.4073.23 | 279440    | 23-Sep-20 | 16:41 | x64      |
| Excelsrc.dll                                             | 2019.150.4073.23 | 308104    | 23-Sep-20 | 16:41 | x64      |
| Execpackagetask.dll                                      | 2019.150.4073.23 | 185224    | 23-Sep-20 | 16:41 | x64      |
| Flatfiledest.dll                                         | 2019.150.4073.23 | 410504    | 23-Sep-20 | 16:41 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4073.23 | 426904    | 23-Sep-20 | 16:41 | x64      |
| Logread.exe                                              | 2019.150.4073.23 | 717704    | 23-Sep-20 | 16:41 | x64      |
| Mergetxt.dll                                             | 2019.150.4073.23 | 74640     | 23-Sep-20 | 16:41 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4073.23     | 58248     | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4073.23     | 390024    | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.xmltask.dll                          | 15.0.4073.23     | 156552    | 23-Sep-20 | 16:41 | x86      |
| Msdtssrvrutil.dll                                        | 2019.150.4073.23 | 111496    | 23-Sep-20 | 16:41 | x64      |
| Msgprox.dll                                              | 2019.150.4073.23 | 299928    | 23-Sep-20 | 16:41 | x64      |
| Msoledbsql.dll                                           | 2018.182.3.0     | 148432    | 23-Sep-20 | 16:41 | x64      |
| Msxmlsql.dll                                             | 2019.150.4073.23 | 1495960   | 23-Sep-20 | 16:41 | x64      |
| Oledbdest.dll                                            | 2019.150.4073.23 | 279432    | 23-Sep-20 | 16:41 | x64      |
| Oledbsrc.dll                                             | 2019.150.4073.23 | 312200    | 23-Sep-20 | 16:41 | x64      |
| Osql.exe                                                 | 2019.150.4073.23 | 91016     | 23-Sep-20 | 16:41 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4073.23 | 496520    | 23-Sep-20 | 16:41 | x64      |
| Rawdest.dll                                              | 2019.150.4073.23 | 226192    | 23-Sep-20 | 16:41 | x64      |
| Rawsource.dll                                            | 2019.150.4073.23 | 209800    | 23-Sep-20 | 16:41 | x64      |
| Rdistcom.dll                                             | 2019.150.4073.23 | 914312    | 23-Sep-20 | 16:41 | x64      |
| Recordsetdest.dll                                        | 2019.150.4073.23 | 201608    | 23-Sep-20 | 16:41 | x64      |
| Repldp.dll                                               | 2019.150.4073.23 | 312200    | 23-Sep-20 | 16:41 | x64      |
| Replerrx.dll                                             | 2019.150.4073.23 | 181136    | 23-Sep-20 | 16:41 | x64      |
| Replisapi.dll                                            | 2019.150.4073.23 | 394136    | 23-Sep-20 | 16:41 | x64      |
| Replmerg.exe                                             | 2019.150.4073.23 | 562072    | 23-Sep-20 | 16:41 | x64      |
| Replprov.dll                                             | 2019.150.4073.23 | 852872    | 23-Sep-20 | 16:41 | x64      |
| Replrec.dll                                              | 2019.150.4073.23 | 1029000   | 23-Sep-20 | 16:41 | x64      |
| Replsub.dll                                              | 2019.150.4073.23 | 471944    | 23-Sep-20 | 16:41 | x64      |
| Replsync.dll                                             | 2019.150.4073.23 | 164744    | 23-Sep-20 | 16:41 | x64      |
| Spresolv.dll                                             | 2019.150.4073.23 | 275336    | 23-Sep-20 | 16:41 | x64      |
| Sqlcmd.exe                                               | 2019.150.4073.23 | 263040    | 23-Sep-20 | 16:41 | x64      |
| Sqldiag.exe                                              | 2019.150.4073.23 | 1139608   | 23-Sep-20 | 16:41 | x64      |
| Sqldistx.dll                                             | 2019.150.4073.23 | 246664    | 23-Sep-20 | 16:41 | x64      |
| Sqllogship.exe                                           | 15.0.4073.23     | 103296    | 23-Sep-20 | 16:41 | x64      |
| Sqlmergx.dll                                             | 2019.150.4073.23 | 398224    | 23-Sep-20 | 16:41 | x64      |
| Sqlresourceloader.dll                                    | 2019.150.4073.23 | 50072     | 23-Sep-20 | 16:41 | x64      |
| Sqlresourceloader.dll                                    | 2019.150.4073.23 | 37768     | 23-Sep-20 | 16:41 | x86      |
| Sqlscm.dll                                               | 2019.150.4073.23 | 86920     | 23-Sep-20 | 16:41 | x64      |
| Sqlscm.dll                                               | 2019.150.4073.23 | 78728     | 23-Sep-20 | 16:41 | x86      |
| Sqlsvc.dll                                               | 2019.150.4073.23 | 181128    | 23-Sep-20 | 16:41 | x64      |
| Sqlsvc.dll                                               | 2019.150.4073.23 | 148376    | 23-Sep-20 | 16:41 | x86      |
| Sqltaskconnections.dll                                   | 2019.150.4073.23 | 201608    | 23-Sep-20 | 16:41 | x64      |
| Ssradd.dll                                               | 2019.150.4073.23 | 82824     | 23-Sep-20 | 16:41 | x64      |
| Ssravg.dll                                               | 2019.150.4073.23 | 82824     | 23-Sep-20 | 16:41 | x64      |
| Ssrdown.dll                                              | 2019.150.4073.23 | 74640     | 23-Sep-20 | 16:41 | x64      |
| Ssrmax.dll                                               | 2019.150.4073.23 | 82824     | 23-Sep-20 | 16:41 | x64      |
| Ssrmin.dll                                               | 2019.150.4073.23 | 82824     | 23-Sep-20 | 16:41 | x64      |
| Ssrpub.dll                                               | 2019.150.4073.23 | 74640     | 23-Sep-20 | 16:41 | x64      |
| Ssrup.dll                                                | 2019.150.4073.23 | 74632     | 23-Sep-20 | 16:41 | x64      |
| Txagg.dll                                                | 2019.150.4073.23 | 390032    | 23-Sep-20 | 16:41 | x64      |
| Txbdd.dll                                                | 2019.150.4073.23 | 189320    | 23-Sep-20 | 16:41 | x64      |
| Txdatacollector.dll                                      | 2019.150.4073.23 | 471944    | 23-Sep-20 | 16:41 | x64      |
| Txdataconvert.dll                                        | 2019.150.4073.23 | 316304    | 23-Sep-20 | 16:41 | x64      |
| Txderived.dll                                            | 2019.150.4073.23 | 639872    | 23-Sep-20 | 16:41 | x64      |
| Txlookup.dll                                             | 2019.150.4073.23 | 541576    | 23-Sep-20 | 16:41 | x64      |
| Txmerge.dll                                              | 2019.150.4073.23 | 246664    | 23-Sep-20 | 16:41 | x64      |
| Txmergejoin.dll                                          | 2019.150.4073.23 | 308104    | 23-Sep-20 | 16:41 | x64      |
| Txmulticast.dll                                          | 2019.150.4073.23 | 148360    | 23-Sep-20 | 16:41 | x64      |
| Txrowcount.dll                                           | 2019.150.4073.23 | 144272    | 23-Sep-20 | 16:41 | x64      |
| Txsort.dll                                               | 2019.150.4073.23 | 287624    | 23-Sep-20 | 16:41 | x64      |
| Txsplit.dll                                              | 2019.150.4073.23 | 623496    | 23-Sep-20 | 16:41 | x64      |
| Txunionall.dll                                           | 2019.150.4073.23 | 197512    | 23-Sep-20 | 16:41 | x64      |
| Xe.dll                                                   | 2019.150.4073.23 | 721800    | 23-Sep-20 | 16:41 | x64      |
| Xmlsub.dll                                               | 2019.150.4073.23 | 295816    | 23-Sep-20 | 16:41 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4073.23 | 91024     | 23-Sep-20 | 16:42 | x64      |
| Exthost.exe        | 2019.150.4073.23 | 238472    | 23-Sep-20 | 16:42 | x64      |
| Launchpad.exe      | 2019.150.4073.23 | 1217416   | 23-Sep-20 | 16:42 | x64      |
| Sqlsatellite.dll   | 2019.150.4073.23 | 1016728   | 23-Sep-20 | 16:42 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4073.23 | 684936    | 23-Sep-20 | 16:42 | x64      |
| Fdhost.exe     | 2019.150.4073.23 | 127896    | 23-Sep-20 | 16:42 | x64      |
| Fdlauncher.exe | 2019.150.4073.23 | 78736     | 23-Sep-20 | 16:42 | x64      |
| Sqlft150ph.dll | 2019.150.4073.23 | 91024     | 23-Sep-20 | 16:42 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4073.23 | 29576     | 23-Sep-20 | 16:44 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4073.23 | 226192    | 23-Sep-20 | 16:41 | x86      |
| Commanddest.dll                                               | 2019.150.4073.23 | 263056    | 23-Sep-20 | 16:42 | x64      |
| Dteparse.dll                                                  | 2019.150.4073.23 | 111496    | 23-Sep-20 | 16:41 | x86      |
| Dteparse.dll                                                  | 2019.150.4073.23 | 123792    | 23-Sep-20 | 16:41 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4073.23 | 131984    | 23-Sep-20 | 16:41 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4073.23 | 115600    | 23-Sep-20 | 16:41 | x86      |
| Dtepkg.dll                                                    | 2019.150.4073.23 | 131984    | 23-Sep-20 | 16:41 | x86      |
| Dtepkg.dll                                                    | 2019.150.4073.23 | 148360    | 23-Sep-20 | 16:41 | x64      |
| Dtexec.exe                                                    | 2019.150.4073.23 | 62856     | 23-Sep-20 | 16:41 | x86      |
| Dtexec.exe                                                    | 2019.150.4073.23 | 71560     | 23-Sep-20 | 16:41 | x64      |
| Dts.dll                                                       | 2019.150.4073.23 | 3142536   | 23-Sep-20 | 16:41 | x64      |
| Dts.dll                                                       | 2019.150.4073.23 | 2761608   | 23-Sep-20 | 16:42 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4073.23 | 443272    | 23-Sep-20 | 16:42 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4073.23 | 500616    | 23-Sep-20 | 16:42 | x64      |
| Dtsconn.dll                                                   | 2019.150.4073.23 | 435088    | 23-Sep-20 | 16:41 | x86      |
| Dtsconn.dll                                                   | 2019.150.4073.23 | 525192    | 23-Sep-20 | 16:42 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4073.23 | 110984    | 23-Sep-20 | 16:42 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4073.23 | 92560     | 23-Sep-20 | 16:42 | x86      |
| Dtshost.exe                                                   | 2019.150.4073.23 | 87448     | 23-Sep-20 | 16:41 | x86      |
| Dtshost.exe                                                   | 2019.150.4073.23 | 104328    | 23-Sep-20 | 16:41 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4073.23 | 553880    | 23-Sep-20 | 16:41 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4073.23 | 566168    | 23-Sep-20 | 16:41 | x64      |
| Dtspipeline.dll                                               | 2019.150.4073.23 | 1119112   | 23-Sep-20 | 16:41 | x86      |
| Dtspipeline.dll                                               | 2019.150.4073.23 | 1328008   | 23-Sep-20 | 16:43 | x64      |
| Dtswizard.exe                                                 | 15.0.4073.23     | 885648    | 23-Sep-20 | 16:42 | x64      |
| Dtswizard.exe                                                 | 15.0.4073.23     | 889728    | 23-Sep-20 | 16:42 | x86      |
| Dtuparse.dll                                                  | 2019.150.4073.23 | 86920     | 23-Sep-20 | 16:41 | x86      |
| Dtuparse.dll                                                  | 2019.150.4073.23 | 99208     | 23-Sep-20 | 16:41 | x64      |
| Dtutil.exe                                                    | 2019.150.4073.23 | 147336    | 23-Sep-20 | 16:41 | x64      |
| Dtutil.exe                                                    | 2019.150.4073.23 | 128904    | 23-Sep-20 | 16:41 | x86      |
| Exceldest.dll                                                 | 2019.150.4073.23 | 234376    | 23-Sep-20 | 16:41 | x86      |
| Exceldest.dll                                                 | 2019.150.4073.23 | 279440    | 23-Sep-20 | 16:41 | x64      |
| Excelsrc.dll                                                  | 2019.150.4073.23 | 308104    | 23-Sep-20 | 16:41 | x64      |
| Excelsrc.dll                                                  | 2019.150.4073.23 | 258952    | 23-Sep-20 | 16:42 | x86      |
| Execpackagetask.dll                                           | 2019.150.4073.23 | 185224    | 23-Sep-20 | 16:41 | x64      |
| Execpackagetask.dll                                           | 2019.150.4073.23 | 148360    | 23-Sep-20 | 16:41 | x86      |
| Flatfiledest.dll                                              | 2019.150.4073.23 | 357256    | 23-Sep-20 | 16:41 | x86      |
| Flatfiledest.dll                                              | 2019.150.4073.23 | 410504    | 23-Sep-20 | 16:41 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4073.23 | 369544    | 23-Sep-20 | 16:41 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4073.23 | 426904    | 23-Sep-20 | 16:41 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4073.23     | 119696    | 23-Sep-20 | 16:41 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4073.23     | 119688    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4073.23     | 78736     | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4073.23     | 58248     | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4073.23     | 500616    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4073.23     | 500624    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4073.23     | 390024    | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4073.23     | 58256     | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4073.23     | 140168    | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4073.23     | 140176    | 23-Sep-20 | 16:42 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4073.23     | 156552    | 23-Sep-20 | 16:41 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4073.23     | 156552    | 23-Sep-20 | 16:41 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4073.23     | 217992    | 23-Sep-20 | 16:42 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4073.23 | 111496    | 23-Sep-20 | 16:41 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4073.23 | 99208     | 23-Sep-20 | 16:41 | x86      |
| Msmdpp.dll                                                    | 2018.150.34.27   | 10062216  | 23-Sep-20 | 16:41 | x64      |
| Odbcdest.dll                                                  | 2019.150.4073.23 | 316296    | 23-Sep-20 | 16:41 | x86      |
| Odbcdest.dll                                                  | 2019.150.4073.23 | 369544    | 23-Sep-20 | 16:41 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4073.23 | 328584    | 23-Sep-20 | 16:41 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4073.23 | 381840    | 23-Sep-20 | 16:41 | x64      |
| Oledbdest.dll                                                 | 2019.150.4073.23 | 238480    | 23-Sep-20 | 16:41 | x86      |
| Oledbdest.dll                                                 | 2019.150.4073.23 | 279432    | 23-Sep-20 | 16:41 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4073.23 | 263048    | 23-Sep-20 | 16:41 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4073.23 | 312200    | 23-Sep-20 | 16:41 | x64      |
| Rawdest.dll                                                   | 2019.150.4073.23 | 189320    | 23-Sep-20 | 16:41 | x86      |
| Rawdest.dll                                                   | 2019.150.4073.23 | 226192    | 23-Sep-20 | 16:41 | x64      |
| Rawsource.dll                                                 | 2019.150.4073.23 | 177032    | 23-Sep-20 | 16:41 | x86      |
| Rawsource.dll                                                 | 2019.150.4073.23 | 209800    | 23-Sep-20 | 16:41 | x64      |
| Recordsetdest.dll                                             | 2019.150.4073.23 | 201608    | 23-Sep-20 | 16:41 | x64      |
| Recordsetdest.dll                                             | 2019.150.4073.23 | 172936    | 23-Sep-20 | 16:41 | x86      |
| Sqlceip.exe                                                   | 15.0.4073.23     | 283528    | 23-Sep-20 | 16:41 | x86      |
| Sqldest.dll                                                   | 2019.150.4073.23 | 238480    | 23-Sep-20 | 16:41 | x86      |
| Sqldest.dll                                                   | 2019.150.4073.23 | 275336    | 23-Sep-20 | 16:41 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4073.23 | 201608    | 23-Sep-20 | 16:41 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4073.23 | 168840    | 23-Sep-20 | 16:41 | x86      |
| Txagg.dll                                                     | 2019.150.4073.23 | 328600    | 23-Sep-20 | 16:41 | x86      |
| Txagg.dll                                                     | 2019.150.4073.23 | 390032    | 23-Sep-20 | 16:41 | x64      |
| Txbdd.dll                                                     | 2019.150.4073.23 | 189320    | 23-Sep-20 | 16:41 | x64      |
| Txbdd.dll                                                     | 2019.150.4073.23 | 152456    | 23-Sep-20 | 16:42 | x86      |
| Txbestmatch.dll                                               | 2019.150.4073.23 | 545680    | 23-Sep-20 | 16:41 | x86      |
| Txbestmatch.dll                                               | 2019.150.4073.23 | 652168    | 23-Sep-20 | 16:42 | x64      |
| Txcache.dll                                                   | 2019.150.4073.23 | 197520    | 23-Sep-20 | 16:41 | x64      |
| Txcache.dll                                                   | 2019.150.4073.23 | 164744    | 23-Sep-20 | 16:41 | x86      |
| Txcharmap.dll                                                 | 2019.150.4073.23 | 271256    | 23-Sep-20 | 16:41 | x86      |
| Txcharmap.dll                                                 | 2019.150.4073.23 | 312200    | 23-Sep-20 | 16:41 | x64      |
| Txcopymap.dll                                                 | 2019.150.4073.23 | 164744    | 23-Sep-20 | 16:41 | x86      |
| Txcopymap.dll                                                 | 2019.150.4073.23 | 197512    | 23-Sep-20 | 16:42 | x64      |
| Txdataconvert.dll                                             | 2019.150.4073.23 | 275336    | 23-Sep-20 | 16:41 | x86      |
| Txdataconvert.dll                                             | 2019.150.4073.23 | 316304    | 23-Sep-20 | 16:41 | x64      |
| Txderived.dll                                                 | 2019.150.4073.23 | 557960    | 23-Sep-20 | 16:41 | x86      |
| Txderived.dll                                                 | 2019.150.4073.23 | 639872    | 23-Sep-20 | 16:42 | x64      |
| Txfileextractor.dll                                           | 2019.150.4073.23 | 217992    | 23-Sep-20 | 16:41 | x64      |
| Txfileextractor.dll                                           | 2019.150.4073.23 | 181128    | 23-Sep-20 | 16:41 | x86      |
| Txfileinserter.dll                                            | 2019.150.4073.23 | 213896    | 23-Sep-20 | 16:41 | x64      |
| Txfileinserter.dll                                            | 2019.150.4073.23 | 181128    | 23-Sep-20 | 16:42 | x86      |
| Txgroupdups.dll                                               | 2019.150.4073.23 | 254864    | 23-Sep-20 | 16:41 | x86      |
| Txgroupdups.dll                                               | 2019.150.4073.23 | 312200    | 23-Sep-20 | 16:41 | x64      |
| Txlineage.dll                                                 | 2019.150.4073.23 | 127896    | 23-Sep-20 | 16:41 | x86      |
| Txlineage.dll                                                 | 2019.150.4073.23 | 152456    | 23-Sep-20 | 16:41 | x64      |
| Txlookup.dll                                                  | 2019.150.4073.23 | 541576    | 23-Sep-20 | 16:41 | x64      |
| Txlookup.dll                                                  | 2019.150.4073.23 | 467848    | 23-Sep-20 | 16:41 | x86      |
| Txmerge.dll                                                   | 2019.150.4073.23 | 201608    | 23-Sep-20 | 16:41 | x86      |
| Txmerge.dll                                                   | 2019.150.4073.23 | 246664    | 23-Sep-20 | 16:41 | x64      |
| Txmergejoin.dll                                               | 2019.150.4073.23 | 308104    | 23-Sep-20 | 16:42 | x64      |
| Txmergejoin.dll                                               | 2019.150.4073.23 | 246664    | 23-Sep-20 | 16:42 | x86      |
| Txmulticast.dll                                               | 2019.150.4073.23 | 115600    | 23-Sep-20 | 16:41 | x86      |
| Txmulticast.dll                                               | 2019.150.4073.23 | 148360    | 23-Sep-20 | 16:41 | x64      |
| Txpivot.dll                                                   | 2019.150.4073.23 | 205704    | 23-Sep-20 | 16:41 | x86      |
| Txpivot.dll                                                   | 2019.150.4073.23 | 238472    | 23-Sep-20 | 16:41 | x64      |
| Txrowcount.dll                                                | 2019.150.4073.23 | 115592    | 23-Sep-20 | 16:41 | x86      |
| Txrowcount.dll                                                | 2019.150.4073.23 | 144272    | 23-Sep-20 | 16:41 | x64      |
| Txsampling.dll                                                | 2019.150.4073.23 | 193416    | 23-Sep-20 | 16:41 | x64      |
| Txsampling.dll                                                | 2019.150.4073.23 | 156552    | 23-Sep-20 | 16:41 | x86      |
| Txscd.dll                                                     | 2019.150.4073.23 | 197512    | 23-Sep-20 | 16:41 | x86      |
| Txscd.dll                                                     | 2019.150.4073.23 | 234376    | 23-Sep-20 | 16:41 | x64      |
| Txsort.dll                                                    | 2019.150.4073.23 | 230280    | 23-Sep-20 | 16:41 | x86      |
| Txsort.dll                                                    | 2019.150.4073.23 | 287624    | 23-Sep-20 | 16:41 | x64      |
| Txsplit.dll                                                   | 2019.150.4073.23 | 623496    | 23-Sep-20 | 16:41 | x64      |
| Txsplit.dll                                                   | 2019.150.4073.23 | 549768    | 23-Sep-20 | 16:41 | x86      |
| Txtermextraction.dll                                          | 2019.150.4073.23 | 8643472   | 23-Sep-20 | 16:41 | x86      |
| Txtermextraction.dll                                          | 2019.150.4073.23 | 8700808   | 23-Sep-20 | 16:42 | x64      |
| Txtermlookup.dll                                              | 2019.150.4073.23 | 4137864   | 23-Sep-20 | 16:41 | x86      |
| Txtermlookup.dll                                              | 2019.150.4073.23 | 4182920   | 23-Sep-20 | 16:41 | x64      |
| Txunionall.dll                                                | 2019.150.4073.23 | 197512    | 23-Sep-20 | 16:41 | x64      |
| Txunionall.dll                                                | 2019.150.4073.23 | 160656    | 23-Sep-20 | 16:42 | x86      |
| Txunpivot.dll                                                 | 2019.150.4073.23 | 181120    | 23-Sep-20 | 16:41 | x86      |
| Txunpivot.dll                                                 | 2019.150.4073.23 | 213896    | 23-Sep-20 | 16:42 | x64      |
| Xe.dll                                                        | 2019.150.4073.23 | 631696    | 23-Sep-20 | 16:41 | x86      |
| Xe.dll                                                        | 2019.150.4073.23 | 721800    | 23-Sep-20 | 16:41 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1883.0      | 551840    | 23-Sep-20 | 17:40 | x86      |
| Dmsnative.dll                                                        | 2018.150.1883.0  | 139160    | 23-Sep-20 | 17:40 | x64      |
| Dwengineservice.dll                                                  | 15.0.1883.0      | 43920     | 23-Sep-20 | 17:40 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008       | 17142672  | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003       | 146304    | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108        | 2365520   | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272       | 2199120   | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272       | 144976    | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217        | 2408016   | 23-Sep-20 | 17:40 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39         | 2928720   | 23-Sep-20 | 17:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109768  | 23-Sep-20 | 17:40 | x64      |
| Icudt58.dll                                                          | 58.2.0.0         | 27109832  | 23-Sep-20 | 17:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2425288   | 23-Sep-20 | 17:40 | x64      |
| Icuin58.dll                                                          | 58.2.0.0         | 2431880   | 23-Sep-20 | 17:40 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124        | 15488080  | 23-Sep-20 | 17:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1775048   | 23-Sep-20 | 17:40 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0         | 1783688   | 23-Sep-20 | 17:40 | x64      |
| Instapi150.dll                                                       | 2019.150.4073.23 | 86928     | 23-Sep-20 | 17:40 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10         | 2620304   | 23-Sep-20 | 17:40 | x64      |
| Libcrypto                                                            | 1.1.1.4          | 2953680   | 23-Sep-20 | 17:40 | x64      |
| Libsasl.dll                                                          | 2.1.26.0         | 292224    | 23-Sep-20 | 17:40 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10         | 648080    | 23-Sep-20 | 17:40 | x64      |
| Libssl                                                               | 1.1.1.4          | 798160    | 23-Sep-20 | 17:40 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1883.0      | 66464     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1883.0      | 292256    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1883.0      | 1951120   | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1883.0      | 169376    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1883.0      | 634784    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1883.0      | 243608    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1883.0      | 137632    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1883.0      | 78752     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1883.0      | 50080     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1883.0      | 87440     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1883.0      | 1128352   | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1883.0      | 79776     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1883.0      | 69520     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1883.0      | 34208     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1883.0      | 30112     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1883.0      | 45456     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1883.0      | 20384     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1883.0      | 25488     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1883.0      | 130464    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1883.0      | 85408     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1883.0      | 99744     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1883.0      | 291744    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 118688    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 137104    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 140192    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 136600    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 149392    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 138640    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 133008    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 175520    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 116120    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1883.0      | 135072    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1883.0      | 71584     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1883.0      | 20880     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1883.0      | 36256     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1883.0      | 127904    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1883.0      | 3049368   | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1883.0      | 3952536   | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 117152    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 132000    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 136592    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 132512    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 147360    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 133016    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 129440    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 169888    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 114080    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1883.0      | 130976    | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1883.0      | 66456     | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1883.0      | 2681240   | 23-Sep-20 | 17:40 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1883.0      | 2435472   | 23-Sep-20 | 17:40 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4073.23 | 451464    | 23-Sep-20 | 17:40 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4073.23 | 7385992   | 23-Sep-20 | 17:40 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1     | 2016120   | 23-Sep-20 | 17:40 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1     | 720792    | 23-Sep-20 | 17:40 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1     | 138136    | 23-Sep-20 | 17:40 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1     | 175000    | 23-Sep-20 | 17:40 | x64      |
| Saslplain.dll                                                        | 2.1.26.0         | 170880    | 23-Sep-20 | 17:40 | x64      |
| Secforwarder.dll                                                     | 2019.150.4073.23 | 78736     | 23-Sep-20 | 17:40 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1883.0  | 60312     | 23-Sep-20 | 17:40 | x64      |
| Sqldk.dll                                                            | 2019.150.4073.23 | 3150736   | 23-Sep-20 | 17:40 | x64      |
| Sqldumper.exe                                                        | 2019.150.4073.23 | 185216    | 23-Sep-20 | 17:40 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 1586056   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 4146072   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 3400600   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 4141976   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 4047752   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 2212760   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 2163608   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 3806088   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 3806088   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 1532808   | 23-Sep-20 | 16:53 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4073.23 | 4014992   | 23-Sep-20 | 16:53 | x64      |
| Sqlos.dll                                                            | 2019.150.4073.23 | 41872     | 23-Sep-20 | 17:40 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1883.0  | 4840336   | 23-Sep-20 | 17:40 | x64      |
| Sqltses.dll                                                          | 2019.150.4073.23 | 9077640   | 23-Sep-20 | 17:40 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078     | 14995920  | 23-Sep-20 | 17:40 | x64      |
| Terasso.dll                                                          | 16.20.0.13       | 2158896   | 23-Sep-20 | 17:40 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0         | 281472    | 23-Sep-20 | 17:40 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4073.23 | 29592     | 23-Sep-20 | 16:43 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File name                         |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                              | 2019.150.4073.23 | 1631112   | 23-Sep-20 | 17:25 | x86      |
| Dtaengine.exe                                              | 2019.150.4073.23 | 217992    | 23-Sep-20 | 17:25 | x86      |
| Dteparse.dll                                               | 2019.150.4073.23 | 111496    | 23-Sep-20 | 17:25 | x86      |
| Dteparse.dll                                               | 2019.150.4073.23 | 123792    | 23-Sep-20 | 17:25 | x64      |
| Dteparsemgd.dll                                            | 2019.150.4073.23 | 115600    | 23-Sep-20 | 17:25 | x86      |
| Dteparsemgd.dll                                            | 2019.150.4073.23 | 131984    | 23-Sep-20 | 17:25 | x64      |
| Dtepkg.dll                                                 | 2019.150.4073.23 | 131984    | 23-Sep-20 | 17:25 | x86      |
| Dtepkg.dll                                                 | 2019.150.4073.23 | 148360    | 23-Sep-20 | 17:25 | x64      |
| Dtexec.exe                                                 | 2019.150.4073.23 | 62856     | 23-Sep-20 | 17:25 | x86      |
| Dtexec.exe                                                 | 2019.150.4073.23 | 71560     | 23-Sep-20 | 17:25 | x64      |
| Dts.dll                                                    | 2019.150.4073.23 | 2761608   | 23-Sep-20 | 17:25 | x86      |
| Dts.dll                                                    | 2019.150.4073.23 | 3142536   | 23-Sep-20 | 17:25 | x64      |
| Dtscomexpreval.dll                                         | 2019.150.4073.23 | 443272    | 23-Sep-20 | 17:25 | x86      |
| Dtscomexpreval.dll                                         | 2019.150.4073.23 | 500616    | 23-Sep-20 | 17:25 | x64      |
| Dtsconn.dll                                                | 2019.150.4073.23 | 435088    | 23-Sep-20 | 17:25 | x86      |
| Dtsconn.dll                                                | 2019.150.4073.23 | 525192    | 23-Sep-20 | 17:25 | x64      |
| Dtshost.exe                                                | 2019.150.4073.23 | 104328    | 23-Sep-20 | 17:25 | x64      |
| Dtshost.exe                                                | 2019.150.4073.23 | 87448     | 23-Sep-20 | 17:25 | x86      |
| Dtsmsg150.dll                                              | 2019.150.4073.23 | 553880    | 23-Sep-20 | 17:25 | x86      |
| Dtsmsg150.dll                                              | 2019.150.4073.23 | 566168    | 23-Sep-20 | 17:25 | x64      |
| Dtspipeline.dll                                            | 2019.150.4073.23 | 1119112   | 23-Sep-20 | 17:25 | x86      |
| Dtspipeline.dll                                            | 2019.150.4073.23 | 1328008   | 23-Sep-20 | 17:25 | x64      |
| Dtswizard.exe                                              | 15.0.4073.23     | 885648    | 23-Sep-20 | 17:25 | x64      |
| Dtswizard.exe                                              | 15.0.4073.23     | 889728    | 23-Sep-20 | 17:25 | x86      |
| Dtuparse.dll                                               | 2019.150.4073.23 | 86920     | 23-Sep-20 | 17:25 | x86      |
| Dtuparse.dll                                               | 2019.150.4073.23 | 99208     | 23-Sep-20 | 17:25 | x64      |
| Dtutil.exe                                                 | 2019.150.4073.23 | 128904    | 23-Sep-20 | 17:25 | x86      |
| Dtutil.exe                                                 | 2019.150.4073.23 | 147336    | 23-Sep-20 | 17:25 | x64      |
| Exceldest.dll                                              | 2019.150.4073.23 | 234376    | 23-Sep-20 | 17:25 | x86      |
| Exceldest.dll                                              | 2019.150.4073.23 | 279440    | 23-Sep-20 | 17:25 | x64      |
| Excelsrc.dll                                               | 2019.150.4073.23 | 258952    | 23-Sep-20 | 17:25 | x86      |
| Excelsrc.dll                                               | 2019.150.4073.23 | 308104    | 23-Sep-20 | 17:25 | x64      |
| Flatfiledest.dll                                           | 2019.150.4073.23 | 357256    | 23-Sep-20 | 17:25 | x86      |
| Flatfiledest.dll                                           | 2019.150.4073.23 | 410504    | 23-Sep-20 | 17:25 | x64      |
| Flatfilesrc.dll                                            | 2019.150.4073.23 | 369544    | 23-Sep-20 | 17:25 | x86      |
| Flatfilesrc.dll                                            | 2019.150.4073.23 | 426904    | 23-Sep-20 | 17:25 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 15.0.4073.23     | 78728     | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 15.0.4073.23     | 402328    | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 15.0.4073.23     | 402312    | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 15.0.4073.23     | 2999184   | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 15.0.4073.23     | 2999176   | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4073.23     | 58256     | 23-Sep-20 | 17:25 | x86      |
| Microsoft.sqlserver.olapenum.dll                           | 15.0.18181.0     | 99760     | 23-Sep-20 | 17:25 | x86      |
| Msdtssrvrutil.dll                                          | 2019.150.4073.23 | 111496    | 23-Sep-20 | 17:25 | x64      |
| Msdtssrvrutil.dll                                          | 2019.150.4073.23 | 99208     | 23-Sep-20 | 17:25 | x86      |
| Msmgdsrv.dll                                               | 2018.150.34.27   | 8277896   | 23-Sep-20 | 16:45 | x86      |
| Oledbdest.dll                                              | 2019.150.4073.23 | 238480    | 23-Sep-20 | 17:25 | x86      |
| Oledbdest.dll                                              | 2019.150.4073.23 | 279432    | 23-Sep-20 | 17:25 | x64      |
| Oledbsrc.dll                                               | 2019.150.4073.23 | 263048    | 23-Sep-20 | 17:25 | x86      |
| Oledbsrc.dll                                               | 2019.150.4073.23 | 312200    | 23-Sep-20 | 17:25 | x64      |
| Sqlresourceloader.dll                                      | 2019.150.4073.23 | 50072     | 23-Sep-20 | 17:25 | x64      |
| Sqlresourceloader.dll                                      | 2019.150.4073.23 | 37768     | 23-Sep-20 | 17:25 | x86      |
| Sqlscm.dll                                                 | 2019.150.4073.23 | 78728     | 23-Sep-20 | 17:25 | x86      |
| Sqlscm.dll                                                 | 2019.150.4073.23 | 86920     | 23-Sep-20 | 17:25 | x64      |
| Sqlsvc.dll                                                 | 2019.150.4073.23 | 148376    | 23-Sep-20 | 17:25 | x86      |
| Sqlsvc.dll                                                 | 2019.150.4073.23 | 181128    | 23-Sep-20 | 17:25 | x64      |
| Sqltaskconnections.dll                                     | 2019.150.4073.23 | 168840    | 23-Sep-20 | 17:25 | x86      |
| Sqltaskconnections.dll                                     | 2019.150.4073.23 | 201608    | 23-Sep-20 | 17:25 | x64      |
| Txdataconvert.dll                                          | 2019.150.4073.23 | 275336    | 23-Sep-20 | 17:25 | x86      |
| Txdataconvert.dll                                          | 2019.150.4073.23 | 316304    | 23-Sep-20 | 17:25 | x64      |
| Xe.dll                                                     | 2019.150.4073.23 | 631696    | 23-Sep-20 | 17:25 | x86      |
| Xe.dll                                                     | 2019.150.4073.23 | 721800    | 23-Sep-20 | 17:25 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2019.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this cumulative update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides the following important information.

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Hybrid environment deployment</b></summary>

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

SQL Server CUs are currently multilingual. Therefore, this CU package isn't specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2019**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
