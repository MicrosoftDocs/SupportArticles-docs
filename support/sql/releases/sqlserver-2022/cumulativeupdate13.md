---
title: Cumulative update 13 for SQL Server 2022 (KB5036432)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 13 (KB5036432).
ms.date: 08/19/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5036432
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5036432 - Cumulative Update 13 for SQL Server 2022

_Release Date:_ &nbsp; May 16, 2024  
_Version:_ &nbsp; 16.0.4125.3

## Summary

This article describes Cumulative Update package 13 (CU13) for Microsoft SQL Server 2022. This update contains 15 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 12, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4125.3**, file version: **2022.160.4125.3**
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

### Issue one: Patching error for secondary replicas in an availability group with databases enabled replication, CDC, or SSISDB

[!INCLUDE [patching-error-2022](../includes/patching-error-2022.md)]

### Issue two: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

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
| <a id=2810754>[2810754](#2810754) </a> | [FIX: Can't disable "change data capture" if any column is encrypted by "Always Encrypted" feature in SQL Server (KB4034376)](https://support.microsoft.com/help/4034376)| SQL Server Engine | Replication | All|
| <a id=3003456>[3003456](#3003456) </a> | Fixes an issue in which some changes might not be captured into the change data capture (CDC) change tables (*cdc.\<capture_instance>_CT*) when CDC runs in parallel with a switch partition operation. | SQL Server Engine | Replication | All|
| <a id=3015714>[3015714](#3015714) </a> | Fixes the following error that you encounter when running `sys.sp_flush_CT_internal_table_on_demand` in a SQL Server instance that has the Case-sensitive (_CS) collation option: </br></br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Msg 137, Level 15, State 2, Procedure sp_ManualCTCleanup, Line \<LineNumber> [Batch Start Line 3] </br>Must declare the scalar variable "@TableName". </br>Total rows deleted: (null). </br>Total rows deleted: (null).| SQL Server Engine | Replication | All|
| <a id=3033974>[3033974](#3033974) </a> | Adds the error message to the **comments** column of `dbo.MSchange_tracking_history` to help you understand the failure if a failure occurs during the auto cleanup or manual cleanup process.| SQL Server Engine | Replication | All|
| <a id=3144736>[3144736](#3144736) </a> | Fixes an error that you encounter when using conversation timers in Service Broker while the SQL Server instance is under memory pressure. This causes queries to fail and the instance to stop responding.| SQL Server Engine | Replication | Windows|
| <a id=3071580>[3071580](#3071580) </a> | Fixes an issue in which the full-text auto crawl function might stop working when you use full-text search. | SQL Server Engine | Search| All|
| <a id=2979492>[2979492](#2979492) </a> | Fixes the following error that you encounter when updating a view with a linked server connection to another instance if dynamic data masking (DDM) is enabled: </br></br>Msg 15905, Level 16, State 6, Procedure \<ProcedureName>, Line \<LineNumber> [Batch Start Line 34] </br>Query not supported: Cannot determine result column sources.Invalid metadata. | SQL Server Engine | Security Infrastructure | All|
| <a id=3033535>[3033535](#3033535) </a> | Adds the following log message when high I/O latencies are detected in Bufferpool Lazy Writer (`ntdll!ZwWriteFile` system call) due to a performance issue in the underlying storage: </br></br>WARNING Long asynchronous API Call: The scheduling fairness of scheduler can be impacted by an asynchronous API invocation unexpectedly exceeding xxx ms. | SQL Server Engine | SQL OS| All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

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
|SQLServer2022-KB5036432-x64.exe| E78D2CF147BB596017615D50A5AB8CF3812A718AAB85CAB6C08C34A50D5935FB |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 01-May-2024 | 15:34 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.233 | 336944    | 01-May-2024 | 15:34 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 01-May-2024 | 15:34 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.233     | 865216    | 01-May-2024 | 15:34 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.233     | 2903488   | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 01-May-2024 | 15:34 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 01-May-2024 | 15:34 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 01-May-2024 | 15:34 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 01-May-2024 | 15:34 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 01-May-2024 | 15:34 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 01-May-2024 | 15:34 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 01-May-2024 | 15:34 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 01-May-2024 | 15:34 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 01-May-2024 | 15:34 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 01-May-2024 | 15:34 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 01-May-2024 | 15:34 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 01-May-2024 | 15:34 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 01-May-2024 | 15:34 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 01-May-2024 | 15:34 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 01-May-2024 | 15:34 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 01-May-2024 | 15:34 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 01-May-2024 | 15:34 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 01-May-2024 | 15:34 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 01-May-2024 | 15:34 | x86      |
| Msmdctr.dll                                         | 2022.160.43.233 | 38864     | 01-May-2024 | 15:34 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 53976120  | 01-May-2024 | 15:34 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.233 | 71818688  | 01-May-2024 | 15:34 | x64      |
| Msmdpump.dll                                        | 2022.160.43.233 | 10333744  | 01-May-2024 | 15:34 | x64      |
| Msmdredir.dll                                       | 2022.160.43.233 | 8132032   | 01-May-2024 | 15:34 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.233 | 71367216  | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 956992    | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1884720   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1671728   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1881152   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1848360   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1147440   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1140280   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1769520   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1749040   | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 932912    | 01-May-2024 | 15:34 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.233 | 1837616   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 955456    | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1882672   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1668656   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1876528   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1844784   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1145392   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1138752   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1765440   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1745456   | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 933424    | 01-May-2024 | 15:34 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.233 | 1833008   | 01-May-2024 | 15:34 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 8265280   | 01-May-2024 | 15:34 | x86      |
| Msmgdsrv.dll                                        | 2022.160.43.233 | 10083392  | 01-May-2024 | 15:34 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 10969648  | 01-May-2024 | 15:34 | x64      |
| Msolap.dll                                          | 2022.160.43.233 | 8743880   | 01-May-2024 | 15:34 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 289840    | 01-May-2024 | 15:34 | x86      |
| Msolui.dll                                          | 2022.160.43.233 | 308264    | 01-May-2024 | 15:34 | x64      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 01-May-2024 | 15:34 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 01-May-2024 | 15:34 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 01-May-2024 | 15:34 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 01-May-2024 | 15:34 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 01-May-2024 | 15:34 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 01-May-2024 | 15:34 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:34 | x64      |
| Sqlceip.exe                                         | 16.0.4125.3     | 301096    | 01-May-2024 | 15:34 | x86      |
| Sqldumper.exe                                       | 2022.160.4125.3 | 378920    | 01-May-2024 | 15:34 | x86      |
| Sqldumper.exe                                       | 2022.160.4125.3 | 448448    | 01-May-2024 | 15:34 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 01-May-2024 | 15:34 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 01-May-2024 | 15:34 | x86      |
| Tmapi.dll                                           | 2022.160.43.233 | 5884480   | 01-May-2024 | 15:34 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.233 | 5575216   | 01-May-2024 | 15:34 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.233 | 1481264   | 01-May-2024 | 15:34 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.233 | 7198264   | 01-May-2024 | 15:34 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 26593232  | 01-May-2024 | 15:34 | x64      |
| Xmsrv.dll                                           | 2022.160.43.233 | 35895856  | 01-May-2024 | 15:34 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4125.3 | 79928     | 01-May-2024 | 15:35 | x86      |
| Instapi150.dll                             | 2022.160.4125.3 | 104504    | 01-May-2024 | 15:35 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633776   | 01-May-2024 | 15:35 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.233     | 2633784   | 01-May-2024 | 15:35 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.233     | 2933296   | 01-May-2024 | 15:35 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.233     | 2323520   | 01-May-2024 | 15:35 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4125.3 | 104376    | 01-May-2024 | 15:35 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4125.3 | 92096     | 01-May-2024 | 15:35 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4125.3     | 554944    | 01-May-2024 | 15:35 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4125.3     | 554960    | 01-May-2024 | 15:35 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 27696     | 01-May-2024 | 15:35 | x86      |
| Msasxpress.dll                             | 2022.160.43.233 | 32816     | 01-May-2024 | 15:35 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:35 | x64      |
| Sqldumper.exe                              | 2022.160.4125.3 | 378920    | 01-May-2024 | 15:35 | x86      |
| Sqldumper.exe                              | 2022.160.4125.3 | 448448    | 01-May-2024 | 15:35 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4125.3 | 395320    | 01-May-2024 | 15:35 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4125.3 | 456744    | 01-May-2024 | 15:35 | x64      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4125.3     | 309184    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4125.3     | 2070584   | 01-May-2024 | 15:35 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:35 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4125.3  | 600000    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4125.3  | 600120    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4125.3  | 174016    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4125.3  | 174136    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4125.3  | 1857488   | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4125.3  | 1857576   | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4125.3  | 370624    | 01-May-2024 | 15:35 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4125.3  | 370744    | 01-May-2024 | 15:35 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 01-May-2024 | 18:22 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 01-May-2024 | 18:22 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4125.3 | 5994536   | 01-May-2024 | 18:22 | x64      |
| Aetm-enclave.dll                             | 2022.160.4125.3 | 5959688   | 01-May-2024 | 18:22 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4125.3 | 6194792   | 01-May-2024 | 18:22 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4125.3 | 6160696   | 01-May-2024 | 18:22 | x64      |
| Dcexec.exe                                   | 2022.160.4125.3 | 96192     | 01-May-2024 | 18:22 | x64      |
| Fssres.dll                                   | 2022.160.4125.3 | 100392    | 01-May-2024 | 18:22 | x64      |
| Hadrres.dll                                  | 2022.160.4125.3 | 227264    | 01-May-2024 | 18:22 | x64      |
| Hkcompile.dll                                | 2022.160.4125.3 | 1411112   | 01-May-2024 | 18:22 | x64      |
| Hkengine.dll                                 | 2022.160.4125.3 | 5769272   | 01-May-2024 | 18:22 | x64      |
| Hkruntime.dll                                | 2022.160.4125.3 | 190416    | 01-May-2024 | 18:22 | x64      |
| Hktempdb.dll                                 | 2022.160.4125.3 | 71616     | 01-May-2024 | 18:22 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.233     | 2322480   | 01-May-2024 | 18:22 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4125.3 | 333880    | 01-May-2024 | 18:22 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4125.3 | 96312     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 30656     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 38848     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 34768     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 38848     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 38864     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 30664     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 30760     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 34752     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 38848     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 30672     | 01-May-2024 | 18:22 | x64      |
| Odsole70.rll                                 | 16.0.4125.3     | 38864     | 01-May-2024 | 18:22 | x64      |
| Qds.dll                                      | 2022.160.4125.3 | 1808336   | 01-May-2024 | 18:22 | x64      |
| Rsfxft.dll                                   | 2022.160.4125.3 | 55336     | 01-May-2024 | 18:22 | x64      |
| Secforwarder.dll                             | 2022.160.4125.3 | 83904     | 01-May-2024 | 18:22 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4125.3 | 137272    | 01-May-2024 | 18:22 | x64      |
| Sqlaamss.dll                                 | 2022.160.4125.3 | 120888    | 01-May-2024 | 18:22 | x64      |
| Sqlaccess.dll                                | 2022.160.4125.3 | 444472    | 01-May-2024 | 18:22 | x64      |
| Sqlagent.exe                                 | 2022.160.4125.3 | 718888    | 01-May-2024 | 18:22 | x64      |
| Sqlceip.exe                                  | 16.0.4125.3     | 301096    | 01-May-2024 | 18:22 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4125.3 | 104488    | 01-May-2024 | 18:22 | x64      |
| Sqlctr160.dll                                | 2022.160.4125.3 | 157752    | 01-May-2024 | 18:22 | x64      |
| Sqlctr160.dll                                | 2022.160.4125.3 | 129064    | 01-May-2024 | 18:22 | x86      |
| Sqldk.dll                                    | 2022.160.4125.3 | 4020160   | 01-May-2024 | 18:22 | x64      |
| Sqldtsss.dll                                 | 2022.160.4125.3 | 120768    | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 1755192   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3860520   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4077608   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4585528   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4716600   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3762216   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3946552   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4585512   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4417576   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4487224   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 2451512   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 2394152   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4274232   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3905576   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4425664   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4216872   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4200488   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3983416   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 3860520   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 1689656   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4311096   | 01-May-2024 | 18:22 | x64      |
| Sqlevn70.rll                                 | 2022.160.4125.3 | 4450344   | 01-May-2024 | 18:22 | x64      |
| Sqliosim.com                                 | 2022.160.4125.3 | 387112    | 01-May-2024 | 18:22 | x64      |
| Sqliosim.exe                                 | 2022.160.4125.3 | 3057704   | 01-May-2024 | 18:22 | x64      |
| Sqllang.dll                                  | 2022.160.4125.3 | 48773056  | 01-May-2024 | 18:22 | x64      |
| Sqlmin.dll                                   | 2022.160.4125.3 | 51242960  | 01-May-2024 | 18:22 | x64      |
| Sqlolapss.dll                                | 2022.160.4125.3 | 116776    | 01-May-2024 | 18:22 | x64      |
| Sqlos.dll                                    | 2022.160.4125.3 | 51240     | 01-May-2024 | 18:22 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4125.3 | 100392    | 01-May-2024 | 18:22 | x64      |
| Sqlrepss.dll                                 | 2022.160.4125.3 | 141368    | 01-May-2024 | 18:22 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4125.3 | 51240     | 01-May-2024 | 18:22 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4125.3 | 5834792   | 01-May-2024 | 18:22 | x64      |
| Sqlservr.exe                                 | 2022.160.4125.3 | 722984    | 01-May-2024 | 18:22 | x64      |
| Sqlsvc.dll                                   | 2022.160.4125.3 | 194512    | 01-May-2024 | 18:22 | x64      |
| Sqltses.dll                                  | 2022.160.4125.3 | 10667968  | 01-May-2024 | 18:22 | x64      |
| Sqsrvres.dll                                 | 2022.160.4125.3 | 305088    | 01-May-2024 | 18:22 | x64      |
| Svl.dll                                      | 2022.160.4125.3 | 247848    | 01-May-2024 | 18:22 | x64      |
| Xe.dll                                       | 2022.160.4125.3 | 718784    | 01-May-2024 | 18:22 | x64      |
| Xpqueue.dll                                  | 2022.160.4125.3 | 100392    | 01-May-2024 | 18:22 | x64      |
| Xpstar.dll                                   | 2022.160.4125.3 | 534480    | 01-May-2024 | 18:22 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 01-May-2024 | 15:34 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 01-May-2024 | 15:34 | x86      |
| Bcp.exe                                              | 2022.160.4125.3  | 141352    | 01-May-2024 | 15:34 | x64      |
| Commanddest.dll                                      | 2022.160.4125.3  | 272424    | 01-May-2024 | 15:34 | x64      |
| Datacollectortasks.dll                               | 2022.160.4125.3  | 227368    | 01-May-2024 | 15:34 | x64      |
| Distrib.exe                                          | 2022.160.4125.3  | 260152    | 01-May-2024 | 15:34 | x64      |
| Dteparse.dll                                         | 2022.160.4125.3  | 133160    | 01-May-2024 | 15:34 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4125.3  | 178232    | 01-May-2024 | 15:34 | x64      |
| Dtepkg.dll                                           | 2022.160.4125.3  | 153640    | 01-May-2024 | 15:34 | x64      |
| Dtexec.exe                                           | 2022.160.4125.3  | 76856     | 01-May-2024 | 15:34 | x64      |
| Dts.dll                                              | 2022.160.4125.3  | 3266496   | 01-May-2024 | 15:34 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4125.3  | 493624    | 01-May-2024 | 15:34 | x64      |
| Dtsconn.dll                                          | 2022.160.4125.3  | 550848    | 01-May-2024 | 15:34 | x64      |
| Dtshost.exe                                          | 2022.160.4125.3  | 120376    | 01-May-2024 | 15:34 | x64      |
| Dtslog.dll                                           | 2022.160.4125.3  | 137256    | 01-May-2024 | 15:34 | x64      |
| Dtspipeline.dll                                      | 2022.160.4125.3  | 1337296   | 01-May-2024 | 15:34 | x64      |
| Dtuparse.dll                                         | 2022.160.4125.3  | 104488    | 01-May-2024 | 15:34 | x64      |
| Dtutil.exe                                           | 2022.160.4125.3  | 166440    | 01-May-2024 | 15:34 | x64      |
| Exceldest.dll                                        | 2022.160.4125.3  | 284712    | 01-May-2024 | 15:34 | x64      |
| Excelsrc.dll                                         | 2022.160.4125.3  | 305192    | 01-May-2024 | 15:34 | x64      |
| Execpackagetask.dll                                  | 2022.160.4125.3  | 182328    | 01-May-2024 | 15:34 | x64      |
| Flatfiledest.dll                                     | 2022.160.4125.3  | 423888    | 01-May-2024 | 15:34 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4125.3  | 440256    | 01-May-2024 | 15:34 | x64      |
| Logread.exe                                          | 2022.160.4125.3  | 792616    | 01-May-2024 | 15:34 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.233      | 2933816   | 01-May-2024 | 15:34 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 01-May-2024 | 15:34 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 01-May-2024 | 15:34 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 01-May-2024 | 15:34 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4125.3      | 30656     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 01-May-2024 | 15:34 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 01-May-2024 | 15:34 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4125.3      | 391224    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4125.3  | 1710016   | 01-May-2024 | 15:34 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4125.3      | 554960    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 01-May-2024 | 15:34 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4125.3  | 124968    | 01-May-2024 | 15:34 | x64      |
| Msgprox.dll                                          | 2022.160.4125.3  | 313400    | 01-May-2024 | 15:34 | x64      |
| Msoledbsql.dll                                       | 2018.187.2.0     | 2754584   | 01-May-2024 | 15:34 | x64      |
| Msoledbsql.dll                                       | 2018.187.2.0     | 153624    | 01-May-2024 | 15:34 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 01-May-2024 | 15:34 | x86      |
| Oledbdest.dll                                        | 2022.160.4125.3  | 288808    | 01-May-2024 | 15:34 | x64      |
| Oledbsrc.dll                                         | 2022.160.4125.3  | 313384    | 01-May-2024 | 15:34 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4125.3  | 526376    | 01-May-2024 | 15:34 | x64      |
| Rawdest.dll                                          | 2022.160.4125.3  | 227368    | 01-May-2024 | 15:34 | x64      |
| Rawsource.dll                                        | 2022.160.4125.3  | 215080    | 01-May-2024 | 15:34 | x64      |
| Rdistcom.dll                                         | 2022.160.4125.3  | 940088    | 01-May-2024 | 15:34 | x64      |
| Recordsetdest.dll                                    | 2022.160.4125.3  | 206888    | 01-May-2024 | 15:34 | x64      |
| Repldp.dll                                           | 2022.160.4125.3  | 337976    | 01-May-2024 | 15:34 | x64      |
| Replerrx.dll                                         | 2022.160.4125.3  | 198696    | 01-May-2024 | 15:34 | x64      |
| Replisapi.dll                                        | 2022.160.4125.3  | 419776    | 01-May-2024 | 15:34 | x64      |
| Replmerg.exe                                         | 2022.160.4125.3  | 596008    | 01-May-2024 | 15:34 | x64      |
| Replprov.dll                                         | 2022.160.4125.3  | 890920    | 01-May-2024 | 15:34 | x64      |
| Replrec.dll                                          | 2022.160.4125.3  | 1058768   | 01-May-2024 | 15:34 | x64      |
| Replsub.dll                                          | 2022.160.4125.3  | 501816    | 01-May-2024 | 15:34 | x64      |
| Spresolv.dll                                         | 2022.160.4125.3  | 300992    | 01-May-2024 | 15:34 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4125.3  | 137272    | 01-May-2024 | 15:34 | x64      |
| Sqlcmd.exe                                           | 2022.160.4125.3  | 276536    | 01-May-2024 | 15:34 | x64      |
| Sqldiag.exe                                          | 2022.160.4125.3  | 1140792   | 01-May-2024 | 15:34 | x64      |
| Sqldistx.dll                                         | 2022.160.4125.3  | 268328    | 01-May-2024 | 15:34 | x64      |
| Sqlmergx.dll                                         | 2022.160.4125.3  | 423976    | 01-May-2024 | 15:34 | x64      |
| Sqlsvc.dll                                           | 2022.160.4125.3  | 194512    | 01-May-2024 | 15:34 | x64      |
| Sqlsvc.dll                                           | 2022.160.4125.3  | 153640    | 01-May-2024 | 15:34 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4125.3  | 210984    | 01-May-2024 | 15:34 | x64      |
| Ssradd.dll                                           | 2022.160.4125.3  | 100392    | 01-May-2024 | 15:34 | x64      |
| Ssravg.dll                                           | 2022.160.4125.3  | 100392    | 01-May-2024 | 15:34 | x64      |
| Ssrmax.dll                                           | 2022.160.4125.3  | 100392    | 01-May-2024 | 15:34 | x64      |
| Ssrmin.dll                                           | 2022.160.4125.3  | 100304    | 01-May-2024 | 15:34 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 01-May-2024 | 15:34 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 01-May-2024 | 15:34 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 01-May-2024 | 15:34 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 01-May-2024 | 15:34 | x86      |
| Txagg.dll                                            | 2022.160.4125.3  | 395320    | 01-May-2024 | 15:34 | x64      |
| Txbdd.dll                                            | 2022.160.4125.3  | 190504    | 01-May-2024 | 15:34 | x64      |
| Txdatacollector.dll                                  | 2022.160.4125.3  | 469032    | 01-May-2024 | 15:34 | x64      |
| Txdataconvert.dll                                    | 2022.160.4125.3  | 333760    | 01-May-2024 | 15:34 | x64      |
| Txderived.dll                                        | 2022.160.4125.3  | 632888    | 01-May-2024 | 15:34 | x64      |
| Txlookup.dll                                         | 2022.160.4125.3  | 608192    | 01-May-2024 | 15:34 | x64      |
| Txmerge.dll                                          | 2022.160.4125.3  | 243752    | 01-May-2024 | 15:34 | x64      |
| Txmergejoin.dll                                      | 2022.160.4125.3  | 301096    | 01-May-2024 | 15:34 | x64      |
| Txmulticast.dll                                      | 2022.160.4125.3  | 145344    | 01-May-2024 | 15:34 | x64      |
| Txrowcount.dll                                       | 2022.160.4125.3  | 145344    | 01-May-2024 | 15:34 | x64      |
| Txsort.dll                                           | 2022.160.4125.3  | 276520    | 01-May-2024 | 15:34 | x64      |
| Txsplit.dll                                          | 2022.160.4125.3  | 620584    | 01-May-2024 | 15:34 | x64      |
| Txunionall.dll                                       | 2022.160.4125.3  | 194600    | 01-May-2024 | 15:34 | x64      |
| Xe.dll                                               | 2022.160.4125.3  | 718784    | 01-May-2024 | 15:34 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4125.3 | 100408    | 01-May-2024 | 15:35 | x64      |
| Exthost.exe                   | 2022.160.4125.3 | 247848    | 01-May-2024 | 15:35 | x64      |
| Launchpad.exe                 | 2022.160.4125.3 | 1447888   | 01-May-2024 | 15:35 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:35 | x64      |
| Sqlsatellite.dll              | 2022.160.4125.3 | 1255376   | 01-May-2024 | 15:35 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4125.3 | 710696    | 01-May-2024 | 15:35 | x64      |
| Fdhost.exe               | 2022.160.4125.3 | 153640    | 01-May-2024 | 15:35 | x64      |
| Fdlauncher.exe           | 2022.160.4125.3 | 100304    | 01-May-2024 | 15:35 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:35 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 01-May-2024 | 15:32 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 01-May-2024 | 15:34 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 01-May-2024 | 15:32 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 01-May-2024 | 15:34 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 01-May-2024 | 15:32 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 01-May-2024 | 15:34 | x86      |
| Commanddest.dll                                               | 2022.160.4125.3 | 231480    | 01-May-2024 | 15:32 | x86      |
| Commanddest.dll                                               | 2022.160.4125.3 | 272424    | 01-May-2024 | 15:34 | x64      |
| Dteparse.dll                                                  | 2022.160.4125.3 | 116776    | 01-May-2024 | 15:32 | x86      |
| Dteparse.dll                                                  | 2022.160.4125.3 | 133160    | 01-May-2024 | 15:34 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4125.3 | 165944    | 01-May-2024 | 15:32 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4125.3 | 178232    | 01-May-2024 | 15:34 | x64      |
| Dtepkg.dll                                                    | 2022.160.4125.3 | 129080    | 01-May-2024 | 15:32 | x86      |
| Dtepkg.dll                                                    | 2022.160.4125.3 | 153640    | 01-May-2024 | 15:34 | x64      |
| Dtexec.exe                                                    | 2022.160.4125.3 | 65064     | 01-May-2024 | 15:32 | x86      |
| Dtexec.exe                                                    | 2022.160.4125.3 | 76856     | 01-May-2024 | 15:34 | x64      |
| Dts.dll                                                       | 2022.160.4125.3 | 2861112   | 01-May-2024 | 15:32 | x86      |
| Dts.dll                                                       | 2022.160.4125.3 | 3266496   | 01-May-2024 | 15:34 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4125.3 | 444456    | 01-May-2024 | 15:32 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4125.3 | 493624    | 01-May-2024 | 15:34 | x64      |
| Dtsconn.dll                                                   | 2022.160.4125.3 | 464936    | 01-May-2024 | 15:32 | x86      |
| Dtsconn.dll                                                   | 2022.160.4125.3 | 550848    | 01-May-2024 | 15:34 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4125.3 | 94776     | 01-May-2024 | 15:32 | x86      |
| Dtsdebughost.exe                                              | 2022.160.4125.3 | 114640    | 01-May-2024 | 15:34 | x64      |
| Dtshost.exe                                                   | 2022.160.4125.3 | 98344     | 01-May-2024 | 15:32 | x86      |
| Dtshost.exe                                                   | 2022.160.4125.3 | 120376    | 01-May-2024 | 15:34 | x64      |
| Dtslog.dll                                                    | 2022.160.4125.3 | 120872    | 01-May-2024 | 15:32 | x86      |
| Dtslog.dll                                                    | 2022.160.4125.3 | 137256    | 01-May-2024 | 15:34 | x64      |
| Dtspipeline.dll                                               | 2022.160.4125.3 | 1144768   | 01-May-2024 | 15:32 | x86      |
| Dtspipeline.dll                                               | 2022.160.4125.3 | 1337296   | 01-May-2024 | 15:34 | x64      |
| Dtuparse.dll                                                  | 2022.160.4125.3 | 88104     | 01-May-2024 | 15:32 | x86      |
| Dtuparse.dll                                                  | 2022.160.4125.3 | 104488    | 01-May-2024 | 15:34 | x64      |
| Dtutil.exe                                                    | 2022.160.4125.3 | 142376    | 01-May-2024 | 15:32 | x86      |
| Dtutil.exe                                                    | 2022.160.4125.3 | 166440    | 01-May-2024 | 15:34 | x64      |
| Exceldest.dll                                                 | 2022.160.4125.3 | 247864    | 01-May-2024 | 15:32 | x86      |
| Exceldest.dll                                                 | 2022.160.4125.3 | 284712    | 01-May-2024 | 15:34 | x64      |
| Excelsrc.dll                                                  | 2022.160.4125.3 | 264248    | 01-May-2024 | 15:32 | x86      |
| Excelsrc.dll                                                  | 2022.160.4125.3 | 305192    | 01-May-2024 | 15:34 | x64      |
| Execpackagetask.dll                                           | 2022.160.4125.3 | 149560    | 01-May-2024 | 15:32 | x86      |
| Execpackagetask.dll                                           | 2022.160.4125.3 | 182328    | 01-May-2024 | 15:34 | x64      |
| Flatfiledest.dll                                              | 2022.160.4125.3 | 374824    | 01-May-2024 | 15:32 | x86      |
| Flatfiledest.dll                                              | 2022.160.4125.3 | 423888    | 01-May-2024 | 15:34 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4125.3 | 391208    | 01-May-2024 | 15:32 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4125.3 | 440256    | 01-May-2024 | 15:34 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4125.3     | 120872    | 01-May-2024 | 15:34 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4125.3     | 120872    | 01-May-2024 | 15:34 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933824   | 01-May-2024 | 15:32 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.233     | 2933816   | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4125.3     | 509992    | 01-May-2024 | 15:32 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4125.3     | 509992    | 01-May-2024 | 15:34 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4125.3     | 391224    | 01-May-2024 | 15:34 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4125.3     | 219176    | 01-May-2024 | 15:34 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4125.3 | 100392    | 01-May-2024 | 15:32 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4125.3 | 124968    | 01-May-2024 | 15:34 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.233 | 10164160  | 01-May-2024 | 15:34 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 01-May-2024 | 15:32 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 01-May-2024 | 15:34 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 01-May-2024 | 15:34 | x86      |
| Odbcdest.dll                                                  | 2022.160.4125.3 | 342072    | 01-May-2024 | 15:32 | x86      |
| Odbcdest.dll                                                  | 2022.160.4125.3 | 382912    | 01-May-2024 | 15:34 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4125.3 | 350248    | 01-May-2024 | 15:32 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4125.3 | 399400    | 01-May-2024 | 15:34 | x64      |
| Oledbdest.dll                                                 | 2022.160.4125.3 | 247848    | 01-May-2024 | 15:32 | x86      |
| Oledbdest.dll                                                 | 2022.160.4125.3 | 288808    | 01-May-2024 | 15:34 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4125.3 | 268344    | 01-May-2024 | 15:32 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4125.3 | 313384    | 01-May-2024 | 15:34 | x64      |
| Rawdest.dll                                                   | 2022.160.4125.3 | 190520    | 01-May-2024 | 15:32 | x86      |
| Rawdest.dll                                                   | 2022.160.4125.3 | 227368    | 01-May-2024 | 15:34 | x64      |
| Rawsource.dll                                                 | 2022.160.4125.3 | 186408    | 01-May-2024 | 15:32 | x86      |
| Rawsource.dll                                                 | 2022.160.4125.3 | 215080    | 01-May-2024 | 15:34 | x64      |
| Recordsetdest.dll                                             | 2022.160.4125.3 | 174136    | 01-May-2024 | 15:32 | x86      |
| Recordsetdest.dll                                             | 2022.160.4125.3 | 206888    | 01-May-2024 | 15:34 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4125.3 | 137272    | 01-May-2024 | 15:34 | x64      |
| Sqlceip.exe                                                   | 16.0.4125.3     | 301096    | 01-May-2024 | 15:34 | x86      |
| Sqldest.dll                                                   | 2022.160.4125.3 | 256040    | 01-May-2024 | 15:32 | x86      |
| Sqldest.dll                                                   | 2022.160.4125.3 | 288808    | 01-May-2024 | 15:34 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4125.3 | 174136    | 01-May-2024 | 15:32 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4125.3 | 210984    | 01-May-2024 | 15:34 | x64      |
| Txagg.dll                                                     | 2022.160.4125.3 | 346152    | 01-May-2024 | 15:32 | x86      |
| Txagg.dll                                                     | 2022.160.4125.3 | 395320    | 01-May-2024 | 15:34 | x64      |
| Txbdd.dll                                                     | 2022.160.4125.3 | 149560    | 01-May-2024 | 15:32 | x86      |
| Txbdd.dll                                                     | 2022.160.4125.3 | 190504    | 01-May-2024 | 15:34 | x64      |
| Txbestmatch.dll                                               | 2022.160.4125.3 | 567336    | 01-May-2024 | 15:32 | x86      |
| Txbestmatch.dll                                               | 2022.160.4125.3 | 661440    | 01-May-2024 | 15:34 | x64      |
| Txcache.dll                                                   | 2022.160.4125.3 | 170040    | 01-May-2024 | 15:32 | x86      |
| Txcache.dll                                                   | 2022.160.4125.3 | 202808    | 01-May-2024 | 15:34 | x64      |
| Txcharmap.dll                                                 | 2022.160.4125.3 | 280616    | 01-May-2024 | 15:32 | x86      |
| Txcharmap.dll                                                 | 2022.160.4125.3 | 325568    | 01-May-2024 | 15:34 | x64      |
| Txcopymap.dll                                                 | 2022.160.4125.3 | 165944    | 01-May-2024 | 15:32 | x86      |
| Txcopymap.dll                                                 | 2022.160.4125.3 | 202792    | 01-May-2024 | 15:34 | x64      |
| Txdataconvert.dll                                             | 2022.160.4125.3 | 288808    | 01-May-2024 | 15:32 | x86      |
| Txdataconvert.dll                                             | 2022.160.4125.3 | 333760    | 01-May-2024 | 15:34 | x64      |
| Txderived.dll                                                 | 2022.160.4125.3 | 559144    | 01-May-2024 | 15:32 | x86      |
| Txderived.dll                                                 | 2022.160.4125.3 | 632888    | 01-May-2024 | 15:34 | x64      |
| Txfileextractor.dll                                           | 2022.160.4125.3 | 186408    | 01-May-2024 | 15:32 | x86      |
| Txfileextractor.dll                                           | 2022.160.4125.3 | 219176    | 01-May-2024 | 15:34 | x64      |
| Txfileinserter.dll                                            | 2022.160.4125.3 | 186408    | 01-May-2024 | 15:32 | x86      |
| Txfileinserter.dll                                            | 2022.160.4125.3 | 219176    | 01-May-2024 | 15:34 | x64      |
| Txgroupdups.dll                                               | 2022.160.4125.3 | 354344    | 01-May-2024 | 15:32 | x86      |
| Txgroupdups.dll                                               | 2022.160.4125.3 | 403392    | 01-May-2024 | 15:34 | x64      |
| Txlineage.dll                                                 | 2022.160.4125.3 | 129064    | 01-May-2024 | 15:32 | x86      |
| Txlineage.dll                                                 | 2022.160.4125.3 | 157752    | 01-May-2024 | 15:34 | x64      |
| Txlookup.dll                                                  | 2022.160.4125.3 | 522280    | 01-May-2024 | 15:32 | x86      |
| Txlookup.dll                                                  | 2022.160.4125.3 | 608192    | 01-May-2024 | 15:34 | x64      |
| Txmerge.dll                                                   | 2022.160.4125.3 | 194616    | 01-May-2024 | 15:32 | x86      |
| Txmerge.dll                                                   | 2022.160.4125.3 | 243752    | 01-May-2024 | 15:34 | x64      |
| Txmergejoin.dll                                               | 2022.160.4125.3 | 256040    | 01-May-2024 | 15:32 | x86      |
| Txmergejoin.dll                                               | 2022.160.4125.3 | 301096    | 01-May-2024 | 15:34 | x64      |
| Txmulticast.dll                                               | 2022.160.4125.3 | 116776    | 01-May-2024 | 15:32 | x86      |
| Txmulticast.dll                                               | 2022.160.4125.3 | 145344    | 01-May-2024 | 15:34 | x64      |
| Txpivot.dll                                                   | 2022.160.4125.3 | 198712    | 01-May-2024 | 15:32 | x86      |
| Txpivot.dll                                                   | 2022.160.4125.3 | 239656    | 01-May-2024 | 15:34 | x64      |
| Txrowcount.dll                                                | 2022.160.4125.3 | 116776    | 01-May-2024 | 15:32 | x86      |
| Txrowcount.dll                                                | 2022.160.4125.3 | 145344    | 01-May-2024 | 15:34 | x64      |
| Txsampling.dll                                                | 2022.160.4125.3 | 153656    | 01-May-2024 | 15:32 | x86      |
| Txsampling.dll                                                | 2022.160.4125.3 | 186408    | 01-May-2024 | 15:34 | x64      |
| Txscd.dll                                                     | 2022.160.4125.3 | 198696    | 01-May-2024 | 15:32 | x86      |
| Txscd.dll                                                     | 2022.160.4125.3 | 235560    | 01-May-2024 | 15:34 | x64      |
| Txsort.dll                                                    | 2022.160.4125.3 | 231464    | 01-May-2024 | 15:32 | x86      |
| Txsort.dll                                                    | 2022.160.4125.3 | 276520    | 01-May-2024 | 15:34 | x64      |
| Txsplit.dll                                                   | 2022.160.4125.3 | 550952    | 01-May-2024 | 15:32 | x86      |
| Txsplit.dll                                                   | 2022.160.4125.3 | 620584    | 01-May-2024 | 15:34 | x64      |
| Txtermextraction.dll                                          | 2022.160.4125.3 | 8648744   | 01-May-2024 | 15:32 | x86      |
| Txtermextraction.dll                                          | 2022.160.4125.3 | 8701992   | 01-May-2024 | 15:34 | x64      |
| Txtermlookup.dll                                              | 2022.160.4125.3 | 4138944   | 01-May-2024 | 15:32 | x86      |
| Txtermlookup.dll                                              | 2022.160.4125.3 | 4184104   | 01-May-2024 | 15:34 | x64      |
| Txunionall.dll                                                | 2022.160.4125.3 | 153640    | 01-May-2024 | 15:32 | x86      |
| Txunionall.dll                                                | 2022.160.4125.3 | 194600    | 01-May-2024 | 15:34 | x64      |
| Txunpivot.dll                                                 | 2022.160.4125.3 | 178216    | 01-May-2024 | 15:32 | x86      |
| Txunpivot.dll                                                 | 2022.160.4125.3 | 215096    | 01-May-2024 | 15:34 | x64      |
| Xe.dll                                                        | 2022.160.4125.3 | 641064    | 01-May-2024 | 15:32 | x86      |
| Xe.dll                                                        | 2022.160.4125.3 | 718784    | 01-May-2024 | 15:34 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1035.0     | 559688    | 01-May-2024 | 18:04 | x86      |
| Dmsnative.dll                                                        | 2022.160.1035.0 | 152632    | 01-May-2024 | 18:04 | x64      |
| Dwengineservice.dll                                                  | 16.0.1035.0     | 45016     | 01-May-2024 | 18:04 | x86      |
| Instapi150.dll                                                       | 2022.160.4125.3 | 104504    | 01-May-2024 | 18:04 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1035.0     | 67528     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1035.0     | 293320    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1035.0     | 1958360   | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1035.0     | 169424    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1035.0     | 647224    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1035.0     | 246216    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1035.0     | 139320    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1035.0     | 79944     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1035.0     | 51272     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1035.0     | 88632     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1035.0     | 1129432   | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1035.0     | 80952     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1035.0     | 70712     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1035.0     | 35272     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1035.0     | 31304     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1035.0     | 46552     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1035.0     | 21560     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1035.0     | 26584     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1035.0     | 131640    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1035.0     | 86480     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1035.0     | 100936    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1035.0     | 293336    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 120280    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 138296    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 141384    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 137672    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 150488    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 139736    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 134616    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 176696    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 117704    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1035.0     | 136664    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1035.0     | 72760     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1035.0     | 22072     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1035.0     | 37320     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1035.0     | 128968    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1035.0     | 3064776   | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1035.0     | 3955768   | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 118344    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133176    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 137784    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 133688    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 148536    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 134200    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 130616    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 171064    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 115256    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1035.0     | 132152    | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1035.0     | 67544     | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1035.0     | 2682840   | 01-May-2024 | 18:04 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1035.0     | 2436552   | 01-May-2024 | 18:04 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4125.3 | 296896    | 01-May-2024 | 18:04 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4125.3 | 9074624   | 01-May-2024 | 18:04 | x64      |
| Secforwarder.dll                                                     | 2022.160.4125.3 | 83904     | 01-May-2024 | 18:04 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1035.0 | 61400     | 01-May-2024 | 18:04 | x64      |
| Sqldk.dll                                                            | 2022.160.4125.3 | 4020160   | 01-May-2024 | 18:04 | x64      |
| Sqldumper.exe                                                        | 2022.160.4125.3 | 448448    | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 1755192   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4585528   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 3762216   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4585512   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4487224   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 2451512   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 2394152   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4216872   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4200488   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 1689656   | 01-May-2024 | 18:04 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4125.3 | 4450344   | 01-May-2024 | 18:04 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 01-May-2024 | 18:04 | x64      |
| Sqlos.dll                                                            | 2022.160.4125.3 | 51240     | 01-May-2024 | 18:04 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1035.0 | 4841528   | 01-May-2024 | 18:04 | x64      |
| Sqltses.dll                                                          | 2022.160.4125.3 | 10667968  | 01-May-2024 | 18:04 | x64      |

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
