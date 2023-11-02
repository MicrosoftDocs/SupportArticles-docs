---
title: Cumulative Update 3 for SQL Server 2019 (KB4538853)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 3 (KB4538853).
ms.date: 06/30/2023
ms.custom: KB4538853
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4538853 - Cumulative Update 3 for SQL Server 2019

_Release Date:_ &nbsp; March 12, 2020  
_Version:_ &nbsp; 15.0.4023.6

## Summary

This article describes Cumulative Update package 3 (CU3) for Microsoft SQL Server 2019. This update contains 23 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 2, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4023.6**, file version: **2019.150.4023.6**
- Analysis Services - Product version: **15.0.34.9**, file version: **2018.150.34.9**

## Known issues in this update

There's a known uninstallation issue that affects this SQL Server 2019 CU3 under certain circumstances. If you uninstall this CU, SQL Server doesn't come online, and you find the following SQL Server error log entry:

> The script level for 'system_xevents_modification.sql' in database 'master' cannot be downgraded from *XXXXXXXXX* to *XXXXXXXXX*, which is supported by this server. This usually implies that a future database was attached and the downgrade path is not supported by the current installation. Install a newer version of SQL Server and re-try opening the database.

To mitigate this issue, enable Trace Flag - T902 to bring SQL Server online. You don't have to uninstall the program again. To upgrade to a new CU, you must first remove this flag.

