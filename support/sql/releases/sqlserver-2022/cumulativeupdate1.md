---
title: Cumulative update 1 for SQL Server 2022 (KB5022375)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 1 (KB5022375).
ms.date: 
ms.custom: KB5022375
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# KB5022375 - Cumulative Update 1 for SQL Server 2022

_Release Date:_ &nbsp;
_Version:_ &nbsp; 16.0.4001.1

## Summary

This article describes Cumulative Update package 1 (CU1) for Microsoft SQL Server 2022. This update contains 76 [fixes](#improvements-and-fixes-included-in-this-update). This release will update components in the following builds:

- SQL Server - Product version: **16.0.4001.1**, file version: **2022.160.4001.1**
- Analysis Services - Product version: **16.0.43.206**, file version: **2022.160.43.206**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://download.microsoft.com/download/d/3/e/d3e28f3d-6a4f-47ce-aaa5-9d74c5590ed6/SQLServerBuilds.xlsx).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | KB article number | Description | Fix area | Platform |
|---|---|---|---|---|
| | | | | |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: Download the latest cumulative update package for SQL Server 2022 now

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: Download the cumulative update package for SQL Server 2022 CU1 now

> [!NOTE]
>
> - Microsoft Update Catalog contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the SQL Server 2022 Release Notes

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update for Big Data Clusters (BDC)</b></summary>

To upgrade Microsoft SQL Server 2022 Big Data Clusters (BDC) on Linux to the latest CU, see the [Big Data Clusters Deployment Guidance](/sql/big-data-cluster/deployment-guidance).

For additional information, see the [Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5022375-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5022375-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5022375-x64.exe|4057DCBD88F34160E098E83691766B4ED99396E939BF56340955E3EB19923FE9|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it is converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

SQL Server 2022 Analysis Services

|                          File   name                      |   File version  | File size |    Date   | Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Asplatformhost.dll                                        | 2022.160.43.206 | 336848    | 12-Jan-23 | 9:46 | x64      |
| Microsoft.analysisservices.server.core.dll                | 16.0.43.206     | 2903504   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 189344    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 214944    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 218016    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 213920    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 231328    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 212896    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 208800    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 270752    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 187808    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 16.0.43.206     | 212384    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 16.0.43.206     | 1281440   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 16.0.43.206     | 567712    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 57760     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 63392     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 63904     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 62880     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 66464     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 62368     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 61856     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 72608     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 57248     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 16.0.43.206     | 62368     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17824     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17872     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17872     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17824     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17824     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17872     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17824     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 18896     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17872     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 16.0.43.206     | 17824     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.data.mashup.sqlclient.dll                       | 2.108.3243.0    | 24480     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.data.sqlclient.dll                              | 1.14.21068.1    | 1920960   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identity.client.dll                             | 4.14.0.0        | 1350048   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll                 | 5.6.0.61018     | 65952     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identitymodel.logging.dll                       | 5.6.0.61018     | 26528     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identitymodel.protocols.dll                     | 5.6.0.61018     | 32192     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll       | 5.6.0.61018     | 103328    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identitymodel.tokens.dll                        | 5.6.0.61018     | 162720    | 12-Jan-23 | 9:46 | x86      |
| Msmdctr.dll                                               | 2022.160.43.206 | 38832     | 12-Jan-23 | 9:46 | x64      |
| Msmdlocal.dll                                             | 2022.160.43.206 | 53920200  | 12-Jan-23 | 9:46 | x86      |
| Msmdlocal.dll                                             | 2022.160.43.206 | 71755168  | 12-Jan-23 | 9:46 | x64      |
| Msmdpump.dll                                              | 2022.160.43.206 | 10335176  | 12-Jan-23 | 9:46 | x64      |
| Msmdredir.dll                                             | 2022.160.43.206 | 8132016   | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 16800     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 16800     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 17312     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 16800     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 17312     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 17312     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 17312     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 18336     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 16800     | 12-Jan-23 | 9:46 | x86      |
| Msmdspdm.resources.dll                                    | 16.0.43.206     | 16800     | 12-Jan-23 | 9:46 | x86      |
| Msmdsrv.exe                                               | 2022.160.43.206 | 71308752  | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 954784    | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1882528   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1669552   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1878944   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1846192   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1145264   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1138096   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1767328   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1746848   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 930736    | 12-Jan-23 | 9:46 | x64      |
| Msmdsrv.rll                                               | 2022.160.43.206 | 1835424   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 953264    | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1880496   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1666480   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1874352   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1842592   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1143216   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1136544   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1763752   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1743264   | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 931248    | 12-Jan-23 | 9:46 | x64      |
| Msmdsrvi.rll                                              | 2022.160.43.206 | 1830816   | 12-Jan-23 | 9:46 | x64      |
| Msmgdsrv.dll                                              | 2022.160.43.206 | 8265680   | 12-Jan-23 | 9:46 | x86      |
| Msmgdsrv.dll                                              | 2022.160.43.206 | 10083784  | 12-Jan-23 | 9:46 | x64      |
| Msolap.dll                                                | 2022.160.43.206 | 8744880   | 12-Jan-23 | 9:46 | x86      |
| Msolap.dll                                                | 2022.160.43.206 | 10970032  | 12-Jan-23 | 9:46 | x64      |
| Msolui.dll                                                | 2022.160.43.206 | 289696    | 12-Jan-23 | 9:46 | x86      |
| Msolui.dll                                                | 2022.160.43.206 | 308128    | 12-Jan-23 | 9:46 | x64      |
| Newtonsoft.json.dll                                       | 13.0.1.25517    | 704448    | 12-Jan-23 | 9:46 | x86      |
| Sni.dll                                                   | 1.1.1.0         | 555424    | 12-Jan-23 | 9:46 | x64      |
| Sql_as_keyfile.dll                                        | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:46 | x64      |
| Sqlceip.exe                                               | 16.0.4001.1     | 301000    | 12-Jan-23 | 9:46 | x86      |
| Sqldumper.exe                                             | 2022.160.4001.1 | 227240    | 12-Jan-23 | 9:46 | x86      |
| Sqldumper.exe                                             | 2022.160.4001.1 | 260040    | 12-Jan-23 | 9:46 | x64      |
| System.identitymodel.tokens.jwt.dll                       | 5.6.0.61018     | 83872     | 12-Jan-23 | 9:46 | x86      |
| Tmapi.dll                                                 | 2022.160.43.206 | 5884320   | 12-Jan-23 | 9:46 | x64      |
| Tmcachemgr.dll                                            | 2022.160.43.206 | 5575120   | 12-Jan-23 | 9:46 | x64      |
| Tmpersistence.dll                                         | 2022.160.43.206 | 1481120   | 12-Jan-23 | 9:46 | x64      |
| Tmtransactions.dll                                        | 2022.160.43.206 | 7197648   | 12-Jan-23 | 9:46 | x64      |
| Xmsrv.dll                                                 | 2022.160.43.206 | 35895760  | 12-Jan-23 | 9:46 | x86      |
| Xmsrv.dll                                                 | 2022.160.43.206 | 26594256  | 12-Jan-23 | 9:46 | x64      |

SQL Server 2022 Database Services Common Core

|                   File   name              |   File version  | File size |    Date   | Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Instapi150.dll                             | 2022.160.4001.1 | 104344    | 12-Jan-23 | 9:46 | x64      |
| Instapi150.dll                             | 2022.160.4001.1 | 79776     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.206     | 2633648   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.206     | 2633648   | 12-Jan-23 | 9:47 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.206     | 2933152   | 12-Jan-23 | 9:47 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.206     | 2323376   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.206     | 2323376   | 12-Jan-23 | 9:47 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4001.1     | 554904    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4001.1     | 554952    | 12-Jan-23 | 9:46 | x86      |
| Msasxpress.dll                             | 2022.160.43.206 | 32720     | 12-Jan-23 | 9:46 | x64      |
| Msasxpress.dll                             | 2022.160.43.206 | 27568     | 12-Jan-23 | 9:47 | x86      |
| Sql_common_core_keyfile.dll                | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:46 | x64      |
| Sqldumper.exe                              | 2022.160.4001.1 | 227240    | 12-Jan-23 | 9:46 | x86      |
| Sqldumper.exe                              | 2022.160.4001.1 | 260040    | 12-Jan-23 | 9:46 | x64      |

SQL Server 2022 Data Quality

|          File   name      | File version | File size |    Date   | Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4001.1  | 600008    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4001.1  | 600008    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4001.1  | 173992    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4001.1  | 173984    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4001.1  | 1857448   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4001.1  | 1857480   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4001.1  | 370600    | 12-Jan-23 | 9:46 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4001.1  | 370592    | 12-Jan-23 | 9:46 | x86      |

SQL Server 2022 Database Services Core Instance

|                    File   name               |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                   | 2022.160.4001.1 | 4719008   | 12-Jan-23 | 10:58 | x64      |
| Aetm-enclave.dll                             | 2022.160.4001.1 | 4673464   | 12-Jan-23 | 10:58 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4001.1 | 4909104   | 12-Jan-23 | 10:58 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4001.1 | 4874512   | 12-Jan-23 | 10:58 | x64      |
| Hadrres.dll                                  | 2022.160.4001.1 | 227240    | 12-Jan-23 | 10:58 | x64      |
| Hkcompile.dll                                | 2022.160.4001.1 | 1410984   | 12-Jan-23 | 10:58 | x64      |
| Hkengine.dll                                 | 2022.160.4001.1 | 5760968   | 12-Jan-23 | 10:58 | x64      |
| Hkruntime.dll                                | 2022.160.4001.1 | 190368    | 12-Jan-23 | 10:58 | x64      |
| Hktempdb.dll                                 | 2022.160.4001.1 | 71576     | 12-Jan-23 | 10:58 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.206     | 2322384   | 12-Jan-23 | 10:58 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4001.1 | 333768    | 12-Jan-23 | 10:58 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4001.1 | 96200     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 30664     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 38856     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 34720     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 38856     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 38856     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 30616     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 30664     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 34760     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 38856     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 30624     | 12-Jan-23 | 10:58 | x64      |
| Odsole70.rll                                 | 16.0.4001.1     | 38816     | 12-Jan-23 | 10:58 | x64      |
| Qds.dll                                      | 2022.160.4001.1 | 1779624   | 12-Jan-23 | 10:58 | x64      |
| Rsfxft.dll                                   | 2022.160.4001.1 | 55208     | 12-Jan-23 | 10:58 | x64      |
| Secforwarder.dll                             | 2022.160.4001.1 | 83872     | 12-Jan-23 | 10:58 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4001.1 | 137128    | 12-Jan-23 | 10:58 | x64      |
| Sqlaccess.dll                                | 2022.160.4001.1 | 444328    | 12-Jan-23 | 10:58 | x64      |
| Sqlagent.exe                                 | 2022.160.4001.1 | 726984    | 12-Jan-23 | 10:58 | x64      |
| Sqlceip.exe                                  | 16.0.4001.1     | 301000    | 12-Jan-23 | 10:58 | x86      |
| Sqlctr160.dll                                | 2022.160.4001.1 | 157608    | 12-Jan-23 | 10:58 | x64      |
| Sqlctr160.dll                                | 2022.160.4001.1 | 128968    | 12-Jan-23 | 10:58 | x86      |
| Sqldk.dll                                    | 2022.160.4001.1 | 4028360   | 12-Jan-23 | 10:58 | x64      |
| Sqllang.dll                                  | 2022.160.4001.1 | 48523208  | 12-Jan-23 | 10:58 | x64      |
| Sqlmin.dll                                   | 2022.160.4001.1 | 51304392  | 12-Jan-23 | 10:58 | x64      |
| Sqlos.dll                                    | 2022.160.4001.1 | 51144     | 12-Jan-23 | 10:58 | x64      |
| Sqlrepss.dll                                 | 2022.160.4001.1 | 137112    | 12-Jan-23 | 10:58 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4001.1 | 51112     | 12-Jan-23 | 10:58 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4001.1 | 5830568   | 12-Jan-23 | 10:58 | x64      |
| Sqlservr.exe                                 | 2022.160.4001.1 | 722856    | 12-Jan-23 | 10:58 | x64      |
| Sqltses.dll                                  | 2022.160.4001.1 | 9389976   | 12-Jan-23 | 10:58 | x64      |
| Sqsrvres.dll                                 | 2022.160.4001.1 | 305064    | 12-Jan-23 | 10:58 | x64      |
| Svl.dll                                      | 2022.160.4001.1 | 247704    | 12-Jan-23 | 10:58 | x64      |
| Xe.dll                                       | 2022.160.4001.1 | 718792    | 12-Jan-23 | 10:58 | x64      |

SQL Server 2022 Database Services Core Shared

|                        File   name                   |   File version  | File size |    Date   | Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Distrib.exe                                          | 2022.160.4001.1 | 268200    | 12-Jan-23 | 9:47 | x64      |
| Logread.exe                                          | 2022.160.4001.1 | 788384    | 12-Jan-23 | 9:47 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.206     | 2933680   | 12-Jan-23 | 9:46 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.10.22089.1    | 2032120   | 12-Jan-23 | 9:47 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4001.1     | 30632     | 12-Jan-23 | 9:46 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 12-Jan-23 | 9:47 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 12-Jan-23 | 9:47 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 12-Jan-23 | 9:47 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 12-Jan-23 | 9:47 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 12-Jan-23 | 9:47 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 12-Jan-23 | 9:47 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4001.1 | 1714088   | 12-Jan-23 | 9:47 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4001.1     | 554904    | 12-Jan-23 | 9:47 | x86      |
| Msgprox.dll                                          | 2022.160.4001.1 | 313288    | 12-Jan-23 | 9:47 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 2734072   | 12-Jan-23 | 9:46 | x64      |
| Msoledbsql.dll                                       | 2018.186.4.0    | 153584    | 12-Jan-23 | 9:46 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 12-Jan-23 | 9:47 | x86      |
| Qrdrsvc.exe                                          | 2022.160.4001.1 | 530328    | 12-Jan-23 | 9:47 | x64      |
| Rdistcom.dll                                         | 2022.160.4001.1 | 939944    | 12-Jan-23 | 9:47 | x64      |
| Repldp.dll                                           | 2022.160.4001.1 | 337832    | 12-Jan-23 | 9:47 | x64      |
| Replisapi.dll                                        | 2022.160.4001.1 | 419744    | 12-Jan-23 | 9:47 | x64      |
| Replmerg.exe                                         | 2022.160.4001.1 | 604104    | 12-Jan-23 | 9:47 | x64      |
| Replprov.dll                                         | 2022.160.4001.1 | 890784    | 12-Jan-23 | 9:47 | x64      |
| Replrec.dll                                          | 2022.160.4001.1 | 1058728   | 12-Jan-23 | 9:47 | x64      |
| Replsub.dll                                          | 2022.160.4001.1 | 501664    | 12-Jan-23 | 9:47 | x64      |
| Spresolv.dll                                         | 2022.160.4001.1 | 300960    | 12-Jan-23 | 9:47 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:46 | x64      |
| Sqldistx.dll                                         | 2022.160.4001.1 | 268232    | 12-Jan-23 | 9:47 | x64      |
| Sqlmergx.dll                                         | 2022.160.4001.1 | 423880    | 12-Jan-23 | 9:47 | x64      |
| Xe.dll                                               | 2022.160.4001.1 | 718792    | 12-Jan-23 | 9:48 | x64      |

SQL Server 2022 sql_extensibility

|            File   name        |   File version  | File size |    Date   | Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Commonlauncher.dll            | 2022.160.4001.1 | 100264    | 12-Jan-23 | 9:46 | x64      |
| Exthost.exe                   | 2022.160.4001.1 | 247704    | 12-Jan-23 | 9:46 | x64      |
| Launchpad.exe                 | 2022.160.4001.1 | 1361832   | 12-Jan-23 | 9:46 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:46 | x64      |
| Sqlsatellite.dll              | 2022.160.4001.1 | 1165224   | 12-Jan-23 | 9:46 | x64      |

SQL Server 2022 Full-Text Engine

|          File   name     |   File version  | File size |    Date   | Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Fd.dll                   | 2022.160.4001.1 | 710600    | 12-Jan-23 | 9:46 | x64      |
| Fdhost.exe               | 2022.160.4001.1 | 153512    | 12-Jan-23 | 9:46 | x64      |
| Fdlauncher.exe           | 2022.160.4001.1 | 100296    | 12-Jan-23 | 9:46 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:46 | x64      |

SQL Server 2022 Integration Services

|                            File   name                        |   File version  | File size |    Date   | Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 12-Jan-23 | 9:53 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 79176     | 12-Jan-23 | 9:54 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 12-Jan-23 | 9:53 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 40312     | 12-Jan-23 | 9:54 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 80728     | 12-Jan-23 | 9:53 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 80728     | 12-Jan-23 | 9:54 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4001.1     | 120776    | 12-Jan-23 | 9:53 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4001.1     | 120776    | 12-Jan-23 | 9:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.206     | 2933712   | 12-Jan-23 | 9:53 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.206     | 2933680   | 12-Jan-23 | 9:53 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4001.1     | 509864    | 12-Jan-23 | 9:53 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4001.1     | 219048    | 12-Jan-23 | 9:53 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.206 | 10165712  | 12-Jan-23 | 9:53 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 12-Jan-23 | 9:53 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 12-Jan-23 | 9:53 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 12-Jan-23 | 9:54 | x86      |
| Sql_is_keyfile.dll                                            | 2022.160.4001.1 | 137128    | 12-Jan-23 | 9:52 | x64      |
| Sqlceip.exe                                                   | 16.0.4001.1     | 301000    | 12-Jan-23 | 9:53 | x86      |
| Xe.dll                                                        | 2022.160.4001.1 | 640928    | 12-Jan-23 | 9:54 | x86      |
| Xe.dll                                                        | 2022.160.4001.1 | 718792    | 12-Jan-23 | 9:54 | x64      |

SQL Server 2022 sql_polybase_core_inst

|      File   name |   File version  | File size |    Date   |  Time | Platform |
|:----------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll   | 2022.160.4001.1 | 104344    | 12-Jan-23 | 10:40 | x64      |
| Mpdwinterop.dll  | 2022.160.4001.1 | 296856    | 12-Jan-23 | 10:40 | x64      |
| Mpdwsvc.exe      | 2022.160.4001.1 | 7817112   | 12-Jan-23 | 10:40 | x64      |
| Secforwarder.dll | 2022.160.4001.1 | 83872     | 12-Jan-23 | 10:40 | x64      |
| Sqldk.dll        | 2022.160.4001.1 | 4028360   | 12-Jan-23 | 10:40 | x64      |
| Sqldumper.exe    | 2022.160.4001.1 | 260040    | 12-Jan-23 | 10:40 | x64      |
| Sqlncli17e.dll   | 2017.1710.3.1   | 1898432   | 12-Jan-23 | 10:40 | x64      |
| Sqlos.dll        | 2022.160.4001.1 | 51144     | 12-Jan-23 | 10:40 | x64      |
| Sqltses.dll      | 2022.160.4001.1 | 9389976   | 12-Jan-23 | 10:40 | x64      |

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

To use one of the hotfixes in this package, you do not have to make any changes to the registry.

</details>

<details>
<summary><b>Important notices</b></summary>

This article also provides the following important information:

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number do not match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

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
    > If you do not want to use the rolling update process, follow these steps to apply an update:
    >
    > - Install the update on the passive node.
    > - Install the update on the active node (requires a service restart).

- [Upgrade and update of availability group servers that use minimal downtime and data loss](https://msdn.microsoft.com/library/dn178483.aspx)

    > [!NOTE]
    > If you enabled Always On together with **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for more information about how to apply an update in these environments.

- [How to apply a hotfix for SQL Server in a transactional replication and database mirroring topology](../../database-engine/replication/install-service-packs-hotfixes.md)
- [How to apply a hotfix for SQL Server in a replication topology](../../database-engine/replication/apply-hotfix-sql-replication-topology.md)
- [Upgrading Mirrored Instances](/sql/database-engine/database-mirroring/upgrading-mirrored-instances) 
- [Overview of SQL Server Servicing Installation](https://technet.microsoft.com/library/dd638062.aspx)

</details>

<details>
<summary><b>Language support</b></summary>

SQL Server CUs are currently multilingual. Therefore, this CU package is not specific to one language. It applies to all supported languages.

</details>

<details>
<summary><b>Components (features) updated</b></summary>

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must re-apply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If additional issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that do not qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).

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

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](https://blogs.msdn.microsoft.com/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism/)
- [SQL Server Service Packs are discontinued starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determining which version and edition of SQL Server Database Engine is running](https://gallery.technet.microsoft.com/determining-which-version-af0f16f6)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
