---
title: Cumulative update 21 for SQL Server 2022 (KB5065865)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 cumulative update 21 (KB5065865).
ms.date: 09/11/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5065865
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5065865 - Cumulative Update 21 for SQL Server 2022

_Release Date:_ &nbsp; September 11, 2025  
_Version:_ &nbsp; 16.0.4215.2

## Summary

This article describes Cumulative Update package 21 (CU21) for Microsoft SQL Server 2022. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 20 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4215.2**, file version: **2022.160.4215.2**
- Analysis Services - Product version: **16.0.43.247**, file version: **2022.160.43.247**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table:

| Bug reference | Description| Fix area| Component | Platform |
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------------------------------------|----------|
|<a id=4433544>[4433544](#4433544) </a> | Fixes an issue in which running the `TRUNCATE TABLE WITH PARTITIONS` statement on a table with non-aligned partitions succeeds unexpectedly and causes corruption. | SQL Server Engine | DB Management | All|
|<a id=4145424>[4145424](#4145424) </a> | 	Fixes an assertion dump issue on the primary replica of an availability group related to the expression "!(uaeUnused != prev && trace->Elements[prev].ThreadId == trace->Elements[curr].ThreadId) \|\| (trace->Elements[prev].Value <= value)."| SQL Server Engine | High Availability and Disaster Recovery | All|
|<a id=4419880>[4419880](#4419880) </a> | 	Fixes a SQL injection vulnerability in a system stored procedure.| SQL Server Engine | High Availability and Disaster Recovery | All|
|<a id=4311157>[4311157](#4311157) </a> | Fixes a SQL Server on Linux termination issue that you might encounter when trying to send encrypted TLS/SSL data to a peer after receiving an alert such as `bad_record_mac` from the peer. | SQL Server Engine | Linux | Linux|
|<a id=4419716>[4419716](#4419716) </a> | 	Fixes a SQL injection vulnerability in a system stored procedure.| SQL Server Engine | Metadata| All|
|<a id=4229256>[4229256](#4229256) </a> | Fixes an issue of using DMVs in specific scenarios to inspect text of statements that are executing in other sessions and that might contain sensitive data. | SQL Server Engine | Programmability | All|
|<a id=4268984>[4268984](#4268984) </a> | Fixes an access violation dump issue that you encounter in `ACCESS_VIOLATION_c0000005_sqllang.dll!CScaOp_Intrinsic::FConvertToText_Intrinsic` when executing queries that use the TRIM intrinsic.| SQL Server Engine | Programmability | All|
|<a id=4410919>[4410919](#4410919) </a> | Fixes an issue in which the `TRY_CONVERT` function might cause invalid results when the plan uses the **Clustered Index Seek** operator. | SQL Server Engine | Query Optimizer | All|
|<a id=4441901>[4441901](#4441901) </a> | Fixes an issue in which the change tracking auto cleanup process blocks the user triggered `ALTER TABLE` column-level DDL (`ADD/DROP/ALTER COLUMN`) operations.| SQL Server Engine | Replication | All|
|<a id=4524294>[4524294](#4524294) </a> | Fixes an issue in which adding a merge agent fails and throws out the following error when the subscription uses a non-default port: </br></br>Msg 2560, Level 16, State 9, Procedure distribution.sys.sp_MSadd_merge_agent, Line \<LineNumber> [Batch Start Line 3]</br>Parameter 2 is incorrect for this DBCC statement. | SQL Server Engine | Replication | Windows|
|<a id=4424573>[4424573](#4424573) </a> | 	Prevents logins with the `ALTER ANY LOGIN` permission from resetting the passwords of logins that have `ALTER ANY LOGIN` or `IMPERSONATE ANY LOGIN` permissions to avoid elevation of privilege. | SQL Server Engine | Security Infrastructure | All|
|<a id=4520174>[4520174](#4520174) </a> | Fixes an access violation that you encounter when running `sp_describe_first_result_set` on `sys.database_ledger_digest_locations`.| SQL Server Engine | Security Infrastructure | All|
|<a id=4437734>[4437734](#4437734) </a> | 	Prevents elevation of privilege by running SQL Agent job steps for built-in jobs with reduced permissions. | SQL Server Engine | SQL Agent | All|
|<a id=4285469>[4285469](#4285469) </a> | Fixes a vulnerability that lets users who have access to certain stored procedures perform SQL injection and run arbitrary code by using elevated privileges.| SQL Server Engine | SQL Server Engine | All|
|<a id=4448818>[4448818](#4448818) </a> | Fixes URLs in certain error messages (for example, error 14130 and error 14131). | SQL Server Engine | SQL Server Engine | All|
|<a id=2693201>[2693201](#2693201) </a> | Fixes an issue in which the log files shrink beyond the specified target size under certain operations when you run the `DBCC SHRINKFILE` command. | SQL Server Engine | Storage Management| All|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU21 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5065865)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5065865-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5065865-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5065865-x64.exe| 91B2659FA385584AA10278D3016531782F209BE0D94DB84BE3EE9F2094ED43A5 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions


SQL Server 2022 Analysis Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Anglesharp.dll | 0.9.9.0 | 1240112 | 11-Aug-2025 | 14:02 | x86 |
| Asplatformhost.dll | 2022.160.43.247 | 336936 | 11-Aug-2025 | 13:58 | x64 |
| Mashupcompression.dll | 2.127.602.0 | 141760 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.analysisservices.minterop.dll | 16.0.43.247 | 865296 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.analysisservices.server.core.dll | 16.0.43.247 | 2903568 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.data.edm.netfx35.dll | 5.7.0.62516 | 661936 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.dll | 2.127.602.0 | 224184 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.oledb.dll | 2.127.602.0 | 32192 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.preview.dll | 2.127.602.0 | 153528 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.dll | 2.127.602.0 | 113088 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 33216 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47040 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47024 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.mashup.sqlclient.dll | 2.127.602.0 | 25536 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.odata.netfx35.dll | 5.7.0.62516 | 1455536 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.odata.query.netfx35.dll | 5.7.0.62516 | 182200 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.dll | 1.0.0.25 | 931680 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 35200 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 36704 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 37216 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 39808 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 49024 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sqlclient.dll | 2.17.23292.1 | 1997744 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sqlclient.sni.dll | 2.1.1.0 | 511920 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.dataintegration.fuzzyclustering.dll | 1.0.0.0 | 40368 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.dataintegration.fuzzymatching.dll | 1.0.0.0 | 628144 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.dataintegration.fuzzymatchingcommon.dll | 1.0.0.0 | 390064 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.exchange.webservices.dll | 15.0.913.15 | 1124272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.hostintegration.connectors.dll | 2.127.602.0 | 4964800 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identity.client.dll | 4.57.0.0 | 1653680 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.35.0.41201 | 111536 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.logging.dll | 6.35.0.41201 | 38320 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.35.0.41201 | 39856 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201 | 114096 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.35.0.41201 | 992192 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.cdm.icdmprovider.dll | 2.127.602.0 | 21952 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.container.exe | 2.127.602.0 | 25024 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.mashup.container.netfx40.exe | 2.127.602.0 | 24000 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.mashup.container.netfx45.exe | 2.127.602.0 | 23992 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.mashup.eventsource.dll | 2.127.602.0 | 150448 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.dll | 2.127.602.0 | 94144 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15808 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16320 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16312 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16816 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 17344 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15792 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbinterop.dll | 2.127.602.0 | 201144 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.mashup.oledbprovider.dll | 2.127.602.0 | 67008 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14264 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.sapbwprovider.dll | 2.127.602.0 | 334256 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.scriptdom.dll | 2.40.4554.261 | 2365872 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.shims.dll | 2.127.602.0 | 29616 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0 | 141248 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.dll | 2.127.602.0 | 15941040 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.dll | 2.127.602.0 | 7617472 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 35872 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 36288 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39360 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39856 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39872 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40368 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40888 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 42424 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 47024 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 620464 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 747448 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 739248 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 718776 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 776128 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 726960 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 702384 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 980912 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 612272 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 714672 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.mshtml.dll | 7.0.3300.1 | 8017840 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.odata.core.netfx35.dll | 6.15.0.0 | 1438656 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.odata.core.netfx35.v7.dll | 7.4.0.11102 | 1262000 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.odata.edm.netfx35.dll | 6.15.0.0 | 779712 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.odata.edm.netfx35.v7.dll | 7.4.0.11102 | 745920 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.powerbi.adomdclient.dll | 16.0.122.20 | 1216944 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.spatial.netfx35.dll | 6.15.0.0 | 127408 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.spatial.netfx35.v7.dll | 7.4.0.11102 | 125368 | 11-Aug-2025 | 14:02 | x86 |
| Msmdctr.dll | 2022.160.43.247 | 38952 | 11-Aug-2025 | 13:58 | x64 |
| Msmdlocal.dll | 2022.160.43.247 | 53976624 | 11-Aug-2025 | 13:58 | x86 |
| Msmdlocal.dll | 2022.160.43.247 | 71820336 | 11-Aug-2025 | 13:58 | x64 |
| Msmdpump.dll | 2022.160.43.247 | 10334280 | 11-Aug-2025 | 13:58 | x64 |
| Msmdredir.dll | 2022.160.43.247 | 8132656 | 11-Aug-2025 | 13:58 | x86 |
| Msmdsrv.exe | 2022.160.43.247 | 71362120 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 956960 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1884688 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1671720 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1881104 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1848352 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1147448 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1140264 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1769512 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1749008 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 932896 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1837584 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 955432 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1882664 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1668624 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1876520 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1844776 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1145376 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1138704 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1765416 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1745424 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 933416 | 11-Aug-2025 | 13:58 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1832976 | 11-Aug-2025 | 13:58 | x64 |
| Msmgdsrv.dll | 2022.160.43.247 | 10083400 | 11-Aug-2025 | 13:58 | x64 |
| Msmgdsrv.dll | 2022.160.43.247 | 8265800 | 11-Aug-2025 | 13:58 | x86 |
| Msolap.dll | 2022.160.43.247 | 8744536 | 11-Aug-2025 | 13:58 | x86 |
| Msolap.dll | 2022.160.43.247 | 10969656 | 11-Aug-2025 | 13:58 | x64 |
| Msolui.dll | 2022.160.43.247 | 289832 | 11-Aug-2025 | 13:58 | x86 |
| Msolui.dll | 2022.160.43.247 | 308280 | 11-Aug-2025 | 13:58 | x64 |
| Newtonsoft.json.dll | 13.0.3.27908 | 722264 | 11-Aug-2025 | 14:02 | x86 |
| Parquetsharp.dll | 0.0.0.0 | 412592 | 11-Aug-2025 | 14:02 | x64 |
| Parquetsharpnative.dll | 7.0.0.17 | 20091320 | 11-Aug-2025 | 14:02 | x64 |
| Powerbiextensions.dll | 2.127.602.0 | 11111344 | 11-Aug-2025 | 14:02 | x86 |
| Private\_odbc32.dll | 10.0.19041.1 | 735288 | 11-Aug-2025 | 14:02 | x64 |
| Sni.dll | 1.1.1.0 | 555424 | 11-Aug-2025 | 14:02 | x64 |
| Sql\_as\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |
| Sqlceip.exe | 16.0.4215.2 | 301096 | 11-Aug-2025 | 14:02 | x86 |
| Sqldumper.exe | 2022.160.4215.2 | 448544 | 11-Aug-2025 | 14:02 | x64 |
| Sqldumper.exe | 2022.160.4215.2 | 383000 | 11-Aug-2025 | 14:02 | x86 |
| System.identitymodel.tokens.jwt.dll | 6.35.0.41201 | 77248 | 11-Aug-2025 | 14:02 | x86 |
| System.spatial.netfx35.dll | 5.7.0.62516 | 118704 | 11-Aug-2025 | 14:02 | x86 |
| Tmapi.dll | 2022.160.43.247 | 5884504 | 11-Aug-2025 | 13:58 | x64 |
| Tmcachemgr.dll | 2022.160.43.247 | 5575728 | 11-Aug-2025 | 13:58 | x64 |
| Tmpersistence.dll | 2022.160.43.247 | 1481256 | 11-Aug-2025 | 13:58 | x64 |
| Tmtransactions.dll | 2022.160.43.247 | 7198256 | 11-Aug-2025 | 13:58 | x64 |
| Xmsrv.dll | 2022.160.43.247 | 26593368 | 11-Aug-2025 | 13:58 | x64 |
| Xmsrv.dll | 2022.160.43.247 | 35895856 | 11-Aug-2025 | 13:58 | x86 |

SQL Server 2022 Database Services Common Core

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Instapi150.dll | 2022.160.4215.2 | 104480 | 11-Aug-2025 | 14:02 | x64 |
| Instapi150.dll | 2022.160.4215.2 | 79880 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.247 | 2633744 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.analysisservices.core.dll | 16.0.43.247 | 2933288 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.247 | 2323472 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.247 | 2323496 | 11-Aug-2025 | 13:58 | x86 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4215.2 | 104464 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4215.2 | 92168 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.rmo.dll | 16.0.4215.2 | 555024 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.rmo.dll | 16.0.4215.2 | 555040 | 11-Aug-2025 | 14:02 | x86 |
| Msasxpress.dll | 2022.160.43.247 | 27664 | 11-Aug-2025 | 13:58 | x86 |
| Msasxpress.dll | 2022.160.43.247 | 32784 | 11-Aug-2025 | 13:58 | x64 |
| Sql\_common\_core\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |
| Sqldumper.exe | 2022.160.4215.2 | 383000 | 11-Aug-2025 | 14:02 | x86 |
| Sqldumper.exe | 2022.160.4215.2 | 448544 | 11-Aug-2025 | 14:02 | x64 |
| Sqlmgmprovider.dll | 2022.160.4215.2 | 395280 | 11-Aug-2025 | 14:02 | x86 |
| Sqlmgmprovider.dll | 2022.160.4215.2 | 456736 | 11-Aug-2025 | 14:02 | x64 |
| Sqlsvcsync.dll | 2022.160.4215.2 | 280592 | 11-Aug-2025 | 14:02 | x86 |
| Sqlsvcsync.dll | 2022.160.4215.2 | 362504 | 11-Aug-2025 | 14:02 | x64 |
| Svrenumapi150.dll | 2022.160.4215.2 | 1247280 | 11-Aug-2025 | 14:02 | x64 |
| Svrenumapi150.dll | 2022.160.4215.2 | 976912 | 11-Aug-2025 | 14:02 | x86 |

SQL Server 2022 Data Quality Client

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.studio.infra.dll | 16.0.4215.2 | 309280 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.studio.viewmodels.dll | 16.0.4215.2 | 1009672 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.studio.views.dll | 16.0.4215.2 | 2070584 | 11-Aug-2025 | 14:02 | x86 |
| Sql\_dqc\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |

SQL Server 2022 Data Quality

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.cleansing.dll | 16.0.4215.2 | 469008 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.cleansing.dll | 16.0.4215.2 | 469024 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4215.2 | 600080 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4215.2 | 600096 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.dll | 16.0.4215.2 | 174088 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.dll | 16.0.4215.2 | 174096 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.infra.dll | 16.0.4215.2 | 1857568 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4215.2 | 370704 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4215.2 | 370736 | 11-Aug-2025 | 14:02 | x86 |
| Dqsinstaller.exe | 16.0.4215.2 | 2775056 | 11-Aug-2025 | 14:02 | x86 |
| Sql\_dq\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |

SQL Server 2022 Database Services Core Instance

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Adal.dll | 3.6.1.64359 | 1618832 | 11-Aug-2025 | 15:06 | x64 |
| Adalsqlrda.dll | 3.6.1.64359 | 1618832 | 11-Aug-2025 | 15:06 | x64 |
| Aetm-enclave-simulator.dll | 2022.160.4215.2 | 5993024 | 11-Aug-2025 | 14:45 | x64 |
| Aetm-enclave.dll | 2022.160.4215.2 | 5959680 | 11-Aug-2025 | 14:45 | x64 |
| Aetm-sgx-enclave-simulator.dll | 2022.160.4215.2 | 6194792 | 11-Aug-2025 | 14:45 | x64 |
| Aetm-sgx-enclave.dll | 2022.160.4215.2 | 6160720 | 11-Aug-2025 | 14:45 | x64 |
| Databasemail.exe | 16.0.4215.2 | 30728 | 11-Aug-2025 | 15:06 | x64 |
| Databasemailengine.dll | 16.0.4215.2 | 79888 | 11-Aug-2025 | 15:06 | x86 |
| Dcexec.exe | 2022.160.4215.2 | 96288 | 11-Aug-2025 | 15:06 | x64 |
| Fssres.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 15:06 | x64 |
| Hadrres.dll | 2022.160.4215.2 | 227336 | 11-Aug-2025 | 15:06 | x64 |
| Hkcompile.dll | 2022.160.4215.2 | 1427496 | 11-Aug-2025 | 15:06 | x64 |
| Hkdllgen.exe | 2022.160.4215.2 | 1570832 | 11-Aug-2025 | 15:06 | x64 |
| Hkengine.dll | 2022.160.4215.2 | 5769256 | 11-Aug-2025 | 15:06 | x64 |
| Hkruntime.dll | 2022.160.4215.2 | 190496 | 11-Aug-2025 | 15:06 | x64 |
| Hktempdb.dll | 2022.160.4215.2 | 71696 | 11-Aug-2025 | 15:06 | x64 |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.247 | 2322456 | 11-Aug-2025 | 15:06 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 11-Aug-2025 | 15:06 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 11-Aug-2025 | 15:06 | x64 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 11-Aug-2025 | 15:06 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4215.2 | 83984 | 11-Aug-2025 | 14:45 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4215.2 | 182312 | 11-Aug-2025 | 15:06 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 15:06 | x64 |
| Microsoft.sqlserver.xevent.linq.dll | 2022.160.4215.2 | 333840 | 11-Aug-2025 | 15:06 | x64 |
| Microsoft.sqlserver.xevent.targets.dll | 2022.160.4215.2 | 96264 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 30736 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 38920 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 34832 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 38944 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 38920 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 30760 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 30736 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 34848 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 38928 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 30736 | 11-Aug-2025 | 15:06 | x64 |
| Odsole70.rll | 16.0.4215.2 | 38928 | 11-Aug-2025 | 15:06 | x64 |
| Qds.dll | 2022.160.4215.2 | 1820680 | 11-Aug-2025 | 15:06 | x64 |
| Rsfxft.dll | 2022.160.4215.2 | 55304 | 11-Aug-2025 | 15:06 | x64 |
| Secforwarder.dll | 2022.160.4215.2 | 83976 | 11-Aug-2025 | 15:06 | x64 |
| Sql\_engine\_core\_inst\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 15:06 | x64 |
| Sqlaamss.dll | 2022.160.4215.2 | 120872 | 11-Aug-2025 | 15:06 | x64 |
| Sqlaccess.dll | 2022.160.4215.2 | 444432 | 11-Aug-2025 | 15:06 | x64 |
| Sqlagent.exe | 2022.160.4215.2 | 722976 | 11-Aug-2025 | 15:06 | x64 |
| Sqlagentmail.dll | 2022.160.4215.2 | 75808 | 11-Aug-2025 | 15:06 | x64 |
| Sqlceip.exe | 16.0.4215.2 | 301096 | 11-Aug-2025 | 15:06 | x86 |
| Sqlcmdss.dll | 2022.160.4215.2 | 104464 | 11-Aug-2025 | 15:06 | x64 |
| Sqlctr160.dll | 2022.160.4215.2 | 157728 | 11-Aug-2025 | 15:06 | x64 |
| Sqlctr160.dll | 2022.160.4215.2 | 129048 | 11-Aug-2025 | 15:06 | x86 |
| Sqldk.dll | 2022.160.4215.2 | 4024360 | 11-Aug-2025 | 15:06 | x64 |
| Sqldtsss.dll | 2022.160.4215.2 | 120864 | 11-Aug-2025 | 15:06 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 1763360 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3881016 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4098064 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4610064 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4741176 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3778576 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3966984 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4610080 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4438024 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4511752 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 2463776 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 2406432 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4294688 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3930144 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4446256 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4241456 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4220944 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4003888 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3880976 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 1701904 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4331544 | 11-Aug-2025 | 14:45 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4474912 | 11-Aug-2025 | 14:45 | x64 |
| Sqliosim.com | 2022.160.4215.2 | 395304 | 11-Aug-2025 | 15:06 | x64 |
| Sqliosim.exe | 2022.160.4215.2 | 3069976 | 11-Aug-2025 | 15:06 | x64 |
| Sqllang.dll | 2022.160.4215.2 | 49055784 | 11-Aug-2025 | 15:06 | x64 |
| Sqlmin.dll | 2022.160.4215.2 | 52246568 | 11-Aug-2025 | 15:06 | x64 |
| Sqlolapss.dll | 2022.160.4215.2 | 116792 | 11-Aug-2025 | 15:06 | x64 |
| Sqlos.dll | 2022.160.4215.2 | 51208 | 11-Aug-2025 | 14:45 | x64 |
| Sqlpowershellss.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 15:06 | x64 |
| Sqlrepss.dll | 2022.160.4215.2 | 149552 | 11-Aug-2025 | 15:06 | x64 |
| Sqlscriptdowngrade.dll | 2022.160.4215.2 | 51232 | 11-Aug-2025 | 15:06 | x64 |
| Sqlscriptupgrade.dll | 2022.160.4215.2 | 5843000 | 11-Aug-2025 | 15:06 | x64 |
| Sqlservr.exe | 2022.160.4215.2 | 727056 | 11-Aug-2025 | 15:06 | x64 |
| Sqlsvc.dll | 2022.160.4215.2 | 194600 | 11-Aug-2025 | 15:06 | x64 |
| Sqltses.dll | 2022.160.4215.2 | 10668072 | 11-Aug-2025 | 15:06 | x64 |
| Sqsrvres.dll | 2022.160.4215.2 | 305168 | 11-Aug-2025 | 15:06 | x64 |
| Svl.dll | 2022.160.4215.2 | 247848 | 11-Aug-2025 | 15:06 | x64 |
| System.buffers.dll | 4.6.28619.1 | 20856 | 11-Aug-2025 | 15:06 | x86 |
| System.configuration.configurationmanager.dll | 6.0.922.41905 | 87184 | 11-Aug-2025 | 15:06 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 11-Aug-2025 | 15:06 | x86 |
| System.numerics.vectors.dll | 4.6.26515.6 | 115856 | 11-Aug-2025 | 15:06 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 11-Aug-2025 | 15:06 | x86 |
| System.runtime.interopservices.runtimeinformation.dll | 4.6.24705.1 | 33256 | 11-Aug-2025 | 15:06 | x86 |
| System.text.encodings.web.dll | 6.0.21.52210 | 76904 | 11-Aug-2025 | 15:06 | x86 |
| Xe.dll | 2022.160.4215.2 | 718872 | 11-Aug-2025 | 15:06 | x64 |
| Xpqueue.dll | 2022.160.4215.2 | 100368 | 11-Aug-2025 | 15:06 | x64 |
| Xpstar.dll | 2022.160.4215.2 | 534560 | 11-Aug-2025 | 15:06 | x64 |

SQL Server 2022 Database Services Core Shared

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Azure.core.dll | 1.3600.23.56006 | 384432 | 11-Aug-2025 | 14:02 | x86 |
| Azure.identity.dll | 1.1000.423.56303 | 334768 | 11-Aug-2025 | 14:02 | x86 |
| Bcp.exe | 2022.160.4215.2 | 141336 | 11-Aug-2025 | 14:02 | x64 |
| Commanddest.dll | 2022.160.4215.2 | 272432 | 11-Aug-2025 | 14:02 | x64 |
| Datacollectortasks.dll | 2022.160.4215.2 | 227360 | 11-Aug-2025 | 14:02 | x64 |
| Distrib.exe | 2022.160.4215.2 | 260120 | 11-Aug-2025 | 14:02 | x64 |
| Dteparse.dll | 2022.160.4215.2 | 133152 | 11-Aug-2025 | 14:02 | x64 |
| Dteparsemgd.dll | 2022.160.4215.2 | 178192 | 11-Aug-2025 | 14:02 | x64 |
| Dtepkg.dll | 2022.160.4215.2 | 153616 | 11-Aug-2025 | 14:02 | x64 |
| Dtexec.exe | 2022.160.4215.2 | 76832 | 11-Aug-2025 | 14:02 | x64 |
| Dts.dll | 2022.160.4215.2 | 3270688 | 11-Aug-2025 | 14:02 | x64 |
| Dtscomexpreval.dll | 2022.160.4215.2 | 493600 | 11-Aug-2025 | 14:02 | x64 |
| Dtsconn.dll | 2022.160.4215.2 | 550960 | 11-Aug-2025 | 14:02 | x64 |
| Dtshost.exe | 2022.160.4215.2 | 120344 | 11-Aug-2025 | 14:02 | x64 |
| Dtslog.dll | 2022.160.4215.2 | 137248 | 11-Aug-2025 | 14:02 | x64 |
| Dtspipeline.dll | 2022.160.4215.2 | 1337360 | 11-Aug-2025 | 14:02 | x64 |
| Dtuparse.dll | 2022.160.4215.2 | 104456 | 11-Aug-2025 | 14:02 | x64 |
| Dtutil.exe | 2022.160.4215.2 | 166432 | 11-Aug-2025 | 14:02 | x64 |
| Exceldest.dll | 2022.160.4215.2 | 284704 | 11-Aug-2025 | 14:02 | x64 |
| Excelsrc.dll | 2022.160.4215.2 | 305168 | 11-Aug-2025 | 14:02 | x64 |
| Execpackagetask.dll | 2022.160.4215.2 | 182304 | 11-Aug-2025 | 14:02 | x64 |
| Flatfiledest.dll | 2022.160.4215.2 | 423952 | 11-Aug-2025 | 14:02 | x64 |
| Flatfilesrc.dll | 2022.160.4215.2 | 440336 | 11-Aug-2025 | 14:02 | x64 |
| Logread.exe | 2022.160.4215.2 | 817160 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933792 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.bcl.asyncinterfaces.dll | 6.0.21.52210 | 22144 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.data.tools.sql.batchparser.dll | 17.100.23.0 | 42416 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4215.2 | 30752 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identity.client.extensions.msal.dll | 4.56.0.0 | 66552 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.abstractions.dll | 6.24.0.31013 | 18864 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.24.0.31013 | 85424 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.logging.dll | 6.24.0.31013 | 34224 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.24.0.31013 | 38288 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.24.0.31013 | 114048 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.24.0.31013 | 986032 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.connectioninfo.dll | 17.100.23.0 | 126496 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.dmf.common.dll | 17.100.23.0 | 63520 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4215.2 | 391184 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.management.sdk.sfc.dll | 17.100.23.0 | 513464 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.replication.dll | 2022.160.4215.2 | 1718304 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.sqlserver.rmo.dll | 16.0.4215.2 | 555040 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.servicebrokerenum.dll | 17.100.23.0 | 37920 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.smo.dll | 17.100.23.0 | 4451872 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.smoextended.dll | 17.100.23.0 | 161208 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.sqlclrprovider.dll | 17.100.23.0 | 21536 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.sqlenum.dll | 17.100.23.0 | 1587744 | 11-Aug-2025 | 14:02 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4215.2 | 182312 | 11-Aug-2025 | 14:02 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 14:02 | x64 |
| Msdtssrvrutil.dll | 2022.160.4215.2 | 124944 | 11-Aug-2025 | 14:02 | x64 |
| Msgprox.dll | 2022.160.4215.2 | 313376 | 11-Aug-2025 | 14:02 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 2750472 | 11-Aug-2025 | 14:02 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 153608 | 11-Aug-2025 | 14:02 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 11-Aug-2025 | 14:02 | x86 |
| Oledbdest.dll | 2022.160.4215.2 | 288776 | 11-Aug-2025 | 14:02 | x64 |
| Oledbsrc.dll | 2022.160.4215.2 | 317472 | 11-Aug-2025 | 14:02 | x64 |
| Qrdrsvc.exe | 2022.160.4215.2 | 526352 | 11-Aug-2025 | 14:02 | x64 |
| Rawdest.dll | 2022.160.4215.2 | 227352 | 11-Aug-2025 | 14:02 | x64 |
| Rawsource.dll | 2022.160.4215.2 | 215072 | 11-Aug-2025 | 14:02 | x64 |
| Rdistcom.dll | 2022.160.4215.2 | 948256 | 11-Aug-2025 | 14:02 | x64 |
| Recordsetdest.dll | 2022.160.4215.2 | 206872 | 11-Aug-2025 | 14:02 | x64 |
| Repldp.dll | 2022.160.4215.2 | 337936 | 11-Aug-2025 | 14:02 | x64 |
| Replerrx.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 14:02 | x64 |
| Replisapi.dll | 2022.160.4215.2 | 419856 | 11-Aug-2025 | 14:02 | x64 |
| Replmerg.exe | 2022.160.4215.2 | 600080 | 11-Aug-2025 | 14:02 | x64 |
| Replprov.dll | 2022.160.4215.2 | 890912 | 11-Aug-2025 | 14:02 | x64 |
| Replrec.dll | 2022.160.4215.2 | 1062944 | 11-Aug-2025 | 14:02 | x64 |
| Replsub.dll | 2022.160.4215.2 | 505888 | 11-Aug-2025 | 14:02 | x64 |
| Spresolv.dll | 2022.160.4215.2 | 305160 | 11-Aug-2025 | 14:02 | x64 |
| Sql\_engine\_core\_shared\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 14:02 | x64 |
| Sqlcmd.exe | 2022.160.4215.2 | 276520 | 11-Aug-2025 | 14:02 | x64 |
| Sqldiag.exe | 2022.160.4215.2 | 1140768 | 11-Aug-2025 | 14:02 | x64 |
| Sqldistx.dll | 2022.160.4215.2 | 268304 | 11-Aug-2025 | 14:02 | x64 |
| Sqlmergx.dll | 2022.160.4215.2 | 423968 | 11-Aug-2025 | 14:02 | x64 |
| Sqlnclirda11.dll | 2011.110.5069.66 | 3478208 | 11-Aug-2025 | 14:02 | x64 |
| Sqlsvc.dll | 2022.160.4215.2 | 194600 | 11-Aug-2025 | 14:02 | x64 |
| Sqlsvc.dll | 2022.160.4215.2 | 153632 | 11-Aug-2025 | 14:02 | x86 |
| Sqltaskconnections.dll | 2022.160.4215.2 | 210952 | 11-Aug-2025 | 14:02 | x64 |
| Sqlwep160.dll | 2022.160.4215.2 | 124944 | 11-Aug-2025 | 14:02 | x64 |
| Ssradd.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:02 | x64 |
| Ssravg.dll | 2022.160.4215.2 | 100360 | 11-Aug-2025 | 14:02 | x64 |
| Ssrmax.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:02 | x64 |
| Ssrmin.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:02 | x64 |
| System.diagnostics.diagnosticsource.dll | 7.0.423.11508 | 173232 | 11-Aug-2025 | 14:02 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 11-Aug-2025 | 14:02 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 11-Aug-2025 | 14:02 | x86 |
| System.security.cryptography.protecteddata.dll | 7.0.22.51805 | 21640 | 11-Aug-2025 | 14:02 | x86 |
| Txagg.dll | 2022.160.4215.2 | 395296 | 11-Aug-2025 | 14:02 | x64 |
| Txbdd.dll | 2022.160.4215.2 | 190488 | 11-Aug-2025 | 14:02 | x64 |
| Txdatacollector.dll | 2022.160.4215.2 | 469024 | 11-Aug-2025 | 14:02 | x64 |
| Txdataconvert.dll | 2022.160.4215.2 | 333856 | 11-Aug-2025 | 14:02 | x64 |
| Txderived.dll | 2022.160.4215.2 | 632840 | 11-Aug-2025 | 14:02 | x64 |
| Txlookup.dll | 2022.160.4215.2 | 608272 | 11-Aug-2025 | 14:02 | x64 |
| Txmerge.dll | 2022.160.4215.2 | 243728 | 11-Aug-2025 | 14:02 | x64 |
| Txmergejoin.dll | 2022.160.4215.2 | 301088 | 11-Aug-2025 | 14:02 | x64 |
| Txmulticast.dll | 2022.160.4215.2 | 145416 | 11-Aug-2025 | 14:02 | x64 |
| Txrowcount.dll | 2022.160.4215.2 | 145416 | 11-Aug-2025 | 14:02 | x64 |
| Txsort.dll | 2022.160.4215.2 | 276496 | 11-Aug-2025 | 14:02 | x64 |
| Txsplit.dll | 2022.160.4215.2 | 620560 | 11-Aug-2025 | 14:02 | x64 |
| Txunionall.dll | 2022.160.4215.2 | 194576 | 11-Aug-2025 | 14:02 | x64 |
| Xe.dll | 2022.160.4215.2 | 718872 | 11-Aug-2025 | 14:02 | x64 |

SQL Server 2022 sql\_extensibility

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commonlauncher.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:02 | x64 |
| Exthost.exe | 2022.160.4215.2 | 247840 | 11-Aug-2025 | 14:02 | x64 |
| Launchpad.exe | 2022.160.4215.2 | 1452072 | 11-Aug-2025 | 14:02 | x64 |
| Sql\_extensibility\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |
| Sqlsatellite.dll | 2022.160.4215.2 | 1255456 | 11-Aug-2025 | 14:02 | x64 |

SQL Server 2022 Full-Text Engine

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Fd.dll | 2022.160.4215.2 | 702496 | 11-Aug-2025 | 14:02 | x64 |
| Fdhost.exe | 2022.160.4215.2 | 157728 | 11-Aug-2025 | 14:02 | x64 |
| Fdlauncher.exe | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:02 | x64 |
| Sql\_fulltext\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 13:58 | x64 |

SQL Server 2022 Integration Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Attunity.sqlserver.cdccontroltask.dll | 7.0.0.133 | 78272 | 11-Aug-2025 | 14:10 | x86 |
| Attunity.sqlserver.cdccontroltask.dll | 7.0.0.133 | 78272 | 11-Aug-2025 | 14:10 | x86 |
| Attunity.sqlserver.cdcsplit.dll | 7.0.0.133 | 39320 | 11-Aug-2025 | 14:10 | x86 |
| Attunity.sqlserver.cdcsplit.dll | 7.0.0.133 | 39320 | 11-Aug-2025 | 14:10 | x86 |
| Attunity.sqlserver.cdcsrc.dll | 7.0.0.133 | 79808 | 11-Aug-2025 | 14:10 | x86 |
| Attunity.sqlserver.cdcsrc.dll | 7.0.0.133 | 79808 | 11-Aug-2025 | 14:10 | x86 |
| Commanddest.dll | 2022.160.4215.2 | 231472 | 11-Aug-2025 | 14:10 | x86 |
| Commanddest.dll | 2022.160.4215.2 | 272432 | 11-Aug-2025 | 14:10 | x64 |
| Dteparse.dll | 2022.160.4215.2 | 116760 | 11-Aug-2025 | 14:10 | x86 |
| Dteparse.dll | 2022.160.4215.2 | 133152 | 11-Aug-2025 | 14:10 | x64 |
| Dteparsemgd.dll | 2022.160.4215.2 | 165896 | 11-Aug-2025 | 14:10 | x86 |
| Dteparsemgd.dll | 2022.160.4215.2 | 178192 | 11-Aug-2025 | 14:10 | x64 |
| Dtepkg.dll | 2022.160.4215.2 | 133144 | 11-Aug-2025 | 14:10 | x86 |
| Dtepkg.dll | 2022.160.4215.2 | 153616 | 11-Aug-2025 | 14:10 | x64 |
| Dtexec.exe | 2022.160.4215.2 | 65072 | 11-Aug-2025 | 14:10 | x86 |
| Dtexec.exe | 2022.160.4215.2 | 76832 | 11-Aug-2025 | 14:10 | x64 |
| Dts.dll | 2022.160.4215.2 | 2861088 | 11-Aug-2025 | 14:10 | x86 |
| Dts.dll | 2022.160.4215.2 | 3270688 | 11-Aug-2025 | 14:10 | x64 |
| Dtscomexpreval.dll | 2022.160.4215.2 | 444432 | 11-Aug-2025 | 14:10 | x86 |
| Dtscomexpreval.dll | 2022.160.4215.2 | 493600 | 11-Aug-2025 | 14:10 | x64 |
| Dtsconn.dll | 2022.160.4215.2 | 464944 | 11-Aug-2025 | 14:10 | x86 |
| Dtsconn.dll | 2022.160.4215.2 | 550960 | 11-Aug-2025 | 14:10 | x64 |
| Dtsdebughost.exe | 2022.160.4215.2 | 94760 | 11-Aug-2025 | 14:10 | x86 |
| Dtsdebughost.exe | 2022.160.4215.2 | 114696 | 11-Aug-2025 | 14:10 | x64 |
| Dtshost.exe | 2022.160.4215.2 | 98336 | 11-Aug-2025 | 14:10 | x86 |
| Dtshost.exe | 2022.160.4215.2 | 120344 | 11-Aug-2025 | 14:10 | x64 |
| Dtslog.dll | 2022.160.4215.2 | 120864 | 11-Aug-2025 | 14:10 | x86 |
| Dtslog.dll | 2022.160.4215.2 | 137248 | 11-Aug-2025 | 14:10 | x64 |
| Dtspipeline.dll | 2022.160.4215.2 | 1144864 | 11-Aug-2025 | 14:10 | x86 |
| Dtspipeline.dll | 2022.160.4215.2 | 1337360 | 11-Aug-2025 | 14:10 | x64 |
| Dtuparse.dll | 2022.160.4215.2 | 88104 | 11-Aug-2025 | 14:10 | x86 |
| Dtuparse.dll | 2022.160.4215.2 | 104456 | 11-Aug-2025 | 14:10 | x64 |
| Dtutil.exe | 2022.160.4215.2 | 142344 | 11-Aug-2025 | 14:10 | x86 |
| Dtutil.exe | 2022.160.4215.2 | 166432 | 11-Aug-2025 | 14:10 | x64 |
| Exceldest.dll | 2022.160.4215.2 | 247824 | 11-Aug-2025 | 14:10 | x86 |
| Exceldest.dll | 2022.160.4215.2 | 284704 | 11-Aug-2025 | 14:10 | x64 |
| Excelsrc.dll | 2022.160.4215.2 | 264208 | 11-Aug-2025 | 14:10 | x86 |
| Excelsrc.dll | 2022.160.4215.2 | 305168 | 11-Aug-2025 | 14:10 | x64 |
| Execpackagetask.dll | 2022.160.4215.2 | 149536 | 11-Aug-2025 | 14:10 | x86 |
| Execpackagetask.dll | 2022.160.4215.2 | 182304 | 11-Aug-2025 | 14:10 | x64 |
| Flatfiledest.dll | 2022.160.4215.2 | 374800 | 11-Aug-2025 | 14:10 | x86 |
| Flatfiledest.dll | 2022.160.4215.2 | 423952 | 11-Aug-2025 | 14:10 | x64 |
| Flatfilesrc.dll | 2022.160.4215.2 | 391184 | 11-Aug-2025 | 14:10 | x86 |
| Flatfilesrc.dll | 2022.160.4215.2 | 440336 | 11-Aug-2025 | 14:10 | x64 |
| Isdbupgradewizard.exe | 16.0.4215.2 | 120840 | 11-Aug-2025 | 14:10 | x86 |
| Isdbupgradewizard.exe | 16.0.4215.2 | 120864 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933792 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933800 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4215.2 | 509984 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4215.2 | 509984 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4215.2 | 391184 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4215.2 | 170000 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4215.2 | 182312 | 11-Aug-2025 | 14:10 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4215.2 | 178184 | 11-Aug-2025 | 14:10 | x86 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 14:10 | x64 |
| Msdtssrvr.exe | 16.0.4215.2 | 219152 | 11-Aug-2025 | 14:10 | x64 |
| Msdtssrvrutil.dll | 2022.160.4215.2 | 100384 | 11-Aug-2025 | 14:10 | x86 |
| Msdtssrvrutil.dll | 2022.160.4215.2 | 124944 | 11-Aug-2025 | 14:10 | x64 |
| Msmdpp.dll | 2022.160.43.247 | 10164784 | 11-Aug-2025 | 14:10 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 11-Aug-2025 | 14:10 | x86 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 11-Aug-2025 | 14:10 | x86 |
| Odbcdest.dll | 2022.160.4215.2 | 342048 | 11-Aug-2025 | 14:10 | x86 |
| Odbcdest.dll | 2022.160.4215.2 | 387088 | 11-Aug-2025 | 14:10 | x64 |
| Odbcsrc.dll | 2022.160.4215.2 | 350224 | 11-Aug-2025 | 14:10 | x86 |
| Odbcsrc.dll | 2022.160.4215.2 | 399392 | 11-Aug-2025 | 14:10 | x64 |
| Oledbdest.dll | 2022.160.4215.2 | 247856 | 11-Aug-2025 | 14:10 | x86 |
| Oledbdest.dll | 2022.160.4215.2 | 288776 | 11-Aug-2025 | 14:10 | x64 |
| Oledbsrc.dll | 2022.160.4215.2 | 268304 | 11-Aug-2025 | 14:10 | x86 |
| Oledbsrc.dll | 2022.160.4215.2 | 317472 | 11-Aug-2025 | 14:10 | x64 |
| Rawdest.dll | 2022.160.4215.2 | 227352 | 11-Aug-2025 | 14:10 | x64 |
| Rawdest.dll | 2022.160.4215.2 | 190480 | 11-Aug-2025 | 14:10 | x86 |
| Rawsource.dll | 2022.160.4215.2 | 215072 | 11-Aug-2025 | 14:10 | x64 |
| Rawsource.dll | 2022.160.4215.2 | 186400 | 11-Aug-2025 | 14:10 | x86 |
| Recordsetdest.dll | 2022.160.4215.2 | 206872 | 11-Aug-2025 | 14:10 | x64 |
| Recordsetdest.dll | 2022.160.4215.2 | 174128 | 11-Aug-2025 | 14:10 | x86 |
| Sql\_is\_keyfile.dll | 2022.160.4215.2 | 137224 | 11-Aug-2025 | 14:10 | x64 |
| Sqlceip.exe | 16.0.4215.2 | 301096 | 11-Aug-2025 | 14:10 | x86 |
| Sqldest.dll | 2022.160.4215.2 | 256032 | 11-Aug-2025 | 14:10 | x86 |
| Sqldest.dll | 2022.160.4215.2 | 288792 | 11-Aug-2025 | 14:10 | x64 |
| Sqltaskconnections.dll | 2022.160.4215.2 | 210952 | 11-Aug-2025 | 14:10 | x64 |
| Sqltaskconnections.dll | 2022.160.4215.2 | 174128 | 11-Aug-2025 | 14:10 | x86 |
| Txagg.dll | 2022.160.4215.2 | 346136 | 11-Aug-2025 | 14:10 | x86 |
| Txagg.dll | 2022.160.4215.2 | 395296 | 11-Aug-2025 | 14:10 | x64 |
| Txbdd.dll | 2022.160.4215.2 | 149552 | 11-Aug-2025 | 14:10 | x86 |
| Txbdd.dll | 2022.160.4215.2 | 190488 | 11-Aug-2025 | 14:10 | x64 |
| Txbestmatch.dll | 2022.160.4215.2 | 567336 | 11-Aug-2025 | 14:10 | x86 |
| Txbestmatch.dll | 2022.160.4215.2 | 661512 | 11-Aug-2025 | 14:10 | x64 |
| Txcache.dll | 2022.160.4215.2 | 170032 | 11-Aug-2025 | 14:10 | x86 |
| Txcache.dll | 2022.160.4215.2 | 202768 | 11-Aug-2025 | 14:10 | x64 |
| Txcharmap.dll | 2022.160.4215.2 | 280608 | 11-Aug-2025 | 14:10 | x86 |
| Txcharmap.dll | 2022.160.4215.2 | 325648 | 11-Aug-2025 | 14:10 | x64 |
| Txcopymap.dll | 2022.160.4215.2 | 165904 | 11-Aug-2025 | 14:10 | x86 |
| Txcopymap.dll | 2022.160.4215.2 | 202760 | 11-Aug-2025 | 14:10 | x64 |
| Txdataconvert.dll | 2022.160.4215.2 | 288784 | 11-Aug-2025 | 14:10 | x86 |
| Txdataconvert.dll | 2022.160.4215.2 | 333856 | 11-Aug-2025 | 14:10 | x64 |
| Txderived.dll | 2022.160.4215.2 | 559136 | 11-Aug-2025 | 14:10 | x86 |
| Txderived.dll | 2022.160.4215.2 | 632840 | 11-Aug-2025 | 14:10 | x64 |
| Txfileextractor.dll | 2022.160.4215.2 | 186400 | 11-Aug-2025 | 14:10 | x86 |
| Txfileextractor.dll | 2022.160.4215.2 | 219152 | 11-Aug-2025 | 14:10 | x64 |
| Txfileinserter.dll | 2022.160.4215.2 | 186376 | 11-Aug-2025 | 14:10 | x86 |
| Txfileinserter.dll | 2022.160.4215.2 | 219152 | 11-Aug-2025 | 14:10 | x64 |
| Txgroupdups.dll | 2022.160.4215.2 | 354336 | 11-Aug-2025 | 14:10 | x86 |
| Txgroupdups.dll | 2022.160.4215.2 | 403472 | 11-Aug-2025 | 14:10 | x64 |
| Txlineage.dll | 2022.160.4215.2 | 129048 | 11-Aug-2025 | 14:10 | x86 |
| Txlineage.dll | 2022.160.4215.2 | 157736 | 11-Aug-2025 | 14:10 | x64 |
| Txlookup.dll | 2022.160.4215.2 | 522248 | 11-Aug-2025 | 14:10 | x86 |
| Txlookup.dll | 2022.160.4215.2 | 608272 | 11-Aug-2025 | 14:10 | x64 |
| Txmerge.dll | 2022.160.4215.2 | 194608 | 11-Aug-2025 | 14:10 | x86 |
| Txmerge.dll | 2022.160.4215.2 | 243728 | 11-Aug-2025 | 14:10 | x64 |
| Txmergejoin.dll | 2022.160.4215.2 | 256048 | 11-Aug-2025 | 14:10 | x86 |
| Txmergejoin.dll | 2022.160.4215.2 | 301088 | 11-Aug-2025 | 14:10 | x64 |
| Txmulticast.dll | 2022.160.4215.2 | 116752 | 11-Aug-2025 | 14:10 | x86 |
| Txmulticast.dll | 2022.160.4215.2 | 145416 | 11-Aug-2025 | 14:10 | x64 |
| Txpivot.dll | 2022.160.4215.2 | 198704 | 11-Aug-2025 | 14:10 | x86 |
| Txpivot.dll | 2022.160.4215.2 | 239632 | 11-Aug-2025 | 14:10 | x64 |
| Txrowcount.dll | 2022.160.4215.2 | 116752 | 11-Aug-2025 | 14:10 | x86 |
| Txrowcount.dll | 2022.160.4215.2 | 145416 | 11-Aug-2025 | 14:10 | x64 |
| Txsampling.dll | 2022.160.4215.2 | 153632 | 11-Aug-2025 | 14:10 | x86 |
| Txsampling.dll | 2022.160.4215.2 | 186408 | 11-Aug-2025 | 14:10 | x64 |
| Txscd.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 14:10 | x86 |
| Txscd.dll | 2022.160.4215.2 | 235536 | 11-Aug-2025 | 14:10 | x64 |
| Txsort.dll | 2022.160.4215.2 | 231432 | 11-Aug-2025 | 14:10 | x86 |
| Txsort.dll | 2022.160.4215.2 | 276496 | 11-Aug-2025 | 14:10 | x64 |
| Txsplit.dll | 2022.160.4215.2 | 550944 | 11-Aug-2025 | 14:10 | x86 |
| Txsplit.dll | 2022.160.4215.2 | 620560 | 11-Aug-2025 | 14:10 | x64 |
| Txtermextraction.dll | 2022.160.4215.2 | 8648760 | 11-Aug-2025 | 14:10 | x86 |
| Txtermextraction.dll | 2022.160.4215.2 | 8702016 | 11-Aug-2025 | 14:10 | x64 |
| Txtermlookup.dll | 2022.160.4215.2 | 4139032 | 11-Aug-2025 | 14:10 | x86 |
| Txtermlookup.dll | 2022.160.4215.2 | 4184096 | 11-Aug-2025 | 14:10 | x64 |
| Txunionall.dll | 2022.160.4215.2 | 153632 | 11-Aug-2025 | 14:10 | x86 |
| Txunionall.dll | 2022.160.4215.2 | 194576 | 11-Aug-2025 | 14:10 | x64 |
| Txunpivot.dll | 2022.160.4215.2 | 178208 | 11-Aug-2025 | 14:10 | x86 |
| Txunpivot.dll | 2022.160.4215.2 | 215056 | 11-Aug-2025 | 14:10 | x64 |
| Xe.dll | 2022.160.4215.2 | 641032 | 11-Aug-2025 | 14:10 | x86 |
| Xe.dll | 2022.160.4215.2 | 718872 | 11-Aug-2025 | 14:10 | x64 |

SQL Server 2022 sql\_polybase\_core\_inst

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dms.dll | 16.0.1057.0 | 559656 | 11-Aug-2025 | 14:49 | x86 |
| Dmsnative.dll | 2022.160.1057.0 | 152640 | 11-Aug-2025 | 14:49 | x64 |
| Dwengineservice.dll | 16.0.1057.0 | 45120 | 11-Aug-2025 | 14:49 | x86 |
| Instapi150.dll | 2022.160.4215.2 | 104480 | 11-Aug-2025 | 14:49 | x64 |
| Microsoft.data.edm.dll | 5.8.4.63386 | 669784 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.data.odata.dll | 5.8.4.63386 | 1539488 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.data.services.client.dll | 5.8.4.63386 | 681048 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll | 16.0.1057.0 | 67632 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.catalog.dll | 16.0.1057.0 | 293416 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.common.dll | 16.0.1057.0 | 1958464 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.configuration.dll | 16.0.1057.0 | 169512 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll | 16.0.1057.0 | 647208 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll | 16.0.1057.0 | 246296 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll | 16.0.1057.0 | 139328 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1057.0 | 79920 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll | 16.0.1057.0 | 51248 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.distributor.dll | 16.0.1057.0 | 88616 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.dll | 16.0.1057.0 | 1129512 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll | 16.0.1057.0 | 80944 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.eventing.dll | 16.0.1057.0 | 70680 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll | 16.0.1057.0 | 35376 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll | 16.0.1057.0 | 30768 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll | 16.0.1057.0 | 46640 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll | 16.0.1057.0 | 21552 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.failover.dll | 16.0.1057.0 | 26672 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll | 16.0.1057.0 | 131632 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll | 16.0.1057.0 | 86568 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll | 16.0.1057.0 | 100904 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.dll | 16.0.1057.0 | 293952 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 120360 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 138288 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 141352 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 138280 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 151064 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 140336 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 134696 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 177176 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 117824 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1057.0 | 136744 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.nodes.dll | 16.0.1057.0 | 72728 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll | 16.0.1057.0 | 22080 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll | 16.0.1057.0 | 37416 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll | 16.0.1057.0 | 129072 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.dll | 16.0.1057.0 | 3066904 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll | 16.0.1057.0 | 3955776 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 118336 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 133144 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 137776 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 133696 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 148520 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 134168 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 130624 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 171056 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 115248 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1057.0 | 132160 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll | 16.0.1057.0 | 67632 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll | 16.0.1057.0 | 2682928 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.datawarehouse.utilities.dll | 16.0.1057.0 | 2436672 | 11-Aug-2025 | 14:49 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4215.2 | 83984 | 11-Aug-2025 | 14:49 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4215.2 | 182312 | 11-Aug-2025 | 14:49 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4215.2 | 198664 | 11-Aug-2025 | 14:49 | x64 |
| Mpdwinterop.dll | 2022.160.4215.2 | 296976 | 11-Aug-2025 | 14:49 | x64 |
| Mpdwsvc.exe | 2022.160.4215.2 | 9082944 | 11-Aug-2025 | 14:49 | x64 |
| Secforwarder.dll | 2022.160.4215.2 | 83976 | 11-Aug-2025 | 14:49 | x64 |
| Sharedmemory.dll | 2022.160.1057.0 | 61488 | 11-Aug-2025 | 14:49 | x64 |
| Sqldk.dll | 2022.160.4215.2 | 4024360 | 11-Aug-2025 | 14:49 | x64 |
| Sqldumper.exe | 2022.160.4215.2 | 448544 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 1763360 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4610064 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 3778576 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4610080 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4511752 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 2463776 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 2406432 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4241456 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4220944 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 1701904 | 11-Aug-2025 | 14:49 | x64 |
| Sqlevn70.rll | 2022.160.4215.2 | 4474912 | 11-Aug-2025 | 14:49 | x64 |
| Sqlncli17e.dll | 2017.1710.6.1 | 1898520 | 11-Aug-2025 | 14:49 | x64 |
| Sqlos.dll | 2022.160.4215.2 | 51208 | 11-Aug-2025 | 14:49 | x64 |
| Sqlsortpdw.dll | 2022.160.1057.0 | 4841496 | 11-Aug-2025 | 14:49 | x64 |
| Sqltses.dll | 2022.160.4215.2 | 10668072 | 11-Aug-2025 | 14:49 | x64 |
| System.spatial.dll | 5.8.4.63386 | 130464 | 11-Aug-2025 | 14:49 | x86 |

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
