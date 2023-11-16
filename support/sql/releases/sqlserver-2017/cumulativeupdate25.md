---
title: Cumulative update 25 for SQL Server 2017 (KB5003830)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 25 (KB5003830).
ms.date: 08/04/2023
ms.custom: KB5003830
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5003830 - Cumulative Update 25 for SQL Server 2017

_Release Date:_ &nbsp; July 12, 2021  
_Version:_ &nbsp; 14.0.3401.7

## Summary

This article describes Cumulative Update package 25 (CU25) for Microsoft SQL Server 2017. This update contains 18 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 24, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3401.7**, file version: **2017.140.3401.7**
- Analysis Services - Product version: **14.0.249.75**, file version: **2017.140.249.75**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component| Platform |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|----------------------------------------------|----------|
| <a id=14092090>[14092090](#14092090) </a> | Fixes an issue where SSAS 2017 unexpected error occurs when you restore a tabular database backed up on the same instance.| Analysis services | Analysis Services | Windows |
| <a id=14012370>[14012370](#14012370) </a> | Fixes an issue in which a database freezes its I/O during a VSS backup but never thaws the I/O. This can lead to latch timeouts. | SQL Server Engine | Backup Restore | Windows |
| <a id=14048638>[14048638](#14048638) </a> | Fixes an issue where you're unable to set up Managed Backup on SQL Server 2016 or 2017 by using Azure SAS credential with a long secret due to SAS expiration in SQL Server 2017. | SQL Server Engine | Backup Restore | Windows |
| <a id=14119445>[14119445](#14119445) </a> | [FIX: Wrong results may occur during Clustered Columnstore Index alter index reorganize in versioned scans in SQL Server 2017 (KB5004560)](https://support.microsoft.com/help/5004560) | SQL Server Engine | Column Stores | Windows |
| <a id=13880247>[13880247](#13880247) </a> | Fixes an issue where a query is stuck in `BATCH_MODE_SORT` in SQL Server 2017. | SQL Server Engine | Column Stores | Windows |
| <a id=14056987>[14056987](#14056987) </a> | Fixes a potential issue that causes error 5511 when performing a log backup on a database that has filestream data. | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=14082570>[14082570](#14082570) </a> | [Improvement: Availability Group listener without the load balancer in SQL Server 2017 and 2019 (KB4578579)](https://support.microsoft.com/help/4578579) | SQL Server Engine |High Availability and Disaster Recovery | Windows |
| <a id=14030483>[14030483](#14030483) </a> | Fixes an issue that causes the database `log_reuse_wait_desc` to change to `AVAILABILITY_REPLICA` when a database is removed from an availability group. | SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=14102876>[14102876](#14102876) </a> | Adds improvement to help diagnose replica connection timeout errors. </br></br>**Note**: This improvement adds `sqlserver.ucs_connection_setup` XEvent and 35206, 35201 `ERROR_REPORTED` XEvent to `AlwaysOn_health`, to provide additional logging detail when connection timeout occurs between error log. SSAS doesn't work with AlwaysOn Availability Groups, but need a different solution for DR unless you're using SQL databases as your data source. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14087445>[14087445](#14087445) </a> | Fixes an issue where SQL Server 2017 CU22 using XTP UserDB for staging tables has steady growing trend for "VARHEAP\Storage internal heap" in `dm_db_xtp_memory_consumers` that leads to OOM/41805 errors when it reaches 50/60GB and requires proactive restart/failover to retain stability. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id=13955890>[13955890](#13955890) </a> | Fixes an issue on how to rotate the service account password without restarting SQL Server. | SQL Server Engine|Linux | Linux|
| <a id=13975159>[13975159](#13975159) </a> | Adds support for 32 key columns to `system sp_pkeys` and fixes the performance regression that occurs after the installation of Cumulative Update 21 (CU21) for SQL Server 2017.| SQL Server Engine | Metadata | Windows |
| <a id=13956645>[13956645](#13956645) </a> | Fixes the `EXCEPTION_INVALID_CRT_PARAMETER` dump that is generated on performing `INSERT\UPDATE` of wide replicated table in SQL Server 2017. | SQL Server Engine | Methods to access stored data| Windows |
| <a id=14082568>[14082568](#14082568) </a> | [Improvement: Failover Cluster DNN in SQL Server 2017 (KB5004766)](https://support.microsoft.com/help/5004766) | SQL Server Connectivity | Protocols | Windows |
| <a id=13647546>[13647546](#13647546) </a> | [FIX: Access Violation on secondary replica may occur when you drop index from view on primary replica in SQL Server 2017 (KB5004646)](https://support.microsoft.com/help/5004646) | SQL Server Engine | Query Optimizer | Windows |
| <a id=14089545>[14089545](#14089545) </a> | [FIX: Update SQL Server 2017 CEIP service to send usage and diagnostic data to a new endpoint (KB5004466)](https://support.microsoft.com/help/5004466) | SQL Server Engine | Telemetry | All |
| <a id=14043333>[14043333](#14043333) </a> | Fixes the assertion error that occurs while performing database recovery in SQL Server 2017. | SQL Server Engine | Transaction Services | All |
| <a id=14043292>[14043292](#14043292) </a> | Fixes an issue where Setup Account Privileges check may not be performed when installing Cumulative Update or Security Update. | SQL Setup | Patching | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2017 CU release.
> - If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog </b></summary>

> [!NOTE]
>
> After future cumulative updates are released for SQL Server 2017, this and all previous CUs can be downloaded from the [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/search.aspx?q=sql%20server%202017). However, we recommend that you always install the latest cumulative update that is available.

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU25 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/07/sqlserver2017-kb5003830-x64_bcd8cf2bfa6d57fca1a6a916a3f54d11687aa97f.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5003830-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5003830-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5003830-x64.exe| B7736A87FCAAFFBE63F44B03DDF7538C7EF5B4DF85DB35266755A81E3A9687D0 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.70 | 259472    | 10-Feb-21 | 00:02  | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.70     | 735120    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.70     | 1374096   | 10-Feb-21 | 00:02  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.70     | 977296    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.70     | 514960    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 9-Feb-21  | 23:58 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 9-Feb-21  | 23:58 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 9-Feb-21  | 23:58 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 9-Feb-21  | 23:58 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 9-Feb-21  | 23:58 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 9-Feb-21  | 23:58 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 9-Feb-21  | 23:58 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 9-Feb-21  | 23:58 | x86      |
| Msmdctr.dll                                        | 2017.140.249.70 | 33168     | 10-Feb-21 | 00:02  | x64      |
| Msmdlocal.dll                                      | 2017.140.249.70 | 40420240  | 10-Feb-21 | 00:04  | x86      |
| Msmdlocal.dll                                      | 2017.140.249.70 | 60765584  | 10-Feb-21 | 00:02  | x64      |
| Msmdpump.dll                                       | 2017.140.249.70 | 9332112   | 10-Feb-21 | 00:02  | x64      |
| Msmdredir.dll                                      | 2017.140.249.70 | 7088016   | 10-Feb-21 | 00:04  | x86      |
| Msmdsrv.exe                                        | 2017.140.249.70 | 60665744  | 10-Feb-21 | 00:02  | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.70 | 7304592   | 10-Feb-21 | 00:04  | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.70 | 9000848   | 10-Feb-21 | 00:02  | x64      |
| Msolap.dll                                         | 2017.140.249.70 | 7773072   | 10-Feb-21 | 00:04  | x86      |
| Msolap.dll                                         | 2017.140.249.70 | 10256784  | 10-Feb-21 | 00:02  | x64      |
| Msolui.dll                                         | 2017.140.249.70 | 280464    | 10-Feb-21 | 00:04  | x86      |
| Msolui.dll                                         | 2017.140.249.70 | 304016    | 10-Feb-21 | 00:02  | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 9-Feb-21  | 23:58 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 9-Feb-21  | 23:58 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02  | x64      |
| Sqlboot.dll                                        | 2017.140.3381.3 | 190848    | 10-Feb-21 | 00:02  | x64      |
| Sqlceip.exe                                        | 14.0.3381.3     | 254848    | 10-Feb-21 | 00:08  | x86      |
| Sqldumper.exe                                      | 2017.140.3381.3 | 138632    | 9-Feb-21  | 23:59 | x64      |
| Sqldumper.exe                                      | 2017.140.3381.3 | 116128    | 9-Feb-21  | 23:59 | x86      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 9-Feb-21  | 23:58 | x86      |
| Tmapi.dll                                          | 2017.140.249.70 | 5814672   | 10-Feb-21 | 00:03  | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.70 | 4157840   | 10-Feb-21 | 00:03  | x64      |
| Tmpersistence.dll                                  | 2017.140.249.70 | 1125264   | 10-Feb-21 | 00:03  | x64      |
| Tmtransactions.dll                                 | 2017.140.249.70 | 1634704   | 10-Feb-21 | 00:03  | x64      |
| Xe.dll                                             | 2017.140.3381.3 | 666520    | 10-Feb-21 | 00:03  | x64      |
| Xmlrw.dll                                          | 2017.140.3381.3 | 298368    | 10-Feb-21 | 00:03  | x64      |
| Xmlrw.dll                                          | 2017.140.3381.3 | 250752    | 10-Feb-21 | 00:04  | x86      |
| Xmlrwbin.dll                                       | 2017.140.3381.3 | 217504    | 10-Feb-21 | 00:03  | x64      |
| Xmlrwbin.dll                                       | 2017.140.3381.3 | 182656    | 10-Feb-21 | 00:04  | x86      |
| Xmsrv.dll                                          | 2017.140.249.70 | 25375632  | 10-Feb-21 | 00:03  | x64      |
| Xmsrv.dll                                          | 2017.140.249.70 | 33349520  | 10-Feb-21 | 00:04  | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3381.3  | 153504    | 10-Feb-21 | 00:03  | x86      |
| Batchparser.dll                            | 2017.140.3381.3  | 173984    | 10-Feb-21 | 00:02  | x64      |
| Instapi150.dll                             | 2017.140.3381.3  | 55688     | 10-Feb-21 | 00:04  | x86      |
| Instapi150.dll                             | 2017.140.3381.3  | 65408     | 10-Feb-21 | 00:02  | x64      |
| Isacctchange.dll                           | 2017.140.3381.3  | 22400     | 10-Feb-21 | 00:03  | x86      |
| Isacctchange.dll                           | 2017.140.3381.3  | 23936     | 10-Feb-21 | 00:02  | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.70      | 1081744   | 10-Feb-21 | 00:03  | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.70      | 1081744   | 10-Feb-21 | 00:02  | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.70      | 1374608   | 10-Feb-21 | 00:03  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.70      | 734608    | 10-Feb-21 | 00:03  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.70      | 734608    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3381.3      | 30592     | 10-Feb-21 | 00:03  | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3381.3  | 71584     | 10-Feb-21 | 00:03  | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3381.3  | 75168     | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3381.3      | 564616    | 10-Feb-21 | 00:03  | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3381.3      | 564616    | 10-Feb-21 | 00:02  | x86      |
| Msasxpress.dll                             | 2017.140.249.70  | 24976     | 10-Feb-21 | 00:04  | x86      |
| Msasxpress.dll                             | 2017.140.249.70  | 29072     | 10-Feb-21 | 00:02  | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3381.3  | 62360     | 10-Feb-21 | 00:04  | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3381.3  | 77216     | 10-Feb-21 | 00:02  | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3381.3  | 93576     | 10-Feb-21 | 00:02  | x64      |
| Sqldumper.exe                              | 2017.140.3381.3  | 138632    | 9-Feb-21  | 23:59 | x64      |
| Sqldumper.exe                              | 2017.140.3381.3  | 116128    | 9-Feb-21  | 23:59 | x86      |
| Sqlftacct.dll                              | 2017.140.3381.3  | 49056     | 10-Feb-21 | 00:04  | x86      |
| Sqlftacct.dll                              | 2017.140.3381.3  | 57248     | 10-Feb-21 | 00:02  | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 10-Feb-21 | 00:04  | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 10-Feb-21 | 00:02  | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3381.3  | 368536    | 10-Feb-21 | 00:04  | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3381.3  | 413088    | 10-Feb-21 | 00:02  | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3381.3  | 28064     | 10-Feb-21 | 00:04  | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3381.3  | 30600     | 10-Feb-21 | 00:02  | x64      |
| Sqlsvcsync.dll                             | 2017.140.3381.3  | 267144    | 10-Feb-21 | 00:04  | x86      |
| Sqlsvcsync.dll                             | 2017.140.3381.3  | 351136    | 10-Feb-21 | 00:02  | x64      |
| Sqltdiagn.dll                              | 2017.140.3381.3  | 53632     | 10-Feb-21 | 00:04  | x86      |
| Sqltdiagn.dll                              | 2017.140.3381.3  | 60808     | 10-Feb-21 | 00:02  | x64      |
| Svrenumapi150.dll                          | 2017.140.3381.3  | 888192    | 10-Feb-21 | 00:04  | x86      |
| Svrenumapi150.dll                          | 2017.140.3381.3  | 1167768   | 10-Feb-21 | 00:02  | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 10-Feb-21 | 00:04 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 10-Feb-21 | 00:04 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 10-Feb-21 | 00:04 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 10-Feb-21 | 00:04 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 10-Feb-21 | 00:02 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3381.3 | 114072    | 10-Feb-21 | 00:03 | x86      |
| Dreplaycommon.dll              | 2017.140.3381.3 | 693152    | 10-Feb-21 | 00:03 | x86      |
| Dreplayserverps.dll            | 2017.140.3381.3 | 26008     | 10-Feb-21 | 00:03 | x86      |
| Dreplayutil.dll                | 2017.140.3381.3 | 302976    | 10-Feb-21 | 00:03 | x86      |
| Instapi150.dll                 | 2017.140.3381.3 | 65408     | 10-Feb-21 | 00:02 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlresourceloader.dll          | 2017.140.3381.3 | 22408     | 10-Feb-21 | 00:04 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3381.3 | 693152    | 10-Feb-21 | 00:03 | x86      |
| Dreplaycontroller.exe              | 2017.140.3381.3 | 343448    | 10-Feb-21 | 00:03 | x86      |
| Dreplayprocess.dll                 | 2017.140.3381.3 | 164736    | 10-Feb-21 | 00:03 | x86      |
| Dreplayserverps.dll                | 2017.140.3381.3 | 26008     | 10-Feb-21 | 00:03 | x86      |
| Instapi150.dll                     | 2017.140.3381.3 | 65408     | 10-Feb-21 | 00:02 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlresourceloader.dll              | 2017.140.3381.3 | 22408     | 10-Feb-21 | 00:04 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3381.3     | 33664     | 10-Feb-21 | 00:02  | x64      |
| Batchparser.dll                              | 2017.140.3381.3 | 173984    | 10-Feb-21 | 00:02  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 10-Feb-21 | 00:05  | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 10-Feb-21 | 00:05  | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 10-Feb-21 | 00:05  | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 10-Feb-21 | 00:04  | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 10-Feb-21 | 00:02  | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3381.3 | 220568    | 10-Feb-21 | 00:02  | x64      |
| Dcexec.exe                                   | 2017.140.3381.3 | 67488     | 10-Feb-21 | 00:02  | x64      |
| Fssres.dll                                   | 2017.140.3381.3 | 83864     | 10-Feb-21 | 00:02  | x64      |
| Hadrres.dll                                  | 2017.140.3381.3 | 182680    | 10-Feb-21 | 00:02  | x64      |
| Hkcompile.dll                                | 2017.140.3381.3 | 1416064   | 10-Feb-21 | 00:02  | x64      |
| Hkengine.dll                                 | 2017.140.3381.3 | 5853600   | 10-Feb-21 | 00:02  | x64      |
| Hkruntime.dll                                | 2017.140.3381.3 | 156032    | 10-Feb-21 | 00:02  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 10-Feb-21 | 00:05  | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.70     | 734096    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3381.3     | 231304    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3381.3     | 73088     | 10-Feb-21 | 00:02  | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3381.3 | 385944    | 10-Feb-21 | 00:02  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3381.3 | 65432     | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3381.3 | 58264     | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3381.3 | 145288    | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3381.3 | 152480    | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3381.3 | 296856    | 10-Feb-21 | 00:02  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3381.3 | 67968     | 10-Feb-21 | 00:02  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 10-Feb-21 | 00:05  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 10-Feb-21 | 00:05  | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 10-Feb-21 | 00:05  | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 10-Feb-21 | 00:05  | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 10-Feb-21 | 00:05  | x64      |
| Odsole70.dll                                 | 2017.140.3381.3 | 85888     | 10-Feb-21 | 00:02  | x64      |
| Opends60.dll                                 | 2017.140.3381.3 | 26016     | 10-Feb-21 | 00:02  | x64      |
| Qds.dll                                      | 2017.140.3381.3 | 1176960   | 10-Feb-21 | 00:02  | x64      |
| Rsfxft.dll                                   | 2017.140.3381.3 | 27544     | 10-Feb-21 | 00:02  | x64      |
| Secforwarder.dll                             | 2017.140.3381.3 | 30600     | 10-Feb-21 | 00:02  | x64      |
| Sqagtres.dll                                 | 2017.140.3381.3 | 69016     | 10-Feb-21 | 00:02  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02  | x64      |
| Sqlaamss.dll                                 | 2017.140.3381.3 | 84864     | 10-Feb-21 | 00:02  | x64      |
| Sqlaccess.dll                                | 2017.140.3381.3 | 468896    | 10-Feb-21 | 00:02  | x64      |
| Sqlagent.exe                                 | 2017.140.3381.3 | 598432    | 10-Feb-21 | 00:02  | x64      |
| Sqlagentctr140.dll                           | 2017.140.3381.3 | 47512     | 10-Feb-21 | 00:04  | x86      |
| Sqlagentctr140.dll                           | 2017.140.3381.3 | 56216     | 10-Feb-21 | 00:02  | x64      |
| Sqlagentlog.dll                              | 2017.140.3381.3 | 26016     | 10-Feb-21 | 00:02  | x64      |
| Sqlagentmail.dll                             | 2017.140.3381.3 | 46976     | 10-Feb-21 | 00:02  | x64      |
| Sqlboot.dll                                  | 2017.140.3381.3 | 190848    | 10-Feb-21 | 00:02  | x64      |
| Sqlceip.exe                                  | 14.0.3381.3     | 254848    | 10-Feb-21 | 00:08  | x86      |
| Sqlcmdss.dll                                 | 2017.140.3381.3 | 67488     | 10-Feb-21 | 00:02  | x64      |
| Sqlctr140.dll                                | 2017.140.3381.3 | 106368    | 10-Feb-21 | 00:04  | x86      |
| Sqlctr140.dll                                | 2017.140.3381.3 | 123808    | 10-Feb-21 | 00:02  | x64      |
| Sqldk.dll                                    | 2017.140.3381.3 | 2800008   | 10-Feb-21 | 00:02  | x64      |
| Sqldtsss.dll                                 | 2017.140.3381.3 | 102304    | 10-Feb-21 | 00:02  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 1493912   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3296672   | 9-Feb-21  | 23:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3480992   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3915168   | 9-Feb-21  | 23:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 4027808   | 9-Feb-21  | 23:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3212704   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3366792   | 10-Feb-21 | 00:08  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3917728   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3787160   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3820952   | 9-Feb-21  | 23:57 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 2087320   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 2033568   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3636120   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3337632   | 10-Feb-21 | 00:11  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3780000   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3588504   | 10-Feb-21 | 00:11  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3596192   | 10-Feb-21 | 00:08  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3402112   | 10-Feb-21 | 00:10  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3290520   | 9-Feb-21  | 23:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 1441184   | 9-Feb-21  | 23:56 | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3677080   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                 | 2017.140.3381.3 | 3785632   | 10-Feb-21 | 00:10  | x64      |
| Sqliosim.com                                 | 2017.140.3381.3 | 306584    | 10-Feb-21 | 00:02  | x64      |
| Sqliosim.exe                                 | 2017.140.3381.3 | 3013024   | 10-Feb-21 | 00:02  | x64      |
| Sqllang.dll                                  | 2017.140.3381.3 | 41258904  | 10-Feb-21 | 00:02  | x64      |
| Sqlmin.dll                                   | 2017.140.3381.3 | 40418176  | 10-Feb-21 | 00:02  | x64      |
| Sqlolapss.dll                                | 2017.140.3381.3 | 102280    | 10-Feb-21 | 00:02  | x64      |
| Sqlos.dll                                    | 2017.140.3381.3 | 19336     | 10-Feb-21 | 00:02  | x64      |
| Sqlpowershellss.dll                          | 2017.140.3381.3 | 62848     | 10-Feb-21 | 00:02  | x64      |
| Sqlrepss.dll                                 | 2017.140.3381.3 | 61824     | 10-Feb-21 | 00:02  | x64      |
| Sqlresld.dll                                 | 2017.140.3381.3 | 23960     | 10-Feb-21 | 00:02  | x64      |
| Sqlresourceloader.dll                        | 2017.140.3381.3 | 25472     | 10-Feb-21 | 00:02  | x64      |
| Sqlscm.dll                                   | 2017.140.3381.3 | 65952     | 10-Feb-21 | 00:02  | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3381.3 | 20864     | 10-Feb-21 | 00:02  | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3381.3 | 5890464   | 10-Feb-21 | 00:02  | x64      |
| Sqlserverspatial150.dll                      | 2017.140.3381.3 | 725912    | 10-Feb-21 | 00:02  | x64      |
| Sqlservr.exe                                 | 2017.140.3381.3 | 481672    | 10-Feb-21 | 00:02  | x64      |
| Sqlsvc.dll                                   | 2017.140.3381.3 | 156040    | 10-Feb-21 | 00:02  | x64      |
| Sqltses.dll                                  | 2017.140.3381.3 | 9555840   | 10-Feb-21 | 00:02  | x64      |
| Sqsrvres.dll                                 | 2017.140.3381.3 | 255872    | 10-Feb-21 | 00:02  | x64      |
| Svl.dll                                      | 2017.140.3381.3 | 146848    | 10-Feb-21 | 00:02  | x64      |
| Xe.dll                                       | 2017.140.3381.3 | 666520    | 10-Feb-21 | 00:03  | x64      |
| Xmlrw.dll                                    | 2017.140.3381.3 | 298368    | 10-Feb-21 | 00:03  | x64      |
| Xmlrwbin.dll                                 | 2017.140.3381.3 | 217504    | 10-Feb-21 | 00:03  | x64      |
| Xpadsi.exe                                   | 2017.140.3381.3 | 84888     | 10-Feb-21 | 00:02  | x64      |
| Xplog70.dll                                  | 2017.140.3381.3 | 71040     | 10-Feb-21 | 00:03  | x64      |
| Xpqueue.dll                                  | 2017.140.3381.3 | 68000     | 10-Feb-21 | 00:03  | x64      |
| Xprepl.dll                                   | 2017.140.3381.3 | 96640     | 10-Feb-21 | 00:03  | x64      |
| Xpsqlbot.dll                                 | 2017.140.3381.3 | 25480     | 10-Feb-21 | 00:03  | x64      |
| Xpstar.dll                                   | 2017.140.3381.3 | 445344    | 10-Feb-21 | 00:02  | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3381.3 | 153504    | 10-Feb-21 | 00:03 | x86      |
| Batchparser.dll                                             | 2017.140.3381.3 | 173984    | 10-Feb-21 | 00:02 | x64      |
| Bcp.exe                                                     | 2017.140.3381.3 | 113024    | 10-Feb-21 | 00:02 | x64      |
| Commanddest.dll                                             | 2017.140.3381.3 | 239008    | 10-Feb-21 | 00:02 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3381.3 | 109448    | 10-Feb-21 | 00:02 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3381.3 | 180608    | 10-Feb-21 | 00:02 | x64      |
| Distrib.exe                                                 | 2017.140.3381.3 | 198016    | 10-Feb-21 | 00:02 | x64      |
| Dteparse.dll                                                | 2017.140.3381.3 | 104352    | 10-Feb-21 | 00:02 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtepkg.dll                                                  | 2017.140.3381.3 | 130952    | 10-Feb-21 | 00:02 | x64      |
| Dtexec.exe                                                  | 2017.140.3381.3 | 66968     | 10-Feb-21 | 00:02 | x64      |
| Dts.dll                                                     | 2017.140.3381.3 | 2994056   | 10-Feb-21 | 00:02 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3381.3 | 468360    | 10-Feb-21 | 00:02 | x64      |
| Dtsconn.dll                                                 | 2017.140.3381.3 | 493464    | 10-Feb-21 | 00:02 | x64      |
| Dtshost.exe                                                 | 2017.140.3381.3 | 99208     | 10-Feb-21 | 00:02 | x64      |
| Dtslog.dll                                                  | 2017.140.3381.3 | 113544    | 10-Feb-21 | 00:02 | x64      |
| Dtsmsg150.dll                                               | 2017.140.3381.3 | 538496    | 10-Feb-21 | 00:02 | x64      |
| Dtspipeline.dll                                             | 2017.140.3381.3 | 1261464   | 10-Feb-21 | 00:02 | x64      |
| Dtspipelineperf150.dll                                      | 2017.140.3381.3 | 41376     | 10-Feb-21 | 00:02 | x64      |
| Dtuparse.dll                                                | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtutil.exe                                                  | 2017.140.3381.3 | 141720    | 10-Feb-21 | 00:02 | x64      |
| Exceldest.dll                                               | 2017.140.3381.3 | 253832    | 10-Feb-21 | 00:02 | x64      |
| Excelsrc.dll                                                | 2017.140.3381.3 | 275872    | 10-Feb-21 | 00:02 | x64      |
| Execpackagetask.dll                                         | 2017.140.3381.3 | 161152    | 10-Feb-21 | 00:02 | x64      |
| Flatfiledest.dll                                            | 2017.140.3381.3 | 379800    | 10-Feb-21 | 00:02 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3381.3 | 392608    | 10-Feb-21 | 00:02 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3381.3 | 89496     | 10-Feb-21 | 00:02 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3381.3 | 52640     | 10-Feb-21 | 00:02 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 10-Feb-21 | 00:05 | x86      |
| Logread.exe                                                 | 2017.140.3381.3 | 629664    | 10-Feb-21 | 00:02 | x64      |
| Mergetxt.dll                                                | 2017.140.3381.3 | 58264     | 10-Feb-21 | 00:02 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.70     | 1375120   | 10-Feb-21 | 00:02 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 10-Feb-21 | 00:05 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3381.3     | 130944    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3381.3     | 48544     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3381.3     | 82848     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3381.3     | 66432     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3381.3     | 385408    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3381.3     | 607624    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3381.3 | 1657752   | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3381.3     | 564616    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3381.3 | 145288    | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3381.3 | 152480    | 10-Feb-21 | 00:02 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3381.3 | 96136     | 10-Feb-21 | 00:02 | x64      |
| Msgprox.dll                                                 | 2017.140.3381.3 | 265088    | 10-Feb-21 | 00:02 | x64      |
| Msxmlsql.dll                                                | 2017.140.3381.3 | 1441176   | 10-Feb-21 | 00:02 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 10-Feb-21 | 00:05 | x86      |
| Oledbdest.dll                                               | 2017.140.3381.3 | 254344    | 10-Feb-21 | 00:02 | x64      |
| Oledbsrc.dll                                                | 2017.140.3381.3 | 281992    | 10-Feb-21 | 00:02 | x64      |
| Osql.exe                                                    | 2017.140.3381.3 | 68488     | 10-Feb-21 | 00:02 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3381.3 | 468864    | 10-Feb-21 | 00:02 | x64      |
| Rawdest.dll                                                 | 2017.140.3381.3 | 199584    | 10-Feb-21 | 00:02 | x64      |
| Rawsource.dll                                               | 2017.140.3381.3 | 187272    | 10-Feb-21 | 00:02 | x64      |
| Rdistcom.dll                                                | 2017.140.3381.3 | 852376    | 10-Feb-21 | 00:03 | x64      |
| Recordsetdest.dll                                           | 2017.140.3381.3 | 177536    | 10-Feb-21 | 00:02 | x64      |
| Replagnt.dll                                                | 2017.140.3381.3 | 23968     | 10-Feb-21 | 00:03 | x64      |
| Repldp.dll                                                  | 2017.140.3381.3 | 285568    | 10-Feb-21 | 00:03 | x64      |
| Replerrx.dll                                                | 2017.140.3381.3 | 148864    | 10-Feb-21 | 00:03 | x64      |
| Replisapi.dll                                               | 2017.140.3381.3 | 357248    | 10-Feb-21 | 00:03 | x64      |
| Replmerg.exe                                                | 2017.140.3381.3 | 520064    | 10-Feb-21 | 00:03 | x64      |
| Replprov.dll                                                | 2017.140.3381.3 | 797056    | 10-Feb-21 | 00:03 | x64      |
| Replrec.dll                                                 | 2017.140.3381.3 | 970144    | 10-Feb-21 | 00:03 | x64      |
| Replsub.dll                                                 | 2017.140.3381.3 | 440200    | 10-Feb-21 | 00:03 | x64      |
| Replsync.dll                                                | 2017.140.3381.3 | 148360    | 10-Feb-21 | 00:03 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 10-Feb-21 | 00:02 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 10-Feb-21 | 00:02 | x64      |
| Spresolv.dll                                                | 2017.140.3381.3 | 247176    | 10-Feb-21 | 00:02 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3381.3 | 242048    | 10-Feb-21 | 00:02 | x64      |
| Sqldiag.exe                                                 | 2017.140.3381.3 | 1254808   | 10-Feb-21 | 00:02 | x64      |
| Sqldistx.dll                                                | 2017.140.3381.3 | 219544    | 10-Feb-21 | 00:02 | x64      |
| Sqllogship.exe                                              | 14.0.3381.3     | 99200     | 10-Feb-21 | 00:02 | x64      |
| Sqlmergx.dll                                                | 2017.140.3381.3 | 355200    | 10-Feb-21 | 00:02 | x64      |
| Sqlresld.dll                                                | 2017.140.3381.3 | 21920     | 10-Feb-21 | 00:04 | x86      |
| Sqlresld.dll                                                | 2017.140.3381.3 | 23960     | 10-Feb-21 | 00:02 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3381.3 | 22408     | 10-Feb-21 | 00:04 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3381.3 | 25472     | 10-Feb-21 | 00:02 | x64      |
| Sqlscm.dll                                                  | 2017.140.3381.3 | 55200     | 10-Feb-21 | 00:04 | x86      |
| Sqlscm.dll                                                  | 2017.140.3381.3 | 65952     | 10-Feb-21 | 00:02 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3381.3 | 128408    | 10-Feb-21 | 00:04 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3381.3 | 156040    | 10-Feb-21 | 00:02 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3381.3 | 177056    | 10-Feb-21 | 00:02 | x64      |
| Sqlwep140.dll                                               | 2017.140.3381.3 | 98688     | 10-Feb-21 | 00:02 | x64      |
| Ssdebugps.dll                                               | 2017.140.3381.3 | 26496     | 10-Feb-21 | 00:02 | x64      |
| Ssisoledb.dll                                               | 2017.140.3381.3 | 209312    | 10-Feb-21 | 00:02 | x64      |
| Ssradd.dll                                                  | 2017.140.3381.3 | 70040     | 10-Feb-21 | 00:02 | x64      |
| Ssravg.dll                                                  | 2017.140.3381.3 | 70528     | 10-Feb-21 | 00:02 | x64      |
| Ssrdown.dll                                                 | 2017.140.3381.3 | 55168     | 10-Feb-21 | 00:02 | x64      |
| Ssrmax.dll                                                  | 2017.140.3381.3 | 68504     | 10-Feb-21 | 00:02 | x64      |
| Ssrmin.dll                                                  | 2017.140.3381.3 | 68480     | 10-Feb-21 | 00:02 | x64      |
| Ssrpub.dll                                                  | 2017.140.3381.3 | 55688     | 10-Feb-21 | 00:02 | x64      |
| Ssrup.dll                                                   | 2017.140.3381.3 | 55168     | 10-Feb-21 | 00:02 | x64      |
| Tablediff.exe                                               | 14.0.3381.3     | 79752     | 10-Feb-21 | 00:03 | x64      |
| Txagg.dll                                                   | 2017.140.3381.3 | 355208    | 10-Feb-21 | 00:02 | x64      |
| Txbdd.dll                                                   | 2017.140.3381.3 | 163224    | 10-Feb-21 | 00:02 | x64      |
| Txdatacollector.dll                                         | 2017.140.3381.3 | 353688    | 10-Feb-21 | 00:02 | x64      |
| Txdataconvert.dll                                           | 2017.140.3381.3 | 286088    | 10-Feb-21 | 00:02 | x64      |
| Txderived.dll                                               | 2017.140.3381.3 | 597384    | 10-Feb-21 | 00:02 | x64      |
| Txlookup.dll                                                | 2017.140.3381.3 | 521096    | 10-Feb-21 | 00:02 | x64      |
| Txmerge.dll                                                 | 2017.140.3381.3 | 223136    | 10-Feb-21 | 00:02 | x64      |
| Txmergejoin.dll                                             | 2017.140.3381.3 | 268704    | 10-Feb-21 | 00:02 | x64      |
| Txmulticast.dll                                             | 2017.140.3381.3 | 120728    | 10-Feb-21 | 00:02 | x64      |
| Txrowcount.dll                                              | 2017.140.3381.3 | 118656    | 10-Feb-21 | 00:02 | x64      |
| Txsort.dll                                                  | 2017.140.3381.3 | 249728    | 10-Feb-21 | 00:02 | x64      |
| Txsplit.dll                                                 | 2017.140.3381.3 | 589696    | 10-Feb-21 | 00:02 | x64      |
| Txunionall.dll                                              | 2017.140.3381.3 | 174976    | 10-Feb-21 | 00:02 | x64      |
| Xe.dll                                                      | 2017.140.3381.3 | 666520    | 10-Feb-21 | 00:03 | x64      |
| Xmlrw.dll                                                   | 2017.140.3381.3 | 298368    | 10-Feb-21 | 00:03 | x64      |
| Xmlsub.dll                                                  | 2017.140.3381.3 | 255392    | 10-Feb-21 | 00:03 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3381.3 | 1119104   | 10-Feb-21 | 00:02 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlsatellite.dll              | 2017.140.3381.3 | 916872    | 10-Feb-21 | 00:02 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3381.3 | 665504    | 10-Feb-21 | 00:02 | x64      |
| Fdhost.exe               | 2017.140.3381.3 | 109440    | 10-Feb-21 | 00:02 | x64      |
| Fdlauncher.exe           | 2017.140.3381.3 | 57216     | 10-Feb-21 | 00:02 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 10-Feb-21 | 00:02 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlft140ph.dll           | 2017.140.3381.3 | 62880     | 10-Feb-21 | 00:02 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3381.3     | 17280     | 10-Feb-21 | 00:02 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 10-Feb-21 | 00:03 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 10-Feb-21 | 00:02 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 10-Feb-21 | 00:03 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 10-Feb-21 | 00:02 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 10-Feb-21 | 00:03 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 10-Feb-21 | 00:02 | x86      |
| Commanddest.dll                                               | 2017.140.3381.3 | 193928    | 10-Feb-21 | 00:03 | x86      |
| Commanddest.dll                                               | 2017.140.3381.3 | 239008    | 10-Feb-21 | 00:02 | x64      |
| Dteparse.dll                                                  | 2017.140.3381.3 | 93600     | 10-Feb-21 | 00:03 | x86      |
| Dteparse.dll                                                  | 2017.140.3381.3 | 104352    | 10-Feb-21 | 00:02 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3381.3 | 76696     | 10-Feb-21 | 00:03 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtepkg.dll                                                    | 2017.140.3381.3 | 109952    | 10-Feb-21 | 00:03 | x86      |
| Dtepkg.dll                                                    | 2017.140.3381.3 | 130952    | 10-Feb-21 | 00:02 | x64      |
| Dtexec.exe                                                    | 2017.140.3381.3 | 60824     | 10-Feb-21 | 00:03 | x86      |
| Dtexec.exe                                                    | 2017.140.3381.3 | 66968     | 10-Feb-21 | 00:02 | x64      |
| Dts.dll                                                       | 2017.140.3381.3 | 2544032   | 10-Feb-21 | 00:03 | x86      |
| Dts.dll                                                       | 2017.140.3381.3 | 2994056   | 10-Feb-21 | 00:02 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3381.3 | 411040    | 10-Feb-21 | 00:03 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3381.3 | 468360    | 10-Feb-21 | 00:02 | x64      |
| Dtsconn.dll                                                   | 2017.140.3381.3 | 395672    | 10-Feb-21 | 00:03 | x86      |
| Dtsconn.dll                                                   | 2017.140.3381.3 | 493464    | 10-Feb-21 | 00:02 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3381.3 | 88448     | 10-Feb-21 | 00:03 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3381.3 | 104320    | 10-Feb-21 | 00:02 | x64      |
| Dtshost.exe                                                   | 2017.140.3381.3 | 84384     | 10-Feb-21 | 00:04 | x86      |
| Dtshost.exe                                                   | 2017.140.3381.3 | 99208     | 10-Feb-21 | 00:02 | x64      |
| Dtslog.dll                                                    | 2017.140.3381.3 | 96152     | 10-Feb-21 | 00:03 | x86      |
| Dtslog.dll                                                    | 2017.140.3381.3 | 113544    | 10-Feb-21 | 00:02 | x64      |
| Dtsmsg150.dll                                                 | 2017.140.3381.3 | 534424    | 10-Feb-21 | 00:04 | x86      |
| Dtsmsg150.dll                                                 | 2017.140.3381.3 | 538496    | 10-Feb-21 | 00:02 | x64      |
| Dtspipeline.dll                                               | 2017.140.3381.3 | 1053568   | 10-Feb-21 | 00:03 | x86      |
| Dtspipeline.dll                                               | 2017.140.3381.3 | 1261464   | 10-Feb-21 | 00:02 | x64      |
| Dtspipelineperf150.dll                                        | 2017.140.3381.3 | 35744     | 10-Feb-21 | 00:03 | x86      |
| Dtspipelineperf150.dll                                        | 2017.140.3381.3 | 41376     | 10-Feb-21 | 00:02 | x64      |
| Dtuparse.dll                                                  | 2017.140.3381.3 | 73112     | 10-Feb-21 | 00:03 | x86      |
| Dtuparse.dll                                                  | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtutil.exe                                                    | 2017.140.3381.3 | 120704    | 10-Feb-21 | 00:03 | x86      |
| Dtutil.exe                                                    | 2017.140.3381.3 | 141720    | 10-Feb-21 | 00:02 | x64      |
| Exceldest.dll                                                 | 2017.140.3381.3 | 207744    | 10-Feb-21 | 00:03 | x86      |
| Exceldest.dll                                                 | 2017.140.3381.3 | 253832    | 10-Feb-21 | 00:02 | x64      |
| Excelsrc.dll                                                  | 2017.140.3381.3 | 223616    | 10-Feb-21 | 00:03 | x86      |
| Excelsrc.dll                                                  | 2017.140.3381.3 | 275872    | 10-Feb-21 | 00:02 | x64      |
| Execpackagetask.dll                                           | 2017.140.3381.3 | 128416    | 10-Feb-21 | 00:03 | x86      |
| Execpackagetask.dll                                           | 2017.140.3381.3 | 161152    | 10-Feb-21 | 00:02 | x64      |
| Flatfiledest.dll                                              | 2017.140.3381.3 | 325504    | 10-Feb-21 | 00:03 | x86      |
| Flatfiledest.dll                                              | 2017.140.3381.3 | 379800    | 10-Feb-21 | 00:02 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3381.3 | 337288    | 10-Feb-21 | 00:03 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3381.3 | 392608    | 10-Feb-21 | 00:02 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3381.3 | 73624     | 10-Feb-21 | 00:03 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3381.3 | 89496     | 10-Feb-21 | 00:02 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 10-Feb-21 | 00:05 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 10-Feb-21 | 00:00 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3381.3     | 460184    | 10-Feb-21 | 00:03 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3381.3     | 459648    | 10-Feb-21 | 00:02 | x64      |
| Isserverexec.exe                                              | 14.0.3381.3     | 142208    | 10-Feb-21 | 00:03 | x86      |
| Isserverexec.exe                                              | 14.0.3381.3     | 141720    | 10-Feb-21 | 00:02 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.70     | 1375120   | 10-Feb-21 | 00:03 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.70     | 1375120   | 10-Feb-21 | 00:02 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 10-Feb-21 | 00:08 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 10-Feb-21 | 00:05 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 10-Feb-21 | 00:00 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3381.3     | 67488     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3381.3 | 100224    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3381.3 | 105368    | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3381.3     | 48520     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3381.3     | 48544     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3381.3     | 82848     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3381.3     | 82848     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3381.3     | 66464     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3381.3     | 66432     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3381.3     | 507808    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3381.3     | 507808    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3381.3     | 76696     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3381.3     | 76672     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3381.3     | 408960    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3381.3     | 408968    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3381.3     | 385408    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3381.3     | 607640    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3381.3     | 607624    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3381.3     | 246176    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3381.3     | 246176    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3381.3     | 48008     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3381.3     | 48008     | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3381.3 | 135048    | 10-Feb-21 | 00:04 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3381.3 | 145288    | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3381.3 | 138656    | 10-Feb-21 | 00:04 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3381.3 | 152480    | 10-Feb-21 | 00:02 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3381.3     | 212872    | 10-Feb-21 | 00:02 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3381.3 | 83328     | 10-Feb-21 | 00:03 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3381.3 | 96136     | 10-Feb-21 | 00:02 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.70 | 9191808   | 10-Feb-21 | 00:02 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 10-Feb-21 | 00:00 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 10-Feb-21 | 00:08 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 10-Feb-21 | 00:05 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 10-Feb-21 | 00:00 | x86      |
| Oledbdest.dll                                                 | 2017.140.3381.3 | 207752    | 10-Feb-21 | 00:03 | x86      |
| Oledbdest.dll                                                 | 2017.140.3381.3 | 254344    | 10-Feb-21 | 00:02 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3381.3 | 226184    | 10-Feb-21 | 00:03 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3381.3 | 281992    | 10-Feb-21 | 00:02 | x64      |
| Rawdest.dll                                                   | 2017.140.3381.3 | 159616    | 10-Feb-21 | 00:04 | x86      |
| Rawdest.dll                                                   | 2017.140.3381.3 | 199584    | 10-Feb-21 | 00:02 | x64      |
| Rawsource.dll                                                 | 2017.140.3381.3 | 146336    | 10-Feb-21 | 00:04 | x86      |
| Rawsource.dll                                                 | 2017.140.3381.3 | 187272    | 10-Feb-21 | 00:02 | x64      |
| Recordsetdest.dll                                             | 2017.140.3381.3 | 142208    | 10-Feb-21 | 00:04 | x86      |
| Recordsetdest.dll                                             | 2017.140.3381.3 | 177536    | 10-Feb-21 | 00:02 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlceip.exe                                                   | 14.0.3381.3     | 254848    | 10-Feb-21 | 00:08 | x86      |
| Sqldest.dll                                                   | 2017.140.3381.3 | 206728    | 10-Feb-21 | 00:04 | x86      |
| Sqldest.dll                                                   | 2017.140.3381.3 | 253832    | 10-Feb-21 | 00:02 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3381.3 | 148384    | 10-Feb-21 | 00:04 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3381.3 | 177056    | 10-Feb-21 | 00:02 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3381.3 | 169880    | 10-Feb-21 | 00:04 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3381.3 | 209312    | 10-Feb-21 | 00:02 | x64      |
| Txagg.dll                                                     | 2017.140.3381.3 | 295328    | 10-Feb-21 | 00:04 | x86      |
| Txagg.dll                                                     | 2017.140.3381.3 | 355208    | 10-Feb-21 | 00:02 | x64      |
| Txbdd.dll                                                     | 2017.140.3381.3 | 129432    | 10-Feb-21 | 00:04 | x86      |
| Txbdd.dll                                                     | 2017.140.3381.3 | 163224    | 10-Feb-21 | 00:02 | x64      |
| Txbestmatch.dll                                               | 2017.140.3381.3 | 486280    | 10-Feb-21 | 00:04 | x86      |
| Txbestmatch.dll                                               | 2017.140.3381.3 | 598432    | 10-Feb-21 | 00:02 | x64      |
| Txcache.dll                                                   | 2017.140.3381.3 | 139136    | 10-Feb-21 | 00:04 | x86      |
| Txcache.dll                                                   | 2017.140.3381.3 | 173472    | 10-Feb-21 | 00:02 | x64      |
| Txcharmap.dll                                                 | 2017.140.3381.3 | 242080    | 10-Feb-21 | 00:04 | x86      |
| Txcharmap.dll                                                 | 2017.140.3381.3 | 279944    | 10-Feb-21 | 00:02 | x64      |
| Txcopymap.dll                                                 | 2017.140.3381.3 | 138648    | 10-Feb-21 | 00:04 | x86      |
| Txcopymap.dll                                                 | 2017.140.3381.3 | 173440    | 10-Feb-21 | 00:02 | x64      |
| Txdataconvert.dll                                             | 2017.140.3381.3 | 246168    | 10-Feb-21 | 00:04 | x86      |
| Txdataconvert.dll                                             | 2017.140.3381.3 | 286088    | 10-Feb-21 | 00:02 | x64      |
| Txderived.dll                                                 | 2017.140.3381.3 | 508800    | 10-Feb-21 | 00:04 | x86      |
| Txderived.dll                                                 | 2017.140.3381.3 | 597384    | 10-Feb-21 | 00:02 | x64      |
| Txfileextractor.dll                                           | 2017.140.3381.3 | 153984    | 10-Feb-21 | 00:04 | x86      |
| Txfileextractor.dll                                           | 2017.140.3381.3 | 191872    | 10-Feb-21 | 00:02 | x64      |
| Txfileinserter.dll                                            | 2017.140.3381.3 | 152448    | 10-Feb-21 | 00:04 | x86      |
| Txfileinserter.dll                                            | 2017.140.3381.3 | 189856    | 10-Feb-21 | 00:02 | x64      |
| Txgroupdups.dll                                               | 2017.140.3381.3 | 224136    | 10-Feb-21 | 00:04 | x86      |
| Txgroupdups.dll                                               | 2017.140.3381.3 | 283520    | 10-Feb-21 | 00:02 | x64      |
| Txlineage.dll                                                 | 2017.140.3381.3 | 103296    | 10-Feb-21 | 00:04 | x86      |
| Txlineage.dll                                                 | 2017.140.3381.3 | 129944    | 10-Feb-21 | 00:02 | x64      |
| Txlookup.dll                                                  | 2017.140.3381.3 | 439704    | 10-Feb-21 | 00:04 | x86      |
| Txlookup.dll                                                  | 2017.140.3381.3 | 521096    | 10-Feb-21 | 00:02 | x64      |
| Txmerge.dll                                                   | 2017.140.3381.3 | 169880    | 10-Feb-21 | 00:04 | x86      |
| Txmerge.dll                                                   | 2017.140.3381.3 | 223136    | 10-Feb-21 | 00:02 | x64      |
| Txmergejoin.dll                                               | 2017.140.3381.3 | 214936    | 10-Feb-21 | 00:04 | x86      |
| Txmergejoin.dll                                               | 2017.140.3381.3 | 268704    | 10-Feb-21 | 00:02 | x64      |
| Txmulticast.dll                                               | 2017.140.3381.3 | 95616     | 10-Feb-21 | 00:04 | x86      |
| Txmulticast.dll                                               | 2017.140.3381.3 | 120728    | 10-Feb-21 | 00:02 | x64      |
| Txpivot.dll                                                   | 2017.140.3381.3 | 173440    | 10-Feb-21 | 00:04 | x86      |
| Txpivot.dll                                                   | 2017.140.3381.3 | 218008    | 10-Feb-21 | 00:02 | x64      |
| Txrowcount.dll                                                | 2017.140.3381.3 | 94624     | 10-Feb-21 | 00:04 | x86      |
| Txrowcount.dll                                                | 2017.140.3381.3 | 118656    | 10-Feb-21 | 00:02 | x64      |
| Txsampling.dll                                                | 2017.140.3381.3 | 128904    | 10-Feb-21 | 00:04 | x86      |
| Txsampling.dll                                                | 2017.140.3381.3 | 165760    | 10-Feb-21 | 00:02 | x64      |
| Txscd.dll                                                     | 2017.140.3381.3 | 163224    | 10-Feb-21 | 00:04 | x86      |
| Txscd.dll                                                     | 2017.140.3381.3 | 213896    | 10-Feb-21 | 00:02 | x64      |
| Txsort.dll                                                    | 2017.140.3381.3 | 201112    | 10-Feb-21 | 00:04 | x86      |
| Txsort.dll                                                    | 2017.140.3381.3 | 249728    | 10-Feb-21 | 00:02 | x64      |
| Txsplit.dll                                                   | 2017.140.3381.3 | 503704    | 10-Feb-21 | 00:04 | x86      |
| Txsplit.dll                                                   | 2017.140.3381.3 | 589696    | 10-Feb-21 | 00:02 | x64      |
| Txtermextraction.dll                                          | 2017.140.3381.3 | 8608128   | 10-Feb-21 | 00:04 | x86      |
| Txtermextraction.dll                                          | 2017.140.3381.3 | 8669576   | 10-Feb-21 | 00:02 | x64      |
| Txtermlookup.dll                                              | 2017.140.3381.3 | 4099968   | 10-Feb-21 | 00:04 | x86      |
| Txtermlookup.dll                                              | 2017.140.3381.3 | 4150176   | 10-Feb-21 | 00:02 | x64      |
| Txunionall.dll                                                | 2017.140.3381.3 | 132512    | 10-Feb-21 | 00:04 | x86      |
| Txunionall.dll                                                | 2017.140.3381.3 | 174976    | 10-Feb-21 | 00:02 | x64      |
| Txunpivot.dll                                                 | 2017.140.3381.3 | 153496    | 10-Feb-21 | 00:04 | x86      |
| Txunpivot.dll                                                 | 2017.140.3381.3 | 192920    | 10-Feb-21 | 00:02 | x64      |
| Xe.dll                                                        | 2017.140.3381.3 | 666520    | 10-Feb-21 | 00:03 | x64      |
| Xe.dll                                                        | 2017.140.3381.3 | 588672    | 10-Feb-21 | 00:04 | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 10-Feb-21 | 00:08  | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 10-Feb-21 | 00:08  | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 10-Feb-21 | 00:08  | x86      |
| Instapi150.dll                                                       | 2017.140.3381.3  | 65408     | 10-Feb-21 | 00:08  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 10-Feb-21 | 00:07  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 9-Feb-21  | 23:57 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 9-Feb-21  | 23:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 10-Feb-21 | 00:07  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 10-Feb-21 | 00:11  | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 10-Feb-21 | 00:07  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 9-Feb-21  | 23:57 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 9-Feb-21  | 23:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 9-Feb-21  | 23:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 10-Feb-21 | 00:07  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 10-Feb-21 | 00:05  | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 10-Feb-21 | 00:11  | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 10-Feb-21 | 00:08  | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 10-Feb-21 | 00:08  | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3381.3  | 400288    | 10-Feb-21 | 00:08  | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3381.3  | 7321496   | 10-Feb-21 | 00:08  | x64      |
| Secforwarder.dll                                                     | 2017.140.3381.3  | 30600     | 10-Feb-21 | 00:08  | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 10-Feb-21 | 00:08  | x64      |
| Sqldk.dll                                                            | 2017.140.3381.3  | 2733448   | 10-Feb-21 | 00:08  | x64      |
| Sqldumper.exe                                                        | 2017.140.3381.3  | 138632    | 10-Feb-21 | 00:08  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 1493912   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3915168   | 9-Feb-21  | 23:57 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3212704   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3917728   | 10-Feb-21 | 00:05  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3820952   | 9-Feb-21  | 23:57 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 2087320   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 2033568   | 9-Feb-21  | 23:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3588504   | 10-Feb-21 | 00:11  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3596192   | 10-Feb-21 | 00:08  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 1441184   | 9-Feb-21  | 23:56 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3381.3  | 3785632   | 10-Feb-21 | 00:10  | x64      |
| Sqlncli13e.dll                                                       | 2017.140.3381.3  | 2257824   | 10-Feb-21 | 00:08  | x64      |
| Sqlos.dll                                                            | 2017.140.3381.3  | 19336     | 10-Feb-21 | 00:08  | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 10-Feb-21 | 00:08  | x64      |
| Sqltses.dll                                                          | 2017.140.3381.3  | 9729416   | 10-Feb-21 | 00:08  | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3381.3     | 17312     | 10-Feb-21 | 00:02 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                              | 2017.140.3381.3 | 1441664   | 10-Feb-21 | 00:04 | x86      |
| Dtaengine.exe                                              | 2017.140.3381.3 | 197504    | 10-Feb-21 | 00:03 | x86      |
| Dteparse.dll                                               | 2017.140.3381.3 | 93600     | 10-Feb-21 | 00:03 | x86      |
| Dteparse.dll                                               | 2017.140.3381.3 | 104352    | 10-Feb-21 | 00:02 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3381.3 | 76696     | 10-Feb-21 | 00:03 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtepkg.dll                                                 | 2017.140.3381.3 | 109952    | 10-Feb-21 | 00:03 | x86      |
| Dtepkg.dll                                                 | 2017.140.3381.3 | 130952    | 10-Feb-21 | 00:02 | x64      |
| Dtexec.exe                                                 | 2017.140.3381.3 | 60824     | 10-Feb-21 | 00:03 | x86      |
| Dtexec.exe                                                 | 2017.140.3381.3 | 66968     | 10-Feb-21 | 00:02 | x64      |
| Dts.dll                                                    | 2017.140.3381.3 | 2544032   | 10-Feb-21 | 00:03 | x86      |
| Dts.dll                                                    | 2017.140.3381.3 | 2994056   | 10-Feb-21 | 00:02 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3381.3 | 411040    | 10-Feb-21 | 00:03 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3381.3 | 468360    | 10-Feb-21 | 00:02 | x64      |
| Dtsconn.dll                                                | 2017.140.3381.3 | 395672    | 10-Feb-21 | 00:03 | x86      |
| Dtsconn.dll                                                | 2017.140.3381.3 | 493464    | 10-Feb-21 | 00:02 | x64      |
| Dtshost.exe                                                | 2017.140.3381.3 | 84384     | 10-Feb-21 | 00:04 | x86      |
| Dtshost.exe                                                | 2017.140.3381.3 | 99208     | 10-Feb-21 | 00:02 | x64      |
| Dtslog.dll                                                 | 2017.140.3381.3 | 96152     | 10-Feb-21 | 00:03 | x86      |
| Dtslog.dll                                                 | 2017.140.3381.3 | 113544    | 10-Feb-21 | 00:02 | x64      |
| Dtsmsg150.dll                                              | 2017.140.3381.3 | 534424    | 10-Feb-21 | 00:04 | x86      |
| Dtsmsg150.dll                                              | 2017.140.3381.3 | 538496    | 10-Feb-21 | 00:02 | x64      |
| Dtspipeline.dll                                            | 2017.140.3381.3 | 1053568   | 10-Feb-21 | 00:03 | x86      |
| Dtspipeline.dll                                            | 2017.140.3381.3 | 1261464   | 10-Feb-21 | 00:02 | x64      |
| Dtspipelineperf150.dll                                     | 2017.140.3381.3 | 35744     | 10-Feb-21 | 00:03 | x86      |
| Dtspipelineperf150.dll                                     | 2017.140.3381.3 | 41376     | 10-Feb-21 | 00:02 | x64      |
| Dtuparse.dll                                               | 2017.140.3381.3 | 73112     | 10-Feb-21 | 00:03 | x86      |
| Dtuparse.dll                                               | 2017.140.3381.3 | 82312     | 10-Feb-21 | 00:02 | x64      |
| Dtutil.exe                                                 | 2017.140.3381.3 | 120704    | 10-Feb-21 | 00:03 | x86      |
| Dtutil.exe                                                 | 2017.140.3381.3 | 141720    | 10-Feb-21 | 00:02 | x64      |
| Exceldest.dll                                              | 2017.140.3381.3 | 207744    | 10-Feb-21 | 00:03 | x86      |
| Exceldest.dll                                              | 2017.140.3381.3 | 253832    | 10-Feb-21 | 00:02 | x64      |
| Excelsrc.dll                                               | 2017.140.3381.3 | 223616    | 10-Feb-21 | 00:03 | x86      |
| Excelsrc.dll                                               | 2017.140.3381.3 | 275872    | 10-Feb-21 | 00:02 | x64      |
| Flatfiledest.dll                                           | 2017.140.3381.3 | 325504    | 10-Feb-21 | 00:03 | x86      |
| Flatfiledest.dll                                           | 2017.140.3381.3 | 379800    | 10-Feb-21 | 00:02 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3381.3 | 337288    | 10-Feb-21 | 00:03 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3381.3 | 392608    | 10-Feb-21 | 00:02 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3381.3 | 73624     | 10-Feb-21 | 00:03 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3381.3 | 89496     | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3381.3     | 67464     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3381.3     | 179584    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3381.3     | 403360    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3381.3     | 403328    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3381.3     | 2086784   | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3381.3     | 2086792   | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3381.3     | 607640    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3381.3     | 607624    | 10-Feb-21 | 00:02 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3381.3     | 246176    | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3381.3     | 48008     | 10-Feb-21 | 00:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3381.3 | 135048    | 10-Feb-21 | 00:04 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3381.3 | 145288    | 10-Feb-21 | 00:02 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3381.3 | 138656    | 10-Feb-21 | 00:04 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3381.3 | 152480    | 10-Feb-21 | 00:02 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3381.3 | 83328     | 10-Feb-21 | 00:03 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3381.3 | 96136     | 10-Feb-21 | 00:02 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.70 | 7304592   | 10-Feb-21 | 00:04 | x86      |
| Oledbdest.dll                                              | 2017.140.3381.3 | 207752    | 10-Feb-21 | 00:03 | x86      |
| Oledbdest.dll                                              | 2017.140.3381.3 | 254344    | 10-Feb-21 | 00:02 | x64      |
| Oledbsrc.dll                                               | 2017.140.3381.3 | 226184    | 10-Feb-21 | 00:03 | x86      |
| Oledbsrc.dll                                               | 2017.140.3381.3 | 281992    | 10-Feb-21 | 00:02 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3381.3 | 93576     | 10-Feb-21 | 00:02 | x64      |
| Sqlresld.dll                                               | 2017.140.3381.3 | 21920     | 10-Feb-21 | 00:04 | x86      |
| Sqlresld.dll                                               | 2017.140.3381.3 | 23960     | 10-Feb-21 | 00:02 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3381.3 | 22408     | 10-Feb-21 | 00:04 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3381.3 | 25472     | 10-Feb-21 | 00:02 | x64      |
| Sqlscm.dll                                                 | 2017.140.3381.3 | 55200     | 10-Feb-21 | 00:04 | x86      |
| Sqlscm.dll                                                 | 2017.140.3381.3 | 65952     | 10-Feb-21 | 00:02 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3381.3 | 128408    | 10-Feb-21 | 00:04 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3381.3 | 156040    | 10-Feb-21 | 00:02 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3381.3 | 148384    | 10-Feb-21 | 00:04 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3381.3 | 177056    | 10-Feb-21 | 00:02 | x64      |
| Txdataconvert.dll                                          | 2017.140.3381.3 | 246168    | 10-Feb-21 | 00:04 | x86      |
| Txdataconvert.dll                                          | 2017.140.3381.3 | 286088    | 10-Feb-21 | 00:02 | x64      |
| Xe.dll                                                     | 2017.140.3381.3 | 666520    | 10-Feb-21 | 00:03 | x64      |
| Xe.dll                                                     | 2017.140.3381.3 | 588672    | 10-Feb-21 | 00:04 | x86      |
| Xmlrw.dll                                                  | 2017.140.3381.3 | 298368    | 10-Feb-21 | 00:03 | x64      |
| Xmlrw.dll                                                  | 2017.140.3381.3 | 250752    | 10-Feb-21 | 00:04 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3381.3 | 217504    | 10-Feb-21 | 00:03 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3381.3 | 182656    | 10-Feb-21 | 00:04 | x86      |

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

CU packages for Linux are available at https://packages.microsoft.com/.

> [!NOTE]
> - Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
> - SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
>- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines: </br>- Historical data shows that a significant number of support cases involve an issue that has already been addressed in a released CU. </br>- CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
> - We recommend that you test SQL Server CUs before you deploy them to production environments.

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

- [Upgrade and update of availability group servers that use minimal downtime and data loss](/sql/database-engine/availability-groups/windows/upgrading-always-on-availability-group-replica-instances)

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

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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

### Third-party information disclaimer

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.

## References

- [Announcing updates to the SQL Server Incremental Servicing Model (ISM)](/archive/blogs/sqlreleaseservices/announcing-updates-to-the-sql-server-incremental-servicing-model-ism)
- [SQL Server Service Packs are no longer supported starting from SQL Server 2017](https://support.microsoft.com/topic/fd405dee-cae7-b40f-db14-01e3e4951169)
- [Determine which version and edition of SQL Server Database Engine is running](../find-my-sql-version.md)
- [Servicing models for SQL Server](../../general/servicing-models-sql-server.md)
- [Naming schema and Fix area descriptions for SQL Server software update packages](../../database-engine/install/windows/naming-schema-and-fix-area.md)
- [Description of the standard terminology that is used to describe Microsoft software updates](../../../windows-client/deployment/standard-terminology-software-updates.md)