SQL Server 2019 CU5 or any later CU release contains the fix.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13410674">[13410674](#13410674)</a> | [FIX: ISDBUpgradeWizard.exe throws error when you try to upgrade SSISDB after restoring from earlier versions in SQL Server 2019 (KB4547890)](https://support.microsoft.com/help/4547890) | Integration Services | DTS | Windows |
| <a id="13410658">[13410658](#13410658)</a> | Allow DTSWizard to support Microsoft Entra ID when the selected driver is MSOLEDBSQL. | Integration Services | Integration Services | Windows |
| <a id="13405530">[13405530](#13405530)</a> | "The JSON DDL request is missing the database name" error occurs when you delete the database property from the descriptive table under the JSON code in SQL Server 2019. | Openness and Interoperability | Protocols | Windows |
| <a id="13378659">[13378659](#13378659)</a> | [FIX: sp_execute_external_script doesn't run when you install SQL Server 2019 with Machine Learning Services and a customized Shared feature directory (KB4540121)](https://support.microsoft.com/help/4540121) | SQL Server Engine | Extensibility | Windows |
| <a id="13404121">[13404121](#13404121)</a> | [FIX: Fail to access openmpi path when running rx jobs in parallel mode with Revo package in Linux SQL Server 2019 (KB4548131)](https://support.microsoft.com/help/4548131) | SQL Server Engine | Extensibility | Linux |
| <a id="13411046">[13411046](#13411046)</a> | [FIX: Data length/size of Unicode nvarchar data type column is not correct for OutputDataSet in sp_execute_external_script query in SQL Server 2019 on Linux (KB4548133)](https://support.microsoft.com/help/4548131) | SQL Server Engine | Extensibility | Linux |
| <a id="13412450">[13412450](#13412450)</a> | [FIX: Launchpad services fails to start during failover in SQL Server 2019 (KB4539172)](https://support.microsoft.com/help/4539172) | SQL Server Engine | Extensibility | Windows |
| <a id="13395279">[13395279](#13395279)</a> | Updates the Zulu JRE version to `zulu11.37.18-sa-jre11.0.6`. | SQL Server Engine | Extensibility | All |
| <a id="13403957">[13403957](#13403957)</a> | Updates RSetup with the updated FWLINK version 3.5.2.293. | SQL Server Engine | Extensibility | Windows |
| <a id="13412437">[13412437](#13412437)</a> |  Updates to SQL Server on Linux (mssql mlservices and extensibility) packages to address following issues: </br></br>1. BxlServer consumes 100% CPU. </br>2. Python launcher encounters assert when deleting files. </br>3. Data length mismatch when using Unicode string with `OutputDataSet` and `InputDataSet` of data passthrough query. | SQL Server Engine | Extensibility | Linux |
| <a id="13429278">[13429278](#13429278)</a> | [FIX: Error occurs when you interact with SQL Server Agent in SQL Server 2019 (KB4550657)](https://support.microsoft.com/help/4550657) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13209410">[13209410](#13209410)</a> | SQL Server error log contains additional empty lines while printing In-memory OLTP related messages. | SQL Server Engine | In-memory OLTP | All |
| <a id="13357974">[13357974](#13357974)</a> | Due to a new feature called concurrent PFS update in SQL Server 2019 which is enabled by default, in certain rare corner cases, you may encounter non-yielding threads and latch timeout errors in SQL Server. | SQL Server Engine | Methods to access stored data | All |
| <a id="13324032">[13324032](#13324032)</a> | [FIX: .NET Framework DbDataAdapter.FillSchema method returns NULL on database with compatibility level 140 in SQL Server 2019 and 2017 (KB4529927)](https://support.microsoft.com/help/4529927) | SQL Server Engine | Programmability | Windows |
| <a id="13350041">[13350041](#13350041)</a> | When you repeatedly run a stored procedure that uses temporary table with indexes on SQL Server 2019, the client may receive an unexpected error with message "A severe error occurred on the current command" and an access violation exception is recorded on the SQL Server. If the same workload is executed on any previous major version of SQL Server, this issue doesn't occur. | SQL Server Engine | Query Execution | Windows |
| <a id="13388147">[13388147](#13388147)</a> | When you run a query against `sys.dm_db_stats_histogram`, it may fail with access violation when a parallel plan is chosen. | SQL Server Engine | Query Execution | All |
| <a id="13360725">[13360725](#13360725)</a> | When you run a `SELECT` query returning empty/multiple rows with variable assignment in inline-able scalar UDFs, you may receive wrong results. | SQL Server Engine | Query Optimizer | Windows |
| <a id="13383620">[13383620](#13383620)</a> | This update reduces query execution time for BDC storage pool tables and other Polybase external tables. | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13321064">[13321064](#13321064)</a> | [Improvement: Enable hybrid buffer pool read caching in SQL Server 2019 (KB4538118)](https://support.microsoft.com/help/4538118) | SQL Server Engine | SQL OS | All |
| <a id="13357938">[13357938](#13357938)</a> | [Improvement: Add new Protection key feature work for SQL Server 2019 on Linux (KB4538686)](https://support.microsoft.com/help/4538686) | SQL Server Engine | SQL OS | Linux |
| <a id="13359752">[13359752](#13359752)</a> | [Improvement: Size and retention policy are increased in default XEvent trace system_health in SQL Server 2019 and 2016 (KB4541132)](https://support.microsoft.com/help/4541132) | SQL Server Engine | SQL OS | All |
| <a id="13317222">[13317222](#13317222)</a> | Enable SQL checksum sniffer for Pmm pages in hybrid buffer pool. | SQL Server Engine | SQL OS | All |
| <a id="13382004">[13382004](#13382004)</a> | [FIX: Database creation to Azure blob storage from SQL Server 2019 on Linux may fail with error (KB4548523)](https://support.microsoft.com/help/4548523) | SQL Server Engine | Storage Management | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2019 now](https://www.microsoft.com/download/details.aspx?id=100809)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2019 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU3 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/03/sqlserver2019-kb4538853-x64_e110a1af271b4e97840c713c1d8f44d159f2393e.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4538853-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4538853-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4538853-x64.exe|D76CB8E8EE60535B602194BE66500FB79EE49EC2445002EBC0F7AABCBA5FAFCD|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.34.9   | 291728    | 04-Mar-20 | 01:47 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181   | 140664    | 04-Mar-20 | 01:53 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.34.9       | 757344    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 174472    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 198752    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 201096    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 197512    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 213904    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 196488    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 192400    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 251272    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 172944    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.34.9       | 195984    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.34.9       | 1096592   | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.34.9       | 479632    | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 53648     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 58256     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 58464     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 57744     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 60816     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 57232     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 57440     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 66448     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 52856     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.34.9       | 57224     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 17808     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16776     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.34.9       | 16784     | 04-Mar-20 | 01:47 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660856    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181   | 180600    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181   | 30072     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181   | 74616     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181   | 102264    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 41848     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 28536     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 45944     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 37752     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181   | 29048     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454456   | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920680    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 23928     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25464     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 25976     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 28536     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37752     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181   | 5242744   | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181   | 19832     | 04-Mar-20 | 01:53 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181   | 19832     | 04-Mar-20 | 01:53 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181   | 19832     | 04-Mar-20 | 01:53 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181   | 149368    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181   | 82296     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15432     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15224     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 15736     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181   | 14712     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181   | 190840    | 04-Mar-20 | 01:53 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181   | 59768     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181   | 13176     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181   | 26488     | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140152    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181   | 14094200  | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 541560    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 652152    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 643960    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 627576    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 676728    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 635768    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 615288    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 848760    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 533368    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181   | 623480    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 04-Mar-20 | 01:53 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778616    | 04-Mar-20 | 01:53 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15      | 1100152   | 04-Mar-20 | 01:53 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126328    | 04-Mar-20 | 01:53 | x86      |
| Msmdctr.dll                                               | 2018.150.34.9   | 37472     | 04-Mar-20 | 01:47 | x64      |
| Msmdlocal.dll                                             | 2018.150.34.9   | 47777168  | 04-Mar-20 | 01:47 | x86      |
| Msmdlocal.dll                                             | 2018.150.34.9   | 66285456  | 04-Mar-20 | 01:47 | x64      |
| Msmdpump.dll                                              | 2018.150.34.9   | 10187872  | 04-Mar-20 | 01:47 | x64      |
| Msmdredir.dll                                             | 2018.150.34.9   | 7955344   | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 15760     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 15760     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 16272     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 15760     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 16272     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 16272     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 16272     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 17296     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 15760     | 04-Mar-20 | 01:47 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.34.9       | 15760     | 04-Mar-20 | 01:47 | x86      |
| Msmdsrv.exe                                               | 2018.150.34.9   | 65825168  | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 832608    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1627232   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1453152   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1642080   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1607776   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1000544   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 991328    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1536096   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1520736   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 810080    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrv.rll                                               | 2018.150.34.9   | 1595488   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 831584    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1623648   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1450080   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1636960   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1603680   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 998008    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 990304    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1532000   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1517152   | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 809056    | 04-Mar-20 | 01:47 | x64      |
| Msmdsrvi.rll                                              | 2018.150.34.9   | 1590672   | 04-Mar-20 | 01:47 | x64      |
| Msmgdsrv.dll                                              | 2018.150.34.9   | 8278416   | 04-Mar-20 | 01:47 | x86      |
| Msmgdsrv.dll                                              | 2018.150.34.9   | 10184824  | 04-Mar-20 | 01:47 | x64      |
| Msolap.dll                                                | 2018.150.34.9   | 8607120   | 04-Mar-20 | 01:47 | x86      |
| Msolap.dll                                                | 2018.150.34.9   | 11014776  | 04-Mar-20 | 01:47 | x64      |
| Msolui.dll                                                | 2018.150.34.9   | 285072    | 04-Mar-20 | 01:47 | x86      |
| Msolui.dll                                                | 2018.150.34.9   | 305552    | 04-Mar-20 | 01:47 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181   | 9252728   | 04-Mar-20 | 01:53 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728440    | 04-Mar-20 | 01:53 | x64      |
| Sqlceip.exe                                               | 15.0.4023.6     | 283736    | 04-Mar-20 | 01:52 | x86      |
| Sqldumper.exe                                             | 2019.150.4023.6 | 152456    | 04-Mar-20 | 01:50 | x86      |
| Sqldumper.exe                                             | 2019.150.4023.6 | 185224    | 04-Mar-20 | 01:50 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117624    | 04-Mar-20 | 01:53 | x86      |
| Tmapi.dll                                                 | 2018.150.34.9   | 6177168   | 04-Mar-20 | 01:47 | x64      |
| Tmcachemgr.dll                                            | 2018.150.34.9   | 4916624   | 04-Mar-20 | 01:47 | x64      |
| Tmpersistence.dll                                         | 2018.150.34.9   | 1183632   | 04-Mar-20 | 01:47 | x64      |
| Tmtransactions.dll                                        | 2018.150.34.9   | 6802312   | 04-Mar-20 | 01:47 | x64      |
| Xmsrv.dll                                                 | 2018.150.34.9   | 35458144  | 04-Mar-20 | 01:47 | x86      |
| Xmsrv.dll                                                 | 2018.150.34.9   | 26021264  | 04-Mar-20 | 01:47 | x64      |

SQL Server 2019 Database Services Common Core

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll | 2019.150.4023.6 | 74872     | 04-Mar-20 | 01:48 | x86      |
| Instapi150.dll | 2019.150.4023.6 | 86920     | 04-Mar-20 | 01:48 | x64      |
| Msasxpress.dll | 2018.150.34.9   | 26208     | 04-Mar-20 | 01:48 | x86      |
| Msasxpress.dll | 2018.150.34.9   | 31120     | 04-Mar-20 | 01:48 | x64      |
| Sqldumper.exe  | 2019.150.4023.6 | 185224    | 04-Mar-20 | 01:54 | x64      |
| Sqldumper.exe  | 2019.150.4023.6 | 152456    | 04-Mar-20 | 01:54 | x86      |
| Sqlmanager.dll | 2019.150.4023.6 | 873560    | 04-Mar-20 | 01:56 | x64      |
| Sqlmanager.dll | 2019.150.4023.6 | 742280    | 04-Mar-20 | 01:57 | x86      |

SQL Server 2019 sql_dreplay_client

|     File name     |   File version  | File size |    Date   |  Time | Platform |
|:-----------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll | 2019.150.4023.6 | 664968    | 04-Mar-20 | 01:55 | x86      |
| Dreplayutil.dll   | 2019.150.4023.6 | 304224    | 04-Mar-20 | 01:55 | x86      |
| Instapi150.dll    | 2019.150.4023.6 | 86920     | 04-Mar-20 | 01:51 | x64      |

SQL Server 2019 sql_dreplay_controller

|     File name     |   File version  | File size |    Date   |  Time | Platform |
|:-----------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll | 2019.150.4023.6 | 664968    | 04-Mar-20 | 01:49 | x86      |
| Instapi150.dll    | 2019.150.4023.6 | 86920     | 04-Mar-20 | 01:49 | x64      |

SQL Server 2019 Database Services Core Instance

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll     | 2019.150.4023.6 | 4652936   | 04-Mar-20 | 03:27 | x64      |
| Aetm-enclave.dll               | 2019.150.4023.6 | 4603744   | 04-Mar-20 | 03:27 | x64      |
| Aetm-sgx-enclave-simulator.dll | 2019.150.4023.6 | 4924648   | 04-Mar-20 | 03:27 | x64      |
| Aetm-sgx-enclave.dll           | 2019.150.4023.6 | 4866248   | 04-Mar-20 | 03:27 | x64      |
| Azureattest.dll                | 10.0.18965.1000 | 255056    | 04-Mar-20 | 01:45 | x64      |
| Azureattestmanager.dll         | 10.0.18965.1000 | 97528     | 04-Mar-20 | 01:45 | x64      |
| Hkcompile.dll                  | 2019.150.4023.6 | 1291352   | 04-Mar-20 | 03:27 | x64      |
| Hkengine.dll                   | 2019.150.4023.6 | 5784672   | 04-Mar-20 | 03:27 | x64      |
| Hkruntime.dll                  | 2019.150.4023.6 | 181336    | 04-Mar-20 | 03:27 | x64      |
| Hktempdb.dll                   | 2019.150.4023.6 | 62344     | 04-Mar-20 | 03:28 | x64      |
| Qds.dll                        | 2019.150.4023.6 | 1176456   | 04-Mar-20 | 03:27 | x64      |
| Rsfxft.dll                     | 2019.150.4023.6 | 50056     | 04-Mar-20 | 03:28 | x64      |
| Secforwarder.dll               | 2019.150.4023.6 | 78968     | 04-Mar-20 | 03:27 | x64      |
| Sqlaamss.dll                   | 2019.150.4023.6 | 107400    | 04-Mar-20 | 03:31 | x64      |
| Sqlaccess.dll                  | 2019.150.4023.6 | 492640    | 04-Mar-20 | 03:29 | x64      |
| Sqlagent.exe                   | 2019.150.4023.6 | 725896    | 04-Mar-20 | 03:30 | x64      |
| Sqlceip.exe                    | 15.0.4023.6     | 283736    | 04-Mar-20 | 03:27 | x86      |
| Sqlcmdss.dll                   | 2019.150.4023.6 | 86920     | 04-Mar-20 | 03:31 | x64      |
| Sqlctr150.dll                  | 2019.150.4023.6 | 140168    | 04-Mar-20 | 03:28 | x64      |
| Sqlctr150.dll                  | 2019.150.4023.6 | 115808    | 04-Mar-20 | 03:30 | x86      |
| Sqldk.dll                      | 2019.150.4023.6 | 3138440   | 04-Mar-20 | 03:28 | x64      |
| Sqldtsss.dll                   | 2019.150.4023.6 | 107616    | 04-Mar-20 | 03:31 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 1586264   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3482504   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3675016   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 4141960   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 4256864   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3396488   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3560536   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 4133984   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3990408   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 4039560   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 2208648   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 2159712   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3847048   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3523672   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3994712   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3801992   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3798104   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3593096   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3482720   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 1528712   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 3888008   | 04-Mar-20 | 03:27 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4023.6 | 4006792   | 04-Mar-20 | 03:27 | x64      |
| Sqllang.dll                    | 2019.150.4023.6 | 39527304  | 04-Mar-20 | 03:27 | x64      |
| Sqlmin.dll                     | 2019.150.4023.6 | 40138848  | 04-Mar-20 | 03:27 | x64      |
| Sqlolapss.dll                  | 2019.150.4023.6 | 103304    | 04-Mar-20 | 03:31 | x64      |
| Sqlos.dll                      | 2019.150.4023.6 | 46176     | 04-Mar-20 | 03:27 | x64      |
| Sqlpowershellss.dll            | 2019.150.4023.6 | 83032     | 04-Mar-20 | 03:32 | x64      |
| Sqlrepss.dll                   | 2019.150.4023.6 | 82824     | 04-Mar-20 | 03:33 | x64      |
| Sqlscriptdowngrade.dll         | 2019.150.4023.6 | 41864     | 04-Mar-20 | 03:28 | x64      |
| Sqlscriptupgrade.dll           | 2019.150.4023.6 | 5796744   | 04-Mar-20 | 03:27 | x64      |
| Sqlservr.exe                   | 2019.150.4023.6 | 623496    | 04-Mar-20 | 03:27 | x64      |
| Sqlsvc.dll                     | 2019.150.4023.6 | 181128    | 04-Mar-20 | 03:31 | x64      |
| Sqltses.dll                    | 2019.150.4023.6 | 9069448   | 04-Mar-20 | 03:28 | x64      |
| Svl.dll                        | 2019.150.4023.6 | 160648    | 04-Mar-20 | 03:27 | x64      |
| Xpstar.dll                     | 2019.150.4023.6 | 472152    | 04-Mar-20 | 03:30 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                  | 2019.150.4023.6 | 3142536   | 04-Mar-20 | 01:57 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4023.6 | 566152    | 04-Mar-20 | 01:45 | x64      |
| Dtspipeline.dll                                          | 2019.150.4023.6 | 1328008   | 04-Mar-20 | 01:54 | x64      |
| Dtswizard.exe                                            | 15.0.4023.6     | 885848    | 04-Mar-20 | 01:55 | x64      |
| Flatfiledest.dll                                         | 2019.150.4023.6 | 410504    | 04-Mar-20 | 01:53 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4023.6 | 426888    | 04-Mar-20 | 01:53 | x64      |
| Logread.exe                                              | 2019.150.4023.6 | 717704    | 04-Mar-20 | 01:51 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4023.6     | 58248     | 04-Mar-20 | 01:45 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4023.6     | 390024    | 04-Mar-20 | 01:53 | x86      |
| Msoledbsql.dll                                           | 2018.182.3.0    | 148432    | 04-Mar-20 | 01:56 | x64      |
| Msxmlsql.dll                                             | 2019.150.4023.6 | 1496152   | 04-Mar-20 | 01:56 | x64      |
| Osql.exe                                                 | 2019.150.4023.6 | 91224     | 04-Mar-20 | 01:55 | x64      |
| Qrdrsvc.exe                                              | 2019.150.4023.6 | 496520    | 04-Mar-20 | 01:51 | x64      |
| Rdistcom.dll                                             | 2019.150.4023.6 | 914312    | 04-Mar-20 | 01:52 | x64      |
| Replmerg.exe                                             | 2019.150.4023.6 | 562056    | 04-Mar-20 | 01:57 | x64      |
| Replprov.dll                                             | 2019.150.4023.6 | 853088    | 04-Mar-20 | 01:50 | x64      |
| Replrec.dll                                              | 2019.150.4023.6 | 1029216   | 04-Mar-20 | 01:57 | x64      |
| Replsub.dll                                              | 2019.150.4023.6 | 472160    | 04-Mar-20 | 01:53 | x64      |
| Spresolv.dll                                             | 2019.150.4023.6 | 275544    | 04-Mar-20 | 01:50 | x64      |
| Sqldiag.exe                                              | 2019.150.4023.6 | 1139592   | 04-Mar-20 | 01:51 | x64      |
| Sqllogship.exe                                           | 15.0.4023.6     | 103304    | 04-Mar-20 | 01:45 | x64      |
| Sqlsvc.dll                                               | 2019.150.4023.6 | 148360    | 04-Mar-20 | 01:45 | x86      |
| Sqlsvc.dll                                               | 2019.150.4023.6 | 181128    | 04-Mar-20 | 01:45 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4023.6 | 91256     | 04-Mar-20 | 01:58 | x64      |
| Exthost.exe        | 2019.150.4023.6 | 230496    | 04-Mar-20 | 01:59 | x64      |
| Launchpad.exe      | 2019.150.4023.6 | 1225824   | 04-Mar-20 | 01:59 | x64      |
| Sqlsatellite.dll   | 2019.150.4023.6 | 1021024   | 04-Mar-20 | 01:58 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4023.6  | 29784     | 04-Mar-20 | 01:52 | x86      |

SQL Server 2019 Integration Services

|                         File name                        |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                                  | 2019.150.4023.6 | 3142536   | 04-Mar-20 | 02:19 | x64      |
| Dts.dll                                                  | 2019.150.4023.6 | 2765920   | 04-Mar-20 | 02:20 | x86      |
| Dtsmsg150.dll                                            | 2019.150.4023.6 | 566152    | 04-Mar-20 | 02:19 | x64      |
| Dtsmsg150.dll                                            | 2019.150.4023.6 | 553864    | 04-Mar-20 | 02:21 | x86      |
| Dtspipeline.dll                                          | 2019.150.4023.6 | 1119112   | 04-Mar-20 | 02:19 | x86      |
| Dtspipeline.dll                                          | 2019.150.4023.6 | 1328008   | 04-Mar-20 | 02:19 | x64      |
| Dtswizard.exe                                            | 15.0.4023.6     | 889952    | 04-Mar-20 | 02:18 | x86      |
| Dtswizard.exe                                            | 15.0.4023.6     | 885848    | 04-Mar-20 | 02:18 | x64      |
| Flatfiledest.dll                                         | 2019.150.4023.6 | 410504    | 04-Mar-20 | 02:18 | x64      |
| Flatfiledest.dll                                         | 2019.150.4023.6 | 357472    | 04-Mar-20 | 02:19 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4023.6 | 369544    | 04-Mar-20 | 02:18 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4023.6 | 426888    | 04-Mar-20 | 02:20 | x64      |
| Isdbupgradewizard.exe                                    | 15.0.4023.6     | 119688    | 04-Mar-20 | 02:18 | x86      |
| Isdbupgradewizard.exe                                    | 15.0.4023.6     | 119896    | 04-Mar-20 | 02:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4023.6     | 58248     | 04-Mar-20 | 02:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4023.6     | 58456     | 04-Mar-20 | 02:21 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll             | 15.0.4023.6     | 390024    | 04-Mar-20 | 02:18 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4023.6     | 140168    | 04-Mar-20 | 02:18 | x86      |
| Msdtssrvr.exe                                            | 15.0.4023.6     | 217992    | 04-Mar-20 | 02:18 | x64      |
| Msmdpp.dll                                               | 2018.150.34.9   | 10062432  | 04-Mar-20 | 01:52 | x64      |
| Odbcdest.dll                                             | 2019.150.4023.6 | 369544    | 04-Mar-20 | 02:19 | x64      |
| Odbcdest.dll                                             | 2019.150.4023.6 | 316296    | 04-Mar-20 | 02:20 | x86      |
| Odbcsrc.dll                                              | 2019.150.4023.6 | 328792    | 04-Mar-20 | 02:18 | x86      |
| Odbcsrc.dll                                              | 2019.150.4023.6 | 381832    | 04-Mar-20 | 02:19 | x64      |
| Sqlceip.exe                                              | 15.0.4023.6     | 283736    | 04-Mar-20 | 02:21 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1828.0     | 557696    | 04-Mar-20 | 03:26 | x86      |
| Dmsnative.dll                                                        | 2018.150.1828.0 | 138880    | 04-Mar-20 | 03:26 | x64      |
| Dwengineservice.dll                                                  | 15.0.1828.0     | 50544     | 04-Mar-20 | 03:26 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.108       | 2365520   | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2272      | 2199120   | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2272      | 144976    | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.217       | 2408016   | 04-Mar-20 | 03:26 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 04-Mar-20 | 03:26 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 04-Mar-20 | 03:26 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 04-Mar-20 | 03:26 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 04-Mar-20 | 03:26 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 04-Mar-20 | 03:26 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 04-Mar-20 | 03:26 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 04-Mar-20 | 03:26 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 04-Mar-20 | 03:26 | x64      |
| Instapi150.dll                                                       | 2019.150.4023.6 | 86920     | 04-Mar-20 | 03:26 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 04-Mar-20 | 03:26 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 04-Mar-20 | 03:26 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 04-Mar-20 | 03:26 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 04-Mar-20 | 03:26 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 04-Mar-20 | 03:26 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1828.0     | 73344     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1828.0     | 299136    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1828.0     | 1956480   | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1828.0     | 176464    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1828.0     | 626512    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1828.0     | 249704    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1828.0     | 144512    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1828.0     | 85632     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1828.0     | 56960     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1828.0     | 94328     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1828.0     | 1134720   | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1828.0     | 86888     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1828.0     | 76648     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1828.0     | 41088     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1828.0     | 36992     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1828.0     | 52048     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1828.0     | 27504     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1828.0     | 32384     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1828.0     | 137344    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1828.0     | 92288     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1828.0     | 106624    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1828.0     | 295248    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 124544    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 142160    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 145024    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 141648    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 153936    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 143488    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 138360    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 178816    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 121984    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1828.0     | 140416    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1828.0     | 78672     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1828.0     | 27776     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1828.0     | 43136     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1828.0     | 134272    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1828.0     | 3034448   | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1828.0     | 3959120   | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 124240    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 139088    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 143696    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 139600    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 154448    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 140112    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 136528    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 176976    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 121168    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1828.0     | 138064    | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1828.0     | 72320     | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1828.0     | 2688128   | 04-Mar-20 | 03:26 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1828.0     | 2442368   | 04-Mar-20 | 03:26 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4023.6 | 451464    | 04-Mar-20 | 03:26 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4023.6 | 7394184   | 04-Mar-20 | 03:26 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 04-Mar-20 | 03:26 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 04-Mar-20 | 03:26 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 04-Mar-20 | 03:26 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 04-Mar-20 | 03:26 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 04-Mar-20 | 03:26 | x64      |
| Secforwarder.dll                                                     | 2019.150.4023.6 | 78968     | 04-Mar-20 | 03:26 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1828.0 | 66896     | 04-Mar-20 | 03:26 | x64      |
| Sqldk.dll                                                            | 2019.150.4023.6 | 3138440   | 04-Mar-20 | 03:26 | x64      |
| Sqldumper.exe                                                        | 2019.150.4023.6 | 185224    | 04-Mar-20 | 03:26 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 1586264   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 4141960   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 3396488   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 4133984   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 4039560   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 2208648   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 2159712   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 3801992   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 3798104   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 1528712   | 04-Mar-20 | 03:25 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4023.6 | 4006792   | 04-Mar-20 | 03:25 | x64      |
| Sqlos.dll                                                            | 2019.150.4023.6 | 46176     | 04-Mar-20 | 03:26 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1828.0 | 4846928   | 04-Mar-20 | 03:26 | x64      |
| Sqltses.dll                                                          | 2019.150.4023.6 | 9069448   | 04-Mar-20 | 03:26 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 04-Mar-20 | 03:26 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 04-Mar-20 | 03:26 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 04-Mar-20 | 03:26 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4023.6  | 29792     | 04-Mar-20 | 01:52 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                        | 2019.150.4023.6 | 2765920   | 04-Mar-20 | 02:12 | x86      |
| Dts.dll                                        | 2019.150.4023.6 | 3142536   | 04-Mar-20 | 02:12 | x64      |
| Dtsmsg150.dll                                  | 2019.150.4023.6 | 553864    | 04-Mar-20 | 02:12 | x86      |
| Dtsmsg150.dll                                  | 2019.150.4023.6 | 566152    | 04-Mar-20 | 02:12 | x64      |
| Dtspipeline.dll                                | 2019.150.4023.6 | 1119112   | 04-Mar-20 | 02:12 | x86      |
| Dtspipeline.dll                                | 2019.150.4023.6 | 1328008   | 04-Mar-20 | 02:12 | x64      |
| Dtswizard.exe                                  | 15.0.4023.6     | 885848    | 04-Mar-20 | 02:12 | x64      |
| Dtswizard.exe                                  | 15.0.4023.6     | 889952    | 04-Mar-20 | 02:12 | x86      |
| Flatfiledest.dll                               | 2019.150.4023.6 | 410504    | 04-Mar-20 | 02:12 | x64      |
| Flatfiledest.dll                               | 2019.150.4023.6 | 357472    | 04-Mar-20 | 02:12 | x86      |
| Flatfilesrc.dll                                | 2019.150.4023.6 | 369544    | 04-Mar-20 | 02:12 | x86      |
| Flatfilesrc.dll                                | 2019.150.4023.6 | 426888    | 04-Mar-20 | 02:12 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4023.6     | 402312    | 04-Mar-20 | 02:12 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4023.6     | 402552    | 04-Mar-20 | 02:12 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4023.6     | 2999176   | 04-Mar-20 | 02:12 | x86      |
| Msmgdsrv.dll                                   | 2018.150.34.9   | 8278416   | 04-Mar-20 | 01:55 | x86      |
| Sqlsvc.dll                                     | 2019.150.4023.6 | 181128    | 04-Mar-20 | 02:12 | x64      |
| Sqlsvc.dll                                     | 2019.150.4023.6 | 148360    | 04-Mar-20 | 02:13 | x86      |

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
