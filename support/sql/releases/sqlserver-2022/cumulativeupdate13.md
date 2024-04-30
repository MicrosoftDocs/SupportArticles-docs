---
title: Cumulative update 13 for SQL Server 2022 (KB5036432)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 13 (KB5036432).
ms.date: 05/16/2024
ms.custom: KB5036432
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5036432 - Cumulative Update 13 for SQL Server 2022

_Release Date:_ &nbsp; May 16, 2024  
_Version:_ &nbsp; 16.0.4125.2

## Summary

This article describes Cumulative Update package 13 (CU13) for Microsoft SQL Server 2022. This update contains 15 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 12, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4125.2**, file version: **2022.160.4125.2**
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area| Component | Platform |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|----------|
| <a id=2998350>[2998350](#2998350) </a> | Fixes an issue in which the secondary databases of an availability group might fail to be online intermittently. Additionally, you see the following error message: </br></br>Database 'DatabaseName' (database ID \<IDNumber>) startup failed with error 3602, severity 25, state 145. | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3025790>[3025790](#3025790) </a> | Fixes an assertion failure (Location: HadrArProxy.cpp:4314; Expression: !CFeatureSwitchesMin::GetCurrentInstance()->FHadrCheckXClusterAgUcsSizeEnabled() \|\| cbBlob < x_cbMsgBodyMax) that you might encounter when you use read-scale availability groups without a cluster configuration.| SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=2984871>[2984871](#2984871) </a> | Fixes an issue in the lock manager that might cause random access violations and dumps on secondary replicas when the primary replica has 16 or more processors, and the secondary replicas have less than 16 processors. | SQL Server Engine | Metadata| All|
| <a id=3084239>[3084239](#3084239) </a> | Fixes a latch time-out issue that you encounter when fetching the next value for sequence objects, which is due to self-deadlock during lock escalation.| SQL Server Engine | Metadata| All|
| <a id=2916501>[2916501](#2916501) </a> | Adds a new advanced option `'max RPC request params (KB)'` configured by using `sp_configure` to limit the maximum memory allocated for handling remote procedure call (RPC) request parameters.| SQL Server Engine | Query Execution | All|
| <a id=2973934>[2973934](#2973934) </a> | Fixes an issue in which using the `INSERT` statement with the `CAST` or `CONVERT` function from a string representing negative zero to a decimal or numeric datatype succeeds, but you see the following error message on `DBCC CHECKDB` and `DBCC CHECKTABLE`: </br></br>Msg 2570, Level 16, State 3, Line \<LineNumber> </br>Page (1:360), slot 0 in object ID \<ObjectID>, index ID \<IndexID>, partition ID \<PartitionID>, alloc unit ID \<UnitID> (type "In-row data"). Column "\<ColumnName>" value is out of range for data type "decimal". Update column to a legal value. | SQL Server Engine | Query Execution | All|
| <a id=3102467>[3102467](#3102467) </a> | Caches the maximum number of histogram steps in a global configuration variable to reduce `PREEMPTIVE_OS_REGISTRY` waits when creating statistics on temporary tables.| SQL Server Engine | Query Optimizer | All|
| <a id=2810754>[2810754](#2810754) </a> | [FIX: Couldn't disable "change data capture" if any column is encrypted by "Always Encrypted" feature in SQL Server (KB4034376)](https://support.microsoft.com/help/4034376)| SQL Server Engine | Replication | All|
| <a id=3003456>[3003456](#3003456) </a> | Fixes an issue in which some changes might not be captured into the change data capture (CDC) change tables (*cdc.\<capture_instance>_CT*) when CDC runs in parallel with a switch partition operation. | SQL Server Engine | Replication | All|
| <a id=3015714>[3015714](#3015714) </a> | Fixes the following error that you encounter when running `sys.sp_flush_CT_internal_table_on_demand` in a SQL Server instance that has the Case-sensitive (_CS) collation option: </br></br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Total rows deleted: (null). </br>Total rows deleted: (null).| SQL Server Engine | Replication | All|
| <a id=3033974>[3033974](#3033974) </a> | Adds the error message to the **comments** column of `dbo.MSchange_tracking_history` to help you understand the failure if a failure occurs during the auto cleanup or manual cleanup process.| SQL Server Engine | Replication | All|
| <a id=3144736>[3144736](#3144736) </a> | Fixes an error that you encounter when using conversation timers in Service Broker while the SQL Server instance is under memory pressure, which causes queries to fail and the instance to stop responding.| SQL Server Engine | Replication | Windows|
| <a id=2924913>[2924913](#2924913) </a> | Fixes an issue in which the full-text auto crawl function might stop working when you use full-text search. | SQL Server Engine | Search| All|
| <a id=2979492>[2979492](#2979492) </a> | Fixes the following error that you encounter when updating a view with a linked server connection to another instance if dynamic data masking (DDM) is enabled: </br></br>Msg 15905, Level 16, State 6, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line 34] </br>Query not supported: Cannot determine result column sources.Invalid metadata. | SQL Server Engine | Security Infrastructure | All|
| <a id=3033535>[3033535](#3033535) </a> | Adds a log message when high I/O latencies are detected in Bufferpool Lazy Writer (`ntdll!ZwWriteFile` system call) due to a performance issue in the underlying storage. | SQL Server Engine | SQL OS| All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU13 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5036432)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5036432-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5036432-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5036432-x64.exe| 2FCFBFE6C0A67BEE8BB18203D6DF134C4858F8483A903CF01B1D8A6B8FE9F0FD |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 15-Apr-2024 | 16:53 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.233 | 336944    | 15-Apr-2024 | 16:53 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.233     | 865216    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.233     | 2903488   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 15-Apr-2024 | 16:53 | x86      |
| Msmdctr.dll                                         | 2022.160.43.233 | 38864     | 15-Apr-2024 | 16:53 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 71818688  | 15-Apr-2024 | 16:53 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 53976120  | 15-Apr-2024 | 16:53 | x86      |
| Msmdpump.dll                                        | 2022.160.43.233 | 10333744  | 15-Apr-2024 | 16:53 | x64      |
| Msmdredir.dll                                       | 2022.160.43.233 | 8132032   | 15-Apr-2024 | 16:53 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.233 | 71367216  | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 956992    | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1884720   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1671728   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1881152   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1848360   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1147440   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1140280   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1769520   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1749040   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 932912    | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1837616   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 955456    | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1882672   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1668656   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1876528   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1844784   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1145392   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1138752   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1765440   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1745456   | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 933424    | 15-Apr-2024 | 16:53 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1833008   | 15-Apr-2024 | 16:53 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 10083392  | 15-Apr-2024 | 16:53 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 8265280   | 15-Apr-2024 | 16:53 | x86      |
| Msolap.dll                                          | 2022.160.43.233 | 10969648  | 15-Apr-2024 | 16:53 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 8743880   | 15-Apr-2024 | 16:53 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 308264    | 15-Apr-2024 | 16:53 | x64      |
| Msolui.dll                                          | 2022.160.43.233 | 289840    | 15-Apr-2024 | 16:53 | x86      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 15-Apr-2024 | 16:53 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 15-Apr-2024 | 16:53 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 15-Apr-2024 | 16:53 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 15-Apr-2024 | 16:53 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 15-Apr-2024 | 16:53 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 15-Apr-2024 | 16:53 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 16:53 | x64      |
| Sqlceip.exe                                         | 16.0.4125.2     | 301096    | 15-Apr-2024 | 16:53 | x86      |
| Sqldumper.exe                                       | 2022.160.4125.2 | 448448    | 15-Apr-2024 | 16:53 | x64      |
| Sqldumper.exe                                       | 2022.160.4125.2 | 378816    | 15-Apr-2024 | 16:53 | x86      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 15-Apr-2024 | 16:53 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 15-Apr-2024 | 16:53 | x86      |
| Tmapi.dll                                           | 2022.160.43.233 | 5884480   | 15-Apr-2024 | 16:53 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.233 | 5575216   | 15-Apr-2024 | 16:53 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.233 | 1481264   | 15-Apr-2024 | 16:53 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.233 | 7198264   | 15-Apr-2024 | 16:53 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 26593232  | 15-Apr-2024 | 16:53 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 35895856  | 15-Apr-2024 | 16:53 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4125.2 | 104384    | 15-Apr-2024 | 16:53 | x64      |
| Instapi150.dll                             | 2022.160.4125.2 | 79808     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633776   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633784   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.233     | 2933296   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4125.2 | 104488    | 15-Apr-2024 | 16:53 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4125.2 | 92216     | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4125.2     | 554960    | 15-Apr-2024 | 16:53 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4125.2     | 555048    | 15-Apr-2024 | 16:53 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 32816     | 15-Apr-2024 | 16:53 | x64      |
| Msasxpress.dll                             | 2022.160.43.233 | 27696     | 15-Apr-2024 | 16:53 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 16:53 | x64      |
| Sqldumper.exe                              | 2022.160.4125.2 | 448448    | 15-Apr-2024 | 16:53 | x64      |
| Sqldumper.exe                              | 2022.160.4125.2 | 378816    | 15-Apr-2024 | 16:53 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4125.2 | 456656    | 15-Apr-2024 | 16:53 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4125.2 | 395200    | 15-Apr-2024 | 16:53 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4125.2     | 309184    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4125.2     | 2070464   | 15-Apr-2024 | 16:54 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 16:54 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4125.2  | 600016    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4125.2  | 600120    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4125.2  | 174024    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4125.2  | 174136    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4125.2  | 1857488   | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4125.2  | 370728    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4125.2  | 370744    | 15-Apr-2024 | 16:54 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 15-Apr-2024 | 18:24 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 15-Apr-2024 | 18:24 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4125.2 | 5994448   | 15-Apr-2024 | 18:24 | x64      |
| Aetm-enclave.dll                             | 2022.160.4125.2 | 5959568   | 15-Apr-2024 | 18:24 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4125.2 | 6194688   | 15-Apr-2024 | 18:24 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4125.2 | 6160696   | 15-Apr-2024 | 18:24 | x64      |
| Dcexec.exe                                   | 2022.160.4125.2 | 96296     | 15-Apr-2024 | 18:24 | x64      |
| Fssres.dll                                   | 2022.160.4125.2 | 100392    | 15-Apr-2024 | 18:24 | x64      |
| Hadrres.dll                                  | 2022.160.4125.2 | 227280    | 15-Apr-2024 | 18:24 | x64      |
| Hkcompile.dll                                | 2022.160.4125.2 | 1411112   | 15-Apr-2024 | 18:24 | x64      |
| Hkengine.dll                                 | 2022.160.4125.2 | 5769256   | 15-Apr-2024 | 18:24 | x64      |
| Hkruntime.dll                                | 2022.160.4125.2 | 190520    | 15-Apr-2024 | 18:24 | x64      |
| Hktempdb.dll                                 | 2022.160.4125.2 | 71616     | 15-Apr-2024 | 18:24 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.233     | 2322480   | 15-Apr-2024 | 18:24 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4125.2 | 333880    | 15-Apr-2024 | 18:24 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4125.2 | 96312     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 30776     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 38952     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 34856     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 38952     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 38952     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 30760     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 30760     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 34856     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 38968     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 30760     | 15-Apr-2024 | 18:24 | x64      |
| Odsole70.rll                                 | 16.0.4125.2     | 38952     | 15-Apr-2024 | 18:24 | x64      |
| Qds.dll                                      | 2022.160.4125.2 | 1808320   | 15-Apr-2024 | 18:24 | x64      |
| Rsfxft.dll                                   | 2022.160.4125.2 | 55352     | 15-Apr-2024 | 18:24 | x64      |
| Secforwarder.dll                             | 2022.160.4125.2 | 84008     | 15-Apr-2024 | 18:24 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 18:24 | x64      |
| Sqlaamss.dll                                 | 2022.160.4125.2 | 120768    | 15-Apr-2024 | 18:24 | x64      |
| Sqlaccess.dll                                | 2022.160.4125.2 | 444472    | 15-Apr-2024 | 18:24 | x64      |
| Sqlagent.exe                                 | 2022.160.4125.2 | 718888    | 15-Apr-2024 | 18:24 | x64      |
| Sqlceip.exe                                  | 16.0.4125.2     | 301096    | 15-Apr-2024 | 18:24 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4125.2 | 104384    | 15-Apr-2024 | 18:24 | x64      |
| Sqlctr160.dll                                | 2022.160.4125.2 | 128960    | 15-Apr-2024 | 18:24 | x86      |
| Sqlctr160.dll                                | 2022.160.4125.2 | 157736    | 15-Apr-2024 | 18:24 | x64      |
| Sqldk.dll                                    | 2022.160.4125.2 | 4020264   | 15-Apr-2024 | 18:24 | x64      |
| Sqldtsss.dll                                 | 2022.160.4125.2 | 120872    | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 1755176   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3860520   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4077504   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4585424   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4716480   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3762216   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3946448   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4585408   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4417576   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4487104   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 2451496   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 2394048   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4274216   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3905472   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4425768   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4216768   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4200488   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3983312   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 3860520   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 1689640   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4311080   | 15-Apr-2024 | 18:24 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.2 | 4450256   | 15-Apr-2024 | 18:24 | x64      |
| Sqliosim.com                                 | 2022.160.4125.2 | 387112    | 15-Apr-2024 | 18:24 | x64      |
| Sqliosim.exe                                 | 2022.160.4125.2 | 3057704   | 15-Apr-2024 | 18:24 | x64      |
| Sqllang.dll                                  | 2022.160.4125.2 | 48777152  | 15-Apr-2024 | 18:24 | x64      |
| Sqlmin.dll                                   | 2022.160.4125.2 | 51238848  | 15-Apr-2024 | 18:24 | x64      |
| Sqlolapss.dll                                | 2022.160.4125.2 | 116792    | 15-Apr-2024 | 18:24 | x64      |
| Sqlos.dll                                    | 2022.160.4125.2 | 51256     | 15-Apr-2024 | 18:24 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4125.2 | 100288    | 15-Apr-2024 | 18:24 | x64      |
| Sqlrepss.dll                                 | 2022.160.4125.2 | 141352    | 15-Apr-2024 | 18:24 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4125.2 | 51136     | 15-Apr-2024 | 18:24 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4125.2 | 5834808   | 15-Apr-2024 | 18:24 | x64      |
| Sqlservr.exe                                 | 2022.160.4125.2 | 722880    | 15-Apr-2024 | 18:24 | x64      |
| Sqlsvc.dll                                   | 2022.160.4125.2 | 194496    | 15-Apr-2024 | 18:24 | x64      |
| Sqltses.dll                                  | 2022.160.4125.2 | 10667968  | 15-Apr-2024 | 18:24 | x64      |
| Sqsrvres.dll                                 | 2022.160.4125.2 | 305104    | 15-Apr-2024 | 18:24 | x64      |
| Svl.dll                                      | 2022.160.4125.2 | 247848    | 15-Apr-2024 | 18:24 | x64      |
| Xe.dll                                       | 2022.160.4125.2 | 718800    | 15-Apr-2024 | 18:24 | x64      |
| Xpqueue.dll                                  | 2022.160.4125.2 | 100288    | 15-Apr-2024 | 18:24 | x64      |
| Xpstar.dll                                   | 2022.160.4125.2 | 534584    | 15-Apr-2024 | 18:24 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 15-Apr-2024 | 16:54 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 15-Apr-2024 | 16:54 | x86      |
| Bcp.exe                                              | 2022.160.4125.2  | 141352    | 15-Apr-2024 | 16:54 | x64      |
| Commanddest.dll                                      | 2022.160.4125.2  | 272320    | 15-Apr-2024 | 16:54 | x64      |
| Datacollectortasks.dll                               | 2022.160.4125.2  | 227368    | 15-Apr-2024 | 16:54 | x64      |
| Distrib.exe                                          | 2022.160.4125.2  | 260040    | 15-Apr-2024 | 16:54 | x64      |
| Dteparse.dll                                         | 2022.160.4125.2  | 133072    | 15-Apr-2024 | 16:54 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4125.2  | 178216    | 15-Apr-2024 | 16:54 | x64      |
| Dtepkg.dll                                           | 2022.160.4125.2  | 153552    | 15-Apr-2024 | 16:54 | x64      |
| Dtexec.exe                                           | 2022.160.4125.2  | 76840     | 15-Apr-2024 | 16:54 | x64      |
| Dts.dll                                              | 2022.160.4125.2  | 3266616   | 15-Apr-2024 | 16:54 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4125.2  | 493608    | 15-Apr-2024 | 16:54 | x64      |
| Dtsconn.dll                                          | 2022.160.4125.2  | 550968    | 15-Apr-2024 | 16:54 | x64      |
| Dtshost.exe                                          | 2022.160.4125.2  | 120360    | 15-Apr-2024 | 16:54 | x64      |
| Dtslog.dll                                           | 2022.160.4125.2  | 137256    | 15-Apr-2024 | 16:54 | x64      |
| Dtspipeline.dll                                      | 2022.160.4125.2  | 1337400   | 15-Apr-2024 | 16:54 | x64      |
| Dtuparse.dll                                         | 2022.160.4125.2  | 104488    | 15-Apr-2024 | 16:54 | x64      |
| Dtutil.exe                                           | 2022.160.4125.2  | 166456    | 15-Apr-2024 | 16:54 | x64      |
| Exceldest.dll                                        | 2022.160.4125.2  | 284712    | 15-Apr-2024 | 16:54 | x64      |
| Excelsrc.dll                                         | 2022.160.4125.2  | 305208    | 15-Apr-2024 | 16:54 | x64      |
| Execpackagetask.dll                                  | 2022.160.4125.2  | 182312    | 15-Apr-2024 | 16:54 | x64      |
| Flatfiledest.dll                                     | 2022.160.4125.2  | 423976    | 15-Apr-2024 | 16:54 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4125.2  | 440256    | 15-Apr-2024 | 16:54 | x64      |
| Logread.exe                                          | 2022.160.4125.2  | 792512    | 15-Apr-2024 | 16:54 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.233      | 2933816   | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 15-Apr-2024 | 16:54 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4125.2      | 30656     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4125.2      | 391224    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4125.2  | 1710016   | 15-Apr-2024 | 16:54 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4125.2      | 555048    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 15-Apr-2024 | 16:54 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 15-Apr-2024 | 16:54 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4125.2  | 124984    | 15-Apr-2024 | 16:54 | x64      |
| Msgprox.dll                                          | 2022.160.4125.2  | 313288    | 15-Apr-2024 | 16:54 | x64      |
| Msoledbsql.dll                                       | 2018.187.2.0     | 2754584   | 15-Apr-2024 | 16:54 | x64      |
| Msoledbsql.dll                                       | 2018.187.2.0     | 153624    | 15-Apr-2024 | 16:54 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 15-Apr-2024 | 16:54 | x86      |
| Oledbdest.dll                                        | 2022.160.4125.2  | 288824    | 15-Apr-2024 | 16:54 | x64      |
| Oledbsrc.dll                                         | 2022.160.4125.2  | 313384    | 15-Apr-2024 | 16:54 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4125.2  | 526392    | 15-Apr-2024 | 16:54 | x64      |
| Rawdest.dll                                          | 2022.160.4125.2  | 227368    | 15-Apr-2024 | 16:54 | x64      |
| Rawsource.dll                                        | 2022.160.4125.2  | 214992    | 15-Apr-2024 | 16:54 | x64      |
| Rdistcom.dll                                         | 2022.160.4125.2  | 940072    | 15-Apr-2024 | 16:54 | x64      |
| Recordsetdest.dll                                    | 2022.160.4125.2  | 206888    | 15-Apr-2024 | 16:54 | x64      |
| Repldp.dll                                           | 2022.160.4125.2  | 337960    | 15-Apr-2024 | 16:54 | x64      |
| Replerrx.dll                                         | 2022.160.4125.2  | 198592    | 15-Apr-2024 | 16:54 | x64      |
| Replisapi.dll                                        | 2022.160.4125.2  | 419792    | 15-Apr-2024 | 16:54 | x64      |
| Replmerg.exe                                         | 2022.160.4125.2  | 595904    | 15-Apr-2024 | 16:54 | x64      |
| Replprov.dll                                         | 2022.160.4125.2  | 890816    | 15-Apr-2024 | 16:54 | x64      |
| Replrec.dll                                          | 2022.160.4125.2  | 1058752   | 15-Apr-2024 | 16:54 | x64      |
| Replsub.dll                                          | 2022.160.4125.2  | 501704    | 15-Apr-2024 | 16:54 | x64      |
| Spresolv.dll                                         | 2022.160.4125.2  | 300992    | 15-Apr-2024 | 16:54 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4125.2  | 137152    | 15-Apr-2024 | 16:54 | x64      |
| Sqlcmd.exe                                           | 2022.160.4125.2  | 276520    | 15-Apr-2024 | 16:54 | x64      |
| Sqldiag.exe                                          | 2022.160.4125.2  | 1140776   | 15-Apr-2024 | 16:54 | x64      |
| Sqldistx.dll                                         | 2022.160.4125.2  | 268328    | 15-Apr-2024 | 16:54 | x64      |
| Sqlmergx.dll                                         | 2022.160.4125.2  | 423888    | 15-Apr-2024 | 16:54 | x64      |
| Sqlsvc.dll                                           | 2022.160.4125.2  | 194496    | 15-Apr-2024 | 16:54 | x64      |
| Sqlsvc.dll                                           | 2022.160.4125.2  | 153536    | 15-Apr-2024 | 16:54 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4125.2  | 210984    | 15-Apr-2024 | 16:54 | x64      |
| Ssradd.dll                                           | 2022.160.4125.2  | 100288    | 15-Apr-2024 | 16:54 | x64      |
| Ssravg.dll                                           | 2022.160.4125.2  | 100304    | 15-Apr-2024 | 16:54 | x64      |
| Ssrmax.dll                                           | 2022.160.4125.2  | 100304    | 15-Apr-2024 | 16:54 | x64      |
| Ssrmin.dll                                           | 2022.160.4125.2  | 100288    | 15-Apr-2024 | 16:54 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 15-Apr-2024 | 16:54 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 15-Apr-2024 | 16:54 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 15-Apr-2024 | 16:54 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 15-Apr-2024 | 16:54 | x86      |
| Txagg.dll                                            | 2022.160.4125.2  | 395304    | 15-Apr-2024 | 16:54 | x64      |
| Txbdd.dll                                            | 2022.160.4125.2  | 190504    | 15-Apr-2024 | 16:54 | x64      |
| Txdatacollector.dll                                  | 2022.160.4125.2  | 469048    | 15-Apr-2024 | 16:54 | x64      |
| Txdataconvert.dll                                    | 2022.160.4125.2  | 333760    | 15-Apr-2024 | 16:54 | x64      |
| Txderived.dll                                        | 2022.160.4125.2  | 632768    | 15-Apr-2024 | 16:54 | x64      |
| Txlookup.dll                                         | 2022.160.4125.2  | 608192    | 15-Apr-2024 | 16:54 | x64      |
| Txmerge.dll                                          | 2022.160.4125.2  | 243768    | 15-Apr-2024 | 16:54 | x64      |
| Txmergejoin.dll                                      | 2022.160.4125.2  | 301096    | 15-Apr-2024 | 16:54 | x64      |
| Txmulticast.dll                                      | 2022.160.4125.2  | 145448    | 15-Apr-2024 | 16:54 | x64      |
| Txrowcount.dll                                       | 2022.160.4125.2  | 145448    | 15-Apr-2024 | 16:54 | x64      |
| Txsort.dll                                           | 2022.160.4125.2  | 276536    | 15-Apr-2024 | 16:54 | x64      |
| Txsplit.dll                                          | 2022.160.4125.2  | 620600    | 15-Apr-2024 | 16:54 | x64      |
| Txunionall.dll                                       | 2022.160.4125.2  | 194600    | 15-Apr-2024 | 16:54 | x64      |
| Xe.dll                                               | 2022.160.4125.2  | 718800    | 15-Apr-2024 | 16:54 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4125.2 | 100296    | 15-Apr-2024 | 17:04 | x64      |
| Exthost.exe                   | 2022.160.4125.2 | 247864    | 15-Apr-2024 | 17:04 | x64      |
| Launchpad.exe                 | 2022.160.4125.2 | 1447880   | 15-Apr-2024 | 17:04 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 17:04 | x64      |
| Sqlsatellite.dll              | 2022.160.4125.2 | 1255376   | 15-Apr-2024 | 17:04 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4125.2 | 710592    | 15-Apr-2024 | 16:55 | x64      |
| Fdhost.exe               | 2022.160.4125.2 | 153640    | 15-Apr-2024 | 16:55 | x64      |
| Fdlauncher.exe           | 2022.160.4125.2 | 100408    | 15-Apr-2024 | 16:55 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 16:54 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 15-Apr-2024 | 17:25 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 15-Apr-2024 | 17:25 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 15-Apr-2024 | 17:25 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 15-Apr-2024 | 17:25 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 15-Apr-2024 | 17:25 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 15-Apr-2024 | 17:25 | x86      |
| Commanddest.dll                                               | 2022.160.4125.2 | 272320    | 15-Apr-2024 | 17:25 | x64      |
| Commanddest.dll                                               | 2022.160.4125.2 | 231376    | 15-Apr-2024 | 17:25 | x86      |
| Dteparse.dll                                                  | 2022.160.4125.2 | 116776    | 15-Apr-2024 | 17:25 | x86      |
| Dteparse.dll                                                  | 2022.160.4125.2 | 133072    | 15-Apr-2024 | 17:25 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4125.2 | 165944    | 15-Apr-2024 | 17:25 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4125.2 | 178216    | 15-Apr-2024 | 17:25 | x64      |
| Dtepkg.dll                                                    | 2022.160.4125.2 | 129080    | 15-Apr-2024 | 17:25 | x86      |
| Dtepkg.dll                                                    | 2022.160.4125.2 | 153552    | 15-Apr-2024 | 17:25 | x64      |
| Dtexec.exe                                                    | 2022.160.4125.2 | 65064     | 15-Apr-2024 | 17:25 | x86      |
| Dtexec.exe                                                    | 2022.160.4125.2 | 76840     | 15-Apr-2024 | 17:25 | x64      |
| Dts.dll                                                       | 2022.160.4125.2 | 2861096   | 15-Apr-2024 | 17:25 | x86      |
| Dts.dll                                                       | 2022.160.4125.2 | 3266616   | 15-Apr-2024 | 17:25 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4125.2 | 444456    | 15-Apr-2024 | 17:25 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4125.2 | 493608    | 15-Apr-2024 | 17:25 | x64      |
| Dtsconn.dll                                                   | 2022.160.4125.2 | 464832    | 15-Apr-2024 | 17:25 | x86      |
| Dtsconn.dll                                                   | 2022.160.4125.2 | 550968    | 15-Apr-2024 | 17:25 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4125.2 | 94656     | 15-Apr-2024 | 17:25 | x86      |
| Dtsdebughost.exe                                              | 2022.160.4125.2 | 114728    | 15-Apr-2024 | 17:25 | x64      |
| Dtshost.exe                                                   | 2022.160.4125.2 | 98240     | 15-Apr-2024 | 17:25 | x86      |
| Dtshost.exe                                                   | 2022.160.4125.2 | 120360    | 15-Apr-2024 | 17:25 | x64      |
| Dtslog.dll                                                    | 2022.160.4125.2 | 120768    | 15-Apr-2024 | 17:25 | x86      |
| Dtslog.dll                                                    | 2022.160.4125.2 | 137256    | 15-Apr-2024 | 17:25 | x64      |
| Dtspipeline.dll                                               | 2022.160.4125.2 | 1144872   | 15-Apr-2024 | 17:25 | x86      |
| Dtspipeline.dll                                               | 2022.160.4125.2 | 1337400   | 15-Apr-2024 | 17:25 | x64      |
| Dtuparse.dll                                                  | 2022.160.4125.2 | 88120     | 15-Apr-2024 | 17:25 | x86      |
| Dtuparse.dll                                                  | 2022.160.4125.2 | 104488    | 15-Apr-2024 | 17:25 | x64      |
| Dtutil.exe                                                    | 2022.160.4125.2 | 142376    | 15-Apr-2024 | 17:25 | x86      |
| Dtutil.exe                                                    | 2022.160.4125.2 | 166456    | 15-Apr-2024 | 17:25 | x64      |
| Exceldest.dll                                                 | 2022.160.4125.2 | 284712    | 15-Apr-2024 | 17:25 | x64      |
| Exceldest.dll                                                 | 2022.160.4125.2 | 247848    | 15-Apr-2024 | 17:25 | x86      |
| Excelsrc.dll                                                  | 2022.160.4125.2 | 305208    | 15-Apr-2024 | 17:25 | x64      |
| Excelsrc.dll                                                  | 2022.160.4125.2 | 264144    | 15-Apr-2024 | 17:25 | x86      |
| Execpackagetask.dll                                           | 2022.160.4125.2 | 182312    | 15-Apr-2024 | 17:25 | x64      |
| Execpackagetask.dll                                           | 2022.160.4125.2 | 149544    | 15-Apr-2024 | 17:25 | x86      |
| Flatfiledest.dll                                              | 2022.160.4125.2 | 423976    | 15-Apr-2024 | 17:25 | x64      |
| Flatfiledest.dll                                              | 2022.160.4125.2 | 374824    | 15-Apr-2024 | 17:25 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4125.2 | 440256    | 15-Apr-2024 | 17:25 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4125.2 | 391104    | 15-Apr-2024 | 17:25 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4125.2     | 120888    | 15-Apr-2024 | 17:25 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4125.2     | 120768    | 15-Apr-2024 | 17:25 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933816   | 15-Apr-2024 | 17:25 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933824   | 15-Apr-2024 | 17:25 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4125.2     | 509888    | 15-Apr-2024 | 17:25 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4125.2     | 509904    | 15-Apr-2024 | 17:25 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4125.2     | 391224    | 15-Apr-2024 | 17:25 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4125.2     | 219072    | 15-Apr-2024 | 17:25 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4125.2 | 100288    | 15-Apr-2024 | 17:25 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4125.2 | 124984    | 15-Apr-2024 | 17:25 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.233 | 10164160  | 15-Apr-2024 | 17:25 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 15-Apr-2024 | 17:25 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 15-Apr-2024 | 17:25 | x86      |
| Odbcdest.dll                                                  | 2022.160.4125.2 | 383032    | 15-Apr-2024 | 17:25 | x64      |
| Odbcdest.dll                                                  | 2022.160.4125.2 | 342056    | 15-Apr-2024 | 17:25 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4125.2 | 399296    | 15-Apr-2024 | 17:25 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4125.2 | 350144    | 15-Apr-2024 | 17:25 | x86      |
| Oledbdest.dll                                                 | 2022.160.4125.2 | 288824    | 15-Apr-2024 | 17:25 | x64      |
| Oledbdest.dll                                                 | 2022.160.4125.2 | 247848    | 15-Apr-2024 | 17:25 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4125.2 | 313384    | 15-Apr-2024 | 17:25 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4125.2 | 268328    | 15-Apr-2024 | 17:25 | x86      |
| Rawdest.dll                                                   | 2022.160.4125.2 | 190520    | 15-Apr-2024 | 17:25 | x86      |
| Rawdest.dll                                                   | 2022.160.4125.2 | 227368    | 15-Apr-2024 | 17:25 | x64      |
| Rawsource.dll                                                 | 2022.160.4125.2 | 186304    | 15-Apr-2024 | 17:25 | x86      |
| Rawsource.dll                                                 | 2022.160.4125.2 | 214992    | 15-Apr-2024 | 17:25 | x64      |
| Recordsetdest.dll                                             | 2022.160.4125.2 | 174136    | 15-Apr-2024 | 17:25 | x86      |
| Recordsetdest.dll                                             | 2022.160.4125.2 | 206888    | 15-Apr-2024 | 17:25 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4125.2 | 137152    | 15-Apr-2024 | 17:25 | x64      |
| Sqlceip.exe                                                   | 16.0.4125.2     | 301096    | 15-Apr-2024 | 17:25 | x86      |
| Sqldest.dll                                                   | 2022.160.4125.2 | 255936    | 15-Apr-2024 | 17:25 | x86      |
| Sqldest.dll                                                   | 2022.160.4125.2 | 288824    | 15-Apr-2024 | 17:25 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4125.2 | 210984    | 15-Apr-2024 | 17:25 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4125.2 | 174016    | 15-Apr-2024 | 17:25 | x86      |
| Txagg.dll                                                     | 2022.160.4125.2 | 346168    | 15-Apr-2024 | 17:25 | x86      |
| Txagg.dll                                                     | 2022.160.4125.2 | 395304    | 15-Apr-2024 | 17:25 | x64      |
| Txbdd.dll                                                     | 2022.160.4125.2 | 149456    | 15-Apr-2024 | 17:25 | x86      |
| Txbdd.dll                                                     | 2022.160.4125.2 | 190504    | 15-Apr-2024 | 17:25 | x64      |
| Txbestmatch.dll                                               | 2022.160.4125.2 | 567248    | 15-Apr-2024 | 17:25 | x86      |
| Txbestmatch.dll                                               | 2022.160.4125.2 | 661544    | 15-Apr-2024 | 17:25 | x64      |
| Txcache.dll                                                   | 2022.160.4125.2 | 169920    | 15-Apr-2024 | 17:25 | x86      |
| Txcache.dll                                                   | 2022.160.4125.2 | 202792    | 15-Apr-2024 | 17:25 | x64      |
| Txcharmap.dll                                                 | 2022.160.4125.2 | 280512    | 15-Apr-2024 | 17:25 | x86      |
| Txcharmap.dll                                                 | 2022.160.4125.2 | 325688    | 15-Apr-2024 | 17:25 | x64      |
| Txcopymap.dll                                                 | 2022.160.4125.2 | 165944    | 15-Apr-2024 | 17:25 | x86      |
| Txcopymap.dll                                                 | 2022.160.4125.2 | 202792    | 15-Apr-2024 | 17:25 | x64      |
| Txdataconvert.dll                                             | 2022.160.4125.2 | 288720    | 15-Apr-2024 | 17:25 | x86      |
| Txdataconvert.dll                                             | 2022.160.4125.2 | 333760    | 15-Apr-2024 | 17:25 | x64      |
| Txderived.dll                                                 | 2022.160.4125.2 | 559144    | 15-Apr-2024 | 17:25 | x86      |
| Txderived.dll                                                 | 2022.160.4125.2 | 632768    | 15-Apr-2024 | 17:25 | x64      |
| Txfileextractor.dll                                           | 2022.160.4125.2 | 186304    | 15-Apr-2024 | 17:25 | x86      |
| Txfileextractor.dll                                           | 2022.160.4125.2 | 219176    | 15-Apr-2024 | 17:25 | x64      |
| Txfileinserter.dll                                            | 2022.160.4125.2 | 186424    | 15-Apr-2024 | 17:25 | x86      |
| Txfileinserter.dll                                            | 2022.160.4125.2 | 219176    | 15-Apr-2024 | 17:25 | x64      |
| Txgroupdups.dll                                               | 2022.160.4125.2 | 354256    | 15-Apr-2024 | 17:25 | x86      |
| Txgroupdups.dll                                               | 2022.160.4125.2 | 403512    | 15-Apr-2024 | 17:25 | x64      |
| Txlineage.dll                                                 | 2022.160.4125.2 | 128960    | 15-Apr-2024 | 17:25 | x86      |
| Txlineage.dll                                                 | 2022.160.4125.2 | 157632    | 15-Apr-2024 | 17:25 | x64      |
| Txlookup.dll                                                  | 2022.160.4125.2 | 522176    | 15-Apr-2024 | 17:25 | x86      |
| Txlookup.dll                                                  | 2022.160.4125.2 | 608192    | 15-Apr-2024 | 17:25 | x64      |
| Txmerge.dll                                                   | 2022.160.4125.2 | 194600    | 15-Apr-2024 | 17:25 | x86      |
| Txmerge.dll                                                   | 2022.160.4125.2 | 243768    | 15-Apr-2024 | 17:25 | x64      |
| Txmergejoin.dll                                               | 2022.160.4125.2 | 256040    | 15-Apr-2024 | 17:25 | x86      |
| Txmergejoin.dll                                               | 2022.160.4125.2 | 301096    | 15-Apr-2024 | 17:25 | x64      |
| Txmulticast.dll                                               | 2022.160.4125.2 | 116672    | 15-Apr-2024 | 17:25 | x86      |
| Txmulticast.dll                                               | 2022.160.4125.2 | 145448    | 15-Apr-2024 | 17:25 | x64      |
| Txpivot.dll                                                   | 2022.160.4125.2 | 198712    | 15-Apr-2024 | 17:25 | x86      |
| Txpivot.dll                                                   | 2022.160.4125.2 | 239656    | 15-Apr-2024 | 17:25 | x64      |
| Txrowcount.dll                                                | 2022.160.4125.2 | 116776    | 15-Apr-2024 | 17:25 | x86      |
| Txrowcount.dll                                                | 2022.160.4125.2 | 145448    | 15-Apr-2024 | 17:25 | x64      |
| Txsampling.dll                                                | 2022.160.4125.2 | 153552    | 15-Apr-2024 | 17:25 | x86      |
| Txsampling.dll                                                | 2022.160.4125.2 | 186304    | 15-Apr-2024 | 17:25 | x64      |
| Txscd.dll                                                     | 2022.160.4125.2 | 198696    | 15-Apr-2024 | 17:25 | x86      |
| Txscd.dll                                                     | 2022.160.4125.2 | 235560    | 15-Apr-2024 | 17:25 | x64      |
| Txsort.dll                                                    | 2022.160.4125.2 | 231360    | 15-Apr-2024 | 17:25 | x86      |
| Txsort.dll                                                    | 2022.160.4125.2 | 276536    | 15-Apr-2024 | 17:25 | x64      |
| Txsplit.dll                                                   | 2022.160.4125.2 | 550848    | 15-Apr-2024 | 17:25 | x86      |
| Txsplit.dll                                                   | 2022.160.4125.2 | 620600    | 15-Apr-2024 | 17:25 | x64      |
| Txtermextraction.dll                                          | 2022.160.4125.2 | 8648656   | 15-Apr-2024 | 17:25 | x86      |
| Txtermextraction.dll                                          | 2022.160.4125.2 | 8701904   | 15-Apr-2024 | 17:25 | x64      |
| Txtermlookup.dll                                              | 2022.160.4125.2 | 4138960   | 15-Apr-2024 | 17:25 | x86      |
| Txtermlookup.dll                                              | 2022.160.4125.2 | 4184000   | 15-Apr-2024 | 17:25 | x64      |
| Txunionall.dll                                                | 2022.160.4125.2 | 153640    | 15-Apr-2024 | 17:25 | x86      |
| Txunionall.dll                                                | 2022.160.4125.2 | 194600    | 15-Apr-2024 | 17:25 | x64      |
| Txunpivot.dll                                                 | 2022.160.4125.2 | 178232    | 15-Apr-2024 | 17:25 | x86      |
| Txunpivot.dll                                                 | 2022.160.4125.2 | 214992    | 15-Apr-2024 | 17:25 | x64      |
| Xe.dll                                                        | 2022.160.4125.2 | 640976    | 15-Apr-2024 | 17:25 | x86      |
| Xe.dll                                                        | 2022.160.4125.2 | 718800    | 15-Apr-2024 | 17:25 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1035.0     | 559688    | 15-Apr-2024 | 18:07 | x86      |
| Dmsnative.dll                                                        | 2022.160.1035.0 | 152632    | 15-Apr-2024 | 18:07 | x64      |
| Dwengineservice.dll                                                  | 16.0.1035.0     | 45016     | 15-Apr-2024 | 18:07 | x86      |
| Instapi150.dll                                                       | 2022.160.4125.2 | 104384    | 15-Apr-2024 | 18:07 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1035.0     | 67528     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1035.0     | 293320    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1035.0     | 1958360   | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1035.0     | 169424    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1035.0     | 647224    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1035.0     | 246216    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1035.0     | 139320    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1035.0     | 79944     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1035.0     | 51272     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1035.0     | 88632     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1035.0     | 1129432   | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1035.0     | 80952     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1035.0     | 70712     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1035.0     | 35272     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1035.0     | 31304     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1035.0     | 46552     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1035.0     | 21560     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1035.0     | 26584     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1035.0     | 131640    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1035.0     | 86480     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1035.0     | 100936    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1035.0     | 293336    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 120280    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 138296    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 141384    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 137672    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 150488    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 139736    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 134616    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 176696    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 117704    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 136664    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1035.0     | 72760     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1035.0     | 22072     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1035.0     | 37320     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1035.0     | 128968    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1035.0     | 3064776   | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1035.0     | 3955768   | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 118344    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133176    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 137784    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133688    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 148536    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 134200    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 130616    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 171064    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 115256    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 132152    | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1035.0     | 67544     | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1035.0     | 2682840   | 15-Apr-2024 | 18:07 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1035.0     | 2436552   | 15-Apr-2024 | 18:07 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4125.2 | 297016    | 15-Apr-2024 | 18:07 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4125.2 | 9074744   | 15-Apr-2024 | 18:07 | x64      |
| Secforwarder.dll                                                     | 2022.160.4125.2 | 84008     | 15-Apr-2024 | 18:07 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1035.0 | 61400     | 15-Apr-2024 | 18:07 | x64      |
| Sqldk.dll                                                            | 2022.160.4125.2 | 4020264   | 15-Apr-2024 | 18:07 | x64      |
| Sqldumper.exe                                                        | 2022.160.4125.2 | 448448    | 15-Apr-2024 | 18:07 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 1755176   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4585424   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 3762216   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4585408   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4487104   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 2451496   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 2394048   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4216768   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4200488   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 1689640   | 15-Apr-2024 | 18:06 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.2 | 4450256   | 15-Apr-2024 | 18:06 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 15-Apr-2024 | 18:07 | x64      |
| Sqlos.dll                                                            | 2022.160.4125.2 | 51256     | 15-Apr-2024 | 18:07 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1035.0 | 4841528   | 15-Apr-2024 | 18:07 | x64      |
| Sqltses.dll                                                          | 2022.160.4125.2 | 10667968  | 15-Apr-2024 | 18:07 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
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

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
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
