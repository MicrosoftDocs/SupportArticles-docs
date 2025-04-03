---
title: Cumulative update 32 for SQL Server 2019 (KB5054833)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2019 cumulative update 32 (KB5054833).
ms.date: 02/27/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5054833
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5054833 - Cumulative Update 32 for SQL Server 2019

_Release Date:_ &nbsp; February 27, 2025  
_Version:_ &nbsp; 15.0.4430.1

## Summary

This article describes Cumulative Update package 32 (CU32) for Microsoft SQL Server 2019. This update contains 1 [fix](#improvements-and-fixes-included-in-this-update) that was issued after the release of SQL Server 2019 Cumulative Update 31, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4430.1**, file version: **2019.150.4430.1**
- Analysis Services - Product version: **15.0.35.51**, file version: **2018.150.35.51**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion-context-2019](../includes/av-sesssion_context-2019.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bug that is fixed in this cumulative update, see the following Microsoft Knowledge Base article.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=3907024>[3907024](#3907024) </a> | Fixes an issue in which patching a read-scale availability group causes the availability group on the patched replica to be removed. For more information, see [issue two of SQL Server 2019 CU31](cumulativeupdate31.md#issue-two-patching-a-read-scale-availability-group-windows-or-linux-causes-the-availability-group-on-the-patched-replica-to-be-removed). | SQL Server Engine  | High Availability and Disaster Recovery | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU32 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5054833)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5054833-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5054833-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5054833-x64.exe| 864AA01854D124BD907920B26271F9F2ED3F5F82880ADB746DBBC681EF32B371 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Asplatformhost.dll | 2018.150.35.51 | 292912 | 21-Feb-2025 | 18:02 | x64 |
| Mashupcompression.dll | 2.87.142.0 | 140672 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.analysisservices.minterop.dll | 15.0.35.51 | 758344 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 175680 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 199728 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 202296 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 198704 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 215088 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 197680 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 193584 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 252464 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 174120 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.core.resources.dll | 15.0.35.51 | 197160 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.dll | 15.0.35.51 | 1098840 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.json.dll | 15.0.35.51 | 567344 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 54856 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 59440 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 59992 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 62024 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58304 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58440 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 67656 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 53696 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.server.tabular.resources.dll | 15.0.35.51 | 58440 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17992 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17976 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 19032 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51 | 17968 | 21-Feb-2025 | 18:02 | x86 |
| Microsoft.data.edm.netfx35.dll | 5.7.0.62516 | 660872 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.dll | 2.87.142.0 | 191352 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.oledb.dll | 2.87.142.0 | 30592 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.preview.dll | 2.87.142.0 | 76672 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.dll | 2.87.142.0 | 103808 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 37760 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 32120 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41856 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 45952 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 37752 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.mashup.providercommon.resources.dll | 2.87.142.0 | 41864 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.odata.netfx35.dll | 5.7.0.62516 | 1454464 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.odata.query.netfx35.dll | 5.7.0.62516 | 181120 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.dll | 1.0.0.25 | 929592 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34600 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34616 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34624 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 35128 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 46888 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 33064 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 34616 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.data.sapclient.resources.dll | 1.0.0.25 | 37672 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.hostintegration.connectors.dll | 2.87.142.0 | 5283720 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.container.exe | 2.87.142.0 | 23432 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.mashup.container.netfx40.exe | 2.87.142.0 | 22912 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.mashup.container.netfx45.exe | 2.87.142.0 | 22912 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.mashup.eventsource.dll | 2.87.142.0 | 149384 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.dll | 2.87.142.0 | 78720 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14712 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15240 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15240 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15232 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15232 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15224 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14728 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 15744 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14720 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oauth.resources.dll | 2.87.142.0 | 14728 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbinterop.dll | 2.87.142.0 | 199560 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.mashup.oledbprovider.dll | 2.87.142.0 | 64888 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13184 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13176 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13184 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.oledbprovider.resources.dll | 2.87.142.0 | 13192 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.scriptdom.dll | 2.40.4554.261 | 2371808 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.shims.dll | 2.87.142.0 | 27528 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0 | 140168 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.dll | 2.87.142.0 | 14835080 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 566136 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 676728 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 672640 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 652152 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 701312 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 660352 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 639872 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 881536 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 553848 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.mashupengine.resources.dll | 2.87.142.0 | 648064 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.odata.core.netfx35.dll | 6.15.0.0 | 1437560 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.odata.edm.netfx35.dll | 6.15.0.0 | 778632 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.powerbi.adomdclient.dll | 15.1.61.21 | 1109368 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.spatial.netfx35.dll | 6.15.0.0 | 126344 | 21-Feb-2025 | 18:06 | x86 |
| Msmdctr.dll | 2018.150.35.51 | 38472 | 21-Feb-2025 | 18:02 | x64 |
| Msmdlocal.dll | 2018.150.35.51 | 47784504 | 21-Feb-2025 | 18:02 | x86 |
| Msmdlocal.dll | 2018.150.35.51 | 66261560 | 21-Feb-2025 | 18:02 | x64 |
| Msmdpump.dll | 2018.150.35.51 | 10187312 | 21-Feb-2025 | 18:02 | x64 |
| Msmdredir.dll | 2018.150.35.51 | 7957576 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16952 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17456 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17464 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17480 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 17464 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 18488 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16960 | 21-Feb-2025 | 18:02 | x86 |
| Msmdspdm.resources.dll | 15.0.35.51 | 16944 | 21-Feb-2025 | 18:02 | x86 |
| Msmdsrv.exe | 2018.150.35.51 | 65799240 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 833592 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1628208 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1454144 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1643056 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1608752 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1001520 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 992808 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1537080 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1521712 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 811056 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrv.rll | 2018.150.35.51 | 1596472 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 832568 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1624624 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1451064 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1637936 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1604656 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 998968 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 991280 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1532976 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1518136 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 810040 | 21-Feb-2025 | 18:02 | x64 |
| Msmdsrvi.rll | 2018.150.35.51 | 1591848 | 21-Feb-2025 | 18:02 | x64 |
| Msmgdsrv.dll | 2018.150.35.51 | 8280112 | 21-Feb-2025 | 18:02 | x86 |
| Msmgdsrv.dll | 2018.150.35.51 | 10186288 | 21-Feb-2025 | 18:02 | x64 |
| Msolap.dll | 2018.150.35.51 | 8607168 | 21-Feb-2025 | 18:02 | x86 |
| Msolap.dll | 2018.150.35.51 | 11013184 | 21-Feb-2025 | 18:02 | x64 |
| Msolui.dll | 2018.150.35.51 | 286256 | 21-Feb-2025 | 18:02 | x86 |
| Msolui.dll | 2018.150.35.51 | 306624 | 21-Feb-2025 | 18:02 | x64 |
| Powerbiextensions.dll | 2.87.142.0 | 8853888 | 21-Feb-2025 | 18:06 | x86 |
| Private_odbc32.dll | 10.0.14832.1000 | 728448 | 21-Feb-2025 | 18:06 | x64 |
| Sqlboot.dll | 2019.150.4430.1 | 215096 | 21-Feb-2025 | 18:06 | x64 |
| Sqlceip.exe | 15.0.4430.1 | 297000 | 21-Feb-2025 | 18:06 | x86 |
| Sqldumper.exe | 2019.150.4430.1 | 321568 | 21-Feb-2025 | 18:06 | x86 |
| Sqldumper.exe | 2019.150.4430.1 | 378960 | 21-Feb-2025 | 18:06 | x64 |
| System.spatial.netfx35.dll | 5.7.0.62516 | 117640 | 21-Feb-2025 | 18:06 | x86 |
| Tbb.dll | 2019.0.2019.410 | 442688 | 21-Feb-2025 | 18:02 | x64 |
| Tbbmalloc.dll | 2019.0.2019.410 | 270144 | 21-Feb-2025 | 18:02 | x64 |
| Tmapi.dll | 2018.150.35.51 | 6178352 | 21-Feb-2025 | 18:02 | x64 |
| Tmcachemgr.dll | 2018.150.35.51 | 4917808 | 21-Feb-2025 | 18:02 | x64 |
| Tmpersistence.dll | 2018.150.35.51 | 1184816 | 21-Feb-2025 | 18:02 | x64 |
| Tmtransactions.dll | 2018.150.35.51 | 6807088 | 21-Feb-2025 | 18:02 | x64 |
| Xmsrv.dll | 2018.150.35.51 | 35460152 | 21-Feb-2025 | 18:02 | x86 |
| Xmsrv.dll | 2018.150.35.51 | 26025544 | 21-Feb-2025 | 18:02 | x64 |

SQL Server 2019 Database Services Common Core

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Batchparser.dll | 2019.150.4430.1 | 165928 | 21-Feb-2025 | 18:06 | x86 |
| Batchparser.dll | 2019.150.4430.1 | 182328 | 21-Feb-2025 | 18:06 | x64 |
| Instapi150.dll | 2019.150.4430.1 | 75832 | 21-Feb-2025 | 18:06 | x86 |
| Instapi150.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4430.1 | 104512 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4430.1 | 88144 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.rmo.dll | 15.0.4430.1 | 550952 | 21-Feb-2025 | 18:06 | x86 |
| Msasxpress.dll | 2018.150.35.51 | 27184 | 21-Feb-2025 | 18:02 | x86 |
| Msasxpress.dll | 2018.150.35.51 | 32304 | 21-Feb-2025 | 18:02 | x64 |
| Pbsvcacctsync.dll | 2019.150.4430.1 | 75808 | 21-Feb-2025 | 18:06 | x86 |
| Pbsvcacctsync.dll | 2019.150.4430.1 | 92232 | 21-Feb-2025 | 18:06 | x64 |
| Sqldumper.exe | 2019.150.4430.1 | 321568 | 21-Feb-2025 | 18:06 | x86 |
| Sqldumper.exe | 2019.150.4430.1 | 378960 | 21-Feb-2025 | 18:06 | x64 |
| Sqlftacct.dll | 2019.150.4430.1 | 59416 | 21-Feb-2025 | 18:06 | x86 |
| Sqlftacct.dll | 2019.150.4430.1 | 79928 | 21-Feb-2025 | 18:06 | x64 |
| Sqlmanager.dll | 2019.150.4430.1 | 743464 | 21-Feb-2025 | 18:06 | x86 |
| Sqlmanager.dll | 2019.150.4430.1 | 878632 | 21-Feb-2025 | 18:06 | x64 |
| Sqlmgmprovider.dll | 2019.150.4430.1 | 378944 | 21-Feb-2025 | 18:06 | x86 |
| Sqlmgmprovider.dll | 2019.150.4430.1 | 432168 | 21-Feb-2025 | 18:06 | x64 |
| Sqlsvcsync.dll | 2019.150.4430.1 | 276512 | 21-Feb-2025 | 18:06 | x86 |
| Sqlsvcsync.dll | 2019.150.4430.1 | 358464 | 21-Feb-2025 | 18:06 | x64 |
| Svrenumapi150.dll | 2019.150.4430.1 | 1161256 | 21-Feb-2025 | 18:06 | x64 |
| Svrenumapi150.dll | 2019.150.4430.1 | 911416 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 Data Quality

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Microsoft.ssdqs.core.dll | 15.0.4430.1 | 600104 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.ssdqs.core.dll | 15.0.4430.1 | 600144 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.ssdqs.infra.dll | 15.0.4430.1 | 1857568 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.ssdqs.infra.dll | 15.0.4430.1 | 1857592 | 21-Feb-2025 | 18:06 | x86 |
| Dqsinstaller.exe | 15.0.4430.1 | 2771000 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 sql_dreplay_client

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dreplayclient.exe | 2019.150.4430.1 | 137256 | 21-Feb-2025 | 18:06 | x86 |
| Dreplaycommon.dll | 2019.150.4430.1 | 667704 | 21-Feb-2025 | 18:06 | x86 |
| Dreplayutil.dll | 2019.150.4430.1 | 305208 | 21-Feb-2025 | 18:06 | x86 |
| Instapi150.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:06 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 38968 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 sql_dreplay_controller

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dreplaycommon.dll | 2019.150.4430.1 | 667704 | 21-Feb-2025 | 18:06 | x86 |
| Dreplaycontroller.exe | 2019.150.4430.1 | 366648 | 21-Feb-2025 | 18:06 | x86 |
| Instapi150.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:01 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 38968 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 Database Services Core Instance

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Aetm-enclave-simulator.dll | 2019.150.4430.1 | 4658216 | 21-Feb-2025 | 18:26 | x64 |
| Aetm-enclave.dll | 2019.150.4430.1 | 4612640 | 21-Feb-2025 | 18:26 | x64 |
| Aetm-sgx-enclave-simulator.dll | 2019.150.4430.1 | 4932520 | 21-Feb-2025 | 18:26 | x64 |
| Aetm-sgx-enclave.dll | 2019.150.4430.1 | 4873152 | 21-Feb-2025 | 18:26 | x64 |
| Azureattest.dll | 10.0.18965.1000 | 255056 | 21-Feb-2025 | 18:38 | x64 |
| Azureattestmanager.dll | 10.0.18965.1000 | 97528 | 21-Feb-2025 | 18:38 | x64 |
| Batchparser.dll | 2019.150.4430.1 | 182328 | 21-Feb-2025 | 18:26 | x64 |
| C1.dll | 19.16.27034.0 | 2438520 | 21-Feb-2025 | 18:38 | x64 |
| C2.dll | 19.16.27034.0 | 7239032 | 21-Feb-2025 | 18:38 | x64 |
| Cl.exe | 19.16.27034.0 | 424360 | 21-Feb-2025 | 18:38 | x64 |
| Clui.dll | 19.16.27034.0 | 541048 | 21-Feb-2025 | 18:38 | x64 |
| Databasemailengine.dll | 15.0.4430.1 | 79896 | 21-Feb-2025 | 18:38 | x86 |
| Datacollectorcontroller.dll | 2019.150.4430.1 | 280632 | 21-Feb-2025 | 18:38 | x64 |
| Dcexec.exe | 2019.150.4430.1 | 88120 | 21-Feb-2025 | 18:38 | x64 |
| Fssres.dll | 2019.150.4430.1 | 96296 | 21-Feb-2025 | 18:38 | x64 |
| Hadrres.dll | 2019.150.4430.1 | 206888 | 21-Feb-2025 | 18:38 | x64 |
| Hkcompile.dll | 2019.150.4430.1 | 1292344 | 21-Feb-2025 | 18:38 | x64 |
| Hkengine.dll | 2019.150.4430.1 | 5793848 | 21-Feb-2025 | 18:38 | x64 |
| Hkruntime.dll | 2019.150.4430.1 | 182280 | 21-Feb-2025 | 18:38 | x64 |
| Hktempdb.dll | 2019.150.4430.1 | 63568 | 21-Feb-2025 | 18:38 | x64 |
| Link.exe | 14.16.27034.0 | 1707936 | 21-Feb-2025 | 18:38 | x64 |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4430.1 | 235560 | 21-Feb-2025 | 18:38 | x86 |
| Microsoft.sqlserver.types.dll | 2019.150.4430.1 | 391208 | 21-Feb-2025 | 18:38 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2019.150.4430.1 | 84008 | 21-Feb-2025 | 18:26 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 178256 | 21-Feb-2025 | 18:38 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 194640 | 21-Feb-2025 | 18:38 | x64 |
| Microsoft.sqlserver.xevent.linq.dll | 2019.150.4430.1 | 325696 | 21-Feb-2025 | 18:38 | x64 |
| Microsoft.sqlserver.xevent.targets.dll | 2019.150.4430.1 | 92232 | 21-Feb-2025 | 18:38 | x64 |
| Msobj140.dll | 14.16.27034.0 | 134008 | 21-Feb-2025 | 18:38 | x64 |
| Mspdb140.dll | 14.16.27034.0 | 632184 | 21-Feb-2025 | 18:38 | x64 |
| Mspdbcore.dll | 14.16.27034.0 | 632184 | 21-Feb-2025 | 18:38 | x64 |
| Msvcp140.dll | 14.16.27034.0 | 628200 | 21-Feb-2025 | 18:38 | x64 |
| Qds.dll | 2019.150.4430.1 | 1189928 | 21-Feb-2025 | 18:38 | x64 |
| Rsfxft.dll | 2019.150.4430.1 | 51280 | 21-Feb-2025 | 18:38 | x64 |
| Secforwarder.dll | 2019.150.4430.1 | 79936 | 21-Feb-2025 | 18:38 | x64 |
| Sqagtres.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:38 | x64 |
| Sqlaamss.dll | 2019.150.4430.1 | 108624 | 21-Feb-2025 | 18:38 | x64 |
| Sqlaccess.dll | 2019.150.4430.1 | 493632 | 21-Feb-2025 | 18:38 | x64 |
| Sqlagent.exe | 2019.150.4430.1 | 731176 | 21-Feb-2025 | 18:38 | x64 |
| Sqlagentctr150.dll | 2019.150.4430.1 | 71744 | 21-Feb-2025 | 18:38 | x86 |
| Sqlagentctr150.dll | 2019.150.4430.1 | 79936 | 21-Feb-2025 | 18:38 | x64 |
| Sqlboot.dll | 2019.150.4430.1 | 215096 | 21-Feb-2025 | 18:38 | x64 |
| Sqlceip.exe | 15.0.4430.1 | 297000 | 21-Feb-2025 | 18:38 | x86 |
| Sqlcmdss.dll | 2019.150.4430.1 | 88120 | 21-Feb-2025 | 18:38 | x64 |
| Sqlctr150.dll | 2019.150.4430.1 | 116768 | 21-Feb-2025 | 18:38 | x86 |
| Sqlctr150.dll | 2019.150.4430.1 | 145440 | 21-Feb-2025 | 18:38 | x64 |
| Sqldk.dll | 2019.150.4430.1 | 3180584 | 21-Feb-2025 | 18:38 | x64 |
| Sqldtsss.dll | 2019.150.4430.1 | 108608 | 21-Feb-2025 | 18:38 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 1599544 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3512376 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3704912 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4175920 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4290640 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3422264 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3590168 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4167736 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4020304 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4073552 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 2226240 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 2177104 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3881040 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3553312 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4028472 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3831848 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3827776 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3622976 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3512376 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 1542184 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3917904 | 21-Feb-2025 | 18:26 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4040768 | 21-Feb-2025 | 18:26 | x64 |
| Sqllang.dll | 2019.150.4430.1 | 40089640 | 21-Feb-2025 | 18:38 | x64 |
| Sqlmin.dll | 2019.150.4430.1 | 40665168 | 21-Feb-2025 | 18:38 | x64 |
| Sqlolapss.dll | 2019.150.4430.1 | 108608 | 21-Feb-2025 | 18:38 | x64 |
| Sqlos.dll | 2019.150.4430.1 | 43032 | 21-Feb-2025 | 18:38 | x64 |
| Sqlpowershellss.dll | 2019.150.4430.1 | 83984 | 21-Feb-2025 | 18:38 | x64 |
| Sqlrepss.dll | 2019.150.4430.1 | 88144 | 21-Feb-2025 | 18:38 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 51232 | 21-Feb-2025 | 18:38 | x64 |
| Sqlscm.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:38 | x64 |
| Sqlscriptdowngrade.dll | 2019.150.4430.1 | 38976 | 21-Feb-2025 | 18:38 | x64 |
| Sqlscriptupgrade.dll | 2019.150.4430.1 | 5810232 | 21-Feb-2025 | 18:38 | x64 |
| Sqlserverspatial150.dll | 2019.150.4430.1 | 673848 | 21-Feb-2025 | 18:38 | x64 |
| Sqlservr.exe | 2019.150.4430.1 | 628792 | 21-Feb-2025 | 18:38 | x64 |
| Sqlsvc.dll | 2019.150.4430.1 | 182352 | 21-Feb-2025 | 18:38 | x64 |
| Sqltses.dll | 2019.150.4430.1 | 9119784 | 21-Feb-2025 | 18:38 | x64 |
| Sqsrvres.dll | 2019.150.4430.1 | 280600 | 21-Feb-2025 | 18:38 | x64 |
| Stretchcodegen.exe | 15.0.4430.1 | 59448 | 21-Feb-2025 | 18:26 | x86 |
| Svl.dll | 2019.150.4430.1 | 161832 | 21-Feb-2025 | 18:38 | x64 |
| Vcruntime140.dll | 14.16.27034.0 | 85992 | 21-Feb-2025 | 18:38 | x64 |
| Xe.dll | 2019.150.4430.1 | 718912 | 21-Feb-2025 | 18:38 | x64 |
| Xpadsi.exe | 2019.150.4430.1 | 116760 | 21-Feb-2025 | 18:38 | x64 |
| Xplog70.dll | 2019.150.4430.1 | 92200 | 21-Feb-2025 | 18:38 | x64 |
| Xpqueue.dll | 2019.150.4430.1 | 92200 | 21-Feb-2025 | 18:38 | x64 |
| Xprepl.dll | 2019.150.4430.1 | 120896 | 21-Feb-2025 | 18:38 | x64 |
| Xpstar.dll | 2019.150.4430.1 | 473152 | 21-Feb-2025 | 18:38 | x64 |

SQL Server 2019 Database Services Core Shared

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Batchparser.dll | 2019.150.4430.1 | 182328 | 21-Feb-2025 | 18:06 | x64 |
| Batchparser.dll | 2019.150.4430.1 | 165928 | 21-Feb-2025 | 18:06 | x86 |
| Commanddest.dll | 2019.150.4430.1 | 264272 | 21-Feb-2025 | 18:06 | x64 |
| Datacollectortasks.dll | 2019.150.4430.1 | 227392 | 21-Feb-2025 | 18:06 | x64 |
| Distrib.exe | 2019.150.4430.1 | 243720 | 21-Feb-2025 | 18:06 | x64 |
| Dteparse.dll | 2019.150.4430.1 | 124984 | 21-Feb-2025 | 18:06 | x64 |
| Dteparsemgd.dll | 2019.150.4430.1 | 133184 | 21-Feb-2025 | 18:06 | x64 |
| Dtepkg.dll | 2019.150.4430.1 | 149544 | 21-Feb-2025 | 18:06 | x64 |
| Dtexec.exe | 2019.150.4430.1 | 73808 | 21-Feb-2025 | 18:06 | x64 |
| Dts.dll | 2019.150.4430.1 | 3143744 | 21-Feb-2025 | 18:06 | x64 |
| Dtscomexpreval.dll | 2019.150.4430.1 | 501768 | 21-Feb-2025 | 18:06 | x64 |
| Dtsconn.dll | 2019.150.4430.1 | 522248 | 21-Feb-2025 | 18:06 | x64 |
| Dtshost.exe | 2019.150.4430.1 | 107536 | 21-Feb-2025 | 18:06 | x64 |
| Dtsmsg150.dll | 2019.150.4430.1 | 567360 | 21-Feb-2025 | 18:06 | x64 |
| Dtspipeline.dll | 2019.150.4430.1 | 1329216 | 21-Feb-2025 | 18:06 | x64 |
| Dtswizard.exe | 15.0.4430.1 | 886824 | 21-Feb-2025 | 18:06 | x64 |
| Dtuparse.dll | 2019.150.4430.1 | 100416 | 21-Feb-2025 | 18:06 | x64 |
| Dtutil.exe | 2019.150.4430.1 | 151080 | 21-Feb-2025 | 18:06 | x64 |
| Exceldest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:06 | x64 |
| Excelsrc.dll | 2019.150.4430.1 | 309296 | 21-Feb-2025 | 18:06 | x64 |
| Execpackagetask.dll | 2019.150.4430.1 | 186448 | 21-Feb-2025 | 18:06 | x64 |
| Flatfiledest.dll | 2019.150.4430.1 | 411688 | 21-Feb-2025 | 18:06 | x64 |
| Flatfilesrc.dll | 2019.150.4430.1 | 428064 | 21-Feb-2025 | 18:06 | x64 |
| Logread.exe | 2019.150.4430.1 | 722984 | 21-Feb-2025 | 18:06 | x64 |
| Mergetxt.dll | 2019.150.4430.1 | 75840 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4430.1 | 59456 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4430.1 | 43064 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 15.0.4430.1 | 391232 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.replication.dll | 2019.150.4430.1 | 1697832 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.sqlserver.replication.dll | 2019.150.4430.1 | 1640504 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.rmo.dll | 15.0.4430.1 | 550952 | 21-Feb-2025 | 18:06 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 178256 | 21-Feb-2025 | 18:06 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 194640 | 21-Feb-2025 | 18:06 | x64 |
| Msdtssrvrutil.dll | 2019.150.4430.1 | 112704 | 21-Feb-2025 | 18:06 | x64 |
| Msgprox.dll | 2019.150.4430.1 | 301136 | 21-Feb-2025 | 18:06 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 2750472 | 21-Feb-2025 | 18:06 | x64 |
| Msoledbsql.dll | 2018.187.4.0 | 153608 | 21-Feb-2025 | 18:06 | x64 |
| Msxmlsql.dll | 2019.150.4430.1 | 1497112 | 21-Feb-2025 | 18:06 | x64 |
| Oledbdest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:06 | x64 |
| Oledbsrc.dll | 2019.150.4430.1 | 313408 | 21-Feb-2025 | 18:06 | x64 |
| Osql.exe | 2019.150.4430.1 | 92216 | 21-Feb-2025 | 18:06 | x64 |
| Qrdrsvc.exe | 2019.150.4430.1 | 501824 | 21-Feb-2025 | 18:06 | x64 |
| Rawdest.dll | 2019.150.4430.1 | 227344 | 21-Feb-2025 | 18:06 | x64 |
| Rawsource.dll | 2019.150.4430.1 | 211024 | 21-Feb-2025 | 18:06 | x64 |
| Rdistcom.dll | 2019.150.4430.1 | 915512 | 21-Feb-2025 | 18:06 | x64 |
| Recordsetdest.dll | 2019.150.4430.1 | 202832 | 21-Feb-2025 | 18:06 | x64 |
| Repldp.dll | 2019.150.4430.1 | 313352 | 21-Feb-2025 | 18:06 | x64 |
| Replerrx.dll | 2019.150.4430.1 | 182352 | 21-Feb-2025 | 18:06 | x64 |
| Replisapi.dll | 2019.150.4430.1 | 395344 | 21-Feb-2025 | 18:06 | x64 |
| Replmerg.exe | 2019.150.4430.1 | 563232 | 21-Feb-2025 | 18:06 | x64 |
| Replprov.dll | 2019.150.4430.1 | 862232 | 21-Feb-2025 | 18:06 | x64 |
| Replrec.dll | 2019.150.4430.1 | 1034320 | 21-Feb-2025 | 18:06 | x64 |
| Replsub.dll | 2019.150.4430.1 | 473168 | 21-Feb-2025 | 18:06 | x64 |
| Replsync.dll | 2019.150.4430.1 | 165952 | 21-Feb-2025 | 18:06 | x64 |
| Spresolv.dll | 2019.150.4430.1 | 276560 | 21-Feb-2025 | 18:06 | x64 |
| Sqlcmd.exe | 2019.150.4430.1 | 264216 | 21-Feb-2025 | 18:06 | x64 |
| Sqldiag.exe | 2019.150.4430.1 | 1140808 | 21-Feb-2025 | 18:06 | x64 |
| Sqldistx.dll | 2019.150.4430.1 | 251976 | 21-Feb-2025 | 18:06 | x64 |
| Sqllogship.exe | 15.0.4430.1 | 104496 | 21-Feb-2025 | 18:06 | x64 |
| Sqlmergx.dll | 2019.150.4430.1 | 399424 | 21-Feb-2025 | 18:06 | x64 |
| Sqlnclirda11.dll | 2011.110.5069.66 | 3478208 | 21-Feb-2025 | 18:06 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 51232 | 21-Feb-2025 | 18:06 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 38968 | 21-Feb-2025 | 18:06 | x86 |
| Sqlscm.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:06 | x64 |
| Sqlscm.dll | 2019.150.4430.1 | 79912 | 21-Feb-2025 | 18:06 | x86 |
| Sqlsvc.dll | 2019.150.4430.1 | 182352 | 21-Feb-2025 | 18:06 | x64 |
| Sqlsvc.dll | 2019.150.4430.1 | 149568 | 21-Feb-2025 | 18:06 | x86 |
| Sqltaskconnections.dll | 2019.150.4430.1 | 206896 | 21-Feb-2025 | 18:06 | x64 |
| Ssradd.dll | 2019.150.4430.1 | 84032 | 21-Feb-2025 | 18:06 | x64 |
| Ssravg.dll | 2019.150.4430.1 | 84048 | 21-Feb-2025 | 18:06 | x64 |
| Ssrdown.dll | 2019.150.4430.1 | 75800 | 21-Feb-2025 | 18:06 | x64 |
| Ssrmax.dll | 2019.150.4430.1 | 84032 | 21-Feb-2025 | 18:06 | x64 |
| Ssrmin.dll | 2019.150.4430.1 | 84008 | 21-Feb-2025 | 18:06 | x64 |
| Ssrpub.dll | 2019.150.4430.1 | 79952 | 21-Feb-2025 | 18:06 | x64 |
| Ssrup.dll | 2019.150.4430.1 | 75824 | 21-Feb-2025 | 18:06 | x64 |
| Txagg.dll | 2019.150.4430.1 | 391248 | 21-Feb-2025 | 18:06 | x64 |
| Txbdd.dll | 2019.150.4430.1 | 190504 | 21-Feb-2025 | 18:06 | x64 |
| Txdatacollector.dll | 2019.150.4430.1 | 473152 | 21-Feb-2025 | 18:06 | x64 |
| Txdataconvert.dll | 2019.150.4430.1 | 317504 | 21-Feb-2025 | 18:06 | x64 |
| Txderived.dll | 2019.150.4430.1 | 641064 | 21-Feb-2025 | 18:06 | x64 |
| Txlookup.dll | 2019.150.4430.1 | 542784 | 21-Feb-2025 | 18:06 | x64 |
| Txmerge.dll | 2019.150.4430.1 | 247872 | 21-Feb-2025 | 18:06 | x64 |
| Txmergejoin.dll | 2019.150.4430.1 | 309328 | 21-Feb-2025 | 18:06 | x64 |
| Txmulticast.dll | 2019.150.4430.1 | 149560 | 21-Feb-2025 | 18:06 | x64 |
| Txrowcount.dll | 2019.150.4430.1 | 141392 | 21-Feb-2025 | 18:06 | x64 |
| Txsort.dll | 2019.150.4430.1 | 288800 | 21-Feb-2025 | 18:06 | x64 |
| Txsplit.dll | 2019.150.4430.1 | 624648 | 21-Feb-2025 | 18:06 | x64 |
| Txunionall.dll | 2019.150.4430.1 | 198688 | 21-Feb-2025 | 18:06 | x64 |
| Xe.dll | 2019.150.4430.1 | 718912 | 21-Feb-2025 | 18:06 | x64 |
| Xmlsub.dll | 2019.150.4430.1 | 297024 | 21-Feb-2025 | 18:06 | x64 |

SQL Server 2019 sql_extensibility

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commonlauncher.dll | 2019.150.4430.1 | 96312 | 21-Feb-2025 | 18:06 | x64 |
| Exthost.exe | 2019.150.4430.1 | 239680 | 21-Feb-2025 | 18:06 | x64 |
| Launchpad.exe | 2019.150.4430.1 | 1230928 | 21-Feb-2025 | 18:06 | x64 |
| Sqlsatellite.dll | 2019.150.4430.1 | 1026088 | 21-Feb-2025 | 18:06 | x64 |

SQL Server 2019 Full-Text Engine

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Fd.dll | 2019.150.4430.1 | 686088 | 21-Feb-2025 | 18:06 | x64 |
| Fdhost.exe | 2019.150.4430.1 | 129104 | 21-Feb-2025 | 18:06 | x64 |
| Fdlauncher.exe | 2019.150.4430.1 | 79944 | 21-Feb-2025 | 18:06 | x64 |
| Sqlft150ph.dll | 2019.150.4430.1 | 92224 | 21-Feb-2025 | 18:06 | x64 |

SQL Server 2019 sql_inst_mr

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Imrdll.dll | 15.0.4430.1 | 30800 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 Integration Services

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Commanddest.dll | 2019.150.4430.1 | 264272 | 21-Feb-2025 | 18:11 | x64 |
| Commanddest.dll | 2019.150.4430.1 | 227368 | 21-Feb-2025 | 18:11 | x86 |
| Dteparse.dll | 2019.150.4430.1 | 112656 | 21-Feb-2025 | 18:11 | x86 |
| Dteparse.dll | 2019.150.4430.1 | 124984 | 21-Feb-2025 | 18:11 | x64 |
| Dteparsemgd.dll | 2019.150.4430.1 | 116792 | 21-Feb-2025 | 18:11 | x86 |
| Dteparsemgd.dll | 2019.150.4430.1 | 133184 | 21-Feb-2025 | 18:11 | x64 |
| Dtepkg.dll | 2019.150.4430.1 | 133160 | 21-Feb-2025 | 18:11 | x86 |
| Dtepkg.dll | 2019.150.4430.1 | 149544 | 21-Feb-2025 | 18:11 | x64 |
| Dtexec.exe | 2019.150.4430.1 | 65064 | 21-Feb-2025 | 18:11 | x86 |
| Dtexec.exe | 2019.150.4430.1 | 73808 | 21-Feb-2025 | 18:11 | x64 |
| Dts.dll | 2019.150.4430.1 | 2762808 | 21-Feb-2025 | 18:11 | x86 |
| Dts.dll | 2019.150.4430.1 | 3143744 | 21-Feb-2025 | 18:11 | x64 |
| Dtscomexpreval.dll | 2019.150.4430.1 | 444432 | 21-Feb-2025 | 18:11 | x86 |
| Dtscomexpreval.dll | 2019.150.4430.1 | 501768 | 21-Feb-2025 | 18:11 | x64 |
| Dtsconn.dll | 2019.150.4430.1 | 432168 | 21-Feb-2025 | 18:11 | x86 |
| Dtsconn.dll | 2019.150.4430.1 | 522248 | 21-Feb-2025 | 18:11 | x64 |
| Dtsdebughost.exe | 2019.150.4430.1 | 94760 | 21-Feb-2025 | 18:11 | x86 |
| Dtsdebughost.exe | 2019.150.4430.1 | 113208 | 21-Feb-2025 | 18:11 | x64 |
| Dtshost.exe | 2019.150.4430.1 | 89656 | 21-Feb-2025 | 18:11 | x86 |
| Dtshost.exe | 2019.150.4430.1 | 107536 | 21-Feb-2025 | 18:11 | x64 |
| Dtsmsg150.dll | 2019.150.4430.1 | 555056 | 21-Feb-2025 | 18:11 | x86 |
| Dtsmsg150.dll | 2019.150.4430.1 | 567360 | 21-Feb-2025 | 18:11 | x64 |
| Dtspipeline.dll | 2019.150.4430.1 | 1120296 | 21-Feb-2025 | 18:11 | x86 |
| Dtspipeline.dll | 2019.150.4430.1 | 1329216 | 21-Feb-2025 | 18:11 | x64 |
| Dtswizard.exe | 15.0.4430.1 | 890904 | 21-Feb-2025 | 18:11 | x86 |
| Dtswizard.exe | 15.0.4430.1 | 886824 | 21-Feb-2025 | 18:11 | x64 |
| Dtuparse.dll | 2019.150.4430.1 | 88104 | 21-Feb-2025 | 18:11 | x86 |
| Dtuparse.dll | 2019.150.4430.1 | 100416 | 21-Feb-2025 | 18:11 | x64 |
| Dtutil.exe | 2019.150.4430.1 | 130600 | 21-Feb-2025 | 18:11 | x86 |
| Dtutil.exe | 2019.150.4430.1 | 151080 | 21-Feb-2025 | 18:11 | x64 |
| Exceldest.dll | 2019.150.4430.1 | 235576 | 21-Feb-2025 | 18:11 | x86 |
| Exceldest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:11 | x64 |
| Excelsrc.dll | 2019.150.4430.1 | 260152 | 21-Feb-2025 | 18:11 | x86 |
| Excelsrc.dll | 2019.150.4430.1 | 309296 | 21-Feb-2025 | 18:11 | x64 |
| Execpackagetask.dll | 2019.150.4430.1 | 149560 | 21-Feb-2025 | 18:11 | x86 |
| Execpackagetask.dll | 2019.150.4430.1 | 186448 | 21-Feb-2025 | 18:11 | x64 |
| Flatfiledest.dll | 2019.150.4430.1 | 358440 | 21-Feb-2025 | 18:11 | x86 |
| Flatfiledest.dll | 2019.150.4430.1 | 411688 | 21-Feb-2025 | 18:11 | x64 |
| Flatfilesrc.dll | 2019.150.4430.1 | 370704 | 21-Feb-2025 | 18:11 | x86 |
| Flatfilesrc.dll | 2019.150.4430.1 | 428064 | 21-Feb-2025 | 18:11 | x64 |
| Isdbupgradewizard.exe | 15.0.4430.1 | 120864 | 21-Feb-2025 | 18:11 | x86 |
| Isdbupgradewizard.exe | 15.0.4430.1 | 120888 | 21-Feb-2025 | 18:11 | x86 |
| Isserverexec.exe | 15.0.4430.1 | 145464 | 21-Feb-2025 | 18:11 | x64 |
| Isserverexec.exe | 15.0.4430.1 | 149584 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.astasks.dll | 15.0.4430.1 | 116816 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4430.1 | 59456 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4430.1 | 59448 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4430.1 | 510008 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4430.1 | 509992 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4430.1 | 43064 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.maintenanceplantasks.dll | 15.0.4430.1 | 391232 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4430.1 | 59432 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4430.1 | 59448 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.scripttask.dll | 15.0.4430.1 | 141376 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.scripttask.dll | 15.0.4430.1 | 141392 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 157704 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 178256 | 21-Feb-2025 | 18:11 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 174112 | 21-Feb-2025 | 18:11 | x86 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 194640 | 21-Feb-2025 | 18:11 | x64 |
| Msdtssrvr.exe | 15.0.4430.1 | 219200 | 21-Feb-2025 | 18:11 | x64 |
| Msdtssrvrutil.dll | 2019.150.4430.1 | 100392 | 21-Feb-2025 | 18:11 | x86 |
| Msdtssrvrutil.dll | 2019.150.4430.1 | 112704 | 21-Feb-2025 | 18:11 | x64 |
| Msmdpp.dll | 2018.150.35.51 | 10062896 | 21-Feb-2025 | 18:06 | x64 |
| Odbcdest.dll | 2019.150.4430.1 | 321576 | 21-Feb-2025 | 18:11 | x86 |
| Odbcdest.dll | 2019.150.4430.1 | 370752 | 21-Feb-2025 | 18:11 | x64 |
| Odbcsrc.dll | 2019.150.4430.1 | 329768 | 21-Feb-2025 | 18:11 | x86 |
| Odbcsrc.dll | 2019.150.4430.1 | 383048 | 21-Feb-2025 | 18:11 | x64 |
| Oledbdest.dll | 2019.150.4430.1 | 239656 | 21-Feb-2025 | 18:11 | x86 |
| Oledbdest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:11 | x64 |
| Oledbsrc.dll | 2019.150.4430.1 | 264224 | 21-Feb-2025 | 18:11 | x86 |
| Oledbsrc.dll | 2019.150.4430.1 | 313408 | 21-Feb-2025 | 18:11 | x64 |
| Rawdest.dll | 2019.150.4430.1 | 190496 | 21-Feb-2025 | 18:11 | x86 |
| Rawdest.dll | 2019.150.4430.1 | 227344 | 21-Feb-2025 | 18:11 | x64 |
| Rawsource.dll | 2019.150.4430.1 | 178240 | 21-Feb-2025 | 18:11 | x86 |
| Rawsource.dll | 2019.150.4430.1 | 211024 | 21-Feb-2025 | 18:11 | x64 |
| Recordsetdest.dll | 2019.150.4430.1 | 202832 | 21-Feb-2025 | 18:11 | x64 |
| Recordsetdest.dll | 2019.150.4430.1 | 174120 | 21-Feb-2025 | 18:11 | x86 |
| Sqlceip.exe | 15.0.4430.1 | 297000 | 21-Feb-2025 | 18:11 | x86 |
| Sqldest.dll | 2019.150.4430.1 | 239672 | 21-Feb-2025 | 18:11 | x86 |
| Sqldest.dll | 2019.150.4430.1 | 276520 | 21-Feb-2025 | 18:11 | x64 |
| Sqltaskconnections.dll | 2019.150.4430.1 | 170024 | 21-Feb-2025 | 18:11 | x86 |
| Sqltaskconnections.dll | 2019.150.4430.1 | 206896 | 21-Feb-2025 | 18:11 | x64 |
| Txagg.dll | 2019.150.4430.1 | 329768 | 21-Feb-2025 | 18:11 | x86 |
| Txagg.dll | 2019.150.4430.1 | 391248 | 21-Feb-2025 | 18:11 | x64 |
| Txbdd.dll | 2019.150.4430.1 | 153640 | 21-Feb-2025 | 18:11 | x86 |
| Txbdd.dll | 2019.150.4430.1 | 190504 | 21-Feb-2025 | 18:11 | x64 |
| Txbestmatch.dll | 2019.150.4430.1 | 546824 | 21-Feb-2025 | 18:11 | x86 |
| Txbestmatch.dll | 2019.150.4430.1 | 653376 | 21-Feb-2025 | 18:11 | x64 |
| Txcache.dll | 2019.150.4430.1 | 165944 | 21-Feb-2025 | 18:11 | x86 |
| Txcache.dll | 2019.150.4430.1 | 211024 | 21-Feb-2025 | 18:11 | x64 |
| Txcharmap.dll | 2019.150.4430.1 | 272440 | 21-Feb-2025 | 18:11 | x86 |
| Txcharmap.dll | 2019.150.4430.1 | 313424 | 21-Feb-2025 | 18:11 | x64 |
| Txcopymap.dll | 2019.150.4430.1 | 165944 | 21-Feb-2025 | 18:11 | x86 |
| Txcopymap.dll | 2019.150.4430.1 | 198696 | 21-Feb-2025 | 18:11 | x64 |
| Txdataconvert.dll | 2019.150.4430.1 | 276512 | 21-Feb-2025 | 18:11 | x86 |
| Txdataconvert.dll | 2019.150.4430.1 | 317504 | 21-Feb-2025 | 18:11 | x64 |
| Txderived.dll | 2019.150.4430.1 | 559128 | 21-Feb-2025 | 18:11 | x86 |
| Txderived.dll | 2019.150.4430.1 | 641064 | 21-Feb-2025 | 18:11 | x64 |
| Txfileextractor.dll | 2019.150.4430.1 | 182312 | 21-Feb-2025 | 18:11 | x86 |
| Txfileextractor.dll | 2019.150.4430.1 | 219216 | 21-Feb-2025 | 18:11 | x64 |
| Txfileinserter.dll | 2019.150.4430.1 | 182312 | 21-Feb-2025 | 18:11 | x86 |
| Txfileinserter.dll | 2019.150.4430.1 | 215080 | 21-Feb-2025 | 18:11 | x64 |
| Txgroupdups.dll | 2019.150.4430.1 | 256040 | 21-Feb-2025 | 18:11 | x86 |
| Txgroupdups.dll | 2019.150.4430.1 | 313408 | 21-Feb-2025 | 18:11 | x64 |
| Txlineage.dll | 2019.150.4430.1 | 129064 | 21-Feb-2025 | 18:11 | x86 |
| Txlineage.dll | 2019.150.4430.1 | 153664 | 21-Feb-2025 | 18:11 | x64 |
| Txlookup.dll | 2019.150.4430.1 | 469000 | 21-Feb-2025 | 18:11 | x86 |
| Txlookup.dll | 2019.150.4430.1 | 542784 | 21-Feb-2025 | 18:11 | x64 |
| Txmerge.dll | 2019.150.4430.1 | 202808 | 21-Feb-2025 | 18:11 | x86 |
| Txmerge.dll | 2019.150.4430.1 | 247872 | 21-Feb-2025 | 18:11 | x64 |
| Txmergejoin.dll | 2019.150.4430.1 | 247840 | 21-Feb-2025 | 18:11 | x86 |
| Txmergejoin.dll | 2019.150.4430.1 | 309328 | 21-Feb-2025 | 18:11 | x64 |
| Txmulticast.dll | 2019.150.4430.1 | 116776 | 21-Feb-2025 | 18:11 | x86 |
| Txmulticast.dll | 2019.150.4430.1 | 149560 | 21-Feb-2025 | 18:11 | x64 |
| Txpivot.dll | 2019.150.4430.1 | 206904 | 21-Feb-2025 | 18:11 | x86 |
| Txpivot.dll | 2019.150.4430.1 | 239696 | 21-Feb-2025 | 18:11 | x64 |
| Txrowcount.dll | 2019.150.4430.1 | 112664 | 21-Feb-2025 | 18:11 | x86 |
| Txrowcount.dll | 2019.150.4430.1 | 141392 | 21-Feb-2025 | 18:11 | x64 |
| Txsampling.dll | 2019.150.4430.1 | 157752 | 21-Feb-2025 | 18:11 | x86 |
| Txsampling.dll | 2019.150.4430.1 | 194632 | 21-Feb-2025 | 18:11 | x64 |
| Txscd.dll | 2019.150.4430.1 | 198720 | 21-Feb-2025 | 18:11 | x86 |
| Txscd.dll | 2019.150.4430.1 | 235576 | 21-Feb-2025 | 18:11 | x64 |
| Txsort.dll | 2019.150.4430.1 | 231464 | 21-Feb-2025 | 18:11 | x86 |
| Txsort.dll | 2019.150.4430.1 | 288800 | 21-Feb-2025 | 18:11 | x64 |
| Txsplit.dll | 2019.150.4430.1 | 550968 | 21-Feb-2025 | 18:11 | x86 |
| Txsplit.dll | 2019.150.4430.1 | 624648 | 21-Feb-2025 | 18:11 | x64 |
| Txtermextraction.dll | 2019.150.4430.1 | 8644672 | 21-Feb-2025 | 18:11 | x86 |
| Txtermextraction.dll | 2019.150.4430.1 | 8701992 | 21-Feb-2025 | 18:11 | x64 |
| Txtermlookup.dll | 2019.150.4430.1 | 4139048 | 21-Feb-2025 | 18:11 | x86 |
| Txtermlookup.dll | 2019.150.4430.1 | 4184096 | 21-Feb-2025 | 18:11 | x64 |
| Txunionall.dll | 2019.150.4430.1 | 161848 | 21-Feb-2025 | 18:11 | x86 |
| Txunionall.dll | 2019.150.4430.1 | 198688 | 21-Feb-2025 | 18:11 | x64 |
| Txunpivot.dll | 2019.150.4430.1 | 182312 | 21-Feb-2025 | 18:11 | x86 |
| Txunpivot.dll | 2019.150.4430.1 | 215072 | 21-Feb-2025 | 18:11 | x64 |
| Xe.dll | 2019.150.4430.1 | 632896 | 21-Feb-2025 | 18:11 | x86 |
| Xe.dll | 2019.150.4430.1 | 718912 | 21-Feb-2025 | 18:11 | x64 |

SQL Server 2019 sql_polybase_core_inst

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Dms.dll | 15.0.1978.0 | 559696 | 21-Feb-2025 | 18:30 | x86 |
| Dmsnative.dll | 2018.150.1978.0 | 152624 | 21-Feb-2025 | 18:30 | x64 |
| Dwengineservice.dll | 15.0.1978.0 | 45120 | 21-Feb-2025 | 18:30 | x86 |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64 | 2.3.21.1023 | 18691056 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64 | 1.0.2.1003 | 147504 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64 | 2.3.8.1008 | 17142672 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64 | 1.0.2.1003 | 146304 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64 | 8.0.2.304 | 2532096 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64 | 8.0.2.2592 | 2425088 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64 | 8.0.2.2592 | 151808 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64 | 8.0.2.244 | 2416384 | 21-Feb-2025 | 18:30 | x64 |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64 | 8.0.2.216 | 2953472 | 21-Feb-2025 | 18:30 | x64 |
| Icudt58.dll | 58.2.0.0 | 27109768 | 21-Feb-2025 | 18:30 | x64 |
| Icudt58.dll | 58.2.0.0 | 27109832 | 21-Feb-2025 | 18:30 | x64 |
| Icudt58.dll | 58.3.0.0 | 27110344 | 21-Feb-2025 | 18:30 | x64 |
| Icuin58.dll | 58.2.0.0 | 2425288 | 21-Feb-2025 | 18:30 | x64 |
| Icuin58.dll | 58.2.0.0 | 2431880 | 21-Feb-2025 | 18:30 | x64 |
| Icuin58.dll | 58.3.0.0 | 2551752 | 21-Feb-2025 | 18:30 | x64 |
| Icuin58.dll | 58.3.0.0 | 2562504 | 21-Feb-2025 | 18:30 | x64 |
| Icuuc42.dll | 8.0.2.124 | 15491840 | 21-Feb-2025 | 18:30 | x64 |
| Icuuc58.dll | 58.2.0.0 | 1775048 | 21-Feb-2025 | 18:30 | x64 |
| Icuuc58.dll | 58.2.0.0 | 1783688 | 21-Feb-2025 | 18:30 | x64 |
| Icuuc58.dll | 58.3.0.0 | 1888712 | 21-Feb-2025 | 18:30 | x64 |
| Icuuc58.dll | 58.3.0.0 | 1924040 | 21-Feb-2025 | 18:30 | x64 |
| Instapi150.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:30 | x64 |
| Libcrypto-1_1-x64.dll | 1.1.0.10 | 2620304 | 21-Feb-2025 | 18:30 | x64 |
| Libcrypto | 1.1.1.4 | 2953680 | 21-Feb-2025 | 18:30 | x64 |
| Libcrypto | 1.1.1.11 | 4321232 | 21-Feb-2025 | 18:30 | x64 |
| Libcrypto | 1.1.1.14 | 4085336 | 21-Feb-2025 | 18:30 | x64 |
| Libsasl.dll | 2.1.26.0 | 292224 | 21-Feb-2025 | 18:30 | x64 |
| Libsasl.dll | 2.1.26.0 | 521664 | 21-Feb-2025 | 18:30 | x64 |
| Libssl-1_1-x64.dll | 1.1.0.10 | 648080 | 21-Feb-2025 | 18:30 | x64 |
| Libssl | 1.1.1.11 | 1322960 | 21-Feb-2025 | 18:30 | x64 |
| Libssl | 1.1.1.4 | 798160 | 21-Feb-2025 | 18:30 | x64 |
| Libssl | 1.1.1.14 | 1195600 | 21-Feb-2025 | 18:30 | x64 |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll | 15.0.1978.0 | 67664 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.catalog.dll | 15.0.1978.0 | 293456 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.common.dll | 15.0.1978.0 | 1957944 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.configuration.dll | 15.0.1978.0 | 169544 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll | 15.0.1978.0 | 649824 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll | 15.0.1978.0 | 246352 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll | 15.0.1978.0 | 139312 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1978.0 | 79968 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll | 15.0.1978.0 | 51280 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.distributor.dll | 15.0.1978.0 | 88632 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.dll | 15.0.1978.0 | 1129520 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll | 15.0.1978.0 | 80944 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.eventing.dll | 15.0.1978.0 | 70712 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll | 15.0.1978.0 | 35424 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll | 15.0.1978.0 | 31296 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll | 15.0.1978.0 | 46664 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll | 15.0.1978.0 | 21560 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.failover.dll | 15.0.1978.0 | 26704 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll | 15.0.1978.0 | 131632 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll | 15.0.1978.0 | 86584 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll | 15.0.1978.0 | 100912 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.dll | 15.0.1978.0 | 293456 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 120384 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 138296 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 141360 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 137776 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 150584 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 139840 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 134720 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 176720 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 117816 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll | 15.0.1978.0 | 136752 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.nodes.dll | 15.0.1978.0 | 72760 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll | 15.0.1978.0 | 22096 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll | 15.0.1978.0 | 37472 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll | 15.0.1978.0 | 129104 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.dll | 15.0.1978.0 | 3064912 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll | 15.0.1978.0 | 3955760 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 118368 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 133216 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 137784 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 133688 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 148544 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 134192 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 130656 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 171056 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 115280 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll | 15.0.1978.0 | 132168 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll | 15.0.1978.0 | 67640 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll | 15.0.1978.0 | 2682928 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.datawarehouse.utilities.dll | 15.0.1978.0 | 2436656 | 21-Feb-2025 | 18:30 | x86 |
| Microsoft.sqlserver.xe.core.dll | 2019.150.4430.1 | 84008 | 21-Feb-2025 | 18:30 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 178256 | 21-Feb-2025 | 18:30 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 194640 | 21-Feb-2025 | 18:30 | x64 |
| Mpdwinterop.dll | 2019.150.4430.1 | 452648 | 21-Feb-2025 | 18:30 | x64 |
| Mpdwsvc.exe | 2019.150.4430.1 | 7407672 | 21-Feb-2025 | 18:30 | x64 |
| Msodbcsql17.dll | 2017.174.1.1 | 2016120 | 21-Feb-2025 | 18:30 | x64 |
| Odbc32.dll | 10.0.17763.1 | 720792 | 21-Feb-2025 | 18:30 | x64 |
| Odbccp32.dll | 10.0.17763.1 | 138136 | 21-Feb-2025 | 18:30 | x64 |
| Odbctrac.dll | 10.0.17763.1 | 175000 | 21-Feb-2025 | 18:30 | x64 |
| Saslplain.dll | 2.1.26.0 | 170880 | 21-Feb-2025 | 18:30 | x64 |
| Saslplain.dll | 2.1.26.0 | 377792 | 21-Feb-2025 | 18:30 | x64 |
| Secforwarder.dll | 2019.150.4430.1 | 79936 | 21-Feb-2025 | 18:30 | x64 |
| Sharedmemory.dll | 2018.150.1978.0 | 61488 | 21-Feb-2025 | 18:30 | x64 |
| Sqldk.dll | 2019.150.4430.1 | 3180584 | 21-Feb-2025 | 18:30 | x64 |
| Sqldumper.exe | 2019.150.4430.1 | 378960 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 1599544 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4175920 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3422264 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4167736 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4073552 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 2226240 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 2177104 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3831848 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 3827776 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 1542184 | 21-Feb-2025 | 18:30 | x64 |
| Sqlevn70.rll | 2019.150.4430.1 | 4040768 | 21-Feb-2025 | 18:30 | x64 |
| Sqlncli17e.dll | 2017.1710.6.1 | 1898520 | 21-Feb-2025 | 18:30 | x64 |
| Sqlos.dll | 2019.150.4430.1 | 43032 | 21-Feb-2025 | 18:30 | x64 |
| Sqlsortpdw.dll | 2018.150.1978.0 | 4841536 | 21-Feb-2025 | 18:30 | x64 |
| Sqltses.dll | 2019.150.4430.1 | 9119784 | 21-Feb-2025 | 18:30 | x64 |
| Tdataodbc_sb | 16.20.0.1078 | 14995920 | 21-Feb-2025 | 18:30 | x64 |
| Tdataodbc_sb | 17.0.0.27 | 12914640 | 21-Feb-2025 | 18:30 | x64 |
| Terasso.dll | 16.20.0.13 | 2158896 | 21-Feb-2025 | 18:30 | x64 |
| Terasso.dll | 17.0.0.28 | 2357064 | 21-Feb-2025 | 18:30 | x64 |
| Zlibwapi.dll | 1.2.11.0 | 281472 | 21-Feb-2025 | 18:30 | x64 |
| Zlibwapi.dll | 1.2.11.0 | 499248 | 21-Feb-2025 | 18:30 | x64 |

SQL Server 2019 sql_shared_mr

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Smrdll.dll | 15.0.4430.1 | 30760 | 21-Feb-2025 | 18:06 | x86 |

SQL Server 2019 sql_tools_extensions

| File name | File version | File size | Date | Time | Platform |
| --- | --- | --- | --- | --- | --- |
| Autoadmin.dll | 2019.150.4430.1 | 1632296 | 21-Feb-2025 | 18:46 | x86 |
| Dtaengine.exe | 2019.150.4430.1 | 219184 | 21-Feb-2025 | 18:46 | x86 |
| Dteparse.dll | 2019.150.4430.1 | 124984 | 21-Feb-2025 | 18:46 | x64 |
| Dteparse.dll | 2019.150.4430.1 | 112656 | 21-Feb-2025 | 18:46 | x86 |
| Dteparsemgd.dll | 2019.150.4430.1 | 133184 | 21-Feb-2025 | 18:46 | x64 |
| Dteparsemgd.dll | 2019.150.4430.1 | 116792 | 21-Feb-2025 | 18:46 | x86 |
| Dtepkg.dll | 2019.150.4430.1 | 149544 | 21-Feb-2025 | 18:46 | x64 |
| Dtepkg.dll | 2019.150.4430.1 | 133160 | 21-Feb-2025 | 18:46 | x86 |
| Dtexec.exe | 2019.150.4430.1 | 73808 | 21-Feb-2025 | 18:46 | x64 |
| Dtexec.exe | 2019.150.4430.1 | 65064 | 21-Feb-2025 | 18:46 | x86 |
| Dts.dll | 2019.150.4430.1 | 3143744 | 21-Feb-2025 | 18:46 | x64 |
| Dts.dll | 2019.150.4430.1 | 2762808 | 21-Feb-2025 | 18:46 | x86 |
| Dtscomexpreval.dll | 2019.150.4430.1 | 501768 | 21-Feb-2025 | 18:46 | x64 |
| Dtscomexpreval.dll | 2019.150.4430.1 | 444432 | 21-Feb-2025 | 18:46 | x86 |
| Dtsconn.dll | 2019.150.4430.1 | 522248 | 21-Feb-2025 | 18:46 | x64 |
| Dtsconn.dll | 2019.150.4430.1 | 432168 | 21-Feb-2025 | 18:46 | x86 |
| Dtshost.exe | 2019.150.4430.1 | 107536 | 21-Feb-2025 | 18:46 | x64 |
| Dtshost.exe | 2019.150.4430.1 | 89656 | 21-Feb-2025 | 18:46 | x86 |
| Dtsmsg150.dll | 2019.150.4430.1 | 567360 | 21-Feb-2025 | 18:46 | x64 |
| Dtsmsg150.dll | 2019.150.4430.1 | 555056 | 21-Feb-2025 | 18:46 | x86 |
| Dtspipeline.dll | 2019.150.4430.1 | 1329216 | 21-Feb-2025 | 18:46 | x64 |
| Dtspipeline.dll | 2019.150.4430.1 | 1120296 | 21-Feb-2025 | 18:46 | x86 |
| Dtswizard.exe | 15.0.4430.1 | 886824 | 21-Feb-2025 | 18:46 | x64 |
| Dtswizard.exe | 15.0.4430.1 | 890904 | 21-Feb-2025 | 18:46 | x86 |
| Dtuparse.dll | 2019.150.4430.1 | 100416 | 21-Feb-2025 | 18:46 | x64 |
| Dtuparse.dll | 2019.150.4430.1 | 88104 | 21-Feb-2025 | 18:46 | x86 |
| Dtutil.exe | 2019.150.4430.1 | 130600 | 21-Feb-2025 | 18:46 | x86 |
| Dtutil.exe | 2019.150.4430.1 | 151080 | 21-Feb-2025 | 18:46 | x64 |
| Exceldest.dll | 2019.150.4430.1 | 235576 | 21-Feb-2025 | 18:46 | x86 |
| Exceldest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:46 | x64 |
| Excelsrc.dll | 2019.150.4430.1 | 260152 | 21-Feb-2025 | 18:46 | x86 |
| Excelsrc.dll | 2019.150.4430.1 | 309296 | 21-Feb-2025 | 18:46 | x64 |
| Flatfiledest.dll | 2019.150.4430.1 | 358440 | 21-Feb-2025 | 18:46 | x86 |
| Flatfiledest.dll | 2019.150.4430.1 | 411688 | 21-Feb-2025 | 18:46 | x64 |
| Flatfilesrc.dll | 2019.150.4430.1 | 370704 | 21-Feb-2025 | 18:46 | x86 |
| Flatfilesrc.dll | 2019.150.4430.1 | 428064 | 21-Feb-2025 | 18:46 | x64 |
| Microsoft.sqlserver.astasks.dll | 15.0.4430.1 | 116800 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4430.1 | 403512 | 21-Feb-2025 | 18:39 | x86 |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4430.1 | 403536 | 21-Feb-2025 | 18:39 | x86 |
| Microsoft.sqlserver.configuration.sco.dll | 15.0.4430.1 | 3004456 | 21-Feb-2025 | 18:39 | x86 |
| Microsoft.sqlserver.configuration.sco.dll | 15.0.4430.1 | 3004432 | 21-Feb-2025 | 18:39 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4430.1 | 43064 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4430.1 | 43064 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 15.0.4430.1 | 59448 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.olapenum.dll | 15.0.18185.0 | 100800 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 178256 | 21-Feb-2025 | 18:46 | x64 |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4430.1 | 157704 | 21-Feb-2025 | 18:46 | x86 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 194640 | 21-Feb-2025 | 18:46 | x64 |
| Microsoft.sqlserver.xevent.dll | 2019.150.4430.1 | 174112 | 21-Feb-2025 | 18:46 | x86 |
| Msdtssrvrutil.dll | 2019.150.4430.1 | 112704 | 21-Feb-2025 | 18:46 | x64 |
| Msdtssrvrutil.dll | 2019.150.4430.1 | 100392 | 21-Feb-2025 | 18:46 | x86 |
| Msmgdsrv.dll | 2018.150.35.51 | 8280112 | 21-Feb-2025 | 18:39 | x86 |
| Oledbdest.dll | 2019.150.4430.1 | 239656 | 21-Feb-2025 | 18:46 | x86 |
| Oledbdest.dll | 2019.150.4430.1 | 280656 | 21-Feb-2025 | 18:46 | x64 |
| Oledbsrc.dll | 2019.150.4430.1 | 264224 | 21-Feb-2025 | 18:46 | x86 |
| Oledbsrc.dll | 2019.150.4430.1 | 313408 | 21-Feb-2025 | 18:46 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 51232 | 21-Feb-2025 | 18:46 | x64 |
| Sqlresourceloader.dll | 2019.150.4430.1 | 38968 | 21-Feb-2025 | 18:46 | x86 |
| Sqlscm.dll | 2019.150.4430.1 | 88128 | 21-Feb-2025 | 18:46 | x64 |
| Sqlscm.dll | 2019.150.4430.1 | 79912 | 21-Feb-2025 | 18:46 | x86 |
| Sqlsvc.dll | 2019.150.4430.1 | 182352 | 21-Feb-2025 | 18:46 | x64 |
| Sqlsvc.dll | 2019.150.4430.1 | 149568 | 21-Feb-2025 | 18:46 | x86 |
| Sqltaskconnections.dll | 2019.150.4430.1 | 206896 | 21-Feb-2025 | 18:46 | x64 |
| Sqltaskconnections.dll | 2019.150.4430.1 | 170024 | 21-Feb-2025 | 18:46 | x86 |
| Txdataconvert.dll | 2019.150.4430.1 | 276512 | 21-Feb-2025 | 18:46 | x86 |
| Txdataconvert.dll | 2019.150.4430.1 | 317504 | 21-Feb-2025 | 18:46 | x64 |
| Xe.dll | 2019.150.4430.1 | 632896 | 21-Feb-2025 | 18:46 | x86 |
| Xe.dll | 2019.150.4430.1 | 718912 | 21-Feb-2025 | 18:46 | x64 |

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

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

  > [!NOTE]
  > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances)
- [Overview of SQL Server Servicing Installation](/sql/database-engine/install-windows/install-sql-server-servicing-updates)

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

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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
