---
title: Cumulative update 30 for SQL Server 2019 (KB5049235)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 30 (KB5049235).
ms.date: 12/12/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5049235
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5049235 - Cumulative Update 30 for SQL Server 2019

_Release Date:_ &nbsp; December 12, 2024  
_Version:_ &nbsp; 15.0.4415.2

## Summary

This article describes Cumulative Update package 30 (CU30) for Microsoft SQL Server 2019. This update contains 8 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 29, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4415.2**, file version: **2019.150.4415.2**
- Analysis Services - Product version: **15.0.35.51**, file version: **2018.150.35.51**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion-context-2019](../includes/av-sesssion-context-2019.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=3588885>[3588885](#3588885) </a> | Fixes a data discrepancy issue that you encounter when extracting data for Google BigQuery by using the Simba ODBC driver. | Integration Services | Integration Services| Windows|
| <a id=3542238>[3542238](#3542238) </a> | Reduces the `HADR_SYNC_COMMIT` waits caused by the delay between the `log_block_pushed_to_pool` and `hadr_log_block_capture` steps in Always On availability group data movement under certain workloads.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3560254>[3560254](#3560254) </a> | Fixes an issue in which some availability group (AG) databases are in a non-synchronized state after the Windows Server Failover Clustering (WSFC) quorum loss. After applying the fix, the databases should be able to switch to a resolving state when the persisted configuration data can't be read because of the WSFC quorum loss. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=3487110>[3487110](#3487110) </a> | Fixes an issue that causes database corruption if a system failure with `alternatewritethrough` mode occurs. | SQL Server Engine| Linux | Linux|
| <a id=3420397>[3420397](#3420397) </a> | Fixes an issue in which running queries with columnstore indexes is stuck because of non-yielding scheduler errors.| SQL Server Engine| SQL OS| Windows|
| <a id=3514743>[3514743](#3514743) </a> | Fixes various assertion failures (for example, Location: sosmerge.cpp:2930; Expression: mrP->mrpgcnt > 0) that you might encounter when building an index in simple or bulk-logged recovery models with indirect checkpoints because of missing flushes of intermediate data pages.| SQL Server Engine| SQL OS| All|
| <a id=3545173>[3545173](#3545173) </a> | Fixes an issue in which remote code executions might be performed by using a dynamic-link library (DLL) planting technique on a SQL Server instance. | SQL Server Engine| SQL OS| Windows|
| <a id=3545179>[3545179](#3545179) </a> | Fixes an issue in which a vulnerability in a SQL Server assembly might allow remote code execution.| SQL Server Engine| SQL OS| Windows|

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU30 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5049235)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5049235-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5049235-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5049235-x64.exe| 25707A8487E4B170D257BF8070D247946B36DF4ABDCD110874AC394857586D4D |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.51  | 292912    | 18-Nov-2024 | 18:04 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.51      | 758344    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 175680    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 199728    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 202296    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 198704    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 215088    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 197680    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 193584    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 252464    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 174120    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.51      | 197160    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.51      | 1098840   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.51      | 567344    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 54856     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 59440     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 59992     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 62024     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58304     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58440     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 67656     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 53696     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.51      | 58440     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17992     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17976     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 19032     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.51      | 17968     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 18-Nov-2024 | 18:04 | x86      |
| Msmdctr.dll                                               | 2018.150.35.51  | 38472     | 18-Nov-2024 | 18:04 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.51  | 47784504  | 18-Nov-2024 | 18:04 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.51  | 66261560  | 18-Nov-2024 | 18:04 | x64      |
| Msmdpump.dll                                              | 2018.150.35.51  | 10187312  | 18-Nov-2024 | 18:04 | x64      |
| Msmdredir.dll                                             | 2018.150.35.51  | 7957576   | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16952     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17456     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17464     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17480     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 17464     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 18488     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16960     | 18-Nov-2024 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.51      | 16944     | 18-Nov-2024 | 18:04 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.51  | 65799240  | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 833592    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1628208   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1454144   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1643056   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1608752   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1001520   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 992808    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1537080   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1521712   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 811056    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.51  | 1596472   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 832568    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1624624   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1451064   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1637936   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1604656   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 998968    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 991280    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1532976   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1518136   | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 810040    | 18-Nov-2024 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.51  | 1591848   | 18-Nov-2024 | 18:04 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.51  | 8280112   | 18-Nov-2024 | 18:04 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.51  | 10186288  | 18-Nov-2024 | 18:04 | x64      |
| Msolap.dll                                                | 2018.150.35.51  | 8607168   | 18-Nov-2024 | 18:04 | x86      |
| Msolap.dll                                                | 2018.150.35.51  | 11013184  | 18-Nov-2024 | 18:04 | x64      |
| Msolui.dll                                                | 2018.150.35.51  | 286256    | 18-Nov-2024 | 18:04 | x86      |
| Msolui.dll                                                | 2018.150.35.51  | 306624    | 18-Nov-2024 | 18:04 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 18-Nov-2024 | 18:04 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 18-Nov-2024 | 18:04 | x64      |
| Sqlboot.dll                                               | 2019.150.4415.2 | 215120    | 18-Nov-2024 | 18:04 | x64      |
| Sqlceip.exe                                               | 15.0.4415.2     | 297000    | 18-Nov-2024 | 18:04 | x86      |
| Sqldumper.exe                                             | 2019.150.4415.2 | 321592    | 18-Nov-2024 | 18:04 | x86      |
| Sqldumper.exe                                             | 2019.150.4415.2 | 378960    | 18-Nov-2024 | 18:04 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 18-Nov-2024 | 18:04 | x86      |
| Tbb.dll                                                   | 2019.0.2019.410 | 442688    | 18-Nov-2024 | 18:04 | x64      |
| Tbbmalloc.dll                                             | 2019.0.2019.410 | 270144    | 18-Nov-2024 | 18:04 | x64      |
| Tmapi.dll                                                 | 2018.150.35.51  | 6178352   | 18-Nov-2024 | 18:04 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.51  | 4917808   | 18-Nov-2024 | 18:04 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.51  | 1184816   | 18-Nov-2024 | 18:04 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.51  | 6807088   | 18-Nov-2024 | 18:04 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.51  | 26025544  | 18-Nov-2024 | 18:04 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.51  | 35460152  | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4415.2 | 165944    | 18-Nov-2024 | 18:35 | x86      |
| Batchparser.dll                      | 2019.150.4415.2 | 182312    | 18-Nov-2024 | 18:35 | x64      |
| Instapi150.dll                       | 2019.150.4415.2 | 75856     | 18-Nov-2024 | 17:58 | x86      |
| Instapi150.dll                       | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 17:58 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4415.2 | 104504    | 18-Nov-2024 | 18:35 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4415.2 | 88144     | 18-Nov-2024 | 18:35 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4415.2     | 550976    | 18-Nov-2024 | 18:35 | x86      |
| Msasxpress.dll                       | 2018.150.35.51  | 27184     | 18-Nov-2024 | 17:58 | x86      |
| Msasxpress.dll                       | 2018.150.35.51  | 32304     | 18-Nov-2024 | 17:58 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4415.2 | 75840     | 18-Nov-2024 | 18:35 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4415.2 | 92240     | 18-Nov-2024 | 18:35 | x64      |
| Sqldumper.exe                        | 2019.150.4415.2 | 321592    | 18-Nov-2024 | 17:57 | x86      |
| Sqldumper.exe                        | 2019.150.4415.2 | 378960    | 18-Nov-2024 | 17:58 | x64      |
| Sqlftacct.dll                        | 2019.150.4415.2 | 59472     | 18-Nov-2024 | 18:35 | x86      |
| Sqlftacct.dll                        | 2019.150.4415.2 | 79936     | 18-Nov-2024 | 18:35 | x64      |
| Sqlmanager.dll                       | 2019.150.4415.2 | 743464    | 18-Nov-2024 | 18:35 | x86      |
| Sqlmanager.dll                       | 2019.150.4415.2 | 878632    | 18-Nov-2024 | 18:35 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4415.2 | 378960    | 18-Nov-2024 | 18:35 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4415.2 | 432184    | 18-Nov-2024 | 18:35 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4415.2 | 276544    | 18-Nov-2024 | 18:35 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4415.2 | 358480    | 18-Nov-2024 | 18:35 | x64      |
| Svrenumapi150.dll                    | 2019.150.4415.2 | 1161296   | 18-Nov-2024 | 18:35 | x64      |
| Svrenumapi150.dll                    | 2019.150.4415.2 | 911440    | 18-Nov-2024 | 18:35 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4415.2  | 600144    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4415.2  | 600120    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4415.2  | 1857616   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4415.2  | 1857592   | 18-Nov-2024 | 18:04 | x86      |
| Dqsinstaller.exe          | 15.0.4415.2  | 2771024   | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4415.2 | 137296    | 18-Nov-2024 | 18:04 | x86      |
| Dreplaycommon.dll     | 2019.150.4415.2 | 667704    | 18-Nov-2024 | 18:04 | x86      |
| Dreplayutil.dll       | 2019.150.4415.2 | 305192    | 18-Nov-2024 | 18:04 | x86      |
| Instapi150.dll        | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 18:04 | x64      |
| Sqlresourceloader.dll | 2019.150.4415.2 | 38992     | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |     Date    |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4415.2 | 667704    | 18-Nov-2024 | 18:04 | x86      |
| Dreplaycontroller.exe | 2019.150.4415.2 | 366632    | 18-Nov-2024 | 18:04 | x86      |
| Instapi150.dll        | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 18:04 | x64      |
| Sqlresourceloader.dll | 2019.150.4415.2 | 38992     | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2019.150.4415.2 | 4658232   | 18-Nov-2024 | 19:02 | x64      |
| Aetm-enclave.dll                             | 2019.150.4415.2 | 4612648   | 18-Nov-2024 | 19:02 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2019.150.4415.2 | 4932056   | 18-Nov-2024 | 19:02 | x64      |
| Aetm-sgx-enclave.dll                         | 2019.150.4415.2 | 4873696   | 18-Nov-2024 | 19:02 | x64      |
| Azureattest.dll                              | 10.0.18965.1000 | 255056    | 18-Nov-2024 | 19:02 | x64      |
| Azureattestmanager.dll                       | 10.0.18965.1000 | 97528     | 18-Nov-2024 | 19:02 | x64      |
| Batchparser.dll                              | 2019.150.4415.2 | 182312    | 18-Nov-2024 | 19:02 | x64      |
| C1.dll                                       | 19.16.27034.0   | 2438520   | 18-Nov-2024 | 19:02 | x64      |
| C2.dll                                       | 19.16.27034.0   | 7239032   | 18-Nov-2024 | 19:02 | x64      |
| Cl.exe                                       | 19.16.27034.0   | 424360    | 18-Nov-2024 | 19:02 | x64      |
| Clui.dll                                     | 19.16.27034.0   | 541048    | 18-Nov-2024 | 19:02 | x64      |
| Datacollectorcontroller.dll                  | 2019.150.4415.2 | 280616    | 18-Nov-2024 | 19:02 | x64      |
| Dcexec.exe                                   | 2019.150.4415.2 | 88104     | 18-Nov-2024 | 19:02 | x64      |
| Fssres.dll                                   | 2019.150.4415.2 | 96312     | 18-Nov-2024 | 19:02 | x64      |
| Hadrres.dll                                  | 2019.150.4415.2 | 206904    | 18-Nov-2024 | 19:02 | x64      |
| Hkcompile.dll                                | 2019.150.4415.2 | 1292344   | 18-Nov-2024 | 19:02 | x64      |
| Hkengine.dll                                 | 2019.150.4415.2 | 5793872   | 18-Nov-2024 | 19:02 | x64      |
| Hkruntime.dll                                | 2019.150.4415.2 | 182328    | 18-Nov-2024 | 19:02 | x64      |
| Hktempdb.dll                                 | 2019.150.4415.2 | 63544     | 18-Nov-2024 | 19:02 | x64      |
| Link.exe                                     | 14.16.27034.0   | 1707936   | 18-Nov-2024 | 19:02 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 15.0.4415.2     | 235600    | 18-Nov-2024 | 19:02 | x86      |
| Microsoft.sqlserver.types.dll                | 2019.150.4415.2 | 391208    | 18-Nov-2024 | 19:02 | x86      |
| Microsoft.sqlserver.xe.core.dll              | 2019.150.4415.2 | 84048     | 18-Nov-2024 | 19:02 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2019.150.4415.2 | 178256    | 18-Nov-2024 | 19:02 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2019.150.4415.2 | 194640    | 18-Nov-2024 | 19:02 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2019.150.4415.2 | 325712    | 18-Nov-2024 | 19:02 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2019.150.4415.2 | 92216     | 18-Nov-2024 | 19:02 | x64      |
| Msobj140.dll                                 | 14.16.27034.0   | 134008    | 18-Nov-2024 | 19:02 | x64      |
| Mspdb140.dll                                 | 14.16.27034.0   | 632184    | 18-Nov-2024 | 19:02 | x64      |
| Mspdbcore.dll                                | 14.16.27034.0   | 632184    | 18-Nov-2024 | 19:02 | x64      |
| Msvcp140.dll                                 | 14.16.27034.0   | 628200    | 18-Nov-2024 | 19:02 | x64      |
| Qds.dll                                      | 2019.150.4415.2 | 1189968   | 18-Nov-2024 | 19:02 | x64      |
| Rsfxft.dll                                   | 2019.150.4415.2 | 51264     | 18-Nov-2024 | 19:02 | x64      |
| Secforwarder.dll                             | 2019.150.4415.2 | 79912     | 18-Nov-2024 | 19:02 | x64      |
| Sqagtres.dll                                 | 2019.150.4415.2 | 88144     | 18-Nov-2024 | 19:02 | x64      |
| Sqlaamss.dll                                 | 2019.150.4415.2 | 108600    | 18-Nov-2024 | 19:02 | x64      |
| Sqlaccess.dll                                | 2019.150.4415.2 | 493632    | 18-Nov-2024 | 19:02 | x64      |
| Sqlagent.exe                                 | 2019.150.4415.2 | 731192    | 18-Nov-2024 | 19:02 | x64      |
| Sqlagentctr150.dll                           | 2019.150.4415.2 | 71736     | 18-Nov-2024 | 19:02 | x86      |
| Sqlagentctr150.dll                           | 2019.150.4415.2 | 79928     | 18-Nov-2024 | 19:02 | x64      |
| Sqlboot.dll                                  | 2019.150.4415.2 | 215120    | 18-Nov-2024 | 19:02 | x64      |
| Sqlceip.exe                                  | 15.0.4415.2     | 297000    | 18-Nov-2024 | 19:02 | x86      |
| Sqlcmdss.dll                                 | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 19:02 | x64      |
| Sqlctr150.dll                                | 2019.150.4415.2 | 116776    | 18-Nov-2024 | 19:02 | x86      |
| Sqlctr150.dll                                | 2019.150.4415.2 | 145488    | 18-Nov-2024 | 19:02 | x64      |
| Sqldk.dll                                    | 2019.150.4415.2 | 3176528   | 18-Nov-2024 | 19:02 | x64      |
| Sqldtsss.dll                                 | 2019.150.4415.2 | 108624    | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 1599552   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3508304   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3704912   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4175952   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4290624   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3422288   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3590224   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4167744   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4020304   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4073536   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 2226256   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 2177088   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3881024   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3553360   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4024384   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3831872   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3827776   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3622976   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3508304   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 1542224   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 3917904   | 18-Nov-2024 | 19:02 | x64      |
| Sqlevn70.rll                                 | 2019.150.4415.2 | 4040768   | 18-Nov-2024 | 19:02 | x64      |
| Sqllang.dll                                  | 2019.150.4415.2 | 40077368  | 18-Nov-2024 | 19:02 | x64      |
| Sqlmin.dll                                   | 2019.150.4415.2 | 40655440  | 18-Nov-2024 | 19:02 | x64      |
| Sqlolapss.dll                                | 2019.150.4415.2 | 108600    | 18-Nov-2024 | 19:02 | x64      |
| Sqlos.dll                                    | 2019.150.4415.2 | 43088     | 18-Nov-2024 | 19:02 | x64      |
| Sqlpowershellss.dll                          | 2019.150.4415.2 | 84008     | 18-Nov-2024 | 19:02 | x64      |
| Sqlrepss.dll                                 | 2019.150.4415.2 | 88104     | 18-Nov-2024 | 19:02 | x64      |
| Sqlresourceloader.dll                        | 2019.150.4415.2 | 51256     | 18-Nov-2024 | 19:02 | x64      |
| Sqlscm.dll                                   | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 19:02 | x64      |
| Sqlscriptdowngrade.dll                       | 2019.150.4415.2 | 38992     | 18-Nov-2024 | 19:02 | x64      |
| Sqlscriptupgrade.dll                         | 2019.150.4415.2 | 5810256   | 18-Nov-2024 | 19:02 | x64      |
| Sqlserverspatial150.dll                      | 2019.150.4415.2 | 673832    | 18-Nov-2024 | 19:02 | x64      |
| Sqlservr.exe                                 | 2019.150.4415.2 | 628816    | 18-Nov-2024 | 19:02 | x64      |
| Sqlsvc.dll                                   | 2019.150.4415.2 | 182352    | 18-Nov-2024 | 19:02 | x64      |
| Sqltses.dll                                  | 2019.150.4415.2 | 9119800   | 18-Nov-2024 | 19:02 | x64      |
| Sqsrvres.dll                                 | 2019.150.4415.2 | 280616    | 18-Nov-2024 | 19:02 | x64      |
| Stretchcodegen.exe                           | 15.0.4415.2     | 59472     | 18-Nov-2024 | 19:02 | x86      |
| Svl.dll                                      | 2019.150.4415.2 | 161856    | 18-Nov-2024 | 19:02 | x64      |
| Vcruntime140.dll                             | 14.16.27034.0   | 85992     | 18-Nov-2024 | 19:02 | x64      |
| Xe.dll                                       | 2019.150.4415.2 | 718928    | 18-Nov-2024 | 19:02 | x64      |
| Xpadsi.exe                                   | 2019.150.4415.2 | 116792    | 18-Nov-2024 | 19:02 | x64      |
| Xplog70.dll                                  | 2019.150.4415.2 | 92224     | 18-Nov-2024 | 19:02 | x64      |
| Xpqueue.dll                                  | 2019.150.4415.2 | 92216     | 18-Nov-2024 | 19:02 | x64      |
| Xprepl.dll                                   | 2019.150.4415.2 | 120888    | 18-Nov-2024 | 19:02 | x64      |
| Xpstar.dll                                   | 2019.150.4415.2 | 473152    | 18-Nov-2024 | 19:02 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version   | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4415.2  | 182312    | 18-Nov-2024 | 18:00 | x64      |
| Batchparser.dll                                              | 2019.150.4415.2  | 165944    | 18-Nov-2024 | 18:00 | x86      |
| Commanddest.dll                                              | 2019.150.4415.2  | 264272    | 18-Nov-2024 | 18:00 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4415.2  | 231504    | 18-Nov-2024 | 18:04 | x64      |
| Distrib.exe                                                  | 2019.150.4415.2  | 243768    | 18-Nov-2024 | 18:04 | x64      |
| Dteparse.dll                                                 | 2019.150.4415.2  | 125008    | 18-Nov-2024 | 18:00 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4415.2  | 133200    | 18-Nov-2024 | 18:00 | x64      |
| Dtepkg.dll                                                   | 2019.150.4415.2  | 149584    | 18-Nov-2024 | 18:00 | x64      |
| Dtexec.exe                                                   | 2019.150.4415.2  | 73792     | 18-Nov-2024 | 18:00 | x64      |
| Dts.dll                                                      | 2019.150.4415.2  | 3143736   | 18-Nov-2024 | 18:00 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4415.2  | 501840    | 18-Nov-2024 | 18:00 | x64      |
| Dtsconn.dll                                                  | 2019.150.4415.2  | 522320    | 18-Nov-2024 | 18:00 | x64      |
| Dtshost.exe                                                  | 2019.150.4415.2  | 107584    | 18-Nov-2024 | 18:00 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4415.2  | 567376    | 18-Nov-2024 | 18:00 | x64      |
| Dtspipeline.dll                                              | 2019.150.4415.2  | 1329232   | 18-Nov-2024 | 18:00 | x64      |
| Dtswizard.exe                                                | 15.0.4415.2      | 886824    | 18-Nov-2024 | 18:00 | x64      |
| Dtuparse.dll                                                 | 2019.150.4415.2  | 100432    | 18-Nov-2024 | 18:00 | x64      |
| Dtutil.exe                                                   | 2019.150.4415.2  | 151120    | 18-Nov-2024 | 18:00 | x64      |
| Exceldest.dll                                                | 2019.150.4415.2  | 280656    | 18-Nov-2024 | 18:00 | x64      |
| Excelsrc.dll                                                 | 2019.150.4415.2  | 309328    | 18-Nov-2024 | 18:00 | x64      |
| Execpackagetask.dll                                          | 2019.150.4415.2  | 186432    | 18-Nov-2024 | 18:00 | x64      |
| Flatfiledest.dll                                             | 2019.150.4415.2  | 411728    | 18-Nov-2024 | 18:00 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4415.2  | 428112    | 18-Nov-2024 | 18:00 | x64      |
| Logread.exe                                                  | 2019.150.4415.2  | 723000    | 18-Nov-2024 | 18:04 | x64      |
| Mergetxt.dll                                                 | 2019.150.4415.2  | 75816     | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4415.2      | 59432     | 18-Nov-2024 | 18:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4415.2      | 43064     | 18-Nov-2024 | 18:00 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4415.2      | 391248    | 18-Nov-2024 | 18:00 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4415.2  | 1697832   | 18-Nov-2024 | 18:04 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4415.2  | 1640528   | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4415.2      | 550976    | 18-Nov-2024 | 18:04 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2019.150.4415.2  | 178256    | 18-Nov-2024 | 18:00 | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2019.150.4415.2  | 194640    | 18-Nov-2024 | 18:00 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4415.2  | 112704    | 18-Nov-2024 | 18:00 | x64      |
| Msgprox.dll                                                  | 2019.150.4415.2  | 301112    | 18-Nov-2024 | 18:04 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 2750472   | 18-Nov-2024 | 18:04 | x64      |
| Msoledbsql.dll                                               | 2018.187.4.0     | 153608    | 18-Nov-2024 | 18:04 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4415.2  | 1497168   | 18-Nov-2024 | 18:04 | x64      |
| Oledbdest.dll                                                | 2019.150.4415.2  | 280640    | 18-Nov-2024 | 18:00 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4415.2  | 313424    | 18-Nov-2024 | 18:00 | x64      |
| Osql.exe                                                     | 2019.150.4415.2  | 92240     | 18-Nov-2024 | 18:04 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4415.2  | 501816    | 18-Nov-2024 | 18:04 | x64      |
| Rawdest.dll                                                  | 2019.150.4415.2  | 227408    | 18-Nov-2024 | 18:00 | x64      |
| Rawsource.dll                                                | 2019.150.4415.2  | 210984    | 18-Nov-2024 | 18:00 | x64      |
| Rdistcom.dll                                                 | 2019.150.4415.2  | 915496    | 18-Nov-2024 | 18:04 | x64      |
| Recordsetdest.dll                                            | 2019.150.4415.2  | 202832    | 18-Nov-2024 | 18:00 | x64      |
| Repldp.dll                                                   | 2019.150.4415.2  | 313400    | 18-Nov-2024 | 18:04 | x64      |
| Replerrx.dll                                                 | 2019.150.4415.2  | 182328    | 18-Nov-2024 | 18:04 | x64      |
| Replisapi.dll                                                | 2019.150.4415.2  | 395344    | 18-Nov-2024 | 18:04 | x64      |
| Replmerg.exe                                                 | 2019.150.4415.2  | 563240    | 18-Nov-2024 | 18:04 | x64      |
| Replprov.dll                                                 | 2019.150.4415.2  | 862288    | 18-Nov-2024 | 18:04 | x64      |
| Replrec.dll                                                  | 2019.150.4415.2  | 1034296   | 18-Nov-2024 | 18:04 | x64      |
| Replsub.dll                                                  | 2019.150.4415.2  | 473144    | 18-Nov-2024 | 18:04 | x64      |
| Replsync.dll                                                 | 2019.150.4415.2  | 165944    | 18-Nov-2024 | 18:04 | x64      |
| Spresolv.dll                                                 | 2019.150.4415.2  | 276536    | 18-Nov-2024 | 18:04 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4415.2  | 264256    | 18-Nov-2024 | 18:04 | x64      |
| Sqldiag.exe                                                  | 2019.150.4415.2  | 1140792   | 18-Nov-2024 | 18:04 | x64      |
| Sqldistx.dll                                                 | 2019.150.4415.2  | 251960    | 18-Nov-2024 | 18:04 | x64      |
| Sqllogship.exe                                               | 15.0.4415.2      | 104528    | 18-Nov-2024 | 18:04 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4415.2  | 399416    | 18-Nov-2024 | 18:04 | x64      |
| Sqlnclirda11.dll                                             | 2011.110.5069.66 | 3478208   | 18-Nov-2024 | 18:04 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4415.2  | 38992     | 18-Nov-2024 | 18:04 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4415.2  | 51256     | 18-Nov-2024 | 18:04 | x64      |
| Sqlscm.dll                                                   | 2019.150.4415.2  | 79912     | 18-Nov-2024 | 18:04 | x86      |
| Sqlscm.dll                                                   | 2019.150.4415.2  | 88120     | 18-Nov-2024 | 18:04 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4415.2  | 149560    | 18-Nov-2024 | 18:04 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4415.2  | 182352    | 18-Nov-2024 | 18:04 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4415.2  | 202792    | 18-Nov-2024 | 18:00 | x64      |
| Ssradd.dll                                                   | 2019.150.4415.2  | 84008     | 18-Nov-2024 | 18:04 | x64      |
| Ssravg.dll                                                   | 2019.150.4415.2  | 84024     | 18-Nov-2024 | 18:04 | x64      |
| Ssrdown.dll                                                  | 2019.150.4415.2  | 75832     | 18-Nov-2024 | 18:04 | x64      |
| Ssrmax.dll                                                   | 2019.150.4415.2  | 84024     | 18-Nov-2024 | 18:04 | x64      |
| Ssrmin.dll                                                   | 2019.150.4415.2  | 84024     | 18-Nov-2024 | 18:04 | x64      |
| Ssrpub.dll                                                   | 2019.150.4415.2  | 79928     | 18-Nov-2024 | 18:04 | x64      |
| Ssrup.dll                                                    | 2019.150.4415.2  | 75832     | 18-Nov-2024 | 18:04 | x64      |
| Txagg.dll                                                    | 2019.150.4415.2  | 391248    | 18-Nov-2024 | 18:00 | x64      |
| Txbdd.dll                                                    | 2019.150.4415.2  | 194624    | 18-Nov-2024 | 18:00 | x64      |
| Txdatacollector.dll                                          | 2019.150.4415.2  | 473168    | 18-Nov-2024 | 18:04 | x64      |
| Txdataconvert.dll                                            | 2019.150.4415.2  | 317520    | 18-Nov-2024 | 18:00 | x64      |
| Txderived.dll                                                | 2019.150.4415.2  | 641104    | 18-Nov-2024 | 18:00 | x64      |
| Txlookup.dll                                                 | 2019.150.4415.2  | 542760    | 18-Nov-2024 | 18:00 | x64      |
| Txmerge.dll                                                  | 2019.150.4415.2  | 247888    | 18-Nov-2024 | 18:00 | x64      |
| Txmergejoin.dll                                              | 2019.150.4415.2  | 309312    | 18-Nov-2024 | 18:00 | x64      |
| Txmulticast.dll                                              | 2019.150.4415.2  | 145472    | 18-Nov-2024 | 18:00 | x64      |
| Txrowcount.dll                                               | 2019.150.4415.2  | 141376    | 18-Nov-2024 | 18:00 | x64      |
| Txsort.dll                                                   | 2019.150.4415.2  | 288848    | 18-Nov-2024 | 18:00 | x64      |
| Txsplit.dll                                                  | 2019.150.4415.2  | 624720    | 18-Nov-2024 | 18:00 | x64      |
| Txunionall.dll                                               | 2019.150.4415.2  | 198736    | 18-Nov-2024 | 18:00 | x64      |
| Xe.dll                                                       | 2019.150.4415.2  | 718928    | 18-Nov-2024 | 18:00 | x64      |
| Xmlsub.dll                                                   | 2019.150.4415.2  | 297000    | 18-Nov-2024 | 18:04 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |     Date    |  Time | Platform |
|:------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4415.2 | 96336     | 18-Nov-2024 | 18:04 | x64      |
| Exthost.exe        | 2019.150.4415.2 | 239696    | 18-Nov-2024 | 18:04 | x64      |
| Launchpad.exe      | 2019.150.4415.2 | 1230928   | 18-Nov-2024 | 18:04 | x64      |
| Sqlsatellite.dll   | 2019.150.4415.2 | 1026112   | 18-Nov-2024 | 18:04 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |     Date    |  Time | Platform |
|:--------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4415.2 | 686120    | 18-Nov-2024 | 18:04 | x64      |
| Fdhost.exe     | 2019.150.4415.2 | 129088    | 18-Nov-2024 | 18:04 | x64      |
| Fdlauncher.exe | 2019.150.4415.2 | 79928     | 18-Nov-2024 | 18:04 | x64      |
| Sqlft150ph.dll | 2019.150.4415.2 | 92224     | 18-Nov-2024 | 18:04 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4415.2  | 30776     | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4415.2 | 264272    | 18-Nov-2024 | 18:18 | x64      |
| Commanddest.dll                                               | 2019.150.4415.2 | 227384    | 18-Nov-2024 | 18:19 | x86      |
| Dteparse.dll                                                  | 2019.150.4415.2 | 112720    | 18-Nov-2024 | 18:19 | x86      |
| Dteparse.dll                                                  | 2019.150.4415.2 | 125008    | 18-Nov-2024 | 18:19 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4415.2 | 116792    | 18-Nov-2024 | 18:19 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4415.2 | 133200    | 18-Nov-2024 | 18:19 | x64      |
| Dtepkg.dll                                                    | 2019.150.4415.2 | 133200    | 18-Nov-2024 | 18:19 | x86      |
| Dtepkg.dll                                                    | 2019.150.4415.2 | 149584    | 18-Nov-2024 | 18:19 | x64      |
| Dtexec.exe                                                    | 2019.150.4415.2 | 65104     | 18-Nov-2024 | 18:19 | x86      |
| Dtexec.exe                                                    | 2019.150.4415.2 | 73792     | 18-Nov-2024 | 18:19 | x64      |
| Dts.dll                                                       | 2019.150.4415.2 | 2762792   | 18-Nov-2024 | 18:19 | x86      |
| Dts.dll                                                       | 2019.150.4415.2 | 3143736   | 18-Nov-2024 | 18:19 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4415.2 | 444496    | 18-Nov-2024 | 18:19 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4415.2 | 501840    | 18-Nov-2024 | 18:19 | x64      |
| Dtsconn.dll                                                   | 2019.150.4415.2 | 432208    | 18-Nov-2024 | 18:19 | x86      |
| Dtsconn.dll                                                   | 2019.150.4415.2 | 522320    | 18-Nov-2024 | 18:19 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4415.2 | 94800     | 18-Nov-2024 | 18:19 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4415.2 | 113232    | 18-Nov-2024 | 18:19 | x64      |
| Dtshost.exe                                                   | 2019.150.4415.2 | 89680     | 18-Nov-2024 | 18:19 | x86      |
| Dtshost.exe                                                   | 2019.150.4415.2 | 107584    | 18-Nov-2024 | 18:19 | x64      |
| Dtsmsg150.dll                                                 | 2019.150.4415.2 | 555072    | 18-Nov-2024 | 18:19 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4415.2 | 567376    | 18-Nov-2024 | 18:19 | x64      |
| Dtspipeline.dll                                               | 2019.150.4415.2 | 1120312   | 18-Nov-2024 | 18:19 | x86      |
| Dtspipeline.dll                                               | 2019.150.4415.2 | 1329232   | 18-Nov-2024 | 18:19 | x64      |
| Dtswizard.exe                                                 | 15.0.4415.2     | 890936    | 18-Nov-2024 | 18:19 | x86      |
| Dtswizard.exe                                                 | 15.0.4415.2     | 886824    | 18-Nov-2024 | 18:19 | x64      |
| Dtuparse.dll                                                  | 2019.150.4415.2 | 88128     | 18-Nov-2024 | 18:19 | x86      |
| Dtuparse.dll                                                  | 2019.150.4415.2 | 100432    | 18-Nov-2024 | 18:19 | x64      |
| Dtutil.exe                                                    | 2019.150.4415.2 | 130640    | 18-Nov-2024 | 18:19 | x86      |
| Dtutil.exe                                                    | 2019.150.4415.2 | 151120    | 18-Nov-2024 | 18:19 | x64      |
| Exceldest.dll                                                 | 2019.150.4415.2 | 235576    | 18-Nov-2024 | 18:19 | x86      |
| Exceldest.dll                                                 | 2019.150.4415.2 | 280656    | 18-Nov-2024 | 18:19 | x64      |
| Excelsrc.dll                                                  | 2019.150.4415.2 | 260176    | 18-Nov-2024 | 18:19 | x86      |
| Excelsrc.dll                                                  | 2019.150.4415.2 | 309328    | 18-Nov-2024 | 18:19 | x64      |
| Execpackagetask.dll                                           | 2019.150.4415.2 | 149560    | 18-Nov-2024 | 18:19 | x86      |
| Execpackagetask.dll                                           | 2019.150.4415.2 | 186432    | 18-Nov-2024 | 18:19 | x64      |
| Flatfiledest.dll                                              | 2019.150.4415.2 | 358464    | 18-Nov-2024 | 18:19 | x86      |
| Flatfiledest.dll                                              | 2019.150.4415.2 | 411728    | 18-Nov-2024 | 18:19 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4415.2 | 370752    | 18-Nov-2024 | 18:19 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4415.2 | 428112    | 18-Nov-2024 | 18:19 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4415.2     | 120912    | 18-Nov-2024 | 18:19 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4415.2     | 120888    | 18-Nov-2024 | 18:19 | x86      |
| Isserverexec.exe                                              | 15.0.4415.2     | 145464    | 18-Nov-2024 | 18:19 | x64      |
| Isserverexec.exe                                              | 15.0.4415.2     | 149568    | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4415.2     | 116816    | 18-Nov-2024 | 18:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4415.2     | 59432     | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4415.2     | 59472     | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4415.2     | 510032    | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4415.2     | 510008    | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4415.2     | 43064     | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4415.2     | 43088     | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4415.2     | 391248    | 18-Nov-2024 | 18:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4415.2     | 59456     | 18-Nov-2024 | 18:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4415.2     | 59448     | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4415.2     | 141376    | 18-Nov-2024 | 18:18 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4415.2     | 141368    | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2019.150.4415.2 | 157736    | 18-Nov-2024 | 18:18 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2019.150.4415.2 | 178256    | 18-Nov-2024 | 18:19 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2019.150.4415.2 | 174136    | 18-Nov-2024 | 18:19 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2019.150.4415.2 | 194640    | 18-Nov-2024 | 18:19 | x64      |
| Msdtssrvr.exe                                                 | 15.0.4415.2     | 219216    | 18-Nov-2024 | 18:19 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4415.2 | 100416    | 18-Nov-2024 | 18:19 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4415.2 | 112704    | 18-Nov-2024 | 18:19 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.51  | 10062896  | 18-Nov-2024 | 18:19 | x64      |
| Odbcdest.dll                                                  | 2019.150.4415.2 | 321616    | 18-Nov-2024 | 18:19 | x86      |
| Odbcdest.dll                                                  | 2019.150.4415.2 | 370768    | 18-Nov-2024 | 18:19 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4415.2 | 329784    | 18-Nov-2024 | 18:19 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4415.2 | 383056    | 18-Nov-2024 | 18:19 | x64      |
| Oledbdest.dll                                                 | 2019.150.4415.2 | 239672    | 18-Nov-2024 | 18:19 | x86      |
| Oledbdest.dll                                                 | 2019.150.4415.2 | 280640    | 18-Nov-2024 | 18:19 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4415.2 | 264272    | 18-Nov-2024 | 18:19 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4415.2 | 313424    | 18-Nov-2024 | 18:19 | x64      |
| Rawdest.dll                                                   | 2019.150.4415.2 | 227408    | 18-Nov-2024 | 18:18 | x64      |
| Rawdest.dll                                                   | 2019.150.4415.2 | 190544    | 18-Nov-2024 | 18:19 | x86      |
| Rawsource.dll                                                 | 2019.150.4415.2 | 210984    | 18-Nov-2024 | 18:18 | x64      |
| Rawsource.dll                                                 | 2019.150.4415.2 | 178256    | 18-Nov-2024 | 18:19 | x86      |
| Recordsetdest.dll                                             | 2019.150.4415.2 | 202832    | 18-Nov-2024 | 18:19 | x64      |
| Recordsetdest.dll                                             | 2019.150.4415.2 | 174160    | 18-Nov-2024 | 18:19 | x86      |
| Sqlceip.exe                                                   | 15.0.4415.2     | 297000    | 18-Nov-2024 | 18:19 | x86      |
| Sqldest.dll                                                   | 2019.150.4415.2 | 239680    | 18-Nov-2024 | 18:19 | x86      |
| Sqldest.dll                                                   | 2019.150.4415.2 | 276544    | 18-Nov-2024 | 18:19 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4415.2 | 170064    | 18-Nov-2024 | 18:19 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4415.2 | 202792    | 18-Nov-2024 | 18:19 | x64      |
| Txagg.dll                                                     | 2019.150.4415.2 | 329784    | 18-Nov-2024 | 18:19 | x86      |
| Txagg.dll                                                     | 2019.150.4415.2 | 391248    | 18-Nov-2024 | 18:19 | x64      |
| Txbdd.dll                                                     | 2019.150.4415.2 | 153680    | 18-Nov-2024 | 18:19 | x86      |
| Txbdd.dll                                                     | 2019.150.4415.2 | 194624    | 18-Nov-2024 | 18:19 | x64      |
| Txbestmatch.dll                                               | 2019.150.4415.2 | 546872    | 18-Nov-2024 | 18:19 | x86      |
| Txbestmatch.dll                                               | 2019.150.4415.2 | 653376    | 18-Nov-2024 | 18:19 | x64      |
| Txcache.dll                                                   | 2019.150.4415.2 | 165968    | 18-Nov-2024 | 18:19 | x86      |
| Txcache.dll                                                   | 2019.150.4415.2 | 198720    | 18-Nov-2024 | 18:19 | x64      |
| Txcharmap.dll                                                 | 2019.150.4415.2 | 272448    | 18-Nov-2024 | 18:19 | x86      |
| Txcharmap.dll                                                 | 2019.150.4415.2 | 313408    | 18-Nov-2024 | 18:19 | x64      |
| Txcopymap.dll                                                 | 2019.150.4415.2 | 174136    | 18-Nov-2024 | 18:19 | x86      |
| Txcopymap.dll                                                 | 2019.150.4415.2 | 198736    | 18-Nov-2024 | 18:19 | x64      |
| Txdataconvert.dll                                             | 2019.150.4415.2 | 276536    | 18-Nov-2024 | 18:19 | x86      |
| Txdataconvert.dll                                             | 2019.150.4415.2 | 317520    | 18-Nov-2024 | 18:19 | x64      |
| Txderived.dll                                                 | 2019.150.4415.2 | 559160    | 18-Nov-2024 | 18:19 | x86      |
| Txderived.dll                                                 | 2019.150.4415.2 | 641104    | 18-Nov-2024 | 18:19 | x64      |
| Txfileextractor.dll                                           | 2019.150.4415.2 | 182336    | 18-Nov-2024 | 18:19 | x86      |
| Txfileextractor.dll                                           | 2019.150.4415.2 | 219216    | 18-Nov-2024 | 18:19 | x64      |
| Txfileinserter.dll                                            | 2019.150.4415.2 | 182352    | 18-Nov-2024 | 18:19 | x86      |
| Txfileinserter.dll                                            | 2019.150.4415.2 | 215120    | 18-Nov-2024 | 18:19 | x64      |
| Txgroupdups.dll                                               | 2019.150.4415.2 | 256056    | 18-Nov-2024 | 18:19 | x86      |
| Txgroupdups.dll                                               | 2019.150.4415.2 | 313408    | 18-Nov-2024 | 18:19 | x64      |
| Txlineage.dll                                                 | 2019.150.4415.2 | 129064    | 18-Nov-2024 | 18:19 | x86      |
| Txlineage.dll                                                 | 2019.150.4415.2 | 153680    | 18-Nov-2024 | 18:19 | x64      |
| Txlookup.dll                                                  | 2019.150.4415.2 | 469072    | 18-Nov-2024 | 18:19 | x86      |
| Txlookup.dll                                                  | 2019.150.4415.2 | 542760    | 18-Nov-2024 | 18:19 | x64      |
| Txmerge.dll                                                   | 2019.150.4415.2 | 206888    | 18-Nov-2024 | 18:19 | x86      |
| Txmerge.dll                                                   | 2019.150.4415.2 | 247888    | 18-Nov-2024 | 18:19 | x64      |
| Txmergejoin.dll                                               | 2019.150.4415.2 | 247848    | 18-Nov-2024 | 18:19 | x86      |
| Txmergejoin.dll                                               | 2019.150.4415.2 | 309312    | 18-Nov-2024 | 18:19 | x64      |
| Txmulticast.dll                                               | 2019.150.4415.2 | 116816    | 18-Nov-2024 | 18:19 | x86      |
| Txmulticast.dll                                               | 2019.150.4415.2 | 145472    | 18-Nov-2024 | 18:19 | x64      |
| Txpivot.dll                                                   | 2019.150.4415.2 | 206928    | 18-Nov-2024 | 18:19 | x86      |
| Txpivot.dll                                                   | 2019.150.4415.2 | 239696    | 18-Nov-2024 | 18:19 | x64      |
| Txrowcount.dll                                                | 2019.150.4415.2 | 112696    | 18-Nov-2024 | 18:19 | x86      |
| Txrowcount.dll                                                | 2019.150.4415.2 | 141376    | 18-Nov-2024 | 18:19 | x64      |
| Txsampling.dll                                                | 2019.150.4415.2 | 157776    | 18-Nov-2024 | 18:19 | x86      |
| Txsampling.dll                                                | 2019.150.4415.2 | 194640    | 18-Nov-2024 | 18:19 | x64      |
| Txscd.dll                                                     | 2019.150.4415.2 | 198736    | 18-Nov-2024 | 18:19 | x86      |
| Txscd.dll                                                     | 2019.150.4415.2 | 235600    | 18-Nov-2024 | 18:19 | x64      |
| Txsort.dll                                                    | 2019.150.4415.2 | 231488    | 18-Nov-2024 | 18:19 | x86      |
| Txsort.dll                                                    | 2019.150.4415.2 | 288848    | 18-Nov-2024 | 18:19 | x64      |
| Txsplit.dll                                                   | 2019.150.4415.2 | 550976    | 18-Nov-2024 | 18:19 | x86      |
| Txsplit.dll                                                   | 2019.150.4415.2 | 624720    | 18-Nov-2024 | 18:19 | x64      |
| Txtermextraction.dll                                          | 2019.150.4415.2 | 8644648   | 18-Nov-2024 | 18:19 | x86      |
| Txtermextraction.dll                                          | 2019.150.4415.2 | 8702008   | 18-Nov-2024 | 18:19 | x64      |
| Txtermlookup.dll                                              | 2019.150.4415.2 | 4139048   | 18-Nov-2024 | 18:19 | x86      |
| Txtermlookup.dll                                              | 2019.150.4415.2 | 4184144   | 18-Nov-2024 | 18:19 | x64      |
| Txunionall.dll                                                | 2019.150.4415.2 | 161856    | 18-Nov-2024 | 18:19 | x86      |
| Txunionall.dll                                                | 2019.150.4415.2 | 198736    | 18-Nov-2024 | 18:19 | x64      |
| Txunpivot.dll                                                 | 2019.150.4415.2 | 182312    | 18-Nov-2024 | 18:19 | x86      |
| Txunpivot.dll                                                 | 2019.150.4415.2 | 215120    | 18-Nov-2024 | 18:19 | x64      |
| Xe.dll                                                        | 2019.150.4415.2 | 632896    | 18-Nov-2024 | 18:19 | x86      |
| Xe.dll                                                        | 2019.150.4415.2 | 718928    | 18-Nov-2024 | 18:19 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1978.0     | 559696    | 18-Nov-2024 | 18:48 | x86      |
| Dmsnative.dll                                                        | 2018.150.1978.0 | 152624    | 18-Nov-2024 | 18:48 | x64      |
| Dwengineservice.dll                                                  | 15.0.1978.0     | 45120     | 18-Nov-2024 | 18:48 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 18-Nov-2024 | 18:48 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 18-Nov-2024 | 18:48 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 18-Nov-2024 | 18:48 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 18-Nov-2024 | 18:48 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 18-Nov-2024 | 18:48 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 18-Nov-2024 | 18:48 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 18-Nov-2024 | 18:48 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 18-Nov-2024 | 18:48 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 18-Nov-2024 | 18:48 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 18-Nov-2024 | 18:48 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 18-Nov-2024 | 18:48 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 18-Nov-2024 | 18:48 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 18-Nov-2024 | 18:48 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 18-Nov-2024 | 18:48 | x64      |
| Instapi150.dll                                                       | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 18:49 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 18-Nov-2024 | 18:48 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 18-Nov-2024 | 18:48 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 18-Nov-2024 | 18:48 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 18-Nov-2024 | 18:48 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 18-Nov-2024 | 18:48 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 18-Nov-2024 | 18:48 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 18-Nov-2024 | 18:48 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 18-Nov-2024 | 18:48 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 18-Nov-2024 | 18:48 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 18-Nov-2024 | 18:48 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1978.0     | 67664     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1978.0     | 293456    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1978.0     | 1957944   | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1978.0     | 169544    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1978.0     | 649824    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1978.0     | 246352    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1978.0     | 139312    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1978.0     | 79968     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1978.0     | 51280     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1978.0     | 88632     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1978.0     | 1129520   | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1978.0     | 80944     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1978.0     | 70712     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1978.0     | 35424     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1978.0     | 31296     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1978.0     | 46664     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1978.0     | 21560     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1978.0     | 26704     | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1978.0     | 131632    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1978.0     | 86584     | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1978.0     | 100912    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1978.0     | 293456    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 120384    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 138296    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 141360    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 137776    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 150584    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 139840    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 134720    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 176720    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 117816    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1978.0     | 136752    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1978.0     | 72760     | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1978.0     | 22096     | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1978.0     | 37472     | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1978.0     | 129104    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1978.0     | 3064912   | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1978.0     | 3955760   | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 118368    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 133216    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 137784    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 133688    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 148544    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 134192    | 18-Nov-2024 | 18:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 130656    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 171056    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 115280    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1978.0     | 132168    | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1978.0     | 67640     | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1978.0     | 2682928   | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1978.0     | 2436656   | 18-Nov-2024 | 18:48 | x86      |
| Microsoft.sqlserver.xe.core.dll                                      | 2019.150.4415.2 | 84048     | 18-Nov-2024 | 18:48 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                         | 2019.150.4415.2 | 178256    | 18-Nov-2024 | 18:48 | x64      |
| Microsoft.sqlserver.xevent.dll                                       | 2019.150.4415.2 | 194640    | 18-Nov-2024 | 18:48 | x64      |
| Mpdwinterop.dll                                                      | 2019.150.4415.2 | 452664    | 18-Nov-2024 | 18:48 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4415.2 | 7407696   | 18-Nov-2024 | 18:48 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 18-Nov-2024 | 18:48 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 18-Nov-2024 | 18:48 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 18-Nov-2024 | 18:48 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 18-Nov-2024 | 18:48 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 18-Nov-2024 | 18:48 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 18-Nov-2024 | 18:48 | x64      |
| Secforwarder.dll                                                     | 2019.150.4415.2 | 79912     | 18-Nov-2024 | 18:48 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1978.0 | 61488     | 18-Nov-2024 | 18:48 | x64      |
| Sqldk.dll                                                            | 2019.150.4415.2 | 3176528   | 18-Nov-2024 | 18:48 | x64      |
| Sqldumper.exe                                                        | 2019.150.4415.2 | 378960    | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 1599552   | 18-Nov-2024 | 18:49 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 4175952   | 18-Nov-2024 | 18:49 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 3422288   | 18-Nov-2024 | 18:49 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 4167744   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 4073536   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 2226256   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 2177088   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 3831872   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 3827776   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 1542224   | 18-Nov-2024 | 18:48 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4415.2 | 4040768   | 18-Nov-2024 | 18:48 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 18-Nov-2024 | 18:48 | x64      |
| Sqlos.dll                                                            | 2019.150.4415.2 | 43088     | 18-Nov-2024 | 18:48 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1978.0 | 4841536   | 18-Nov-2024 | 18:48 | x64      |
| Sqltses.dll                                                          | 2019.150.4415.2 | 9119800   | 18-Nov-2024 | 18:48 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 18-Nov-2024 | 18:48 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 18-Nov-2024 | 18:48 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 18-Nov-2024 | 18:48 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 18-Nov-2024 | 18:48 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 18-Nov-2024 | 18:48 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 18-Nov-2024 | 18:48 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |     Date    |  Time | Platform |
|:----------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4415.2  | 30760     | 18-Nov-2024 | 18:04 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4415.2 | 1632336   | 18-Nov-2024 | 19:17 | x86      |
| Dtaengine.exe                                                | 2019.150.4415.2 | 219200    | 18-Nov-2024 | 19:17 | x86      |
| Dteparse.dll                                                 | 2019.150.4415.2 | 125008    | 18-Nov-2024 | 19:17 | x64      |
| Dteparse.dll                                                 | 2019.150.4415.2 | 112720    | 18-Nov-2024 | 19:17 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4415.2 | 133200    | 18-Nov-2024 | 19:17 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4415.2 | 116792    | 18-Nov-2024 | 19:17 | x86      |
| Dtepkg.dll                                                   | 2019.150.4415.2 | 149584    | 18-Nov-2024 | 19:17 | x64      |
| Dtepkg.dll                                                   | 2019.150.4415.2 | 133200    | 18-Nov-2024 | 19:17 | x86      |
| Dtexec.exe                                                   | 2019.150.4415.2 | 73792     | 18-Nov-2024 | 19:17 | x64      |
| Dtexec.exe                                                   | 2019.150.4415.2 | 65104     | 18-Nov-2024 | 19:17 | x86      |
| Dts.dll                                                      | 2019.150.4415.2 | 3143736   | 18-Nov-2024 | 19:17 | x64      |
| Dts.dll                                                      | 2019.150.4415.2 | 2762792   | 18-Nov-2024 | 19:17 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4415.2 | 501840    | 18-Nov-2024 | 19:17 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4415.2 | 444496    | 18-Nov-2024 | 19:17 | x86      |
| Dtsconn.dll                                                  | 2019.150.4415.2 | 522320    | 18-Nov-2024 | 19:17 | x64      |
| Dtsconn.dll                                                  | 2019.150.4415.2 | 432208    | 18-Nov-2024 | 19:17 | x86      |
| Dtshost.exe                                                  | 2019.150.4415.2 | 107584    | 18-Nov-2024 | 19:17 | x64      |
| Dtshost.exe                                                  | 2019.150.4415.2 | 89680     | 18-Nov-2024 | 19:17 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4415.2 | 567376    | 18-Nov-2024 | 19:17 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4415.2 | 555072    | 18-Nov-2024 | 19:17 | x86      |
| Dtspipeline.dll                                              | 2019.150.4415.2 | 1329232   | 18-Nov-2024 | 19:17 | x64      |
| Dtspipeline.dll                                              | 2019.150.4415.2 | 1120312   | 18-Nov-2024 | 19:17 | x86      |
| Dtswizard.exe                                                | 15.0.4415.2     | 886824    | 18-Nov-2024 | 19:17 | x64      |
| Dtswizard.exe                                                | 15.0.4415.2     | 890936    | 18-Nov-2024 | 19:17 | x86      |
| Dtuparse.dll                                                 | 2019.150.4415.2 | 100432    | 18-Nov-2024 | 19:17 | x64      |
| Dtuparse.dll                                                 | 2019.150.4415.2 | 88128     | 18-Nov-2024 | 19:17 | x86      |
| Dtutil.exe                                                   | 2019.150.4415.2 | 151120    | 18-Nov-2024 | 19:17 | x64      |
| Dtutil.exe                                                   | 2019.150.4415.2 | 130640    | 18-Nov-2024 | 19:17 | x86      |
| Exceldest.dll                                                | 2019.150.4415.2 | 280656    | 18-Nov-2024 | 19:17 | x64      |
| Exceldest.dll                                                | 2019.150.4415.2 | 235576    | 18-Nov-2024 | 19:17 | x86      |
| Excelsrc.dll                                                 | 2019.150.4415.2 | 309328    | 18-Nov-2024 | 19:17 | x64      |
| Excelsrc.dll                                                 | 2019.150.4415.2 | 260176    | 18-Nov-2024 | 19:17 | x86      |
| Flatfiledest.dll                                             | 2019.150.4415.2 | 358464    | 18-Nov-2024 | 19:17 | x86      |
| Flatfiledest.dll                                             | 2019.150.4415.2 | 411728    | 18-Nov-2024 | 19:17 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4415.2 | 370752    | 18-Nov-2024 | 19:17 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4415.2 | 428112    | 18-Nov-2024 | 19:17 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4415.2     | 116816    | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4415.2     | 403536    | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4415.2     | 403520    | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4415.2     | 3004456   | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4415.2     | 3004480   | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4415.2     | 43064     | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4415.2     | 43088     | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4415.2     | 59456     | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2019.150.4415.2 | 178256    | 18-Nov-2024 | 19:17 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                 | 2019.150.4415.2 | 157736    | 18-Nov-2024 | 19:17 | x86      |
| Microsoft.sqlserver.xevent.dll                               | 2019.150.4415.2 | 194640    | 18-Nov-2024 | 19:17 | x64      |
| Microsoft.sqlserver.xevent.dll                               | 2019.150.4415.2 | 174136    | 18-Nov-2024 | 19:17 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4415.2 | 112704    | 18-Nov-2024 | 19:17 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4415.2 | 100416    | 18-Nov-2024 | 19:17 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.51  | 8280112   | 18-Nov-2024 | 19:17 | x86      |
| Oledbdest.dll                                                | 2019.150.4415.2 | 239672    | 18-Nov-2024 | 19:17 | x86      |
| Oledbdest.dll                                                | 2019.150.4415.2 | 280640    | 18-Nov-2024 | 19:17 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4415.2 | 264272    | 18-Nov-2024 | 19:17 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4415.2 | 313424    | 18-Nov-2024 | 19:17 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4415.2 | 51256     | 18-Nov-2024 | 19:17 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4415.2 | 38992     | 18-Nov-2024 | 19:17 | x86      |
| Sqlscm.dll                                                   | 2019.150.4415.2 | 88120     | 18-Nov-2024 | 19:17 | x64      |
| Sqlscm.dll                                                   | 2019.150.4415.2 | 79912     | 18-Nov-2024 | 19:17 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4415.2 | 182352    | 18-Nov-2024 | 19:17 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4415.2 | 149560    | 18-Nov-2024 | 19:17 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4415.2 | 202792    | 18-Nov-2024 | 19:17 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4415.2 | 170064    | 18-Nov-2024 | 19:17 | x86      |
| Txdataconvert.dll                                            | 2019.150.4415.2 | 276536    | 18-Nov-2024 | 19:17 | x86      |
| Txdataconvert.dll                                            | 2019.150.4415.2 | 317520    | 18-Nov-2024 | 19:17 | x64      |
| Xe.dll                                                       | 2019.150.4415.2 | 632896    | 18-Nov-2024 | 19:17 | x86      |
| Xe.dll                                                       | 2019.150.4415.2 | 718928    | 18-Nov-2024 | 19:17 | x64      |

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
