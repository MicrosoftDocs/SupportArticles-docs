---
title: Cumulative update 6 for SQL Server 2017 (KB4101464)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 6 (KB4101464).
ms.date: 08/04/2023
ms.custom: KB4101464
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4101464 - Cumulative Update 6 for SQL Server 2017

_Release Date:_ &nbsp; April 17, 2018  
_Version:_ &nbsp; 14.0.3025.34

## Summary

This article describes Cumulative Update package 6 (CU6) for Microsoft SQL Server 2017. This update contains 38 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 5, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3025.34**, file version: **2017.140.3025.34**
- Analysis Services - Product version: **14.0.204.1**, file version: **2017.140.204.1**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="11642085">[11642085](#11642085)</a> | [FIX: A calculation error occurs when a secured measure is queried in SSAS 2017 (KB4098732)](https://support.microsoft.com/help/4098732) | Analysis Services | Server | Windows |
| <a id="11701140">[11701140](#11701140)</a> | [FIX: Access violation occurs when executing a DAX query on a tabular model in SQL Server 2014 and 2017 Analysis Services (KB4086173)](https://support.microsoft.com/help/4086173) | Analysis Services | Server | Windows |
| <a id="11701179">[11701179](#11701179)</a> | [FIX: "DirectQuery may not be used with this data source" error when you browse a Direct Query model in SQL Server (KB4093226)](https://support.microsoft.com/help/4093226) | Analysis Services | Server | Windows |
| <a id="11701193">[11701193](#11701193)</a> | [FIX: Unexpected error when you create a subcube in SQL Server 2016 and 2017 Analysis Services (Multidimensional model) (KB4074862)](https://support.microsoft.com/help/4074862) | Analysis Services | Server | Windows |
| <a id="11701196">[11701196](#11701196)</a> | [FIX: SSAS may crash when you run a DAX query by using a non-admin Windows user in SQL Server 2016 and 2017 (KB4083949)](https://support.microsoft.com/help/4083949) | Analysis Services | Server | Windows |
| <a id="11701201">[11701201](#11701201)</a> | [FIX: SSAS stops responding when you run an MDX query in SQL Server 2016 and 2017 Analysis Services (Multidimensional model) (KB4086136)](https://support.microsoft.com/help/4086136) | Analysis Services | Server | Windows |
| <a id="11701208">[11701208](#11701208)</a> | [FIX: Out of memory occurs and query fails when you run MDX query with NON EMPTY option in SSAS (KB4089623)](https://support.microsoft.com/help/4089623) | Analysis Services | Server | Windows |
| <a id="11706961">[11706961](#11706961)</a> | [FIX: Memory gets exhausted when you run Power BI report that executes DAX query on SSAS 2016 and 2017 Multidimensional mode (KB4090032)](https://support.microsoft.com/help/4090032) | Analysis Services | Server | Windows |
| <a id="11751257">[11751257](#11751257)</a> | [FIX: An unexpected exception occurs and SSAS crashes when you execute a particular DAX function in SQL Server 2017 (KB4096258)](https://support.microsoft.com/help/4096258) | Analysis Services | Server | Windows |
| <a id="11701169">[11701169](#11701169)</a> | [FIX: "Incorrect syntax near the keyword 'KEY'" error when you add an Oracle table with primary column named 'KEY' in SQL Server 2016 and 2017 (KB4057615)](https://support.microsoft.com/help/4057615) | Integration Services | CDC | Windows |
| <a id="11701155">[11701155](#11701155)</a> | FIX: Change Data Capture functionality doesn't work in SQL Server (KB4038932) | Integration Services | CDC | Windows |
| <a id="11701174">[11701174](#11701174)</a> | [FIX: Error when upgrading SSIS catalog database in SQL Server 2016 and 2017 Standard Edition (KB4058747)](https://support.microsoft.com/help/4058747) | Integration Services | Tools | Windows |
| <a id="11797615">[11797615](#11797615)</a> | [FIX: SQL Server Agent can't connect to SQL Server 2017 on Docker when non-default TCP port is used (KB4100918)](https://support.microsoft.com/help/4100918) | Integration Services | Tools | Linux |
| <a id="11684530">[11684530](#11684530)</a> | [FIX: Incorrect user name is displayed when a user logs in MDS and accesses Users and Groups functional area in SQL Server 2017 (KB4099334)](https://support.microsoft.com/help/4099334) | Master Data Services | Client | Windows |
| <a id="11587927">[11587927](#11587927)</a> | False error reporting when you execute the `Test-SqlAvailabilityGroup` cmdlet in SQL Server (KB4099335) | SQL Server Client Tools | Powershell (SQLPS.exe) | Windows |
| <a id="11701180">[11701180](#11701180)</a> | [FIX: Assertion error when data is bulk-inserted into a table that contains non-clustered and clustered columnstore indexes in SQL Server 2016 and 2017 (KB4074881)](https://support.microsoft.com/help/4074881) | SQL Server Engine | Column Stores | Windows |
| <a id="11697318">[11697318](#11697318)</a> | Fixes an issue in which the database can't be detached or dropped after its storage is disconnected and reconnected. | SQL Server Engine | DB Management | Windows |
| <a id="11715371">[11715371](#11715371)</a> | [FIX: R script fails on parallel execution in SQL Server 2017 (KB4098763)](https://support.microsoft.com/help/4098763) | SQL Server Engine | Extensibility | Windows |
| <a id="11701200">[11701200](#11701200)</a> | [FIX: Assertion failure when sys.dm_db_log_space_usage statement is run on a database snapshot in SQL Server 2016 and 2017 (KB4088901)](https://support.microsoft.com/help/4088901) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11701210">[11701210](#11701210)</a> | [Latch timeout on Secondary Replica, Deadlock Between Read-only Queries (KB4089819)](https://support.microsoft.com/help/4089819) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11797978">[11797978](#11797978)</a> | [FIX: Parallel redo in a secondary replica of an availability group that contains heap tables generates a runtime assert dump or the SQL Server crashes with an access violation error (KB4101554)](https://support.microsoft.com/help/4101554) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11807574">[11807574](#11807574)</a> | [FIX: Automatic seeding fails when you use an Always On availability group in SQL Server (KB4101482)](https://support.microsoft.com/help/4101482) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="11701162">[11701162](#11701162)</a> | FIX: Assert in "`HadrRefcountedObject::Release`" when you configure a replica for manual seeding mode in SQL Server (KB4077708) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="11701217">[11701217](#11701217)</a> | [FIX: Large disk checkpoint usage occurs for an In-Memory optimized filegroup during heavy non-In-Memory workloads (KB3147012)](https://support.microsoft.com/help/3147012) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="11804747">[11804747](#11804747)</a> | [FIX: Errors occur when you upgrade to SQL Server 2017 CU4 or later and SQL Server Agent isn't enabled on Linux (KB4101323)](https://support.microsoft.com/help/4101323) | SQL Server Engine | Linux | Linux |
| <a id="11806534">[11806534](#11806534)</a> | [FIX: Database Mail can't connect to SQL Server 2017 on Linux when non-default TCP port is used (KB4100873)](https://support.microsoft.com/help/4100873) | SQL Server Engine | Linux | Linux |
| <a id="11751562">[11751562](#11751562)</a> | [FIX: "Access is denied" error when you try to create a database in SQL Server 2017 Express LocalDB (KB4096875)](https://support.microsoft.com/help/4096875) | SQL Server Engine | LocalDB | Windows |
| <a id="11701181">[11701181](#11701181)</a> | [FIX: Managed Backup fails when database is renamed with trailing white space in SQL Server 2016 and 2017 (KB4090486)](https://support.microsoft.com/help/4090486) | SQL Server Engine | Management Services | Windows |
| <a id="11701157">[11701157](#11701157)</a> | [FIX: Error 15665 when you call sp_set_session_context repeatedly with null key value in SQL Server 2017 (KB4089324)](https://support.microsoft.com/help/4089324) | SQL Server Engine | Programmability | Windows |
| <a id="11701190">[11701190](#11701190)</a> | [FIX: Random access violations occur when you run monitoring stored procedure in SQL Server 2016 and 2017 (KB4078596)](https://support.microsoft.com/help/4078596) | SQL Server Engine | Query Execution | Windows |
| <a id="11701156">[11701156](#11701156)</a> | [Update to support partition elimination in query plans that have spatial indexes in SQL Server 2016 and 2017 (KB4089950)](https://support.microsoft.com/help/4089950) | SQL Server Engine | Query Optimizer | All |
| <a id="11701215">[11701215](#11701215)</a> | [Improves the query performance when an optimized bitmap filter is applied to a query plan in SQL Server 2016 and 2017 (KB4089276)](https://support.microsoft.com/help/4089276) | SQL Server Engine | Query Optimizer | All |
| <a id="11701184">[11701184](#11701184)</a> | [A non-optimal query plan choice causes poor performance when values outside the range represented in statistics are searched in SQL Server 2016 and 2017 (KB3192154)](https://support.microsoft.com/help/3192154) | SQL Server Engine | Query Optimizer | Windows |
| <a id="11797614">[11797614](#11797614)</a> | [FIX: "Access Violation" error when you execute a complex query with multiple joins and the Adaptive Join feature is enabled in SQL Server (KB4099126)](https://support.microsoft.com/help/4099126) | SQL Server Engine | Query Optimizer | All |
| <a id="11701170">[11701170](#11701170)</a> | [FIX: ALTER PROCEDURE WITH ENCRYPTION statement fails when you encrypt a non-published stored procedure in SQL Server 2016 and 2017 (KB4058289)](https://support.microsoft.com/help/4058289) | SQL Server Engine | Replication | Windows |
| <a id="11751554">[11751554](#11751554)</a> | [FIX: Leakage of sensitive data occurs when you enable DDM function in SQL Server 2017 (KB4100582)](https://support.microsoft.com/help/4100582) | SQL Server Engine | Security Infrastructure | All |
| <a id="11701167">[11701167](#11701167)</a> | FIX: Random masking doesn't mask `BIGINT` values correctly in SQL Server (KB4090025) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="11719463">[11719463](#11719463)</a> | [Improvement: Enable "forced flush" mechanism in SQL Server 2017 on Linux (KB4131496)](https://support.microsoft.com/help/4131496) | SQL Server Engine | Transaction Services | All |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU6 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2018/04/sqlserver2017-kb4101464-x64_e42478470a71c67424402031f50974ac7180c657.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4101464-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4101464-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4101464-x64.exe| 33C3CD603B555137EAE1DB0AB63AAD8FE8ACB1E4A6B93DEDC3145B8D37B8CC63 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.204.1   | 266408    | 28-Jan-18 | 14:00 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.204.1       | 741536    | 28-Jan-18 | 14:01 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.204.1       | 1380520   | 16-Mar-18 | 20:33 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.204.1       | 984232    | 28-Jan-18 | 14:00 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.204.1       | 521384    | 16-Mar-18 | 20:33 | x86      |
| Microsoft.applicationinsights.dll                  | 2.6.0.6787       | 239328    | 28-Mar-18 | 22:35 | x86      |
| Microsoft.data.mashup.dll                          | 2.49.4831.201    | 174816    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.49.4831.201    | 36576     | 17-Mar-18 | 00:17 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.49.4831.201    | 48864     | 25-Oct-17 | 03:11 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.49.4831.201    | 105184    | 17-Mar-18 | 00:17 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.49.4831.201    | 5167328   | 17-Mar-18 | 00:17 | x86      |
| Microsoft.mashup.container.exe                     | 2.49.4831.201    | 26336     | 25-Oct-17 | 03:11 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.49.4831.201    | 26848     | 17-Mar-18 | 00:17 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.49.4831.201    | 26848     | 17-Mar-18 | 00:17 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.49.4831.201    | 159456    | 17-Mar-18 | 00:17 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.49.4831.201    | 82656     | 17-Mar-18 | 00:17 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.49.4831.201    | 67296     | 17-Mar-18 | 00:17 | x86      |
| Microsoft.mashup.shims.dll                         | 2.49.4831.201    | 25824     | 17-Mar-18 | 00:17 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 151264    | 25-Oct-17 | 03:11 | x86      |
| Microsoft.mashupengine.dll                         | 2.49.4831.201    | 13032160  | 17-Mar-18 | 00:17 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 14.0.1.484       | 1044672   | 17-Mar-18 | 00:17 | x86      |
| Msmdctr.dll                                        | 2017.140.204.1   | 40096     | 16-Mar-18 | 20:33 | x64      |
| Msmdlocal.dll                                      | 2017.140.204.1   | 40377504  | 28-Jan-18 | 13:30 | x86      |
| Msmdlocal.dll                                      | 2017.140.204.1   | 60709032  | 28-Jan-18 | 14:01 | x64      |
| Msmdpump.dll                                       | 2017.140.204.1   | 9334952   | 16-Mar-18 | 20:33 | x64      |
| Msmdredir.dll                                      | 2017.140.204.1   | 7092384   | 28-Jan-18 | 13:30 | x86      |
| Msmdsrv.exe                                        | 2017.140.204.1   | 60609704  | 28-Jan-18 | 14:01 | x64      |
| Msmgdsrv.dll                                       | 2017.140.204.1   | 9004712   | 15-Mar-18 | 14:30 | x64      |
| Msmgdsrv.dll                                       | 2017.140.204.1   | 7310496   | 16-Mar-18 | 20:30 | x86      |
| Msolap.dll                                         | 2017.140.204.1   | 7776928   | 16-Mar-18 | 20:30 | x86      |
| Msolap.dll                                         | 2017.140.204.1   | 10258592  | 16-Mar-18 | 20:33 | x64      |
| Msolui.dll                                         | 2017.140.204.1   | 287392    | 28-Jan-18 | 13:30 | x86      |
| Msolui.dll                                         | 2017.140.204.1   | 310952    | 16-Mar-18 | 20:33 | x64      |
| Powerbiextensions.dll                              | 2.49.4831.201    | 5316832   | 25-Oct-17 | 03:11 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlboot.dll                                        | 2017.140.3025.34 | 196256    | 10-Apr-18 | 02:05 | x64      |
| Sqlceip.exe                                        | 14.0.3025.34     | 252576    | 10-Apr-18 | 02:01 | x86      |
| Sqldumper.exe                                      | 2017.140.3025.34 | 140960    | 10-Apr-18 | 01:37 | x64      |
| Sqldumper.exe                                      | 2017.140.3025.34 | 119456    | 10-Apr-18 | 02:03 | x86      |
| Tmapi.dll                                          | 2017.140.204.1   | 5822624   | 16-Mar-18 | 20:33 | x64      |
| Tmcachemgr.dll                                     | 2017.140.204.1   | 4164768   | 16-Mar-18 | 20:33 | x64      |
| Tmpersistence.dll                                  | 2017.140.204.1   | 1132200   | 28-Jan-18 | 14:01 | x64      |
| Tmtransactions.dll                                 | 2017.140.204.1   | 1640096   | 28-Jan-18 | 14:01 | x64      |
| Xe.dll                                             | 2017.140.3025.34 | 673440    | 10-Apr-18 | 01:37 | x64      |
| Xmlrw.dll                                          | 2017.140.3025.34 | 305312    | 10-Apr-18 | 02:05 | x64      |
| Xmlrw.dll                                          | 2017.140.3025.34 | 257696    | 10-Apr-18 | 02:06 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3025.34 | 189600    | 10-Apr-18 | 09:51 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3025.34 | 224416    | 10-Apr-18 | 02:05 | x64      |
| Xmsrv.dll                                          | 2017.140.204.1   | 33350816  | 28-Jan-18 | 13:31 | x86      |
| Xmsrv.dll                                          | 2017.140.204.1   | 25375400  | 28-Jan-18 | 14:01 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3025.34 | 180896    | 10-Apr-18 | 00:54 | x64      |
| Batchparser.dll                            | 2017.140.3025.34 | 160416    | 10-Apr-18 | 00:54 | x86      |
| Instapi140.dll                             | 2017.140.3025.34 | 70304     | 10-Apr-18 | 01:03 | x64      |
| Instapi140.dll                             | 2017.140.3025.34 | 61096     | 10-Apr-18 | 01:03 | x86      |
| Isacctchange.dll                           | 2017.140.3025.34 | 30880     | 10-Apr-18 | 09:47 | x64      |
| Isacctchange.dll                           | 2017.140.3025.34 | 29344     | 10-Apr-18 | 02:06 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088680   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.204.1       | 1088672   | 16-Mar-18 | 20:30 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.204.1       | 1381536   | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741544    | 16-Mar-18 | 20:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.204.1       | 741536    | 16-Mar-18 | 20:33 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3025.34     | 37024     | 10-Apr-18 | 02:06 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3025.34 | 82080     | 10-Apr-18 | 02:05 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3025.34 | 78496     | 10-Apr-18 | 02:06 | x86      |
| Msasxpress.dll                             | 2017.140.204.1   | 31904     | 28-Jan-18 | 13:30 | x86      |
| Msasxpress.dll                             | 2017.140.204.1   | 36008     | 16-Mar-18 | 20:33 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3025.34 | 82080     | 10-Apr-18 | 09:50 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3025.34 | 67744     | 10-Apr-18 | 02:06 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqldumper.exe                              | 2017.140.3025.34 | 140960    | 10-Apr-18 | 01:37 | x64      |
| Sqldumper.exe                              | 2017.140.3025.34 | 119456    | 10-Apr-18 | 02:03 | x86      |
| Sqlftacct.dll                              | 2017.140.3025.34 | 54432     | 10-Apr-18 | 09:51 | x86      |
| Sqlftacct.dll                              | 2017.140.3025.34 | 62112     | 10-Apr-18 | 02:05 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 10-Jan-18 | 09:00 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 17-Mar-18 | 00:46 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3025.34 | 415904    | 10-Apr-18 | 09:49 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3025.34 | 372384    | 10-Apr-18 | 09:51 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3025.34 | 37536     | 10-Apr-18 | 09:50 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3025.34 | 34976     | 10-Apr-18 | 09:51 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3025.34 | 356000    | 10-Apr-18 | 02:05 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3025.34 | 273056    | 10-Apr-18 | 02:06 | x86      |
| Sqltdiagn.dll                              | 2017.140.3025.34 | 60576     | 10-Apr-18 | 00:54 | x86      |
| Sqltdiagn.dll                              | 2017.140.3025.34 | 67744     | 10-Apr-18 | 01:03 | x64      |
| Svrenumapi140.dll                          | 2017.140.3025.34 | 1173152   | 10-Apr-18 | 02:05 | x64      |
| Svrenumapi140.dll                          | 2017.140.3025.34 | 893600    | 10-Apr-18 | 02:06 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3025.34 | 120992    | 10-Apr-18 | 09:50 | x86      |
| Dreplaycommon.dll              | 2017.140.3025.34 | 698016    | 10-Apr-18 | 02:05 | x86      |
| Dreplayserverps.dll            | 2017.140.3025.34 | 32928     | 10-Apr-18 | 02:05 | x86      |
| Dreplayutil.dll                | 2017.140.3025.34 | 309920    | 10-Apr-18 | 09:50 | x86      |
| Instapi140.dll                 | 2017.140.3025.34 | 70304     | 10-Apr-18 | 01:03 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlresourceloader.dll          | 2017.140.3025.34 | 29352     | 10-Apr-18 | 01:03 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3025.34 | 698016    | 10-Apr-18 | 02:05 | x86      |
| Dreplaycontroller.exe              | 2017.140.3025.34 | 350368    | 10-Apr-18 | 09:50 | x86      |
| Dreplayprocess.dll                 | 2017.140.3025.34 | 171680    | 10-Apr-18 | 09:50 | x86      |
| Dreplayserverps.dll                | 2017.140.3025.34 | 32928     | 10-Apr-18 | 02:05 | x86      |
| Instapi140.dll                     | 2017.140.3025.34 | 70304     | 10-Apr-18 | 01:03 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlresourceloader.dll              | 2017.140.3025.34 | 29352     | 10-Apr-18 | 01:03 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                              | 2017.140.3025.34 | 180896    | 10-Apr-18 | 00:54 | x64      |
| C1.dll                                       | 18.10.40116.18   | 909312    | 15-Dec-17 | 20:22 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5325312   | 11-Jan-18 | 12:42 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 176128    | 15-Dec-17 | 20:22 | x64      |
| Datacollectorcontroller.dll                  | 2017.140.3025.34 | 225952    | 10-Apr-18 | 09:46 | x64      |
| Dcexec.exe                                   | 2017.140.3025.34 | 74400     | 10-Apr-18 | 09:46 | x64      |
| Fssres.dll                                   | 2017.140.3025.34 | 89248     | 10-Apr-18 | 09:50 | x64      |
| Hadrres.dll                                  | 2017.140.3025.34 | 187560    | 10-Apr-18 | 09:50 | x64      |
| Hkcompile.dll                                | 2017.140.3025.34 | 1423008   | 10-Apr-18 | 09:50 | x64      |
| Hkengine.dll                                 | 2017.140.3025.34 | 5858984   | 10-Apr-18 | 09:50 | x64      |
| Hkruntime.dll                                | 2017.140.3025.34 | 161952    | 10-Apr-18 | 09:50 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1001472   | 11-Jan-18 | 12:42 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.204.1       | 741024    | 16-Mar-18 | 20:33 | x86      |
| Microsoft.applicationinsights.dll            | 2.6.0.6787       | 239328    | 28-Mar-18 | 22:35 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3025.34     | 237216    | 10-Apr-18 | 09:47 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3025.34     | 79520     | 10-Apr-18 | 08:09 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3025.34 | 71328     | 10-Apr-18 | 02:05 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3025.34 | 65184     | 10-Apr-18 | 00:58 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3025.34 | 152224    | 10-Apr-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3025.34 | 159392    | 10-Apr-18 | 01:37 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3025.34 | 303776    | 10-Apr-18 | 07:34 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3025.34 | 74920     | 10-Apr-18 | 07:34 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 113664    | 15-Dec-17 | 20:22 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 543232    | 14-Jan-18 | 17:27 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 543232    | 14-Jan-18 | 17:27 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 645120    | 15-Dec-17 | 20:22 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 948736    | 15-Dec-17 | 20:22 | x64      |
| Odsole70.dll                                 | 2017.140.3025.34 | 92832     | 10-Apr-18 | 02:05 | x64      |
| Opends60.dll                                 | 2017.140.3025.34 | 32928     | 10-Apr-18 | 01:03 | x64      |
| Qds.dll                                      | 2017.140.3025.34 | 1168032   | 10-Apr-18 | 13:31 | x64      |
| Rsfxft.dll                                   | 2017.140.3025.34 | 34464     | 10-Apr-18 | 01:44 | x64      |
| Secforwarder.dll                             | 2017.140.3025.34 | 37536     | 10-Apr-18 | 02:05 | x64      |
| Sqagtres.dll                                 | 2017.140.3025.34 | 74400     | 10-Apr-18 | 02:05 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlaamss.dll                                 | 2017.140.3025.34 | 90272     | 10-Apr-18 | 09:49 | x64      |
| Sqlaccess.dll                                | 2017.140.3025.34 | 474792    | 10-Apr-18 | 02:05 | x64      |
| Sqlagent.exe                                 | 2017.140.3025.34 | 580776    | 10-Apr-18 | 09:49 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3025.34 | 61088     | 10-Apr-18 | 08:28 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3025.34 | 52896     | 10-Apr-18 | 09:51 | x86      |
| Sqlagentlog.dll                              | 2017.140.3025.34 | 32936     | 10-Apr-18 | 02:05 | x64      |
| Sqlagentmail.dll                             | 2017.140.3025.34 | 53920     | 10-Apr-18 | 01:03 | x64      |
| Sqlboot.dll                                  | 2017.140.3025.34 | 196256    | 10-Apr-18 | 02:05 | x64      |
| Sqlceip.exe                                  | 14.0.3025.34     | 252576    | 10-Apr-18 | 02:01 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3025.34 | 72352     | 10-Apr-18 | 09:49 | x64      |
| Sqlctr140.dll                                | 2017.140.3025.34 | 129184    | 10-Apr-18 | 09:50 | x64      |
| Sqlctr140.dll                                | 2017.140.3025.34 | 111776    | 10-Apr-18 | 02:06 | x86      |
| Sqldk.dll                                    | 2017.140.3025.34 | 2794144   | 10-Apr-18 | 13:31 | x64      |
| Sqldtsss.dll                                 | 2017.140.3025.34 | 107176    | 10-Apr-18 | 09:49 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3334824   | 10-Apr-18 | 01:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3671712   | 10-Apr-18 | 01:37 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3774624   | 10-Apr-18 | 01:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3585184   | 10-Apr-18 | 01:40 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 2088096   | 10-Apr-18 | 01:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3398312   | 10-Apr-18 | 01:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 4020384   | 10-Apr-18 | 01:41 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3817640   | 10-Apr-18 | 01:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 1444000   | 10-Apr-18 | 01:42 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3477160   | 10-Apr-18 | 01:44 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 2034336   | 10-Apr-18 | 01:44 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3911328   | 10-Apr-18 | 01:46 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3293344   | 10-Apr-18 | 01:49 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3630752   | 10-Apr-18 | 01:51 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3287712   | 10-Apr-18 | 01:51 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3363488   | 10-Apr-18 | 01:53 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 1496744   | 10-Apr-18 | 01:53 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3593888   | 10-Apr-18 | 01:55 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3913888   | 10-Apr-18 | 01:57 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3210912   | 10-Apr-18 | 01:59 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3781792   | 10-Apr-18 | 02:01 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3025.34 | 3781280   | 10-Apr-18 | 02:01 | x64      |
| Sqliosim.com                                 | 2017.140.3025.34 | 313504    | 10-Apr-18 | 07:38 | x64      |
| Sqliosim.exe                                 | 2017.140.3025.34 | 3019936   | 10-Apr-18 | 09:50 | x64      |
| Sqllang.dll                                  | 2017.140.3025.34 | 41229472  | 10-Apr-18 | 13:31 | x64      |
| Sqlmin.dll                                   | 2017.140.3025.34 | 40278176  | 10-Apr-18 | 13:31 | x64      |
| Sqlolapss.dll                                | 2017.140.3025.34 | 107680    | 10-Apr-18 | 02:05 | x64      |
| Sqlos.dll                                    | 2017.140.3025.34 | 26272     | 10-Apr-18 | 01:44 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3025.34 | 67744     | 10-Apr-18 | 02:05 | x64      |
| Sqlrepss.dll                                 | 2017.140.3025.34 | 64160     | 10-Apr-18 | 02:05 | x64      |
| Sqlresld.dll                                 | 2017.140.3025.34 | 30880     | 10-Apr-18 | 02:05 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3025.34 | 32416     | 10-Apr-18 | 01:03 | x64      |
| Sqlscm.dll                                   | 2017.140.3025.34 | 70816     | 10-Apr-18 | 02:05 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3025.34 | 27808     | 10-Apr-18 | 02:05 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3025.34 | 5872288   | 10-Apr-18 | 02:05 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3025.34 | 732832    | 10-Apr-18 | 02:05 | x64      |
| Sqlservr.exe                                 | 2017.140.3025.34 | 487072    | 10-Apr-18 | 13:31 | x64      |
| Sqlsvc.dll                                   | 2017.140.3025.34 | 161440    | 10-Apr-18 | 02:05 | x64      |
| Sqltses.dll                                  | 2017.140.3025.34 | 9537184   | 10-Apr-18 | 13:31 | x64      |
| Sqsrvres.dll                                 | 2017.140.3025.34 | 260256    | 10-Apr-18 | 09:50 | x64      |
| Svl.dll                                      | 2017.140.3025.34 | 153760    | 10-Apr-18 | 09:50 | x64      |
| Xe.dll                                       | 2017.140.3025.34 | 673440    | 10-Apr-18 | 01:37 | x64      |
| Xmlrw.dll                                    | 2017.140.3025.34 | 305312    | 10-Apr-18 | 02:05 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3025.34 | 224416    | 10-Apr-18 | 02:05 | x64      |
| Xpadsi.exe                                   | 2017.140.3025.34 | 89768     | 10-Apr-18 | 09:50 | x64      |
| Xplog70.dll                                  | 2017.140.3025.34 | 75944     | 10-Apr-18 | 09:50 | x64      |
| Xpqueue.dll                                  | 2017.140.3025.34 | 74912     | 10-Apr-18 | 02:05 | x64      |
| Xprepl.dll                                   | 2017.140.3025.34 | 101536    | 10-Apr-18 | 09:50 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3025.34 | 32416     | 10-Apr-18 | 02:05 | x64      |
| Xpstar.dll                                   | 2017.140.3025.34 | 437408    | 10-Apr-18 | 09:50 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3025.34 | 180896    | 10-Apr-18 | 00:54 | x64      |
| Batchparser.dll                                             | 2017.140.3025.34 | 160416    | 10-Apr-18 | 00:54 | x86      |
| Bcp.exe                                                     | 2017.140.3025.34 | 119968    | 10-Apr-18 | 02:05 | x64      |
| Commanddest.dll                                             | 2017.140.3025.34 | 245920    | 10-Apr-18 | 02:05 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3025.34 | 116384    | 10-Apr-18 | 09:46 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3025.34 | 187552    | 10-Apr-18 | 02:05 | x64      |
| Distrib.exe                                                 | 2017.140.3025.34 | 202400    | 10-Apr-18 | 02:05 | x64      |
| Dteparse.dll                                                | 2017.140.3025.34 | 111264    | 10-Apr-18 | 02:05 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3025.34 | 89248     | 10-Apr-18 | 02:05 | x64      |
| Dtepkg.dll                                                  | 2017.140.3025.34 | 137888    | 10-Apr-18 | 09:46 | x64      |
| Dtexec.exe                                                  | 2017.140.3025.34 | 74912     | 10-Apr-18 | 09:46 | x64      |
| Dts.dll                                                     | 2017.140.3025.34 | 2998944   | 10-Apr-18 | 09:46 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3025.34 | 475296    | 10-Apr-18 | 09:46 | x64      |
| Dtsconn.dll                                                 | 2017.140.3025.34 | 497320    | 10-Apr-18 | 09:46 | x64      |
| Dtshost.exe                                                 | 2017.140.3025.34 | 103584    | 10-Apr-18 | 09:50 | x64      |
| Dtslog.dll                                                  | 2017.140.3025.34 | 120480    | 10-Apr-18 | 02:05 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3025.34 | 545440    | 10-Apr-18 | 02:05 | x64      |
| Dtspipeline.dll                                             | 2017.140.3025.34 | 1266336   | 10-Apr-18 | 09:46 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3025.34 | 48288     | 10-Apr-18 | 09:46 | x64      |
| Dtuparse.dll                                                | 2017.140.3025.34 | 89248     | 10-Apr-18 | 09:46 | x64      |
| Dtutil.exe                                                  | 2017.140.3025.34 | 147104    | 10-Apr-18 | 09:46 | x64      |
| Exceldest.dll                                               | 2017.140.3025.34 | 260768    | 10-Apr-18 | 02:05 | x64      |
| Excelsrc.dll                                                | 2017.140.3025.34 | 282784    | 10-Apr-18 | 09:46 | x64      |
| Execpackagetask.dll                                         | 2017.140.3025.34 | 168096    | 10-Apr-18 | 02:05 | x64      |
| Flatfiledest.dll                                            | 2017.140.3025.34 | 384160    | 10-Apr-18 | 02:05 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3025.34 | 396456    | 10-Apr-18 | 09:47 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3025.34 | 96416     | 10-Apr-18 | 09:46 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3025.34 | 59552     | 10-Apr-18 | 09:50 | x64      |
| Logread.exe                                                 | 2017.140.3025.34 | 635040    | 10-Apr-18 | 09:50 | x64      |
| Mergetxt.dll                                                | 2017.140.3025.34 | 63136     | 10-Apr-18 | 09:50 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.204.1       | 1381536   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3025.34     | 89760     | 10-Apr-18 | 09:49 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3025.34 | 1662624   | 10-Apr-18 | 09:49 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3025.34 | 152224    | 10-Apr-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3025.34 | 159392    | 10-Apr-18 | 01:37 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3025.34 | 103072    | 10-Apr-18 | 09:47 | x64      |
| Msgprox.dll                                                 | 2017.140.3025.34 | 270496    | 10-Apr-18 | 09:50 | x64      |
| Msxmlsql.dll                                                | 2017.140.3025.34 | 1448096   | 10-Apr-18 | 09:50 | x64      |
| Oledbdest.dll                                               | 2017.140.3025.34 | 261280    | 10-Apr-18 | 09:47 | x64      |
| Oledbsrc.dll                                                | 2017.140.3025.34 | 288928    | 10-Apr-18 | 09:47 | x64      |
| Osql.exe                                                    | 2017.140.3025.34 | 75424     | 10-Apr-18 | 02:05 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3025.34 | 473760    | 10-Apr-18 | 09:50 | x64      |
| Rawdest.dll                                                 | 2017.140.3025.34 | 206496    | 10-Apr-18 | 09:49 | x64      |
| Rawsource.dll                                               | 2017.140.3025.34 | 194208    | 10-Apr-18 | 09:49 | x64      |
| Rdistcom.dll                                                | 2017.140.3025.34 | 856224    | 10-Apr-18 | 09:50 | x64      |
| Recordsetdest.dll                                           | 2017.140.3025.34 | 184480    | 10-Apr-18 | 02:05 | x64      |
| Replagnt.dll                                                | 2017.140.3025.34 | 30880     | 10-Apr-18 | 02:05 | x64      |
| Repldp.dll                                                  | 2017.140.3025.34 | 290464    | 10-Apr-18 | 09:50 | x64      |
| Replerrx.dll                                                | 2017.140.3025.34 | 154272    | 10-Apr-18 | 09:50 | x64      |
| Replisapi.dll                                               | 2017.140.3025.34 | 361632    | 10-Apr-18 | 09:50 | x64      |
| Replmerg.exe                                                | 2017.140.3025.34 | 524960    | 10-Apr-18 | 09:50 | x64      |
| Replprov.dll                                                | 2017.140.3025.34 | 801440    | 10-Apr-18 | 09:50 | x64      |
| Replrec.dll                                                 | 2017.140.3025.34 | 975008    | 10-Apr-18 | 09:50 | x64      |
| Replsub.dll                                                 | 2017.140.3025.34 | 445600    | 10-Apr-18 | 09:50 | x64      |
| Replsync.dll                                                | 2017.140.3025.34 | 153760    | 10-Apr-18 | 02:05 | x64      |
| Spresolv.dll                                                | 2017.140.3025.34 | 252064    | 10-Apr-18 | 09:50 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3025.34 | 249000    | 10-Apr-18 | 02:05 | x64      |
| Sqldiag.exe                                                 | 2017.140.3025.34 | 1257632   | 10-Apr-18 | 09:50 | x64      |
| Sqldistx.dll                                                | 2017.140.3025.34 | 224928    | 10-Apr-18 | 09:50 | x64      |
| Sqllogship.exe                                              | 14.0.3025.34     | 105632    | 10-Apr-18 | 02:05 | x64      |
| Sqlmergx.dll                                                | 2017.140.3025.34 | 360608    | 10-Apr-18 | 09:50 | x64      |
| Sqlresld.dll                                                | 2017.140.3025.34 | 30880     | 10-Apr-18 | 02:05 | x64      |
| Sqlresld.dll                                                | 2017.140.3025.34 | 28832     | 10-Apr-18 | 02:06 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3025.34 | 32416     | 10-Apr-18 | 01:03 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3025.34 | 29352     | 10-Apr-18 | 01:03 | x86      |
| Sqlscm.dll                                                  | 2017.140.3025.34 | 70816     | 10-Apr-18 | 02:05 | x64      |
| Sqlscm.dll                                                  | 2017.140.3025.34 | 60072     | 10-Apr-18 | 02:06 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3025.34 | 161440    | 10-Apr-18 | 02:05 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3025.34 | 134816    | 10-Apr-18 | 02:06 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3025.34 | 183968    | 10-Apr-18 | 09:49 | x64      |
| Sqlwep140.dll                                               | 2017.140.3025.34 | 105632    | 10-Apr-18 | 02:05 | x64      |
| Ssdebugps.dll                                               | 2017.140.3025.34 | 33440     | 10-Apr-18 | 09:50 | x64      |
| Ssisoledb.dll                                               | 2017.140.3025.34 | 216224    | 10-Apr-18 | 02:05 | x64      |
| Ssradd.dll                                                  | 2017.140.3025.34 | 74912     | 10-Apr-18 | 09:50 | x64      |
| Ssravg.dll                                                  | 2017.140.3025.34 | 74912     | 10-Apr-18 | 02:05 | x64      |
| Ssrdown.dll                                                 | 2017.140.3025.34 | 60064     | 10-Apr-18 | 02:05 | x64      |
| Ssrmax.dll                                                  | 2017.140.3025.34 | 72864     | 10-Apr-18 | 09:50 | x64      |
| Ssrmin.dll                                                  | 2017.140.3025.34 | 73376     | 10-Apr-18 | 02:05 | x64      |
| Ssrpub.dll                                                  | 2017.140.3025.34 | 60584     | 10-Apr-18 | 09:50 | x64      |
| Ssrup.dll                                                   | 2017.140.3025.34 | 60064     | 10-Apr-18 | 09:50 | x64      |
| Txagg.dll                                                   | 2017.140.3025.34 | 362144    | 10-Apr-18 | 09:50 | x64      |
| Txbdd.dll                                                   | 2017.140.3025.34 | 170152    | 10-Apr-18 | 09:50 | x64      |
| Txdatacollector.dll                                         | 2017.140.3025.34 | 360608    | 10-Apr-18 | 02:05 | x64      |
| Txdataconvert.dll                                           | 2017.140.3025.34 | 293024    | 10-Apr-18 | 09:50 | x64      |
| Txderived.dll                                               | 2017.140.3025.34 | 604320    | 10-Apr-18 | 09:50 | x64      |
| Txlookup.dll                                                | 2017.140.3025.34 | 528032    | 10-Apr-18 | 09:50 | x64      |
| Txmerge.dll                                                 | 2017.140.3025.34 | 230048    | 10-Apr-18 | 09:50 | x64      |
| Txmergejoin.dll                                             | 2017.140.3025.34 | 275616    | 10-Apr-18 | 09:50 | x64      |
| Txmulticast.dll                                             | 2017.140.3025.34 | 127648    | 10-Apr-18 | 09:50 | x64      |
| Txrowcount.dll                                              | 2017.140.3025.34 | 125608    | 10-Apr-18 | 09:50 | x64      |
| Txsort.dll                                                  | 2017.140.3025.34 | 256672    | 10-Apr-18 | 09:50 | x64      |
| Txsplit.dll                                                 | 2017.140.3025.34 | 596640    | 10-Apr-18 | 09:50 | x64      |
| Txunionall.dll                                              | 2017.140.3025.34 | 181920    | 10-Apr-18 | 09:50 | x64      |
| Xe.dll                                                      | 2017.140.3025.34 | 673440    | 10-Apr-18 | 01:37 | x64      |
| Xmlrw.dll                                                   | 2017.140.3025.34 | 305312    | 10-Apr-18 | 02:05 | x64      |
| Xmlsub.dll                                                  | 2017.140.3025.34 | 260768    | 10-Apr-18 | 02:05 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3025.34 | 1123496   | 10-Apr-18 | 09:50 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlsatellite.dll              | 2017.140.3025.34 | 922272    | 10-Apr-18 | 09:50 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3025.34 | 667296    | 10-Apr-18 | 02:05 | x64      |
| Fdhost.exe               | 2017.140.3025.34 | 114336    | 10-Apr-18 | 09:50 | x64      |
| Fdlauncher.exe           | 2017.140.3025.34 | 62112     | 10-Apr-18 | 02:05 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlft140ph.dll           | 2017.140.3025.34 | 67744     | 10-Apr-18 | 02:05 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3025.34     | 23712     | 10-Apr-18 | 02:05 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 16-Mar-18 | 20:33 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 16-Mar-18 | 20:33 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 16-Mar-18 | 20:33 | x86      |
| Commanddest.dll                                               | 2017.140.3025.34 | 245920    | 10-Apr-18 | 02:05 | x64      |
| Commanddest.dll                                               | 2017.140.3025.34 | 200864    | 10-Apr-18 | 02:05 | x86      |
| Dteparse.dll                                                  | 2017.140.3025.34 | 111264    | 10-Apr-18 | 02:05 | x64      |
| Dteparse.dll                                                  | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3025.34 | 89248     | 10-Apr-18 | 02:05 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3025.34 | 83616     | 10-Apr-18 | 02:05 | x86      |
| Dtepkg.dll                                                    | 2017.140.3025.34 | 137888    | 10-Apr-18 | 09:46 | x64      |
| Dtepkg.dll                                                    | 2017.140.3025.34 | 116896    | 10-Apr-18 | 09:50 | x86      |
| Dtexec.exe                                                    | 2017.140.3025.34 | 74912     | 10-Apr-18 | 09:46 | x64      |
| Dtexec.exe                                                    | 2017.140.3025.34 | 67744     | 10-Apr-18 | 09:50 | x86      |
| Dts.dll                                                       | 2017.140.3025.34 | 2998944   | 10-Apr-18 | 09:46 | x64      |
| Dts.dll                                                       | 2017.140.3025.34 | 2549408   | 10-Apr-18 | 09:50 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3025.34 | 475296    | 10-Apr-18 | 09:46 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3025.34 | 417952    | 10-Apr-18 | 09:50 | x86      |
| Dtsconn.dll                                                   | 2017.140.3025.34 | 497320    | 10-Apr-18 | 09:46 | x64      |
| Dtsconn.dll                                                   | 2017.140.3025.34 | 399528    | 10-Apr-18 | 09:50 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3025.34 | 95392     | 10-Apr-18 | 09:50 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3025.34 | 111264    | 10-Apr-18 | 02:05 | x64      |
| Dtshost.exe                                                   | 2017.140.3025.34 | 103584    | 10-Apr-18 | 09:50 | x64      |
| Dtshost.exe                                                   | 2017.140.3025.34 | 89760     | 10-Apr-18 | 02:06 | x86      |
| Dtslog.dll                                                    | 2017.140.3025.34 | 103072    | 10-Apr-18 | 09:50 | x86      |
| Dtslog.dll                                                    | 2017.140.3025.34 | 120480    | 10-Apr-18 | 02:05 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3025.34 | 541344    | 10-Apr-18 | 01:03 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3025.34 | 545440    | 10-Apr-18 | 02:05 | x64      |
| Dtspipeline.dll                                               | 2017.140.3025.34 | 1266336   | 10-Apr-18 | 09:46 | x64      |
| Dtspipeline.dll                                               | 2017.140.3025.34 | 1059488   | 10-Apr-18 | 09:50 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3025.34 | 48288     | 10-Apr-18 | 09:46 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3025.34 | 42656     | 10-Apr-18 | 02:05 | x86      |
| Dtuparse.dll                                                  | 2017.140.3025.34 | 89248     | 10-Apr-18 | 09:46 | x64      |
| Dtuparse.dll                                                  | 2017.140.3025.34 | 80032     | 10-Apr-18 | 02:05 | x86      |
| Dtutil.exe                                                    | 2017.140.3025.34 | 147104    | 10-Apr-18 | 09:46 | x64      |
| Dtutil.exe                                                    | 2017.140.3025.34 | 126112    | 10-Apr-18 | 02:05 | x86      |
| Exceldest.dll                                                 | 2017.140.3025.34 | 214688    | 10-Apr-18 | 09:50 | x86      |
| Exceldest.dll                                                 | 2017.140.3025.34 | 260768    | 10-Apr-18 | 02:05 | x64      |
| Excelsrc.dll                                                  | 2017.140.3025.34 | 282784    | 10-Apr-18 | 09:46 | x64      |
| Excelsrc.dll                                                  | 2017.140.3025.34 | 230568    | 10-Apr-18 | 09:50 | x86      |
| Execpackagetask.dll                                           | 2017.140.3025.34 | 168096    | 10-Apr-18 | 02:05 | x64      |
| Execpackagetask.dll                                           | 2017.140.3025.34 | 135328    | 10-Apr-18 | 02:06 | x86      |
| Flatfiledest.dll                                              | 2017.140.3025.34 | 330912    | 10-Apr-18 | 09:50 | x86      |
| Flatfiledest.dll                                              | 2017.140.3025.34 | 384160    | 10-Apr-18 | 02:05 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3025.34 | 396456    | 10-Apr-18 | 09:47 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3025.34 | 342176    | 10-Apr-18 | 02:06 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3025.34 | 96416     | 10-Apr-18 | 09:46 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3025.34 | 80544     | 10-Apr-18 | 02:06 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3025.34     | 466592    | 10-Apr-18 | 14:02 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3025.34     | 467104    | 10-Apr-18 | 14:03 | x86      |
| Isserverexec.exe                                              | 14.0.3025.34     | 148640    | 10-Apr-18 | 09:47 | x64      |
| Isserverexec.exe                                              | 14.0.3025.34     | 149152    | 10-Apr-18 | 09:50 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1       | 1381536   | 28-Jan-18 | 13:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.204.1       | 1381536   | 28-Jan-18 | 14:00 | x86      |
| Microsoft.applicationinsights.dll                             | 2.6.0.6787       | 239328    | 28-Mar-18 | 22:35 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 28-Oct-17 | 03:16 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3025.34     | 71328     | 10-Apr-18 | 09:49 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3025.34 | 112288    | 10-Apr-18 | 09:49 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3025.34 | 107168    | 10-Apr-18 | 09:50 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3025.34     | 89760     | 10-Apr-18 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3025.34     | 89760     | 10-Apr-18 | 09:51 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3025.34     | 494752    | 10-Apr-18 | 02:05 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3025.34     | 494752    | 10-Apr-18 | 02:06 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3025.34     | 83616     | 10-Apr-18 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3025.34     | 83616     | 10-Apr-18 | 09:51 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3025.34     | 415904    | 10-Apr-18 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3025.34     | 415904    | 10-Apr-18 | 09:51 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3025.34     | 252576    | 10-Apr-18 | 09:51 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3025.34     | 252576    | 10-Apr-18 | 02:05 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3025.34 | 152224    | 10-Apr-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3025.34 | 141984    | 10-Apr-18 | 08:42 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3025.34 | 145568    | 10-Apr-18 | 08:06 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3025.34 | 159392    | 10-Apr-18 | 01:37 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3025.34     | 219816    | 10-Apr-18 | 09:49 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3025.34 | 103072    | 10-Apr-18 | 09:47 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3025.34 | 90272     | 10-Apr-18 | 09:50 | x86      |
| Msmdpp.dll                                                    | 2017.140.204.1   | 9194144   | 28-Jan-18 | 14:01 | x64      |
| Oledbdest.dll                                                 | 2017.140.3025.34 | 261280    | 10-Apr-18 | 09:47 | x64      |
| Oledbdest.dll                                                 | 2017.140.3025.34 | 214688    | 10-Apr-18 | 09:50 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3025.34 | 288928    | 10-Apr-18 | 09:47 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3025.34 | 233120    | 10-Apr-18 | 09:50 | x86      |
| Rawdest.dll                                                   | 2017.140.3025.34 | 206496    | 10-Apr-18 | 09:49 | x64      |
| Rawdest.dll                                                   | 2017.140.3025.34 | 166560    | 10-Apr-18 | 02:06 | x86      |
| Rawsource.dll                                                 | 2017.140.3025.34 | 194208    | 10-Apr-18 | 09:49 | x64      |
| Rawsource.dll                                                 | 2017.140.3025.34 | 153248    | 10-Apr-18 | 09:51 | x86      |
| Recordsetdest.dll                                             | 2017.140.3025.34 | 149152    | 10-Apr-18 | 09:51 | x86      |
| Recordsetdest.dll                                             | 2017.140.3025.34 | 184480    | 10-Apr-18 | 02:05 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlceip.exe                                                   | 14.0.3025.34     | 252576    | 10-Apr-18 | 02:01 | x86      |
| Sqldest.dll                                                   | 2017.140.3025.34 | 260768    | 10-Apr-18 | 02:05 | x64      |
| Sqldest.dll                                                   | 2017.140.3025.34 | 213664    | 10-Apr-18 | 02:06 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3025.34 | 183968    | 10-Apr-18 | 09:49 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3025.34 | 155296    | 10-Apr-18 | 02:06 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3025.34 | 216224    | 10-Apr-18 | 02:05 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3025.34 | 176800    | 10-Apr-18 | 02:06 | x86      |
| Txagg.dll                                                     | 2017.140.3025.34 | 362144    | 10-Apr-18 | 09:50 | x64      |
| Txagg.dll                                                     | 2017.140.3025.34 | 302240    | 10-Apr-18 | 09:51 | x86      |
| Txbdd.dll                                                     | 2017.140.3025.34 | 170152    | 10-Apr-18 | 09:50 | x64      |
| Txbdd.dll                                                     | 2017.140.3025.34 | 136352    | 10-Apr-18 | 02:06 | x86      |
| Txbestmatch.dll                                               | 2017.140.3025.34 | 605344    | 10-Apr-18 | 09:50 | x64      |
| Txbestmatch.dll                                               | 2017.140.3025.34 | 493216    | 10-Apr-18 | 09:51 | x86      |
| Txcache.dll                                                   | 2017.140.3025.34 | 180384    | 10-Apr-18 | 09:50 | x64      |
| Txcache.dll                                                   | 2017.140.3025.34 | 146080    | 10-Apr-18 | 09:51 | x86      |
| Txcharmap.dll                                                 | 2017.140.3025.34 | 286880    | 10-Apr-18 | 09:50 | x64      |
| Txcharmap.dll                                                 | 2017.140.3025.34 | 248992    | 10-Apr-18 | 09:51 | x86      |
| Txcopymap.dll                                                 | 2017.140.3025.34 | 180384    | 10-Apr-18 | 09:50 | x64      |
| Txcopymap.dll                                                 | 2017.140.3025.34 | 145568    | 10-Apr-18 | 02:06 | x86      |
| Txdataconvert.dll                                             | 2017.140.3025.34 | 293024    | 10-Apr-18 | 09:50 | x64      |
| Txdataconvert.dll                                             | 2017.140.3025.34 | 253096    | 10-Apr-18 | 02:06 | x86      |
| Txderived.dll                                                 | 2017.140.3025.34 | 604320    | 10-Apr-18 | 09:50 | x64      |
| Txderived.dll                                                 | 2017.140.3025.34 | 515744    | 10-Apr-18 | 02:06 | x86      |
| Txfileextractor.dll                                           | 2017.140.3025.34 | 198816    | 10-Apr-18 | 09:50 | x64      |
| Txfileextractor.dll                                           | 2017.140.3025.34 | 160928    | 10-Apr-18 | 02:06 | x86      |
| Txfileinserter.dll                                            | 2017.140.3025.34 | 196768    | 10-Apr-18 | 09:50 | x64      |
| Txfileinserter.dll                                            | 2017.140.3025.34 | 159392    | 10-Apr-18 | 09:51 | x86      |
| Txgroupdups.dll                                               | 2017.140.3025.34 | 290464    | 10-Apr-18 | 09:50 | x64      |
| Txgroupdups.dll                                               | 2017.140.3025.34 | 231072    | 10-Apr-18 | 09:51 | x86      |
| Txlineage.dll                                                 | 2017.140.3025.34 | 136864    | 10-Apr-18 | 09:50 | x64      |
| Txlineage.dll                                                 | 2017.140.3025.34 | 110240    | 10-Apr-18 | 09:51 | x86      |
| Txlookup.dll                                                  | 2017.140.3025.34 | 528032    | 10-Apr-18 | 09:50 | x64      |
| Txlookup.dll                                                  | 2017.140.3025.34 | 446624    | 10-Apr-18 | 09:51 | x86      |
| Txmerge.dll                                                   | 2017.140.3025.34 | 230048    | 10-Apr-18 | 09:50 | x64      |
| Txmerge.dll                                                   | 2017.140.3025.34 | 176800    | 10-Apr-18 | 02:06 | x86      |
| Txmergejoin.dll                                               | 2017.140.3025.34 | 275616    | 10-Apr-18 | 09:50 | x64      |
| Txmergejoin.dll                                               | 2017.140.3025.34 | 221856    | 10-Apr-18 | 09:51 | x86      |
| Txmulticast.dll                                               | 2017.140.3025.34 | 127648    | 10-Apr-18 | 09:50 | x64      |
| Txmulticast.dll                                               | 2017.140.3025.34 | 102560    | 10-Apr-18 | 09:51 | x86      |
| Txpivot.dll                                                   | 2017.140.3025.34 | 224928    | 10-Apr-18 | 09:50 | x64      |
| Txpivot.dll                                                   | 2017.140.3025.34 | 180384    | 10-Apr-18 | 09:51 | x86      |
| Txrowcount.dll                                                | 2017.140.3025.34 | 125608    | 10-Apr-18 | 09:50 | x64      |
| Txrowcount.dll                                                | 2017.140.3025.34 | 101536    | 10-Apr-18 | 02:06 | x86      |
| Txsampling.dll                                                | 2017.140.3025.34 | 135840    | 10-Apr-18 | 09:51 | x86      |
| Txsampling.dll                                                | 2017.140.3025.34 | 172704    | 10-Apr-18 | 02:05 | x64      |
| Txscd.dll                                                     | 2017.140.3025.34 | 220832    | 10-Apr-18 | 09:50 | x64      |
| Txscd.dll                                                     | 2017.140.3025.34 | 170144    | 10-Apr-18 | 09:51 | x86      |
| Txsort.dll                                                    | 2017.140.3025.34 | 256672    | 10-Apr-18 | 09:50 | x64      |
| Txsort.dll                                                    | 2017.140.3025.34 | 208032    | 10-Apr-18 | 09:51 | x86      |
| Txsplit.dll                                                   | 2017.140.3025.34 | 596640    | 10-Apr-18 | 09:50 | x64      |
| Txsplit.dll                                                   | 2017.140.3025.34 | 510624    | 10-Apr-18 | 09:51 | x86      |
| Txtermextraction.dll                                          | 2017.140.3025.34 | 8676512   | 10-Apr-18 | 09:50 | x64      |
| Txtermextraction.dll                                          | 2017.140.3025.34 | 8615072   | 10-Apr-18 | 09:51 | x86      |
| Txtermlookup.dll                                              | 2017.140.3025.34 | 4157088   | 10-Apr-18 | 09:50 | x64      |
| Txtermlookup.dll                                              | 2017.140.3025.34 | 4106912   | 10-Apr-18 | 09:51 | x86      |
| Txunionall.dll                                                | 2017.140.3025.34 | 181920    | 10-Apr-18 | 09:50 | x64      |
| Txunionall.dll                                                | 2017.140.3025.34 | 139424    | 10-Apr-18 | 02:06 | x86      |
| Txunpivot.dll                                                 | 2017.140.3025.34 | 199840    | 10-Apr-18 | 09:50 | x64      |
| Txunpivot.dll                                                 | 2017.140.3025.34 | 160416    | 10-Apr-18 | 02:06 | x86      |
| Xe.dll                                                        | 2017.140.3025.34 | 673440    | 10-Apr-18 | 01:37 | x64      |
| Xe.dll                                                        | 2017.140.3025.34 | 595616    | 10-Apr-18 | 01:54 | x86      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.18     | 523944    | 17-Mar-18 | 00:16 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.18 | 78504     | 28-Jan-18 | 14:02 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.18     | 45736     | 28-Jan-18 | 14:02 | x86      |
| Instapi140.dll                                                       | 2017.140.3025.34 | 70304     | 10-Apr-18 | 01:03 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.18     | 74928     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.18     | 213672    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.18     | 1799336   | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.18     | 116904    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.18     | 390312    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.18     | 196272    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.18     | 131248    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.18     | 63144     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.18     | 55464     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.18     | 93872     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.18     | 792752    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.18     | 87720     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.18     | 78000     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.18     | 42152     | 28-Jan-18 | 14:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.18     | 37032     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.18     | 47792     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.18     | 27304     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.18     | 32424     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.18     | 129704    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.18     | 95400     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.18     | 109232    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.18     | 264360    | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 105128    | 17-Mar-18 | 00:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 119464    | 17-Mar-18 | 00:17 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 122536    | 17-Mar-18 | 00:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118952    | 17-Mar-18 | 00:50 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 129192    | 17-Mar-18 | 00:37 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 121512    | 17-Mar-18 | 00:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 116392    | 17-Mar-18 | 00:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 149680    | 17-Mar-18 | 00:21 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 103080    | 17-Mar-18 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.18     | 118440    | 17-Mar-18 | 01:08 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.18     | 70312     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.18     | 28840     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.18     | 43688     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.18     | 83624     | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.18     | 136872    | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.18     | 2341040   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.18     | 3860136   | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 110760    | 17-Mar-18 | 00:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123560    | 17-Mar-18 | 00:17 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 128176    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124080    | 28-Jan-18 | 14:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 136872    | 17-Mar-18 | 00:37 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 124584    | 28-Jan-18 | 14:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 121512    | 17-Mar-18 | 00:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 156328    | 17-Mar-18 | 00:21 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 108712    | 28-Jan-18 | 14:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.18     | 123048    | 17-Mar-18 | 01:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.18     | 70312     | 17-Mar-18 | 00:16 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.18     | 2756264   | 28-Jan-18 | 14:02 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.18     | 751784    | 17-Mar-18 | 00:16 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3025.34 | 407200    | 10-Apr-18 | 02:05 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3025.34 | 7324320   | 10-Apr-18 | 07:28 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3025.34 | 2263200   | 10-Apr-18 | 02:05 | x64      |
| Secforwarder.dll                                                     | 2017.140.3025.34 | 37536     | 10-Apr-18 | 02:05 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.18 | 64688     | 17-Mar-18 | 00:16 | x64      |
| Sqldk.dll                                                            | 2017.140.3025.34 | 2710016   | 10-Apr-18 | 07:36 | x64      |
| Sqldumper.exe                                                        | 2017.140.3025.34 | 140960    | 10-Apr-18 | 01:37 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 1496744   | 10-Apr-18 | 01:53 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3911328   | 10-Apr-18 | 01:46 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3210912   | 10-Apr-18 | 01:59 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3913888   | 10-Apr-18 | 01:57 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3817640   | 10-Apr-18 | 01:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 2088096   | 10-Apr-18 | 01:41 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 2034336   | 10-Apr-18 | 01:44 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3585184   | 10-Apr-18 | 01:40 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3593888   | 10-Apr-18 | 01:55 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 1444000   | 10-Apr-18 | 01:42 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3025.34 | 3781792   | 10-Apr-18 | 02:01 | x64      |
| Sqlos.dll                                                            | 2017.140.3025.34 | 26272     | 10-Apr-18 | 01:44 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.18 | 4348072   | 17-Mar-18 | 00:16 | x64      |
| Sqltses.dll                                                          | 2017.140.3025.34 | 9690624   | 10-Apr-18 | 07:36 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3025.34     | 23720     | 10-Apr-18 | 02:05 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3025.34 | 1448608   | 10-Apr-18 | 08:06 | x86      |
| Dtaengine.exe                                          | 2017.140.3025.34 | 204456    | 10-Apr-18 | 08:06 | x86      |
| Dteparse.dll                                           | 2017.140.3025.34 | 111264    | 10-Apr-18 | 02:05 | x64      |
| Dteparse.dll                                           | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3025.34 | 89248     | 10-Apr-18 | 02:05 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3025.34 | 83616     | 10-Apr-18 | 02:05 | x86      |
| Dtepkg.dll                                             | 2017.140.3025.34 | 137888    | 10-Apr-18 | 09:46 | x64      |
| Dtepkg.dll                                             | 2017.140.3025.34 | 116896    | 10-Apr-18 | 09:50 | x86      |
| Dtexec.exe                                             | 2017.140.3025.34 | 74912     | 10-Apr-18 | 09:46 | x64      |
| Dtexec.exe                                             | 2017.140.3025.34 | 67744     | 10-Apr-18 | 09:50 | x86      |
| Dts.dll                                                | 2017.140.3025.34 | 2998944   | 10-Apr-18 | 09:46 | x64      |
| Dts.dll                                                | 2017.140.3025.34 | 2549408   | 10-Apr-18 | 09:50 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3025.34 | 475296    | 10-Apr-18 | 09:46 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3025.34 | 417952    | 10-Apr-18 | 09:50 | x86      |
| Dtsconn.dll                                            | 2017.140.3025.34 | 497320    | 10-Apr-18 | 09:46 | x64      |
| Dtsconn.dll                                            | 2017.140.3025.34 | 399528    | 10-Apr-18 | 09:50 | x86      |
| Dtshost.exe                                            | 2017.140.3025.34 | 103584    | 10-Apr-18 | 09:50 | x64      |
| Dtshost.exe                                            | 2017.140.3025.34 | 89760     | 10-Apr-18 | 02:06 | x86      |
| Dtslog.dll                                             | 2017.140.3025.34 | 103072    | 10-Apr-18 | 09:50 | x86      |
| Dtslog.dll                                             | 2017.140.3025.34 | 120480    | 10-Apr-18 | 02:05 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3025.34 | 541344    | 10-Apr-18 | 01:03 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3025.34 | 545440    | 10-Apr-18 | 02:05 | x64      |
| Dtspipeline.dll                                        | 2017.140.3025.34 | 1266336   | 10-Apr-18 | 09:46 | x64      |
| Dtspipeline.dll                                        | 2017.140.3025.34 | 1059488   | 10-Apr-18 | 09:50 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3025.34 | 48288     | 10-Apr-18 | 09:46 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3025.34 | 42656     | 10-Apr-18 | 02:05 | x86      |
| Dtuparse.dll                                           | 2017.140.3025.34 | 89248     | 10-Apr-18 | 09:46 | x64      |
| Dtuparse.dll                                           | 2017.140.3025.34 | 80032     | 10-Apr-18 | 02:05 | x86      |
| Dtutil.exe                                             | 2017.140.3025.34 | 147104    | 10-Apr-18 | 09:46 | x64      |
| Dtutil.exe                                             | 2017.140.3025.34 | 126112    | 10-Apr-18 | 02:05 | x86      |
| Exceldest.dll                                          | 2017.140.3025.34 | 214688    | 10-Apr-18 | 09:50 | x86      |
| Exceldest.dll                                          | 2017.140.3025.34 | 260768    | 10-Apr-18 | 02:05 | x64      |
| Excelsrc.dll                                           | 2017.140.3025.34 | 282784    | 10-Apr-18 | 09:46 | x64      |
| Excelsrc.dll                                           | 2017.140.3025.34 | 230568    | 10-Apr-18 | 09:50 | x86      |
| Flatfiledest.dll                                       | 2017.140.3025.34 | 330912    | 10-Apr-18 | 09:50 | x86      |
| Flatfiledest.dll                                       | 2017.140.3025.34 | 384160    | 10-Apr-18 | 02:05 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3025.34 | 396456    | 10-Apr-18 | 09:47 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3025.34 | 342176    | 10-Apr-18 | 02:06 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3025.34 | 96416     | 10-Apr-18 | 09:46 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3025.34 | 80544     | 10-Apr-18 | 02:06 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3025.34     | 71328     | 10-Apr-18 | 09:50 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3025.34     | 184480    | 10-Apr-18 | 14:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3025.34     | 406688    | 10-Apr-18 | 02:05 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3025.34     | 406688    | 10-Apr-18 | 02:06 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3025.34     | 2093216   | 10-Apr-18 | 02:05 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3025.34     | 2093216   | 10-Apr-18 | 02:06 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3025.34     | 252576    | 10-Apr-18 | 09:51 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3025.34 | 152224    | 10-Apr-18 | 07:28 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3025.34 | 141984    | 10-Apr-18 | 08:42 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3025.34 | 145568    | 10-Apr-18 | 08:06 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3025.34 | 159392    | 10-Apr-18 | 01:37 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3025.34 | 103072    | 10-Apr-18 | 09:47 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3025.34 | 90272     | 10-Apr-18 | 09:50 | x86      |
| Msmgdsrv.dll                                           | 2017.140.204.1   | 7310496   | 16-Mar-18 | 20:30 | x86      |
| Oledbdest.dll                                          | 2017.140.3025.34 | 261280    | 10-Apr-18 | 09:47 | x64      |
| Oledbdest.dll                                          | 2017.140.3025.34 | 214688    | 10-Apr-18 | 09:50 | x86      |
| Oledbsrc.dll                                           | 2017.140.3025.34 | 288928    | 10-Apr-18 | 09:47 | x64      |
| Oledbsrc.dll                                           | 2017.140.3025.34 | 233120    | 10-Apr-18 | 09:50 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3025.34 | 100512    | 10-Apr-18 | 02:05 | x64      |
| Sqlresld.dll                                           | 2017.140.3025.34 | 30880     | 10-Apr-18 | 02:05 | x64      |
| Sqlresld.dll                                           | 2017.140.3025.34 | 28832     | 10-Apr-18 | 02:06 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3025.34 | 32416     | 10-Apr-18 | 01:03 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3025.34 | 29352     | 10-Apr-18 | 01:03 | x86      |
| Sqlscm.dll                                             | 2017.140.3025.34 | 70816     | 10-Apr-18 | 02:05 | x64      |
| Sqlscm.dll                                             | 2017.140.3025.34 | 60072     | 10-Apr-18 | 02:06 | x86      |
| Sqlsvc.dll                                             | 2017.140.3025.34 | 161440    | 10-Apr-18 | 02:05 | x64      |
| Sqlsvc.dll                                             | 2017.140.3025.34 | 134816    | 10-Apr-18 | 02:06 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3025.34 | 183968    | 10-Apr-18 | 09:49 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3025.34 | 155296    | 10-Apr-18 | 02:06 | x86      |
| Txdataconvert.dll                                      | 2017.140.3025.34 | 293024    | 10-Apr-18 | 09:50 | x64      |
| Txdataconvert.dll                                      | 2017.140.3025.34 | 253096    | 10-Apr-18 | 02:06 | x86      |
| Xe.dll                                                 | 2017.140.3025.34 | 673440    | 10-Apr-18 | 01:37 | x64      |
| Xe.dll                                                 | 2017.140.3025.34 | 595616    | 10-Apr-18 | 01:54 | x86      |
| Xmlrw.dll                                              | 2017.140.3025.34 | 305312    | 10-Apr-18 | 02:05 | x64      |
| Xmlrw.dll                                              | 2017.140.3025.34 | 257696    | 10-Apr-18 | 02:06 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3025.34 | 189600    | 10-Apr-18 | 09:51 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3025.34 | 224416    | 10-Apr-18 | 02:05 | x64      |

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
