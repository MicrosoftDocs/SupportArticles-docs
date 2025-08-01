---
title: Servicing Update for SQL Server 2019 RTM (KB4517790)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 RTM servicing update (KB4517790).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4517790
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4517790 - Servicing Update for SQL Server 2019 RTM

_Release Date:_ &nbsp; November 04, 2019  
_Version:_ &nbsp; 15.0.2070.41

## Summary

This Servicing Update for Microsoft SQL Server 2019 RTM is a non-security GDR release. It's a supplemental update that's designed to be installed after SQL Server 2019 RTM. After you install this servicing update, you'll still have the option to install the next SQL Server 2019 cumulative update or GDR servicing release. This release updates components to the following builds:

- SQL Server - Product version: **15.0.2070.41**, file version: **2019.150.2070.41**
- Analysis Services - Product version: **15.0.32.52**, file version: **2018.150.32.52**

## Known issues in this update

There are no known issues in this update.

## Improvements and fixes included in this servicing update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|-|-|-|-|-|
| <a id="12710429">[12710429](#12710429)</a> | [FIX: SQL Server Browser doesn't respond through clustered IP address from a SQL Server 2019 Failover Clustered Instance (FCI) (KB4527165)](https://support.microsoft.com/help/4527165) | SQL Connectivity | Protocols | Windows |

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
<summary><b>How to obtain or download this servicing update package for Windows</b></summary>

The following update is available from the Microsoft Download Center:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the servicing update package for SQL Server 2019 RTM now](https://www.microsoft.com/download/details.aspx?id=100442)

The following update is available from the Microsoft Update Catalog:

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the servicing update package for SQL Server 2019 RTM now](http://download.windowsupdate.com/d/msdownload/update/software/crup/2019/11/sqlserver2019-kb4517790-x64_6412a53eb385a693b48948a297816647d25fa5d5.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4517790-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4517790-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4517790-x64.exe|0E08E97EF523EDEA9C874B2014B8543D87FB553585DA5764D3B54DB89FCC88C6|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.32.52   | 291728    | 28-Oct-19 | 20:41 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 28-Oct-19 | 20:41 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.32.52       | 757640    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 195976    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 198536    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 172936    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 174480    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 192400    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 196488    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 197520    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 201104    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 213896    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 251272    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.32.52       | 1097304   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.32.52       | 479840    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57440     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 58256     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 52832     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 53856     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57232     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57440     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57952     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 58976     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 61024     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 66648     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16784     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16992     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16776     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16992     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 17800     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 28-Oct-19 | 20:41 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 28-Oct-19 | 20:41 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 28-Oct-19 | 20:41 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 28-Oct-19 | 20:41 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 28-Oct-19 | 20:41 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 28-Oct-19 | 20:41 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 28-Oct-19 | 20:41 | x86      |
| Msmdctr.dll                                               | 2018.150.32.52   | 37472     | 28-Oct-19 | 20:41 | x64      |
| Msmdlocal.dll                                             | 2018.150.32.52   | 47704160  | 28-Oct-19 | 20:41 | x86      |
| Msmdlocal.dll                                             | 2018.150.32.52   | 66188384  | 28-Oct-19 | 20:41 | x64      |
| Msmdpump.dll                                              | 2018.150.32.52   | 10187664  | 28-Oct-19 | 20:41 | x64      |
| Msmdredir.dll                                             | 2018.150.32.52   | 7955552   | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15968     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15960     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15968     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16264     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16472     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16480     | 28-Oct-19 | 20:41 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 17504     | 28-Oct-19 | 20:41 | x86      |
| Msmdsrv.exe                                               | 2018.150.32.52   | 65722976  | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1000328   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1453456   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1521032   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1536392   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1595784   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1608072   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1627528   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1642376   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 809864    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 832392    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 991624    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1450592   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1517664   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1532504   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1591904   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1604704   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1624160   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1637472   | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 808536    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 831584    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 990328    | 28-Oct-19 | 20:41 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 998496    | 28-Oct-19 | 20:41 | x64      |
| Msmgdsrv.dll                                              | 2018.150.32.52   | 10184592  | 28-Oct-19 | 20:41 | x64      |
| Msmgdsrv.dll                                              | 2018.150.32.52   | 8278416   | 28-Oct-19 | 20:41 | x86      |
| Msolap.dll                                                | 2018.150.32.52   | 11014544  | 28-Oct-19 | 20:41 | x64      |
| Msolap.dll                                                | 2018.150.32.52   | 8607120   | 28-Oct-19 | 20:41 | x86      |
| Msolui.dll                                                | 2018.150.32.52   | 285280    | 28-Oct-19 | 20:41 | x86      |
| Msolui.dll                                                | 2018.150.32.52   | 305552    | 28-Oct-19 | 20:41 | x64      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 28-Oct-19 | 20:41 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 28-Oct-19 | 20:41 | x64      |
| Sqlceip.exe                                               | 15.0.2070.41     | 290640    | 28-Oct-19 | 20:41 | x86      |
| Sqldumper.exe                                             | 2019.150.2070.41 | 159328    | 28-Oct-19 | 20:41 | x86      |
| Sqldumper.exe                                             | 2019.150.2070.41 | 192312    | 28-Oct-19 | 20:41 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 28-Oct-19 | 20:41 | x86      |
| Tmapi.dll                                                 | 2018.150.32.52   | 6177160   | 28-Oct-19 | 20:41 | x64      |
| Tmcachemgr.dll                                            | 2018.150.32.52   | 4916616   | 28-Oct-19 | 20:41 | x64      |
| Tmpersistence.dll                                         | 2018.150.32.52   | 1183624   | 28-Oct-19 | 20:41 | x64      |
| Tmtransactions.dll                                        | 2018.150.32.52   | 6806624   | 28-Oct-19 | 20:41 | x64      |
| Xmsrv.dll                                                 | 2018.150.32.52   | 26021264  | 28-Oct-19 | 20:41 | x64      |
| Xmsrv.dll                                                 | 2018.150.32.52   | 35457936  | 28-Oct-19 | 20:41 | x86      |

SQL Server 2019 Database Services Common Core

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.2070.41 | 81720     | 28-Oct-19 | 20:42 | x86      |
| Instapi140.dll | 2019.150.2070.41 | 93800     | 28-Oct-19 | 20:42 | x64      |
| Msasxpress.dll | 2018.150.32.52   | 25992     | 28-Oct-19 | 20:42 | x86      |
| Msasxpress.dll | 2018.150.32.52   | 31120     | 28-Oct-19 | 20:42 | x64      |
| Sqldumper.exe  | 2019.150.2070.41 | 159328    | 28-Oct-19 | 20:42 | x86      |
| Sqldumper.exe  | 2019.150.2070.41 | 192312    | 28-Oct-19 | 20:42 | x64      |

SQL Server 2019 sql_dreplay_client

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.2070.41 | 93800     | 28-Oct-19 | 20:43 | x64      |

SQL Server 2019 sql_dreplay_controller

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.2070.41 | 93800     | 28-Oct-19 | 20:42 | x64      |

SQL Server 2019 Database Services Core Instance

|        File name       |   File version   | File size |    Date   |  Time | Platform |
|:----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Hkcompile.dll          | 2019.150.2070.41 | 1298232   | 28-Oct-19 | 21:50 | x64      |
| Hkengine.dll           | 2019.150.2070.41 | 5791544   | 28-Oct-19 | 21:49 | x64      |
| Hkruntime.dll          | 2019.150.2070.41 | 188008    | 28-Oct-19 | 21:49 | x64      |
| Qds.dll                | 2019.150.2070.41 | 1175136   | 28-Oct-19 | 21:49 | x64      |
| Rsfxft.dll             | 2019.150.2070.41 | 57144     | 28-Oct-19 | 21:49 | x64      |
| Secforwarder.dll       | 2019.150.2070.41 | 85816     | 28-Oct-19 | 21:49 | x64      |
| Sqlaccess.dll          | 2019.150.2070.41 | 499304    | 28-Oct-19 | 21:49 | x64      |
| Sqlagent.exe           | 2019.150.2070.41 | 695912    | 28-Oct-19 | 21:50 | x64      |
| Sqlceip.exe            | 15.0.2070.41     | 290640    | 28-Oct-19 | 21:49 | x86      |
| Sqldk.dll              | 2019.150.2070.41 | 3128936   | 28-Oct-19 | 21:50 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 1535800   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 1592928   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 2166584   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 2215528   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3399272   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3485288   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3530552   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3563112   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3595880   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3678008   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3800680   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3804776   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3854136   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3891000   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3993400   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 3997288   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 4009576   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 4046440   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 4136552   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 4144744   | 28-Oct-19 | 21:49 | x64      |
| `Sqlevn70.rll`           | 2019.150.2070.41 | 4259432   | 28-Oct-19 | 21:49 | x64      |
| Sqllang.dll            | 2019.150.2070.41 | 39517800  | 28-Oct-19 | 21:50 | x64      |
| Sqlmin.dll             | 2019.150.2070.41 | 39826024  | 28-Oct-19 | 21:49 | x64      |
| Sqlos.dll              | 2019.150.2070.41 | 52840     | 28-Oct-19 | 21:49 | x64      |
| Sqlscriptdowngrade.dll | 2019.150.2070.41 | 48976     | 28-Oct-19 | 21:49 | x64      |
| Sqlscriptupgrade.dll   | 2019.150.2070.41 | 5910328   | 28-Oct-19 | 21:49 | x64      |
| Sqlservr.exe           | 2019.150.2070.41 | 630584    | 28-Oct-19 | 21:49 | x64      |
| Sqltses.dll            | 2019.150.2070.41 | 9076536   | 28-Oct-19 | 21:49 | x64      |
| Svl.dll                | 2019.150.2070.41 | 167528    | 28-Oct-19 | 21:49 | x64      |

SQL Server 2019 Database Services Core Shared

|     File name    |   File version   | File size |    Date   |  Time | Platform |
|:----------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Flatfiledest.dll | 2019.150.2070.41 | 417592    | 28-Oct-19 | 20:40 | x64      |
| Flatfilesrc.dll  | 2019.150.2070.41 | 433976    | 28-Oct-19 | 20:40 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.2070.41 | 97896     | 28-Oct-19 | 20:43 | x64      |
| Exthost.exe        | 2019.150.2070.41 | 233056    | 28-Oct-19 | 20:43 | x64      |
| Launchpad.exe      | 2019.150.2070.41 | 1228600   | 28-Oct-19 | 20:43 | x64      |
| Sqlsatellite.dll   | 2019.150.2070.41 | 1023800   | 28-Oct-19 | 20:43 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.2070.41 | 36456     | 28-Oct-19 | 20:42 | x86      |

SQL Server 2019 Integration Services

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Flatfiledest.dll                   | 2019.150.2070.41 | 364344    | 28-Oct-19 | 20:55 | x86      |
| Flatfiledest.dll                   | 2019.150.2070.41 | 417592    | 28-Oct-19 | 20:55 | x64      |
| Flatfilesrc.dll                    | 2019.150.2070.41 | 433976    | 28-Oct-19 | 20:55 | x64      |
| Flatfilesrc.dll                    | 2019.150.2070.41 | 376632    | 28-Oct-19 | 20:55 | x86      |
| Microsoft.sqlserver.scripttask.dll | 15.0.2070.41     | 147040    | 28-Oct-19 | 20:55 | x86      |
| Microsoft.sqlserver.scripttask.dll | 15.0.2070.41     | 147256    | 28-Oct-19 | 20:55 | x86      |
| Msdtssrvr.exe                      | 15.0.2070.41     | 224872    | 28-Oct-19 | 20:55 | x64      |
| Msmdpp.dll                         | 2018.150.32.52   | 10061704  | 28-Oct-19 | 20:40 | x64      |
| Sqlceip.exe                        | 15.0.2070.41     | 290640    | 28-Oct-19 | 20:55 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1807.0      | 557184    | 28-Oct-19 | 21:32 | x86      |
| Dmsnative.dll                                                        | 2018.150.1807.0  | 138872    | 28-Oct-19 | 21:32 | x64      |
| Dwengineservice.dll                                                  | 15.0.1807.0      | 50304     | 28-Oct-19 | 21:32 | x86      |
| Instapi140.dll                                                       | 2019.150.2070.41 | 93800     | 28-Oct-19 | 21:32 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1807.0      | 73344     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1807.0      | 299344    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1807.0      | 1954640   | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1807.0      | 176256    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1807.0      | 625272    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1807.0      | 249472    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1807.0      | 144512    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1807.0      | 85352     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1807.0      | 56960     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1807.0      | 94336     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1807.0      | 1134208   | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1807.0      | 86656     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1807.0      | 76416     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1807.0      | 41088     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1807.0      | 36688     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1807.0      | 49784     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1807.0      | 27472     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1807.0      | 32592     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1807.0      | 137344    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1807.0      | 92496     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1807.0      | 106832    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1807.0      | 295040    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 124544    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 141952    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 145024    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 141432    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 153728    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 143488    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 138368    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 179024    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 121984    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1807.0      | 140408    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1807.0      | 78456     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1807.0      | 27992     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1807.0      | 43136     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1807.0      | 134272    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1807.0      | 3033936   | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1807.0      | 3958912   | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 124240    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 139088    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 143488    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 139600    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 154240    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 139904    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 136320    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 176976    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 121168    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1807.0      | 138064    | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1807.0      | 72528     | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1807.0      | 2688128   | 28-Oct-19 | 21:32 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1807.0      | 2443088   | 28-Oct-19 | 21:32 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.2070.41 | 458344    | 28-Oct-19 | 21:32 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.2070.41 | 7380584   | 28-Oct-19 | 21:32 | x64      |
| Secforwarder.dll                                                     | 2019.150.2070.41 | 85816     | 28-Oct-19 | 21:32 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1807.0  | 66176     | 28-Oct-19 | 21:32 | x64      |
| Sqldk.dll                                                            | 2019.150.2070.41 | 3128936   | 28-Oct-19 | 21:32 | x64      |
| Sqldumper.exe                                                        | 2019.150.2070.41 | 192312    | 28-Oct-19 | 21:32 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 1592928   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 4144744   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 3399272   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 4136552   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 4046440   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 2215528   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 2166584   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 3804776   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 3800680   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 1535800   | 28-Oct-19 | 21:31 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.2070.41 | 4009576   | 28-Oct-19 | 21:31 | x64      |
| Sqlos.dll                                                            | 2019.150.2070.41 | 52840     | 28-Oct-19 | 21:32 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1807.0  | 4846928   | 28-Oct-19 | 21:32 | x64      |
| Sqltses.dll                                                          | 2019.150.2070.41 | 9076536   | 28-Oct-19 | 21:32 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.2070.41 | 36664     | 28-Oct-19 | 20:42 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Flatfiledest.dll                               | 2019.150.2070.41 | 417592    | 28-Oct-19 | 21:03 | x64      |
| Flatfiledest.dll                               | 2019.150.2070.41 | 364344    | 28-Oct-19 | 21:03 | x86      |
| Flatfilesrc.dll                                | 2019.150.2070.41 | 433976    | 28-Oct-19 | 21:03 | x64      |
| Flatfilesrc.dll                                | 2019.150.2070.41 | 376632    | 28-Oct-19 | 21:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.2070.41     | 409192    | 28-Oct-19 | 21:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.2070.41     | 409400    | 28-Oct-19 | 21:03 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.2070.41     | 3006056   | 28-Oct-19 | 21:03 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.2070.41     | 3006056   | 28-Oct-19 | 21:03 | x86      |
| Msmgdsrv.dll                                   | 2018.150.32.52   | 8278416   | 28-Oct-19 | 20:45 | x86      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this servicing update package, you must be running SQL Server 2019.

</details>

<details>
<summary><b>Restart information</b></summary>

You might have to restart the computer after you apply this servicing update package.

</details>

<details>
<summary><b>Registry information</b></summary>

To use one of the hotfixes in this package, you don't have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

The Servicing Update payload mainly contains other fixes required for the new SQL Server 2019 Big Data Clusters feature and there's a critical fix for SQL Server Failover Cluster named instance.

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
