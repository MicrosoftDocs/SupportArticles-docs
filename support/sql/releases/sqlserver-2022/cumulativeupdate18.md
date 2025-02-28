---
title: Cumulative update 18 for SQL Server 2022 (KB5050771)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 18 (KB5050771).
ms.date: 03/13/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5050771
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5050771 - Cumulative Update 18 for SQL Server 2022

_Release Date:_ &nbsp; March 13, 2025  
_Version:_ &nbsp; 16.0.4185.2

## Summary

This article describes Cumulative Update package 18 (CU18) for Microsoft SQL Server 2022. This update contains 10 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 17 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4185.2**, file version: **2022.160.4185.2**
- Analysis Services - Product version: **16.0.43.242**, file version: **2022.160.43.242**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component | Platform |
|------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------------------------------------|----------|
| <a id=2998962>[2998962](#2998962) </a> | Fixes an issue in which a copy-only filegroup backup on an availability group secondary replica fails with the following errors: </br></br>Msg 3059, Level 16, State 1, Line \<LineNumber> </br>This BACKUP or RESTORE command is not supported on a database mirror or secondary replica. </br>Msg 3013, Level 16, State 1, Line \<LineNumber> </br>BACKUP DATABASE is terminating abnormally.| SQL Server Engine | Backup Restore| Windows|
| <a id=3726420>[3726420](#3726420) </a> | Makes the contained availability group (AG) available to use resource governor workload group that's defined at the instance level. For more information, see [Resource governor](/sql/database-engine/availability-groups/windows/contained-availability-groups-overview#resource-governor).| SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=3867855>[3867855](#3867855) </a> | Fixes an issue in which a self-signed certificate created for SQL Server on Linux might include a negative serial number.| SQL Server Engine | Linux | Linux|
| <a id=3791615>[3791615](#3791615) </a> | Fixes an issue in Database Mail in which the information logged into the `sysmail_log` system table and `sysmail_event_log` view in the **msdb** database might be stored and displayed as "???" (for example, when querying objects in SSMS). This issue might happen when the reported message (typically an error condition) contains non-ASCII characters and is more common on localized versions of SQL Server (for example, Japanese), not specific to the language of the SQL Server instance or its collation.| SQL Server Engine | Management Services | All|
| <a id=3848607>[3848607](#3848607) </a> | Fixes an issue in which the `sys.computed_columns` view doesn't show the proper definition when using external tables with file metadata columns.| SQL Server Engine | Metadata| Windows|
| <a id=3802029>[3802029](#3802029) </a> | Fixes an issue in which the manual change tracking cleanup stored procedure incorrectly sets the invalid cleanup version to negative when the `TableName` parameter isn't passed.| SQL Server Engine | Replication | All|
| <a id=3821559>[3821559](#3821559) </a> | Fixes an issue in which the second article might not have updates correctly replicated if accelerated database recovery (ADR) is enabled on the database using replication with two articles for a single table. | SQL Server Engine | Replication | Windows|
| <a id=3902839>[3902839](#3902839) </a> | Fixes incorrect results that you encounter when you create a full-text index for a `.docx` file that contains a hyperlink at the start of a paragraph but without a trailing whitespace at the end of the previous paragraph, which causes the full-text search to fail to correctly index the contents of the hyperlink. <br/><br/>**Note**: You need to turn on trace flag 7686. | SQL Server Engine | Search | All|
| <a id=3549792>[3549792](#3549792) </a> | Fixes an error that you encounter when the 'Erase Phantom System Health Records' step in the SQL Server Agent job `syspolicy_purge_history` tries to connect to other instances and the account running the service doesn't have permission to connect. The following error occurs in the SQL Server error log: <br/><br/>\<DateTime> Logon Error: 18456, Severity: 14, State: 5. <br/>\<DateTime> Logon Login failed for user '\<UserName>'. Reason: Could not find a login matching the name provided. [CLIENT: \<IP address>] | SQL Server Engine | SQL Agent | All|
| <a id=3800647>[3800647](#3800647) </a> | Data Quality Services (DQS) is only supported in SQL Server Enterprise and Developer editions. Before the fix, the operation is completed successfully when you try to install DQS in the Standard or Web edition. Moreover, this DQS will automatically be selected for installation when setting up a Windows Server Failover Cluster. Once installed, this DQS can't be configured. After applying this fix, SQL Server Setup won't allow DQS to be installed in SQL Server Standard or Web edition. </br></br>Note: This fix applies to new installations only. For more information, see [Installing Updates from the Command Prompt](/sql/database-engine/install-windows/installing-updates-from-the-command-prompt). | SQL Setup | Patching| Windows|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU18 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5050771)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5050771-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5050771-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5050771-x64.exe| B7BD13D01D3094AA2568B44DC9562C5D55FC29A0B4D79CED5B51A68D7F04B039 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Anglesharp.dll | 0.9.9.0 | 1240112 | 26-Feb-2025 | 15:56 | x86 |
| Asplatformhost.dll | 2022.160.43.242 | 336952 | 26-Feb-2025 | 15:53 | x64 |
| Mashupcompression.dll | 2.127.602.0 | 141760 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.analysisservices.minterop.dll | 16.0.43.242 | 865336 | 26-Feb-2025 | 15:53 | x86 |
| Microsoft.analysisservices.server.core.dll | 16.0.43.242 | 2903640 | 26-Feb-2025 | 15:53 | x86 |
| Microsoft.data.edm.netfx35.dll | 5.7.0.62516 | 661936 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.dll | 2.127.602.0 | 224184 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.oledb.dll | 2.127.602.0 | 32192 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.preview.dll | 2.127.602.0 | 153528 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.dll | 2.127.602.0 | 113088 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 33216 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47040 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42928 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 47024 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 38832 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.127.602.0 | 42944 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.mashup.sqlclient.dll | 2.127.602.0 | 25536 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.odata.netfx35.dll | 5.7.0.62516 | 1455536 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.odata.query.netfx35.dll | 5.7.0.62516 | 182200 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.dll | 1.0.0.25 | 931680 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 35200 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 36704 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 37216 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 49024 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 36704 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 39808 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sqlclient.dll | 2.17.23292.1 | 1997744 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sqlclient.sni.dll | 2.1.1.0 | 511920 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.dataintegration.fuzzyclustering.dll | 1.0.0.0 | 40368 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.dataintegration.fuzzymatching.dll | 1.0.0.0 | 628144 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.dataintegration.fuzzymatchingcommon.dll | 1.0.0.0 | 390064 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.exchange.webservices.dll | 15.0.913.15 | 1124272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.hostintegration.connectors.dll | 2.127.602.0 | 4964800 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identity.client.dll | 4.57.0.0 | 1653680 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.35.0.41201 | 111536 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.logging.dll | 6.35.0.41201 | 38320 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.35.0.41201 | 39856 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201 | 114096 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.35.0.41201 | 992192 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.cdm.icdmprovider.dll | 2.127.602.0 | 21952 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.container.exe | 2.127.602.0 | 25024 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.mashup.container.netfx40.exe | 2.127.602.0 | 24000 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.mashup.container.netfx45.exe | 2.127.602.0 | 23992 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.mashup.eventsource.dll | 2.127.602.0 | 150448 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.dll | 2.127.602.0 | 94144 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15808 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16320 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16312 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16816 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 17344 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 15792 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.127.602.0 | 16304 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbinterop.dll | 2.127.602.0 | 201144 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.mashup.oledbprovider.dll | 2.127.602.0 | 67008 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14264 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.127.602.0 | 14256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.sapbwprovider.dll | 2.127.602.0 | 334256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.scriptdom.dll | 2.40.4554.261 | 2365872 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.shims.dll | 2.127.602.0 | 29616 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0 | 141248 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.dll | 2.127.602.0 | 15941040 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.dll | 2.127.602.0 | 7617472 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39360 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 47024 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 35872 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 36288 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39856 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 39872 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40368 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 40888 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.library45.resources.dll | 2.127.602.0 | 42424 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 620464 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 747448 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 739248 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 718776 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 776128 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 726960 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 702384 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 980912 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 612272 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mashupengine.resources.dll | 2.127.602.0 | 714672 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.mshtml.dll | 7.0.3300.1 | 8017840 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.odata.core.netfx35.dll | 6.15.0.0 | 1438656 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.odata.core.netfx35.v7.dll | 7.4.0.11102 | 1262000 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.odata.edm.netfx35.dll | 6.15.0.0 | 779712 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.odata.edm.netfx35.v7.dll | 7.4.0.11102 | 745920 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.powerbi.adomdclient.dll | 16.0.122.20 | 1216944 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.spatial.netfx35.dll | 6.15.0.0 | 127408 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.spatial.netfx35.v7.dll | 7.4.0.11102 | 125368 | 26-Feb-2025 | 15:56 | x86 |
| Msmdctr.dll | 2022.160.43.242 | 38984 | 26-Feb-2025 | 15:53 | x64 |
| Msmdlocal.dll | 2022.160.43.242 | 53976128 | 26-Feb-2025 | 15:53 | x86 |
| Msmdlocal.dll | 2022.160.43.242 | 71818840 | 26-Feb-2025 | 15:53 | x64 |
| Msmdpump.dll | 2022.160.43.242 | 10333744 | 26-Feb-2025 | 15:53 | x64 |
| Msmdredir.dll | 2022.160.43.242 | 8132696 | 26-Feb-2025 | 15:53 | x86 |
| Msmdsrv.exe | 2022.160.43.242 | 71362624 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 956992 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1884720 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1671752 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1881136 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1848376 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1147440 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1140296 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1769544 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1749080 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 932928 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrv.rll | 2022.160.43.242 | 1837616 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 955440 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1882712 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1668656 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1876560 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1844784 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1145432 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1138736 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1765424 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1745480 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 933424 | 26-Feb-2025 | 15:53 | x64 |
| Msmdsrvi.rll | 2022.160.43.242 | 1833008 | 26-Feb-2025 | 15:53 | x64 |
| Msmgdsrv.dll | 2022.160.43.242 | 10083400 | 26-Feb-2025 | 15:53 | x64 |
| Msmgdsrv.dll | 2022.160.43.242 | 8265800 | 26-Feb-2025 | 15:53 | x86 |
| Msolap.dll | 2022.160.43.242 | 10969664 | 26-Feb-2025 | 15:53 | x64 |
| Msolap.dll | 2022.160.43.242 | 8744520 | 26-Feb-2025 | 15:53 | x86 |
| Msolui.dll | 2022.160.43.242 | 289840 | 26-Feb-2025 | 15:53 | x86 |
| Msolui.dll | 2022.160.43.242 | 308272 | 26-Feb-2025 | 15:53 | x64 |
| Newtonsoft.json.dll | 13.0.3.27908 | 722264 | 26-Feb-2025 | 15:56 | x86 |
| Parquetsharp.dll | 0.0.0.0 | 412592 | 26-Feb-2025 | 15:56 | x64 |
| Parquetsharpnative.dll | 7.0.0.17 | 20091320 | 26-Feb-2025 | 15:56 | x64 |
| Powerbiextensions.dll | 2.127.602.0 | 11111344 | 26-Feb-2025 | 15:56 | x86 |
| Private_odbc32.dll | 10.0.19041.1 | 735288 | 26-Feb-2025 | 15:56 | x64 |
| Sni.dll | 1.1.1.0 | 555424 | 26-Feb-2025 | 15:56 | x64 |
| Sql_as_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:53 | x64 |
| Sqlceip.exe | 16.0.4185.2 | 301136 | 26-Feb-2025 | 15:56 | x86 |
| Sqldumper.exe | 2022.160.4185.2 | 378912 | 26-Feb-2025 | 15:56 | x86 |
| Sqldumper.exe | 2022.160.4185.2 | 448528 | 26-Feb-2025 | 15:56 | x64 |
| System.identitymodel.tokens.jwt.dll | 6.35.0.41201 | 77248 | 26-Feb-2025 | 15:56 | x86 |
| System.spatial.netfx35.dll | 5.7.0.62516 | 118704 | 26-Feb-2025 | 15:56 | x86 |
| Tmapi.dll | 2022.160.43.242 | 5884464 | 26-Feb-2025 | 15:53 | x64 |
| Tmcachemgr.dll | 2022.160.43.242 | 5575256 | 26-Feb-2025 | 15:53 | x64 |
| Tmpersistence.dll | 2022.160.43.242 | 1481280 | 26-Feb-2025 | 15:53 | x64 |
| Tmtransactions.dll | 2022.160.43.242 | 7198256 | 26-Feb-2025 | 15:53 | x64 |
| Xmsrv.dll | 2022.160.43.242 | 26593328 | 26-Feb-2025 | 15:53 | x64 |
| Xmsrv.dll | 2022.160.43.242 | 35895856 | 26-Feb-2025 | 15:53 | x86 |

SQL Server 2022 Database Services Common Core

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Instapi150.dll | 2022.160.4185.2 | 104480 | 26-Feb-2025 | 15:56 | x64 |
| Instapi150.dll | 2022.160.4185.2 | 79952 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.242 | 2633776 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.242 | 2633816 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.core.dll | 16.0.43.242 | 2933336 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.242 | 2323504 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.xmla.dll | 16.0.43.242 | 2323528 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4185.2 | 104528 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2022.160.4185.2 | 92224 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.rmo.dll | 16.0.4185.2 | 555048 | 26-Feb-2025 | 15:56 | x86 |
| Msasxpress.dll | 2022.160.43.242 | 27720 | 26-Feb-2025 | 15:56 | x86 |
| Msasxpress.dll | 2022.160.43.242 | 32840 | 26-Feb-2025 | 15:56 | x64 |
| Sql_common_core_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |
| Sqldumper.exe | 2022.160.4185.2 | 378912 | 26-Feb-2025 | 15:56 | x86 |
| Sqldumper.exe | 2022.160.4185.2 | 448528 | 26-Feb-2025 | 15:56 | x64 |
| Sqlmgmprovider.dll | 2022.160.4185.2 | 395304 | 26-Feb-2025 | 15:56 | x86 |
| Sqlmgmprovider.dll | 2022.160.4185.2 | 456776 | 26-Feb-2025 | 15:56 | x64 |
| Sqlsvcsync.dll | 2022.160.4185.2 | 280616 | 26-Feb-2025 | 15:56 | x86 |
| Sqlsvcsync.dll | 2022.160.4185.2 | 362576 | 26-Feb-2025 | 15:56 | x64 |
| Svrenumapi150.dll | 2022.160.4185.2 | 1247288 | 26-Feb-2025 | 15:56 | x64 |
| Svrenumapi150.dll | 2022.160.4185.2 | 976952 | 26-Feb-2025 | 15:56 | x86 |

SQL Server 2022 Data Quality Client

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.studio.infra.dll | 16.0.4185.2 | 309280 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.studio.views.dll | 16.0.4185.2 | 2070600 | 26-Feb-2025 | 15:56 | x86 |
| Sql_dqc_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:53 | x64 |

SQL Server 2022 Data Quality

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.cleansing.dll | 16.0.4185.2 | 469032 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.cleansing.dll | 16.0.4185.2 | 469056 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4185.2 | 600104 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.core.dll | 16.0.4185.2 | 600128 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.dll | 16.0.4185.2 | 174104 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.dll | 16.0.4185.2 | 174112 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.infra.dll | 16.0.4185.2 | 1857576 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.infra.dll | 16.0.4185.2 | 1857592 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4185.2 | 370720 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.ssdqs.proxy.dll | 16.0.4185.2 | 370744 | 26-Feb-2025 | 15:56 | x86 |
| Dqsinstaller.exe | 16.0.4185.2 | 2775112 | 26-Feb-2025 | 15:56 | x86 |
| Sql_dq_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |

SQL Server 2022 Database Services Core Instance

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Adal.dll | 3.6.1.64359 | 1618832 | 26-Feb-2025 | 16:46 | x64 |
| Adalsqlrda.dll | 3.6.1.64359 | 1618832 | 26-Feb-2025 | 16:46 | x64 |
| Aetm-enclave-simulator.dll | 2022.160.4185.2 | 5993040 | 26-Feb-2025 | 16:46 | x64 |
| Aetm-enclave.dll | 2022.160.4185.2 | 5959712 | 26-Feb-2025 | 16:46 | x64 |
| Aetm-sgx-enclave-simulator.dll | 2022.160.4185.2 | 6194816 | 26-Feb-2025 | 16:46 | x64 |
| Aetm-sgx-enclave.dll | 2022.160.4185.2 | 6160704 | 26-Feb-2025 | 16:46 | x64 |
| Databasemail.exe | 16.0.4185.2 | 30768 | 26-Feb-2025 | 16:46 | x64 |
| Databasemailengine.dll | 16.0.4185.2 | 79928 | 26-Feb-2025 | 16:46 | x86 |
| Dcexec.exe | 2022.160.4185.2 | 96336 | 26-Feb-2025 | 16:46 | x64 |
| Fssres.dll | 2022.160.4185.2 | 100368 | 26-Feb-2025 | 16:46 | x64 |
| Hadrres.dll | 2022.160.4185.2 | 227400 | 26-Feb-2025 | 16:46 | x64 |
| Hkcompile.dll | 2022.160.4185.2 | 1427520 | 26-Feb-2025 | 16:46 | x64 |
| Hkdllgen.exe | 2022.160.4185.2 | 1570896 | 26-Feb-2025 | 16:46 | x64 |
| Hkengine.dll | 2022.160.4185.2 | 5769288 | 26-Feb-2025 | 16:46 | x64 |
| Hkruntime.dll | 2022.160.4185.2 | 190544 | 26-Feb-2025 | 16:46 | x64 |
| Hktempdb.dll | 2022.160.4185.2 | 71744 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.242 | 2322480 | 26-Feb-2025 | 16:46 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 26-Feb-2025 | 16:46 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 26-Feb-2025 | 16:46 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4185.2 | 84040 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4185.2 | 182336 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.sqlserver.xevent.linq.dll | 2022.160.4185.2 | 333904 | 26-Feb-2025 | 16:46 | x64 |
| Microsoft.sqlserver.xevent.targets.dll | 2022.160.4185.2 | 96336 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 30760 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 38952 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 34856 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 38968 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 38952 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 30728 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 30784 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 34896 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 38952 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 30760 | 26-Feb-2025 | 16:46 | x64 |
| Odsole70.rll | 16.0.4185.2 | 38944 | 26-Feb-2025 | 16:46 | x64 |
| Qds.dll | 2022.160.4185.2 | 1812520 | 26-Feb-2025 | 16:46 | x64 |
| Rsfxft.dll | 2022.160.4185.2 | 55336 | 26-Feb-2025 | 16:46 | x64 |
| Secforwarder.dll | 2022.160.4185.2 | 84048 | 26-Feb-2025 | 16:46 | x64 |
| Sql_engine_core_inst_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 16:46 | x64 |
| Sqlaamss.dll | 2022.160.4185.2 | 120912 | 26-Feb-2025 | 16:46 | x64 |
| Sqlaccess.dll | 2022.160.4185.2 | 444496 | 26-Feb-2025 | 16:46 | x64 |
| Sqlagent.exe | 2022.160.4185.2 | 722976 | 26-Feb-2025 | 16:46 | x64 |
| Sqlagentmail.dll | 2022.160.4185.2 | 75848 | 26-Feb-2025 | 16:46 | x64 |
| Sqlceip.exe | 16.0.4185.2 | 301136 | 26-Feb-2025 | 16:46 | x86 |
| Sqlcmdss.dll | 2022.160.4185.2 | 104520 | 26-Feb-2025 | 16:46 | x64 |
| Sqlctr160.dll | 2022.160.4185.2 | 157752 | 26-Feb-2025 | 16:46 | x64 |
| Sqlctr160.dll | 2022.160.4185.2 | 129064 | 26-Feb-2025 | 16:46 | x86 |
| Sqldk.dll | 2022.160.4185.2 | 4024392 | 26-Feb-2025 | 16:46 | x64 |
| Sqldtsss.dll | 2022.160.4185.2 | 120880 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 1759312 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3876872 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4094032 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4606016 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4737064 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3774544 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3962952 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4606016 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4434000 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4507688 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 2459704 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 2402368 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4290640 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3926056 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4442168 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4237352 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4216904 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3999800 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3876920 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 1697856 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4327496 | 26-Feb-2025 | 16:46 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4470848 | 26-Feb-2025 | 16:46 | x64 |
| Sqliosim.com | 2022.160.4185.2 | 395304 | 26-Feb-2025 | 16:46 | x64 |
| Sqliosim.exe | 2022.160.4185.2 | 3070032 | 26-Feb-2025 | 16:46 | x64 |
| Sqllang.dll | 2022.160.4185.2 | 48969808 | 26-Feb-2025 | 16:46 | x64 |
| Sqlmin.dll | 2022.160.4185.2 | 52238376 | 26-Feb-2025 | 16:46 | x64 |
| Sqlolapss.dll | 2022.160.4185.2 | 116792 | 26-Feb-2025 | 16:46 | x64 |
| Sqlos.dll | 2022.160.4185.2 | 51240 | 26-Feb-2025 | 16:46 | x64 |
| Sqlpowershellss.dll | 2022.160.4185.2 | 100408 | 26-Feb-2025 | 16:46 | x64 |
| Sqlrepss.dll | 2022.160.4185.2 | 149560 | 26-Feb-2025 | 16:46 | x64 |
| Sqlscriptdowngrade.dll | 2022.160.4185.2 | 51280 | 26-Feb-2025 | 16:46 | x64 |
| Sqlscriptupgrade.dll | 2022.160.4185.2 | 5834816 | 26-Feb-2025 | 16:46 | x64 |
| Sqlservr.exe | 2022.160.4185.2 | 727096 | 26-Feb-2025 | 16:46 | x64 |
| Sqlsvc.dll | 2022.160.4185.2 | 194632 | 26-Feb-2025 | 16:46 | x64 |
| Sqltses.dll | 2022.160.4185.2 | 10668088 | 26-Feb-2025 | 16:46 | x64 |
| Sqsrvres.dll | 2022.160.4185.2 | 305160 | 26-Feb-2025 | 16:46 | x64 |
| Svl.dll | 2022.160.4185.2 | 247864 | 26-Feb-2025 | 16:46 | x64 |
| System.buffers.dll | 4.6.28619.1 | 20856 | 26-Feb-2025 | 16:46 | x86 |
| System.configuration.configurationmanager.dll | 6.0.922.41905 | 87184 | 26-Feb-2025 | 16:46 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 26-Feb-2025 | 16:46 | x86 |
| System.numerics.vectors.dll | 4.6.26515.6 | 115856 | 26-Feb-2025 | 16:46 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 26-Feb-2025 | 16:46 | x86 |
| System.runtime.interopservices.runtimeinformation.dll | 4.6.24705.1 | 33256 | 26-Feb-2025 | 16:46 | x86 |
| System.text.encodings.web.dll | 6.0.21.52210 | 76904 | 26-Feb-2025 | 16:46 | x86 |
| Xe.dll | 2022.160.4185.2 | 718896 | 26-Feb-2025 | 16:46 | x64 |
| Xpqueue.dll | 2022.160.4185.2 | 100360 | 26-Feb-2025 | 16:46 | x64 |
| Xpstar.dll | 2022.160.4185.2 | 534568 | 26-Feb-2025 | 16:46 | x64 |

SQL Server 2022 Database Services Core Shared

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Azure.core.dll | 1.3600.23.56006 | 384432 | 26-Feb-2025 | 15:56 | x86 |
| Azure.identity.dll | 1.1000.423.56303 | 334768 | 26-Feb-2025 | 15:56 | x86 |
| Bcp.exe | 2022.160.4185.2 | 141368 | 26-Feb-2025 | 15:56 | x64 |
| Commanddest.dll | 2022.160.4185.2 | 272440 | 26-Feb-2025 | 15:56 | x64 |
| Datacollectortasks.dll | 2022.160.4185.2 | 227384 | 26-Feb-2025 | 15:56 | x64 |
| Distrib.exe | 2022.160.4185.2 | 260176 | 26-Feb-2025 | 15:56 | x64 |
| Dteparse.dll | 2022.160.4185.2 | 133176 | 26-Feb-2025 | 15:56 | x64 |
| Dteparsemgd.dll | 2022.160.4185.2 | 178232 | 26-Feb-2025 | 15:56 | x64 |
| Dtepkg.dll | 2022.160.4185.2 | 153672 | 26-Feb-2025 | 15:56 | x64 |
| Dtexec.exe | 2022.160.4185.2 | 76872 | 26-Feb-2025 | 15:56 | x64 |
| Dts.dll | 2022.160.4185.2 | 3270720 | 26-Feb-2025 | 15:56 | x64 |
| Dtscomexpreval.dll | 2022.160.4185.2 | 493632 | 26-Feb-2025 | 15:56 | x64 |
| Dtsconn.dll | 2022.160.4185.2 | 550992 | 26-Feb-2025 | 15:56 | x64 |
| Dtshost.exe | 2022.160.4185.2 | 120384 | 26-Feb-2025 | 15:56 | x64 |
| Dtslog.dll | 2022.160.4185.2 | 137288 | 26-Feb-2025 | 15:56 | x64 |
| Dtspipeline.dll | 2022.160.4185.2 | 1337384 | 26-Feb-2025 | 15:56 | x64 |
| Dtuparse.dll | 2022.160.4185.2 | 104520 | 26-Feb-2025 | 15:56 | x64 |
| Dtutil.exe | 2022.160.4185.2 | 166440 | 26-Feb-2025 | 15:56 | x64 |
| Exceldest.dll | 2022.160.4185.2 | 284728 | 26-Feb-2025 | 15:56 | x64 |
| Excelsrc.dll | 2022.160.4185.2 | 305192 | 26-Feb-2025 | 15:56 | x64 |
| Execpackagetask.dll | 2022.160.4185.2 | 182344 | 26-Feb-2025 | 15:56 | x64 |
| Flatfiledest.dll | 2022.160.4185.2 | 424008 | 26-Feb-2025 | 15:56 | x64 |
| Flatfilesrc.dll | 2022.160.4185.2 | 440400 | 26-Feb-2025 | 15:56 | x64 |
| Logread.exe | 2022.160.4185.2 | 792656 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.242 | 2933808 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.bcl.asyncinterfaces.dll | 6.0.21.52210 | 22144 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sqlclient.dll | 5.13.23292.1 | 2048632 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.data.sqlclient.sni.dll | 5.1.1.0 | 504872 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.data.tools.sql.batchparser.dll | 17.100.23.0 | 42416 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4185.2 | 30784 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identity.client.dll | 4.56.0.0 | 1652320 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identity.client.extensions.msal.dll | 4.56.0.0 | 66552 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.abstractions.dll | 6.24.0.31013 | 18864 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.jsonwebtokens.dll | 6.24.0.31013 | 85424 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.logging.dll | 6.24.0.31013 | 34224 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.protocols.dll | 6.24.0.31013 | 38288 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.24.0.31013 | 114048 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.identitymodel.tokens.dll | 6.24.0.31013 | 986032 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.connectioninfo.dll | 17.100.23.0 | 126496 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.dmf.common.dll | 17.100.23.0 | 63520 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4185.2 | 391192 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.management.sdk.sfc.dll | 17.100.23.0 | 513464 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.replication.dll | 2022.160.4185.2 | 1718336 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.sqlserver.rmo.dll | 16.0.4185.2 | 555048 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.servicebrokerenum.dll | 17.100.23.0 | 37920 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.smo.dll | 17.100.23.0 | 4451872 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.smoextended.dll | 17.100.23.0 | 161208 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.sqlclrprovider.dll | 17.100.23.0 | 21536 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.sqlenum.dll | 17.100.23.0 | 1587744 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4185.2 | 182336 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 15:56 | x64 |
| Msdtssrvrutil.dll | 2022.160.4185.2 | 125008 | 26-Feb-2025 | 15:56 | x64 |
| Msgprox.dll | 2022.160.4185.2 | 313416 | 26-Feb-2025 | 15:56 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 2750472 | 26-Feb-2025 | 15:56 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 153608 | 26-Feb-2025 | 15:56 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 26-Feb-2025 | 15:56 | x86 |
| Oledbdest.dll | 2022.160.4185.2 | 288792 | 26-Feb-2025 | 15:56 | x64 |
| Oledbsrc.dll | 2022.160.4185.2 | 317464 | 26-Feb-2025 | 15:56 | x64 |
| Qrdrsvc.exe | 2022.160.4185.2 | 526408 | 26-Feb-2025 | 15:56 | x64 |
| Rawdest.dll | 2022.160.4185.2 | 227408 | 26-Feb-2025 | 15:56 | x64 |
| Rawsource.dll | 2022.160.4185.2 | 215080 | 26-Feb-2025 | 15:56 | x64 |
| Rdistcom.dll | 2022.160.4185.2 | 944208 | 26-Feb-2025 | 15:56 | x64 |
| Recordsetdest.dll | 2022.160.4185.2 | 206888 | 26-Feb-2025 | 15:56 | x64 |
| Repldp.dll | 2022.160.4185.2 | 337976 | 26-Feb-2025 | 15:56 | x64 |
| Replerrx.dll | 2022.160.4185.2 | 198712 | 26-Feb-2025 | 15:56 | x64 |
| Replisapi.dll | 2022.160.4185.2 | 419880 | 26-Feb-2025 | 15:56 | x64 |
| Replmerg.exe | 2022.160.4185.2 | 596008 | 26-Feb-2025 | 15:56 | x64 |
| Replprov.dll | 2022.160.4185.2 | 890960 | 26-Feb-2025 | 15:56 | x64 |
| Replrec.dll | 2022.160.4185.2 | 1058856 | 26-Feb-2025 | 15:56 | x64 |
| Replsub.dll | 2022.160.4185.2 | 501800 | 26-Feb-2025 | 15:56 | x64 |
| Spresolv.dll | 2022.160.4185.2 | 301064 | 26-Feb-2025 | 15:56 | x64 |
| Sql_engine_core_shared_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |
| Sqlcmd.exe | 2022.160.4185.2 | 276512 | 26-Feb-2025 | 15:56 | x64 |
| Sqldiag.exe | 2022.160.4185.2 | 1140816 | 26-Feb-2025 | 15:56 | x64 |
| Sqldistx.dll | 2022.160.4185.2 | 268296 | 26-Feb-2025 | 15:56 | x64 |
| Sqlmergx.dll | 2022.160.4185.2 | 423992 | 26-Feb-2025 | 15:56 | x64 |
| Sqlnclirda11.dll | 2011.110.5069.66 | 3478208 | 26-Feb-2025 | 15:56 | x64 |
| Sqlsvc.dll | 2022.160.4185.2 | 194632 | 26-Feb-2025 | 15:56 | x64 |
| Sqlsvc.dll | 2022.160.4185.2 | 153664 | 26-Feb-2025 | 15:56 | x86 |
| Sqltaskconnections.dll | 2022.160.4185.2 | 211008 | 26-Feb-2025 | 15:56 | x64 |
| Ssradd.dll | 2022.160.4185.2 | 100392 | 26-Feb-2025 | 15:56 | x64 |
| Ssravg.dll | 2022.160.4185.2 | 100376 | 26-Feb-2025 | 15:56 | x64 |
| Ssrmax.dll | 2022.160.4185.2 | 100408 | 26-Feb-2025 | 15:56 | x64 |
| Ssrmin.dll | 2022.160.4185.2 | 100432 | 26-Feb-2025 | 15:56 | x64 |
| System.diagnostics.diagnosticsource.dll | 7.0.423.11508 | 173232 | 26-Feb-2025 | 15:56 | x86 |
| System.memory.dll | 4.6.31308.1 | 142240 | 26-Feb-2025 | 15:56 | x86 |
| System.runtime.compilerservices.unsafe.dll | 6.0.21.52210 | 18024 | 26-Feb-2025 | 15:56 | x86 |
| System.security.cryptography.protecteddata.dll | 7.0.22.51805 | 21640 | 26-Feb-2025 | 15:56 | x86 |
| Txagg.dll | 2022.160.4185.2 | 395328 | 26-Feb-2025 | 15:56 | x64 |
| Txbdd.dll | 2022.160.4185.2 | 190544 | 26-Feb-2025 | 15:56 | x64 |
| Txdatacollector.dll | 2022.160.4185.2 | 469032 | 26-Feb-2025 | 15:56 | x64 |
| Txdataconvert.dll | 2022.160.4185.2 | 333888 | 26-Feb-2025 | 15:56 | x64 |
| Txderived.dll | 2022.160.4185.2 | 632840 | 26-Feb-2025 | 15:56 | x64 |
| Txlookup.dll | 2022.160.4185.2 | 608296 | 26-Feb-2025 | 15:56 | x64 |
| Txmerge.dll | 2022.160.4185.2 | 243720 | 26-Feb-2025 | 15:56 | x64 |
| Txmergejoin.dll | 2022.160.4185.2 | 301104 | 26-Feb-2025 | 15:56 | x64 |
| Txmulticast.dll | 2022.160.4185.2 | 145448 | 26-Feb-2025 | 15:56 | x64 |
| Txrowcount.dll | 2022.160.4185.2 | 145464 | 26-Feb-2025 | 15:56 | x64 |
| Txsort.dll | 2022.160.4185.2 | 276520 | 26-Feb-2025 | 15:56 | x64 |
| Txsplit.dll | 2022.160.4185.2 | 620624 | 26-Feb-2025 | 15:56 | x64 |
| Txunionall.dll | 2022.160.4185.2 | 194584 | 26-Feb-2025 | 15:56 | x64 |
| Xe.dll | 2022.160.4185.2 | 718896 | 26-Feb-2025 | 15:56 | x64 |

SQL Server 2022 sql_extensibility

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commonlauncher.dll | 2022.160.4185.2 | 100408 | 26-Feb-2025 | 15:56 | x64 |
| Exthost.exe | 2022.160.4185.2 | 247848 | 26-Feb-2025 | 15:56 | x64 |
| Launchpad.exe | 2022.160.4185.2 | 1452088 | 26-Feb-2025 | 15:56 | x64 |
| Sql_extensibility_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |
| Sqlsatellite.dll | 2022.160.4185.2 | 1255440 | 26-Feb-2025 | 15:56 | x64 |

SQL Server 2022 Full-Text Engine

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Fd.dll | 2022.160.4185.2 | 702504 | 26-Feb-2025 | 15:56 | x64 |
| Fdhost.exe | 2022.160.4185.2 | 157760 | 26-Feb-2025 | 15:56 | x64 |
| Fdlauncher.exe | 2022.160.4185.2 | 100432 | 26-Feb-2025 | 15:56 | x64 |
| Sql_fulltext_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |

SQL Server 2022 Integration Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Attunity.sqlserver.cdccontroltask.dll | 7.0.0.133 | 78272 | 26-Feb-2025 | 15:56 | x86 |
| Attunity.sqlserver.cdcsplit.dll | 7.0.0.133 | 39320 | 26-Feb-2025 | 15:56 | x86 |
| Attunity.sqlserver.cdcsrc.dll | 7.0.0.133 | 79808 | 26-Feb-2025 | 15:56 | x86 |
| Commanddest.dll | 2022.160.4185.2 | 231504 | 26-Feb-2025 | 15:56 | x86 |
| Commanddest.dll | 2022.160.4185.2 | 272440 | 26-Feb-2025 | 15:56 | x64 |
| Dteparse.dll | 2022.160.4185.2 | 116776 | 26-Feb-2025 | 15:56 | x86 |
| Dteparse.dll | 2022.160.4185.2 | 133176 | 26-Feb-2025 | 15:56 | x64 |
| Dteparsemgd.dll | 2022.160.4185.2 | 165928 | 26-Feb-2025 | 15:56 | x86 |
| Dteparsemgd.dll | 2022.160.4185.2 | 178232 | 26-Feb-2025 | 15:56 | x64 |
| Dtepkg.dll | 2022.160.4185.2 | 133160 | 26-Feb-2025 | 15:56 | x86 |
| Dtepkg.dll | 2022.160.4185.2 | 153672 | 26-Feb-2025 | 15:56 | x64 |
| Dtexec.exe | 2022.160.4185.2 | 65056 | 26-Feb-2025 | 15:56 | x86 |
| Dtexec.exe | 2022.160.4185.2 | 76872 | 26-Feb-2025 | 15:56 | x64 |
| Dts.dll | 2022.160.4185.2 | 2861120 | 26-Feb-2025 | 15:56 | x86 |
| Dts.dll | 2022.160.4185.2 | 3270720 | 26-Feb-2025 | 15:56 | x64 |
| Dtscomexpreval.dll | 2022.160.4185.2 | 444456 | 26-Feb-2025 | 15:56 | x86 |
| Dtscomexpreval.dll | 2022.160.4185.2 | 493632 | 26-Feb-2025 | 15:56 | x64 |
| Dtsconn.dll | 2022.160.4185.2 | 464936 | 26-Feb-2025 | 15:56 | x86 |
| Dtsconn.dll | 2022.160.4185.2 | 550992 | 26-Feb-2025 | 15:56 | x64 |
| Dtsdebughost.exe | 2022.160.4185.2 | 114752 | 26-Feb-2025 | 15:56 | x64 |
| Dtsdebughost.exe | 2022.160.4185.2 | 94776 | 26-Feb-2025 | 15:56 | x86 |
| Dtshost.exe | 2022.160.4185.2 | 120384 | 26-Feb-2025 | 15:56 | x64 |
| Dtshost.exe | 2022.160.4185.2 | 98384 | 26-Feb-2025 | 15:56 | x86 |
| Dtslog.dll | 2022.160.4185.2 | 120872 | 26-Feb-2025 | 15:56 | x86 |
| Dtslog.dll | 2022.160.4185.2 | 137288 | 26-Feb-2025 | 15:56 | x64 |
| Dtspipeline.dll | 2022.160.4185.2 | 1144904 | 26-Feb-2025 | 15:56 | x86 |
| Dtspipeline.dll | 2022.160.4185.2 | 1337384 | 26-Feb-2025 | 15:56 | x64 |
| Dtuparse.dll | 2022.160.4185.2 | 104520 | 26-Feb-2025 | 15:56 | x64 |
| Dtuparse.dll | 2022.160.4185.2 | 88104 | 26-Feb-2025 | 15:56 | x86 |
| Dtutil.exe | 2022.160.4185.2 | 142408 | 26-Feb-2025 | 15:56 | x86 |
| Dtutil.exe | 2022.160.4185.2 | 166440 | 26-Feb-2025 | 15:56 | x64 |
| Exceldest.dll | 2022.160.4185.2 | 284728 | 26-Feb-2025 | 15:56 | x64 |
| Exceldest.dll | 2022.160.4185.2 | 247864 | 26-Feb-2025 | 15:56 | x86 |
| Excelsrc.dll | 2022.160.4185.2 | 305192 | 26-Feb-2025 | 15:56 | x64 |
| Excelsrc.dll | 2022.160.4185.2 | 264216 | 26-Feb-2025 | 15:56 | x86 |
| Execpackagetask.dll | 2022.160.4185.2 | 182344 | 26-Feb-2025 | 15:56 | x64 |
| Execpackagetask.dll | 2022.160.4185.2 | 149544 | 26-Feb-2025 | 15:56 | x86 |
| Flatfiledest.dll | 2022.160.4185.2 | 424008 | 26-Feb-2025 | 15:56 | x64 |
| Flatfiledest.dll | 2022.160.4185.2 | 374824 | 26-Feb-2025 | 15:56 | x86 |
| Flatfilesrc.dll | 2022.160.4185.2 | 440400 | 26-Feb-2025 | 15:56 | x64 |
| Flatfilesrc.dll | 2022.160.4185.2 | 391208 | 26-Feb-2025 | 15:56 | x86 |
| Isdbupgradewizard.exe | 16.0.4185.2 | 120904 | 26-Feb-2025 | 15:56 | x86 |
| Isdbupgradewizard.exe | 16.0.4185.2 | 120912 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.242 | 2933808 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.analysisservices.applocal.core.dll | 16.0.43.242 | 2933832 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4185.2 | 509992 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4185.2 | 510032 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 16.0.4185.2 | 391192 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4185.2 | 170024 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4185.2 | 182336 | 26-Feb-2025 | 15:56 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4185.2 | 178256 | 26-Feb-2025 | 15:56 | x86 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 15:56 | x64 |
| Msdtssrvr.exe | 16.0.4185.2 | 219216 | 26-Feb-2025 | 15:56 | x64 |
| Msdtssrvrutil.dll | 2022.160.4185.2 | 100392 | 26-Feb-2025 | 15:56 | x86 |
| Msdtssrvrutil.dll | 2022.160.4185.2 | 125008 | 26-Feb-2025 | 15:56 | x64 |
| Msmdpp.dll | 2022.160.43.242 | 10164304 | 26-Feb-2025 | 15:56 | x64 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 26-Feb-2025 | 15:56 | x86 |
| Newtonsoft.json.dll | 13.0.1.25517 | 704408 | 26-Feb-2025 | 15:56 | x86 |
| Odbcdest.dll | 2022.160.4185.2 | 342056 | 26-Feb-2025 | 15:56 | x86 |
| Odbcdest.dll | 2022.160.4185.2 | 387136 | 26-Feb-2025 | 15:56 | x64 |
| Odbcsrc.dll | 2022.160.4185.2 | 350248 | 26-Feb-2025 | 15:56 | x86 |
| Odbcsrc.dll | 2022.160.4185.2 | 399400 | 26-Feb-2025 | 15:56 | x64 |
| Oledbdest.dll | 2022.160.4185.2 | 247848 | 26-Feb-2025 | 15:56 | x86 |
| Oledbdest.dll | 2022.160.4185.2 | 288792 | 26-Feb-2025 | 15:56 | x64 |
| Oledbsrc.dll | 2022.160.4185.2 | 268320 | 26-Feb-2025 | 15:56 | x86 |
| Oledbsrc.dll | 2022.160.4185.2 | 317464 | 26-Feb-2025 | 15:56 | x64 |
| Rawdest.dll | 2022.160.4185.2 | 227408 | 26-Feb-2025 | 15:56 | x64 |
| Rawdest.dll | 2022.160.4185.2 | 190504 | 26-Feb-2025 | 15:56 | x86 |
| Rawsource.dll | 2022.160.4185.2 | 215080 | 26-Feb-2025 | 15:56 | x64 |
| Rawsource.dll | 2022.160.4185.2 | 186432 | 26-Feb-2025 | 15:56 | x86 |
| Recordsetdest.dll | 2022.160.4185.2 | 206888 | 26-Feb-2025 | 15:56 | x64 |
| Recordsetdest.dll | 2022.160.4185.2 | 174160 | 26-Feb-2025 | 15:56 | x86 |
| Sql_is_keyfile.dll | 2022.160.4185.2 | 137296 | 26-Feb-2025 | 15:56 | x64 |
| Sqlceip.exe | 16.0.4185.2 | 301136 | 26-Feb-2025 | 15:56 | x86 |
| Sqldest.dll | 2022.160.4185.2 | 256040 | 26-Feb-2025 | 15:56 | x86 |
| Sqldest.dll | 2022.160.4185.2 | 288848 | 26-Feb-2025 | 15:56 | x64 |
| Sqltaskconnections.dll | 2022.160.4185.2 | 211008 | 26-Feb-2025 | 15:56 | x64 |
| Sqltaskconnections.dll | 2022.160.4185.2 | 174136 | 26-Feb-2025 | 15:56 | x86 |
| Txagg.dll | 2022.160.4185.2 | 346152 | 26-Feb-2025 | 15:56 | x86 |
| Txagg.dll | 2022.160.4185.2 | 395328 | 26-Feb-2025 | 15:56 | x64 |
| Txbdd.dll | 2022.160.4185.2 | 149568 | 26-Feb-2025 | 15:56 | x86 |
| Txbdd.dll | 2022.160.4185.2 | 190544 | 26-Feb-2025 | 15:56 | x64 |
| Txbestmatch.dll | 2022.160.4185.2 | 567336 | 26-Feb-2025 | 15:56 | x86 |
| Txbestmatch.dll | 2022.160.4185.2 | 661576 | 26-Feb-2025 | 15:56 | x64 |
| Txcache.dll | 2022.160.4185.2 | 170024 | 26-Feb-2025 | 15:56 | x86 |
| Txcache.dll | 2022.160.4185.2 | 202824 | 26-Feb-2025 | 15:56 | x64 |
| Txcharmap.dll | 2022.160.4185.2 | 280656 | 26-Feb-2025 | 15:56 | x86 |
| Txcharmap.dll | 2022.160.4185.2 | 325712 | 26-Feb-2025 | 15:56 | x64 |
| Txcopymap.dll | 2022.160.4185.2 | 165920 | 26-Feb-2025 | 15:56 | x86 |
| Txcopymap.dll | 2022.160.4185.2 | 202824 | 26-Feb-2025 | 15:56 | x64 |
| Txdataconvert.dll | 2022.160.4185.2 | 288824 | 26-Feb-2025 | 15:56 | x86 |
| Txdataconvert.dll | 2022.160.4185.2 | 333888 | 26-Feb-2025 | 15:56 | x64 |
| Txderived.dll | 2022.160.4185.2 | 559160 | 26-Feb-2025 | 15:56 | x86 |
| Txderived.dll | 2022.160.4185.2 | 632840 | 26-Feb-2025 | 15:56 | x64 |
| Txfileextractor.dll | 2022.160.4185.2 | 186408 | 26-Feb-2025 | 15:56 | x86 |
| Txfileextractor.dll | 2022.160.4185.2 | 219216 | 26-Feb-2025 | 15:56 | x64 |
| Txfileinserter.dll | 2022.160.4185.2 | 186424 | 26-Feb-2025 | 15:56 | x86 |
| Txfileinserter.dll | 2022.160.4185.2 | 219192 | 26-Feb-2025 | 15:56 | x64 |
| Txgroupdups.dll | 2022.160.4185.2 | 354344 | 26-Feb-2025 | 15:56 | x86 |
| Txgroupdups.dll | 2022.160.4185.2 | 403520 | 26-Feb-2025 | 15:56 | x64 |
| Txlineage.dll | 2022.160.4185.2 | 129064 | 26-Feb-2025 | 15:56 | x86 |
| Txlineage.dll | 2022.160.4185.2 | 157736 | 26-Feb-2025 | 15:56 | x64 |
| Txlookup.dll | 2022.160.4185.2 | 522296 | 26-Feb-2025 | 15:56 | x86 |
| Txlookup.dll | 2022.160.4185.2 | 608296 | 26-Feb-2025 | 15:56 | x64 |
| Txmerge.dll | 2022.160.4185.2 | 194600 | 26-Feb-2025 | 15:56 | x86 |
| Txmerge.dll | 2022.160.4185.2 | 243720 | 26-Feb-2025 | 15:56 | x64 |
| Txmergejoin.dll | 2022.160.4185.2 | 256040 | 26-Feb-2025 | 15:56 | x86 |
| Txmergejoin.dll | 2022.160.4185.2 | 301104 | 26-Feb-2025 | 15:56 | x64 |
| Txmulticast.dll | 2022.160.4185.2 | 116768 | 26-Feb-2025 | 15:56 | x86 |
| Txmulticast.dll | 2022.160.4185.2 | 145448 | 26-Feb-2025 | 15:56 | x64 |
| Txpivot.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 15:56 | x86 |
| Txpivot.dll | 2022.160.4185.2 | 239680 | 26-Feb-2025 | 15:56 | x64 |
| Txrowcount.dll | 2022.160.4185.2 | 116792 | 26-Feb-2025 | 15:56 | x86 |
| Txrowcount.dll | 2022.160.4185.2 | 145464 | 26-Feb-2025 | 15:56 | x64 |
| Txsampling.dll | 2022.160.4185.2 | 153608 | 26-Feb-2025 | 15:56 | x86 |
| Txsampling.dll | 2022.160.4185.2 | 186424 | 26-Feb-2025 | 15:56 | x64 |
| Txscd.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 15:56 | x86 |
| Txscd.dll | 2022.160.4185.2 | 235600 | 26-Feb-2025 | 15:56 | x64 |
| Txsort.dll | 2022.160.4185.2 | 231464 | 26-Feb-2025 | 15:56 | x86 |
| Txsort.dll | 2022.160.4185.2 | 276520 | 26-Feb-2025 | 15:56 | x64 |
| Txsplit.dll | 2022.160.4185.2 | 550992 | 26-Feb-2025 | 15:56 | x86 |
| Txsplit.dll | 2022.160.4185.2 | 620624 | 26-Feb-2025 | 15:56 | x64 |
| Txtermextraction.dll | 2022.160.4185.2 | 8648784 | 26-Feb-2025 | 15:56 | x86 |
| Txtermextraction.dll | 2022.160.4185.2 | 8702032 | 26-Feb-2025 | 15:56 | x64 |
| Txtermlookup.dll | 2022.160.4185.2 | 4139088 | 26-Feb-2025 | 15:56 | x86 |
| Txtermlookup.dll | 2022.160.4185.2 | 4184144 | 26-Feb-2025 | 15:56 | x64 |
| Txunionall.dll | 2022.160.4185.2 | 153640 | 26-Feb-2025 | 15:56 | x86 |
| Txunionall.dll | 2022.160.4185.2 | 194584 | 26-Feb-2025 | 15:56 | x64 |
| Txunpivot.dll | 2022.160.4185.2 | 178232 | 26-Feb-2025 | 15:56 | x86 |
| Txunpivot.dll | 2022.160.4185.2 | 215048 | 26-Feb-2025 | 15:56 | x64 |
| Xe.dll | 2022.160.4185.2 | 641088 | 26-Feb-2025 | 15:56 | x86 |
| Xe.dll | 2022.160.4185.2 | 718896 | 26-Feb-2025 | 15:56 | x64 |

SQL Server 2022 sql_polybase_core_inst

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dms.dll | 16.0.1046.0 | 559680 | 26-Feb-2025 | 16:28 | x86 |
| Dmsnative.dll | 2022.160.1046.0 | 152640 | 26-Feb-2025 | 16:28 | x64 |
| Dwengineservice.dll | 16.0.1046.0 | 45112 | 26-Feb-2025 | 16:28 | x86 |
| Instapi150.dll | 2022.160.4185.2 | 104480 | 26-Feb-2025 | 16:28 | x64 |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll | 16.0.1046.0 | 67640 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.catalog.dll | 16.0.1046.0 | 293456 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.common.dll | 16.0.1046.0 | 1958472 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.configuration.dll | 16.0.1046.0 | 169520 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll | 16.0.1046.0 | 647224 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll | 16.0.1046.0 | 246368 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll | 16.0.1046.0 | 139344 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1046.0 | 79968 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll | 16.0.1046.0 | 51248 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.distributor.dll | 16.0.1046.0 | 88656 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.dll | 16.0.1046.0 | 1129528 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll | 16.0.1046.0 | 80992 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.eventing.dll | 16.0.1046.0 | 70736 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll | 16.0.1046.0 | 35376 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll | 16.0.1046.0 | 30784 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll | 16.0.1046.0 | 46672 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll | 16.0.1046.0 | 21552 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.failover.dll | 16.0.1046.0 | 26672 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll | 16.0.1046.0 | 131664 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll | 16.0.1046.0 | 86624 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll | 16.0.1046.0 | 100960 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.dll | 16.0.1046.0 | 293432 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 120376 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 138296 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 141384 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 137776 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 150592 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 139832 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 134712 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 176688 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 117816 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 16.0.1046.0 | 136768 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.nodes.dll | 16.0.1046.0 | 72784 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll | 16.0.1046.0 | 22064 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll | 16.0.1046.0 | 37432 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll | 16.0.1046.0 | 129072 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.dll | 16.0.1046.0 | 3064912 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll | 16.0.1046.0 | 3955784 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 118336 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 133184 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 137776 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 133680 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 148528 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 134192 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 130624 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 171064 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 115256 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 16.0.1046.0 | 132152 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll | 16.0.1046.0 | 67664 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll | 16.0.1046.0 | 2682936 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.datawarehouse.utilities.dll | 16.0.1046.0 | 2436664 | 26-Feb-2025 | 16:28 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2022.160.4185.2 | 84040 | 26-Feb-2025 | 16:28 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4185.2 | 182336 | 26-Feb-2025 | 16:28 | x64 |
| Microsoft.sqlserver.xevent.dll | 2022.160.4185.2 | 198696 | 26-Feb-2025 | 16:28 | x64 |
| Mpdwinterop.dll | 2022.160.4185.2 | 297040 | 26-Feb-2025 | 16:28 | x64 |
| Mpdwsvc.exe | 2022.160.4185.2 | 9082920 | 26-Feb-2025 | 16:28 | x64 |
| Secforwarder.dll | 2022.160.4185.2 | 84048 | 26-Feb-2025 | 16:28 | x64 |
| Sharedmemory.dll | 2022.160.1046.0 | 61504 | 26-Feb-2025 | 16:28 | x64 |
| Sqldk.dll | 2022.160.4185.2 | 4024392 | 26-Feb-2025 | 16:28 | x64 |
| Sqldumper.exe | 2022.160.4185.2 | 448528 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 1759312 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4606016 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 3774544 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4606016 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4507688 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 2459704 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 2402368 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4237352 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4216904 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 1697856 | 26-Feb-2025 | 16:28 | x64 |
| Sqlevn70.rll | 2022.160.4185.2 | 4470848 | 26-Feb-2025 | 16:28 | x64 |
| Sqlncli17e.dll | 2017.1710.6.1 | 1898520 | 26-Feb-2025 | 16:28 | x64 |
| Sqlos.dll | 2022.160.4185.2 | 51240 | 26-Feb-2025 | 16:28 | x64 |
| Sqlsortpdw.dll | 2022.160.1046.0 | 4841520 | 26-Feb-2025 | 16:28 | x64 |
| Sqltses.dll | 2022.160.4185.2 | 10668088 | 26-Feb-2025 | 16:28 | x64 |

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
