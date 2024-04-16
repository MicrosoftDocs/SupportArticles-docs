---
title: Cumulative update 3 for SQL Server 2017 (KB4052987)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 3 (KB4052987).
ms.date: 08/04/2023
ms.custom: KB4052987, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4052987 - Cumulative Update 3 for SQL Server 2017

_Release Date:_ &nbsp; January 04, 2018  
_Version:_ &nbsp; 14.0.3015.40

> [!NOTE]
> Cumulative Update 3 (CU3) for Microsoft SQL Server 2017 was also released in the January 3, 2018, SQL Server Security Bulletin ADV180002. See [KB 4058562](https://support.microsoft.com/help/4058562) for more information. In other words, the same physical package (*SQLServer2017-KB4052987-x64.exe*) was made available both as CU3 (KB 4052987) and the Security Bulletin ([KB 4058562](https://support.microsoft.com/help/4058562)).
>
> Because of this, you may already have CU3 installed as part of that security release. If you do try to install CU3 after ADV180002, you may receive the following message:
>
> There are no SQL Server instances or shared features that can be updated on this computer
>
> This indicates that CU3 is already installed and that no further action is required.

## Summary

This article describes Cumulative Update package 3 (CU3) for Microsoft SQL Server 2017. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 2, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3008.27**, file version: **2017.140.3008.27**
- Analysis Services - Product version: **14.0.202.1**, file version: **2017.140.202.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="11272738">[11272738](#11272738)</a> | [FIX: Performance Counters are missing after the installation of SSAS 2017 in tabular mode (KB4056328)](https://support.microsoft.com/help/4056328) | Analysis Services | Analysis Services | Windows |
| <a id="11309598">[11309598](#11309598)</a> | [FIX: "The data area passed to a system call is too small" error when you start a Centennial application on a SQL Server 2017 server (KB4073393)](https://support.microsoft.com/help/4073393) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="11230379">[11230379](#11230379)</a> | [FIX: Mirroring session stops synchronizing after doing rolling upgrade to SQL Server 2017 (KB4056354)](https://support.microsoft.com/help/4056354) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11300802">[11300802](#11300802)</a> | [FIX: Unnecessary failover when you use AlwaysOn Availability Group in SQL Server 2017 on Linux (KB4056922)](https://support.microsoft.com/help/4056922) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id="11281561">[11281561](#11281561)</a> | [FIX: In-memory database restore fails with errors in SQL Server 2016 and SQL Server 2017 (KB4051356)](https://support.microsoft.com/help/4051356) | SQL Server Engine | In-Memory OLTP | All |
| <a id="11124264">[11124264](#11124264)</a> | [FIX: Alert Engine reads complete Application event log and sends alerts on old events after Windows is restarted (KB4052127)](https://support.microsoft.com/help/4052127) | SQL Server Engine | Management Services | Windows |
| <a id="11176915">[11176915](#11176915)</a> | [Update to enable PolyBase technology in SQL Server 2017 (KB4053293)](https://support.microsoft.com/help/4053293) | SQL Server Engine | PolyBase | Windows |
| <a id="11061737">[11061737](#11061737)</a> | [Update adds execution statistics of a scalar-valued, user-defined function to the Showplan XML file in SQL Server 2017 (KB4056154)](https://support.microsoft.com/help/4056154) | SQL Server Engine | Query Execution | All |
| <a id="11061767">[11061767](#11061767)</a> | [Update adds CPU timeout setting to Resource Governor workgroup REQUEST_MAX_CPU_TIME_SEC in SQL Server 2017 (KB4038419)](https://support.microsoft.com/help/4038419) | SQL Server Engine | Query Execution | All |
| <a id="11061779">[11061779](#11061779)</a> | [Improve tempdb spill diagnostics in DMV and Extended Events in SQL Server 2017 (KB4041814)](https://support.microsoft.com/help/4041814) | SQL Server Engine | Query Execution | All |
| <a id="11061785">[11061785](#11061785)</a> | [Update adds optimizer row goal information in query execution plans in SQL Server 2017 (KB4051361)](https://support.microsoft.com/help/4051361) | SQL Server Engine | Query Execution | All |
| <a id="11061781">[11061781](#11061781)</a> | [FIX: Add CXPACKET wait type in showplan XML in SQL Server 2017 (KB4046914)](https://support.microsoft.com/help/4046914) | SQL Server Engine | Query Execution | All |
| <a id="11061723">[11061723](#11061723)</a> | Update enables XML Showplans to provide a list of statistics used during query optimization in SQL Server 2017 (KB4041817) | SQL Server Engine | Query Execution | All |
| <a id="11061704">[11061704](#11061704)</a> | [Update adds support for MAXDOP option for CREATE STATISTICS and UPDATE STATISTICS statements in SQL Server 2017 (KB4041809)](https://support.microsoft.com/help/4041809) | SQL Server Engine | Query Optimizer | All |
| <a id="11061716">[11061716](#11061716)</a> | [FIX: Automatic update of incremental statistics is delayed in SQL Server 2017 (KB4041811)](https://support.microsoft.com/help/4041811) | SQL Server Engine | Query Optimizer | All |
| <a id="11280500">[11280500](#11280500)</a> | [FIX: DBCC CHECKDB returns consistency errors if SOUNDEX function is used in PERSISTED computed columns in SQL Server (KB4055735)](https://support.microsoft.com/help/4055735) | SQL Server Engine | Storage Management | All |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

> [!NOTE]
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU3 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2018/01/sqlserver2017-kb4052987-x64_a533b82e49cb9a5eea52cd2339db18aa4017587b.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4052987-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4052987-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4052987-x64.exe| 3228E428B10C884F6C3C91EEA8A65546AD7A019EE9B56D1E5CC31708611D24CE |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.202.1   | 266408    | 23-Dec-17 | 01:24 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.202.1       | 741544    | 23-Dec-17 | 01:19 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.202.1       | 1380520   | 23-Dec-17 | 01:24 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.202.1       | 984224    | 23-Dec-17 | 01:24 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.202.1       | 521384    | 23-Dec-17 | 01:24 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201    | 174816    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201    | 36576     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201    | 48864     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201    | 105184    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201    | 5167328   | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201    | 26336     | 20-Oct-17 | 10:17 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201    | 26848     | 20-Oct-17 | 10:17 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201    | 26848     | 20-Oct-17 | 10:17 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201    | 159456    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201    | 82656     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201    | 67296     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201    | 25824     | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151264    | 20-Oct-17 | 10:17 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201    | 13032160  | 20-Oct-17 | 10:17 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484       | 1044672   | 20-Oct-17 | 10:17 | x86      |
| Msmdctr.dll                                        | 2017.140.202.1   | 40104     | 23-Dec-17 | 01:25 | x64      |
| Msmdlocal.dll                                      | 2017.140.202.1   | 40374952  | 23-Dec-17 | 00:39 | x86      |
| Msmdlocal.dll                                      | 2017.140.202.1   | 60701352  | 23-Dec-17 | 01:25 | x64      |
| Msmdpump.dll                                       | 2017.140.202.1   | 9334944   | 23-Dec-17 | 01:25 | x64      |
| Msmdredir.dll                                      | 2017.140.202.1   | 7091880   | 23-Dec-17 | 00:39 | x86      |
| Msmdsrv.exe                                        | 2017.140.202.1   | 60601000  | 23-Dec-17 | 01:25 | x64      |
| Msmgdsrv.dll                                       | 2017.140.202.1   | 7310504   | 23-Dec-17 | 00:39 | x86      |
| Msmgdsrv.dll                                       | 2017.140.202.1   | 9004712   | 23-Dec-17 | 01:25 | x64      |
| Msolap.dll                                         | 2017.140.202.1   | 7777440   | 23-Dec-17 | 00:39 | x86      |
| Msolap.dll                                         | 2017.140.202.1   | 10258600  | 23-Dec-17 | 01:25 | x64      |
| Msolui.dll                                         | 2017.140.202.1   | 287392    | 23-Dec-17 | 00:39 | x86      |
| Msolui.dll                                         | 2017.140.202.1   | 310952    | 23-Dec-17 | 01:25 | x64      |
| Powerbiextensions.dll                              | 2.49.4831.201    | 5316832   | 20-Oct-17 | 10:17 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlboot.dll                                        | 2017.140.3015.40 | 195232    | 23-Dec-17 | 00:36 | x64      |
| Sqlceip.exe                                        | 14.0.3015.40     | 251040    | 23-Dec-17 | 01:32 | x86      |
| Sqldumper.exe                                      | 2017.140.3015.40 | 140448    | 23-Dec-17 | 00:33 | x64      |
| Sqldumper.exe                                      | 2017.140.3015.40 | 118944    | 23-Dec-17 | 01:24 | x86      |
| Tmapi.dll                                          | 2017.140.202.1   | 5822632   | 23-Dec-17 | 01:27 | x64      |
| Tmcachemgr.dll                                     | 2017.140.202.1   | 4164776   | 23-Dec-17 | 01:27 | x64      |
| Tmpersistence.dll                                  | 2017.140.202.1   | 1132192   | 23-Dec-17 | 01:27 | x64      |
| Tmtransactions.dll                                 | 2017.140.202.1   | 1640104   | 23-Dec-17 | 01:27 | x64      |
| Xe.dll                                             | 2017.140.3015.40 | 673440    | 23-Dec-17 | 00:33 | x64      |
| Xmlrw.dll                                          | 2017.140.3015.40 | 305312    | 23-Dec-17 | 00:36 | x64      |
| Xmlrw.dll                                          | 2017.140.3015.40 | 257696    | 23-Dec-17 | 01:31 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3015.40 | 224416    | 23-Dec-17 | 00:36 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3015.40 | 189600    | 23-Dec-17 | 01:31 | x86      |
| Xmsrv.dll                                          | 2017.140.202.1   | 33350304  | 23-Dec-17 | 00:39 | x86      |
| Xmsrv.dll                                          | 2017.140.202.1   | 25375400  | 23-Dec-17 | 01:27 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3015.40 | 180896    | 23-Dec-17 | 00:36 | x64      |
| Batchparser.dll                            | 2017.140.3015.40 | 160416    | 23-Dec-17 | 00:18 | x86      |
| Instapi140.dll                             | 2017.140.3015.40 | 70304     | 23-Dec-17 | 00:18 | x64      |
| Instapi140.dll                             | 2017.140.3015.40 | 61096     | 23-Dec-17 | 00:18 | x86      |
| Isacctchange.dll                           | 2017.140.3015.40 | 30880     | 23-Dec-17 | 01:24 | x64      |
| Isacctchange.dll                           | 2017.140.3015.40 | 29344     | 23-Dec-17 | 01:29 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.202.1       | 1088672   | 23-Dec-17 | 00:39 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.202.1       | 1088680   | 23-Dec-17 | 01:24 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.202.1       | 1381544   | 23-Dec-17 | 00:39 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.202.1       | 741544    | 23-Dec-17 | 00:39 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.202.1       | 741544    | 23-Dec-17 | 01:24 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3015.40     | 37024     | 23-Dec-17 | 00:39 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3015.40 | 82080     | 23-Dec-17 | 00:36 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3015.40 | 78496     | 23-Dec-17 | 00:39 | x86      |
| Msasxpress.dll                             | 2017.140.202.1   | 31912     | 23-Dec-17 | 00:39 | x86      |
| Msasxpress.dll                             | 2017.140.202.1   | 36008     | 23-Dec-17 | 01:25 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3015.40 | 82080     | 23-Dec-17 | 01:25 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3015.40 | 67744     | 23-Dec-17 | 01:31 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqldumper.exe                              | 2017.140.3015.40 | 140448    | 23-Dec-17 | 00:33 | x64      |
| Sqldumper.exe                              | 2017.140.3015.40 | 118944    | 23-Dec-17 | 01:24 | x86      |
| Sqlftacct.dll                              | 2017.140.3015.40 | 62112     | 23-Dec-17 | 01:25 | x64      |
| Sqlftacct.dll                              | 2017.140.3015.40 | 54432     | 23-Dec-17 | 01:31 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3015.40 | 415912    | 23-Dec-17 | 01:25 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3015.40 | 372384    | 23-Dec-17 | 01:29 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3015.40 | 34976     | 23-Dec-17 | 00:39 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3015.40 | 37536     | 23-Dec-17 | 01:25 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3015.40 | 356000    | 23-Dec-17 | 00:36 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3015.40 | 273056    | 23-Dec-17 | 00:39 | x86      |
| Sqltdiagn.dll                              | 2017.140.3015.40 | 67744     | 23-Dec-17 | 00:36 | x64      |
| Sqltdiagn.dll                              | 2017.140.3015.40 | 60576     | 23-Dec-17 | 00:39 | x86      |
| Svrenumapi140.dll                          | 2017.140.3015.40 | 1173152   | 23-Dec-17 | 00:36 | x64      |
| Svrenumapi140.dll                          | 2017.140.3015.40 | 893600    | 23-Dec-17 | 00:39 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3015.40 | 120992    | 23-Dec-17 | 02:34 | x86      |
| Dreplaycommon.dll              | 2017.140.3015.40 | 698016    | 23-Dec-17 | 01:29 | x86      |
| Dreplayserverps.dll            | 2017.140.3015.40 | 32928     | 23-Dec-17 | 00:39 | x86      |
| Dreplayutil.dll                | 2017.140.3015.40 | 309920    | 23-Dec-17 | 01:29 | x86      |
| Instapi140.dll                 | 2017.140.3015.40 | 70304     | 23-Dec-17 | 00:18 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlresourceloader.dll          | 2017.140.3015.40 | 29344     | 23-Dec-17 | 00:18 | x86      |

SQL Server 2017 sql_dreplay_controller

| File name                          | File version     | File size | Date        | Time  | Platform |
|------------------------------------|------------------|-----------|-------------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3015.40 | 698016    | 23-Dec-17 | 01:29 | x86      |
| Dreplaycontroller.exe              | 2017.140.3015.40 | 350368    | 23-Dec-17 | 02:34 | x86      |
| Dreplayprocess.dll                 | 2017.140.3015.40 | 171680    | 23-Dec-17 | 01:29 | x86      |
| Dreplayserverps.dll                | 2017.140.3015.40 | 32928     | 23-Dec-17 | 00:39 | x86      |
| Instapi140.dll                     | 2017.140.3015.40 | 70304     | 23-Dec-17 | 00:18 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlresourceloader.dll              | 2017.140.3015.40 | 29344     | 23-Dec-17 | 00:18 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3015.40 | 180896    | 23-Dec-17 | 00:36 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 17-Dec-17 | 01:59 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 17-Dec-17 | 01:59 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 17-Dec-17 | 01:59 | x64      |
| Datacollectorcontroller.dll                  | 2017.140.3015.40 | 225952    | 23-Dec-17 | 01:24 | x64      |
| Dcexec.exe                                   | 2017.140.3015.40 | 74400     | 23-Dec-17 | 01:24 | x64      |
| Fssres.dll                                   | 2017.140.3015.40 | 89256     | 23-Dec-17 | 01:25 | x64      |
| Hadrres.dll                                  | 2017.140.3015.40 | 187552    | 23-Dec-17 | 01:25 | x64      |
| Hkcompile.dll                                | 2017.140.3015.40 | 1423008   | 23-Dec-17 | 01:25 | x64      |
| Hkengine.dll                                 | 2017.140.3015.40 | 5857952   | 23-Dec-17 | 01:25 | x64      |
| Hkruntime.dll                                | 2017.140.3015.40 | 161952    | 23-Dec-17 | 02:27 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 17-Dec-17 | 01:59 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.202.1       | 741032    | 23-Dec-17 | 01:24 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3015.40     | 237216    | 23-Dec-17 | 02:21 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3015.40     | 79520     | 23-Dec-17 | 02:19 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3015.40 | 71328     | 23-Dec-17 | 00:36 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3015.40 | 65184     | 23-Dec-17 | 00:33 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3015.40 | 152224    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3015.40 | 159392    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3015.40 | 303776    | 23-Dec-17 | 01:20 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3015.40 | 74912     | 23-Dec-17 | 02:13 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 17-Dec-17 | 01:59 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 17-Dec-17 | 01:59 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 17-Dec-17 | 01:59 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 17-Dec-17 | 01:59 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 17-Dec-17 | 01:59 | x64      |
| Odsole70.dll                                 | 2017.140.3015.40 | 92832     | 23-Dec-17 | 01:25 | x64      |
| Opends60.dll                                 | 2017.140.3015.40 | 32928     | 23-Dec-17 | 00:36 | x64      |
| Qds.dll                                      | 2017.140.3015.40 | 1168032   | 23-Dec-17 | 05:21 | x64      |
| Rsfxft.dll                                   | 2017.140.3015.40 | 34464     | 23-Dec-17 | 00:18 | x64      |
| Secforwarder.dll                             | 2017.140.3015.40 | 37536     | 23-Dec-17 | 01:22 | x64      |
| Sqagtres.dll                                 | 2017.140.3015.40 | 74400     | 23-Dec-17 | 00:36 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlaamss.dll                                 | 2017.140.3015.40 | 89760     | 23-Dec-17 | 02:27 | x64      |
| Sqlaccess.dll                                | 2017.140.3015.40 | 474784    | 23-Dec-17 | 00:36 | x64      |
| Sqlagent.exe                                 | 2017.140.3015.40 | 579744    | 23-Dec-17 | 01:25 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3015.40 | 61088     | 23-Dec-17 | 01:19 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3015.40 | 52896     | 23-Dec-17 | 01:29 | x86      |
| Sqlagentlog.dll                              | 2017.140.3015.40 | 32928     | 23-Dec-17 | 00:18 | x64      |
| Sqlagentmail.dll                             | 2017.140.3015.40 | 53920     | 23-Dec-17 | 00:36 | x64      |
| Sqlboot.dll                                  | 2017.140.3015.40 | 195232    | 23-Dec-17 | 00:36 | x64      |
| Sqlceip.exe                                  | 14.0.3015.40     | 251040    | 23-Dec-17 | 01:32 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3015.40 | 72352     | 23-Dec-17 | 01:25 | x64      |
| Sqlctr140.dll                                | 2017.140.3015.40 | 129192    | 23-Dec-17 | 01:25 | x64      |
| Sqlctr140.dll                                | 2017.140.3015.40 | 111776    | 23-Dec-17 | 01:31 | x86      |
| Sqldk.dll                                    | 2017.140.3015.40 | 2790048   | 23-Dec-17 | 05:21 | x64      |
| Sqldtsss.dll                                 | 2017.140.3015.40 | 107168    | 23-Dec-17 | 02:27 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 2086560   | 23-Dec-17 | 00:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3332768   | 23-Dec-17 | 00:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 2033312   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 4017824   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 1442984   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3582120   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3361440   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3396256   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3475104   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 1495712   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3590816   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3814560   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3778720   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3285664   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3628192   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3772064   | 23-Dec-17 | 00:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3291296   | 23-Dec-17 | 00:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3911336   | 23-Dec-17 | 00:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3208352   | 23-Dec-17 | 00:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3779232   | 23-Dec-17 | 00:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3908256   | 23-Dec-17 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3015.40 | 3669152   | 23-Dec-17 | 00:39 | x64      |
| Sqliosim.com                                 | 2017.140.3015.40 | 313504    | 23-Dec-17 | 01:24 | x64      |
| Sqliosim.exe                                 | 2017.140.3015.40 | 3019944   | 23-Dec-17 | 02:27 | x64      |
| Sqllang.dll                                  | 2017.140.3015.40 | 41207968  | 23-Dec-17 | 05:21 | x64      |
| Sqlmin.dll                                   | 2017.140.3015.40 | 40257696  | 23-Dec-17 | 05:21 | x64      |
| Sqlolapss.dll                                | 2017.140.3015.40 | 107680    | 23-Dec-17 | 01:25 | x64      |
| Sqlos.dll                                    | 2017.140.3015.40 | 26272     | 23-Dec-17 | 00:36 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3015.40 | 67744     | 23-Dec-17 | 01:25 | x64      |
| Sqlrepss.dll                                 | 2017.140.3015.40 | 64160     | 23-Dec-17 | 01:25 | x64      |
| Sqlresld.dll                                 | 2017.140.3015.40 | 30880     | 23-Dec-17 | 01:25 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3015.40 | 32416     | 23-Dec-17 | 00:18 | x64      |
| Sqlscm.dll                                   | 2017.140.3015.40 | 70816     | 23-Dec-17 | 00:36 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3015.40 | 27808     | 23-Dec-17 | 00:18 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3015.40 | 5871264   | 23-Dec-17 | 00:18 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3015.40 | 732832    | 23-Dec-17 | 00:36 | x64      |
| Sqlservr.exe                                 | 2017.140.3015.40 | 487072    | 23-Dec-17 | 05:21 | x64      |
| Sqlsvc.dll                                   | 2017.140.3015.40 | 161440    | 23-Dec-17 | 00:36 | x64      |
| Sqltses.dll                                  | 2017.140.3015.40 | 9537184   | 23-Dec-17 | 05:21 | x64      |
| Sqsrvres.dll                                 | 2017.140.3015.40 | 260264    | 23-Dec-17 | 01:25 | x64      |
| Svl.dll                                      | 2017.140.3015.40 | 153768    | 23-Dec-17 | 01:25 | x64      |
| Xe.dll                                       | 2017.140.3015.40 | 673440    | 23-Dec-17 | 00:33 | x64      |
| Xmlrw.dll                                    | 2017.140.3015.40 | 305312    | 23-Dec-17 | 00:36 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3015.40 | 224416    | 23-Dec-17 | 00:36 | x64      |
| Xpadsi.exe                                   | 2017.140.3015.40 | 89768     | 23-Dec-17 | 01:25 | x64      |
| Xplog70.dll                                  | 2017.140.3015.40 | 75936     | 23-Dec-17 | 01:27 | x64      |
| Xpqueue.dll                                  | 2017.140.3015.40 | 74920     | 23-Dec-17 | 01:27 | x64      |
| Xprepl.dll                                   | 2017.140.3015.40 | 101536    | 23-Dec-17 | 00:36 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3015.40 | 32416     | 23-Dec-17 | 01:27 | x64      |
| Xpstar.dll                                   | 2017.140.3015.40 | 437408    | 23-Dec-17 | 00:36 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3015.40 | 180896    | 23-Dec-17 | 00:36 | x64      |
| Batchparser.dll                                             | 2017.140.3015.40 | 160416    | 23-Dec-17 | 00:18 | x86      |
| Bcp.exe                                                     | 2017.140.3015.40 | 119968    | 23-Dec-17 | 01:25 | x64      |
| Commanddest.dll                                             | 2017.140.3015.40 | 245920    | 23-Dec-17 | 01:24 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3015.40 | 116384    | 23-Dec-17 | 01:24 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3015.40 | 187552    | 23-Dec-17 | 01:24 | x64      |
| Distrib.exe                                                 | 2017.140.3015.40 | 202400    | 23-Dec-17 | 00:36 | x64      |
| Dteparse.dll                                                | 2017.140.3015.40 | 111264    | 23-Dec-17 | 01:24 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3015.40 | 89248     | 23-Dec-17 | 00:36 | x64      |
| Dtepkg.dll                                                  | 2017.140.3015.40 | 137888    | 23-Dec-17 | 01:24 | x64      |
| Dtexec.exe                                                  | 2017.140.3015.40 | 73888     | 23-Dec-17 | 01:24 | x64      |
| Dts.dll                                                     | 2017.140.3015.40 | 2998944   | 23-Dec-17 | 01:24 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3015.40 | 475296    | 23-Dec-17 | 01:24 | x64      |
| Dtsconn.dll                                                 | 2017.140.3015.40 | 497312    | 23-Dec-17 | 01:24 | x64      |
| Dtshost.exe                                                 | 2017.140.3015.40 | 103584    | 23-Dec-17 | 01:25 | x64      |
| Dtslog.dll                                                  | 2017.140.3015.40 | 120480    | 23-Dec-17 | 00:36 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3015.40 | 545440    | 23-Dec-17 | 00:36 | x64      |
| Dtspipeline.dll                                             | 2017.140.3015.40 | 1266336   | 23-Dec-17 | 01:24 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3015.40 | 48296     | 23-Dec-17 | 01:24 | x64      |
| Dtuparse.dll                                                | 2017.140.3015.40 | 89248     | 23-Dec-17 | 01:24 | x64      |
| Dtutil.exe                                                  | 2017.140.3015.40 | 147104    | 23-Dec-17 | 01:24 | x64      |
| Exceldest.dll                                               | 2017.140.3015.40 | 260768    | 23-Dec-17 | 02:21 | x64      |
| Excelsrc.dll                                                | 2017.140.3015.40 | 282784    | 23-Dec-17 | 01:24 | x64      |
| Execpackagetask.dll                                         | 2017.140.3015.40 | 168096    | 23-Dec-17 | 01:24 | x64      |
| Flatfiledest.dll                                            | 2017.140.3015.40 | 384160    | 23-Dec-17 | 01:24 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3015.40 | 396448    | 23-Dec-17 | 01:24 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3015.40 | 96424     | 23-Dec-17 | 00:36 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3015.40 | 59552     | 23-Dec-17 | 01:25 | x64      |
| Logread.exe                                                 | 2017.140.3015.40 | 634016    | 23-Dec-17 | 01:25 | x64      |
| Mergetxt.dll                                                | 2017.140.3015.40 | 63136     | 23-Dec-17 | 00:36 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.202.1       | 1381544   | 23-Dec-17 | 01:24 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 06-Nov-17 | 20:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3015.40     | 89760     | 23-Dec-17 | 02:21 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3015.40 | 1650336   | 23-Dec-17 | 02:21 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3015.40 | 152224    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3015.40 | 159392    | 23-Dec-17 | 01:18 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3015.40 | 103072    | 23-Dec-17 | 01:24 | x64      |
| Msgprox.dll                                                 | 2017.140.3015.40 | 269984    | 23-Dec-17 | 01:25 | x64      |
| Msxmlsql.dll                                                | 2017.140.3015.40 | 1448096   | 23-Dec-17 | 01:25 | x64      |
| Oledbdest.dll                                               | 2017.140.3015.40 | 261280    | 23-Dec-17 | 01:24 | x64      |
| Oledbsrc.dll                                                | 2017.140.3015.40 | 288928    | 23-Dec-17 | 01:24 | x64      |
| Osql.exe                                                    | 2017.140.3015.40 | 75432     | 23-Dec-17 | 00:18 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3015.40 | 472736    | 23-Dec-17 | 01:25 | x64      |
| Rawdest.dll                                                 | 2017.140.3015.40 | 206496    | 23-Dec-17 | 01:25 | x64      |
| Rawsource.dll                                               | 2017.140.3015.40 | 194208    | 23-Dec-17 | 01:25 | x64      |
| Rdistcom.dll                                                | 2017.140.3015.40 | 856224    | 23-Dec-17 | 01:25 | x64      |
| Recordsetdest.dll                                           | 2017.140.3015.40 | 184480    | 23-Dec-17 | 01:25 | x64      |
| Replagnt.dll                                                | 2017.140.3015.40 | 30880     | 23-Dec-17 | 01:25 | x64      |
| Repldp.dll                                                  | 2017.140.3015.40 | 290464    | 23-Dec-17 | 00:36 | x64      |
| Replerrx.dll                                                | 2017.140.3015.40 | 153760    | 23-Dec-17 | 01:27 | x64      |
| Replisapi.dll                                               | 2017.140.3015.40 | 361632    | 23-Dec-17 | 01:27 | x64      |
| Replmerg.exe                                                | 2017.140.3015.40 | 524960    | 23-Dec-17 | 01:25 | x64      |
| Replprov.dll                                                | 2017.140.3015.40 | 801440    | 23-Dec-17 | 00:36 | x64      |
| Replrec.dll                                                 | 2017.140.3015.40 | 975016    | 23-Dec-17 | 01:27 | x64      |
| Replsub.dll                                                 | 2017.140.3015.40 | 445600    | 23-Dec-17 | 01:27 | x64      |
| Replsync.dll                                                | 2017.140.3015.40 | 153760    | 23-Dec-17 | 01:27 | x64      |
| Spresolv.dll                                                | 2017.140.3015.40 | 252064    | 23-Dec-17 | 00:36 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3015.40 | 248992    | 23-Dec-17 | 01:25 | x64      |
| Sqldiag.exe                                                 | 2017.140.3015.40 | 1257632   | 23-Dec-17 | 00:36 | x64      |
| Sqldistx.dll                                                | 2017.140.3015.40 | 224936    | 23-Dec-17 | 01:25 | x64      |
| Sqlmergx.dll                                                | 2017.140.3015.40 | 360608    | 23-Dec-17 | 00:36 | x64      |
| Sqlresld.dll                                                | 2017.140.3015.40 | 28832     | 23-Dec-17 | 00:39 | x86      |
| Sqlresld.dll                                                | 2017.140.3015.40 | 30880     | 23-Dec-17 | 01:25 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3015.40 | 32416     | 23-Dec-17 | 00:18 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3015.40 | 29344     | 23-Dec-17 | 00:18 | x86      |
| Sqlscm.dll                                                  | 2017.140.3015.40 | 70816     | 23-Dec-17 | 00:36 | x64      |
| Sqlscm.dll                                                  | 2017.140.3015.40 | 60064     | 23-Dec-17 | 00:39 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3015.40 | 161440    | 23-Dec-17 | 00:36 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3015.40 | 134312    | 23-Dec-17 | 01:29 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3015.40 | 182944    | 23-Dec-17 | 01:25 | x64      |
| Sqlwep140.dll                                               | 2017.140.3015.40 | 105632    | 23-Dec-17 | 00:18 | x64      |
| Ssdebugps.dll                                               | 2017.140.3015.40 | 33440     | 23-Dec-17 | 00:36 | x64      |
| Ssisoledb.dll                                               | 2017.140.3015.40 | 216224    | 23-Dec-17 | 01:25 | x64      |
| Ssradd.dll                                                  | 2017.140.3015.40 | 74920     | 23-Dec-17 | 00:36 | x64      |
| Ssravg.dll                                                  | 2017.140.3015.40 | 74912     | 23-Dec-17 | 01:25 | x64      |
| Ssrdown.dll                                                 | 2017.140.3015.40 | 60064     | 23-Dec-17 | 01:25 | x64      |
| Ssrmax.dll                                                  | 2017.140.3015.40 | 72864     | 23-Dec-17 | 01:25 | x64      |
| Ssrmin.dll                                                  | 2017.140.3015.40 | 73376     | 23-Dec-17 | 01:25 | x64      |
| Ssrpub.dll                                                  | 2017.140.3015.40 | 60576     | 23-Dec-17 | 00:36 | x64      |
| Ssrup.dll                                                   | 2017.140.3015.40 | 60064     | 23-Dec-17 | 01:25 | x64      |
| Txagg.dll                                                   | 2017.140.3015.40 | 362144    | 23-Dec-17 | 01:25 | x64      |
| Txbdd.dll                                                   | 2017.140.3015.40 | 170144    | 23-Dec-17 | 01:25 | x64      |
| Txdatacollector.dll                                         | 2017.140.3015.40 | 360600    | 23-Dec-17 | 01:25 | x64      |
| Txdataconvert.dll                                           | 2017.140.3015.40 | 293024    | 23-Dec-17 | 01:25 | x64      |
| Txderived.dll                                               | 2017.140.3015.40 | 604320    | 23-Dec-17 | 01:25 | x64      |
| Txlookup.dll                                                | 2017.140.3015.40 | 528032    | 23-Dec-17 | 01:25 | x64      |
| Txmerge.dll                                                 | 2017.140.3015.40 | 230048    | 23-Dec-17 | 01:25 | x64      |
| Txmergejoin.dll                                             | 2017.140.3015.40 | 275616    | 23-Dec-17 | 01:25 | x64      |
| Txmulticast.dll                                             | 2017.140.3015.40 | 127648    | 23-Dec-17 | 01:25 | x64      |
| Txrowcount.dll                                              | 2017.140.3015.40 | 125608    | 23-Dec-17 | 01:25 | x64      |
| Txsort.dll                                                  | 2017.140.3015.40 | 256672    | 23-Dec-17 | 01:25 | x64      |
| Txsplit.dll                                                 | 2017.140.3015.40 | 596640    | 23-Dec-17 | 01:25 | x64      |
| Txunionall.dll                                              | 2017.140.3015.40 | 181928    | 23-Dec-17 | 01:25 | x64      |
| Xe.dll                                                      | 2017.140.3015.40 | 673440    | 23-Dec-17 | 00:33 | x64      |
| Xmlrw.dll                                                   | 2017.140.3015.40 | 305312    | 23-Dec-17 | 00:36 | x64      |
| Xmlsub.dll                                                  | 2017.140.3015.40 | 260256    | 23-Dec-17 | 01:27 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3015.40 | 1122464   | 23-Dec-17 | 02:27 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlsatellite.dll              | 2017.140.3015.40 | 920736    | 23-Dec-17 | 02:27 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3015.40 | 667296    | 23-Dec-17 | 00:36 | x64      |
| Fdhost.exe               | 2017.140.3015.40 | 114336    | 23-Dec-17 | 02:27 | x64      |
| Fdlauncher.exe           | 2017.140.3015.40 | 62112     | 23-Dec-17 | 00:36 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlft140ph.dll           | 2017.140.3015.40 | 67752     | 23-Dec-17 | 00:36 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3015.40     | 23712     | 23-Dec-17 | 00:36 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 20-Oct-17 | 10:17 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 20-Oct-17 | 10:17 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 20-Oct-17 | 10:17 | x86      |
| Commanddest.dll                                               | 2017.140.3015.40 | 245920    | 23-Dec-17 | 01:24 | x64      |
| Commanddest.dll                                               | 2017.140.3015.40 | 200864    | 23-Dec-17 | 01:29 | x86      |
| Dteparse.dll                                                  | 2017.140.3015.40 | 111264    | 23-Dec-17 | 01:24 | x64      |
| Dteparse.dll                                                  | 2017.140.3015.40 | 100512    | 23-Dec-17 | 01:29 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3015.40 | 89248     | 23-Dec-17 | 00:36 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3015.40 | 83616     | 23-Dec-17 | 01:29 | x86      |
| Dtepkg.dll                                                    | 2017.140.3015.40 | 137888    | 23-Dec-17 | 01:24 | x64      |
| Dtepkg.dll                                                    | 2017.140.3015.40 | 116896    | 23-Dec-17 | 01:29 | x86      |
| Dtexec.exe                                                    | 2017.140.3015.40 | 73888     | 23-Dec-17 | 01:24 | x64      |
| Dtexec.exe                                                    | 2017.140.3015.40 | 67744     | 23-Dec-17 | 01:29 | x86      |
| Dts.dll                                                       | 2017.140.3015.40 | 2998944   | 23-Dec-17 | 01:24 | x64      |
| Dts.dll                                                       | 2017.140.3015.40 | 2549920   | 23-Dec-17 | 01:29 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3015.40 | 475296    | 23-Dec-17 | 01:24 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3015.40 | 417952    | 23-Dec-17 | 01:29 | x86      |
| Dtsconn.dll                                                   | 2017.140.3015.40 | 497312    | 23-Dec-17 | 01:24 | x64      |
| Dtsconn.dll                                                   | 2017.140.3015.40 | 399016    | 23-Dec-17 | 01:29 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3015.40 | 111776    | 23-Dec-17 | 01:24 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3015.40 | 95392     | 23-Dec-17 | 01:29 | x86      |
| Dtshost.exe                                                   | 2017.140.3015.40 | 103584    | 23-Dec-17 | 01:25 | x64      |
| Dtshost.exe                                                   | 2017.140.3015.40 | 89760     | 23-Dec-17 | 01:30 | x86      |
| Dtslog.dll                                                    | 2017.140.3015.40 | 120480    | 23-Dec-17 | 00:36 | x64      |
| Dtslog.dll                                                    | 2017.140.3015.40 | 103072    | 23-Dec-17 | 01:29 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3015.40 | 545440    | 23-Dec-17 | 00:36 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3015.40 | 541344    | 23-Dec-17 | 01:31 | x86      |
| Dtspipeline.dll                                               | 2017.140.3015.40 | 1266336   | 23-Dec-17 | 01:24 | x64      |
| Dtspipeline.dll                                               | 2017.140.3015.40 | 1058976   | 23-Dec-17 | 01:29 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3015.40 | 48296     | 23-Dec-17 | 01:24 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3015.40 | 42656     | 23-Dec-17 | 01:29 | x86      |
| Dtuparse.dll                                                  | 2017.140.3015.40 | 89248     | 23-Dec-17 | 01:24 | x64      |
| Dtuparse.dll                                                  | 2017.140.3015.40 | 80032     | 23-Dec-17 | 01:29 | x86      |
| Dtutil.exe                                                    | 2017.140.3015.40 | 147104    | 23-Dec-17 | 01:24 | x64      |
| Dtutil.exe                                                    | 2017.140.3015.40 | 126120    | 23-Dec-17 | 01:29 | x86      |
| Exceldest.dll                                                 | 2017.140.3015.40 | 214688    | 23-Dec-17 | 01:29 | x86      |
| Exceldest.dll                                                 | 2017.140.3015.40 | 260768    | 23-Dec-17 | 02:21 | x64      |
| Excelsrc.dll                                                  | 2017.140.3015.40 | 282784    | 23-Dec-17 | 01:24 | x64      |
| Excelsrc.dll                                                  | 2017.140.3015.40 | 230560    | 23-Dec-17 | 01:29 | x86      |
| Execpackagetask.dll                                           | 2017.140.3015.40 | 168096    | 23-Dec-17 | 01:24 | x64      |
| Execpackagetask.dll                                           | 2017.140.3015.40 | 135336    | 23-Dec-17 | 01:29 | x86      |
| Flatfiledest.dll                                              | 2017.140.3015.40 | 384160    | 23-Dec-17 | 01:24 | x64      |
| Flatfiledest.dll                                              | 2017.140.3015.40 | 330920    | 23-Dec-17 | 01:29 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3015.40 | 396448    | 23-Dec-17 | 01:24 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3015.40 | 342176    | 23-Dec-17 | 01:29 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3015.40 | 96424     | 23-Dec-17 | 00:36 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3015.40 | 80544     | 23-Dec-17 | 01:29 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3015.40     | 476832    | 23-Dec-17 | 02:21 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3015.40     | 477344    | 23-Dec-17 | 02:34 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.202.1       | 1381536   | 23-Dec-17 | 00:39 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.202.1       | 1381544   | 23-Dec-17 | 01:24 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 06-Nov-17 | 20:05 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3015.40 | 112288    | 23-Dec-17 | 01:25 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3015.40 | 107168    | 23-Dec-17 | 01:29 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3015.40     | 89760     | 23-Dec-17 | 02:21 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3015.40     | 89760     | 23-Dec-17 | 02:34 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3015.40     | 493736    | 23-Dec-17 | 00:36 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3015.40     | 493728    | 23-Dec-17 | 00:39 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3015.40     | 83624     | 23-Dec-17 | 02:21 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3015.40     | 83616     | 23-Dec-17 | 02:34 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3015.40     | 415392    | 23-Dec-17 | 02:21 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3015.40     | 415392    | 23-Dec-17 | 02:34 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3015.40 | 152224    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3015.40 | 141984    | 23-Dec-17 | 02:33 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3015.40 | 159392    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3015.40 | 145568    | 23-Dec-17 | 01:20 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3015.40     | 219808    | 23-Dec-17 | 02:21 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3015.40 | 103072    | 23-Dec-17 | 01:24 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3015.40 | 90272     | 23-Dec-17 | 01:29 | x86      |
| Msmdpp.dll                                                    | 2017.140.202.1   | 9194144   | 23-Dec-17 | 01:25 | x64      |
| Oledbdest.dll                                                 | 2017.140.3015.40 | 261280    | 23-Dec-17 | 01:24 | x64      |
| Oledbdest.dll                                                 | 2017.140.3015.40 | 214688    | 23-Dec-17 | 01:29 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3015.40 | 288928    | 23-Dec-17 | 01:24 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3015.40 | 233120    | 23-Dec-17 | 01:29 | x86      |
| Rawdest.dll                                                   | 2017.140.3015.40 | 206496    | 23-Dec-17 | 01:25 | x64      |
| Rawdest.dll                                                   | 2017.140.3015.40 | 166568    | 23-Dec-17 | 01:30 | x86      |
| Rawsource.dll                                                 | 2017.140.3015.40 | 194208    | 23-Dec-17 | 01:25 | x64      |
| Rawsource.dll                                                 | 2017.140.3015.40 | 153248    | 23-Dec-17 | 01:30 | x86      |
| Recordsetdest.dll                                             | 2017.140.3015.40 | 184480    | 23-Dec-17 | 01:25 | x64      |
| Recordsetdest.dll                                             | 2017.140.3015.40 | 149152    | 23-Dec-17 | 01:30 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlceip.exe                                                   | 14.0.3015.40     | 251040    | 23-Dec-17 | 01:32 | x86      |
| Sqldest.dll                                                   | 2017.140.3015.40 | 260768    | 23-Dec-17 | 01:25 | x64      |
| Sqldest.dll                                                   | 2017.140.3015.40 | 213672    | 23-Dec-17 | 01:29 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3015.40 | 182944    | 23-Dec-17 | 01:25 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3015.40 | 155296    | 23-Dec-17 | 01:29 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3015.40 | 216224    | 23-Dec-17 | 01:25 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3015.40 | 176800    | 23-Dec-17 | 01:29 | x86      |
| Txagg.dll                                                     | 2017.140.3015.40 | 362144    | 23-Dec-17 | 01:25 | x64      |
| Txagg.dll                                                     | 2017.140.3015.40 | 302248    | 23-Dec-17 | 01:30 | x86      |
| Txbdd.dll                                                     | 2017.140.3015.40 | 170144    | 23-Dec-17 | 01:25 | x64      |
| Txbdd.dll                                                     | 2017.140.3015.40 | 136352    | 23-Dec-17 | 01:30 | x86      |
| Txbestmatch.dll                                               | 2017.140.3015.40 | 605344    | 23-Dec-17 | 01:25 | x64      |
| Txbestmatch.dll                                               | 2017.140.3015.40 | 493216    | 23-Dec-17 | 01:30 | x86      |
| Txcache.dll                                                   | 2017.140.3015.40 | 180384    | 23-Dec-17 | 01:25 | x64      |
| Txcache.dll                                                   | 2017.140.3015.40 | 146080    | 23-Dec-17 | 01:30 | x86      |
| Txcharmap.dll                                                 | 2017.140.3015.40 | 286880    | 23-Dec-17 | 01:25 | x64      |
| Txcharmap.dll                                                 | 2017.140.3015.40 | 249000    | 23-Dec-17 | 01:30 | x86      |
| Txcopymap.dll                                                 | 2017.140.3015.40 | 180384    | 23-Dec-17 | 00:36 | x64      |
| Txcopymap.dll                                                 | 2017.140.3015.40 | 148128    | 23-Dec-17 | 01:30 | x86      |
| Txdataconvert.dll                                             | 2017.140.3015.40 | 293024    | 23-Dec-17 | 01:25 | x64      |
| Txdataconvert.dll                                             | 2017.140.3015.40 | 253096    | 23-Dec-17 | 01:30 | x86      |
| Txderived.dll                                                 | 2017.140.3015.40 | 604320    | 23-Dec-17 | 01:25 | x64      |
| Txderived.dll                                                 | 2017.140.3015.40 | 515744    | 23-Dec-17 | 01:30 | x86      |
| Txfileextractor.dll                                           | 2017.140.3015.40 | 198824    | 23-Dec-17 | 01:25 | x64      |
| Txfileextractor.dll                                           | 2017.140.3015.40 | 160928    | 23-Dec-17 | 01:30 | x86      |
| Txfileinserter.dll                                            | 2017.140.3015.40 | 196768    | 23-Dec-17 | 01:25 | x64      |
| Txfileinserter.dll                                            | 2017.140.3015.40 | 159392    | 23-Dec-17 | 01:30 | x86      |
| Txgroupdups.dll                                               | 2017.140.3015.40 | 290464    | 23-Dec-17 | 01:25 | x64      |
| Txgroupdups.dll                                               | 2017.140.3015.40 | 231072    | 23-Dec-17 | 01:30 | x86      |
| Txlineage.dll                                                 | 2017.140.3015.40 | 110248    | 23-Dec-17 | 01:30 | x86      |
| Txlineage.dll                                                 | 2017.140.3015.40 | 136872    | 23-Dec-17 | 02:27 | x64      |
| Txlookup.dll                                                  | 2017.140.3015.40 | 528032    | 23-Dec-17 | 01:25 | x64      |
| Txlookup.dll                                                  | 2017.140.3015.40 | 446624    | 23-Dec-17 | 01:30 | x86      |
| Txmerge.dll                                                   | 2017.140.3015.40 | 230048    | 23-Dec-17 | 01:25 | x64      |
| Txmerge.dll                                                   | 2017.140.3015.40 | 176800    | 23-Dec-17 | 01:30 | x86      |
| Txmergejoin.dll                                               | 2017.140.3015.40 | 275616    | 23-Dec-17 | 01:25 | x64      |
| Txmergejoin.dll                                               | 2017.140.3015.40 | 221864    | 23-Dec-17 | 01:30 | x86      |
| Txmulticast.dll                                               | 2017.140.3015.40 | 127648    | 23-Dec-17 | 01:25 | x64      |
| Txmulticast.dll                                               | 2017.140.3015.40 | 102560    | 23-Dec-17 | 01:30 | x86      |
| Txpivot.dll                                                   | 2017.140.3015.40 | 224928    | 23-Dec-17 | 01:25 | x64      |
| Txpivot.dll                                                   | 2017.140.3015.40 | 180384    | 23-Dec-17 | 01:30 | x86      |
| Txrowcount.dll                                                | 2017.140.3015.40 | 125608    | 23-Dec-17 | 01:25 | x64      |
| Txrowcount.dll                                                | 2017.140.3015.40 | 101536    | 23-Dec-17 | 01:30 | x86      |
| Txsampling.dll                                                | 2017.140.3015.40 | 172704    | 23-Dec-17 | 01:25 | x64      |
| Txsampling.dll                                                | 2017.140.3015.40 | 135840    | 23-Dec-17 | 01:30 | x86      |
| Txscd.dll                                                     | 2017.140.3015.40 | 220832    | 23-Dec-17 | 01:25 | x64      |
| Txscd.dll                                                     | 2017.140.3015.40 | 170144    | 23-Dec-17 | 01:30 | x86      |
| Txsort.dll                                                    | 2017.140.3015.40 | 256672    | 23-Dec-17 | 01:25 | x64      |
| Txsort.dll                                                    | 2017.140.3015.40 | 208032    | 23-Dec-17 | 01:30 | x86      |
| Txsplit.dll                                                   | 2017.140.3015.40 | 596640    | 23-Dec-17 | 01:25 | x64      |
| Txsplit.dll                                                   | 2017.140.3015.40 | 510624    | 23-Dec-17 | 01:30 | x86      |
| Txtermextraction.dll                                          | 2017.140.3015.40 | 8676512   | 23-Dec-17 | 01:25 | x64      |
| Txtermextraction.dll                                          | 2017.140.3015.40 | 8615072   | 23-Dec-17 | 02:35 | x86      |
| Txtermlookup.dll                                              | 2017.140.3015.40 | 4157088   | 23-Dec-17 | 01:25 | x64      |
| Txtermlookup.dll                                              | 2017.140.3015.40 | 4106912   | 23-Dec-17 | 01:31 | x86      |
| Txunionall.dll                                                | 2017.140.3015.40 | 181928    | 23-Dec-17 | 01:25 | x64      |
| Txunionall.dll                                                | 2017.140.3015.40 | 139424    | 23-Dec-17 | 01:30 | x86      |
| Txunpivot.dll                                                 | 2017.140.3015.40 | 199840    | 23-Dec-17 | 01:25 | x64      |
| Txunpivot.dll                                                 | 2017.140.3015.40 | 160416    | 23-Dec-17 | 01:30 | x86      |
| Xe.dll                                                        | 2017.140.3015.40 | 673440    | 23-Dec-17 | 00:33 | x64      |
| Xe.dll                                                        | 2017.140.3015.40 | 595616    | 23-Dec-17 | 01:18 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.17     | 523944    | 15-Dec-17 | 04:50 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.17 | 78504     | 15-Dec-17 | 04:50 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.17     | 45736     | 15-Dec-17 | 04:50 | x86      |
| Instapi140.dll                                                       | 2017.140.3015.40 | 70304     | 23-Dec-17 | 00:18 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.17     | 74920     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.17     | 213672    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.17     | 1799336   | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.17     | 116904    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.17     | 390312    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.17     | 196264    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.17     | 131240    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.17     | 63144     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.17     | 55464     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.17     | 93864     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.17     | 792744    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.17     | 87720     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.17     | 77992     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.17     | 42152     | 15-Dec-17 | 05:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.17     | 37032     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.17     | 47784     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.17     | 27304     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.17     | 32424     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.17     | 129704    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.17     | 95400     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.17     | 109224    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.17     | 264360    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 105128    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 119464    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 122536    | 15-Dec-17 | 05:05 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 118952    | 15-Dec-17 | 05:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 129192    | 15-Dec-17 | 04:57 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 121512    | 15-Dec-17 | 05:17 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 116392    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 149672    | 15-Dec-17 | 04:53 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 103080    | 15-Dec-17 | 04:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.17     | 118440    | 15-Dec-17 | 05:05 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.17     | 70312     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.17     | 28840     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.17     | 43688     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.17     | 83624     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.17     | 136872    | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.17     | 2341032   | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.17     | 3860136   | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 110760    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 123560    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 128168    | 15-Dec-17 | 05:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 124072    | 15-Dec-17 | 05:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 136872    | 15-Dec-17 | 04:57 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 124584    | 15-Dec-17 | 05:17 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 121512    | 15-Dec-17 | 04:47 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 156328    | 15-Dec-17 | 04:53 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 108712    | 15-Dec-17 | 04:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.17     | 123048    | 15-Dec-17 | 05:05 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.17     | 70312     | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.17     | 2756264   | 15-Dec-17 | 04:50 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.17     | 751784    | 15-Dec-17 | 04:50 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3015.40 | 407200    | 23-Dec-17 | 00:36 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3015.40 | 7322784   | 23-Dec-17 | 02:13 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3015.40 | 2263200   | 23-Dec-17 | 00:36 | x64      |
| Secforwarder.dll                                                     | 2017.140.3015.40 | 37536     | 23-Dec-17 | 01:22 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.17 | 64680     | 15-Dec-17 | 04:47 | x64      |
| Sqldk.dll                                                            | 2017.140.3015.40 | 2706944   | 23-Dec-17 | 00:34 | x64      |
| Sqldumper.exe                                                        | 2017.140.3015.40 | 140448    | 23-Dec-17 | 00:33 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 1495712   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3908256   | 23-Dec-17 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3208352   | 23-Dec-17 | 00:37 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3911336   | 23-Dec-17 | 00:36 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3814560   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 2086560   | 23-Dec-17 | 00:33 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 2033312   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3582120   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3590816   | 23-Dec-17 | 00:35 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 1442984   | 23-Dec-17 | 00:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3015.40 | 3778720   | 23-Dec-17 | 00:35 | x64      |
| Sqlos.dll                                                            | 2017.140.3015.40 | 26272     | 23-Dec-17 | 00:36 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.17 | 4348072   | 15-Dec-17 | 04:51 | x64      |
| Sqltses.dll                                                          | 2017.140.3015.40 | 9690624   | 23-Dec-17 | 01:18 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3015.40     | 23712     | 23-Dec-17 | 00:36 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |

SQL Server 2017 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                  | 2017.140.3015.40 | 1448608   | 23-Dec-17 | 01:31 | x86      |
| Dtaengine.exe                                  | 2017.140.3015.40 | 204448    | 23-Dec-17 | 01:29 | x86      |
| Dteparse.dll                                   | 2017.140.3015.40 | 111264    | 23-Dec-17 | 01:24 | x64      |
| Dteparse.dll                                   | 2017.140.3015.40 | 100512    | 23-Dec-17 | 01:29 | x86      |
| Dteparsemgd.dll                                | 2017.140.3015.40 | 89248     | 23-Dec-17 | 00:36 | x64      |
| Dteparsemgd.dll                                | 2017.140.3015.40 | 83616     | 23-Dec-17 | 01:29 | x86      |
| Dtepkg.dll                                     | 2017.140.3015.40 | 137888    | 23-Dec-17 | 01:24 | x64      |
| Dtepkg.dll                                     | 2017.140.3015.40 | 116896    | 23-Dec-17 | 01:29 | x86      |
| Dtexec.exe                                     | 2017.140.3015.40 | 73888     | 23-Dec-17 | 01:24 | x64      |
| Dtexec.exe                                     | 2017.140.3015.40 | 67744     | 23-Dec-17 | 01:29 | x86      |
| Dts.dll                                        | 2017.140.3015.40 | 2998944   | 23-Dec-17 | 01:24 | x64      |
| Dts.dll                                        | 2017.140.3015.40 | 2549920   | 23-Dec-17 | 01:29 | x86      |
| Dtscomexpreval.dll                             | 2017.140.3015.40 | 475296    | 23-Dec-17 | 01:24 | x64      |
| Dtscomexpreval.dll                             | 2017.140.3015.40 | 417952    | 23-Dec-17 | 01:29 | x86      |
| Dtsconn.dll                                    | 2017.140.3015.40 | 497312    | 23-Dec-17 | 01:24 | x64      |
| Dtsconn.dll                                    | 2017.140.3015.40 | 399016    | 23-Dec-17 | 01:29 | x86      |
| Dtshost.exe                                    | 2017.140.3015.40 | 103584    | 23-Dec-17 | 01:25 | x64      |
| Dtshost.exe                                    | 2017.140.3015.40 | 89760     | 23-Dec-17 | 01:30 | x86      |
| Dtslog.dll                                     | 2017.140.3015.40 | 120480    | 23-Dec-17 | 00:36 | x64      |
| Dtslog.dll                                     | 2017.140.3015.40 | 103072    | 23-Dec-17 | 01:29 | x86      |
| Dtsmsg140.dll                                  | 2017.140.3015.40 | 545440    | 23-Dec-17 | 00:36 | x64      |
| Dtsmsg140.dll                                  | 2017.140.3015.40 | 541344    | 23-Dec-17 | 01:31 | x86      |
| Dtspipeline.dll                                | 2017.140.3015.40 | 1266336   | 23-Dec-17 | 01:24 | x64      |
| Dtspipeline.dll                                | 2017.140.3015.40 | 1058976   | 23-Dec-17 | 01:29 | x86      |
| Dtspipelineperf140.dll                         | 2017.140.3015.40 | 48296     | 23-Dec-17 | 01:24 | x64      |
| Dtspipelineperf140.dll                         | 2017.140.3015.40 | 42656     | 23-Dec-17 | 01:29 | x86      |
| Dtuparse.dll                                   | 2017.140.3015.40 | 89248     | 23-Dec-17 | 01:24 | x64      |
| Dtuparse.dll                                   | 2017.140.3015.40 | 80032     | 23-Dec-17 | 01:29 | x86      |
| Dtutil.exe                                     | 2017.140.3015.40 | 147104    | 23-Dec-17 | 01:24 | x64      |
| Dtutil.exe                                     | 2017.140.3015.40 | 126120    | 23-Dec-17 | 01:29 | x86      |
| Exceldest.dll                                  | 2017.140.3015.40 | 214688    | 23-Dec-17 | 01:29 | x86      |
| Exceldest.dll                                  | 2017.140.3015.40 | 260768    | 23-Dec-17 | 02:21 | x64      |
| Excelsrc.dll                                   | 2017.140.3015.40 | 282784    | 23-Dec-17 | 01:24 | x64      |
| Excelsrc.dll                                   | 2017.140.3015.40 | 230560    | 23-Dec-17 | 01:29 | x86      |
| Flatfiledest.dll                               | 2017.140.3015.40 | 384160    | 23-Dec-17 | 01:24 | x64      |
| Flatfiledest.dll                               | 2017.140.3015.40 | 330920    | 23-Dec-17 | 01:29 | x86      |
| Flatfilesrc.dll                                | 2017.140.3015.40 | 396448    | 23-Dec-17 | 01:24 | x64      |
| Flatfilesrc.dll                                | 2017.140.3015.40 | 342176    | 23-Dec-17 | 01:29 | x86      |
| Foreachfileenumerator.dll                      | 2017.140.3015.40 | 96424     | 23-Dec-17 | 00:36 | x64      |
| Foreachfileenumerator.dll                      | 2017.140.3015.40 | 80544     | 23-Dec-17 | 01:29 | x86      |
| Microsoft.sqlserver.astasksui.dll              | 14.0.3015.40     | 184480    | 23-Dec-17 | 04:52 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3015.40     | 406688    | 23-Dec-17 | 01:25 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3015.40     | 406688    | 23-Dec-17 | 01:29 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3015.40     | 2093216   | 23-Dec-17 | 01:25 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3015.40     | 2093216   | 23-Dec-17 | 01:29 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3015.40 | 152224    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll   | 2017.140.3015.40 | 141984    | 23-Dec-17 | 02:33 | x86      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3015.40 | 159392    | 23-Dec-17 | 01:18 | x64      |
| Microsoft.sqlserver.xevent.dll                 | 2017.140.3015.40 | 145568    | 23-Dec-17 | 01:20 | x86      |
| Msdtssrvrutil.dll                              | 2017.140.3015.40 | 103072    | 23-Dec-17 | 01:24 | x64      |
| Msdtssrvrutil.dll                              | 2017.140.3015.40 | 90272     | 23-Dec-17 | 01:29 | x86      |
| Msmgdsrv.dll                                   | 2017.140.202.1   | 7310504   | 23-Dec-17 | 00:39 | x86      |
| Oledbdest.dll                                  | 2017.140.3015.40 | 261280    | 23-Dec-17 | 01:24 | x64      |
| Oledbdest.dll                                  | 2017.140.3015.40 | 214688    | 23-Dec-17 | 01:29 | x86      |
| Oledbsrc.dll                                   | 2017.140.3015.40 | 288928    | 23-Dec-17 | 01:24 | x64      |
| Oledbsrc.dll                                   | 2017.140.3015.40 | 233120    | 23-Dec-17 | 01:29 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2017.140.3015.40 | 100512    | 23-Dec-17 | 00:36 | x64      |
| Sqlresld.dll                                   | 2017.140.3015.40 | 28832     | 23-Dec-17 | 00:39 | x86      |
| Sqlresld.dll                                   | 2017.140.3015.40 | 30880     | 23-Dec-17 | 01:25 | x64      |
| Sqlresourceloader.dll                          | 2017.140.3015.40 | 32416     | 23-Dec-17 | 00:18 | x64      |
| Sqlresourceloader.dll                          | 2017.140.3015.40 | 29344     | 23-Dec-17 | 00:18 | x86      |
| Sqlscm.dll                                     | 2017.140.3015.40 | 70816     | 23-Dec-17 | 00:36 | x64      |
| Sqlscm.dll                                     | 2017.140.3015.40 | 60064     | 23-Dec-17 | 00:39 | x86      |
| Sqlsvc.dll                                     | 2017.140.3015.40 | 161440    | 23-Dec-17 | 00:36 | x64      |
| Sqlsvc.dll                                     | 2017.140.3015.40 | 134312    | 23-Dec-17 | 01:29 | x86      |
| Sqltaskconnections.dll                         | 2017.140.3015.40 | 182944    | 23-Dec-17 | 01:25 | x64      |
| Sqltaskconnections.dll                         | 2017.140.3015.40 | 155296    | 23-Dec-17 | 01:29 | x86      |
| Txdataconvert.dll                              | 2017.140.3015.40 | 293024    | 23-Dec-17 | 01:25 | x64      |
| Txdataconvert.dll                              | 2017.140.3015.40 | 253096    | 23-Dec-17 | 01:30 | x86      |
| Xe.dll                                         | 2017.140.3015.40 | 673440    | 23-Dec-17 | 00:33 | x64      |
| Xe.dll                                         | 2017.140.3015.40 | 595616    | 23-Dec-17 | 01:18 | x86      |
| Xmlrw.dll                                      | 2017.140.3015.40 | 305312    | 23-Dec-17 | 00:36 | x64      |
| Xmlrw.dll                                      | 2017.140.3015.40 | 257696    | 23-Dec-17 | 01:31 | x86      |
| Xmlrwbin.dll                                   | 2017.140.3015.40 | 224416    | 23-Dec-17 | 00:36 | x64      |
| Xmlrwbin.dll                                   | 2017.140.3015.40 | 189600    | 23-Dec-17 | 01:31 | x86      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2017.

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

This article also provides important information about the following situations:

- [**Pacemaker**](#pacemaker): A behavioral change is made in distributions that use the latest available version of Pacemaker. Mitigation methods are provided.

- [**Query Store**](#query-store): You must run this script if you use the Query Store and you have previously installed Microsoft SQL Server 2017 Cumulative Update 2 (CU2).

### Analysis Services CU build version

Beginning in Microsoft SQL Server 2017, the Analysis Services build version number and SQL Server Database Engine build version number don't match. For more information, see [Verify Analysis Services cumulative update build version](/sql/analysis-services/instances/analysis-services-component-version).

### Cumulative updates (CU)

Cumulative updates (CU) are now available at the Microsoft Download Center.

Only the most recent CU that was released for SQL Server 2017 is available at the Download Center.

CU packages for Linux are available at https://packages.microsoft.com.

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU.
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
- We recommend that you test SQL Server CUs before you deploy them to production environments.

</details>

<details>
<summary><b>Pacemaker notice</b></summary><a id="pacemaker"></a>

**IMPORTANT**

All distributions (including RHEL 7.3 and 7.4) that use the latest available **Pacemaker package 1.1.18-11.el7** introduce a behavior change for the `start-failure-is-fatal` cluster setting if its value is `false`. This change affects the failover workflow. If a primary replica experiences an outage, the cluster is expected to fail over to one of the available secondary replicas. Instead, users will notice that the cluster keeps trying to start the failed primary replica. If that primary never comes online (because of a permanent outage), the cluster never fails over to another available secondary replica.

This issue affects all SQL Server versions, regardless of the cumulative update version that they are on.

To mitigate the issue, use either of the following methods.

### Method 1

Follow these steps:

1. Remove the `start-failure-is-fatal` override from the existing cluster.

    \# RHEL, Ubuntu pcs property unset start-failure-is-fatal # or pcs property set start-failure-is-fatal=true # SLES crm configure property start-failure-is-fatal=true

1. Decrease the `cluster-recheck-interval` value.

    \# RHEL, Ubuntu pcs property set cluster-recheck-interval=\<Xmin> # SLES crm configure property cluster-recheck-interval=\<Xmin>

1. Add the `failure-timeout` meta property to each AG resource.

    \# RHEL, Ubuntu pcs resource update ag1 meta failure-timeout=60s # SLES crm configure edit ag1 # In the text editor, add \`meta failure-timeout=60s\` after any \`param\`s and before any \`op\`s

    > [!NOTE]
    > In this code, substitute the value for \<Xmin> as appropriate. If a replica goes down, the cluster tries to restart the replica at an interval that is bound by the `failure-timeout` value and the `cluster-recheck-interval` value. For example, if `failure-timeout` is set to 60 seconds and `cluster-recheck-interval` is set to 120 seconds, the restart is tried at an interval that is greater than 60 seconds but less than 120 seconds. We recommend that you set `failure-timeout` to `60s` and `cluster-recheck-interval` to a value that is greater than 60 seconds. We recommend that you do not set `cluster-recheck-interval` to a small value. For more information, refer to the Pacemaker documentation or consult the system provider.

### Method 2

Revert to Pacemaker version 1.1.16.

</details>

<details>
<summary><b>Query Store notice</b></summary><a id="query-store"></a>

**IMPORTANT**

You must run this script if you use Query Store and you're updating from SQL Server 2017 Cumulative Update 2 (CU2) directly to SQL Server 2017 Cumulative Update 3 (CU3) or any later cumulative update. You don't have to run this script if you have previously installed SQL Server 2017 Cumulative Update 3 (CU3) or any later SQL Server 2017 cumulative update.

```sql
SET NOCOUNT ON;
DROP TABLE IF EXISTS #tmpUserDBs;

SELECT [database_id], 0 AS [IsDone]
INTO #tmpUserDBs
FROM master.sys.databases
WHERE [database_id] > 4
 AND [state] = 0 -- must be ONLINE
 AND is_read_only = 0 -- cannot be READ_ONLY
 AND [database_id] NOT IN (SELECT dr.database_id FROM sys.dm_hadr_database_replica_states dr -- Except all local Always On secondary replicas
  INNER JOIN sys.dm_hadr_availability_replica_states rs ON dr.group_id = rs.group_id
  INNER JOIN sys.databases d ON dr.database_id = d.database_id
  WHERE rs.role = 2 -- Is Secondary
   AND dr.is_local = 1
   AND rs.is_local = 1)

DECLARE @userDB sysname;

WHILE (SELECT COUNT([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0) > 0
BEGIN
 SELECT TOP 1 @userDB = DB_NAME([database_id]) FROM #tmpUserDBs WHERE [IsDone] = 0

 -- PRINT 'Working on database ' + @userDB

 EXEC ('USE [' + @userDB + '];
DECLARE @clearPlan bigint, @clearQry bigint;
IF EXISTS (SELECT [actual_state] FROM sys.database_query_store_options WHERE [actual_state] IN (1,2))
BEGIN
 IF EXISTS (SELECT plan_id FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27'')
 BEGIN
  DROP TABLE IF EXISTS #tmpclearPlans;

  SELECT plan_id, query_id, 0 AS [IsDone]
  INTO #tmpclearPlans
  FROM sys.query_store_plan WHERE engine_version = ''14.0.3008.27''

  WHILE (SELECT COUNT(plan_id) FROM #tmpclearPlans WHERE [IsDone] = 0) > 0
  BEGIN
   SELECT TOP 1 @clearPlan = plan_id, @clearQry = query_id FROM #tmpclearPlans WHERE [IsDone] = 0
   EXECUTE sys.sp_query_store_unforce_plan @clearQry, @clearPlan;
   EXECUTE sys.sp_query_store_remove_plan @clearPlan;

   UPDATE #tmpclearPlans
   SET [IsDone] = 1
   WHERE plan_id = @clearPlan AND query_id = @clearQry
  END;

  PRINT ''- Cleared possibly affected plans in database [' + @userDB + ']''
 END
 ELSE
 BEGIN
  PRINT ''- No affected plans in database [' + @userDB + ']''
 END
END
ELSE
BEGIN
 PRINT ''- Query Store not enabled in database [' + @userDB + ']''
END')
  UPDATE #tmpUserDBs
  SET [IsDone] = 1
  WHERE [database_id] = DB_ID(@userDB)
END
```

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

One CU package includes all available updates for all SQL Server 2017 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2017**.
1. Press and hold (or right-click) the entry, and then select **Uninstall**.

</details>

<details>
<summary><b>How to uninstall this update on Linux</b></summary>

To uninstall this CU on Linux, you must roll back the package to the previous version. For more information about how to roll back the installation, see [Rollback SQL Server](/sql/linux/sql-server-linux-setup#rollback).

</details>

**Third-party information disclaimer**

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
