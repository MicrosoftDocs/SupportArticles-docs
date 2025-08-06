---
title: Cumulative update 20 for SQL Server 2022 (KB5059390)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 cumulative update 20 (KB5059390).
ms.date: 07/10/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5059390
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5059390 - Cumulative Update 20 for SQL Server 2022

_Release Date:_ &nbsp; July 10, 2025  
_Version:_ &nbsp; 16.0.4205.1

## Summary

This article describes Cumulative Update package 20 (CU20) for Microsoft SQL Server 2022. This update contains 11 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 19 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4205.1**, file version: **2022.160.4205.1**
- Analysis Services - Product version: **16.0.43.247**, file version: **2022.160.43.247**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table:

| Bug reference | Description | Fix area| Component | Platform|
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|-------------------------|---------------|
|<a id=4295018>[4295018](#4295018) </a> | Fixes an infrequent race condition in which proactive caching register notification in multidimensional mode might cause a SQL Server Analysis Services (SSAS) server to stop responding during startup.| Analysis Services | Analysis Services | Windows |
|<a id=4100859>[4100859](#4100859) </a> | Fixes an assertion failure (Location:"sql\\ntdbms\\storeng\\dfs\\manager\\blobaccess.cpp":9441; Expression:filepos > protocolHandler->m_maxFilePosSoFar) that you encounter when backing up to S3-compatible object storage fails and then having 20 retries. | SQL Server Engine | Backup Restore| All |
|<a id=4123934>[4123934](#4123934) </a> | Fixes a deadlock issue that results in a non-yielding scheduler and causes the SQL Server instance to stop responding when `control.alternatewritethrough` is set to `1` under low vCPU conditions. | 	SQL Server Engine | Linux | Linux |
|<a id=4297001>[4297001](#4297001) </a> | Adds memory limit support for Control Groups (cgroups) v2 in Platform Abstraction Layer (SQLPAL). | SQL Server Engine | Linux | Linux |
|<a id=4167049>[4167049](#4167049) </a> | Fixes a non-yielding scheduler dump issue with `qds!CDBQDS::AbortQdsBackgroundTask` that may occur when the list of Query Store (QDS) background tasks is large and either QDS is disabled or SQL Server shuts down. In addition to the dump, you would see the following error messages: </br></br> Error: 1222, Severity: 16, State: 111.</br>Lock request time out period exceeded.</br>Error: 12412, Severity: 16, State: 1.</br>Internal table access error: failed to access the Query Store internal table with HRESULT: 0x80004005| SQL Server Engine | High Availability and Disaster Recovery | All |
|<a id=4257781>[4257781](#4257781) </a> | 	Fixes an issue in which uninitialized memory is returned in some rare cases when using limited length parameters with `REPLACE` function. | SQL Server Engine | Programmability | All |
|<a id=4277598>[4277598](#4277598) </a> | 	Fixes an issue in which an access violation dump occurs instead of returning the correct error message when using `PARSE` or `TRY_PARSE` with special floating-point values such as NaN (Not-a-Number) or Infinity as input.| 	SQL Server Engine | Programmability | All |
|<a id=4053244>[4053244](#4053244) </a> | 	Fixes an issue in which uninitialized memory can be read in some rare cases when using variable length parameters.| 	SQL Server Engine | Query Execution | All |
|<a id=4104525>[4104525](#4104525) </a> | Fixes an access violation that you encounter when a query calls a multi-statement table-valued function (MSTVF) that has a common language runtime (CLR) expression in its parameter and triggers interleaved execution.| 	SQL Server Engine | Query Optimizer | All |
|<a id=4317961>[4317961](#4317961) </a> | Adds support for "**WITH SID=sid, TYPE=[E\|X]**" in the `CREATE USER` syntax in SQL Server 2022 by using trace flag 11953. For more information, see [CREATE USER (Transact-SQL)](/sql/t-sql/statements/create-user-transact-sql#syntax). | SQL Server Engine | SQL Server Engine | All |
|<a id=4044263>[4044263](#4044263) </a> | Fixes an issue introduced by a previous Windows update that causes restarts and even prevents setup from continuing. After applying this fix, the value of the `PendingFileRenameOperations` registry key is deleted when applying updates to SQL Server. | SQL Setup | Patching| 	Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU20 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5059390)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5059390-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5059390-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5059390-x64.exe| 3565C4DE8D3ADB31BCD7B11528B1287FFC7A23E118A5817FCBCF92DC88270243 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Anglesharp.dll | 0.9.9.0 | 1240112 | 13-Jun-2025 | 14:12 | x86 |
| Asplatformhost.dll | 2022.160.43.247 | 336936 | 13-Jun-2025 | 14:12 | x64 |
| Mashupcompression.dll | 2.127.602.0 | 141760 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.analysisservices.minterop.dll | 16.0.43.247 | 865296 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.analysisservices.server.core.dll | 16.0.43.247 | 2903568 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.edm.netfx35.dll | 5.7.0.62516 | 661936 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.dll | 2.127.602.0 | 224184 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.oledb.dll | 2.127.602.0 | 32192 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.preview.dll | 2.127.602.0 | 153528 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.dll | 2.127.602.0 | 113088 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 33216 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47040 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47024 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.mashup.sqlclient.dll | 2.127.602.0 | 25536 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.odata.netfx35.dll | 5.7.0.62516 | 1455536 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.odata.query.netfx35.dll | 5.7.0.62516 | 182200 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.dll | 1.0.0.25 | 931680 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 35200 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 36704 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 36704 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 37216 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 39808 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 49024 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sqlclient.dll | 2.17.23292.1 | 1997744 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sqlclient.sni.dll | 2.1.1.0 | 511920 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.dataintegration.fuzzyclustering.dll | 1.0.0.0 | 40368 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.dataintegration.fuzzymatching.dll | 1.0.0.0 | 628144 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.dataintegration.fuzzymatchingcommon.dll | 1.0.0.0 | 390064 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.exchange.webservices.dll | 15.0.913.15 | 1124272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.hostintegration.connectors.dll | 2.127.602.0 | 4964800 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identity.client.dll | 4.57.0.0 | 1653680 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.35.0.41201 | 111536 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.logging.dll | 6.35.0.41201 | 38320 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.35.0.41201 | 39856 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201 | 114096 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.35.0.41201 | 992192 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.cdm.icdmprovider.dll | 2.127.602.0 | 21952 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.container.exe | 2.127.602.0 | 25024 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.mashup.container.netfx40.exe | 2.127.602.0 | 24000 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.mashup.container.netfx45.exe | 2.127.602.0 | 23992 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.mashup.eventsource.dll | 2.127.602.0 | 150448 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.dll | 2.127.602.0 | 94144 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15808 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16320 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16312 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16816 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 17344 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15792 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbinterop.dll | 2.127.602.0 | 201144 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.mashup.oledbprovider.dll | 2.127.602.0 | 67008 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14264 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.sapbwprovider.dll | 2.127.602.0 | 334256 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.scriptdom.dll | 2.40.4554.261 | 2365872 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.shims.dll | 2.127.602.0 | 29616 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0 | 141248 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.dll | 2.127.602.0 | 15941040 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.dll | 2.127.602.0 | 7617472 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39360 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 35872 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 36288 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39856 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39872 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40368 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40888 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 42424 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 47024 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 620464 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 747448 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 739248 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 718776 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 776128 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 726960 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 702384 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 980912 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 612272 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 714672 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.mshtml.dll | 7.0.3300.1 | 8017840 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.odata.core.netfx35.dll | 6.15.0.0 | 1438656 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.odata.core.netfx35.v7.dll | 7.4.0.11102 | 1262000 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.odata.edm.netfx35.dll | 6.15.0.0 | 779712 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.odata.edm.netfx35.v7.dll | 7.4.0.11102 | 745920 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.powerbi.adomdclient.dll | 16.0.122.20 | 1216944 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.spatial.netfx35.dll | 6.15.0.0 | 127408 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.spatial.netfx35.v7.dll | 7.4.0.11102 | 125368 | 13-Jun-2025 | 14:12 | x86 |
| Msmdctr.dll | 2022.160.43.247 | 38952 | 13-Jun-2025 | 14:12 | x64 |
| Msmdlocal.dll | 2022.160.43.247 | 71820336 | 13-Jun-2025 | 14:12 | x64 |
| Msmdlocal.dll | 2022.160.43.247 | 53976624 | 13-Jun-2025 | 14:12 | x86 |
| Msmdpump.dll | 2022.160.43.247 | 10334280 | 13-Jun-2025 | 14:12 | x64 |
| Msmdredir.dll | 2022.160.43.247 | 8132656 | 13-Jun-2025 | 14:12 | x86 |
| Msmdsrv.exe | 2022.160.43.247 | 71362120 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 956960 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1884688 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1671720 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1881104 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1848352 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1147448 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1140264 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1769512 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1749008 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 932896 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrv.rll | 2022.160.43.247 | 1837584 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 955432 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1882664 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1668624 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1876520 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1844776 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1145376 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1138704 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1765416 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1745424 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 933416 | 13-Jun-2025 | 14:12 | x64 |
| Msmdsrvi.rll | 2022.160.43.247 | 1832976 | 13-Jun-2025 | 14:12 | x64 |
| Msmgdsrv.dll | 2022.160.43.247 | 10083400 | 13-Jun-2025 | 14:12 | x64 |
| Msmgdsrv.dll | 2022.160.43.247 | 8265800 | 13-Jun-2025 | 14:12 | x86 |
| Msolap.dll | 2022.160.43.247 | 10969656 | 13-Jun-2025 | 14:12 | x64 |
| Msolap.dll | 2022.160.43.247 | 8744536 | 13-Jun-2025 | 14:12 | x86 |
| Msolui.dll | 2022.160.43.247 | 308280 | 13-Jun-2025 | 14:12 | x64 |
| Msolui.dll | 2022.160.43.247 | 289832 | 13-Jun-2025 | 14:12 | x86 |
| Newtonsoft.json.dll | 13.0.3.27908 | 722264 | 13-Jun-2025 | 14:12 | x86 |
| Parquetsharp.dll | 0.0.0.0 | 412592 | 13-Jun-2025 | 14:12 | x64 |
| Parquetsharpnative.dll | 7.0.0.17 | 20091320 | 13-Jun-2025 | 14:12 | x64 |
| Powerbiextensions.dll | 2.127.602.0 | 11111344 | 13-Jun-2025 | 14:12 | x86 |
| Private\_odbc32.dll | 10.0.19041.1 | 735288 | 13-Jun-2025 | 14:12 | x64 |
| Sni.dll | 1.1.1.0 | 555424 | 13-Jun-2025 | 14:12 | x64 |
| Sql\_as\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:12 | x64 |
| Sqlceip.exe | 16.0.4205.1 | 301072 | 13-Jun-2025 | 14:12 | x86 |
| Sqldumper.exe | 2022.160.4205.1 | 448552 | 13-Jun-2025 | 14:12 | x64 |
| Sqldumper.exe | 2022.160.4205.1 | 383000 | 13-Jun-2025 | 14:12 | x86 |
| System.identitymodel.tokens.jwt.dll | 6.35.0.41201 | 77248 | 13-Jun-2025 | 14:12 | x86 |
| System.spatial.netfx35.dll | 5.7.0.62516 | 118704 | 13-Jun-2025 | 14:12 | x86 |
| Tmapi.dll | 2022.160.43.247 | 5884504 | 13-Jun-2025 | 14:12 | x64 |
| Tmcachemgr.dll | 2022.160.43.247 | 5575728 | 13-Jun-2025 | 14:12 | x64 |
| Tmpersistence.dll | 2022.160.43.247 | 1481256 | 13-Jun-2025 | 14:12 | x64 |
| Tmtransactions.dll | 2022.160.43.247 | 7198256 | 13-Jun-2025 | 14:12 | x64 |
| Xmsrv.dll | 2022.160.43.247 | 26593368 | 13-Jun-2025 | 14:12 | x64 |
| Xmsrv.dll | 2022.160.43.247 | 35895856 | 13-Jun-2025 | 14:12 | x86 |

SQL Server 2022 Database Services Common Core

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Instapi150.dll | 2022.160.4205.1 | 104456 | 13-Jun-2025 | 14:12 | x64 |
| Instapi150.dll | 2022.160.4205.1 | 79912 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.247 | 2633744 | 13-Jun-2025 | 14:08 | x86 |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.247 | 2633744 | 13-Jun-2025 | 14:09 | x86 |
| Microsoft.analysisservices.core.dll | 16.0.43.247 | 2933288 | 13-Jun-2025 | 14:08 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.247 | 2323472 | 13-Jun-2025 | 14:09 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.247 | 2323496 | 13-Jun-2025 | 14:09 | x86 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4205.1 | 104472 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4205.1 | 92168 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.rmo.dll | 16.0.4205.1 | 555040 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.rmo.dll | 16.0.4205.1 | 555016 | 13-Jun-2025 | 14:12 | x86 |
| Msasxpress.dll | 2022.160.43.247 | 27664 | 13-Jun-2025 | 14:09 | x86 |
| Msasxpress.dll | 2022.160.43.247 | 32784 | 13-Jun-2025 | 14:09 | x64 |
| Sql\_common\_core\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:09 | x64 |
| Sqldumper.exe | 2022.160.4205.1 | 448552 | 13-Jun-2025 | 14:12 | x64 |
| Sqldumper.exe | 2022.160.4205.1 | 383000 | 13-Jun-2025 | 14:12 | x86 |
| Sqlmgmprovider.dll | 2022.160.4205.1 | 456712 | 13-Jun-2025 | 14:12 | x64 |
| Sqlmgmprovider.dll | 2022.160.4205.1 | 395304 | 13-Jun-2025 | 14:12 | x86 |
| Sqlsvcsync.dll | 2022.160.4205.1 | 362512 | 13-Jun-2025 | 14:12 | x64 |
| Sqlsvcsync.dll | 2022.160.4205.1 | 280624 | 13-Jun-2025 | 14:12 | x86 |
| Svrenumapi150.dll | 2022.160.4205.1 | 1247240 | 13-Jun-2025 | 14:12 | x64 |
| Svrenumapi150.dll | 2022.160.4205.1 | 972816 | 13-Jun-2025 | 14:12 | x86 |

SQL Server 2022 Data Quality Client

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.studio.infra.dll | 16.0.4205.1 | 309280 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.studio.viewmodels.dll | 16.0.4205.1 | 1009704 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.studio.views.dll | 16.0.4205.1 | 2070544 | 13-Jun-2025 | 14:12 | x86 |
| Sql\_dqc\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:12 | x64 |

SQL Server 2022 Data Quality

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.cleansing.dll | 16.0.4205.1 | 469008 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.cleansing.dll | 16.0.4205.1 | 469024 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4205.1 | 600080 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4205.1 | 600080 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.dll | 16.0.4205.1 | 174096 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.dll | 16.0.4205.1 | 174136 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.infra.dll | 16.0.4205.1 | 1857552 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.infra.dll | 16.0.4205.1 | 1857552 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4205.1 | 370696 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4205.1 | 370744 | 13-Jun-2025 | 14:12 | x86 |
| Dqsinstaller.exe | 16.0.4205.1 | 2775048 | 13-Jun-2025 | 14:12 | x86 |
| Sql\_dq\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:12 | x64 |

SQL Server 2022 Database Services Core Instance

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Adal.dll | 3.6.1.64359 | 1618832 | 13-Jun-2025 | 15:11 | x64 |
| Adalsqlrda.dll | 3.6.1.64359 | 1618832 | 13-Jun-2025 | 15:11 | x64 |
| Aetm-enclave-simulator.dll | 2022.160.4205.1 | 5993032 | 13-Jun-2025 | 15:11 | x64 |
| Aetm-enclave.dll | 2022.160.4205.1 | 5959704 | 13-Jun-2025 | 15:11 | x64 |
| Aetm-sgx-enclave-simulator.dll | 2022.160.4205.1 | 6194800 | 13-Jun-2025 | 15:11 | x64 |
| Aetm-sgx-enclave.dll | 2022.160.4205.1 | 6160704 | 13-Jun-2025 | 15:11 | x64 |
| Databasemail.exe | 16.0.4205.1 | 30760 | 13-Jun-2025 | 15:11 | x64 |
| Databasemailengine.dll | 16.0.4205.1 | 79888 | 13-Jun-2025 | 15:11 | x86 |
| Dcexec.exe | 2022.160.4205.1 | 96288 | 13-Jun-2025 | 15:11 | x64 |
| Fssres.dll | 2022.160.4205.1 | 100384 | 13-Jun-2025 | 15:11 | x64 |
| Hadrres.dll | 2022.160.4205.1 | 227360 | 13-Jun-2025 | 15:11 | x64 |
| Hkcompile.dll | 2022.160.4205.1 | 1427464 | 13-Jun-2025 | 15:11 | x64 |
| Hkdllgen.exe | 2022.160.4205.1 | 1570856 | 13-Jun-2025 | 15:11 | x64 |
| Hkengine.dll | 2022.160.4205.1 | 5769280 | 13-Jun-2025 | 15:11 | x64 |
| Hkruntime.dll | 2022.160.4205.1 | 190520 | 13-Jun-2025 | 15:11 | x64 |
| Hktempdb.dll | 2022.160.4205.1 | 71688 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.247 | 2322456 | 13-Jun-2025 | 15:11 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 13-Jun-2025 | 15:11 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 13-Jun-2025 | 15:11 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4205.1 | 84008 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4205.1 | 182288 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4205.1 | 198664 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.sqlserver.xevent.linq.dll | 2022.160.4205.1 | 333840 | 13-Jun-2025 | 15:11 | x64 |
| Microsoft.sqlserver.xevent.targets.dll | 2022.160.4205.1 | 96288 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 30736 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 38928 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 34832 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 38920 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 38928 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 30728 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 30728 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 34824 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 38944 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 30760 | 13-Jun-2025 | 15:11 | x64 |
| Odsole70.rll | 16.0.4205.1 | 38920 | 13-Jun-2025 | 15:11 | x64 |
| Qds.dll | 2022.160.4205.1 | 1820688 | 13-Jun-2025 | 15:11 | x64 |
| Rsfxft.dll | 2022.160.4205.1 | 55328 | 13-Jun-2025 | 15:11 | x64 |
| Secforwarder.dll | 2022.160.4205.1 | 84008 | 13-Jun-2025 | 15:11 | x64 |
| Sql\_engine\_core\_inst\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 15:11 | x64 |
| Sqlaamss.dll | 2022.160.4205.1 | 120864 | 13-Jun-2025 | 15:11 | x64 |
| Sqlaccess.dll | 2022.160.4205.1 | 444432 | 13-Jun-2025 | 15:11 | x64 |
| Sqlagent.exe | 2022.160.4205.1 | 722976 | 13-Jun-2025 | 15:11 | x64 |
| Sqlagentmail.dll | 2022.160.4205.1 | 75792 | 13-Jun-2025 | 15:11 | x64 |
| Sqlceip.exe | 16.0.4205.1 | 301072 | 13-Jun-2025 | 15:11 | x86 |
| Sqlcmdss.dll | 2022.160.4205.1 | 104464 | 13-Jun-2025 | 15:11 | x64 |
| Sqlctr160.dll | 2022.160.4205.1 | 157736 | 13-Jun-2025 | 15:11 | x64 |
| Sqlctr160.dll | 2022.160.4205.1 | 129056 | 13-Jun-2025 | 15:11 | x86 |
| Sqldk.dll | 2022.160.4205.1 | 4024376 | 13-Jun-2025 | 15:11 | x64 |
| Sqldtsss.dll | 2022.160.4205.1 | 120864 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 1763360 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3876880 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4093992 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4605968 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4737056 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3774504 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3962888 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4605960 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4433968 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4507688 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 2459688 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 2402312 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4290600 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3926032 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4442168 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4237320 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4216840 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3999760 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3876904 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 1697808 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4327456 | 13-Jun-2025 | 15:11 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4470792 | 13-Jun-2025 | 15:11 | x64 |
| Sqliosim.com | 2022.160.4205.1 | 395296 | 13-Jun-2025 | 15:11 | x64 |
| Sqliosim.exe | 2022.160.4205.1 | 3069992 | 13-Jun-2025 | 15:11 | x64 |
| Sqllang.dll | 2022.160.4205.1 | 49010752 | 13-Jun-2025 | 15:11 | x64 |
| Sqlmin.dll | 2022.160.4205.1 | 52242496 | 13-Jun-2025 | 15:11 | x64 |
| Sqlolapss.dll | 2022.160.4205.1 | 116768 | 13-Jun-2025 | 15:11 | x64 |
| Sqlos.dll | 2022.160.4205.1 | 51216 | 13-Jun-2025 | 15:11 | x64 |
| Sqlpowershellss.dll | 2022.160.4205.1 | 100360 | 13-Jun-2025 | 15:11 | x64 |
| Sqlrepss.dll | 2022.160.4205.1 | 149528 | 13-Jun-2025 | 15:11 | x64 |
| Sqlscriptdowngrade.dll | 2022.160.4205.1 | 51216 | 13-Jun-2025 | 15:11 | x64 |
| Sqlscriptupgrade.dll | 2022.160.4205.1 | 5838920 | 13-Jun-2025 | 15:11 | x64 |
| Sqlservr.exe | 2022.160.4205.1 | 727048 | 13-Jun-2025 | 15:11 | x64 |
| Sqlsvc.dll | 2022.160.4205.1 | 194592 | 13-Jun-2025 | 15:11 | x64 |
| Sqltses.dll | 2022.160.4205.1 | 10668096 | 13-Jun-2025 | 15:11 | x64 |
| Sqsrvres.dll | 2022.160.4205.1 | 305184 | 13-Jun-2025 | 15:11 | x64 |
| Svl.dll | 2022.160.4205.1 | 247816 | 13-Jun-2025 | 15:11 | x64 |
| System.buffers.dll | 4.6.28619.1 | 20856 | 13-Jun-2025 | 15:11 | x86 |
| System.configuration.configurationmanager.dll | 6.0.922.41905 | 87184 | 13-Jun-2025 | 15:11 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 13-Jun-2025 | 15:11 | x86 |
| System.numerics.vectors.dll | 4.6.26515.6 | 115856 | 13-Jun-2025 | 15:11 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 13-Jun-2025 | 15:11 | x86 |
| System.runtime.interopservices.runtimeinformation.dll | 4.6.24705.1 | 33256 | 13-Jun-2025 | 15:11 | x86 |
| System.text.encodings.web.dll | 6.0.21.52210 | 76904 | 13-Jun-2025 | 15:11 | x86 |
| Xe.dll | 2022.160.4205.1 | 718888 | 13-Jun-2025 | 15:11 | x64 |
| Xpqueue.dll | 2022.160.4205.1 | 100360 | 13-Jun-2025 | 15:11 | x64 |
| Xpstar.dll | 2022.160.4205.1 | 534544 | 13-Jun-2025 | 15:11 | x64 |

SQL Server 2022 Database Services Core Shared

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Azure.core.dll | 1.3600.23.56006 | 384432 | 13-Jun-2025 | 14:12 | x86 |
| Azure.identity.dll | 1.1000.423.56303 | 334768 | 13-Jun-2025 | 14:12 | x86 |
| Bcp.exe | 2022.160.4205.1 | 141328 | 13-Jun-2025 | 14:12 | x64 |
| Commanddest.dll | 2022.160.4205.1 | 272392 | 13-Jun-2025 | 14:12 | x64 |
| Datacollectortasks.dll | 2022.160.4205.1 | 227352 | 13-Jun-2025 | 14:12 | x64 |
| Distrib.exe | 2022.160.4205.1 | 260112 | 13-Jun-2025 | 14:12 | x64 |
| Dteparse.dll | 2022.160.4205.1 | 133128 | 13-Jun-2025 | 14:12 | x64 |
| Dteparsemgd.dll | 2022.160.4205.1 | 178208 | 13-Jun-2025 | 14:12 | x64 |
| Dtepkg.dll | 2022.160.4205.1 | 153640 | 13-Jun-2025 | 14:12 | x64 |
| Dtexec.exe | 2022.160.4205.1 | 76832 | 13-Jun-2025 | 14:12 | x64 |
| Dts.dll | 2022.160.4205.1 | 3270712 | 13-Jun-2025 | 14:12 | x64 |
| Dtscomexpreval.dll | 2022.160.4205.1 | 493576 | 13-Jun-2025 | 14:12 | x64 |
| Dtsconn.dll | 2022.160.4205.1 | 550944 | 13-Jun-2025 | 14:12 | x64 |
| Dtshost.exe | 2022.160.4205.1 | 120328 | 13-Jun-2025 | 14:12 | x64 |
| Dtslog.dll | 2022.160.4205.1 | 137232 | 13-Jun-2025 | 14:12 | x64 |
| Dtspipeline.dll | 2022.160.4205.1 | 1337368 | 13-Jun-2025 | 14:12 | x64 |
| Dtuparse.dll | 2022.160.4205.1 | 104480 | 13-Jun-2025 | 14:12 | x64 |
| Dtutil.exe | 2022.160.4205.1 | 166440 | 13-Jun-2025 | 14:12 | x64 |
| Exceldest.dll | 2022.160.4205.1 | 284696 | 13-Jun-2025 | 14:12 | x64 |
| Excelsrc.dll | 2022.160.4205.1 | 305168 | 13-Jun-2025 | 14:12 | x64 |
| Execpackagetask.dll | 2022.160.4205.1 | 182304 | 13-Jun-2025 | 14:12 | x64 |
| Flatfiledest.dll | 2022.160.4205.1 | 423944 | 13-Jun-2025 | 14:12 | x64 |
| Flatfilesrc.dll | 2022.160.4205.1 | 440328 | 13-Jun-2025 | 14:12 | x64 |
| Logread.exe | 2022.160.4205.1 | 792616 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933792 | 13-Jun-2025 | 14:09 | x86 |
| Microsoft.bcl.asyncinterfaces.dll | 6.0.21.52210 | 22144 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.data.tools.sql.batchparser.dll | 17.100.23.0 | 42416 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4205.1 | 30760 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identity.client.extensions.msal.dll | 4.56.0.0 | 66552 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.abstractions.dll | 6.24.0.31013 | 18864 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.24.0.31013 | 85424 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.logging.dll | 6.24.0.31013 | 34224 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.24.0.31013 | 38288 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.24.0.31013 | 114048 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.24.0.31013 | 986032 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.connectioninfo.dll | 17.100.23.0 | 126496 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.dmf.common.dll | 17.100.23.0 | 63520 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4205.1 | 391176 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.management.sdk.sfc.dll | 17.100.23.0 | 513464 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.replication.dll | 2022.160.4205.1 | 1718312 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.sqlserver.rmo.dll | 16.0.4205.1 | 555016 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.servicebrokerenum.dll | 17.100.23.0 | 37920 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.smo.dll | 17.100.23.0 | 4451872 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.smoextended.dll | 17.100.23.0 | 161208 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.sqlclrprovider.dll | 17.100.23.0 | 21536 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.sqlenum.dll | 17.100.23.0 | 1587744 | 13-Jun-2025 | 14:12 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4205.1 | 182288 | 13-Jun-2025 | 14:12 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4205.1 | 198664 | 13-Jun-2025 | 14:12 | x64 |
| Msdtssrvrutil.dll | 2022.160.4205.1 | 124944 | 13-Jun-2025 | 14:12 | x64 |
| Msgprox.dll | 2022.160.4205.1 | 313352 | 13-Jun-2025 | 14:12 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 2750472 | 13-Jun-2025 | 14:12 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 153608 | 13-Jun-2025 | 14:12 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 13-Jun-2025 | 14:12 | x86 |
| Oledbdest.dll | 2022.160.4205.1 | 288776 | 13-Jun-2025 | 14:12 | x64 |
| Oledbsrc.dll | 2022.160.4205.1 | 317456 | 13-Jun-2025 | 14:12 | x64 |
| Qrdrsvc.exe | 2022.160.4205.1 | 526352 | 13-Jun-2025 | 14:12 | x64 |
| Rawdest.dll | 2022.160.4205.1 | 227376 | 13-Jun-2025 | 14:12 | x64 |
| Rawsource.dll | 2022.160.4205.1 | 215056 | 13-Jun-2025 | 14:12 | x64 |
| Rdistcom.dll | 2022.160.4205.1 | 944144 | 13-Jun-2025 | 14:12 | x64 |
| Recordsetdest.dll | 2022.160.4205.1 | 206888 | 13-Jun-2025 | 14:12 | x64 |
| Repldp.dll | 2022.160.4205.1 | 337936 | 13-Jun-2025 | 14:12 | x64 |
| Replerrx.dll | 2022.160.4205.1 | 198672 | 13-Jun-2025 | 14:12 | x64 |
| Replisapi.dll | 2022.160.4205.1 | 419856 | 13-Jun-2025 | 14:12 | x64 |
| Replmerg.exe | 2022.160.4205.1 | 600096 | 13-Jun-2025 | 14:12 | x64 |
| Replprov.dll | 2022.160.4205.1 | 890912 | 13-Jun-2025 | 14:12 | x64 |
| Replrec.dll | 2022.160.4205.1 | 1062936 | 13-Jun-2025 | 14:12 | x64 |
| Replsub.dll | 2022.160.4205.1 | 505872 | 13-Jun-2025 | 14:12 | x64 |
| Spresolv.dll | 2022.160.4205.1 | 305192 | 13-Jun-2025 | 14:12 | x64 |
| Sql\_engine\_core\_shared\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:09 | x64 |
| Sqlcmd.exe | 2022.160.4205.1 | 276496 | 13-Jun-2025 | 14:12 | x64 |
| Sqldiag.exe | 2022.160.4205.1 | 1140752 | 13-Jun-2025 | 14:12 | x64 |
| Sqldistx.dll | 2022.160.4205.1 | 268304 | 13-Jun-2025 | 14:12 | x64 |
| Sqlmergx.dll | 2022.160.4205.1 | 423960 | 13-Jun-2025 | 14:12 | x64 |
| Sqlnclirda11.dll | 2011.110.5069.66 | 3478208 | 13-Jun-2025 | 14:12 | x64 |
| Sqlsvc.dll | 2022.160.4205.1 | 153616 | 13-Jun-2025 | 14:12 | x86 |
| Sqlsvc.dll | 2022.160.4205.1 | 194592 | 13-Jun-2025 | 14:12 | x64 |
| Sqltaskconnections.dll | 2022.160.4205.1 | 210984 | 13-Jun-2025 | 14:12 | x64 |
| Sqlwep160.dll | 2022.160.4205.1 | 124968 | 13-Jun-2025 | 14:12 | x64 |
| Ssradd.dll | 2022.160.4205.1 | 100360 | 13-Jun-2025 | 14:12 | x64 |
| Ssravg.dll | 2022.160.4205.1 | 100368 | 13-Jun-2025 | 14:12 | x64 |
| Ssrmax.dll | 2022.160.4205.1 | 100368 | 13-Jun-2025 | 14:12 | x64 |
| Ssrmin.dll | 2022.160.4205.1 | 100368 | 13-Jun-2025 | 14:12 | x64 |
| System.diagnostics.diagnosticsource.dll | 7.0.423.11508 | 173232 | 13-Jun-2025 | 14:12 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 13-Jun-2025 | 14:12 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 13-Jun-2025 | 14:12 | x86 |
| System.security.cryptography.protecteddata.dll | 7.0.22.51805 | 21640 | 13-Jun-2025 | 14:12 | x86 |
| Txagg.dll | 2022.160.4205.1 | 395304 | 13-Jun-2025 | 14:12 | x64 |
| Txbdd.dll | 2022.160.4205.1 | 190472 | 13-Jun-2025 | 14:12 | x64 |
| Txdatacollector.dll | 2022.160.4205.1 | 469040 | 13-Jun-2025 | 14:12 | x64 |
| Txdataconvert.dll | 2022.160.4205.1 | 333840 | 13-Jun-2025 | 14:12 | x64 |
| Txderived.dll | 2022.160.4205.1 | 632848 | 13-Jun-2025 | 14:12 | x64 |
| Txlookup.dll | 2022.160.4205.1 | 608296 | 13-Jun-2025 | 14:12 | x64 |
| Txmerge.dll | 2022.160.4205.1 | 243728 | 13-Jun-2025 | 14:12 | x64 |
| Txmergejoin.dll | 2022.160.4205.1 | 301112 | 13-Jun-2025 | 14:12 | x64 |
| Txmulticast.dll | 2022.160.4205.1 | 145416 | 13-Jun-2025 | 14:12 | x64 |
| Txrowcount.dll | 2022.160.4205.1 | 145416 | 13-Jun-2025 | 14:12 | x64 |
| Txsort.dll | 2022.160.4205.1 | 276504 | 13-Jun-2025 | 14:12 | x64 |
| Txsplit.dll | 2022.160.4205.1 | 620584 | 13-Jun-2025 | 14:12 | x64 |
| Txunionall.dll | 2022.160.4205.1 | 194584 | 13-Jun-2025 | 14:12 | x64 |
| Xe.dll | 2022.160.4205.1 | 718888 | 13-Jun-2025 | 14:12 | x64 |

SQL Server 2022 sql\_extensibility

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commonlauncher.dll | 2022.160.4205.1 | 100400 | 13-Jun-2025 | 14:12 | x64 |
| Exthost.exe | 2022.160.4205.1 | 247848 | 13-Jun-2025 | 14:12 | x64 |
| Launchpad.exe | 2022.160.4205.1 | 1452080 | 13-Jun-2025 | 14:12 | x64 |
| Sql\_extensibility\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:09 | x64 |
| Sqlsatellite.dll | 2022.160.4205.1 | 1255432 | 13-Jun-2025 | 14:12 | x64 |

SQL Server 2022 Full-Text Engine

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Fd.dll | 2022.160.4205.1 | 702472 | 13-Jun-2025 | 14:12 | x64 |
| Fdhost.exe | 2022.160.4205.1 | 157736 | 13-Jun-2025 | 14:12 | x64 |
| Fdlauncher.exe | 2022.160.4205.1 | 100384 | 13-Jun-2025 | 14:12 | x64 |
| Sql\_fulltext\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:10 | x64 |

SQL Server 2022 Integration Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Attunity.sqlserver.cdccontroltask.dll | 7.0.0.133 | 78272 | 13-Jun-2025 | 14:17 | x86 |
| Attunity.sqlserver.cdccontroltask.dll | 7.0.0.133 | 78272 | 13-Jun-2025 | 14:17 | x86 |
| Attunity.sqlserver.cdcsplit.dll | 7.0.0.133 | 39320 | 13-Jun-2025 | 14:17 | x86 |
| Attunity.sqlserver.cdcsplit.dll | 7.0.0.133 | 39320 | 13-Jun-2025 | 14:17 | x86 |
| Attunity.sqlserver.cdcsrc.dll | 7.0.0.133 | 79808 | 13-Jun-2025 | 14:17 | x86 |
| Attunity.sqlserver.cdcsrc.dll | 7.0.0.133 | 79808 | 13-Jun-2025 | 14:17 | x86 |
| Commanddest.dll | 2022.160.4205.1 | 272392 | 13-Jun-2025 | 14:17 | x64 |
| Commanddest.dll | 2022.160.4205.1 | 231464 | 13-Jun-2025 | 14:17 | x86 |
| Dteparse.dll | 2022.160.4205.1 | 133128 | 13-Jun-2025 | 14:17 | x64 |
| Dteparse.dll | 2022.160.4205.1 | 116744 | 13-Jun-2025 | 14:17 | x86 |
| Dteparsemgd.dll | 2022.160.4205.1 | 178208 | 13-Jun-2025 | 14:17 | x64 |
| Dteparsemgd.dll | 2022.160.4205.1 | 165936 | 13-Jun-2025 | 14:17 | x86 |
| Dtepkg.dll | 2022.160.4205.1 | 153640 | 13-Jun-2025 | 14:17 | x64 |
| Dtepkg.dll | 2022.160.4205.1 | 133160 | 13-Jun-2025 | 14:17 | x86 |
| Dtexec.exe | 2022.160.4205.1 | 76832 | 13-Jun-2025 | 14:17 | x64 |
| Dtexec.exe | 2022.160.4205.1 | 65056 | 13-Jun-2025 | 14:17 | x86 |
| Dts.dll | 2022.160.4205.1 | 3270712 | 13-Jun-2025 | 14:17 | x64 |
| Dts.dll | 2022.160.4205.1 | 2861088 | 13-Jun-2025 | 14:17 | x86 |
| Dtscomexpreval.dll | 2022.160.4205.1 | 493576 | 13-Jun-2025 | 14:17 | x64 |
| Dtscomexpreval.dll | 2022.160.4205.1 | 444424 | 13-Jun-2025 | 14:17 | x86 |
| Dtsconn.dll | 2022.160.4205.1 | 550944 | 13-Jun-2025 | 14:17 | x64 |
| Dtsconn.dll | 2022.160.4205.1 | 464912 | 13-Jun-2025 | 14:17 | x86 |
| Dtsdebughost.exe | 2022.160.4205.1 | 114720 | 13-Jun-2025 | 14:17 | x64 |
| Dtsdebughost.exe | 2022.160.4205.1 | 94736 | 13-Jun-2025 | 14:17 | x86 |
| Dtshost.exe | 2022.160.4205.1 | 120328 | 13-Jun-2025 | 14:17 | x64 |
| Dtshost.exe | 2022.160.4205.1 | 98352 | 13-Jun-2025 | 14:17 | x86 |
| Dtslog.dll | 2022.160.4205.1 | 137232 | 13-Jun-2025 | 14:17 | x64 |
| Dtslog.dll | 2022.160.4205.1 | 120840 | 13-Jun-2025 | 14:17 | x86 |
| Dtspipeline.dll | 2022.160.4205.1 | 1337368 | 13-Jun-2025 | 14:17 | x64 |
| Dtspipeline.dll | 2022.160.4205.1 | 1144856 | 13-Jun-2025 | 14:17 | x86 |
| Dtuparse.dll | 2022.160.4205.1 | 104480 | 13-Jun-2025 | 14:17 | x64 |
| Dtuparse.dll | 2022.160.4205.1 | 88080 | 13-Jun-2025 | 14:17 | x86 |
| Dtutil.exe | 2022.160.4205.1 | 166440 | 13-Jun-2025 | 14:17 | x64 |
| Dtutil.exe | 2022.160.4205.1 | 142352 | 13-Jun-2025 | 14:17 | x86 |
| Exceldest.dll | 2022.160.4205.1 | 284696 | 13-Jun-2025 | 14:17 | x64 |
| Exceldest.dll | 2022.160.4205.1 | 247864 | 13-Jun-2025 | 14:17 | x86 |
| Excelsrc.dll | 2022.160.4205.1 | 305168 | 13-Jun-2025 | 14:17 | x64 |
| Excelsrc.dll | 2022.160.4205.1 | 264232 | 13-Jun-2025 | 14:17 | x86 |
| Execpackagetask.dll | 2022.160.4205.1 | 182304 | 13-Jun-2025 | 14:17 | x64 |
| Execpackagetask.dll | 2022.160.4205.1 | 149544 | 13-Jun-2025 | 14:17 | x86 |
| Flatfiledest.dll | 2022.160.4205.1 | 423944 | 13-Jun-2025 | 14:17 | x64 |
| Flatfiledest.dll | 2022.160.4205.1 | 374800 | 13-Jun-2025 | 14:17 | x86 |
| Flatfilesrc.dll | 2022.160.4205.1 | 440328 | 13-Jun-2025 | 14:17 | x64 |
| Flatfilesrc.dll | 2022.160.4205.1 | 391176 | 13-Jun-2025 | 14:17 | x86 |
| Isdbupgradewizard.exe | 16.0.4205.1 | 120840 | 13-Jun-2025 | 14:17 | x86 |
| Isdbupgradewizard.exe | 16.0.4205.1 | 120840 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933792 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.247 | 2933800 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4205.1 | 509968 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4205.1 | 509992 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4205.1 | 391176 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4205.1 | 182288 | 13-Jun-2025 | 14:17 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4205.1 | 170016 | 13-Jun-2025 | 14:17 | x86 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4205.1 | 198664 | 13-Jun-2025 | 14:17 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4205.1 | 178184 | 13-Jun-2025 | 14:17 | x86 |
| Msdtssrvr.exe | 16.0.4205.1 | 219168 | 13-Jun-2025 | 14:17 | x64 |
| Msdtssrvrutil.dll | 2022.160.4205.1 | 124944 | 13-Jun-2025 | 14:17 | x64 |
| Msdtssrvrutil.dll | 2022.160.4205.1 | 100392 | 13-Jun-2025 | 14:17 | x86 |
| Msmdpp.dll | 2022.160.43.247 | 10164784 | 13-Jun-2025 | 14:17 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 13-Jun-2025 | 14:17 | x86 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 13-Jun-2025 | 14:17 | x86 |
| Odbcdest.dll | 2022.160.4205.1 | 387104 | 13-Jun-2025 | 14:17 | x64 |
| Odbcdest.dll | 2022.160.4205.1 | 342032 | 13-Jun-2025 | 14:17 | x86 |
| Odbcsrc.dll | 2022.160.4205.1 | 399392 | 13-Jun-2025 | 14:17 | x64 |
| Odbcsrc.dll | 2022.160.4205.1 | 350232 | 13-Jun-2025 | 14:17 | x86 |
| Oledbdest.dll | 2022.160.4205.1 | 288776 | 13-Jun-2025 | 14:17 | x64 |
| Oledbdest.dll | 2022.160.4205.1 | 247848 | 13-Jun-2025 | 14:17 | x86 |
| Oledbsrc.dll | 2022.160.4205.1 | 317456 | 13-Jun-2025 | 14:17 | x64 |
| Oledbsrc.dll | 2022.160.4205.1 | 268328 | 13-Jun-2025 | 14:17 | x86 |
| Rawdest.dll | 2022.160.4205.1 | 227376 | 13-Jun-2025 | 14:17 | x64 |
| Rawdest.dll | 2022.160.4205.1 | 190472 | 13-Jun-2025 | 14:17 | x86 |
| Rawsource.dll | 2022.160.4205.1 | 215056 | 13-Jun-2025 | 14:17 | x64 |
| Rawsource.dll | 2022.160.4205.1 | 186376 | 13-Jun-2025 | 14:17 | x86 |
| Recordsetdest.dll | 2022.160.4205.1 | 206888 | 13-Jun-2025 | 14:17 | x64 |
| Recordsetdest.dll | 2022.160.4205.1 | 174088 | 13-Jun-2025 | 14:17 | x86 |
| Sql\_is\_keyfile.dll | 2022.160.4205.1 | 137224 | 13-Jun-2025 | 14:17 | x64 |
| Sqlceip.exe | 16.0.4205.1 | 301072 | 13-Jun-2025 | 14:17 | x86 |
| Sqldest.dll | 2022.160.4205.1 | 288776 | 13-Jun-2025 | 14:17 | x64 |
| Sqldest.dll | 2022.160.4205.1 | 256056 | 13-Jun-2025 | 14:17 | x86 |
| Sqltaskconnections.dll | 2022.160.4205.1 | 210984 | 13-Jun-2025 | 14:17 | x64 |
| Sqltaskconnections.dll | 2022.160.4205.1 | 174112 | 13-Jun-2025 | 14:17 | x86 |
| Txagg.dll | 2022.160.4205.1 | 395304 | 13-Jun-2025 | 14:17 | x64 |
| Txagg.dll | 2022.160.4205.1 | 346120 | 13-Jun-2025 | 14:17 | x86 |
| Txbdd.dll | 2022.160.4205.1 | 190472 | 13-Jun-2025 | 14:17 | x64 |
| Txbdd.dll | 2022.160.4205.1 | 149544 | 13-Jun-2025 | 14:17 | x86 |
| Txbestmatch.dll | 2022.160.4205.1 | 661512 | 13-Jun-2025 | 14:17 | x64 |
| Txbestmatch.dll | 2022.160.4205.1 | 567304 | 13-Jun-2025 | 14:17 | x86 |
| Txcache.dll | 2022.160.4205.1 | 202776 | 13-Jun-2025 | 14:17 | x64 |
| Txcache.dll | 2022.160.4205.1 | 170000 | 13-Jun-2025 | 14:17 | x86 |
| Txcharmap.dll | 2022.160.4205.1 | 325664 | 13-Jun-2025 | 14:17 | x64 |
| Txcharmap.dll | 2022.160.4205.1 | 280608 | 13-Jun-2025 | 14:17 | x86 |
| Txcopymap.dll | 2022.160.4205.1 | 202768 | 13-Jun-2025 | 14:17 | x64 |
| Txcopymap.dll | 2022.160.4205.1 | 165920 | 13-Jun-2025 | 14:17 | x86 |
| Txdataconvert.dll | 2022.160.4205.1 | 333840 | 13-Jun-2025 | 14:17 | x64 |
| Txdataconvert.dll | 2022.160.4205.1 | 288776 | 13-Jun-2025 | 14:17 | x86 |
| Txderived.dll | 2022.160.4205.1 | 632848 | 13-Jun-2025 | 14:17 | x64 |
| Txderived.dll | 2022.160.4205.1 | 559136 | 13-Jun-2025 | 14:17 | x86 |
| Txfileextractor.dll | 2022.160.4205.1 | 219152 | 13-Jun-2025 | 14:17 | x64 |
| Txfileextractor.dll | 2022.160.4205.1 | 186408 | 13-Jun-2025 | 14:17 | x86 |
| Txfileinserter.dll | 2022.160.4205.1 | 219160 | 13-Jun-2025 | 14:17 | x64 |
| Txfileinserter.dll | 2022.160.4205.1 | 186416 | 13-Jun-2025 | 14:17 | x86 |
| Txgroupdups.dll | 2022.160.4205.1 | 403496 | 13-Jun-2025 | 14:17 | x64 |
| Txgroupdups.dll | 2022.160.4205.1 | 354312 | 13-Jun-2025 | 14:17 | x86 |
| Txlineage.dll | 2022.160.4205.1 | 157704 | 13-Jun-2025 | 14:17 | x64 |
| Txlineage.dll | 2022.160.4205.1 | 129056 | 13-Jun-2025 | 14:17 | x86 |
| Txlookup.dll | 2022.160.4205.1 | 608296 | 13-Jun-2025 | 14:17 | x64 |
| Txlookup.dll | 2022.160.4205.1 | 522272 | 13-Jun-2025 | 14:17 | x86 |
| Txmerge.dll | 2022.160.4205.1 | 243728 | 13-Jun-2025 | 14:17 | x64 |
| Txmerge.dll | 2022.160.4205.1 | 194576 | 13-Jun-2025 | 14:17 | x86 |
| Txmergejoin.dll | 2022.160.4205.1 | 301112 | 13-Jun-2025 | 14:17 | x64 |
| Txmergejoin.dll | 2022.160.4205.1 | 256008 | 13-Jun-2025 | 14:17 | x86 |
| Txmulticast.dll | 2022.160.4205.1 | 145416 | 13-Jun-2025 | 14:17 | x64 |
| Txmulticast.dll | 2022.160.4205.1 | 116768 | 13-Jun-2025 | 14:17 | x86 |
| Txpivot.dll | 2022.160.4205.1 | 239624 | 13-Jun-2025 | 14:17 | x64 |
| Txpivot.dll | 2022.160.4205.1 | 198664 | 13-Jun-2025 | 14:17 | x86 |
| Txrowcount.dll | 2022.160.4205.1 | 145416 | 13-Jun-2025 | 14:17 | x64 |
| Txrowcount.dll | 2022.160.4205.1 | 116744 | 13-Jun-2025 | 14:17 | x86 |
| Txsampling.dll | 2022.160.4205.1 | 186384 | 13-Jun-2025 | 14:17 | x64 |
| Txsampling.dll | 2022.160.4205.1 | 153616 | 13-Jun-2025 | 14:17 | x86 |
| Txscd.dll | 2022.160.4205.1 | 235544 | 13-Jun-2025 | 14:17 | x64 |
| Txscd.dll | 2022.160.4205.1 | 198672 | 13-Jun-2025 | 14:17 | x86 |
| Txsort.dll | 2022.160.4205.1 | 276504 | 13-Jun-2025 | 14:17 | x64 |
| Txsort.dll | 2022.160.4205.1 | 231432 | 13-Jun-2025 | 14:17 | x86 |
| Txsplit.dll | 2022.160.4205.1 | 620584 | 13-Jun-2025 | 14:17 | x64 |
| Txsplit.dll | 2022.160.4205.1 | 550928 | 13-Jun-2025 | 14:17 | x86 |
| Txtermextraction.dll | 2022.160.4205.1 | 8701992 | 13-Jun-2025 | 14:17 | x64 |
| Txtermextraction.dll | 2022.160.4205.1 | 8648744 | 13-Jun-2025 | 14:17 | x86 |
| Txtermlookup.dll | 2022.160.4205.1 | 4184072 | 13-Jun-2025 | 14:17 | x64 |
| Txtermlookup.dll | 2022.160.4205.1 | 4139016 | 13-Jun-2025 | 14:17 | x86 |
| Txunionall.dll | 2022.160.4205.1 | 194584 | 13-Jun-2025 | 14:17 | x64 |
| Txunionall.dll | 2022.160.4205.1 | 153608 | 13-Jun-2025 | 14:17 | x86 |
| Txunpivot.dll | 2022.160.4205.1 | 215048 | 13-Jun-2025 | 14:17 | x64 |
| Txunpivot.dll | 2022.160.4205.1 | 178184 | 13-Jun-2025 | 14:17 | x86 |
| Xe.dll | 2022.160.4205.1 | 718888 | 13-Jun-2025 | 14:17 | x64 |
| Xe.dll | 2022.160.4205.1 | 641040 | 13-Jun-2025 | 14:17 | x86 |

SQL Server 2022 sql\_polybase\_core\_inst

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dms.dll | 16.0.1053.0 | 559640 | 13-Jun-2025 | 14:56 | x86 |
| Dmsnative.dll | 2022.160.1053.0 | 152624 | 13-Jun-2025 | 14:56 | x64 |
| Dwengineservice.dll | 16.0.1053.0 | 45104 | 13-Jun-2025 | 14:56 | x86 |
| Instapi150.dll | 2022.160.4205.1 | 104456 | 13-Jun-2025 | 14:56 | x64 |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll | 16.0.1053.0 | 67648 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.catalog.dll | 16.0.1053.0 | 293424 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.common.dll | 16.0.1053.0 | 1958464 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.configuration.dll | 16.0.1053.0 | 169496 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll | 16.0.1053.0 | 647208 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll | 16.0.1053.0 | 246320 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll | 16.0.1053.0 | 139312 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1053.0 | 79920 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll | 16.0.1053.0 | 51264 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.distributor.dll | 16.0.1053.0 | 88600 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.dll | 16.0.1053.0 | 1129512 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll | 16.0.1053.0 | 80944 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.eventing.dll | 16.0.1053.0 | 70680 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll | 16.0.1053.0 | 35352 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll | 16.0.1053.0 | 30744 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll | 16.0.1053.0 | 46632 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll | 16.0.1053.0 | 21568 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.failover.dll | 16.0.1053.0 | 26648 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll | 16.0.1053.0 | 131624 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll | 16.0.1053.0 | 86552 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll | 16.0.1053.0 | 100928 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.dll | 16.0.1053.0 | 293400 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 120344 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 138288 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 141360 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 137768 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 150592 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 139824 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 134704 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 176688 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 117824 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1053.0 | 136752 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.nodes.dll | 16.0.1053.0 | 72728 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll | 16.0.1053.0 | 22064 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll | 16.0.1053.0 | 37424 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll | 16.0.1053.0 | 129072 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.dll | 16.0.1053.0 | 3066408 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll | 16.0.1053.0 | 3955736 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 118320 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 133144 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 137752 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 133656 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 148528 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 134168 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 130584 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 171072 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 115224 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1053.0 | 132136 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll | 16.0.1053.0 | 67608 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll | 16.0.1053.0 | 2682920 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.datawarehouse.utilities.dll | 16.0.1053.0 | 2436648 | 13-Jun-2025 | 14:56 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4205.1 | 84008 | 13-Jun-2025 | 14:56 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4205.1 | 182288 | 13-Jun-2025 | 14:56 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4205.1 | 198664 | 13-Jun-2025 | 14:56 | x64 |
| Mpdwinterop.dll | 2022.160.4205.1 | 296992 | 13-Jun-2025 | 14:56 | x64 |
| Mpdwsvc.exe | 2022.160.4205.1 | 9082944 | 13-Jun-2025 | 14:56 | x64 |
| Secforwarder.dll | 2022.160.4205.1 | 84008 | 13-Jun-2025 | 14:56 | x64 |
| Sharedmemory.dll | 2022.160.1053.0 | 61464 | 13-Jun-2025 | 14:56 | x64 |
| Sqldk.dll | 2022.160.4205.1 | 4024376 | 13-Jun-2025 | 14:56 | x64 |
| Sqldumper.exe | 2022.160.4205.1 | 448552 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 1763360 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4605968 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 3774504 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4605960 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4507688 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 2459688 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 2402312 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4237320 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4216840 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 1697808 | 13-Jun-2025 | 14:56 | x64 |
| Sqlevn70.rll | 2022.160.4205.1 | 4470792 | 13-Jun-2025 | 14:56 | x64 |
| Sqlncli17e.dll | 2017.1710.6.1 | 1898520 | 13-Jun-2025 | 14:56 | x64 |
| Sqlos.dll | 2022.160.4205.1 | 51216 | 13-Jun-2025 | 14:56 | x64 |
| Sqlsortpdw.dll | 2022.160.1053.0 | 4841536 | 13-Jun-2025 | 14:56 | x64 |
| Sqltses.dll | 2022.160.4205.1 | 10668096 | 13-Jun-2025 | 14:56 | x64 |

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
