---
title: Cumulative update 28 for SQL Server 2017 (KB5008084)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 28 (KB5008084).
ms.date: 08/04/2023
ms.custom: KB5008084, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5008084 - Cumulative Update 28 for SQL Server 2017

_Release Date:_ &nbsp; January 13, 2022  
_Version:_ &nbsp; 14.0.3430.2

## Summary

This article describes Cumulative Update package 28 (CU28) for Microsoft SQL Server 2017. This update contains 9 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 27, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3430.2**, file version: **2017.140.3430.2**
- Analysis Services - Product version: **14.0.249.87**, file version: **2017.140.249.87**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component| Platform |
|---------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|----------------------------------------------|----------|
| <a id=14195813>[14195813](#14195813) </a> | Fixes an issue where `sys.fn_hadr_backup_is_preferred_replica` returns different results on secondary replicas of read-scale availability groups (`CLUSTER_TYPE = NONE`) when running on standalone machines or cluster nodes | SQL Server Engine|High Availability and Disaster Recovery | Windows|
| <a id=13898015>[13898015](#13898015) </a> | Fixes the following error that occurs when you execute the `internal.cleanup_server_log` stored procedure in the SSISDB database: </br></br>#MS_SSISServerCleanupJobLogin##. A cursor with the name ‘execution_cursor’ does not exist. [SQLSTATE 34000] (Error 16916) | Integration Services | Server | Windows|
| <a id=14396480>[14396480](#14396480) </a> | Adds improvement to capture `sp_server_diagnostics` XEvent in an `AlwaysOn_health` XEvent session when **STATE** is **3** (ERROR) to diagnose HADR Health Events. | SQL Server Engine | SQL OS | Windows |
| <a id=14042373>[14042373](#14042373) </a> | Fixes an issue in which some of the temporary working folders aren't cleared when many R queries are run in parallel. | SQL Server Engine| Extensibility | Windows |
| <a id=14227334>[14227334](#14227334) </a> | Fixes an issue where the default trace on Linux rolls over before the limit size of 20 MB. | SQL Server Engine| SQL OS | Linux |
| <a id=14335023>[14335023](#14335023) </a> | Fixes the following error that occurs when you back up a database by using virtual device interface (VDI) on ubuntu docker container installed SQL Server 2017: </br></br>Host_515697bb-6009-4018-b373-50c871ed736c_SQLVDIMemoryName_0: ClientBufferAreaManager::SyncWithGlobalTable: Open(hBufferMemory): error 2Host_515697bb-6009-4018-b373-50c871ed736c_SQLVDIMemoryName_0: TriggerAbort: invoked: error 0Host_515697bb-6009-4018-b373-50c871ed736c_SQLVDIMemoryName_0: TriggerAbort: ChannelSem: error 2Features returned by SQL Server: 0x10000 </br></br>Opening the device.VDS::OpenDevice fails: x80770004Msg 18210, Level 16, State 1, Server \<ServerName>, Line \<LineNumber>BackupVirtualDeviceSet::AllocateBuffer: failure on backup device '515697bb-6009-4018-b373-50c871ed736c'. Operating system error 995(The I/O operation has been aborted because of either a thread exit or an application request.).Msg 3013, Level 16, State 1, Server \<ServerName>, Line \<LineNumber>BACKUP DATABASE is terminating abnormally. | SQL Server Engine| Linux | Linux |
| <a id=14287618>[14287618](#14287618) </a> | Fixes an issue where SQL Server disconnects a session when it gets an attention and `INTERLEAVED_EXECUTION_TVF` is enabled.|SQL Server Engine |Query Optimizer | Windows|
| <a id=14293376>[14293376](#14293376) </a> | Fixes an issue where executing concurrent queries with Large Object (LOB) parameters causes failed assertions in tmpilb.cpp and generates minidumps. |SQL Server Engine |Query Execution | Windows |
| <a id=14391931>[14391931](#14391931) </a> | Fixes an issue in which the query processor can't produce a query plan if the `USE PLAN` hint specifies a query plan that has a left outer join and an inner join. |SQL Server Engine | Query Optimizer | Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU28 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2022/01/sqlserver2017-kb5008084-x64_875be48deb01a9d496ef16fa21f9352e8ac08ed8.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5008084-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5008084-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5008084-x64.exe| A0ED9F87E16F83E9E9767A80293E5727B784E82154FCED28D4DF2936133B5976 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.87 | 259472    | 18-Dec-21 | 02:03 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.87     | 735120    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.87     | 1374096   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.87     | 977296    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.87     | 514944    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 18-Dec-21 | 02:06 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 18-Dec-21 | 01:54 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 18-Dec-21 | 01:54 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 18-Dec-21 | 01:54 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 18-Dec-21 | 01:54 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 18-Dec-21 | 01:54 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 18-Dec-21 | 01:54 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 18-Dec-21 | 01:54 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 18-Dec-21 | 01:54 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 18-Dec-21 | 01:54 | x86      |
| Msmdctr.dll                                        | 2017.140.249.87 | 33168     | 18-Dec-21 | 02:05 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.87 | 40420224  | 18-Dec-21 | 01:57 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.87 | 60766088  | 18-Dec-21 | 02:05 | x64      |
| Msmdpump.dll                                       | 2017.140.249.87 | 9333136   | 18-Dec-21 | 02:05 | x64      |
| Msmdredir.dll                                      | 2017.140.249.87 | 7088512   | 18-Dec-21 | 01:57 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.87 | 60667792  | 18-Dec-21 | 02:05 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.87 | 7305104   | 18-Dec-21 | 01:57 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.87 | 9000848   | 18-Dec-21 | 02:05 | x64      |
| Msolap.dll                                         | 2017.140.249.87 | 7772544   | 18-Dec-21 | 01:57 | x86      |
| Msolap.dll                                         | 2017.140.249.87 | 10256800  | 18-Dec-21 | 02:05 | x64      |
| Msolui.dll                                         | 2017.140.249.87 | 280456    | 18-Dec-21 | 01:57 | x86      |
| Msolui.dll                                         | 2017.140.249.87 | 304016    | 18-Dec-21 | 02:05 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 18-Dec-21 | 01:54 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 18-Dec-21 | 01:54 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlboot.dll                                        | 2017.140.3430.2 | 191928    | 18-Dec-21 | 02:05 | x64      |
| Sqlceip.exe                                        | 14.0.3430.2     | 269240    | 18-Dec-21 | 02:06 | x86      |
| Sqldumper.exe                                      | 2017.140.3430.2 | 117176    | 18-Dec-21 | 01:57 | x86      |
| Sqldumper.exe                                      | 2017.140.3430.2 | 138640    | 18-Dec-21 | 02:09 | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 18-Dec-21 | 01:54 | x86      |
| Tmapi.dll                                          | 2017.140.249.87 | 5814672   | 18-Dec-21 | 02:05 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.87 | 4157856   | 18-Dec-21 | 02:05 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.87 | 1125264   | 18-Dec-21 | 02:05 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.87 | 1636240   | 18-Dec-21 | 02:05 | x64      |
| Xe.dll                                             | 2017.140.3430.2 | 667576    | 18-Dec-21 | 02:05 | x64      |
| Xmlrw.dll                                          | 2017.140.3430.2 | 250760    | 18-Dec-21 | 01:57 | x86      |
| Xmlrw.dll                                          | 2017.140.3430.2 | 298376    | 18-Dec-21 | 02:05 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3430.2 | 182656    | 18-Dec-21 | 01:57 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3430.2 | 217488    | 18-Dec-21 | 02:05 | x64      |
| Xmsrv.dll                                          | 2017.140.249.87 | 33349536  | 18-Dec-21 | 01:57 | x86      |
| Xmsrv.dll                                          | 2017.140.249.87 | 25376160  | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time | Platform |
|--------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                            | 2017.140.3430.2  | 153488    | 18-Dec-21 | 01:57 | x86      |
| Batchparser.dll                            | 2017.140.3430.2  | 173968    | 18-Dec-21 | 02:03 | x64      |
| Instapi140.dll                             | 2017.140.3430.2  | 55696     | 18-Dec-21 | 01:57 | x86      |
| Instapi140.dll                             | 2017.140.3430.2  | 65408     | 18-Dec-21 | 02:05 | x64      |
| Isacctchange.dll                           | 2017.140.3430.2  | 22416     | 18-Dec-21 | 01:57 | x86      |
| Isacctchange.dll                           | 2017.140.3430.2  | 23952     | 18-Dec-21 | 02:04 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.87      | 1081744   | 18-Dec-21 | 01:57 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.87      | 1081744   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.87      | 1374608   | 18-Dec-21 | 01:57 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.87      | 734592    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.87      | 734624    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3430.2      | 30608     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3430.2  | 71560     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3430.2  | 75152     | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3430.2      | 564616    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3430.2      | 564616    | 18-Dec-21 | 02:04 | x86      |
| Msasxpress.dll                             | 2017.140.249.87  | 24976     | 18-Dec-21 | 01:57 | x86      |
| Msasxpress.dll                             | 2017.140.249.87  | 29072     | 18-Dec-21 | 02:05 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3430.2  | 63416     | 18-Dec-21 | 01:57 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3430.2  | 78264     | 18-Dec-21 | 02:05 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3430.2  | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqldumper.exe                              | 2017.140.3430.2  | 117176    | 18-Dec-21 | 01:57 | x86      |
| Sqldumper.exe                              | 2017.140.3430.2  | 138640    | 18-Dec-21 | 02:09 | x64      |
| Sqlftacct.dll                              | 2017.140.3430.2  | 50104     | 18-Dec-21 | 01:57 | x86      |
| Sqlftacct.dll                              | 2017.140.3430.2  | 58296     | 18-Dec-21 | 02:05 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 18-Dec-21 | 01:57 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 18-Dec-21 | 02:04 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3430.2  | 368528    | 18-Dec-21 | 01:57 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3430.2  | 414136    | 18-Dec-21 | 02:04 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3430.2  | 29112     | 18-Dec-21 | 01:57 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3430.2  | 31672     | 18-Dec-21 | 02:05 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3430.2  | 267144    | 18-Dec-21 | 01:57 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3430.2  | 351104    | 18-Dec-21 | 02:05 | x64      |
| Sqltdiagn.dll                              | 2017.140.3430.2  | 53648     | 18-Dec-21 | 01:57 | x86      |
| Sqltdiagn.dll                              | 2017.140.3430.2  | 60808     | 18-Dec-21 | 02:04 | x64      |
| Svrenumapi140.dll                          | 2017.140.3430.2  | 888192    | 18-Dec-21 | 01:57 | x86      |
| Svrenumapi140.dll                          | 2017.140.3430.2  | 1167744   | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 18-Dec-21 | 01:57 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 18-Dec-21 | 01:57 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 18-Dec-21 | 01:57 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 18-Dec-21 | 01:57 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 18-Dec-21 | 02:04 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3430.2 | 114048    | 18-Dec-21 | 01:57 | x86      |
| Dreplaycommon.dll              | 2017.140.3430.2 | 693136    | 18-Dec-21 | 01:57 | x86      |
| Dreplayserverps.dll            | 2017.140.3430.2 | 26000     | 18-Dec-21 | 01:57 | x86      |
| Dreplayutil.dll                | 2017.140.3430.2 | 304568    | 18-Dec-21 | 01:57 | x86      |
| Instapi140.dll                 | 2017.140.3430.2 | 65408     | 18-Dec-21 | 02:05 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlresourceloader.dll          | 2017.140.3430.2 | 23480     | 18-Dec-21 | 01:57 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3430.2 | 693136    | 18-Dec-21 | 01:57 | x86      |
| Dreplaycontroller.exe              | 2017.140.3430.2 | 343432    | 18-Dec-21 | 01:57 | x86      |
| Dreplayprocess.dll                 | 2017.140.3430.2 | 165816    | 18-Dec-21 | 01:57 | x86      |
| Dreplayserverps.dll                | 2017.140.3430.2 | 26000     | 18-Dec-21 | 01:57 | x86      |
| Instapi140.dll                     | 2017.140.3430.2 | 65408     | 18-Dec-21 | 02:05 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlresourceloader.dll              | 2017.140.3430.2 | 23480     | 18-Dec-21 | 01:57 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Backuptourl.exe                              | 14.0.3430.2     | 34744     | 18-Dec-21 | 02:03 | x64      |
| Batchparser.dll                              | 2017.140.3430.2 | 173968    | 18-Dec-21 | 02:03 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 18-Dec-21 | 02:08 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 18-Dec-21 | 02:08 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 18-Dec-21 | 02:08 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 18-Dec-21 | 01:53 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 18-Dec-21 | 02:03 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3430.2 | 221624    | 18-Dec-21 | 02:03 | x64      |
| Dcexec.exe                                   | 2017.140.3430.2 | 67472     | 18-Dec-21 | 02:03 | x64      |
| Fssres.dll                                   | 2017.140.3430.2 | 83856     | 18-Dec-21 | 02:05 | x64      |
| Hadrres.dll                                  | 2017.140.3430.2 | 183736    | 18-Dec-21 | 02:05 | x64      |
| Hkcompile.dll                                | 2017.140.3430.2 | 1416072   | 18-Dec-21 | 02:05 | x64      |
| Hkengine.dll                                 | 2017.140.3430.2 | 5854608   | 18-Dec-21 | 02:05 | x64      |
| Hkruntime.dll                                | 2017.140.3430.2 | 156048    | 18-Dec-21 | 02:05 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 18-Dec-21 | 02:08 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.87     | 734096    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 18-Dec-21 | 02:06 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3430.2     | 231824    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3430.2     | 73104     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3430.2 | 387000    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3430.2 | 66488     | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3430.2 | 58248     | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3430.2 | 145288    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3430.2 | 152464    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3430.2 | 297912    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3430.2 | 67976     | 18-Dec-21 | 02:04 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 18-Dec-21 | 02:08 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 18-Dec-21 | 02:08 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 18-Dec-21 | 02:08 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 18-Dec-21 | 02:08 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 18-Dec-21 | 02:08 | x64      |
| Odsole70.dll                                 | 2017.140.3430.2 | 86968     | 18-Dec-21 | 02:05 | x64      |
| Opends60.dll                                 | 2017.140.3430.2 | 26000     | 18-Dec-21 | 02:05 | x64      |
| Qds.dll                                      | 2017.140.3430.2 | 1176976   | 18-Dec-21 | 02:05 | x64      |
| Rsfxft.dll                                   | 2017.140.3430.2 | 27520     | 18-Dec-21 | 02:05 | x64      |
| Secforwarder.dll                             | 2017.140.3430.2 | 31672     | 18-Dec-21 | 02:05 | x64      |
| Sqagtres.dll                                 | 2017.140.3430.2 | 69000     | 18-Dec-21 | 02:05 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlaamss.dll                                 | 2017.140.3430.2 | 84880     | 18-Dec-21 | 02:04 | x64      |
| Sqlaccess.dll                                | 2017.140.3430.2 | 468872    | 18-Dec-21 | 02:05 | x64      |
| Sqlagent.exe                                 | 2017.140.3430.2 | 598408    | 18-Dec-21 | 02:04 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3430.2 | 48568     | 18-Dec-21 | 01:57 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3430.2 | 57272     | 18-Dec-21 | 02:04 | x64      |
| Sqlagentlog.dll                              | 2017.140.3430.2 | 26000     | 18-Dec-21 | 02:04 | x64      |
| Sqlagentmail.dll                             | 2017.140.3430.2 | 46992     | 18-Dec-21 | 02:04 | x64      |
| Sqlboot.dll                                  | 2017.140.3430.2 | 191928    | 18-Dec-21 | 02:05 | x64      |
| Sqlceip.exe                                  | 14.0.3430.2     | 269240    | 18-Dec-21 | 02:06 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3430.2 | 68536     | 18-Dec-21 | 02:04 | x64      |
| Sqlctr140.dll                                | 2017.140.3430.2 | 107448    | 18-Dec-21 | 01:57 | x86      |
| Sqlctr140.dll                                | 2017.140.3430.2 | 124856    | 18-Dec-21 | 02:05 | x64      |
| Sqldk.dll                                    | 2017.140.3430.2 | 2803600   | 18-Dec-21 | 02:04 | x64      |
| Sqldtsss.dll                                 | 2017.140.3430.2 | 102272    | 18-Dec-21 | 02:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 1500600   | 18-Dec-21 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3301816   | 18-Dec-21 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3486648   | 18-Dec-21 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3920312   | 18-Dec-21 | 01:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3296184   | 18-Dec-21 | 01:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3790776   | 18-Dec-21 | 01:52 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3826104   | 18-Dec-21 | 01:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3343800   | 18-Dec-21 | 01:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3785144   | 18-Dec-21 | 01:53 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3922872   | 18-Dec-21 | 01:54 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3601848   | 18-Dec-21 | 02:02 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 2039736   | 18-Dec-21 | 02:02 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3641272   | 18-Dec-21 | 02:03 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3792312   | 18-Dec-21 | 02:03 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 4032952   | 18-Dec-21 | 02:03 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 1447864   | 18-Dec-21 | 02:03 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3681680   | 18-Dec-21 | 02:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3372472   | 18-Dec-21 | 02:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3592592   | 18-Dec-21 | 02:07 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 2093496   | 18-Dec-21 | 02:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3406736   | 18-Dec-21 | 02:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3430.2 | 3218360   | 18-Dec-21 | 02:09 | x64      |
| Sqliosim.com                                 | 2017.140.3430.2 | 306576    | 18-Dec-21 | 02:05 | x64      |
| Sqliosim.exe                                 | 2017.140.3430.2 | 3013008   | 18-Dec-21 | 02:05 | x64      |
| Sqllang.dll                                  | 2017.140.3430.2 | 41403264  | 18-Dec-21 | 02:05 | x64      |
| Sqlmin.dll                                   | 2017.140.3430.2 | 40598456  | 18-Dec-21 | 02:05 | x64      |
| Sqlolapss.dll                                | 2017.140.3430.2 | 102280    | 18-Dec-21 | 02:04 | x64      |
| Sqlos.dll                                    | 2017.140.3430.2 | 19336     | 18-Dec-21 | 02:04 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3430.2 | 62856     | 18-Dec-21 | 02:04 | x64      |
| Sqlrepss.dll                                 | 2017.140.3430.2 | 62904     | 18-Dec-21 | 02:04 | x64      |
| Sqlresld.dll                                 | 2017.140.3430.2 | 23952     | 18-Dec-21 | 02:04 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3430.2 | 25488     | 18-Dec-21 | 02:04 | x64      |
| Sqlscm.dll                                   | 2017.140.3430.2 | 65920     | 18-Dec-21 | 02:04 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3430.2 | 21944     | 18-Dec-21 | 02:05 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3430.2 | 5890960   | 18-Dec-21 | 02:05 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3430.2 | 726968    | 18-Dec-21 | 02:04 | x64      |
| Sqlservr.exe                                 | 2017.140.3430.2 | 481680    | 18-Dec-21 | 02:05 | x64      |
| Sqlsvc.dll                                   | 2017.140.3430.2 | 157112    | 18-Dec-21 | 02:04 | x64      |
| Sqltses.dll                                  | 2017.140.3430.2 | 9559440   | 18-Dec-21 | 02:04 | x64      |
| Sqsrvres.dll                                 | 2017.140.3430.2 | 255888    | 18-Dec-21 | 02:05 | x64      |
| Svl.dll                                      | 2017.140.3430.2 | 146824    | 18-Dec-21 | 02:05 | x64      |
| Xe.dll                                       | 2017.140.3430.2 | 667576    | 18-Dec-21 | 02:05 | x64      |
| Xmlrw.dll                                    | 2017.140.3430.2 | 298376    | 18-Dec-21 | 02:05 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3430.2 | 217488    | 18-Dec-21 | 02:05 | x64      |
| Xpadsi.exe                                   | 2017.140.3430.2 | 84880     | 18-Dec-21 | 02:05 | x64      |
| Xplog70.dll                                  | 2017.140.3430.2 | 72120     | 18-Dec-21 | 02:05 | x64      |
| Xpqueue.dll                                  | 2017.140.3430.2 | 67976     | 18-Dec-21 | 02:05 | x64      |
| Xprepl.dll                                   | 2017.140.3430.2 | 96656     | 18-Dec-21 | 02:05 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3430.2 | 25472     | 18-Dec-21 | 02:05 | x64      |
| Xpstar.dll                                   | 2017.140.3430.2 | 445312    | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3430.2 | 153488    | 18-Dec-21 | 01:57 | x86      |
| Batchparser.dll                                             | 2017.140.3430.2 | 173968    | 18-Dec-21 | 02:03 | x64      |
| Bcp.exe                                                     | 2017.140.3430.2 | 113032    | 18-Dec-21 | 02:05 | x64      |
| Commanddest.dll                                             | 2017.140.3430.2 | 238992    | 18-Dec-21 | 02:03 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3430.2 | 110520    | 18-Dec-21 | 02:03 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3430.2 | 180616    | 18-Dec-21 | 02:03 | x64      |
| Distrib.exe                                                 | 2017.140.3430.2 | 198024    | 18-Dec-21 | 02:05 | x64      |
| Dteparse.dll                                                | 2017.140.3430.2 | 104336    | 18-Dec-21 | 02:03 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3430.2 | 82320     | 18-Dec-21 | 02:03 | x64      |
| Dtepkg.dll                                                  | 2017.140.3430.2 | 130952    | 18-Dec-21 | 02:03 | x64      |
| Dtexec.exe                                                  | 2017.140.3430.2 | 66960     | 18-Dec-21 | 02:03 | x64      |
| Dts.dll                                                     | 2017.140.3430.2 | 2994048   | 18-Dec-21 | 02:03 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3430.2 | 469432    | 18-Dec-21 | 02:03 | x64      |
| Dtsconn.dll                                                 | 2017.140.3430.2 | 493456    | 18-Dec-21 | 02:03 | x64      |
| Dtshost.exe                                                 | 2017.140.3430.2 | 99208     | 18-Dec-21 | 02:05 | x64      |
| Dtslog.dll                                                  | 2017.140.3430.2 | 113536    | 18-Dec-21 | 02:03 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3430.2 | 538504    | 18-Dec-21 | 02:05 | x64      |
| Dtspipeline.dll                                             | 2017.140.3430.2 | 1262520   | 18-Dec-21 | 02:03 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3430.2 | 41360     | 18-Dec-21 | 02:03 | x64      |
| Dtuparse.dll                                                | 2017.140.3430.2 | 82304     | 18-Dec-21 | 02:03 | x64      |
| Dtutil.exe                                                  | 2017.140.3430.2 | 142776    | 18-Dec-21 | 02:03 | x64      |
| Exceldest.dll                                               | 2017.140.3430.2 | 253840    | 18-Dec-21 | 02:03 | x64      |
| Excelsrc.dll                                                | 2017.140.3430.2 | 275856    | 18-Dec-21 | 02:03 | x64      |
| Execpackagetask.dll                                         | 2017.140.3430.2 | 161168    | 18-Dec-21 | 02:03 | x64      |
| Flatfiledest.dll                                            | 2017.140.3430.2 | 379792    | 18-Dec-21 | 02:03 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3430.2 | 392592    | 18-Dec-21 | 02:04 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3430.2 | 89480     | 18-Dec-21 | 02:03 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3430.2 | 53688     | 18-Dec-21 | 02:05 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 18-Dec-21 | 01:52 | x86      |
| Logread.exe                                                 | 2017.140.3430.2 | 629648    | 18-Dec-21 | 02:05 | x64      |
| Mergetxt.dll                                                | 2017.140.3430.2 | 58256     | 18-Dec-21 | 02:05 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.87     | 1375120   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 18-Dec-21 | 01:52 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3430.2     | 130960    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3430.2     | 48528     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3430.2     | 82832     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3430.2     | 66448     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3430.2     | 385416    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3430.2     | 607616    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3430.2 | 1657744   | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3430.2     | 564616    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3430.2 | 145288    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3430.2 | 152464    | 18-Dec-21 | 02:04 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3430.2 | 96128     | 18-Dec-21 | 02:04 | x64      |
| Msgprox.dll                                                 | 2017.140.3430.2 | 265096    | 18-Dec-21 | 02:05 | x64      |
| Msxmlsql.dll                                                | 2017.140.3430.2 | 1441168   | 18-Dec-21 | 02:05 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 18-Dec-21 | 01:52 | x86      |
| Oledbdest.dll                                               | 2017.140.3430.2 | 254344    | 18-Dec-21 | 02:04 | x64      |
| Oledbsrc.dll                                                | 2017.140.3430.2 | 283064    | 18-Dec-21 | 02:04 | x64      |
| Osql.exe                                                    | 2017.140.3430.2 | 68480     | 18-Dec-21 | 02:04 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3430.2 | 469944    | 18-Dec-21 | 02:05 | x64      |
| Rawdest.dll                                                 | 2017.140.3430.2 | 199568    | 18-Dec-21 | 02:05 | x64      |
| Rawsource.dll                                               | 2017.140.3430.2 | 187280    | 18-Dec-21 | 02:05 | x64      |
| Rdistcom.dll                                                | 2017.140.3430.2 | 853432    | 18-Dec-21 | 02:05 | x64      |
| Recordsetdest.dll                                           | 2017.140.3430.2 | 177552    | 18-Dec-21 | 02:05 | x64      |
| Replagnt.dll                                                | 2017.140.3430.2 | 23952     | 18-Dec-21 | 02:05 | x64      |
| Repldp.dll                                                  | 2017.140.3430.2 | 285584    | 18-Dec-21 | 02:05 | x64      |
| Replerrx.dll                                                | 2017.140.3430.2 | 148864    | 18-Dec-21 | 02:05 | x64      |
| Replisapi.dll                                               | 2017.140.3430.2 | 358328    | 18-Dec-21 | 02:05 | x64      |
| Replmerg.exe                                                | 2017.140.3430.2 | 520072    | 18-Dec-21 | 02:05 | x64      |
| Replprov.dll                                                | 2017.140.3430.2 | 798136    | 18-Dec-21 | 02:05 | x64      |
| Replrec.dll                                                 | 2017.140.3430.2 | 973752    | 18-Dec-21 | 02:05 | x64      |
| Replsub.dll                                                 | 2017.140.3430.2 | 441272    | 18-Dec-21 | 02:05 | x64      |
| Replsync.dll                                                | 2017.140.3430.2 | 148368    | 18-Dec-21 | 02:05 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 18-Dec-21 | 02:05 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 18-Dec-21 | 02:05 | x64      |
| Spresolv.dll                                                | 2017.140.3430.2 | 247168    | 18-Dec-21 | 02:05 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3430.2 | 243128    | 18-Dec-21 | 02:05 | x64      |
| Sqldiag.exe                                                 | 2017.140.3430.2 | 1254792   | 18-Dec-21 | 02:05 | x64      |
| Sqldistx.dll                                                | 2017.140.3430.2 | 219520    | 18-Dec-21 | 02:05 | x64      |
| Sqllogship.exe                                              | 14.0.3430.2     | 100280    | 18-Dec-21 | 02:04 | x64      |
| Sqlmergx.dll                                                | 2017.140.3430.2 | 356280    | 18-Dec-21 | 02:05 | x64      |
| Sqlresld.dll                                                | 2017.140.3430.2 | 21888     | 18-Dec-21 | 01:57 | x86      |
| Sqlresld.dll                                                | 2017.140.3430.2 | 23952     | 18-Dec-21 | 02:04 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3430.2 | 23480     | 18-Dec-21 | 01:57 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3430.2 | 25488     | 18-Dec-21 | 02:04 | x64      |
| Sqlscm.dll                                                  | 2017.140.3430.2 | 56248     | 18-Dec-21 | 01:57 | x86      |
| Sqlscm.dll                                                  | 2017.140.3430.2 | 65920     | 18-Dec-21 | 02:04 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3430.2 | 129464    | 18-Dec-21 | 01:57 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3430.2 | 157112    | 18-Dec-21 | 02:04 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3430.2 | 177040    | 18-Dec-21 | 02:04 | x64      |
| Sqlwep140.dll                                               | 2017.140.3430.2 | 98704     | 18-Dec-21 | 02:05 | x64      |
| Ssdebugps.dll                                               | 2017.140.3430.2 | 27576     | 18-Dec-21 | 02:05 | x64      |
| Ssisoledb.dll                                               | 2017.140.3430.2 | 209296    | 18-Dec-21 | 02:04 | x64      |
| Ssradd.dll                                                  | 2017.140.3430.2 | 70032     | 18-Dec-21 | 02:05 | x64      |
| Ssravg.dll                                                  | 2017.140.3430.2 | 70544     | 18-Dec-21 | 02:05 | x64      |
| Ssrdown.dll                                                 | 2017.140.3430.2 | 55184     | 18-Dec-21 | 02:05 | x64      |
| Ssrmax.dll                                                  | 2017.140.3430.2 | 68496     | 18-Dec-21 | 02:05 | x64      |
| Ssrmin.dll                                                  | 2017.140.3430.2 | 68496     | 18-Dec-21 | 02:05 | x64      |
| Ssrpub.dll                                                  | 2017.140.3430.2 | 55680     | 18-Dec-21 | 02:05 | x64      |
| Ssrup.dll                                                   | 2017.140.3430.2 | 55184     | 18-Dec-21 | 02:05 | x64      |
| Tablediff.exe                                               | 14.0.3430.2     | 79760     | 18-Dec-21 | 02:05 | x64      |
| Txagg.dll                                                   | 2017.140.3430.2 | 355216    | 18-Dec-21 | 02:05 | x64      |
| Txbdd.dll                                                   | 2017.140.3430.2 | 163208    | 18-Dec-21 | 02:05 | x64      |
| Txdatacollector.dll                                         | 2017.140.3430.2 | 353680    | 18-Dec-21 | 02:05 | x64      |
| Txdataconvert.dll                                           | 2017.140.3430.2 | 286096    | 18-Dec-21 | 02:05 | x64      |
| Txderived.dll                                               | 2017.140.3430.2 | 597376    | 18-Dec-21 | 02:05 | x64      |
| Txlookup.dll                                                | 2017.140.3430.2 | 521088    | 18-Dec-21 | 02:05 | x64      |
| Txmerge.dll                                                 | 2017.140.3430.2 | 223120    | 18-Dec-21 | 02:05 | x64      |
| Txmergejoin.dll                                             | 2017.140.3430.2 | 268672    | 18-Dec-21 | 02:05 | x64      |
| Txmulticast.dll                                             | 2017.140.3430.2 | 120712    | 18-Dec-21 | 02:05 | x64      |
| Txrowcount.dll                                              | 2017.140.3430.2 | 118672    | 18-Dec-21 | 02:05 | x64      |
| Txsort.dll                                                  | 2017.140.3430.2 | 249744    | 18-Dec-21 | 02:05 | x64      |
| Txsplit.dll                                                 | 2017.140.3430.2 | 589712    | 18-Dec-21 | 02:05 | x64      |
| Txunionall.dll                                              | 2017.140.3430.2 | 174984    | 18-Dec-21 | 02:05 | x64      |
| Xe.dll                                                      | 2017.140.3430.2 | 667576    | 18-Dec-21 | 02:05 | x64      |
| Xmlrw.dll                                                   | 2017.140.3430.2 | 298376    | 18-Dec-21 | 02:05 | x64      |
| Xmlsub.dll                                                  | 2017.140.3430.2 | 255368    | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3430.2 | 1127864   | 18-Dec-21 | 02:05 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlsatellite.dll              | 2017.140.3430.2 | 916880    | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3430.2 | 665488    | 18-Dec-21 | 02:05 | x64      |
| Fdhost.exe               | 2017.140.3430.2 | 109456    | 18-Dec-21 | 02:05 | x64      |
| Fdlauncher.exe           | 2017.140.3430.2 | 57232     | 18-Dec-21 | 02:05 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 18-Dec-21 | 02:04 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlft140ph.dll           | 2017.140.3430.2 | 62856     | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3430.2     | 17288     | 18-Dec-21 | 02:04 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 18-Dec-21 | 01:57 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 18-Dec-21 | 02:03 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 18-Dec-21 | 01:57 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 18-Dec-21 | 02:03 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 18-Dec-21 | 01:57 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 18-Dec-21 | 02:03 | x86      |
| Commanddest.dll                                               | 2017.140.3430.2 | 193920    | 18-Dec-21 | 01:57 | x86      |
| Commanddest.dll                                               | 2017.140.3430.2 | 238992    | 18-Dec-21 | 02:03 | x64      |
| Dteparse.dll                                                  | 2017.140.3430.2 | 94096     | 18-Dec-21 | 01:57 | x86      |
| Dteparse.dll                                                  | 2017.140.3430.2 | 104336    | 18-Dec-21 | 02:03 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3430.2 | 76688     | 18-Dec-21 | 01:57 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3430.2 | 82320     | 18-Dec-21 | 02:03 | x64      |
| Dtepkg.dll                                                    | 2017.140.3430.2 | 109968    | 18-Dec-21 | 01:57 | x86      |
| Dtepkg.dll                                                    | 2017.140.3430.2 | 130952    | 18-Dec-21 | 02:03 | x64      |
| Dtexec.exe                                                    | 2017.140.3430.2 | 61328     | 18-Dec-21 | 01:57 | x86      |
| Dtexec.exe                                                    | 2017.140.3430.2 | 66960     | 18-Dec-21 | 02:03 | x64      |
| Dts.dll                                                       | 2017.140.3430.2 | 2544000   | 18-Dec-21 | 01:57 | x86      |
| Dts.dll                                                       | 2017.140.3430.2 | 2994048   | 18-Dec-21 | 02:03 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3430.2 | 412088    | 18-Dec-21 | 01:57 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3430.2 | 469432    | 18-Dec-21 | 02:03 | x64      |
| Dtsconn.dll                                                   | 2017.140.3430.2 | 395664    | 18-Dec-21 | 01:57 | x86      |
| Dtsconn.dll                                                   | 2017.140.3430.2 | 493456    | 18-Dec-21 | 02:03 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3430.2 | 89528     | 18-Dec-21 | 01:57 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3430.2 | 104320    | 18-Dec-21 | 02:03 | x64      |
| Dtshost.exe                                                   | 2017.140.3430.2 | 84368     | 18-Dec-21 | 01:57 | x86      |
| Dtshost.exe                                                   | 2017.140.3430.2 | 99208     | 18-Dec-21 | 02:05 | x64      |
| Dtslog.dll                                                    | 2017.140.3430.2 | 96136     | 18-Dec-21 | 01:57 | x86      |
| Dtslog.dll                                                    | 2017.140.3430.2 | 113536    | 18-Dec-21 | 02:03 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3430.2 | 534400    | 18-Dec-21 | 01:57 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3430.2 | 538504    | 18-Dec-21 | 02:05 | x64      |
| Dtspipeline.dll                                               | 2017.140.3430.2 | 1053584   | 18-Dec-21 | 01:57 | x86      |
| Dtspipeline.dll                                               | 2017.140.3430.2 | 1262520   | 18-Dec-21 | 02:03 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3430.2 | 36792     | 18-Dec-21 | 01:57 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3430.2 | 41360     | 18-Dec-21 | 02:03 | x64      |
| Dtuparse.dll                                                  | 2017.140.3430.2 | 73608     | 18-Dec-21 | 01:57 | x86      |
| Dtuparse.dll                                                  | 2017.140.3430.2 | 82304     | 18-Dec-21 | 02:03 | x64      |
| Dtutil.exe                                                    | 2017.140.3430.2 | 121784    | 18-Dec-21 | 01:57 | x86      |
| Dtutil.exe                                                    | 2017.140.3430.2 | 142776    | 18-Dec-21 | 02:03 | x64      |
| Exceldest.dll                                                 | 2017.140.3430.2 | 208824    | 18-Dec-21 | 01:57 | x86      |
| Exceldest.dll                                                 | 2017.140.3430.2 | 253840    | 18-Dec-21 | 02:03 | x64      |
| Excelsrc.dll                                                  | 2017.140.3430.2 | 223632    | 18-Dec-21 | 01:57 | x86      |
| Excelsrc.dll                                                  | 2017.140.3430.2 | 275856    | 18-Dec-21 | 02:03 | x64      |
| Execpackagetask.dll                                           | 2017.140.3430.2 | 129464    | 18-Dec-21 | 01:57 | x86      |
| Execpackagetask.dll                                           | 2017.140.3430.2 | 161168    | 18-Dec-21 | 02:03 | x64      |
| Flatfiledest.dll                                              | 2017.140.3430.2 | 326584    | 18-Dec-21 | 01:57 | x86      |
| Flatfiledest.dll                                              | 2017.140.3430.2 | 379792    | 18-Dec-21 | 02:03 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3430.2 | 337280    | 18-Dec-21 | 01:57 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3430.2 | 392592    | 18-Dec-21 | 02:04 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3430.2 | 73608     | 18-Dec-21 | 01:57 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3430.2 | 89480     | 18-Dec-21 | 02:03 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 18-Dec-21 | 01:52 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 18-Dec-21 | 02:09 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3430.2     | 460176    | 18-Dec-21 | 01:57 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3430.2     | 459656    | 18-Dec-21 | 02:04 | x64      |
| Isserverexec.exe                                              | 14.0.3430.2     | 142224    | 18-Dec-21 | 01:57 | x86      |
| Isserverexec.exe                                              | 14.0.3430.2     | 141704    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.87     | 1375104   | 18-Dec-21 | 01:57 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.87     | 1375120   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 18-Dec-21 | 02:06 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 18-Dec-21 | 01:52 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 18-Dec-21 | 02:09 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3430.2     | 105344    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3430.2 | 101304    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3430.2 | 106424    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3430.2     | 48528     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3430.2     | 48528     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3430.2     | 82824     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3430.2     | 82832     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3430.2     | 66448     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3430.2     | 66448     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3430.2     | 507792    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3430.2     | 508856    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3430.2     | 76680     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3430.2     | 77752     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3430.2     | 408968    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3430.2     | 408968    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3430.2     | 385416    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3430.2     | 607624    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3430.2     | 607616    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3430.2     | 247224    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3430.2     | 246160    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3430.2     | 48016     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3430.2     | 48016     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3430.2 | 135056    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3430.2 | 145288    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3430.2 | 138640    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3430.2 | 152464    | 18-Dec-21 | 02:04 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3430.2     | 212872    | 18-Dec-21 | 02:04 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3430.2 | 83328     | 18-Dec-21 | 01:57 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3430.2 | 96128     | 18-Dec-21 | 02:04 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.87 | 9192832   | 18-Dec-21 | 02:05 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 18-Dec-21 | 01:52 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 18-Dec-21 | 02:04 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 18-Dec-21 | 02:07 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 18-Dec-21 | 02:09 | x86      |
| Oledbdest.dll                                                 | 2017.140.3430.2 | 207752    | 18-Dec-21 | 01:57 | x86      |
| Oledbdest.dll                                                 | 2017.140.3430.2 | 254344    | 18-Dec-21 | 02:04 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3430.2 | 227256    | 18-Dec-21 | 01:57 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3430.2 | 283064    | 18-Dec-21 | 02:04 | x64      |
| Rawdest.dll                                                   | 2017.140.3430.2 | 160696    | 18-Dec-21 | 01:57 | x86      |
| Rawdest.dll                                                   | 2017.140.3430.2 | 199568    | 18-Dec-21 | 02:05 | x64      |
| Rawsource.dll                                                 | 2017.140.3430.2 | 146312    | 18-Dec-21 | 01:57 | x86      |
| Rawsource.dll                                                 | 2017.140.3430.2 | 187280    | 18-Dec-21 | 02:05 | x64      |
| Recordsetdest.dll                                             | 2017.140.3430.2 | 145296    | 18-Dec-21 | 01:57 | x86      |
| Recordsetdest.dll                                             | 2017.140.3430.2 | 177552    | 18-Dec-21 | 02:05 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlceip.exe                                                   | 14.0.3430.2     | 269240    | 18-Dec-21 | 02:06 | x86      |
| Sqldest.dll                                                   | 2017.140.3430.2 | 210320    | 18-Dec-21 | 01:57 | x86      |
| Sqldest.dll                                                   | 2017.140.3430.2 | 254904    | 18-Dec-21 | 02:04 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3430.2 | 145296    | 18-Dec-21 | 01:57 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3430.2 | 177040    | 18-Dec-21 | 02:04 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3430.2 | 170936    | 18-Dec-21 | 01:57 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3430.2 | 209296    | 18-Dec-21 | 02:04 | x64      |
| Txagg.dll                                                     | 2017.140.3430.2 | 296376    | 18-Dec-21 | 01:57 | x86      |
| Txagg.dll                                                     | 2017.140.3430.2 | 355216    | 18-Dec-21 | 02:05 | x64      |
| Txbdd.dll                                                     | 2017.140.3430.2 | 133560    | 18-Dec-21 | 01:57 | x86      |
| Txbdd.dll                                                     | 2017.140.3430.2 | 163208    | 18-Dec-21 | 02:05 | x64      |
| Txbestmatch.dll                                               | 2017.140.3430.2 | 486288    | 18-Dec-21 | 01:57 | x86      |
| Txbestmatch.dll                                               | 2017.140.3430.2 | 598416    | 18-Dec-21 | 02:05 | x64      |
| Txcache.dll                                                   | 2017.140.3430.2 | 142224    | 18-Dec-21 | 01:57 | x86      |
| Txcache.dll                                                   | 2017.140.3430.2 | 173456    | 18-Dec-21 | 02:05 | x64      |
| Txcharmap.dll                                                 | 2017.140.3430.2 | 242056    | 18-Dec-21 | 01:57 | x86      |
| Txcharmap.dll                                                 | 2017.140.3430.2 | 279952    | 18-Dec-21 | 02:05 | x64      |
| Txcopymap.dll                                                 | 2017.140.3430.2 | 141200    | 18-Dec-21 | 01:57 | x86      |
| Txcopymap.dll                                                 | 2017.140.3430.2 | 173456    | 18-Dec-21 | 02:05 | x64      |
| Txdataconvert.dll                                             | 2017.140.3430.2 | 249232    | 18-Dec-21 | 01:57 | x86      |
| Txdataconvert.dll                                             | 2017.140.3430.2 | 286096    | 18-Dec-21 | 02:05 | x64      |
| Txderived.dll                                                 | 2017.140.3430.2 | 508816    | 18-Dec-21 | 01:57 | x86      |
| Txderived.dll                                                 | 2017.140.3430.2 | 597376    | 18-Dec-21 | 02:05 | x64      |
| Txfileextractor.dll                                           | 2017.140.3430.2 | 156560    | 18-Dec-21 | 01:57 | x86      |
| Txfileextractor.dll                                           | 2017.140.3430.2 | 191880    | 18-Dec-21 | 02:05 | x64      |
| Txfileinserter.dll                                            | 2017.140.3430.2 | 155024    | 18-Dec-21 | 01:57 | x86      |
| Txfileinserter.dll                                            | 2017.140.3430.2 | 189840    | 18-Dec-21 | 02:05 | x64      |
| Txgroupdups.dll                                               | 2017.140.3430.2 | 224136    | 18-Dec-21 | 01:57 | x86      |
| Txgroupdups.dll                                               | 2017.140.3430.2 | 283536    | 18-Dec-21 | 02:05 | x64      |
| Txlineage.dll                                                 | 2017.140.3430.2 | 103312    | 18-Dec-21 | 01:57 | x86      |
| Txlineage.dll                                                 | 2017.140.3430.2 | 129928    | 18-Dec-21 | 02:05 | x64      |
| Txlookup.dll                                                  | 2017.140.3430.2 | 439696    | 18-Dec-21 | 01:57 | x86      |
| Txlookup.dll                                                  | 2017.140.3430.2 | 521088    | 18-Dec-21 | 02:05 | x64      |
| Txmerge.dll                                                   | 2017.140.3430.2 | 170896    | 18-Dec-21 | 01:57 | x86      |
| Txmerge.dll                                                   | 2017.140.3430.2 | 223120    | 18-Dec-21 | 02:05 | x64      |
| Txmergejoin.dll                                               | 2017.140.3430.2 | 218552    | 18-Dec-21 | 01:57 | x86      |
| Txmergejoin.dll                                               | 2017.140.3430.2 | 268672    | 18-Dec-21 | 02:05 | x64      |
| Txmulticast.dll                                               | 2017.140.3430.2 | 96144     | 18-Dec-21 | 01:57 | x86      |
| Txmulticast.dll                                               | 2017.140.3430.2 | 120712    | 18-Dec-21 | 02:05 | x64      |
| Txpivot.dll                                                   | 2017.140.3430.2 | 176016    | 18-Dec-21 | 01:57 | x86      |
| Txpivot.dll                                                   | 2017.140.3430.2 | 218000    | 18-Dec-21 | 02:05 | x64      |
| Txrowcount.dll                                                | 2017.140.3430.2 | 95120     | 18-Dec-21 | 01:57 | x86      |
| Txrowcount.dll                                                | 2017.140.3430.2 | 118672    | 18-Dec-21 | 02:05 | x64      |
| Txsampling.dll                                                | 2017.140.3430.2 | 128912    | 18-Dec-21 | 01:57 | x86      |
| Txsampling.dll                                                | 2017.140.3430.2 | 165776    | 18-Dec-21 | 02:05 | x64      |
| Txscd.dll                                                     | 2017.140.3430.2 | 163200    | 18-Dec-21 | 01:57 | x86      |
| Txscd.dll                                                     | 2017.140.3430.2 | 213904    | 18-Dec-21 | 02:05 | x64      |
| Txsort.dll                                                    | 2017.140.3430.2 | 205240    | 18-Dec-21 | 01:57 | x86      |
| Txsort.dll                                                    | 2017.140.3430.2 | 249744    | 18-Dec-21 | 02:05 | x64      |
| Txsplit.dll                                                   | 2017.140.3430.2 | 504760    | 18-Dec-21 | 01:57 | x86      |
| Txsplit.dll                                                   | 2017.140.3430.2 | 589712    | 18-Dec-21 | 02:05 | x64      |
| Txtermextraction.dll                                          | 2017.140.3430.2 | 8608144   | 18-Dec-21 | 01:57 | x86      |
| Txtermextraction.dll                                          | 2017.140.3430.2 | 8669568   | 18-Dec-21 | 02:05 | x64      |
| Txtermlookup.dll                                              | 2017.140.3430.2 | 4099984   | 18-Dec-21 | 01:57 | x86      |
| Txtermlookup.dll                                              | 2017.140.3430.2 | 4150160   | 18-Dec-21 | 02:05 | x64      |
| Txunionall.dll                                                | 2017.140.3430.2 | 133008    | 18-Dec-21 | 01:57 | x86      |
| Txunionall.dll                                                | 2017.140.3430.2 | 174984    | 18-Dec-21 | 02:05 | x64      |
| Txunpivot.dll                                                 | 2017.140.3430.2 | 157624    | 18-Dec-21 | 01:57 | x86      |
| Txunpivot.dll                                                 | 2017.140.3430.2 | 192896    | 18-Dec-21 | 02:05 | x64      |
| Xe.dll                                                        | 2017.140.3430.2 | 588672    | 18-Dec-21 | 01:57 | x86      |
| Xe.dll                                                        | 2017.140.3430.2 | 667576    | 18-Dec-21 | 02:05 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 18-Dec-21 | 02:04 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 18-Dec-21 | 02:04 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 18-Dec-21 | 02:04 | x86      |
| Instapi140.dll                                                       | 2017.140.3430.2  | 65408     | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 18-Dec-21 | 02:06 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 18-Dec-21 | 02:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 18-Dec-21 | 02:07 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 18-Dec-21 | 02:03 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 18-Dec-21 | 02:02 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 18-Dec-21 | 02:06 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 18-Dec-21 | 02:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 18-Dec-21 | 02:07 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 18-Dec-21 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 18-Dec-21 | 01:52 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 18-Dec-21 | 02:03 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 18-Dec-21 | 02:02 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 18-Dec-21 | 02:04 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3430.2  | 400272    | 18-Dec-21 | 02:04 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3430.2  | 7324048   | 18-Dec-21 | 02:04 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3430.2  | 2258320   | 18-Dec-21 | 02:04 | x64      |
| Secforwarder.dll                                                     | 2017.140.3430.2  | 31672     | 18-Dec-21 | 02:04 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 18-Dec-21 | 02:04 | x64      |
| Sqldk.dll                                                            | 2017.140.3430.2  | 2736568   | 18-Dec-21 | 02:04 | x64      |
| Sqldumper.exe                                                        | 2017.140.3430.2  | 138640    | 18-Dec-21 | 02:04 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 1500600   | 18-Dec-21 | 01:51 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3920312   | 18-Dec-21 | 01:52 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3218360   | 18-Dec-21 | 02:09 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3922872   | 18-Dec-21 | 01:54 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3826104   | 18-Dec-21 | 01:53 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 2093496   | 18-Dec-21 | 02:08 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 2039736   | 18-Dec-21 | 02:02 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3592592   | 18-Dec-21 | 02:07 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3601848   | 18-Dec-21 | 02:02 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 1447864   | 18-Dec-21 | 02:03 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3430.2  | 3790776   | 18-Dec-21 | 01:52 | x64      |
| Sqlos.dll                                                            | 2017.140.3430.2  | 19336     | 18-Dec-21 | 02:04 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 18-Dec-21 | 02:04 | x64      |
| Sqltses.dll                                                          | 2017.140.3430.2  | 9730488   | 18-Dec-21 | 02:04 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3430.2     | 17296     | 18-Dec-21 | 02:04 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                              | 2017.140.3430.2 | 1441672   | 18-Dec-21 | 01:57 | x86      |
| Dtaengine.exe                                              | 2017.140.3430.2 | 198584    | 18-Dec-21 | 01:57 | x86      |
| Dteparse.dll                                               | 2017.140.3430.2 | 94096     | 18-Dec-21 | 01:57 | x86      |
| Dteparse.dll                                               | 2017.140.3430.2 | 104336    | 18-Dec-21 | 02:03 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3430.2 | 76688     | 18-Dec-21 | 01:57 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3430.2 | 82320     | 18-Dec-21 | 02:03 | x64      |
| Dtepkg.dll                                                 | 2017.140.3430.2 | 109968    | 18-Dec-21 | 01:57 | x86      |
| Dtepkg.dll                                                 | 2017.140.3430.2 | 130952    | 18-Dec-21 | 02:03 | x64      |
| Dtexec.exe                                                 | 2017.140.3430.2 | 61328     | 18-Dec-21 | 01:57 | x86      |
| Dtexec.exe                                                 | 2017.140.3430.2 | 66960     | 18-Dec-21 | 02:03 | x64      |
| Dts.dll                                                    | 2017.140.3430.2 | 2544000   | 18-Dec-21 | 01:57 | x86      |
| Dts.dll                                                    | 2017.140.3430.2 | 2994048   | 18-Dec-21 | 02:03 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3430.2 | 412088    | 18-Dec-21 | 01:57 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3430.2 | 469432    | 18-Dec-21 | 02:03 | x64      |
| Dtsconn.dll                                                | 2017.140.3430.2 | 395664    | 18-Dec-21 | 01:57 | x86      |
| Dtsconn.dll                                                | 2017.140.3430.2 | 493456    | 18-Dec-21 | 02:03 | x64      |
| Dtshost.exe                                                | 2017.140.3430.2 | 84368     | 18-Dec-21 | 01:57 | x86      |
| Dtshost.exe                                                | 2017.140.3430.2 | 99208     | 18-Dec-21 | 02:05 | x64      |
| Dtslog.dll                                                 | 2017.140.3430.2 | 96136     | 18-Dec-21 | 01:57 | x86      |
| Dtslog.dll                                                 | 2017.140.3430.2 | 113536    | 18-Dec-21 | 02:03 | x64      |
| Dtsmsg140.dll                                              | 2017.140.3430.2 | 534400    | 18-Dec-21 | 01:57 | x86      |
| Dtsmsg140.dll                                              | 2017.140.3430.2 | 538504    | 18-Dec-21 | 02:05 | x64      |
| Dtspipeline.dll                                            | 2017.140.3430.2 | 1053584   | 18-Dec-21 | 01:57 | x86      |
| Dtspipeline.dll                                            | 2017.140.3430.2 | 1262520   | 18-Dec-21 | 02:03 | x64      |
| Dtspipelineperf140.dll                                     | 2017.140.3430.2 | 36792     | 18-Dec-21 | 01:57 | x86      |
| Dtspipelineperf140.dll                                     | 2017.140.3430.2 | 41360     | 18-Dec-21 | 02:03 | x64      |
| Dtuparse.dll                                               | 2017.140.3430.2 | 73608     | 18-Dec-21 | 01:57 | x86      |
| Dtuparse.dll                                               | 2017.140.3430.2 | 82304     | 18-Dec-21 | 02:03 | x64      |
| Dtutil.exe                                                 | 2017.140.3430.2 | 121784    | 18-Dec-21 | 01:57 | x86      |
| Dtutil.exe                                                 | 2017.140.3430.2 | 142776    | 18-Dec-21 | 02:03 | x64      |
| Exceldest.dll                                              | 2017.140.3430.2 | 208824    | 18-Dec-21 | 01:57 | x86      |
| Exceldest.dll                                              | 2017.140.3430.2 | 253840    | 18-Dec-21 | 02:03 | x64      |
| Excelsrc.dll                                               | 2017.140.3430.2 | 223632    | 18-Dec-21 | 01:57 | x86      |
| Excelsrc.dll                                               | 2017.140.3430.2 | 275856    | 18-Dec-21 | 02:03 | x64      |
| Flatfiledest.dll                                           | 2017.140.3430.2 | 326584    | 18-Dec-21 | 01:57 | x86      |
| Flatfiledest.dll                                           | 2017.140.3430.2 | 379792    | 18-Dec-21 | 02:03 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3430.2 | 337280    | 18-Dec-21 | 01:57 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3430.2 | 392592    | 18-Dec-21 | 02:04 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3430.2 | 73608     | 18-Dec-21 | 01:57 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3430.2 | 89480     | 18-Dec-21 | 02:03 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3430.2     | 106424    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3430.2     | 179592    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3430.2     | 404408    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3430.2     | 403336    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3430.2     | 2086800   | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3430.2     | 2087864   | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3430.2     | 607624    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3430.2     | 607616    | 18-Dec-21 | 02:04 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3430.2     | 247224    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3430.2     | 48016     | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3430.2 | 135056    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3430.2 | 145288    | 18-Dec-21 | 02:04 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3430.2 | 138640    | 18-Dec-21 | 01:57 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3430.2 | 152464    | 18-Dec-21 | 02:04 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3430.2 | 83328     | 18-Dec-21 | 01:57 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3430.2 | 96128     | 18-Dec-21 | 02:04 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.87 | 7305104   | 18-Dec-21 | 01:57 | x86      |
| Oledbdest.dll                                              | 2017.140.3430.2 | 207752    | 18-Dec-21 | 01:57 | x86      |
| Oledbdest.dll                                              | 2017.140.3430.2 | 254344    | 18-Dec-21 | 02:04 | x64      |
| Oledbsrc.dll                                               | 2017.140.3430.2 | 227256    | 18-Dec-21 | 01:57 | x86      |
| Oledbsrc.dll                                               | 2017.140.3430.2 | 283064    | 18-Dec-21 | 02:04 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3430.2 | 93584     | 18-Dec-21 | 02:04 | x64      |
| Sqlresld.dll                                               | 2017.140.3430.2 | 21888     | 18-Dec-21 | 01:57 | x86      |
| Sqlresld.dll                                               | 2017.140.3430.2 | 23952     | 18-Dec-21 | 02:04 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3430.2 | 23480     | 18-Dec-21 | 01:57 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3430.2 | 25488     | 18-Dec-21 | 02:04 | x64      |
| Sqlscm.dll                                                 | 2017.140.3430.2 | 56248     | 18-Dec-21 | 01:57 | x86      |
| Sqlscm.dll                                                 | 2017.140.3430.2 | 65920     | 18-Dec-21 | 02:04 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3430.2 | 129464    | 18-Dec-21 | 01:57 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3430.2 | 157112    | 18-Dec-21 | 02:04 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3430.2 | 145296    | 18-Dec-21 | 01:57 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3430.2 | 177040    | 18-Dec-21 | 02:04 | x64      |
| Txdataconvert.dll                                          | 2017.140.3430.2 | 249232    | 18-Dec-21 | 01:57 | x86      |
| Txdataconvert.dll                                          | 2017.140.3430.2 | 286096    | 18-Dec-21 | 02:05 | x64      |
| Xe.dll                                                     | 2017.140.3430.2 | 588672    | 18-Dec-21 | 01:57 | x86      |
| Xe.dll                                                     | 2017.140.3430.2 | 667576    | 18-Dec-21 | 02:05 | x64      |
| Xmlrw.dll                                                  | 2017.140.3430.2 | 250760    | 18-Dec-21 | 01:57 | x86      |
| Xmlrw.dll                                                  | 2017.140.3430.2 | 298376    | 18-Dec-21 | 02:05 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3430.2 | 182656    | 18-Dec-21 | 01:57 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3430.2 | 217488    | 18-Dec-21 | 02:05 | x64      |

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
