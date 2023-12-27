---
title: Cumulative update 27 for SQL Server 2017 (KB5006944)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 27 (KB5006944).
ms.date: 08/04/2023
ms.custom: KB5006944
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5006944 - Cumulative Update 27 for SQL Server 2017

_Release Date:_ &nbsp; October 27, 2021  
_Version:_ &nbsp; 14.0.3421.10

## Summary

This article describes Cumulative Update package 27 (CU27) for Microsoft SQL Server 2017. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 26, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3421.10**, file version: **2017.140.3421.10**
- Analysis Services - Product version: **14.0.249.83**, file version: **2017.140.249.83**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area | Component | Platform |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|-------------------------------------------|----------|
| <a id=14247979>[14247979](#14247979) </a> | [FIX: Access violation occurs when you use LOB data type with columnstore indexes in SQL Server 2017 (KB5007158)](https://support.microsoft.com/help/5007158) | SQL Server Engine | Column Stores| All |
| <a id=14080201>[14080201](#14080201) </a> | Fixes the failed assertion that occurs due to implicit conversion where predicate's precision is greater than the value: </br></br>Msg 3624, Level 20, State 1, Line \<LineNumber> </br></br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump is sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br></br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br></br>A severe error occurred on the current command. The results, if any, should be discarded. | SQL Server Engine | Column Stores | Windows 
| <a id=14269761>[14269761](#14269761) </a> | [FIX: Sp_execute_external_script fails after you configure new runtime and remove a new Cumulative Update patch in SQL Server 2017 (KB5007381)](https://support.microsoft.com/help/5007381) | SQL Server Engine|Extensibility| Windows |
| <a id=14182231>[14182231](#14182231) </a> | Fixes an issue where an incorrect name entry in `sys.servers` can result in Always On Availability Group (AG) replica being removed when the server name doesn't match Windows hostname. |SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=14232818>[14232818](#14232818) </a> | Fixes an issue in which the extended event version in the `Alwayson_health` session isn't changed automatically during the Cumulative Update upgrade and downgrade. | SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=14279542>[14279542](#14279542) </a> | Fixes an access violation exception that may occur when `sp_server_diagnostics` is executed.| SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=14266687>[14266687](#14266687) </a> | Fixes an issue where the output of `sp_pkeys` `KEY_SEQ` column doesn't conform to the ordering of columns defined in the Primary Key. | SQL Server Engine | Metadata | Windows |
| <a id=13748048>[13748048](#13748048) </a> | Prevents ghost cleanup from triggering a memory dump during latch time-out in SQL Server 2019.| SQL Server Engine|Methods to access stored data| Windows |
| <a id=13952862>[13952862](#13952862) </a> | Fixes an intra-query deadlock that occurs with certain queries when verbose truncation feature is enabled.| SQL Server Engine|Methods to access stored data | Windows |
| <a id=13788019>[13788019](#13788019) </a> | Fixes an issue where Failover Cluster Instance (FCI) setup fails on secondary nodes of a PolyBase scale-out group in a standard edition of SQL Server 2019. Here's the error message: </br></br>The specified scaleout setting for Polybase is not the same as that specified for the active node in the SQL Server Failover Cluster. To continue, please provide False for the setting. | SQL Server Engine | Polybase | Windows |
| <a id=14269725>[14269725](#14269725) </a> | [FIX: You encounter error messages 8114 or 22122 when performing change tracking cleanup (KB5007039)](https://support.microsoft.com/help/5007039)| SQL Server Engine | Replication | Windows |
| <a id=14216911>[14216911](#14216911) </a> | Fixes an issue where Cumulative Update (CU) patching fails with the following message when you set default data directory to Azure Blob Storage URL: </br></br>The given path's format is not supported. </br></br>Exception Type “System.NotSupportedException” </br></br>**Note**: To work around the issue, you can change the data default directory to a local directory and rerun the SQL patch. | SQL Setup | Patching | Windows|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU27 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2021/10/sqlserver2017-kb5006944-x64_1109176cec3724feb7e21b6e6804b0876229c7c9.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5006944-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5006944-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5006944-x64.exe| CCFA4DC8C7D39B2C3BC5F97067C8C57E72D7F9180AD5AABCC0B5D86E41513E66 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.83  | 259464    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.83      | 735112    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.83      | 1374088   | 14-Oct-21 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.83      | 977304    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.83      | 514960    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435      | 329872    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516      | 661072    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541    | 186232    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541    | 30080     | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541    | 74832     | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541    | 102264    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516      | 1454672   | 14-Oct-21 | 11:24 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516      | 181112    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25         | 920656    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541    | 5262728   | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541    | 22392     | 14-Oct-21 | 11:23 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541    | 21880     | 14-Oct-21 | 11:23 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541    | 22096     | 14-Oct-21 | 11:23 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541    | 149368    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541    | 78712     | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541    | 192392    | 14-Oct-21 | 11:23 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541    | 59984     | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541    | 27512     | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0          | 140368    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541    | 14271872  | 14-Oct-21 | 11:24 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0         | 1437568   | 14-Oct-21 | 11:23 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0         | 778632    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19       | 1104976   | 14-Oct-21 | 11:23 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0         | 126336    | 14-Oct-21 | 11:23 | x86      |
| Msmdctr.dll                                        | 2017.140.249.83  | 33168     | 14-Oct-21 | 11:18 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.83  | 60766096  | 14-Oct-21 | 11:18 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.83  | 40420256  | 14-Oct-21 | 11:30 | x86      |
| Msmdpump.dll                                       | 2017.140.249.83  | 9333136   | 14-Oct-21 | 11:18 | x64      |
| Msmdredir.dll                                      | 2017.140.249.83  | 7088544   | 14-Oct-21 | 11:30 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.83  | 60667776  | 14-Oct-21 | 11:18 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.83  | 9000856   | 14-Oct-21 | 11:18 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.83  | 7305096   | 14-Oct-21 | 11:30 | x86      |
| Msolap.dll                                         | 2017.140.249.83  | 10256784  | 14-Oct-21 | 11:18 | x64      |
| Msolap.dll                                         | 2017.140.249.83  | 7772568   | 14-Oct-21 | 11:30 | x86      |
| Msolui.dll                                         | 2017.140.249.83  | 304016    | 14-Oct-21 | 11:18 | x64      |
| Msolui.dll                                         | 2017.140.249.83  | 280448    | 14-Oct-21 | 11:30 | x86      |
| Powerbiextensions.dll                              | 2.80.5803.541    | 9470032   | 14-Oct-21 | 11:24 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000  | 728456    | 14-Oct-21 | 11:23 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlboot.dll                                        | 2017.140.3421.10 | 190864    | 14-Oct-21 | 11:18 | x64      |
| Sqlceip.exe                                        | 14.0.3421.10     | 268160    | 14-Oct-21 | 11:14 | x86      |
| Sqldumper.exe                                      | 2017.140.3421.10 | 116128    | 14-Oct-21 | 11:16 | x86      |
| Sqldumper.exe                                      | 2017.140.3421.10 | 138640    | 14-Oct-21 | 11:16 | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516      | 117640    | 14-Oct-21 | 11:23 | x86      |
| Tmapi.dll                                          | 2017.140.249.83  | 5814656   | 14-Oct-21 | 11:18 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.83  | 4157832   | 14-Oct-21 | 11:18 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.83  | 1125256   | 14-Oct-21 | 11:19 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.83  | 1636240   | 14-Oct-21 | 11:18 | x64      |
| Xe.dll                                             | 2017.140.3421.10 | 666512    | 14-Oct-21 | 11:19 | x64      |
| Xmlrw.dll                                          | 2017.140.3421.10 | 298384    | 14-Oct-21 | 11:19 | x64      |
| Xmlrw.dll                                          | 2017.140.3421.10 | 250760    | 14-Oct-21 | 11:31 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3421.10 | 217488    | 14-Oct-21 | 11:19 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3421.10 | 182688    | 14-Oct-21 | 11:31 | x86      |
| Xmsrv.dll                                          | 2017.140.249.83  | 25376136  | 14-Oct-21 | 11:19 | x64      |
| Xmsrv.dll                                          | 2017.140.249.83  | 33349512  | 14-Oct-21 | 11:31 | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3421.10 | 173960    | 14-Oct-21 | 11:18 | x64      |
| Batchparser.dll                            | 2017.140.3421.10 | 153504    | 14-Oct-21 | 11:30 | x86      |
| Instapi140.dll                             | 2017.140.3421.10 | 65424     | 14-Oct-21 | 11:18 | x64      |
| Instapi140.dll                             | 2017.140.3421.10 | 55712     | 14-Oct-21 | 11:30 | x86      |
| Isacctchange.dll                           | 2017.140.3421.10 | 23968     | 14-Oct-21 | 11:18 | x64      |
| Isacctchange.dll                           | 2017.140.3421.10 | 22424     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.83      | 1081736   | 14-Oct-21 | 11:18 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.83      | 1081736   | 14-Oct-21 | 11:30 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.83      | 1374592   | 14-Oct-21 | 11:30 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.83      | 734600    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.83      | 734608    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3421.10     | 30608     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3421.10 | 75144     | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3421.10 | 71568     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3421.10     | 564616    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3421.10     | 564616    | 14-Oct-21 | 11:30 | x86      |
| Msasxpress.dll                             | 2017.140.249.83  | 29064     | 14-Oct-21 | 11:18 | x64      |
| Msasxpress.dll                             | 2017.140.249.83  | 24976     | 14-Oct-21 | 11:30 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3421.10 | 77216     | 14-Oct-21 | 11:18 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3421.10 | 62368     | 14-Oct-21 | 11:30 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqldumper.exe                              | 2017.140.3421.10 | 116128    | 14-Oct-21 | 11:16 | x86      |
| Sqldumper.exe                              | 2017.140.3421.10 | 138640    | 14-Oct-21 | 11:16 | x64      |
| Sqlftacct.dll                              | 2017.140.3421.10 | 57232     | 14-Oct-21 | 11:18 | x64      |
| Sqlftacct.dll                              | 2017.140.3421.10 | 49040     | 14-Oct-21 | 11:30 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 14-Oct-21 | 11:18 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 14-Oct-21 | 11:30 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3421.10 | 413088    | 14-Oct-21 | 11:18 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3421.10 | 368528    | 14-Oct-21 | 11:30 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3421.10 | 30608     | 14-Oct-21 | 11:18 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3421.10 | 28048     | 14-Oct-21 | 11:30 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3421.10 | 351112    | 14-Oct-21 | 11:18 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3421.10 | 267144    | 14-Oct-21 | 11:30 | x86      |
| Sqltdiagn.dll                              | 2017.140.3421.10 | 60816     | 14-Oct-21 | 11:18 | x64      |
| Sqltdiagn.dll                              | 2017.140.3421.10 | 53664     | 14-Oct-21 | 11:30 | x86      |
| Svrenumapi140.dll                          | 2017.140.3421.10 | 1167752   | 14-Oct-21 | 11:18 | x64      |
| Svrenumapi140.dll                          | 2017.140.3421.10 | 888192    | 14-Oct-21 | 11:30 | x86      |

SQL Server 2017 Data Quality Client

| File   name         | File version     | File size | Date      | Time  | Platform |
|---------------------|------------------|-----------|-----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2    | 24624     | 14-Oct-21 | 11:30 | x86      |
| Link.exe            | 12.10.30102.2    | 852528    | 14-Oct-21 | 11:30 | x86      |
| Mspdb120.dll        | 12.10.30102.2    | 259632    | 14-Oct-21 | 11:30 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Stdole.dll          | 7.0.9466.0       | 32296     | 14-Oct-21 | 11:30 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-Oct-21 | 11:30 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version     | File size | Date      | Time  | Platform |
|--------------------------------|------------------|-----------|-----------|-------|----------|
| Dreplayclient.exe              | 2017.140.3421.10 | 114064    | 14-Oct-21 | 11:30 | x86      |
| Dreplaycommon.dll              | 2017.140.3421.10 | 693136    | 14-Oct-21 | 11:30 | x86      |
| Dreplayserverps.dll            | 2017.140.3421.10 | 26016     | 14-Oct-21 | 11:30 | x86      |
| Dreplayutil.dll                | 2017.140.3421.10 | 303504    | 14-Oct-21 | 11:30 | x86      |
| Instapi140.dll                 | 2017.140.3421.10 | 65424     | 14-Oct-21 | 11:18 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlresourceloader.dll          | 2017.140.3421.10 | 22432     | 14-Oct-21 | 11:30 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version     | File size | Date      | Time  | Platform |
|------------------------------------|------------------|-----------|-----------|-------|----------|
| Dreplaycommon.dll                  | 2017.140.3421.10 | 693136    | 14-Oct-21 | 11:30 | x86      |
| Dreplaycontroller.exe              | 2017.140.3421.10 | 343432    | 14-Oct-21 | 11:30 | x86      |
| Dreplayprocess.dll                 | 2017.140.3421.10 | 164752    | 14-Oct-21 | 11:30 | x86      |
| Dreplayserverps.dll                | 2017.140.3421.10 | 26016     | 14-Oct-21 | 11:30 | x86      |
| Instapi140.dll                     | 2017.140.3421.10 | 65424     | 14-Oct-21 | 11:18 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlresourceloader.dll              | 2017.140.3421.10 | 22432     | 14-Oct-21 | 11:30 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------|------------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3421.10     | 33696     | 14-Oct-21 | 11:18 | x64      |
| Batchparser.dll                              | 2017.140.3421.10 | 173960    | 14-Oct-21 | 11:18 | x64      |
| C1.dll                                       | 18.10.40116.18   | 925232    | 14-Oct-21 | 11:16 | x64      |
| C2.dll                                       | 18.10.40116.18   | 5341440   | 14-Oct-21 | 11:16 | x64      |
| Cl.exe                                       | 18.10.40116.18   | 192048    | 14-Oct-21 | 11:16 | x64      |
| Clui.dll                                     | 18.10.40116.10   | 486144    | 14-Oct-21 | 11:21 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0     | 48352     | 14-Oct-21 | 11:18 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3421.10 | 220560    | 14-Oct-21 | 11:18 | x64      |
| Dcexec.exe                                   | 2017.140.3421.10 | 67472     | 14-Oct-21 | 11:18 | x64      |
| Fssres.dll                                   | 2017.140.3421.10 | 83856     | 14-Oct-21 | 11:18 | x64      |
| Hadrres.dll                                  | 2017.140.3421.10 | 182672    | 14-Oct-21 | 11:18 | x64      |
| Hkcompile.dll                                | 2017.140.3421.10 | 1416072   | 14-Oct-21 | 11:18 | x64      |
| Hkengine.dll                                 | 2017.140.3421.10 | 5854608   | 14-Oct-21 | 11:18 | x64      |
| Hkruntime.dll                                | 2017.140.3421.10 | 156048    | 14-Oct-21 | 11:18 | x64      |
| Link.exe                                     | 12.10.40116.18   | 1017392   | 14-Oct-21 | 11:16 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.83      | 734080    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435      | 329872    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3421.10     | 231816    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3421.10     | 73096     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3421.10 | 385952    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3421.10 | 65424     | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3421.10 | 58248     | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3421.10 | 145288    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3421.10 | 152464    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3421.10 | 296848    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3421.10 | 67984     | 14-Oct-21 | 11:18 | x64      |
| Msobj120.dll                                 | 12.10.40116.18   | 129576    | 14-Oct-21 | 11:16 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18   | 559144    | 14-Oct-21 | 11:16 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18   | 559144    | 14-Oct-21 | 11:16 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18   | 661040    | 14-Oct-21 | 11:16 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18   | 964656    | 14-Oct-21 | 11:16 | x64      |
| Odsole70.dll                                 | 2017.140.3421.10 | 85896     | 14-Oct-21 | 11:18 | x64      |
| Opends60.dll                                 | 2017.140.3421.10 | 26000     | 14-Oct-21 | 11:18 | x64      |
| Qds.dll                                      | 2017.140.3421.10 | 1176456   | 14-Oct-21 | 11:18 | x64      |
| Rsfxft.dll                                   | 2017.140.3421.10 | 27528     | 14-Oct-21 | 11:18 | x64      |
| Secforwarder.dll                             | 2017.140.3421.10 | 30592     | 14-Oct-21 | 11:18 | x64      |
| Sqagtres.dll                                 | 2017.140.3421.10 | 69024     | 14-Oct-21 | 11:18 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlaamss.dll                                 | 2017.140.3421.10 | 84896     | 14-Oct-21 | 11:18 | x64      |
| Sqlaccess.dll                                | 2017.140.3421.10 | 468880    | 14-Oct-21 | 11:18 | x64      |
| Sqlagent.exe                                 | 2017.140.3421.10 | 598416    | 14-Oct-21 | 11:18 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3421.10 | 56200     | 14-Oct-21 | 11:18 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3421.10 | 47504     | 14-Oct-21 | 11:30 | x86      |
| Sqlagentlog.dll                              | 2017.140.3421.10 | 25992     | 14-Oct-21 | 11:18 | x64      |
| Sqlagentmail.dll                             | 2017.140.3421.10 | 47008     | 14-Oct-21 | 11:18 | x64      |
| Sqlboot.dll                                  | 2017.140.3421.10 | 190864    | 14-Oct-21 | 11:18 | x64      |
| Sqlceip.exe                                  | 14.0.3421.10     | 268160    | 14-Oct-21 | 11:14 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3421.10 | 67472     | 14-Oct-21 | 11:18 | x64      |
| Sqlctr140.dll                                | 2017.140.3421.10 | 123784    | 14-Oct-21 | 11:18 | x64      |
| Sqlctr140.dll                                | 2017.140.3421.10 | 106384    | 14-Oct-21 | 11:30 | x86      |
| Sqldk.dll                                    | 2017.140.3421.10 | 2803592   | 14-Oct-21 | 11:18 | x64      |
| Sqldtsss.dll                                 | 2017.140.3421.10 | 102288    | 14-Oct-21 | 11:18 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 1499528   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3295120   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 1446792   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3300752   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3825040   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3342728   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3600784   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3789712   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3921800   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3485584   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 2092424   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3217288   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3592584   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3640200   | 14-Oct-21 | 11:21 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 2038672   | 14-Oct-21 | 11:23 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3371408   | 14-Oct-21 | 11:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3406728   | 14-Oct-21 | 11:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3784072   | 14-Oct-21 | 11:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3791232   | 14-Oct-21 | 11:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3919248   | 14-Oct-21 | 11:26 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 4031888   | 14-Oct-21 | 11:26 | x64      |
| Sqlevn70.rll                                 | 2017.140.3421.10 | 3681672   | 14-Oct-21 | 11:29 | x64      |
| Sqliosim.com                                 | 2017.140.3421.10 | 306576    | 14-Oct-21 | 11:18 | x64      |
| Sqliosim.exe                                 | 2017.140.3421.10 | 3013008   | 14-Oct-21 | 11:18 | x64      |
| Sqllang.dll                                  | 2017.140.3421.10 | 41414544  | 14-Oct-21 | 11:18 | x64      |
| Sqlmin.dll                                   | 2017.140.3421.10 | 40593800  | 14-Oct-21 | 11:18 | x64      |
| Sqlolapss.dll                                | 2017.140.3421.10 | 102304    | 14-Oct-21 | 11:18 | x64      |
| Sqlos.dll                                    | 2017.140.3421.10 | 19344     | 14-Oct-21 | 11:18 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3421.10 | 62880     | 14-Oct-21 | 11:18 | x64      |
| Sqlrepss.dll                                 | 2017.140.3421.10 | 61832     | 14-Oct-21 | 11:18 | x64      |
| Sqlresld.dll                                 | 2017.140.3421.10 | 23944     | 14-Oct-21 | 11:18 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3421.10 | 25480     | 14-Oct-21 | 11:18 | x64      |
| Sqlscm.dll                                   | 2017.140.3421.10 | 65936     | 14-Oct-21 | 11:18 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3421.10 | 20872     | 14-Oct-21 | 11:18 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3421.10 | 5890448   | 14-Oct-21 | 11:18 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3421.10 | 725920    | 14-Oct-21 | 11:18 | x64      |
| Sqlservr.exe                                 | 2017.140.3421.10 | 481672    | 14-Oct-21 | 11:18 | x64      |
| Sqlsvc.dll                                   | 2017.140.3421.10 | 156064    | 14-Oct-21 | 11:18 | x64      |
| Sqltses.dll                                  | 2017.140.3421.10 | 9559432   | 14-Oct-21 | 11:18 | x64      |
| Sqsrvres.dll                                 | 2017.140.3421.10 | 255888    | 14-Oct-21 | 11:18 | x64      |
| Svl.dll                                      | 2017.140.3421.10 | 146832    | 14-Oct-21 | 11:18 | x64      |
| Xe.dll                                       | 2017.140.3421.10 | 666512    | 14-Oct-21 | 11:19 | x64      |
| Xmlrw.dll                                    | 2017.140.3421.10 | 298384    | 14-Oct-21 | 11:19 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3421.10 | 217488    | 14-Oct-21 | 11:19 | x64      |
| Xpadsi.exe                                   | 2017.140.3421.10 | 84880     | 14-Oct-21 | 11:18 | x64      |
| Xplog70.dll                                  | 2017.140.3421.10 | 71056     | 14-Oct-21 | 11:19 | x64      |
| Xpqueue.dll                                  | 2017.140.3421.10 | 67984     | 14-Oct-21 | 11:19 | x64      |
| Xprepl.dll                                   | 2017.140.3421.10 | 96656     | 14-Oct-21 | 11:19 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3421.10 | 25480     | 14-Oct-21 | 11:19 | x64      |
| Xpstar.dll                                   | 2017.140.3421.10 | 445328    | 14-Oct-21 | 11:18 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version     | File size | Date      | Time  | Platform |
|-------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3421.10 | 173960    | 14-Oct-21 | 11:18 | x64      |
| Batchparser.dll                                             | 2017.140.3421.10 | 153504    | 14-Oct-21 | 11:30 | x86      |
| Bcp.exe                                                     | 2017.140.3421.10 | 113040    | 14-Oct-21 | 11:18 | x64      |
| Commanddest.dll                                             | 2017.140.3421.10 | 238976    | 14-Oct-21 | 11:18 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3421.10 | 109448    | 14-Oct-21 | 11:18 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3421.10 | 180624    | 14-Oct-21 | 11:18 | x64      |
| Distrib.exe                                                 | 2017.140.3421.10 | 198048    | 14-Oct-21 | 11:18 | x64      |
| Dteparse.dll                                                | 2017.140.3421.10 | 104328    | 14-Oct-21 | 11:18 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dtepkg.dll                                                  | 2017.140.3421.10 | 130960    | 14-Oct-21 | 11:18 | x64      |
| Dtexec.exe                                                  | 2017.140.3421.10 | 66960     | 14-Oct-21 | 11:18 | x64      |
| Dts.dll                                                     | 2017.140.3421.10 | 2994064   | 14-Oct-21 | 11:18 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3421.10 | 468360    | 14-Oct-21 | 11:18 | x64      |
| Dtsconn.dll                                                 | 2017.140.3421.10 | 493448    | 14-Oct-21 | 11:18 | x64      |
| Dtshost.exe                                                 | 2017.140.3421.10 | 99208     | 14-Oct-21 | 11:18 | x64      |
| Dtslog.dll                                                  | 2017.140.3421.10 | 113544    | 14-Oct-21 | 11:18 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3421.10 | 538512    | 14-Oct-21 | 11:18 | x64      |
| Dtspipeline.dll                                             | 2017.140.3421.10 | 1261472   | 14-Oct-21 | 11:18 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3421.10 | 41352     | 14-Oct-21 | 11:18 | x64      |
| Dtuparse.dll                                                | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dtutil.exe                                                  | 2017.140.3421.10 | 141712    | 14-Oct-21 | 11:18 | x64      |
| Exceldest.dll                                               | 2017.140.3421.10 | 253832    | 14-Oct-21 | 11:18 | x64      |
| Excelsrc.dll                                                | 2017.140.3421.10 | 275856    | 14-Oct-21 | 11:18 | x64      |
| Execpackagetask.dll                                         | 2017.140.3421.10 | 161168    | 14-Oct-21 | 11:18 | x64      |
| Flatfiledest.dll                                            | 2017.140.3421.10 | 379784    | 14-Oct-21 | 11:18 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3421.10 | 392592    | 14-Oct-21 | 11:18 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3421.10 | 89480     | 14-Oct-21 | 11:18 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3421.10 | 52624     | 14-Oct-21 | 11:18 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8          | 471440    | 14-Oct-21 | 11:27 | x86      |
| Logread.exe                                                 | 2017.140.3421.10 | 629648    | 14-Oct-21 | 11:18 | x64      |
| Mergetxt.dll                                                | 2017.140.3421.10 | 58272     | 14-Oct-21 | 11:18 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.83      | 1375112   | 14-Oct-21 | 11:18 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0         | 171208    | 14-Oct-21 | 11:27 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3421.10     | 130976    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3421.10     | 48520     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3421.10     | 82824     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3421.10     | 66464     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3421.10     | 385408    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3421.10     | 607616    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3421.10 | 1657760   | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3421.10     | 564616    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3421.10 | 145288    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3421.10 | 152464    | 14-Oct-21 | 11:18 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3421.10 | 96136     | 14-Oct-21 | 11:18 | x64      |
| Msgprox.dll                                                 | 2017.140.3421.10 | 265120    | 14-Oct-21 | 11:18 | x64      |
| Msxmlsql.dll                                                | 2017.140.3421.10 | 1441160   | 14-Oct-21 | 11:18 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111      | 522856    | 14-Oct-21 | 11:27 | x86      |
| Oledbdest.dll                                               | 2017.140.3421.10 | 254368    | 14-Oct-21 | 11:18 | x64      |
| Oledbsrc.dll                                                | 2017.140.3421.10 | 281992    | 14-Oct-21 | 11:18 | x64      |
| Osql.exe                                                    | 2017.140.3421.10 | 68488     | 14-Oct-21 | 11:18 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3421.10 | 468896    | 14-Oct-21 | 11:18 | x64      |
| Rawdest.dll                                                 | 2017.140.3421.10 | 199560    | 14-Oct-21 | 11:18 | x64      |
| Rawsource.dll                                               | 2017.140.3421.10 | 187272    | 14-Oct-21 | 11:18 | x64      |
| Rdistcom.dll                                                | 2017.140.3421.10 | 852384    | 14-Oct-21 | 11:18 | x64      |
| Recordsetdest.dll                                           | 2017.140.3421.10 | 177544    | 14-Oct-21 | 11:18 | x64      |
| Replagnt.dll                                                | 2017.140.3421.10 | 23952     | 14-Oct-21 | 11:18 | x64      |
| Repldp.dll                                                  | 2017.140.3421.10 | 285576    | 14-Oct-21 | 11:18 | x64      |
| Replerrx.dll                                                | 2017.140.3421.10 | 148896    | 14-Oct-21 | 11:18 | x64      |
| Replisapi.dll                                               | 2017.140.3421.10 | 357248    | 14-Oct-21 | 11:18 | x64      |
| Replmerg.exe                                                | 2017.140.3421.10 | 520072    | 14-Oct-21 | 11:18 | x64      |
| Replprov.dll                                                | 2017.140.3421.10 | 797064    | 14-Oct-21 | 11:18 | x64      |
| Replrec.dll                                                 | 2017.140.3421.10 | 972704    | 14-Oct-21 | 11:18 | x64      |
| Replsub.dll                                                 | 2017.140.3421.10 | 440208    | 14-Oct-21 | 11:18 | x64      |
| Replsync.dll                                                | 2017.140.3421.10 | 148368    | 14-Oct-21 | 11:18 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576    | 871680    | 14-Oct-21 | 11:18 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576    | 75016     | 14-Oct-21 | 11:18 | x64      |
| Spresolv.dll                                                | 2017.140.3421.10 | 247176    | 14-Oct-21 | 11:18 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3421.10 | 242064    | 14-Oct-21 | 11:18 | x64      |
| Sqldiag.exe                                                 | 2017.140.3421.10 | 1254816   | 14-Oct-21 | 11:18 | x64      |
| Sqldistx.dll                                                | 2017.140.3421.10 | 219536    | 14-Oct-21 | 11:18 | x64      |
| Sqllogship.exe                                              | 14.0.3421.10     | 99232     | 14-Oct-21 | 11:18 | x64      |
| Sqlmergx.dll                                                | 2017.140.3421.10 | 355232    | 14-Oct-21 | 11:18 | x64      |
| Sqlresld.dll                                                | 2017.140.3421.10 | 23944     | 14-Oct-21 | 11:18 | x64      |
| Sqlresld.dll                                                | 2017.140.3421.10 | 21920     | 14-Oct-21 | 11:30 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3421.10 | 25480     | 14-Oct-21 | 11:18 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3421.10 | 22432     | 14-Oct-21 | 11:30 | x86      |
| Sqlscm.dll                                                  | 2017.140.3421.10 | 65936     | 14-Oct-21 | 11:18 | x64      |
| Sqlscm.dll                                                  | 2017.140.3421.10 | 55200     | 14-Oct-21 | 11:30 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3421.10 | 156064    | 14-Oct-21 | 11:18 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3421.10 | 128400    | 14-Oct-21 | 11:30 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3421.10 | 177032    | 14-Oct-21 | 11:18 | x64      |
| Sqlwep140.dll                                               | 2017.140.3421.10 | 98720     | 14-Oct-21 | 11:18 | x64      |
| Ssdebugps.dll                                               | 2017.140.3421.10 | 26512     | 14-Oct-21 | 11:18 | x64      |
| Ssisoledb.dll                                               | 2017.140.3421.10 | 209288    | 14-Oct-21 | 11:18 | x64      |
| Ssradd.dll                                                  | 2017.140.3421.10 | 70032     | 14-Oct-21 | 11:18 | x64      |
| Ssravg.dll                                                  | 2017.140.3421.10 | 70560     | 14-Oct-21 | 11:18 | x64      |
| Ssrdown.dll                                                 | 2017.140.3421.10 | 55176     | 14-Oct-21 | 11:18 | x64      |
| Ssrmax.dll                                                  | 2017.140.3421.10 | 68512     | 14-Oct-21 | 11:18 | x64      |
| Ssrmin.dll                                                  | 2017.140.3421.10 | 68512     | 14-Oct-21 | 11:18 | x64      |
| Ssrpub.dll                                                  | 2017.140.3421.10 | 55696     | 14-Oct-21 | 11:18 | x64      |
| Ssrup.dll                                                   | 2017.140.3421.10 | 55184     | 14-Oct-21 | 11:18 | x64      |
| Tablediff.exe                                               | 14.0.3421.10     | 79744     | 14-Oct-21 | 11:19 | x64      |
| Txagg.dll                                                   | 2017.140.3421.10 | 355208    | 14-Oct-21 | 11:18 | x64      |
| Txbdd.dll                                                   | 2017.140.3421.10 | 163208    | 14-Oct-21 | 11:18 | x64      |
| Txdatacollector.dll                                         | 2017.140.3421.10 | 353680    | 14-Oct-21 | 11:18 | x64      |
| Txdataconvert.dll                                           | 2017.140.3421.10 | 286080    | 14-Oct-21 | 11:18 | x64      |
| Txderived.dll                                               | 2017.140.3421.10 | 597392    | 14-Oct-21 | 11:18 | x64      |
| Txlookup.dll                                                | 2017.140.3421.10 | 521096    | 14-Oct-21 | 11:18 | x64      |
| Txmerge.dll                                                 | 2017.140.3421.10 | 223112    | 14-Oct-21 | 11:18 | x64      |
| Txmergejoin.dll                                             | 2017.140.3421.10 | 268680    | 14-Oct-21 | 11:18 | x64      |
| Txmulticast.dll                                             | 2017.140.3421.10 | 120720    | 14-Oct-21 | 11:18 | x64      |
| Txrowcount.dll                                              | 2017.140.3421.10 | 118664    | 14-Oct-21 | 11:18 | x64      |
| Txsort.dll                                                  | 2017.140.3421.10 | 249744    | 14-Oct-21 | 11:18 | x64      |
| Txsplit.dll                                                 | 2017.140.3421.10 | 589712    | 14-Oct-21 | 11:18 | x64      |
| Txunionall.dll                                              | 2017.140.3421.10 | 174992    | 14-Oct-21 | 11:18 | x64      |
| Xe.dll                                                      | 2017.140.3421.10 | 666512    | 14-Oct-21 | 11:19 | x64      |
| Xmlrw.dll                                                   | 2017.140.3421.10 | 298384    | 14-Oct-21 | 11:19 | x64      |
| Xmlsub.dll                                                  | 2017.140.3421.10 | 255392    | 14-Oct-21 | 11:19 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version     | File size | Date      | Time  | Platform |
|-------------------------------|------------------|-----------|-----------|-------|----------|
| Launchpad.exe                 | 2017.140.3421.10 | 1122696   | 14-Oct-21 | 11:18 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlsatellite.dll              | 2017.140.3421.10 | 916896    | 14-Oct-21 | 11:18 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version     | File size | Date      | Time  | Platform |
|--------------------------|------------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2017.140.3421.10 | 665488    | 14-Oct-21 | 11:18 | x64      |
| Fdhost.exe               | 2017.140.3421.10 | 109440    | 14-Oct-21 | 11:18 | x64      |
| Fdlauncher.exe           | 2017.140.3421.10 | 57232     | 14-Oct-21 | 11:18 | x64      |
| Nlsdl.dll                | 6.0.6001.18000   | 46360     | 14-Oct-21 | 11:18 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlft140ph.dll           | 2017.140.3421.10 | 62856     | 14-Oct-21 | 11:18 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version     | File size | Date      | Time  | Platform |
|-------------------------|------------------|-----------|-----------|-------|----------|
| Imrdll.dll              | 14.0.3421.10     | 17312     | 14-Oct-21 | 11:18 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version     | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112        | 75264     | 14-Oct-21 | 11:18 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112        | 75264     | 14-Oct-21 | 11:30 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112        | 36352     | 14-Oct-21 | 11:18 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112        | 36352     | 14-Oct-21 | 11:30 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112        | 76288     | 14-Oct-21 | 11:18 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112        | 76288     | 14-Oct-21 | 11:30 | x86      |
| Commanddest.dll                                               | 2017.140.3421.10 | 238976    | 14-Oct-21 | 11:18 | x64      |
| Commanddest.dll                                               | 2017.140.3421.10 | 193928    | 14-Oct-21 | 11:29 | x86      |
| Dteparse.dll                                                  | 2017.140.3421.10 | 104328    | 14-Oct-21 | 11:18 | x64      |
| Dteparse.dll                                                  | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:30 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3421.10 | 76680     | 14-Oct-21 | 11:30 | x86      |
| Dtepkg.dll                                                    | 2017.140.3421.10 | 130960    | 14-Oct-21 | 11:18 | x64      |
| Dtepkg.dll                                                    | 2017.140.3421.10 | 109984    | 14-Oct-21 | 11:30 | x86      |
| Dtexec.exe                                                    | 2017.140.3421.10 | 66960     | 14-Oct-21 | 11:18 | x64      |
| Dtexec.exe                                                    | 2017.140.3421.10 | 60808     | 14-Oct-21 | 11:30 | x86      |
| Dts.dll                                                       | 2017.140.3421.10 | 2994064   | 14-Oct-21 | 11:18 | x64      |
| Dts.dll                                                       | 2017.140.3421.10 | 2544008   | 14-Oct-21 | 11:30 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3421.10 | 468360    | 14-Oct-21 | 11:18 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3421.10 | 411016    | 14-Oct-21 | 11:30 | x86      |
| Dtsconn.dll                                                   | 2017.140.3421.10 | 493448    | 14-Oct-21 | 11:18 | x64      |
| Dtsconn.dll                                                   | 2017.140.3421.10 | 395664    | 14-Oct-21 | 11:30 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3421.10 | 104336    | 14-Oct-21 | 11:18 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3421.10 | 88464     | 14-Oct-21 | 11:30 | x86      |
| Dtshost.exe                                                   | 2017.140.3421.10 | 99208     | 14-Oct-21 | 11:18 | x64      |
| Dtshost.exe                                                   | 2017.140.3421.10 | 84360     | 14-Oct-21 | 11:30 | x86      |
| Dtslog.dll                                                    | 2017.140.3421.10 | 113544    | 14-Oct-21 | 11:18 | x64      |
| Dtslog.dll                                                    | 2017.140.3421.10 | 96144     | 14-Oct-21 | 11:30 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3421.10 | 538512    | 14-Oct-21 | 11:18 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3421.10 | 534416    | 14-Oct-21 | 11:30 | x86      |
| Dtspipeline.dll                                               | 2017.140.3421.10 | 1261472   | 14-Oct-21 | 11:18 | x64      |
| Dtspipeline.dll                                               | 2017.140.3421.10 | 1053584   | 14-Oct-21 | 11:30 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3421.10 | 41352     | 14-Oct-21 | 11:18 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3421.10 | 35728     | 14-Oct-21 | 11:30 | x86      |
| Dtuparse.dll                                                  | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dtuparse.dll                                                  | 2017.140.3421.10 | 73608     | 14-Oct-21 | 11:30 | x86      |
| Dtutil.exe                                                    | 2017.140.3421.10 | 141712    | 14-Oct-21 | 11:18 | x64      |
| Dtutil.exe                                                    | 2017.140.3421.10 | 120736    | 14-Oct-21 | 11:30 | x86      |
| Exceldest.dll                                                 | 2017.140.3421.10 | 253832    | 14-Oct-21 | 11:18 | x64      |
| Exceldest.dll                                                 | 2017.140.3421.10 | 207760    | 14-Oct-21 | 11:30 | x86      |
| Excelsrc.dll                                                  | 2017.140.3421.10 | 275856    | 14-Oct-21 | 11:18 | x64      |
| Excelsrc.dll                                                  | 2017.140.3421.10 | 223624    | 14-Oct-21 | 11:30 | x86      |
| Execpackagetask.dll                                           | 2017.140.3421.10 | 161168    | 14-Oct-21 | 11:18 | x64      |
| Execpackagetask.dll                                           | 2017.140.3421.10 | 128400    | 14-Oct-21 | 11:30 | x86      |
| Flatfiledest.dll                                              | 2017.140.3421.10 | 379784    | 14-Oct-21 | 11:18 | x64      |
| Flatfiledest.dll                                              | 2017.140.3421.10 | 325512    | 14-Oct-21 | 11:30 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3421.10 | 392592    | 14-Oct-21 | 11:18 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3421.10 | 337296    | 14-Oct-21 | 11:30 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3421.10 | 89480     | 14-Oct-21 | 11:18 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3421.10 | 73608     | 14-Oct-21 | 11:30 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8          | 471440    | 14-Oct-21 | 11:17 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8          | 471440    | 14-Oct-21 | 11:27 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3421.10     | 459664    | 14-Oct-21 | 11:18 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3421.10     | 460176    | 14-Oct-21 | 11:30 | x86      |
| Isserverexec.exe                                              | 14.0.3421.10     | 141712    | 14-Oct-21 | 11:18 | x64      |
| Isserverexec.exe                                              | 14.0.3421.10     | 142216    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.83      | 1375112   | 14-Oct-21 | 11:18 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.83      | 1375112   | 14-Oct-21 | 11:30 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435      | 329872    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 14-Oct-21 | 11:17 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0         | 171208    | 14-Oct-21 | 11:27 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3421.10     | 105360    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3421.10 | 105344    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3421.10 | 100240    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3421.10     | 48520     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3421.10     | 48544     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3421.10     | 82824     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3421.10     | 82848     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3421.10     | 66464     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3421.10     | 66464     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3421.10     | 507784    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3421.10     | 507808    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3421.10     | 76688     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3421.10     | 76688     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3421.10     | 408968    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3421.10     | 408992    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3421.10     | 385408    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3421.10     | 607616    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3421.10     | 607632    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3421.10     | 246160    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3421.10     | 246176    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3421.10     | 48032     | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3421.10     | 48032     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3421.10 | 145288    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3421.10 | 135056    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3421.10 | 152464    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3421.10 | 138640    | 14-Oct-21 | 11:30 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3421.10     | 212896    | 14-Oct-21 | 11:18 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3421.10 | 96136     | 14-Oct-21 | 11:18 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3421.10 | 83336     | 14-Oct-21 | 11:30 | x86      |
| Msmdpp.dll                                                    | 2017.140.249.83  | 9192856   | 14-Oct-21 | 11:18 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 513424    | 14-Oct-21 | 11:15 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 522856    | 14-Oct-21 | 11:17 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 513424    | 14-Oct-21 | 11:18 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111      | 522856    | 14-Oct-21 | 11:27 | x86      |
| Oledbdest.dll                                                 | 2017.140.3421.10 | 254368    | 14-Oct-21 | 11:18 | x64      |
| Oledbdest.dll                                                 | 2017.140.3421.10 | 207752    | 14-Oct-21 | 11:30 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3421.10 | 281992    | 14-Oct-21 | 11:18 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3421.10 | 226184    | 14-Oct-21 | 11:30 | x86      |
| Rawdest.dll                                                   | 2017.140.3421.10 | 199560    | 14-Oct-21 | 11:18 | x64      |
| Rawdest.dll                                                   | 2017.140.3421.10 | 159632    | 14-Oct-21 | 11:30 | x86      |
| Rawsource.dll                                                 | 2017.140.3421.10 | 187272    | 14-Oct-21 | 11:18 | x64      |
| Rawsource.dll                                                 | 2017.140.3421.10 | 146320    | 14-Oct-21 | 11:30 | x86      |
| Recordsetdest.dll                                             | 2017.140.3421.10 | 177544    | 14-Oct-21 | 11:18 | x64      |
| Recordsetdest.dll                                             | 2017.140.3421.10 | 142224    | 14-Oct-21 | 11:30 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlceip.exe                                                   | 14.0.3421.10     | 268160    | 14-Oct-21 | 11:14 | x86      |
| Sqldest.dll                                                   | 2017.140.3421.10 | 253832    | 14-Oct-21 | 11:18 | x64      |
| Sqldest.dll                                                   | 2017.140.3421.10 | 206736    | 14-Oct-21 | 11:30 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3421.10 | 177032    | 14-Oct-21 | 11:18 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3421.10 | 148360    | 14-Oct-21 | 11:30 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3421.10 | 209288    | 14-Oct-21 | 11:18 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3421.10 | 169872    | 14-Oct-21 | 11:30 | x86      |
| Txagg.dll                                                     | 2017.140.3421.10 | 355208    | 14-Oct-21 | 11:18 | x64      |
| Txagg.dll                                                     | 2017.140.3421.10 | 295312    | 14-Oct-21 | 11:30 | x86      |
| Txbdd.dll                                                     | 2017.140.3421.10 | 163208    | 14-Oct-21 | 11:18 | x64      |
| Txbdd.dll                                                     | 2017.140.3421.10 | 129424    | 14-Oct-21 | 11:30 | x86      |
| Txbestmatch.dll                                               | 2017.140.3421.10 | 598416    | 14-Oct-21 | 11:18 | x64      |
| Txbestmatch.dll                                               | 2017.140.3421.10 | 486288    | 14-Oct-21 | 11:30 | x86      |
| Txcache.dll                                                   | 2017.140.3421.10 | 173448    | 14-Oct-21 | 11:18 | x64      |
| Txcache.dll                                                   | 2017.140.3421.10 | 139144    | 14-Oct-21 | 11:30 | x86      |
| Txcharmap.dll                                                 | 2017.140.3421.10 | 279944    | 14-Oct-21 | 11:18 | x64      |
| Txcharmap.dll                                                 | 2017.140.3421.10 | 242080    | 14-Oct-21 | 11:30 | x86      |
| Txcopymap.dll                                                 | 2017.140.3421.10 | 173440    | 14-Oct-21 | 11:18 | x64      |
| Txcopymap.dll                                                 | 2017.140.3421.10 | 138632    | 14-Oct-21 | 11:30 | x86      |
| Txdataconvert.dll                                             | 2017.140.3421.10 | 286080    | 14-Oct-21 | 11:18 | x64      |
| Txdataconvert.dll                                             | 2017.140.3421.10 | 246144    | 14-Oct-21 | 11:30 | x86      |
| Txderived.dll                                                 | 2017.140.3421.10 | 597392    | 14-Oct-21 | 11:18 | x64      |
| Txderived.dll                                                 | 2017.140.3421.10 | 508808    | 14-Oct-21 | 11:30 | x86      |
| Txfileextractor.dll                                           | 2017.140.3421.10 | 191880    | 14-Oct-21 | 11:18 | x64      |
| Txfileextractor.dll                                           | 2017.140.3421.10 | 153992    | 14-Oct-21 | 11:30 | x86      |
| Txfileinserter.dll                                            | 2017.140.3421.10 | 189832    | 14-Oct-21 | 11:18 | x64      |
| Txfileinserter.dll                                            | 2017.140.3421.10 | 152456    | 14-Oct-21 | 11:30 | x86      |
| Txgroupdups.dll                                               | 2017.140.3421.10 | 283536    | 14-Oct-21 | 11:18 | x64      |
| Txgroupdups.dll                                               | 2017.140.3421.10 | 224136    | 14-Oct-21 | 11:30 | x86      |
| Txlineage.dll                                                 | 2017.140.3421.10 | 129928    | 14-Oct-21 | 11:18 | x64      |
| Txlineage.dll                                                 | 2017.140.3421.10 | 103328    | 14-Oct-21 | 11:30 | x86      |
| Txlookup.dll                                                  | 2017.140.3421.10 | 521096    | 14-Oct-21 | 11:18 | x64      |
| Txlookup.dll                                                  | 2017.140.3421.10 | 439696    | 14-Oct-21 | 11:30 | x86      |
| Txmerge.dll                                                   | 2017.140.3421.10 | 223112    | 14-Oct-21 | 11:18 | x64      |
| Txmerge.dll                                                   | 2017.140.3421.10 | 169872    | 14-Oct-21 | 11:30 | x86      |
| Txmergejoin.dll                                               | 2017.140.3421.10 | 268680    | 14-Oct-21 | 11:18 | x64      |
| Txmergejoin.dll                                               | 2017.140.3421.10 | 214920    | 14-Oct-21 | 11:30 | x86      |
| Txmulticast.dll                                               | 2017.140.3421.10 | 120720    | 14-Oct-21 | 11:18 | x64      |
| Txmulticast.dll                                               | 2017.140.3421.10 | 95632     | 14-Oct-21 | 11:30 | x86      |
| Txpivot.dll                                                   | 2017.140.3421.10 | 218000    | 14-Oct-21 | 11:18 | x64      |
| Txpivot.dll                                                   | 2017.140.3421.10 | 173456    | 14-Oct-21 | 11:30 | x86      |
| Txrowcount.dll                                                | 2017.140.3421.10 | 118664    | 14-Oct-21 | 11:18 | x64      |
| Txrowcount.dll                                                | 2017.140.3421.10 | 94600     | 14-Oct-21 | 11:30 | x86      |
| Txsampling.dll                                                | 2017.140.3421.10 | 165768    | 14-Oct-21 | 11:18 | x64      |
| Txsampling.dll                                                | 2017.140.3421.10 | 128904    | 14-Oct-21 | 11:30 | x86      |
| Txscd.dll                                                     | 2017.140.3421.10 | 213896    | 14-Oct-21 | 11:18 | x64      |
| Txscd.dll                                                     | 2017.140.3421.10 | 163208    | 14-Oct-21 | 11:30 | x86      |
| Txsort.dll                                                    | 2017.140.3421.10 | 249744    | 14-Oct-21 | 11:18 | x64      |
| Txsort.dll                                                    | 2017.140.3421.10 | 201096    | 14-Oct-21 | 11:30 | x86      |
| Txsplit.dll                                                   | 2017.140.3421.10 | 589712    | 14-Oct-21 | 11:18 | x64      |
| Txsplit.dll                                                   | 2017.140.3421.10 | 503680    | 14-Oct-21 | 11:30 | x86      |
| Txtermextraction.dll                                          | 2017.140.3421.10 | 8669568   | 14-Oct-21 | 11:18 | x64      |
| Txtermextraction.dll                                          | 2017.140.3421.10 | 8608136   | 14-Oct-21 | 11:30 | x86      |
| Txtermlookup.dll                                              | 2017.140.3421.10 | 4150152   | 14-Oct-21 | 11:18 | x64      |
| Txtermlookup.dll                                              | 2017.140.3421.10 | 4099976   | 14-Oct-21 | 11:30 | x86      |
| Txunionall.dll                                                | 2017.140.3421.10 | 174992    | 14-Oct-21 | 11:18 | x64      |
| Txunionall.dll                                                | 2017.140.3421.10 | 132480    | 14-Oct-21 | 11:30 | x86      |
| Txunpivot.dll                                                 | 2017.140.3421.10 | 192896    | 14-Oct-21 | 11:18 | x64      |
| Txunpivot.dll                                                 | 2017.140.3421.10 | 153480    | 14-Oct-21 | 11:30 | x86      |
| Xe.dll                                                        | 2017.140.3421.10 | 666512    | 14-Oct-21 | 11:19 | x64      |
| Xe.dll                                                        | 2017.140.3421.10 | 588688    | 14-Oct-21 | 11:31 | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 14-Oct-21 | 11:25 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 14-Oct-21 | 11:25 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 14-Oct-21 | 11:25 | x86      |
| Instapi140.dll                                                       | 2017.140.3421.10 | 65424     | 14-Oct-21 | 11:25 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 14-Oct-21 | 11:27 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 14-Oct-21 | 11:16 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 14-Oct-21 | 11:22 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 14-Oct-21 | 11:23 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 14-Oct-21 | 11:27 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 14-Oct-21 | 11:16 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 14-Oct-21 | 11:14 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 14-Oct-21 | 11:26 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 14-Oct-21 | 11:22 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 14-Oct-21 | 11:25 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 14-Oct-21 | 11:25 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3421.10 | 400288    | 14-Oct-21 | 11:25 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3421.10 | 7324040   | 14-Oct-21 | 11:25 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3421.10 | 2258312   | 14-Oct-21 | 11:25 | x64      |
| Secforwarder.dll                                                     | 2017.140.3421.10 | 30592     | 14-Oct-21 | 11:25 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 14-Oct-21 | 11:25 | x64      |
| Sqldk.dll                                                            | 2017.140.3421.10 | 2735496   | 14-Oct-21 | 11:25 | x64      |
| Sqldumper.exe                                                        | 2017.140.3421.10 | 138640    | 14-Oct-21 | 11:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 1499528   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3919248   | 14-Oct-21 | 11:26 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3217288   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3921800   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3825040   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 2092424   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 2038672   | 14-Oct-21 | 11:23 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3592584   | 14-Oct-21 | 11:16 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3600784   | 14-Oct-21 | 11:15 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 1446792   | 14-Oct-21 | 11:14 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3421.10 | 3789712   | 14-Oct-21 | 11:15 | x64      |
| Sqlos.dll                                                            | 2017.140.3421.10 | 19344     | 14-Oct-21 | 11:25 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 14-Oct-21 | 11:25 | x64      |
| Sqltses.dll                                                          | 2017.140.3421.10 | 9729424   | 14-Oct-21 | 11:25 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version     | File size | Date      | Time  | Platform |
|------------------------------------|------------------|-----------|-----------|-------|----------|
| Smrdll.dll                         | 14.0.3421.10     | 17312     | 14-Oct-21 | 11:18 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version     | File size | Date      | Time  | Platform |
|------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Autoadmin.dll                                              | 2017.140.3421.10 | 1441672   | 14-Oct-21 | 11:30 | x86      |
| Dtaengine.exe                                              | 2017.140.3421.10 | 197536    | 14-Oct-21 | 11:30 | x86      |
| Dteparse.dll                                               | 2017.140.3421.10 | 104328    | 14-Oct-21 | 11:18 | x64      |
| Dteparse.dll                                               | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:30 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3421.10 | 76680     | 14-Oct-21 | 11:30 | x86      |
| Dtepkg.dll                                                 | 2017.140.3421.10 | 130960    | 14-Oct-21 | 11:18 | x64      |
| Dtepkg.dll                                                 | 2017.140.3421.10 | 109984    | 14-Oct-21 | 11:30 | x86      |
| Dtexec.exe                                                 | 2017.140.3421.10 | 66960     | 14-Oct-21 | 11:18 | x64      |
| Dtexec.exe                                                 | 2017.140.3421.10 | 60808     | 14-Oct-21 | 11:30 | x86      |
| Dts.dll                                                    | 2017.140.3421.10 | 2994064   | 14-Oct-21 | 11:18 | x64      |
| Dts.dll                                                    | 2017.140.3421.10 | 2544008   | 14-Oct-21 | 11:30 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3421.10 | 468360    | 14-Oct-21 | 11:18 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3421.10 | 411016    | 14-Oct-21 | 11:30 | x86      |
| Dtsconn.dll                                                | 2017.140.3421.10 | 493448    | 14-Oct-21 | 11:18 | x64      |
| Dtsconn.dll                                                | 2017.140.3421.10 | 395664    | 14-Oct-21 | 11:30 | x86      |
| Dtshost.exe                                                | 2017.140.3421.10 | 99208     | 14-Oct-21 | 11:18 | x64      |
| Dtshost.exe                                                | 2017.140.3421.10 | 84360     | 14-Oct-21 | 11:30 | x86      |
| Dtslog.dll                                                 | 2017.140.3421.10 | 113544    | 14-Oct-21 | 11:18 | x64      |
| Dtslog.dll                                                 | 2017.140.3421.10 | 96144     | 14-Oct-21 | 11:30 | x86      |
| Dtsmsg140.dll                                              | 2017.140.3421.10 | 538512    | 14-Oct-21 | 11:18 | x64      |
| Dtsmsg140.dll                                              | 2017.140.3421.10 | 534416    | 14-Oct-21 | 11:30 | x86      |
| Dtspipeline.dll                                            | 2017.140.3421.10 | 1261472   | 14-Oct-21 | 11:18 | x64      |
| Dtspipeline.dll                                            | 2017.140.3421.10 | 1053584   | 14-Oct-21 | 11:30 | x86      |
| Dtspipelineperf140.dll                                     | 2017.140.3421.10 | 41352     | 14-Oct-21 | 11:18 | x64      |
| Dtspipelineperf140.dll                                     | 2017.140.3421.10 | 35728     | 14-Oct-21 | 11:30 | x86      |
| Dtuparse.dll                                               | 2017.140.3421.10 | 82312     | 14-Oct-21 | 11:18 | x64      |
| Dtuparse.dll                                               | 2017.140.3421.10 | 73608     | 14-Oct-21 | 11:30 | x86      |
| Dtutil.exe                                                 | 2017.140.3421.10 | 141712    | 14-Oct-21 | 11:18 | x64      |
| Dtutil.exe                                                 | 2017.140.3421.10 | 120736    | 14-Oct-21 | 11:30 | x86      |
| Exceldest.dll                                              | 2017.140.3421.10 | 253832    | 14-Oct-21 | 11:18 | x64      |
| Exceldest.dll                                              | 2017.140.3421.10 | 207760    | 14-Oct-21 | 11:30 | x86      |
| Excelsrc.dll                                               | 2017.140.3421.10 | 275856    | 14-Oct-21 | 11:18 | x64      |
| Excelsrc.dll                                               | 2017.140.3421.10 | 223624    | 14-Oct-21 | 11:30 | x86      |
| Flatfiledest.dll                                           | 2017.140.3421.10 | 379784    | 14-Oct-21 | 11:18 | x64      |
| Flatfiledest.dll                                           | 2017.140.3421.10 | 325512    | 14-Oct-21 | 11:30 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3421.10 | 392592    | 14-Oct-21 | 11:18 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3421.10 | 337296    | 14-Oct-21 | 11:30 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3421.10 | 89480     | 14-Oct-21 | 11:18 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3421.10 | 73608     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3421.10     | 105376    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3421.10     | 179592    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3421.10     | 403360    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3421.10     | 403336    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3421.10     | 2086792   | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3421.10     | 2086784   | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3421.10     | 607616    | 14-Oct-21 | 11:18 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3421.10     | 607632    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3421.10     | 246176    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3421.10     | 48032     | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3421.10 | 145288    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3421.10 | 135056    | 14-Oct-21 | 11:30 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3421.10 | 152464    | 14-Oct-21 | 11:18 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3421.10 | 138640    | 14-Oct-21 | 11:30 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3421.10 | 96136     | 14-Oct-21 | 11:18 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3421.10 | 83336     | 14-Oct-21 | 11:30 | x86      |
| Msmgdsrv.dll                                               | 2017.140.249.83  | 7305096   | 14-Oct-21 | 11:30 | x86      |
| Oledbdest.dll                                              | 2017.140.3421.10 | 254368    | 14-Oct-21 | 11:18 | x64      |
| Oledbdest.dll                                              | 2017.140.3421.10 | 207752    | 14-Oct-21 | 11:30 | x86      |
| Oledbsrc.dll                                               | 2017.140.3421.10 | 281992    | 14-Oct-21 | 11:18 | x64      |
| Oledbsrc.dll                                               | 2017.140.3421.10 | 226184    | 14-Oct-21 | 11:30 | x86      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3421.10 | 93584     | 14-Oct-21 | 11:18 | x64      |
| Sqlresld.dll                                               | 2017.140.3421.10 | 23944     | 14-Oct-21 | 11:18 | x64      |
| Sqlresld.dll                                               | 2017.140.3421.10 | 21920     | 14-Oct-21 | 11:30 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3421.10 | 25480     | 14-Oct-21 | 11:18 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3421.10 | 22432     | 14-Oct-21 | 11:30 | x86      |
| Sqlscm.dll                                                 | 2017.140.3421.10 | 65936     | 14-Oct-21 | 11:18 | x64      |
| Sqlscm.dll                                                 | 2017.140.3421.10 | 55200     | 14-Oct-21 | 11:30 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3421.10 | 156064    | 14-Oct-21 | 11:18 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3421.10 | 128400    | 14-Oct-21 | 11:30 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3421.10 | 177032    | 14-Oct-21 | 11:18 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3421.10 | 148360    | 14-Oct-21 | 11:30 | x86      |
| Txdataconvert.dll                                          | 2017.140.3421.10 | 286080    | 14-Oct-21 | 11:18 | x64      |
| Txdataconvert.dll                                          | 2017.140.3421.10 | 246144    | 14-Oct-21 | 11:30 | x86      |
| Xe.dll                                                     | 2017.140.3421.10 | 666512    | 14-Oct-21 | 11:19 | x64      |
| Xe.dll                                                     | 2017.140.3421.10 | 588688    | 14-Oct-21 | 11:31 | x86      |
| Xmlrw.dll                                                  | 2017.140.3421.10 | 298384    | 14-Oct-21 | 11:19 | x64      |
| Xmlrw.dll                                                  | 2017.140.3421.10 | 250760    | 14-Oct-21 | 11:31 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3421.10 | 217488    | 14-Oct-21 | 11:19 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3421.10 | 182688    | 14-Oct-21 | 11:31 | x86      |

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

