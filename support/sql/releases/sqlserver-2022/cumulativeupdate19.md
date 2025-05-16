---
title: Cumulative update 19 for SQL Server 2022 (KB5054531)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 19 (KB5054531).
ms.date: 05/15/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5054531
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5054531 - Cumulative Update 19 for SQL Server 2022

_Release Date:_ &nbsp; May 15, 2025  
_Version:_ &nbsp; 16.0.4195.2

## Summary

This article describes Cumulative Update package 19 (CU19) for Microsoft SQL Server 2022. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 18 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4195.2**, file version: **2022.160.4195.2**
- Analysis Services - Product version: **16.0.43.244**, file version: **2022.160.43.244**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area| Component | Platform |
|-------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|---------------------------|----------|
|<a id=3717029>[3717029](#3717029) </a> | Fixes an issue in which the SQL Server Analysis Services (SSAS) service stops responding and the model is damaged when you add too many members (for example, more than 1,820 members) to a database role. | Analysis Services | Analysis Services | Windows|
|<a id=4110180>[4110180](#4110180) </a> | Fixes an issue in which using `BACKUP TO URL` for S3-compatible storage fails because the buffer for the multipart upload response is insufficient due to XML namespace clutter.|	SQL Server Engine | Backup Restore| All|
|<a id=4009999>[4009999](#4009999) </a> | Fixes a Microsoft Entra authentication issue for SQL Server on Linux with IPv6 enabled. The `network.ipv6dnsrecordslimit` `mssql-conf` option is added to limit the number of AAAA records returned by Domain Name System (DNS) to values between 0 and 5 (inclusive). After enabling this option, at least one IPv4 address will be tried to connect to Entra servers. For more information, see [Microsoft Entra ID configuration options](/sql/linux/sql-server-linux-configure-mssql-conf#microsoft-entra-id-configuration-options). | SQL Server Engine | Linux | Linux|
|<a id=4020612>[4020612](#4020612) </a> | Fixes an issue that affects Red Hat Enterprise Linux (RHEL) 9 in which the encrypted connection fails due to an OpenSSL version upgrade.| SQL Server Engine | Linux | Linux|
|<a id=3855044>[3855044](#3855044) </a> | Fixes an assertion failure (Location: op_decod.cpp:9532; Expression: false) that you encounter when running a query with a linked server. | SQL Server Engine | Query Execution | All|
|<a id=2766519>[2766519](#2766519) </a> | Enables trace flag 9135 (`TRCFLG_QP_DONT_USE_INDEXED_VIEWS`) in retail builds to allow the `EXPAND VIEWS` behavior without the per-query hint.| SQL Server Engine | Query Optimizer | All|
|<a id=4013356>[4013356](#4013356) </a> | Fixes an issue in which incorrect results might be returned if using `WINDOW` clauses in conjunction with `CASE` statements.| SQL Server Engine | Query Optimizer | All|
|<a id=4021026>[4021026](#4021026) </a> | Fixes an issue that you encounter when a large number of full-text fragments are marked for deletion by dropping fragments in batches.| SQL Server Engine | Search| All|
|<a id=3402292>[3402292](#3402292) </a> | Fixes an issue in which the server audit created in a contained availability group doesn't work after the SQL Server instance restarts. | SQL Server Engine | Security Infrastructure | All|
|<a id=3873130>[3873130](#3873130) </a> | Fixes non-yielding exceptions that you might encounter when the Service Broker queue becomes very long while sending messages (for example, due to an application not properly closing conversations).| SQL Server Engine | Service Broker| All|
|<a id=4013480>[4013480](#4013480) </a> | Reverts to the 2-GB limit for the minidump file size to avoid dump issues when capturing minidump files on SQL Server instances with a large amount of memory. | SQL Server Engine | SQL OS| Windows|
|<a id=4048867>[4048867](#4048867) </a> | Updates the log tail file name to be constructed according to the dump file name after running the `DBCC STACKDUMP` command.| SQL Server Engine | SQL OS| Windows|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU19 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5054531)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5054531-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5054531-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5054531-x64.exe| 6E58447853AF96373BB838E7E7A0B41237CC8DAC2EBDCB78E13A268BE27B2694 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 18-Apr-2025 | 14:19 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.244 | 336984    | 18-Apr-2025 | 14:19 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.244     | 865296    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.244     | 2903592   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 18-Apr-2025 | 14:19 | x86      |
| Msmdctr.dll                                         | 2022.160.43.244 | 38952     | 18-Apr-2025 | 14:19 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.244 | 53976128  | 18-Apr-2025 | 14:19 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.244 | 71818840  | 18-Apr-2025 | 14:19 | x64      |
| Msmdpump.dll                                        | 2022.160.43.244 | 10333784  | 18-Apr-2025 | 14:19 | x64      |
| Msmdredir.dll                                       | 2022.160.43.244 | 8132648   | 18-Apr-2025 | 14:19 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.244 | 71367240  | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 956992    | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1884704   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1671752   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1881120   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1848376   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1147424   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1140288   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1769512   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1749024   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 932896    | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.244 | 1837600   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 955424    | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1882672   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1668648   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1876496   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1844776   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1145360   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1138776   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1765432   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1745448   | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 933416    | 18-Apr-2025 | 14:19 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.244 | 1833000   | 18-Apr-2025 | 14:19 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.244 | 8265792   | 18-Apr-2025 | 14:19 | x86      |
| Msmgdsrv.dll                                        | 2022.160.43.244 | 10083400  | 18-Apr-2025 | 14:19 | x64      |
| Msolap.dll                                          | 2022.160.43.244 | 8744512   | 18-Apr-2025 | 14:19 | x86      |
| Msolap.dll                                          | 2022.160.43.244 | 10969688  | 18-Apr-2025 | 14:19 | x64      |
| Msolui.dll                                          | 2022.160.43.244 | 289864    | 18-Apr-2025 | 14:19 | x86      |
| Msolui.dll                                          | 2022.160.43.244 | 308240    | 18-Apr-2025 | 14:19 | x64      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 18-Apr-2025 | 14:19 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 18-Apr-2025 | 14:19 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 18-Apr-2025 | 14:19 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 18-Apr-2025 | 14:19 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 18-Apr-2025 | 14:19 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 18-Apr-2025 | 14:19 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |
| Sqlceip.exe                                         | 16.0.4195.2     | 301088    | 18-Apr-2025 | 14:19 | x86      |
| Sqldumper.exe                                       | 2022.160.4195.2 | 382984    | 18-Apr-2025 | 14:19 | x86      |
| Sqldumper.exe                                       | 2022.160.4195.2 | 448552    | 18-Apr-2025 | 14:19 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 18-Apr-2025 | 14:19 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 18-Apr-2025 | 14:19 | x86      |
| Tmapi.dll                                           | 2022.160.43.244 | 5884464   | 18-Apr-2025 | 14:19 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.244 | 5575744   | 18-Apr-2025 | 14:19 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.244 | 1481272   | 18-Apr-2025 | 14:19 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.244 | 7198272   | 18-Apr-2025 | 14:19 | x64      |
| Xmsrv.dll                                           | 2022.160.43.244 | 26593336  | 18-Apr-2025 | 14:19 | x64      |
| Xmsrv.dll                                           | 2022.160.43.244 | 35895888  | 18-Apr-2025 | 14:19 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4195.2 | 104488    | 18-Apr-2025 | 14:19 | x64      |
| Instapi150.dll                             | 2022.160.4195.2 | 79904     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.244     | 2633784   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.244     | 2633744   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.244     | 2933264   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.244     | 2323488   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.244     | 2323472   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4195.2 | 104464    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4195.2 | 92192     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4195.2     | 555024    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4195.2     | 555048    | 18-Apr-2025 | 14:19 | x86      |
| Msasxpress.dll                             | 2022.160.43.244 | 27680     | 18-Apr-2025 | 14:19 | x86      |
| Msasxpress.dll                             | 2022.160.43.244 | 32808     | 18-Apr-2025 | 14:19 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |
| Sqldumper.exe                              | 2022.160.4195.2 | 382984    | 18-Apr-2025 | 14:19 | x86      |
| Sqldumper.exe                              | 2022.160.4195.2 | 448552    | 18-Apr-2025 | 14:19 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4195.2 | 395280    | 18-Apr-2025 | 14:19 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4195.2 | 456728    | 18-Apr-2025 | 14:19 | x64      |
| Sqlsvcsync.dll                             | 2022.160.4195.2 | 280616    | 18-Apr-2025 | 14:19 | x86      |
| Sqlsvcsync.dll                             | 2022.160.4195.2 | 362536    | 18-Apr-2025 | 14:19 | x64      |
| Svrenumapi150.dll                          | 2022.160.4195.2 | 1247248   | 18-Apr-2025 | 14:19 | x64      |
| Svrenumapi150.dll                          | 2022.160.4195.2 | 972840    | 18-Apr-2025 | 14:19 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4195.2     | 309304    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4195.2     | 2070568   | 18-Apr-2025 | 14:19 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |

SQL Server 2022 Data Quality

|           File name           | File version | File size |     Date    |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 16.0.4195.2  | 469024    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4195.2  | 600096    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4195.2  | 600112    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4195.2  | 174096    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4195.2  | 174112    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4195.2  | 1857552   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4195.2  | 1857576   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4195.2  | 370704    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4195.2  | 370712    | 18-Apr-2025 | 14:19 | x86      |
| Dqsinstaller.exe   | 16.0.4195.2     | 2775056   | 18-Apr-2025 | 14:19 | x86      |
| Sql_dq_keyfile.dll | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |

SQL Server 2022 Database Services Core Instance

|                       File name                       |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                              | 3.6.1.64359     | 1618832   | 18-Apr-2025 | 14:27 | x64      |
| Adalsqlrda.dll                                        | 3.6.1.64359     | 1618832   | 18-Apr-2025 | 14:27 | x64      |
| Aetm-enclave-simulator.dll                            | 2022.160.4195.2 | 5993032   | 18-Apr-2025 | 15:12 | x64      |
| Aetm-enclave.dll                                      | 2022.160.4195.2 | 5959680   | 18-Apr-2025 | 15:12 | x64      |
| Aetm-sgx-enclave-simulator.dll                        | 2022.160.4195.2 | 6194840   | 18-Apr-2025 | 15:12 | x64      |
| Aetm-sgx-enclave.dll                                  | 2022.160.4195.2 | 6160680   | 18-Apr-2025 | 15:12 | x64      |
| Databasemail.exe                                      | 16.0.4195.2     | 30752     | 18-Apr-2025 | 15:12 | x64      |
| Databasemailengine.dll                                | 16.0.4195.2     | 79904     | 18-Apr-2025 | 15:12 | x86      |
| Dcexec.exe                                            | 2022.160.4195.2 | 96280     | 18-Apr-2025 | 15:12 | x64      |
| Fssres.dll                                            | 2022.160.4195.2 | 100368    | 18-Apr-2025 | 15:12 | x64      |
| Hadrres.dll                                           | 2022.160.4195.2 | 227368    | 18-Apr-2025 | 15:12 | x64      |
| Hkcompile.dll                                         | 2022.160.4195.2 | 1427512   | 18-Apr-2025 | 15:12 | x64      |
| Hkdllgen.exe                                          | 2022.160.4195.2 | 1570856   | 18-Apr-2025 | 15:12 | x64      |
| Hkengine.dll                                          | 2022.160.4195.2 | 5769272   | 18-Apr-2025 | 15:12 | x64      |
| Hkruntime.dll                                         | 2022.160.4195.2 | 190512    | 18-Apr-2025 | 15:12 | x64      |
| Hktempdb.dll                                          | 2022.160.4195.2 | 71712     | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll          | 16.0.43.244     | 2322472   | 18-Apr-2025 | 14:27 | x86      |
| Microsoft.data.sqlclient.dll                          | 5.13.23292.1    | 2048632   | 18-Apr-2025 | 15:12 | x86      |
| Microsoft.data.sqlclient.sni.dll                      | 5.1.1.0         | 504872    | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.identity.client.dll                         | 4.56.0.0        | 1652320   | 18-Apr-2025 | 15:12 | x86      |
| Microsoft.sqlserver.xe.core.dll                       | 2022.160.4195.2 | 83992     | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll          | 2022.160.4195.2 | 182312    | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.sqlserver.xevent.dll                        | 2022.160.4195.2 | 198672    | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.sqlserver.xevent.linq.dll                   | 2022.160.4195.2 | 333872    | 18-Apr-2025 | 15:12 | x64      |
| Microsoft.sqlserver.xevent.targets.dll                | 2022.160.4195.2 | 96288     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 30736     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 38944     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 34832     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 38952     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 38944     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 30752     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 30776     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 34856     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 38968     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 30736     | 18-Apr-2025 | 15:12 | x64      |
| Odsole70.rll                                          | 16.0.4195.2     | 38944     | 18-Apr-2025 | 15:12 | x64      |
| Qds.dll                                               | 2022.160.4195.2 | 1820704   | 18-Apr-2025 | 15:12 | x64      |
| Rsfxft.dll                                            | 2022.160.4195.2 | 55336     | 18-Apr-2025 | 15:12 | x64      |
| Secforwarder.dll                                      | 2022.160.4195.2 | 83992     | 18-Apr-2025 | 15:12 | x64      |
| Sql_engine_core_inst_keyfile.dll                      | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:27 | x64      |
| Sqlaamss.dll                                          | 2022.160.4195.2 | 120848    | 18-Apr-2025 | 15:12 | x64      |
| Sqlaccess.dll                                         | 2022.160.4195.2 | 444472    | 18-Apr-2025 | 15:12 | x64      |
| Sqlagent.exe                                          | 2022.160.4195.2 | 727088    | 18-Apr-2025 | 15:12 | x64      |
| Sqlagentmail.dll                                      | 2022.160.4195.2 | 75808     | 18-Apr-2025 | 15:12 | x64      |
| Sqlceip.exe                                           | 16.0.4195.2     | 301088    | 18-Apr-2025 | 15:12 | x86      |
| Sqlcmdss.dll                                          | 2022.160.4195.2 | 104464    | 18-Apr-2025 | 15:12 | x64      |
| Sqlctr160.dll                                         | 2022.160.4195.2 | 129040    | 18-Apr-2025 | 15:12 | x86      |
| Sqlctr160.dll                                         | 2022.160.4195.2 | 157728    | 18-Apr-2025 | 15:12 | x64      |
| Sqldk.dll                                             | 2022.160.4195.2 | 4024368   | 18-Apr-2025 | 15:12 | x64      |
| Sqldtsss.dll                                          | 2022.160.4195.2 | 120888    | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 1763376   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3876880   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4093992   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4605984   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4737040   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3774496   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3962936   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4605976   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4433952   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4507680   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 2459656   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 2402352   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4290576   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3926032   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4442144   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4237328   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4216880   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3999792   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 3876896   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 1697808   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4327480   | 18-Apr-2025 | 15:12 | x64      |
| Sqlevn70.rll                                          | 2022.160.4195.2 | 4470800   | 18-Apr-2025 | 15:12 | x64      |
| Sqliosim.com                                          | 2022.160.4195.2 | 395304    | 18-Apr-2025 | 15:12 | x64      |
| Sqliosim.exe                                          | 2022.160.4195.2 | 3069968   | 18-Apr-2025 | 15:12 | x64      |
| Sqllang.dll                                           | 2022.160.4195.2 | 48990248  | 18-Apr-2025 | 15:12 | x64      |
| Sqlmin.dll                                            | 2022.160.4195.2 | 52238376  | 18-Apr-2025 | 15:12 | x64      |
| Sqlolapss.dll                                         | 2022.160.4195.2 | 116776    | 18-Apr-2025 | 15:12 | x64      |
| Sqlos.dll                                             | 2022.160.4195.2 | 51256     | 18-Apr-2025 | 15:12 | x64      |
| Sqlpowershellss.dll                                   | 2022.160.4195.2 | 100384    | 18-Apr-2025 | 15:12 | x64      |
| Sqlrepss.dll                                          | 2022.160.4195.2 | 149544    | 18-Apr-2025 | 15:12 | x64      |
| Sqlscriptdowngrade.dll                                | 2022.160.4195.2 | 51240     | 18-Apr-2025 | 15:12 | x64      |
| Sqlscriptupgrade.dll                                  | 2022.160.4195.2 | 5834816   | 18-Apr-2025 | 15:12 | x64      |
| Sqlservr.exe                                          | 2022.160.4195.2 | 727072    | 18-Apr-2025 | 15:12 | x64      |
| Sqlsvc.dll                                            | 2022.160.4195.2 | 194592    | 18-Apr-2025 | 15:12 | x64      |
| Sqltses.dll                                           | 2022.160.4195.2 | 10668072  | 18-Apr-2025 | 15:12 | x64      |
| Sqsrvres.dll                                          | 2022.160.4195.2 | 305208    | 18-Apr-2025 | 15:12 | x64      |
| Svl.dll                                               | 2022.160.4195.2 | 247848    | 18-Apr-2025 | 15:12 | x64      |
| System.buffers.dll                                    | 4.6.28619.1     | 20856     | 18-Apr-2025 | 15:12 | x86      |
| System.configuration.configurationmanager.dll         | 6.0.922.41905   | 87184     | 18-Apr-2025 | 15:12 | x86      |
| System.memory.dll                                     | 4.6.31308.1     | 142240    | 18-Apr-2025 | 15:12 | x86      |
| System.numerics.vectors.dll                           | 4.6.26515.6     | 115856    | 18-Apr-2025 | 15:12 | x86      |
| System.runtime.compilerservices.unsafe.dll            | 6.0.21.52210    | 18024     | 18-Apr-2025 | 15:12 | x86      |
| System.runtime.interopservices.runtimeinformation.dll | 4.6.24705.1     | 33256     | 18-Apr-2025 | 15:12 | x86      |
| System.text.encodings.web.dll                         | 6.0.21.52210    | 76904     | 18-Apr-2025 | 15:12 | x86      |
| Xe.dll                                                | 2022.160.4195.2 | 718872    | 18-Apr-2025 | 15:12 | x64      |
| Xpqueue.dll                                           | 2022.160.4195.2 | 100368    | 18-Apr-2025 | 15:12 | x64      |
| Xpstar.dll                                            | 2022.160.4195.2 | 534544    | 18-Apr-2025 | 15:12 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 18-Apr-2025 | 14:19 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 18-Apr-2025 | 14:19 | x86      |
| Bcp.exe                                              | 2022.160.4195.2  | 141344    | 18-Apr-2025 | 14:19 | x64      |
| Commanddest.dll                                      | 2022.160.4195.2  | 272416    | 18-Apr-2025 | 14:19 | x64      |
| Datacollectortasks.dll                               | 2022.160.4195.2  | 227360    | 18-Apr-2025 | 14:19 | x64      |
| Distrib.exe                                          | 2022.160.4195.2  | 260136    | 18-Apr-2025 | 14:19 | x64      |
| Dteparse.dll                                         | 2022.160.4195.2  | 133152    | 18-Apr-2025 | 14:19 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4195.2  | 178216    | 18-Apr-2025 | 14:19 | x64      |
| Dtepkg.dll                                           | 2022.160.4195.2  | 153640    | 18-Apr-2025 | 14:19 | x64      |
| Dtexec.exe                                           | 2022.160.4195.2  | 76856     | 18-Apr-2025 | 14:19 | x64      |
| Dts.dll                                              | 2022.160.4195.2  | 3270696   | 18-Apr-2025 | 14:19 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4195.2  | 493584    | 18-Apr-2025 | 14:19 | x64      |
| Dtsconn.dll                                          | 2022.160.4195.2  | 550928    | 18-Apr-2025 | 14:19 | x64      |
| Dtshost.exe                                          | 2022.160.4195.2  | 120360    | 18-Apr-2025 | 14:19 | x64      |
| Dtslog.dll                                           | 2022.160.4195.2  | 137256    | 18-Apr-2025 | 14:19 | x64      |
| Dtspipeline.dll                                      | 2022.160.4195.2  | 1337376   | 18-Apr-2025 | 14:19 | x64      |
| Dtuparse.dll                                         | 2022.160.4195.2  | 104480    | 18-Apr-2025 | 14:19 | x64      |
| Dtutil.exe                                           | 2022.160.4195.2  | 166432    | 18-Apr-2025 | 14:19 | x64      |
| Exceldest.dll                                        | 2022.160.4195.2  | 284688    | 18-Apr-2025 | 14:19 | x64      |
| Excelsrc.dll                                         | 2022.160.4195.2  | 305184    | 18-Apr-2025 | 14:19 | x64      |
| Execpackagetask.dll                                  | 2022.160.4195.2  | 182288    | 18-Apr-2025 | 14:19 | x64      |
| Flatfiledest.dll                                     | 2022.160.4195.2  | 423952    | 18-Apr-2025 | 14:19 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4195.2  | 440360    | 18-Apr-2025 | 14:19 | x64      |
| Logread.exe                                          | 2022.160.4195.2  | 792592    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.244      | 2933792   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4195.2      | 30760     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4195.2      | 391192    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4195.2  | 1718288   | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4195.2      | 555024    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 18-Apr-2025 | 14:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll         | 2022.160.4195.2  | 182312    | 18-Apr-2025 | 14:19 | x64      |
| Microsoft.sqlserver.xevent.dll                       | 2022.160.4195.2  | 198672    | 18-Apr-2025 | 14:19 | x64      |
| Msdtssrvrutil.dll                                    | 2022.160.4195.2  | 124960    | 18-Apr-2025 | 14:19 | x64      |
| Msgprox.dll                                          | 2022.160.4195.2  | 313360    | 18-Apr-2025 | 14:19 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 18-Apr-2025 | 14:19 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 18-Apr-2025 | 14:19 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 18-Apr-2025 | 14:19 | x86      |
| Oledbdest.dll                                        | 2022.160.4195.2  | 288800    | 18-Apr-2025 | 14:19 | x64      |
| Oledbsrc.dll                                         | 2022.160.4195.2  | 317472    | 18-Apr-2025 | 14:19 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4195.2  | 526368    | 18-Apr-2025 | 14:19 | x64      |
| Rawdest.dll                                          | 2022.160.4195.2  | 227344    | 18-Apr-2025 | 14:19 | x64      |
| Rawsource.dll                                        | 2022.160.4195.2  | 215088    | 18-Apr-2025 | 14:19 | x64      |
| Rdistcom.dll                                         | 2022.160.4195.2  | 944144    | 18-Apr-2025 | 14:19 | x64      |
| Recordsetdest.dll                                    | 2022.160.4195.2  | 206856    | 18-Apr-2025 | 14:19 | x64      |
| Repldp.dll                                           | 2022.160.4195.2  | 337968    | 18-Apr-2025 | 14:19 | x64      |
| Replerrx.dll                                         | 2022.160.4195.2  | 198688    | 18-Apr-2025 | 14:19 | x64      |
| Replisapi.dll                                        | 2022.160.4195.2  | 419872    | 18-Apr-2025 | 14:19 | x64      |
| Replmerg.exe                                         | 2022.160.4195.2  | 595984    | 18-Apr-2025 | 14:19 | x64      |
| Replprov.dll                                         | 2022.160.4195.2  | 890896    | 18-Apr-2025 | 14:19 | x64      |
| Replrec.dll                                          | 2022.160.4195.2  | 1058848   | 18-Apr-2025 | 14:19 | x64      |
| Replsub.dll                                          | 2022.160.4195.2  | 501776    | 18-Apr-2025 | 14:19 | x64      |
| Spresolv.dll                                         | 2022.160.4195.2  | 301088    | 18-Apr-2025 | 14:19 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4195.2  | 137224    | 18-Apr-2025 | 14:19 | x64      |
| Sqlcmd.exe                                           | 2022.160.4195.2  | 276512    | 18-Apr-2025 | 14:19 | x64      |
| Sqldiag.exe                                          | 2022.160.4195.2  | 1140768   | 18-Apr-2025 | 14:19 | x64      |
| Sqldistx.dll                                         | 2022.160.4195.2  | 268328    | 18-Apr-2025 | 14:19 | x64      |
| Sqlmergx.dll                                         | 2022.160.4195.2  | 423976    | 18-Apr-2025 | 14:19 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 18-Apr-2025 | 14:19 | x64      |
| Sqlsvc.dll                                           | 2022.160.4195.2  | 194592    | 18-Apr-2025 | 14:19 | x64      |
| Sqlsvc.dll                                           | 2022.160.4195.2  | 153624    | 18-Apr-2025 | 14:19 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4195.2  | 210984    | 18-Apr-2025 | 14:19 | x64      |
| Sqlwep160.dll                                        | 2022.160.4195.2  | 124960    | 18-Apr-2025 | 14:19 | x64      |
| Ssradd.dll                                           | 2022.160.4195.2  | 100368    | 18-Apr-2025 | 14:19 | x64      |
| Ssravg.dll                                           | 2022.160.4195.2  | 100384    | 18-Apr-2025 | 14:19 | x64      |
| Ssrmax.dll                                           | 2022.160.4195.2  | 100392    | 18-Apr-2025 | 14:19 | x64      |
| Ssrmin.dll                                           | 2022.160.4195.2  | 100368    | 18-Apr-2025 | 14:19 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 18-Apr-2025 | 14:19 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 18-Apr-2025 | 14:19 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 18-Apr-2025 | 14:19 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 18-Apr-2025 | 14:19 | x86      |
| Txagg.dll                                            | 2022.160.4195.2  | 395280    | 18-Apr-2025 | 14:19 | x64      |
| Txbdd.dll                                            | 2022.160.4195.2  | 190480    | 18-Apr-2025 | 14:19 | x64      |
| Txdatacollector.dll                                  | 2022.160.4195.2  | 469000    | 18-Apr-2025 | 14:19 | x64      |
| Txdataconvert.dll                                    | 2022.160.4195.2  | 333864    | 18-Apr-2025 | 14:19 | x64      |
| Txderived.dll                                        | 2022.160.4195.2  | 632848    | 18-Apr-2025 | 14:19 | x64      |
| Txlookup.dll                                         | 2022.160.4195.2  | 608288    | 18-Apr-2025 | 14:19 | x64      |
| Txmerge.dll                                          | 2022.160.4195.2  | 243744    | 18-Apr-2025 | 14:19 | x64      |
| Txmergejoin.dll                                      | 2022.160.4195.2  | 301088    | 18-Apr-2025 | 14:19 | x64      |
| Txmulticast.dll                                      | 2022.160.4195.2  | 145424    | 18-Apr-2025 | 14:19 | x64      |
| Txrowcount.dll                                       | 2022.160.4195.2  | 145448    | 18-Apr-2025 | 14:19 | x64      |
| Txsort.dll                                           | 2022.160.4195.2  | 276520    | 18-Apr-2025 | 14:19 | x64      |
| Txsplit.dll                                          | 2022.160.4195.2  | 620560    | 18-Apr-2025 | 14:19 | x64      |
| Txunionall.dll                                       | 2022.160.4195.2  | 194608    | 18-Apr-2025 | 14:19 | x64      |
| Xe.dll                                               | 2022.160.4195.2  | 718872    | 18-Apr-2025 | 14:19 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4195.2 | 100392    | 18-Apr-2025 | 14:19 | x64      |
| Exthost.exe                   | 2022.160.4195.2 | 247864    | 18-Apr-2025 | 14:19 | x64      |
| Launchpad.exe                 | 2022.160.4195.2 | 1452072   | 18-Apr-2025 | 14:19 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |
| Sqlsatellite.dll              | 2022.160.4195.2 | 1255456   | 18-Apr-2025 | 14:19 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4195.2 | 702496    | 18-Apr-2025 | 14:19 | x64      |
| Fdhost.exe               | 2022.160.4195.2 | 157712    | 18-Apr-2025 | 14:19 | x64      |
| Fdlauncher.exe           | 2022.160.4195.2 | 100392    | 18-Apr-2025 | 14:19 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:19 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 18-Apr-2025 | 14:20 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 18-Apr-2025 | 14:20 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 18-Apr-2025 | 14:20 | x86      |
| Commanddest.dll                                               | 2022.160.4195.2 | 231440    | 18-Apr-2025 | 14:20 | x86      |
| Commanddest.dll                                               | 2022.160.4195.2 | 272416    | 18-Apr-2025 | 14:20 | x64      |
| Dteparse.dll                                                  | 2022.160.4195.2 | 116784    | 18-Apr-2025 | 14:20 | x86      |
| Dteparse.dll                                                  | 2022.160.4195.2 | 133152    | 18-Apr-2025 | 14:20 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4195.2 | 165928    | 18-Apr-2025 | 14:20 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4195.2 | 178216    | 18-Apr-2025 | 14:20 | x64      |
| Dtepkg.dll                                                    | 2022.160.4195.2 | 133152    | 18-Apr-2025 | 14:20 | x86      |
| Dtepkg.dll                                                    | 2022.160.4195.2 | 153640    | 18-Apr-2025 | 14:20 | x64      |
| Dtexec.exe                                                    | 2022.160.4195.2 | 65064     | 18-Apr-2025 | 14:20 | x86      |
| Dtexec.exe                                                    | 2022.160.4195.2 | 76856     | 18-Apr-2025 | 14:20 | x64      |
| Dts.dll                                                       | 2022.160.4195.2 | 2861072   | 18-Apr-2025 | 14:20 | x86      |
| Dts.dll                                                       | 2022.160.4195.2 | 3270696   | 18-Apr-2025 | 14:20 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4195.2 | 444472    | 18-Apr-2025 | 14:20 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4195.2 | 493584    | 18-Apr-2025 | 14:20 | x64      |
| Dtsconn.dll                                                   | 2022.160.4195.2 | 464912    | 18-Apr-2025 | 14:20 | x86      |
| Dtsconn.dll                                                   | 2022.160.4195.2 | 550928    | 18-Apr-2025 | 14:20 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4195.2 | 114704    | 18-Apr-2025 | 14:20 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4195.2 | 94760     | 18-Apr-2025 | 14:20 | x86      |
| Dtshost.exe                                                   | 2022.160.4195.2 | 120360    | 18-Apr-2025 | 14:20 | x64      |
| Dtshost.exe                                                   | 2022.160.4195.2 | 98336     | 18-Apr-2025 | 14:20 | x86      |
| Dtslog.dll                                                    | 2022.160.4195.2 | 120872    | 18-Apr-2025 | 14:20 | x86      |
| Dtslog.dll                                                    | 2022.160.4195.2 | 137256    | 18-Apr-2025 | 14:20 | x64      |
| Dtspipeline.dll                                               | 2022.160.4195.2 | 1144848   | 18-Apr-2025 | 14:20 | x86      |
| Dtspipeline.dll                                               | 2022.160.4195.2 | 1337376   | 18-Apr-2025 | 14:20 | x64      |
| Dtuparse.dll                                                  | 2022.160.4195.2 | 104480    | 18-Apr-2025 | 14:20 | x64      |
| Dtuparse.dll                                                  | 2022.160.4195.2 | 88080     | 18-Apr-2025 | 14:20 | x86      |
| Dtutil.exe                                                    | 2022.160.4195.2 | 142352    | 18-Apr-2025 | 14:20 | x86      |
| Dtutil.exe                                                    | 2022.160.4195.2 | 166432    | 18-Apr-2025 | 14:20 | x64      |
| Exceldest.dll                                                 | 2022.160.4195.2 | 247848    | 18-Apr-2025 | 14:20 | x86      |
| Exceldest.dll                                                 | 2022.160.4195.2 | 284688    | 18-Apr-2025 | 14:20 | x64      |
| Excelsrc.dll                                                  | 2022.160.4195.2 | 264200    | 18-Apr-2025 | 14:20 | x86      |
| Excelsrc.dll                                                  | 2022.160.4195.2 | 305184    | 18-Apr-2025 | 14:20 | x64      |
| Execpackagetask.dll                                           | 2022.160.4195.2 | 149536    | 18-Apr-2025 | 14:20 | x86      |
| Execpackagetask.dll                                           | 2022.160.4195.2 | 182288    | 18-Apr-2025 | 14:20 | x64      |
| Flatfiledest.dll                                              | 2022.160.4195.2 | 374816    | 18-Apr-2025 | 14:20 | x86      |
| Flatfiledest.dll                                              | 2022.160.4195.2 | 423952    | 18-Apr-2025 | 14:20 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4195.2 | 391176    | 18-Apr-2025 | 14:20 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4195.2 | 440360    | 18-Apr-2025 | 14:20 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4195.2     | 120840    | 18-Apr-2025 | 14:20 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4195.2     | 120848    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.244     | 2933792   | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.244     | 2933816   | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4195.2     | 509992    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4195.2     | 509984    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4195.2     | 391192    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4195.2 | 170000    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4195.2 | 182312    | 18-Apr-2025 | 14:20 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4195.2 | 178184    | 18-Apr-2025 | 14:20 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4195.2 | 198672    | 18-Apr-2025 | 14:20 | x64      |
| Msdtssrvr.exe                                                 | 16.0.4195.2     | 219176    | 18-Apr-2025 | 14:20 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4195.2 | 100360    | 18-Apr-2025 | 14:20 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4195.2 | 124960    | 18-Apr-2025 | 14:20 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.244 | 10164312  | 18-Apr-2025 | 14:20 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 18-Apr-2025 | 14:20 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 18-Apr-2025 | 14:20 | x86      |
| Odbcdest.dll                                                  | 2022.160.4195.2 | 342056    | 18-Apr-2025 | 14:20 | x86      |
| Odbcdest.dll                                                  | 2022.160.4195.2 | 387096    | 18-Apr-2025 | 14:20 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4195.2 | 350240    | 18-Apr-2025 | 14:20 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4195.2 | 399376    | 18-Apr-2025 | 14:20 | x64      |
| Oledbdest.dll                                                 | 2022.160.4195.2 | 247840    | 18-Apr-2025 | 14:20 | x86      |
| Oledbdest.dll                                                 | 2022.160.4195.2 | 288800    | 18-Apr-2025 | 14:20 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4195.2 | 268328    | 18-Apr-2025 | 14:20 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4195.2 | 317472    | 18-Apr-2025 | 14:20 | x64      |
| Rawdest.dll                                                   | 2022.160.4195.2 | 190472    | 18-Apr-2025 | 14:20 | x86      |
| Rawdest.dll                                                   | 2022.160.4195.2 | 227344    | 18-Apr-2025 | 14:20 | x64      |
| Rawsource.dll                                                 | 2022.160.4195.2 | 186408    | 18-Apr-2025 | 14:20 | x86      |
| Rawsource.dll                                                 | 2022.160.4195.2 | 215088    | 18-Apr-2025 | 14:20 | x64      |
| Recordsetdest.dll                                             | 2022.160.4195.2 | 174112    | 18-Apr-2025 | 14:20 | x86      |
| Recordsetdest.dll                                             | 2022.160.4195.2 | 206856    | 18-Apr-2025 | 14:20 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4195.2 | 137224    | 18-Apr-2025 | 14:20 | x64      |
| Sqlceip.exe                                                   | 16.0.4195.2     | 301088    | 18-Apr-2025 | 14:20 | x86      |
| Sqldest.dll                                                   | 2022.160.4195.2 | 256032    | 18-Apr-2025 | 14:20 | x86      |
| Sqldest.dll                                                   | 2022.160.4195.2 | 288800    | 18-Apr-2025 | 14:20 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4195.2 | 210984    | 18-Apr-2025 | 14:20 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4195.2 | 174096    | 18-Apr-2025 | 14:20 | x86      |
| Txagg.dll                                                     | 2022.160.4195.2 | 346144    | 18-Apr-2025 | 14:20 | x86      |
| Txagg.dll                                                     | 2022.160.4195.2 | 395280    | 18-Apr-2025 | 14:20 | x64      |
| Txbdd.dll                                                     | 2022.160.4195.2 | 149520    | 18-Apr-2025 | 14:20 | x86      |
| Txbdd.dll                                                     | 2022.160.4195.2 | 190480    | 18-Apr-2025 | 14:20 | x64      |
| Txbestmatch.dll                                               | 2022.160.4195.2 | 567320    | 18-Apr-2025 | 14:20 | x86      |
| Txbestmatch.dll                                               | 2022.160.4195.2 | 661544    | 18-Apr-2025 | 14:20 | x64      |
| Txcache.dll                                                   | 2022.160.4195.2 | 170016    | 18-Apr-2025 | 14:20 | x86      |
| Txcache.dll                                                   | 2022.160.4195.2 | 202768    | 18-Apr-2025 | 14:20 | x64      |
| Txcharmap.dll                                                 | 2022.160.4195.2 | 280616    | 18-Apr-2025 | 14:20 | x86      |
| Txcharmap.dll                                                 | 2022.160.4195.2 | 325672    | 18-Apr-2025 | 14:20 | x64      |
| Txcopymap.dll                                                 | 2022.160.4195.2 | 165928    | 18-Apr-2025 | 14:20 | x86      |
| Txcopymap.dll                                                 | 2022.160.4195.2 | 202768    | 18-Apr-2025 | 14:20 | x64      |
| Txdataconvert.dll                                             | 2022.160.4195.2 | 288784    | 18-Apr-2025 | 14:20 | x86      |
| Txdataconvert.dll                                             | 2022.160.4195.2 | 333864    | 18-Apr-2025 | 14:20 | x64      |
| Txderived.dll                                                 | 2022.160.4195.2 | 559160    | 18-Apr-2025 | 14:20 | x86      |
| Txderived.dll                                                 | 2022.160.4195.2 | 632848    | 18-Apr-2025 | 14:20 | x64      |
| Txfileextractor.dll                                           | 2022.160.4195.2 | 186384    | 18-Apr-2025 | 14:20 | x86      |
| Txfileextractor.dll                                           | 2022.160.4195.2 | 219168    | 18-Apr-2025 | 14:20 | x64      |
| Txfileinserter.dll                                            | 2022.160.4195.2 | 186384    | 18-Apr-2025 | 14:20 | x86      |
| Txfileinserter.dll                                            | 2022.160.4195.2 | 219144    | 18-Apr-2025 | 14:20 | x64      |
| Txgroupdups.dll                                               | 2022.160.4195.2 | 354344    | 18-Apr-2025 | 14:20 | x86      |
| Txgroupdups.dll                                               | 2022.160.4195.2 | 403488    | 18-Apr-2025 | 14:20 | x64      |
| Txlineage.dll                                                 | 2022.160.4195.2 | 129064    | 18-Apr-2025 | 14:20 | x86      |
| Txlineage.dll                                                 | 2022.160.4195.2 | 157736    | 18-Apr-2025 | 14:20 | x64      |
| Txlookup.dll                                                  | 2022.160.4195.2 | 522272    | 18-Apr-2025 | 14:20 | x86      |
| Txlookup.dll                                                  | 2022.160.4195.2 | 608288    | 18-Apr-2025 | 14:20 | x64      |
| Txmerge.dll                                                   | 2022.160.4195.2 | 194600    | 18-Apr-2025 | 14:20 | x86      |
| Txmerge.dll                                                   | 2022.160.4195.2 | 243744    | 18-Apr-2025 | 14:20 | x64      |
| Txmergejoin.dll                                               | 2022.160.4195.2 | 256008    | 18-Apr-2025 | 14:20 | x86      |
| Txmergejoin.dll                                               | 2022.160.4195.2 | 301088    | 18-Apr-2025 | 14:20 | x64      |
| Txmulticast.dll                                               | 2022.160.4195.2 | 116768    | 18-Apr-2025 | 14:20 | x86      |
| Txmulticast.dll                                               | 2022.160.4195.2 | 145424    | 18-Apr-2025 | 14:20 | x64      |
| Txpivot.dll                                                   | 2022.160.4195.2 | 198672    | 18-Apr-2025 | 14:20 | x86      |
| Txpivot.dll                                                   | 2022.160.4195.2 | 239632    | 18-Apr-2025 | 14:20 | x64      |
| Txrowcount.dll                                                | 2022.160.4195.2 | 116792    | 18-Apr-2025 | 14:20 | x86      |
| Txrowcount.dll                                                | 2022.160.4195.2 | 145448    | 18-Apr-2025 | 14:20 | x64      |
| Txsampling.dll                                                | 2022.160.4195.2 | 153632    | 18-Apr-2025 | 14:20 | x86      |
| Txsampling.dll                                                | 2022.160.4195.2 | 186416    | 18-Apr-2025 | 14:20 | x64      |
| Txscd.dll                                                     | 2022.160.4195.2 | 198688    | 18-Apr-2025 | 14:20 | x86      |
| Txscd.dll                                                     | 2022.160.4195.2 | 235536    | 18-Apr-2025 | 14:20 | x64      |
| Txsort.dll                                                    | 2022.160.4195.2 | 231448    | 18-Apr-2025 | 14:20 | x86      |
| Txsort.dll                                                    | 2022.160.4195.2 | 276520    | 18-Apr-2025 | 14:20 | x64      |
| Txsplit.dll                                                   | 2022.160.4195.2 | 550944    | 18-Apr-2025 | 14:20 | x86      |
| Txsplit.dll                                                   | 2022.160.4195.2 | 620560    | 18-Apr-2025 | 14:20 | x64      |
| Txtermextraction.dll                                          | 2022.160.4195.2 | 8648744   | 18-Apr-2025 | 14:20 | x86      |
| Txtermextraction.dll                                          | 2022.160.4195.2 | 8702008   | 18-Apr-2025 | 14:20 | x64      |
| Txtermlookup.dll                                              | 2022.160.4195.2 | 4139040   | 18-Apr-2025 | 14:20 | x86      |
| Txtermlookup.dll                                              | 2022.160.4195.2 | 4184104   | 18-Apr-2025 | 14:20 | x64      |
| Txunionall.dll                                                | 2022.160.4195.2 | 153616    | 18-Apr-2025 | 14:20 | x86      |
| Txunionall.dll                                                | 2022.160.4195.2 | 194608    | 18-Apr-2025 | 14:20 | x64      |
| Txunpivot.dll                                                 | 2022.160.4195.2 | 178192    | 18-Apr-2025 | 14:20 | x86      |
| Txunpivot.dll                                                 | 2022.160.4195.2 | 215056    | 18-Apr-2025 | 14:20 | x64      |
| Xe.dll                                                        | 2022.160.4195.2 | 641040    | 18-Apr-2025 | 14:20 | x86      |
| Xe.dll                                                        | 2022.160.4195.2 | 718872    | 18-Apr-2025 | 14:20 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1046.0     | 559680    | 18-Apr-2025 | 14:53 | x86      |
| Dmsnative.dll                                                        | 2022.160.1046.0 | 152640    | 18-Apr-2025 | 14:53 | x64      |
| Dwengineservice.dll                                                  | 16.0.1046.0     | 45112     | 18-Apr-2025 | 14:53 | x86      |
| Instapi150.dll                                                       | 2022.160.4195.2 | 104488    | 18-Apr-2025 | 14:53 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1046.0     | 67640     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1046.0     | 293456    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1046.0     | 1958472   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1046.0     | 169520    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1046.0     | 647224    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1046.0     | 246368    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1046.0     | 139344    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1046.0     | 79968     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1046.0     | 51248     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1046.0     | 88656     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1046.0     | 1129528   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1046.0     | 80992     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1046.0     | 70736     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1046.0     | 35376     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1046.0     | 30784     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1046.0     | 46672     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1046.0     | 21552     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1046.0     | 26672     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1046.0     | 131664    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1046.0     | 86624     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1046.0     | 100960    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1046.0     | 293432    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 120376    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 138296    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 141384    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 137776    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 150592    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 139832    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 134712    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 176688    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 117816    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 136768    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1046.0     | 72784     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1046.0     | 22064     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1046.0     | 37432     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1046.0     | 129072    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1046.0     | 3064912   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1046.0     | 3955784   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 118336    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133184    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 137776    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133680    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 148528    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 134192    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 130624    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 171064    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 115256    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 132152    | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1046.0     | 67664     | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1046.0     | 2682936   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1046.0     | 2436664   | 18-Apr-2025 | 14:53 | x86      |
| Microsoft.sqlserver.xe.core.dll                                      | 2022.160.4195.2 | 83992     | 18-Apr-2025 | 14:53 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                         | 2022.160.4195.2 | 182312    | 18-Apr-2025 | 14:53 | x64      |
| Microsoft.sqlserver.xevent.dll                                       | 2022.160.4195.2 | 198672    | 18-Apr-2025 | 14:53 | x64      |
| Mpdwinterop.dll                                                      | 2022.160.4195.2 | 296992    | 18-Apr-2025 | 14:53 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4195.2 | 9082952   | 18-Apr-2025 | 14:53 | x64      |
| Secforwarder.dll                                                     | 2022.160.4195.2 | 83992     | 18-Apr-2025 | 14:53 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1046.0 | 61504     | 18-Apr-2025 | 14:53 | x64      |
| Sqldk.dll                                                            | 2022.160.4195.2 | 4024368   | 18-Apr-2025 | 14:53 | x64      |
| Sqldumper.exe                                                        | 2022.160.4195.2 | 448552    | 18-Apr-2025 | 14:53 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 1763376   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4605984   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 3774496   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4605976   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4507680   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 2459656   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 2402352   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4237328   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4216880   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 1697808   | 18-Apr-2025 | 14:52 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4195.2 | 4470800   | 18-Apr-2025 | 14:52 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 18-Apr-2025 | 14:53 | x64      |
| Sqlos.dll                                                            | 2022.160.4195.2 | 51256     | 18-Apr-2025 | 14:53 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1046.0 | 4841520   | 18-Apr-2025 | 14:53 | x64      |
| Sqltses.dll                                                          | 2022.160.4195.2 | 10668072  | 18-Apr-2025 | 14:53 | x64      |

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
