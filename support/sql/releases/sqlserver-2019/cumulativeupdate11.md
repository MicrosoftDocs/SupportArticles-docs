---
title: Cumulative update 11 for SQL Server 2019 (KB5003249)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 11 (KB5003249).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5003249
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5003249 - Cumulative Update 11 for SQL Server 2019

_Release Date:_ &nbsp; June 10, 2021  
_Version:_ &nbsp; 15.0.4138.2

## Summary

This article describes Cumulative Update package 11 (CU11) for Microsoft SQL Server 2019. This update contains 36 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 10, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4138.2**, file version: **2019.150.4138.2**
- Analysis Services - Product version: **15.0.35.9**, file version: **2018.150.35.9**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="13993011">[13993011](#13993011)</a> | Fixes an issue where a subscribe session can become orphaned and can't be killed even after subscribed XEvent trace is deleted. | Analysis Services | Analysis Services | Windows |
| <a id="14022646">[14022646](#14022646)</a> | Fixes SSAS 2019 Tabular instance with DirectQuery mode generates unexpected SQL syntax to `CAST <col> AS VARCHAR(4000)` against Teradata `CHAR` data type. | Analysis Services | Analysis Services | Windows |
| <a id="14040147">[14040147](#14040147)</a> | Fixes an issue with performance when tabular queries in SSAS 2019 take more time to execute compared to SSAS 2016. | Analysis Services | Analysis Services | Windows |
| <a id="14051339">[14051339](#14051339)</a> | Fixes an issue where DAX query with `VAR CALCULATETABLE` and `filter` may return inconsistent result in SSAS 2019 after upgrading from 2017. | Analysis Services | Analysis Services | Windows |
| <a id="14068508">[14068508](#14068508)</a> | Fixes the SSAS 2019 Multidimensional mode no global cache issue when role security involves `CustomData()` func. | Analysis Services | Analysis Services | Windows |
| <a id="14070005">[14070005](#14070005)</a> | Fixes the incorrect results that occur in SSAS 2019 tabular mode when a DAX queries a calculated measure that depends on calc group Calculation item. | Analysis Services | Analysis Services | Windows |
| <a id="14072120">[14072120](#14072120)</a> | Fixes the memory consumption issue that occurs when Model processing in SSAS 2019 consumes more memory, when compared to same model processing in SSAS 2017. | Analysis Services | Analysis Services | Windows |
| <a id="14076769">[14076769](#14076769)</a> | Fixes an issue in **explore** page where the `Day` value changes to `1` if you input 31 some times. | Master Data Services | Client | Windows |
| <a id="14018244">[14018244](#14018244)</a> | Fixes an issue in which queries that use the Clustered Columnstore Index (CCI) `Key Lookup` operator return fewer than the actual number of records when you run CCI `REORG` commands. | SQL Server Engine | Column Stores | All |
| <a id="14080523">[14080523](#14080523)</a> | Fixes an issue that causes query to be stuck in `BATCH_MODE_SORT` in SQL Server 2019. | SQL Server Engine | Column Stores | Windows |
| <a id="14056975">[14056975](#14056975)</a> | Fixes a potential issue that causes error 5511 when performing a log backup on a database that has filestream data. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="13974249">[13974249](#13974249)</a> | [FIX: Error 19432 occurs when Log Writer thread fails to send a log back and stop log capture on Log Writer threads in SQL Server 2019 (KB5003589)](https://support.microsoft.com/help/5003589) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="14068003">[14068003](#14068003)</a> | [FIX: Log line is extremely high when Always On Availability Group has many databases in SQL Server 2019 (KB5003596)](https://support.microsoft.com/help/5003596) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13999052">[13999052](#13999052)</a> | Fixes an issue where an availability group database restart process is blocked when the database is transitioned to a new state because of an availability group failover or lease timeout on the primary replica. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14030474">[14030474](#14030474)</a> | Fixes an issue that causes database `log_reuse_wait_desc` to change to `AVAILABILITY_REPLICA` when a database is removed from Availability Group. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14056430">[14056430](#14056430)</a> | Adds improvement to increase the default size and file retention on `AlwaysOn_health`. </br></br>**Note**: The current definition for the `AlwaysOn_health` XEvent session has a maximum file size of 5 megabytes (MB) and maximum number of files of 4, for a maximum of 20 MB of `AlwaysOn_health` XEvent data. On a busy system, you can roll over this limitation quickly and miss important information in the event of an issue that affects the system. In order to keep more troubleshooting data available on the system, the default file size is changed from 5 MB to 100 MB and the default number of files is changed from 4 to 10, for a maximum of 1 GB of `AlwaysOn_health` XEvent data, in this update. If the definition of the `AlwaysOn_health` session has already been modified from the default values, this improvement won't overwrite the existing settings. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14024322">[14024322](#14024322)</a> | [FIX: SQL Server Express LocalDB can't start or connect to shared instances of SQL Server Express LocalDB 2019 or 2017 (KB5003342)](https://support.microsoft.com/help/5003342) | SQL Server Engine | LocalDB | Windows |
| <a id="13703145">[13703145](#13703145)</a> | [FIX: Error 574 when you try to install Service Pack 2 for SQL Server 2014 (KB4023170)](https://support.microsoft.com/help/4023170) | SQL Server Engine | Management Services | Windows |
| <a id="13974250">[13974250](#13974250)</a> | [Improvement: New XEvents temp_table_cache_trace and temp_table_destroy_list_trace are created in SQL Server 2019 (KB5003937)](https://support.microsoft.com/help/5003937) | SQL Server Engine | Metadata | Windows |
| <a id="13748046">[13748046](#13748046)</a> | Prevents ghost cleanup from triggering a memory dump during latch time-out in SQL Server 2019. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="14015202">[14015202](#14015202)</a> | Fixes the error 3628 that occurs frequently when In-Memory OLTP is enabled in SQL Server 2019 and you may receive an error message as shown below: </br></br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Error: 3628, Severity: 16, State: 1. </br>\<DateTime>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Database Engine received a floating point exception from the operating system while processing a user request. Try the transaction again. If the problem persists, contact your system administrator. | SQL Server Engine | Methods to access stored data | Windows |
| <a id="13982521">[13982521](#13982521)</a> | [Improvement: ADLS Gen2 support for External Tables (KB5003525)](https://support.microsoft.com/help/5003525) | SQL Server Engine | PolyBase | All |
| <a id="14071288">[14071288](#14071288)</a> | [FIX: Support schema reflection stored procedures for the Polybase generic ODBC connector (KB5003869)](https://support.microsoft.com/help/5003869) | SQL Server Engine | PolyBase | Windows |
| <a id="14071341">[14071341](#14071341)</a> | [FIX: Support using the PolyBase SQL Server connector to create external table with remote database name containing a period (KB5003870)](https://support.microsoft.com/help/5003870) | SQL Server Engine | PolyBase | All |
| <a id="13962011">[13962011](#13962011)</a> | Fixes an issue where executing a PolyBase related query encounters error "Invocation of TransactionStateCreate resulted in -1" and causes PolyBase Data Movement service memory dump. | SQL Server Engine | PolyBase | All |
| <a id="14049191">[14049191](#14049191)</a> | Fixes failures in PolyBase queries involving date/time literals or integer divisions that may occur when the Microsoft Spark ODBC driver is used to connect to a generic ODBC external data source. | SQL Server Engine | PolyBase | All |
| <a id="14058311">[14058311](#14058311)</a> | Fixes an issue where the JVM will eventually crash with an out of memory error after a certain number of queries due to threads not being properly cleaned up in certain scenarios when you use PolyBase Hadoop bridge data sources in SQL Server 2019 on Linux. | SQL Server Engine | PolyBase | Linux |
| <a id="14058313">[14058313](#14058313)</a> | Fixes an issue which leads to the impossibility of creating JAVA dumps and thus hampers debuggability and supportability when a PolyBase JAVA HadoopBridge process is started under Linux, an invalid `-XX:HeapDumpPath` JVM option is passed to the JVM. | SQL Server Engine | PolyBase | Linux |
| <a id="14066089">[14066089](#14066089)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine | Programmability | All |
| <a id="14078469">[14078469](#14078469)</a> | Fixes the performance issues that occur with concurrent executions of stored procedures on `CHANGETABLE` and `syscommittab` by enforcing index seek on change tracking side tables in SQL Server 2019. | SQL Server Engine | Query Optimizer | All |
| <a id="13992226">[13992226](#13992226)</a> | Fixes an issue where `sp_hadr_verify_replication_publisher` displays wrong distribution database name in error. | SQL Server Engine | Replication | Windows |
| <a id="14077044">[14077044](#14077044)</a> | When published database is part of availability group and listener is on a non-default port, replication monitor doesn't display publication and subscription information. This CU fixes that issue. | SQL Server Engine | Replication | Windows |
| <a id="14032116">[14032116](#14032116)</a> | [FIX: Performance issues occur when metadata is scanned to find keys to be sent to the AE enclave in SQL Server 2019 (KB5003750)](https://support.microsoft.com/help/5003750) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13990055">[13990055](#13990055)</a> | Fixes the memory release issue in execution of the `STDistance` spatial method while using spatial index. Before the fix, memory usage of `MEMORYCLERK_SOSNODE` gradually grew until all the memory available is taken. | SQL Server Engine | Spatial | Windows |
| <a id="14068550">[14068550](#14068550)</a> | Fixes the high `SOS_SUSPEND_QUEUE` spinlock contention with parallel `window aggregate`. | SQL Server Engine | SQL OS | All |
| <a id="14043293">[14043293](#14043293)</a> | Fixes an issue where `Setup Account Privileges` check may not be performed when installing CU or Security Update. | SQL Setup | Patching | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU11 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/06/sqlserver2019-kb5003249-x64_a1b2d2845c5c66d7b9fced09309537d5fa7dc540.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5003249-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5003249-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5003249-x64.exe| A5077EEED8B83696055C553BD8E6003CA97CE71EF33586CC42ADA9C95B2D98AB |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.9   | 291720    | 27-May-21 | 18:07 | x64      |
| Mashupcompression.dll                                     | 2.80.5803.541   | 140672    | 27-May-21 | 18:07 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.9       | 757144    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 196000    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 196512    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 197536    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 198560    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 201120    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 213920    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 192416    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 172960    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 174496    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.9       | 251296    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.9       | 1096584   | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.9       | 479624    | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 57224     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 57248     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 57760     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 58272     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 60808     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 57248     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 52640     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 53664     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.9       | 66464     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.9       | 16776     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.9       | 16776     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.9       | 16776     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.9       | 16784     | 27-May-21 | 18:07 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.9       | 17800     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 661072    | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.dll                                 | 2.80.5803.541   | 186232    | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.80.5803.541   | 30080     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.80.5803.541   | 74832     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.80.5803.541   | 102264    | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41864     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41856     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 42064     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 37760     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 41848     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.80.5803.541   | 45960     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454672   | 27-May-21 | 18:07 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181112    | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 920656    | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34608     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34816     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35120     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 47112     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33072     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33080     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34824     | 27-May-21 | 18:07 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 27-May-21 | 18:07 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.80.5803.541   | 5262728   | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.container.exe                            | 2.80.5803.541   | 22392     | 27-May-21 | 18:07 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.80.5803.541   | 21880     | 27-May-21 | 18:07 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.80.5803.541   | 22096     | 27-May-21 | 18:07 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.80.5803.541   | 149368    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.80.5803.541   | 78712     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14928     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15240     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15464     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15224     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15232     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15440     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14720     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 14728     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.80.5803.541   | 15744     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.80.5803.541   | 192392    | 27-May-21 | 18:07 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.80.5803.541   | 59984     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13184     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13192     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.80.5803.541   | 13392     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.shims.dll                                | 2.80.5803.541   | 27512     | 27-May-21 | 18:07 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140368    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.dll                                | 2.80.5803.541   | 14271872  | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 640080    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 664656    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 639880    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 648064    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 656256    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 689024    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 545656    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 553864    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 627592    | 27-May-21 | 18:07 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.80.5803.541   | 865360    | 27-May-21 | 18:07 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437568   | 27-May-21 | 18:07 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 27-May-21 | 18:07 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.27.19      | 1104976   | 27-May-21 | 18:07 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126336    | 27-May-21 | 18:07 | x86      |
| Msmdctr.dll                                               | 2018.150.35.9   | 37264     | 27-May-21 | 18:07 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.9   | 47783304  | 27-May-21 | 18:07 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.9   | 66288008  | 27-May-21 | 18:07 | x64      |
| Msmdpump.dll                                              | 2018.150.35.9   | 10187680  | 27-May-21 | 18:07 | x64      |
| Msmdredir.dll                                             | 2018.150.35.9   | 7955872   | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 15768     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 15776     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 16272     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 16280     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 16280     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 15768     | 27-May-21 | 18:07 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.9       | 17304     | 27-May-21 | 18:07 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.9   | 65825672  | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1000328   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1452936   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1520520   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1535880   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1595272   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1607560   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1627016   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 1641864   | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 809864    | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 832392    | 27-May-21 | 18:07 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.9   | 991112    | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1449888   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1516960   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1531808   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1590688   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1603488   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1623456   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 1636768   | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 808864    | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 831392    | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 990112    | 27-May-21 | 18:07 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.9   | 997792    | 27-May-21 | 18:07 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.9   | 10185112  | 27-May-21 | 18:07 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.9   | 8277912   | 27-May-21 | 18:07 | x86      |
| Msolap.dll                                                | 2018.150.35.9   | 11014552  | 27-May-21 | 18:07 | x64      |
| Msolap.dll                                                | 2018.150.35.9   | 8607128   | 27-May-21 | 18:07 | x86      |
| Msolui.dll                                                | 2018.150.35.9   | 285080    | 27-May-21 | 18:07 | x86      |
| Msolui.dll                                                | 2018.150.35.9   | 305568    | 27-May-21 | 18:07 | x64      |
| Powerbiextensions.dll                                     | 2.80.5803.541   | 9470032   | 27-May-21 | 18:07 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728456    | 27-May-21 | 18:07 | x64      |
| Sqlboot.dll                                               | 2019.150.4138.2 | 213888    | 27-May-21 | 18:07 | x64      |
| Sqlceip.exe                                               | 15.0.4138.2     | 287616    | 27-May-21 | 18:07 | x86      |
| Sqldumper.exe                                             | 2019.150.4138.2 | 152464    | 27-May-21 | 18:07 | x86      |
| Sqldumper.exe                                             | 2019.150.4138.2 | 185216    | 27-May-21 | 18:07 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 27-May-21 | 18:07 | x86      |
| Tmapi.dll                                                 | 2018.150.35.9   | 6177176   | 27-May-21 | 18:07 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.9   | 4916632   | 27-May-21 | 18:07 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.9   | 1183648   | 27-May-21 | 18:07 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.9   | 6805400   | 27-May-21 | 18:07 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.9   | 26024344  | 27-May-21 | 18:07 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.9   | 35459480  | 27-May-21 | 18:07 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll                       | 2019.150.4138.2 | 86944     | 27-May-21 | 18:07 | x64      |
| Instapi140.dll                       | 2019.150.4138.2 | 74640     | 27-May-21 | 18:07 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4138.2 | 99232     | 27-May-21 | 18:19 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4138.2 | 86920     | 27-May-21 | 18:19 | x86      |
| Msasxpress.dll                       | 2018.150.35.9   | 26016     | 27-May-21 | 18:08 | x86      |
| Msasxpress.dll                       | 2018.150.35.9   | 31112     | 27-May-21 | 18:08 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4138.2 | 74656     | 27-May-21 | 18:19 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4138.2 | 86944     | 27-May-21 | 18:19 | x64      |
| Sqldumper.exe                        | 2019.150.4138.2 | 152464    | 27-May-21 | 18:07 | x86      |
| Sqldumper.exe                        | 2019.150.4138.2 | 185216    | 27-May-21 | 18:07 | x64      |
| Sqlftacct.dll                        | 2019.150.4138.2 | 58248     | 27-May-21 | 18:19 | x86      |
| Sqlftacct.dll                        | 2019.150.4138.2 | 78752     | 27-May-21 | 18:19 | x64      |
| Sqlmanager.dll                       | 2019.150.4138.2 | 742304    | 27-May-21 | 18:19 | x86      |
| Sqlmanager.dll                       | 2019.150.4138.2 | 877472    | 27-May-21 | 18:19 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4138.2 | 377744    | 27-May-21 | 18:19 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4138.2 | 430992    | 27-May-21 | 18:19 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4138.2 | 275344    | 27-May-21 | 18:19 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4138.2 | 357264    | 27-May-21 | 18:19 | x64      |
| Svrenumapi140.dll                    | 2019.150.4138.2 | 1160072   | 27-May-21 | 18:19 | x64      |
| Svrenumapi140.dll                    | 2019.150.4138.2 | 910216    | 27-May-21 | 18:19 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4138.2 | 136064    | 27-May-21 | 18:18 | x86      |
| Dreplaycommon.dll     | 2019.150.4138.2 | 665504    | 27-May-21 | 18:18 | x86      |
| Dreplayutil.dll       | 2019.150.4138.2 | 304016    | 27-May-21 | 18:18 | x86      |
| Instapi140.dll        | 2019.150.4138.2 | 86944     | 27-May-21 | 18:18 | x64      |
| Sqlresourceloader.dll | 2019.150.4138.2 | 37768     | 27-May-21 | 18:18 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4138.2 | 665504    | 27-May-21 | 18:19 | x86      |
| Dreplaycontroller.exe | 2019.150.4138.2 | 365456    | 27-May-21 | 18:19 | x86      |
| Instapi140.dll        | 2019.150.4138.2 | 86944     | 27-May-21 | 18:19 | x64      |
| Sqlresourceloader.dll | 2019.150.4138.2 | 37768     | 27-May-21 | 18:19 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4138.2 | 4657024   | 27-May-21 | 19:25 | x64      |
| Aetm-enclave.dll                           | 2019.150.4138.2 | 4611464   | 27-May-21 | 19:25 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4138.2 | 4930832   | 27-May-21 | 19:25 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4138.2 | 4872488   | 27-May-21 | 19:25 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 27-May-21 | 18:07 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 27-May-21 | 18:07 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 27-May-21 | 19:25 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 27-May-21 | 19:25 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 27-May-21 | 19:25 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 27-May-21 | 19:25 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4138.2 | 279440    | 27-May-21 | 19:25 | x64      |
| Dcexec.exe                                 | 2019.150.4138.2 | 86912     | 27-May-21 | 19:25 | x64      |
| Fssres.dll                                 | 2019.150.4138.2 | 95104     | 27-May-21 | 19:25 | x64      |
| Hadrres.dll                                | 2019.150.4138.2 | 201616    | 27-May-21 | 19:25 | x64      |
| Hkcompile.dll                              | 2019.150.4138.2 | 1291144   | 27-May-21 | 19:25 | x64      |
| Hkengine.dll                               | 2019.150.4138.2 | 5784480   | 27-May-21 | 19:25 | x64      |
| Hkruntime.dll                              | 2019.150.4138.2 | 181120    | 27-May-21 | 19:25 | x64      |
| Hktempdb.dll                               | 2019.150.4138.2 | 62336     | 27-May-21 | 19:25 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 27-May-21 | 19:25 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4138.2     | 234384    | 27-May-21 | 19:25 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4138.2 | 324480    | 27-May-21 | 19:25 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4138.2 | 91016     | 27-May-21 | 19:25 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 27-May-21 | 19:25 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 27-May-21 | 19:25 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 27-May-21 | 19:25 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 27-May-21 | 19:25 | x64      |
| Qds.dll                                    | 2019.150.4138.2 | 1184656   | 27-May-21 | 19:25 | x64      |
| Rsfxft.dll                                 | 2019.150.4138.2 | 50064     | 27-May-21 | 19:25 | x64      |
| Secforwarder.dll                           | 2019.150.4138.2 | 78736     | 27-May-21 | 19:25 | x64      |
| Sqagtres.dll                               | 2019.150.4138.2 | 86928     | 27-May-21 | 19:25 | x64      |
| Sqlaamss.dll                               | 2019.150.4138.2 | 107408    | 27-May-21 | 19:25 | x64      |
| Sqlaccess.dll                              | 2019.150.4138.2 | 492416    | 27-May-21 | 19:25 | x64      |
| Sqlagent.exe                               | 2019.150.4138.2 | 730000    | 27-May-21 | 19:25 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4138.2 | 66448     | 27-May-21 | 19:25 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4138.2 | 78736     | 27-May-21 | 19:25 | x64      |
| Sqlboot.dll                                | 2019.150.4138.2 | 213888    | 27-May-21 | 19:25 | x64      |
| Sqlceip.exe                                | 15.0.4138.2     | 287616    | 27-May-21 | 18:18 | x86      |
| Sqlcmdss.dll                               | 2019.150.4138.2 | 86944     | 27-May-21 | 19:25 | x64      |
| Sqlctr150.dll                              | 2019.150.4138.2 | 115600    | 27-May-21 | 19:25 | x86      |
| Sqlctr150.dll                              | 2019.150.4138.2 | 140176    | 27-May-21 | 19:25 | x64      |
| Sqldk.dll                                  | 2019.150.4138.2 | 3150728   | 27-May-21 | 19:25 | x64      |
| Sqldtsss.dll                               | 2019.150.4138.2 | 107424    | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 1532816   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 1590160   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 2167712   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 2216848   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3404688   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3490720   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3494800   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3535760   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3572640   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3605408   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3687312   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3810208   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3859360   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 3900304   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4002704   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4006800   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4019104   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4051856   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4146080   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4154256   | 27-May-21 | 19:25 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4138.2 | 4268944   | 27-May-21 | 19:25 | x64      |
| Sqllang.dll                                | 2019.150.4138.2 | 39883664  | 27-May-21 | 19:25 | x64      |
| Sqlmin.dll                                 | 2019.150.4138.2 | 40424848  | 27-May-21 | 19:25 | x64      |
| Sqlolapss.dll                              | 2019.150.4138.2 | 103312    | 27-May-21 | 19:25 | x64      |
| Sqlos.dll                                  | 2019.150.4138.2 | 41872     | 27-May-21 | 19:25 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4138.2 | 82832     | 27-May-21 | 19:25 | x64      |
| Sqlrepss.dll                               | 2019.150.4138.2 | 82832     | 27-May-21 | 19:25 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4138.2 | 50080     | 27-May-21 | 19:25 | x64      |
| Sqlscm.dll                                 | 2019.150.4138.2 | 86920     | 27-May-21 | 19:25 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4138.2 | 37792     | 27-May-21 | 19:25 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4138.2 | 5804944   | 27-May-21 | 19:25 | x64      |
| Sqlserverspatial140.dll                    | 2019.150.4138.2 | 672656    | 27-May-21 | 19:25 | x64      |
| Sqlservr.exe                               | 2019.150.4138.2 | 627600    | 27-May-21 | 19:25 | x64      |
| Sqlsvc.dll                                 | 2019.150.4138.2 | 181136    | 27-May-21 | 19:25 | x64      |
| Sqltses.dll                                | 2019.150.4138.2 | 9114496   | 27-May-21 | 19:25 | x64      |
| Sqsrvres.dll                               | 2019.150.4138.2 | 279440    | 27-May-21 | 19:25 | x64      |
| Svl.dll                                    | 2019.150.4138.2 | 160648    | 27-May-21 | 19:25 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 27-May-21 | 19:25 | x64      |
| Xe.dll                                     | 2019.150.4138.2 | 721792    | 27-May-21 | 18:19 | x64      |
| Xpadsi.exe                                 | 2019.150.4138.2 | 115584    | 27-May-21 | 19:25 | x64      |
| Xplog70.dll                                | 2019.150.4138.2 | 91040     | 27-May-21 | 19:25 | x64      |
| Xprepl.dll                                 | 2019.150.4138.2 | 119712    | 27-May-21 | 19:25 | x64      |
| Xpstar.dll                                 | 2019.150.4138.2 | 471952    | 27-May-21 | 19:25 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                              | 2019.150.4138.2 | 263040    | 27-May-21 | 18:18 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4138.2 | 226176    | 27-May-21 | 18:19 | x64      |
| Distrib.exe                                                  | 2019.150.4138.2 | 234400    | 27-May-21 | 18:19 | x64      |
| Dteparse.dll                                                 | 2019.150.4138.2 | 123792    | 27-May-21 | 18:18 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4138.2 | 131968    | 27-May-21 | 18:18 | x64      |
| Dtepkg.dll                                                   | 2019.150.4138.2 | 148352    | 27-May-21 | 18:18 | x64      |
| Dtexec.exe                                                   | 2019.150.4138.2 | 71584     | 27-May-21 | 18:18 | x64      |
| Dts.dll                                                      | 2019.150.4138.2 | 3142544   | 27-May-21 | 18:19 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4138.2 | 500624    | 27-May-21 | 18:18 | x64      |
| Dtsconn.dll                                                  | 2019.150.4138.2 | 521088    | 27-May-21 | 18:18 | x64      |
| Dtshost.exe                                                  | 2019.150.4138.2 | 104336    | 27-May-21 | 18:18 | x64      |
| Dtsmsg140.dll                                                | 2019.150.4138.2 | 566168    | 27-May-21 | 18:18 | x64      |
| Dtspipeline.dll                                              | 2019.150.4138.2 | 1328000   | 27-May-21 | 18:18 | x64      |
| Dtswizard.exe                                                | 15.0.4138.2     | 885632    | 27-May-21 | 18:18 | x64      |
| Dtuparse.dll                                                 | 2019.150.4138.2 | 99200     | 27-May-21 | 18:18 | x64      |
| Dtutil.exe                                                   | 2019.150.4138.2 | 147344    | 27-May-21 | 18:18 | x64      |
| Exceldest.dll                                                | 2019.150.4138.2 | 279424    | 27-May-21 | 18:18 | x64      |
| Excelsrc.dll                                                 | 2019.150.4138.2 | 308096    | 27-May-21 | 18:18 | x64      |
| Execpackagetask.dll                                          | 2019.150.4138.2 | 185216    | 27-May-21 | 18:18 | x64      |
| Flatfiledest.dll                                             | 2019.150.4138.2 | 410528    | 27-May-21 | 18:18 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4138.2 | 426896    | 27-May-21 | 18:18 | x64      |
| Logread.exe                                                  | 2019.150.4138.2 | 717712    | 27-May-21 | 18:19 | x64      |
| Mergetxt.dll                                                 | 2019.150.4138.2 | 74656     | 27-May-21 | 18:19 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4138.2     | 58256     | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4138.2     | 41872     | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4138.2     | 390048    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.xmltask.dll                              | 15.0.4138.2     | 156560    | 27-May-21 | 18:18 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4138.2 | 111488    | 27-May-21 | 18:18 | x64      |
| Msgprox.dll                                                  | 2019.150.4138.2 | 299936    | 27-May-21 | 18:19 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 27-May-21 | 18:18 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4138.2 | 1495952   | 27-May-21 | 18:18 | x64      |
| Oledbdest.dll                                                | 2019.150.4138.2 | 279424    | 27-May-21 | 18:18 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4138.2 | 312208    | 27-May-21 | 18:18 | x64      |
| Osql.exe                                                     | 2019.150.4138.2 | 91024     | 27-May-21 | 18:18 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4138.2 | 496544    | 27-May-21 | 18:19 | x64      |
| Rawdest.dll                                                  | 2019.150.4138.2 | 226176    | 27-May-21 | 18:18 | x64      |
| Rawsource.dll                                                | 2019.150.4138.2 | 209792    | 27-May-21 | 18:18 | x64      |
| Rdistcom.dll                                                 | 2019.150.4138.2 | 914336    | 27-May-21 | 18:18 | x64      |
| Recordsetdest.dll                                            | 2019.150.4138.2 | 201616    | 27-May-21 | 18:18 | x64      |
| Repldp.dll                                                   | 2019.150.4138.2 | 312224    | 27-May-21 | 18:19 | x64      |
| Replerrx.dll                                                 | 2019.150.4138.2 | 181152    | 27-May-21 | 18:18 | x64      |
| Replisapi.dll                                                | 2019.150.4138.2 | 394144    | 27-May-21 | 18:19 | x64      |
| Replmerg.exe                                                 | 2019.150.4138.2 | 562080    | 27-May-21 | 18:19 | x64      |
| Replprov.dll                                                 | 2019.150.4138.2 | 852896    | 27-May-21 | 18:19 | x64      |
| Replrec.dll                                                  | 2019.150.4138.2 | 1033120   | 27-May-21 | 18:18 | x64      |
| Replsub.dll                                                  | 2019.150.4138.2 | 471968    | 27-May-21 | 18:18 | x64      |
| Replsync.dll                                                 | 2019.150.4138.2 | 164768    | 27-May-21 | 18:19 | x64      |
| Spresolv.dll                                                 | 2019.150.4138.2 | 275360    | 27-May-21 | 18:18 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4138.2 | 263056    | 27-May-21 | 18:18 | x64      |
| Sqldiag.exe                                                  | 2019.150.4138.2 | 1139584   | 27-May-21 | 18:19 | x64      |
| Sqldistx.dll                                                 | 2019.150.4138.2 | 246688    | 27-May-21 | 18:19 | x64      |
| Sqllogship.exe                                               | 15.0.4138.2     | 103304    | 27-May-21 | 18:19 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4138.2 | 398240    | 27-May-21 | 18:19 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4138.2 | 50080     | 27-May-21 | 18:18 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4138.2 | 37768     | 27-May-21 | 18:19 | x86      |
| Sqlscm.dll                                                   | 2019.150.4138.2 | 86920     | 27-May-21 | 18:18 | x64      |
| Sqlscm.dll                                                   | 2019.150.4138.2 | 78736     | 27-May-21 | 18:19 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4138.2 | 148368    | 27-May-21 | 18:18 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4138.2 | 181136    | 27-May-21 | 18:18 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4138.2 | 205712    | 27-May-21 | 18:18 | x64      |
| Ssradd.dll                                                   | 2019.150.4138.2 | 82848     | 27-May-21 | 18:18 | x64      |
| Ssravg.dll                                                   | 2019.150.4138.2 | 82848     | 27-May-21 | 18:18 | x64      |
| Ssrdown.dll                                                  | 2019.150.4138.2 | 74656     | 27-May-21 | 18:19 | x64      |
| Ssrmax.dll                                                   | 2019.150.4138.2 | 82848     | 27-May-21 | 18:19 | x64      |
| Ssrmin.dll                                                   | 2019.150.4138.2 | 82848     | 27-May-21 | 18:19 | x64      |
| Ssrpub.dll                                                   | 2019.150.4138.2 | 74656     | 27-May-21 | 18:19 | x64      |
| Ssrup.dll                                                    | 2019.150.4138.2 | 74656     | 27-May-21 | 18:18 | x64      |
| Txagg.dll                                                    | 2019.150.4138.2 | 390032    | 27-May-21 | 18:18 | x64      |
| Txbdd.dll                                                    | 2019.150.4138.2 | 189328    | 27-May-21 | 18:18 | x64      |
| Txdatacollector.dll                                          | 2019.150.4138.2 | 471936    | 27-May-21 | 18:19 | x64      |
| Txdataconvert.dll                                            | 2019.150.4138.2 | 316304    | 27-May-21 | 18:18 | x64      |
| Txderived.dll                                                | 2019.150.4138.2 | 639888    | 27-May-21 | 18:18 | x64      |
| Txlookup.dll                                                 | 2019.150.4138.2 | 541568    | 27-May-21 | 18:18 | x64      |
| Txmerge.dll                                                  | 2019.150.4138.2 | 258944    | 27-May-21 | 18:18 | x64      |
| Txmergejoin.dll                                              | 2019.150.4138.2 | 308112    | 27-May-21 | 18:18 | x64      |
| Txmulticast.dll                                              | 2019.150.4138.2 | 144256    | 27-May-21 | 18:18 | x64      |
| Txrowcount.dll                                               | 2019.150.4138.2 | 140176    | 27-May-21 | 18:18 | x64      |
| Txsort.dll                                                   | 2019.150.4138.2 | 287632    | 27-May-21 | 18:18 | x64      |
| Txsplit.dll                                                  | 2019.150.4138.2 | 623488    | 27-May-21 | 18:18 | x64      |
| Txunionall.dll                                               | 2019.150.4138.2 | 197520    | 27-May-21 | 18:18 | x64      |
| Xe.dll                                                       | 2019.150.4138.2 | 721792    | 27-May-21 | 18:19 | x64      |
| Xmlsub.dll                                                   | 2019.150.4138.2 | 295840    | 27-May-21 | 18:19 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4138.2 | 95136     | 27-May-21 | 18:19 | x64      |
| Exthost.exe        | 2019.150.4138.2 | 238496    | 27-May-21 | 18:19 | x64      |
| Launchpad.exe      | 2019.150.4138.2 | 1217408   | 27-May-21 | 18:19 | x64      |
| Sqlsatellite.dll   | 2019.150.4138.2 | 1016712   | 27-May-21 | 18:19 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4138.2 | 684944    | 27-May-21 | 18:18 | x64      |
| Fdhost.exe     | 2019.150.4138.2 | 127888    | 27-May-21 | 18:18 | x64      |
| Fdlauncher.exe | 2019.150.4138.2 | 78752     | 27-May-21 | 18:18 | x64      |
| Sqlft150ph.dll | 2019.150.4138.2 | 91008     | 27-May-21 | 18:19 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4138.2  | 29584     | 27-May-21 | 18:19 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4138.2 | 263040    | 27-May-21 | 18:18 | x64      |
| Commanddest.dll                                               | 2019.150.4138.2 | 226176    | 27-May-21 | 18:18 | x86      |
| Dteparse.dll                                                  | 2019.150.4138.2 | 111504    | 27-May-21 | 18:19 | x86      |
| Dteparse.dll                                                  | 2019.150.4138.2 | 123792    | 27-May-21 | 18:19 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4138.2 | 115584    | 27-May-21 | 18:18 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4138.2 | 131968    | 27-May-21 | 18:19 | x64      |
| Dtepkg.dll                                                    | 2019.150.4138.2 | 148352    | 27-May-21 | 18:19 | x64      |
| Dtepkg.dll                                                    | 2019.150.4138.2 | 132000    | 27-May-21 | 18:19 | x86      |
| Dtexec.exe                                                    | 2019.150.4138.2 | 71584     | 27-May-21 | 18:19 | x64      |
| Dtexec.exe                                                    | 2019.150.4138.2 | 62848     | 27-May-21 | 18:19 | x86      |
| Dts.dll                                                       | 2019.150.4138.2 | 3142544   | 27-May-21 | 18:18 | x64      |
| Dts.dll                                                       | 2019.150.4138.2 | 2761616   | 27-May-21 | 18:19 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4138.2 | 443264    | 27-May-21 | 18:19 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4138.2 | 500624    | 27-May-21 | 18:19 | x64      |
| Dtsconn.dll                                                   | 2019.150.4138.2 | 521088    | 27-May-21 | 18:19 | x64      |
| Dtsconn.dll                                                   | 2019.150.4138.2 | 430976    | 27-May-21 | 18:19 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4138.2 | 110976    | 27-May-21 | 18:18 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4138.2 | 92544     | 27-May-21 | 18:18 | x86      |
| Dtshost.exe                                                   | 2019.150.4138.2 | 87440     | 27-May-21 | 18:19 | x86      |
| Dtshost.exe                                                   | 2019.150.4138.2 | 104336    | 27-May-21 | 18:19 | x64      |
| Dtsmsg140.dll                                                 | 2019.150.4138.2 | 553872    | 27-May-21 | 18:18 | x86      |
| Dtsmsg140.dll                                                 | 2019.150.4138.2 | 566168    | 27-May-21 | 18:18 | x64      |
| Dtspipeline.dll                                               | 2019.150.4138.2 | 1328000   | 27-May-21 | 18:19 | x64      |
| Dtspipeline.dll                                               | 2019.150.4138.2 | 1119104   | 27-May-21 | 18:19 | x86      |
| Dtswizard.exe                                                 | 15.0.4138.2     | 889728    | 27-May-21 | 18:18 | x86      |
| Dtswizard.exe                                                 | 15.0.4138.2     | 885632    | 27-May-21 | 18:18 | x64      |
| Dtuparse.dll                                                  | 2019.150.4138.2 | 86928     | 27-May-21 | 18:19 | x86      |
| Dtuparse.dll                                                  | 2019.150.4138.2 | 99200     | 27-May-21 | 18:19 | x64      |
| Dtutil.exe                                                    | 2019.150.4138.2 | 128928    | 27-May-21 | 18:19 | x86      |
| Dtutil.exe                                                    | 2019.150.4138.2 | 147344    | 27-May-21 | 18:19 | x64      |
| Exceldest.dll                                                 | 2019.150.4138.2 | 234368    | 27-May-21 | 18:18 | x86      |
| Exceldest.dll                                                 | 2019.150.4138.2 | 279424    | 27-May-21 | 18:18 | x64      |
| Excelsrc.dll                                                  | 2019.150.4138.2 | 308096    | 27-May-21 | 18:18 | x64      |
| Excelsrc.dll                                                  | 2019.150.4138.2 | 258960    | 27-May-21 | 18:18 | x86      |
| Execpackagetask.dll                                           | 2019.150.4138.2 | 185216    | 27-May-21 | 18:18 | x64      |
| Execpackagetask.dll                                           | 2019.150.4138.2 | 148360    | 27-May-21 | 18:18 | x86      |
| Flatfiledest.dll                                              | 2019.150.4138.2 | 357256    | 27-May-21 | 18:18 | x86      |
| Flatfiledest.dll                                              | 2019.150.4138.2 | 410528    | 27-May-21 | 18:19 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4138.2 | 369536    | 27-May-21 | 18:18 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4138.2 | 426896    | 27-May-21 | 18:18 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4138.2     | 119696    | 27-May-21 | 18:19 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4138.2     | 119712    | 27-May-21 | 18:19 | x86      |
| Isserverexec.exe                                              | 15.0.4138.2     | 144256    | 27-May-21 | 18:18 | x64      |
| Isserverexec.exe                                              | 15.0.4138.2     | 148368    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4138.2     | 78736     | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4138.2     | 58240     | 27-May-21 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4138.2     | 58256     | 27-May-21 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4138.2     | 508816    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4138.2     | 508808    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4138.2     | 41872     | 27-May-21 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4138.2     | 41872     | 27-May-21 | 18:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4138.2     | 390048    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4138.2     | 58240     | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4138.2     | 58272     | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4138.2     | 140160    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4138.2     | 140176    | 27-May-21 | 18:18 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4138.2     | 156560    | 27-May-21 | 18:19 | x86      |
| Microsoft.sqlserver.xmltask.dll                               | 15.0.4138.2     | 156544    | 27-May-21 | 18:19 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4138.2     | 218000    | 27-May-21 | 18:18 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4138.2 | 99216     | 27-May-21 | 18:18 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4138.2 | 111488    | 27-May-21 | 18:19 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.9   | 10062240  | 27-May-21 | 18:07 | x64      |
| Odbcdest.dll                                                  | 2019.150.4138.2 | 316296    | 27-May-21 | 18:18 | x86      |
| Odbcdest.dll                                                  | 2019.150.4138.2 | 369536    | 27-May-21 | 18:18 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4138.2 | 328576    | 27-May-21 | 18:18 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4138.2 | 381840    | 27-May-21 | 18:18 | x64      |
| Oledbdest.dll                                                 | 2019.150.4138.2 | 279424    | 27-May-21 | 18:18 | x64      |
| Oledbdest.dll                                                 | 2019.150.4138.2 | 238472    | 27-May-21 | 18:18 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4138.2 | 263040    | 27-May-21 | 18:18 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4138.2 | 312208    | 27-May-21 | 18:18 | x64      |
| Rawdest.dll                                                   | 2019.150.4138.2 | 226176    | 27-May-21 | 18:19 | x64      |
| Rawdest.dll                                                   | 2019.150.4138.2 | 189312    | 27-May-21 | 18:19 | x86      |
| Rawsource.dll                                                 | 2019.150.4138.2 | 209792    | 27-May-21 | 18:19 | x64      |
| Rawsource.dll                                                 | 2019.150.4138.2 | 177024    | 27-May-21 | 18:19 | x86      |
| Recordsetdest.dll                                             | 2019.150.4138.2 | 172944    | 27-May-21 | 18:18 | x86      |
| Recordsetdest.dll                                             | 2019.150.4138.2 | 201616    | 27-May-21 | 18:19 | x64      |
| Sqlceip.exe                                                   | 15.0.4138.2     | 287616    | 27-May-21 | 18:19 | x86      |
| Sqldest.dll                                                   | 2019.150.4138.2 | 238480    | 27-May-21 | 18:18 | x86      |
| Sqldest.dll                                                   | 2019.150.4138.2 | 275344    | 27-May-21 | 18:19 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4138.2 | 168832    | 27-May-21 | 18:19 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4138.2 | 205712    | 27-May-21 | 18:19 | x64      |
| Txagg.dll                                                     | 2019.150.4138.2 | 328592    | 27-May-21 | 18:19 | x86      |
| Txagg.dll                                                     | 2019.150.4138.2 | 390032    | 27-May-21 | 18:19 | x64      |
| Txbdd.dll                                                     | 2019.150.4138.2 | 156560    | 27-May-21 | 18:19 | x86      |
| Txbdd.dll                                                     | 2019.150.4138.2 | 189328    | 27-May-21 | 18:19 | x64      |
| Txbestmatch.dll                                               | 2019.150.4138.2 | 652160    | 27-May-21 | 18:19 | x64      |
| Txbestmatch.dll                                               | 2019.150.4138.2 | 545680    | 27-May-21 | 18:19 | x86      |
| Txcache.dll                                                   | 2019.150.4138.2 | 172928    | 27-May-21 | 18:18 | x86      |
| Txcache.dll                                                   | 2019.150.4138.2 | 197504    | 27-May-21 | 18:19 | x64      |
| Txcharmap.dll                                                 | 2019.150.4138.2 | 271248    | 27-May-21 | 18:19 | x86      |
| Txcharmap.dll                                                 | 2019.150.4138.2 | 312208    | 27-May-21 | 18:19 | x64      |
| Txcopymap.dll                                                 | 2019.150.4138.2 | 197520    | 27-May-21 | 18:19 | x64      |
| Txcopymap.dll                                                 | 2019.150.4138.2 | 172944    | 27-May-21 | 18:19 | x86      |
| Txdataconvert.dll                                             | 2019.150.4138.2 | 275344    | 27-May-21 | 18:19 | x86      |
| Txdataconvert.dll                                             | 2019.150.4138.2 | 316304    | 27-May-21 | 18:19 | x64      |
| Txderived.dll                                                 | 2019.150.4138.2 | 557952    | 27-May-21 | 18:18 | x86      |
| Txderived.dll                                                 | 2019.150.4138.2 | 639888    | 27-May-21 | 18:19 | x64      |
| Txfileextractor.dll                                           | 2019.150.4138.2 | 218000    | 27-May-21 | 18:18 | x64      |
| Txfileextractor.dll                                           | 2019.150.4138.2 | 181136    | 27-May-21 | 18:19 | x86      |
| Txfileinserter.dll                                            | 2019.150.4138.2 | 181136    | 27-May-21 | 18:19 | x86      |
| Txfileinserter.dll                                            | 2019.150.4138.2 | 213888    | 27-May-21 | 18:19 | x64      |
| Txgroupdups.dll                                               | 2019.150.4138.2 | 312208    | 27-May-21 | 18:19 | x64      |
| Txgroupdups.dll                                               | 2019.150.4138.2 | 254848    | 27-May-21 | 18:19 | x86      |
| Txlineage.dll                                                 | 2019.150.4138.2 | 127888    | 27-May-21 | 18:19 | x86      |
| Txlineage.dll                                                 | 2019.150.4138.2 | 152464    | 27-May-21 | 18:19 | x64      |
| Txlookup.dll                                                  | 2019.150.4138.2 | 467848    | 27-May-21 | 18:18 | x86      |
| Txlookup.dll                                                  | 2019.150.4138.2 | 541568    | 27-May-21 | 18:18 | x64      |
| Txmerge.dll                                                   | 2019.150.4138.2 | 258944    | 27-May-21 | 18:19 | x64      |
| Txmerge.dll                                                   | 2019.150.4138.2 | 205712    | 27-May-21 | 18:19 | x86      |
| Txmergejoin.dll                                               | 2019.150.4138.2 | 246672    | 27-May-21 | 18:18 | x86      |
| Txmergejoin.dll                                               | 2019.150.4138.2 | 308112    | 27-May-21 | 18:18 | x64      |
| Txmulticast.dll                                               | 2019.150.4138.2 | 115584    | 27-May-21 | 18:19 | x86      |
| Txmulticast.dll                                               | 2019.150.4138.2 | 144256    | 27-May-21 | 18:19 | x64      |
| Txpivot.dll                                                   | 2019.150.4138.2 | 238480    | 27-May-21 | 18:19 | x64      |
| Txpivot.dll                                                   | 2019.150.4138.2 | 205712    | 27-May-21 | 18:19 | x86      |
| Txrowcount.dll                                                | 2019.150.4138.2 | 111488    | 27-May-21 | 18:19 | x86      |
| Txrowcount.dll                                                | 2019.150.4138.2 | 140176    | 27-May-21 | 18:19 | x64      |
| Txsampling.dll                                                | 2019.150.4138.2 | 160648    | 27-May-21 | 18:18 | x86      |
| Txsampling.dll                                                | 2019.150.4138.2 | 193416    | 27-May-21 | 18:19 | x64      |
| Txscd.dll                                                     | 2019.150.4138.2 | 234384    | 27-May-21 | 18:18 | x64      |
| Txscd.dll                                                     | 2019.150.4138.2 | 197504    | 27-May-21 | 18:19 | x86      |
| Txsort.dll                                                    | 2019.150.4138.2 | 230272    | 27-May-21 | 18:18 | x86      |
| Txsort.dll                                                    | 2019.150.4138.2 | 287632    | 27-May-21 | 18:19 | x64      |
| Txsplit.dll                                                   | 2019.150.4138.2 | 549768    | 27-May-21 | 18:18 | x86      |
| Txsplit.dll                                                   | 2019.150.4138.2 | 623488    | 27-May-21 | 18:19 | x64      |
| Txtermextraction.dll                                          | 2019.150.4138.2 | 8643456   | 27-May-21 | 18:19 | x86      |
| Txtermextraction.dll                                          | 2019.150.4138.2 | 8700832   | 27-May-21 | 18:19 | x64      |
| Txtermlookup.dll                                              | 2019.150.4138.2 | 4137856   | 27-May-21 | 18:19 | x86      |
| Txtermlookup.dll                                              | 2019.150.4138.2 | 4182928   | 27-May-21 | 18:19 | x64      |
| Txunionall.dll                                                | 2019.150.4138.2 | 160648    | 27-May-21 | 18:19 | x86      |
| Txunionall.dll                                                | 2019.150.4138.2 | 197520    | 27-May-21 | 18:19 | x64      |
| Txunpivot.dll                                                 | 2019.150.4138.2 | 181136    | 27-May-21 | 18:19 | x86      |
| Txunpivot.dll                                                 | 2019.150.4138.2 | 213904    | 27-May-21 | 18:19 | x64      |
| Xe.dll                                                        | 2019.150.4138.2 | 721792    | 27-May-21 | 18:18 | x64      |
| Xe.dll                                                        | 2019.150.4138.2 | 631680    | 27-May-21 | 18:19 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1933.0     | 558504    | 27-May-21 | 19:14 | x86      |
| Dmsnative.dll                                                        | 2018.150.1933.0 | 151456    | 27-May-21 | 19:14 | x64      |
| Dwengineservice.dll                                                  | 15.0.1933.0     | 43920     | 27-May-21 | 19:14 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 27-May-21 | 19:14 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 27-May-21 | 19:14 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 27-May-21 | 19:14 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 27-May-21 | 19:14 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 27-May-21 | 19:14 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 27-May-21 | 19:14 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 27-May-21 | 19:14 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 27-May-21 | 19:14 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 27-May-21 | 19:14 | x64      |
| Instapi140.dll                                                       | 2019.150.4138.2 | 86944     | 27-May-21 | 19:14 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 27-May-21 | 19:14 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 27-May-21 | 19:14 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 27-May-21 | 19:14 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 27-May-21 | 19:14 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 27-May-21 | 19:14 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1933.0     | 66472     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1933.0     | 292264    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1933.0     | 1955240   | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1933.0     | 168360    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1933.0     | 647592    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1933.0     | 245152    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1933.0     | 138128    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1933.0     | 78752     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1933.0     | 50080     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1933.0     | 87440     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1933.0     | 1128336   | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1933.0     | 79760     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1933.0     | 69520     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1933.0     | 34216     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1933.0     | 30096     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1933.0     | 45456     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1933.0     | 20392     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1933.0     | 25512     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1933.0     | 130464    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1933.0     | 85416     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1933.0     | 99752     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1933.0     | 291728    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 119184    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 137104    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 140176    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 136616    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 149392    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 138656    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 133544    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 175504    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 116112    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1933.0     | 135584    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1933.0     | 71584     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1933.0     | 20896     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1933.0     | 36256     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1933.0     | 127904    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1933.0     | 3063712   | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1933.0     | 3954592   | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 117152    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 132000    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 136608    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 132512    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 147360    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 133024    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 129440    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 169888    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 114080    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1933.0     | 130976    | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1933.0     | 66448     | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1933.0     | 2681768   | 27-May-21 | 19:14 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1933.0     | 2435488   | 27-May-21 | 19:14 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4138.2 | 451456    | 27-May-21 | 19:14 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4138.2 | 7386016   | 27-May-21 | 19:14 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 27-May-21 | 19:14 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 27-May-21 | 19:14 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 27-May-21 | 19:14 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 27-May-21 | 19:14 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 27-May-21 | 19:14 | x64      |
| Secforwarder.dll                                                     | 2019.150.4138.2 | 78736     | 27-May-21 | 19:14 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1933.0 | 60320     | 27-May-21 | 19:14 | x64      |
| Sqldk.dll                                                            | 2019.150.4138.2 | 3150728   | 27-May-21 | 19:14 | x64      |
| Sqldumper.exe                                                        | 2019.150.4138.2 | 185216    | 27-May-21 | 19:14 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 1590160   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 4154256   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 3404688   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 4146080   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 4051856   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 2216848   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 2167712   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 3810208   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 3810208   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 1532816   | 27-May-21 | 19:08 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4138.2 | 4019104   | 27-May-21 | 19:08 | x64      |
| Sqlos.dll                                                            | 2019.150.4138.2 | 41872     | 27-May-21 | 19:14 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1933.0 | 4840336   | 27-May-21 | 19:14 | x64      |
| Sqltses.dll                                                          | 2019.150.4138.2 | 9114496   | 27-May-21 | 19:14 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 27-May-21 | 19:14 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 27-May-21 | 19:14 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 27-May-21 | 19:14 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4138.2  | 29600     | 27-May-21 | 18:18 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4138.2 | 1631120   | 27-May-21 | 18:47 | x86      |
| Dtaengine.exe                                                | 2019.150.4138.2 | 217984    | 27-May-21 | 18:47 | x86      |
| Dteparse.dll                                                 | 2019.150.4138.2 | 111504    | 27-May-21 | 18:47 | x86      |
| Dteparse.dll                                                 | 2019.150.4138.2 | 123792    | 27-May-21 | 18:47 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4138.2 | 115584    | 27-May-21 | 18:47 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4138.2 | 131968    | 27-May-21 | 18:47 | x64      |
| Dtepkg.dll                                                   | 2019.150.4138.2 | 132000    | 27-May-21 | 18:47 | x86      |
| Dtepkg.dll                                                   | 2019.150.4138.2 | 148352    | 27-May-21 | 18:47 | x64      |
| Dtexec.exe                                                   | 2019.150.4138.2 | 62848     | 27-May-21 | 18:47 | x86      |
| Dtexec.exe                                                   | 2019.150.4138.2 | 71584     | 27-May-21 | 18:47 | x64      |
| Dts.dll                                                      | 2019.150.4138.2 | 2761616   | 27-May-21 | 18:47 | x86      |
| Dts.dll                                                      | 2019.150.4138.2 | 3142544   | 27-May-21 | 18:47 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4138.2 | 443264    | 27-May-21 | 18:47 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4138.2 | 500624    | 27-May-21 | 18:47 | x64      |
| Dtsconn.dll                                                  | 2019.150.4138.2 | 430976    | 27-May-21 | 18:47 | x86      |
| Dtsconn.dll                                                  | 2019.150.4138.2 | 521088    | 27-May-21 | 18:47 | x64      |
| Dtshost.exe                                                  | 2019.150.4138.2 | 104336    | 27-May-21 | 18:47 | x64      |
| Dtshost.exe                                                  | 2019.150.4138.2 | 87440     | 27-May-21 | 18:47 | x86      |
| Dtsmsg140.dll                                                | 2019.150.4138.2 | 553872    | 27-May-21 | 18:47 | x86      |
| Dtsmsg140.dll                                                | 2019.150.4138.2 | 566168    | 27-May-21 | 18:47 | x64      |
| Dtspipeline.dll                                              | 2019.150.4138.2 | 1119104   | 27-May-21 | 18:47 | x86      |
| Dtspipeline.dll                                              | 2019.150.4138.2 | 1328000   | 27-May-21 | 18:47 | x64      |
| Dtswizard.exe                                                | 15.0.4138.2     | 885632    | 27-May-21 | 18:16 | x64      |
| Dtswizard.exe                                                | 15.0.4138.2     | 889728    | 27-May-21 | 18:16 | x86      |
| Dtuparse.dll                                                 | 2019.150.4138.2 | 86928     | 27-May-21 | 18:47 | x86      |
| Dtuparse.dll                                                 | 2019.150.4138.2 | 99200     | 27-May-21 | 18:47 | x64      |
| Dtutil.exe                                                   | 2019.150.4138.2 | 128928    | 27-May-21 | 18:47 | x86      |
| Dtutil.exe                                                   | 2019.150.4138.2 | 147344    | 27-May-21 | 18:47 | x64      |
| Exceldest.dll                                                | 2019.150.4138.2 | 234368    | 27-May-21 | 18:47 | x86      |
| Exceldest.dll                                                | 2019.150.4138.2 | 279424    | 27-May-21 | 18:47 | x64      |
| Excelsrc.dll                                                 | 2019.150.4138.2 | 258960    | 27-May-21 | 18:47 | x86      |
| Excelsrc.dll                                                 | 2019.150.4138.2 | 308096    | 27-May-21 | 18:47 | x64      |
| Flatfiledest.dll                                             | 2019.150.4138.2 | 357256    | 27-May-21 | 18:47 | x86      |
| Flatfiledest.dll                                             | 2019.150.4138.2 | 410528    | 27-May-21 | 18:47 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4138.2 | 369536    | 27-May-21 | 18:47 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4138.2 | 426896    | 27-May-21 | 18:47 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4138.2     | 78720     | 27-May-21 | 18:16 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4138.2     | 402320    | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4138.2     | 402304    | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4138.2     | 2999200   | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4138.2     | 2999168   | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4138.2     | 41872     | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4138.2     | 41872     | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4138.2     | 58240     | 27-May-21 | 18:47 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18181.0    | 99760     | 27-May-21 | 18:47 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4138.2 | 111488    | 27-May-21 | 18:47 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4138.2 | 99216     | 27-May-21 | 18:47 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.9   | 8277912   | 27-May-21 | 18:16 | x86      |
| Oledbdest.dll                                                | 2019.150.4138.2 | 238472    | 27-May-21 | 18:47 | x86      |
| Oledbdest.dll                                                | 2019.150.4138.2 | 279424    | 27-May-21 | 18:47 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4138.2 | 263040    | 27-May-21 | 18:47 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4138.2 | 312208    | 27-May-21 | 18:47 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4138.2 | 37768     | 27-May-21 | 18:47 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4138.2 | 50080     | 27-May-21 | 18:47 | x64      |
| Sqlscm.dll                                                   | 2019.150.4138.2 | 78736     | 27-May-21 | 18:47 | x86      |
| Sqlscm.dll                                                   | 2019.150.4138.2 | 86920     | 27-May-21 | 18:47 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4138.2 | 148368    | 27-May-21 | 18:47 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4138.2 | 181136    | 27-May-21 | 18:47 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4138.2 | 168832    | 27-May-21 | 18:47 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4138.2 | 205712    | 27-May-21 | 18:47 | x64      |
| Txdataconvert.dll                                            | 2019.150.4138.2 | 275344    | 27-May-21 | 18:47 | x86      |
| Txdataconvert.dll                                            | 2019.150.4138.2 | 316304    | 27-May-21 | 18:47 | x64      |
| Xe.dll                                                       | 2019.150.4138.2 | 631680    | 27-May-21 | 18:47 | x86      |
| Xe.dll                                                       | 2019.150.4138.2 | 721792    | 27-May-21 | 18:47 | x64      |

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
