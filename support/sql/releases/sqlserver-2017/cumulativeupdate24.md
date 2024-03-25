---
title: Cumulative update 24 for SQL Server 2017 (KB5001228)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 24 (KB5001228).
ms.date: 08/04/2023
ms.custom: KB5001228, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB5001228 - Cumulative Update 24 for SQL Server 2017

_Release Date:_ &nbsp; May 10, 2021  
_Version:_ &nbsp; 14.0.3391.2

## Summary

This article describes Cumulative Update package 24 (CU24) for Microsoft SQL Server 2017. This update contains 24 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 23, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3391.2**, file version: **2017.140.3391.2**
- Analysis Services - Product version: **14.0.249.71**, file version: **2017.140.249.71**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area| Component | Platform |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------------------------------------|----------|
| <a id=14021843>[14021843](#14021843) </a> | Fixes the unexpected error that causes the database to fail when deploying JSON script to replace existing database in SQL Server 2017. | Analysis services | Analysis Services | Windows |
| <a id=13746934>[13746934](#13746934) </a> | When a VSS backup tries to back up SQL Server databases that are hosted on the forwarder replica of a Distributed Availability Group, the backup operation fails. </br></br>his `BACKUP` or `RESTORE` command isn't supported on a database mirror or secondary replica. BACKUP DATABASE is terminating abnormally. </br></br>In the error log, you may see the following error: DateTime Backup Error: 3041, Severity: 16, State: 1. </br></br>\<DateTime> Backup BACKUP failed to complete the command BACKUP DATABASE DatabaseName. Check the backup application log for detailed messages. | SQL Server Engine | Backup Restore | Windows |
| <a id=14008523>[14008523](#14008523) </a> | After FIPS is enabled in Windows, you can't enable Managed Backup in SQL Server 2017. When trying to do so, the Application event log will record a 57054 error (from the "Microsoft SQL Server Automated Backup" source) with the following message: </br></br>[Warning] ManagedBackupBackupCertificateFailed: System.Exception: Failed to backup certificate and upload it to Azure storage. ---> System.Reflection.TargetInvocationException: Exception has been thrown by the target of an invocation. ---> System.InvalidOperationException: This implementation is not part of the Windows Platform FIPS validated cryptographic algorithms. | SQL Server Engine | Backup Restore | Windows |
| <a id=13959576>[13959576](#13959576) </a> | [FIX: Assert failure occurs when concurrent query modifies the same bitmap during clustered columnstore delete bitmap seek in SQL Server 2016 and 2017 (KB5000651)](https://support.microsoft.com/help/5000651) | SQL Server Engine | Column Stores | All |
| <a id=13959546>[13959546](#13959546) </a> | Fixes an access violation (AV) that occurs when error is being collected for Availability Group (AG) DB Failover while there's an AG failover undergoing. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=13707752>[13707752](#13707752) </a> | Disables FQDNs in AD usernames when creating or modifying SQL Logins/users for SQL Server 2019 on Linux. | SQL Server Engine | Linux | Linux |
| <a id=13913389>[13913389](#13913389) </a> | Fixes an error that occurs when you execute a query by using `sp_send_dbmail` inside a SQL Agent Job to send mails with attachments.| SQL Server Engine | Linux | Linux |
| <a id=14039036>[14039036](#14039036) </a> | [FIX: SqlLocalDB fails to start shared instances or you cannot connect to shared instances of SqlLocalDB in SQL Server 2017 (KB5003342)](https://support.microsoft.com/help/5003342) | SQL Server Engine | LocalDB | Windows |
| <a id=13703152>[13703152](#13703152) </a> | [FIX: Error 574 when you try to install Service Pack 2 for SQL Server 2017 (KB4023170)](https://support.microsoft.com/help/4023170) | SQL Server Engine | Management Services | Windows |
| <a id=13959573>[13959573](#13959573) </a> | Fixes an Access Violation error that occurs when importing large amount of data to Azure Blob storage. This can occur if PolyBase Data Movement Service encounters out-of-memory condition during large data insert transaction. | SQL Server Engine | Polybase | Windows |
| <a id=13959544>[13959544](#13959544) </a> | [FIX: MERGE statement fails with Access Violation at BTreeRow::DisableAccessReleaseOnWait in SQL Server (KB4589350)](https://support.microsoft.com/help/4589350) | SQL Server Engine | Query Execution | Windows |
| <a id=13959570>[13959570](#13959570) </a> | Fixes the performance issue that occurs with `CHANGETABLE` function and syscommit on SQL Server 2017. | SQL Server Engine | Query Optimizer | Windows |
| <a id=13982720>[13982720](#13982720) </a> | Fixes an issue where optimizer doesn't push down constant parameter to remote query via linked server.  | SQL Server Engine | Query Optimizer | All |
| <a id=13959562>[13959562](#13959562) </a> | [FIX: Failures with the log reader agent occur when you create and drop publication on CDC-enabled database in SQL Server 2019, 2017, and 2016 (KB5000715)](https://support.microsoft.com/help/5000715) | SQL Server Engine | Replication | Windows |
| <a id=13959542>[13959542](#13959542) </a> | Fixes an issue with the Foreign Key added to a table that is referencing a table's column that is part of a unique index with included columns. When the table's ALTER command is replicated, Distribution Agent fails with the following error message. </br></br>Number of referencing columns in foreign key differs from number of referenced columns, table 'TableName'. (Source: MSSQLServer, Error number: 8139) | SQL Server Engine | Replication | Windows |
| <a id=13992225>[13992225](#13992225) </a> | Fixes the `sp_hadr_verify_replication_publisher` displaying wrong distribution database name in error in SQL Server 2017.| SQL Server Engine |Replication| Windows|
| <a id=13959558>[13959558](#13959558) </a> | Fixes FullText query not returning the expected values that are located on the FullText index structure with AccentSensitivity turned on. | SQL Server Engine |Search | Windows |
| <a id=13959548>[13959548](#13959548) </a> | Fixes an Access Violation error that occurs at `sqllang!CStatement::SetDbIdMaskingUsageInfo+0x11` in SQL Server 2016.| SQL Server Engine | Security Infrastructure | Windows |
| <a id=13974723>[13974723](#13974723) </a> | [Improvement: Performance improvements of several spatial built-in properties and methods in SQL Server (KB5001260)](https://support.microsoft.com/help/5001260) | SQL Server Engine | Spatial | All |
| <a id=13990060>[13990060](#13990060) </a> | Fixed the memory release issue in execution of the STDistance spatial method while using spatial index. Before the fix, memory usage of `MEMORYCLERK_SOSNODE` gradually grew until all the memory available is taken. | SQL Server Engine | Spatial | Windows |
| <a id=13959556>[13959556](#13959556) </a> | Improves the records stage of failure and error during stack copy for better diagnostics. | SQL Server Engine | SQL OS | All |
| <a id=13981557>[13981557](#13981557) </a> | Fixes "Fast Fail" error that occurs when SQL Server 2017 on Linux creates core dumps and SQL Server not starting after applying the latest update.| SQL Server Engine | SQL OS | Linux |
| <a id=13970218>[13970218](#13970218) </a> | Fixes an issue where `DBCC PAGE` with option 3 generates access violation dumps after dropping a unique identifier column from the table in SQL Server 2017. </br></br>Msg 596, Level 21, State 1, Line \<LineNumber> </br>Cannot continue the execution because the session is in the kill state. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber>A severe error occurred on the current command. The results, if any, should be discarded.| SQL Server Engine | Storage Management| Windows |
| <a id=13966219>[13966219](#13966219) </a> | [FIX: Delete operation may fail with 7105 error in SQL Server 2017 (KB5001423)](https://support.microsoft.com/help/5001423) | SQL Server Engine | Temporal | Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2017 now](https://www.microsoft.com/download/details.aspx?id=56128)

If the download page does not appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU24 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2021/05/sqlserver2017-kb5001228-x64_8a043ccb15fa259eca0224f59364658300c138aa.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB5001228-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB5001228-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB5001228-x64.exe| 0E5A2CF526F9A034D3B03FEA2A31DA4016A5C492670C91A97D830BFB0345C4B5 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.71 | 259472    | 16-Apr-21 | 06:16 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.71     | 735136    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.71     | 1374112   | 16-Apr-21 | 06:16 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.71     | 977288    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.71     | 514976    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 16-Apr-21 | 06:00 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 16-Apr-21 | 06:12 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 16-Apr-21 | 06:12 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 16-Apr-21 | 06:12 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 16-Apr-21 | 06:12 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 16-Apr-21 | 06:12 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 16-Apr-21 | 06:12 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 16-Apr-21 | 06:12 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 16-Apr-21 | 06:12 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 16-Apr-21 | 06:12 | x86      |
| Msmdctr.dll                                        | 2017.140.249.71 | 33160     | 16-Apr-21 | 06:17 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.71 | 40420248  | 16-Apr-21 | 06:03 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.71 | 60765584  | 16-Apr-21 | 06:17 | x64      |
| Msmdpump.dll                                       | 2017.140.249.71 | 9332112   | 16-Apr-21 | 06:17 | x64      |
| Msmdredir.dll                                      | 2017.140.249.71 | 7088032   | 16-Apr-21 | 06:03 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.71 | 60665224  | 16-Apr-21 | 06:17 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.71 | 7304600   | 16-Apr-21 | 06:03 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.71 | 9000832   | 16-Apr-21 | 06:17 | x64      |
| Msolap.dll                                         | 2017.140.249.71 | 7773072   | 16-Apr-21 | 06:03 | x86      |
| Msolap.dll                                         | 2017.140.249.71 | 10256784  | 16-Apr-21 | 06:17 | x64      |
| Msolui.dll                                         | 2017.140.249.71 | 280448    | 16-Apr-21 | 06:03 | x86      |
| Msolui.dll                                         | 2017.140.249.71 | 304008    | 16-Apr-21 | 06:17 | x64      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 16-Apr-21 | 06:12 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 16-Apr-21 | 06:12 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlboot.dll                                        | 2017.140.3390.2 | 190864    | 16-Apr-21 | 06:18 | x64      |
| Sqlceip.exe                                        | 14.0.3390.2     | 255392    | 16-Apr-21 | 06:00 | x86      |
| Sqldumper.exe                                      | 2017.140.3390.2 | 138640    | 16-Apr-21 | 05:59 | x64      |
| Sqldumper.exe                                      | 2017.140.3390.2 | 116128    | 16-Apr-21 | 06:02 | x86      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 16-Apr-21 | 06:12 | x86      |
| Tmapi.dll                                          | 2017.140.249.71 | 5814672   | 16-Apr-21 | 06:18 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.71 | 4157840   | 16-Apr-21 | 06:18 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.71 | 1125280   | 16-Apr-21 | 06:18 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.71 | 1635728   | 16-Apr-21 | 06:18 | x64      |
| Xe.dll                                             | 2017.140.3390.2 | 666512    | 16-Apr-21 | 06:18 | x64      |
| Xmlrw.dll                                          | 2017.140.3390.2 | 250776    | 16-Apr-21 | 06:03 | x86      |
| Xmlrw.dll                                          | 2017.140.3390.2 | 298376    | 16-Apr-21 | 06:18 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3390.2 | 182672    | 16-Apr-21 | 06:03 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3390.2 | 217472    | 16-Apr-21 | 06:18 | x64      |
| Xmsrv.dll                                          | 2017.140.249.71 | 33349536  | 16-Apr-21 | 06:03 | x86      |
| Xmsrv.dll                                          | 2017.140.249.71 | 25375640  | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time | Platform |
|--------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                            | 2017.140.3390.2  | 153488    | 16-Apr-21 | 06:01 | x86      |
| Batchparser.dll                            | 2017.140.3390.2  | 173984    | 16-Apr-21 | 06:16 | x64      |
| Instapi140.dll                             | 2017.140.3390.2  | 55696     | 16-Apr-21 | 06:03 | x86      |
| Instapi140.dll                             | 2017.140.3390.2  | 65408     | 16-Apr-21 | 06:17 | x64      |
| Isacctchange.dll                           | 2017.140.3390.2  | 22408     | 16-Apr-21 | 06:01 | x86      |
| Isacctchange.dll                           | 2017.140.3390.2  | 23952     | 16-Apr-21 | 06:16 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.71      | 1081744   | 16-Apr-21 | 06:01 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.71      | 1081752   | 16-Apr-21 | 06:16 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.71      | 1374624   | 16-Apr-21 | 06:01 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.71      | 734608    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.71      | 734616    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3390.2      | 30616     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3390.2  | 71560     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3390.2  | 75144     | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3390.2      | 564624    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3390.2      | 564640    | 16-Apr-21 | 06:17 | x86      |
| Msasxpress.dll                             | 2017.140.249.71  | 24984     | 16-Apr-21 | 06:03 | x86      |
| Msasxpress.dll                             | 2017.140.249.71  | 29072     | 16-Apr-21 | 06:17 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3390.2  | 62368     | 16-Apr-21 | 06:03 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3390.2  | 77192     | 16-Apr-21 | 06:18 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3390.2  | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqldumper.exe                              | 2017.140.3390.2  | 138640    | 16-Apr-21 | 05:59 | x64      |
| Sqldumper.exe                              | 2017.140.3390.2  | 116128    | 16-Apr-21 | 06:02 | x86      |
| Sqlftacct.dll                              | 2017.140.3390.2  | 49032     | 16-Apr-21 | 06:03 | x86      |
| Sqlftacct.dll                              | 2017.140.3390.2  | 57224     | 16-Apr-21 | 06:18 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 16-Apr-21 | 06:02 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 16-Apr-21 | 06:17 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3390.2  | 368520    | 16-Apr-21 | 06:02 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3390.2  | 413064    | 16-Apr-21 | 06:17 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3390.2  | 28040     | 16-Apr-21 | 06:03 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3390.2  | 30608     | 16-Apr-21 | 06:18 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3390.2  | 267144    | 16-Apr-21 | 06:03 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3390.2  | 351120    | 16-Apr-21 | 06:18 | x64      |
| Sqltdiagn.dll                              | 2017.140.3390.2  | 53656     | 16-Apr-21 | 06:02 | x86      |
| Sqltdiagn.dll                              | 2017.140.3390.2  | 60832     | 16-Apr-21 | 06:17 | x64      |
| Svrenumapi140.dll                          | 2017.140.3390.2  | 888224    | 16-Apr-21 | 06:03 | x86      |
| Svrenumapi140.dll                          | 2017.140.3390.2  | 1167776   | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 16-Apr-21 | 06:03 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 16-Apr-21 | 06:03 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 16-Apr-21 | 06:03 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 16-Apr-21 | 06:03 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 16-Apr-21 | 06:16 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3390.2 | 114064    | 16-Apr-21 | 06:01 | x86      |
| Dreplaycommon.dll              | 2017.140.3390.2 | 693120    | 16-Apr-21 | 06:01 | x86      |
| Dreplayserverps.dll            | 2017.140.3390.2 | 26008     | 16-Apr-21 | 06:01 | x86      |
| Dreplayutil.dll                | 2017.140.3390.2 | 302992    | 16-Apr-21 | 06:01 | x86      |
| Instapi140.dll                 | 2017.140.3390.2 | 65408     | 16-Apr-21 | 06:17 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlresourceloader.dll          | 2017.140.3390.2 | 22408     | 16-Apr-21 | 06:02 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3390.2 | 693120    | 16-Apr-21 | 06:01 | x86      |
| Dreplaycontroller.exe              | 2017.140.3390.2 | 343448    | 16-Apr-21 | 06:01 | x86      |
| Dreplayprocess.dll                 | 2017.140.3390.2 | 164752    | 16-Apr-21 | 06:01 | x86      |
| Dreplayserverps.dll                | 2017.140.3390.2 | 26008     | 16-Apr-21 | 06:01 | x86      |
| Instapi140.dll                     | 2017.140.3390.2 | 65408     | 16-Apr-21 | 06:17 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlresourceloader.dll              | 2017.140.3390.2 | 22408     | 16-Apr-21 | 06:02 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Backuptourl.exe                              | 14.0.3390.2     | 33680     | 16-Apr-21 | 06:16 | x64      |
| Batchparser.dll                              | 2017.140.3390.2 | 173984    | 16-Apr-21 | 06:16 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 16-Apr-21 | 06:13 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 16-Apr-21 | 06:13 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 16-Apr-21 | 06:13 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 16-Apr-21 | 06:11 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 16-Apr-21 | 06:16 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3390.2 | 220560    | 16-Apr-21 | 06:16 | x64      |
| Dcexec.exe                                   | 2017.140.3390.2 | 67464     | 16-Apr-21 | 06:16 | x64      |
| Fssres.dll                                   | 2017.140.3390.2 | 83856     | 16-Apr-21 | 06:17 | x64      |
| Hadrres.dll                                  | 2017.140.3390.2 | 182688    | 16-Apr-21 | 06:17 | x64      |
| Hkcompile.dll                                | 2017.140.3390.2 | 1416096   | 16-Apr-21 | 06:17 | x64      |
| Hkengine.dll                                 | 2017.140.3390.2 | 5853584   | 16-Apr-21 | 06:17 | x64      |
| Hkruntime.dll                                | 2017.140.3390.2 | 156048    | 16-Apr-21 | 06:17 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 16-Apr-21 | 06:13 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.71     | 734112    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 16-Apr-21 | 06:00 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3390.2     | 231832    | 16-Apr-21 | 06:16 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3390.2     | 73104     | 16-Apr-21 | 06:16 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3390.2 | 385944    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3390.2 | 65424     | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3390.2 | 58256     | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3390.2 | 145312    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3390.2 | 152464    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3390.2 | 296848    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3390.2 | 67984     | 16-Apr-21 | 06:17 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 16-Apr-21 | 06:13 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 16-Apr-21 | 06:13 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 16-Apr-21 | 06:13 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 16-Apr-21 | 06:13 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 16-Apr-21 | 06:13 | x64      |
| Odsole70.dll                                 | 2017.140.3390.2 | 85920     | 16-Apr-21 | 06:17 | x64      |
| Opends60.dll                                 | 2017.140.3390.2 | 26008     | 16-Apr-21 | 06:17 | x64      |
| Qds.dll                                      | 2017.140.3390.2 | 1176968   | 16-Apr-21 | 06:18 | x64      |
| Rsfxft.dll                                   | 2017.140.3390.2 | 27528     | 16-Apr-21 | 06:17 | x64      |
| Secforwarder.dll                             | 2017.140.3390.2 | 30600     | 16-Apr-21 | 06:18 | x64      |
| Sqagtres.dll                                 | 2017.140.3390.2 | 69016     | 16-Apr-21 | 06:18 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlaamss.dll                                 | 2017.140.3390.2 | 84896     | 16-Apr-21 | 06:17 | x64      |
| Sqlaccess.dll                                | 2017.140.3390.2 | 468872    | 16-Apr-21 | 06:18 | x64      |
| Sqlagent.exe                                 | 2017.140.3390.2 | 598432    | 16-Apr-21 | 06:17 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3390.2 | 47504     | 16-Apr-21 | 06:02 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3390.2 | 56200     | 16-Apr-21 | 06:17 | x64      |
| Sqlagentlog.dll                              | 2017.140.3390.2 | 26016     | 16-Apr-21 | 06:17 | x64      |
| Sqlagentmail.dll                             | 2017.140.3390.2 | 47008     | 16-Apr-21 | 06:17 | x64      |
| Sqlboot.dll                                  | 2017.140.3390.2 | 190864    | 16-Apr-21 | 06:18 | x64      |
| Sqlceip.exe                                  | 14.0.3390.2     | 255392    | 16-Apr-21 | 06:00 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3390.2 | 67464     | 16-Apr-21 | 06:17 | x64      |
| Sqlctr140.dll                                | 2017.140.3390.2 | 106400    | 16-Apr-21 | 06:03 | x86      |
| Sqlctr140.dll                                | 2017.140.3390.2 | 123808    | 16-Apr-21 | 06:18 | x64      |
| Sqldk.dll                                    | 2017.140.3390.2 | 2800512   | 16-Apr-21 | 06:17 | x64      |
| Sqldtsss.dll                                 | 2017.140.3390.2 | 102288    | 16-Apr-21 | 06:17 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3779976   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3917704   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3588488   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3787144   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3402120   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3820936   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 2033544   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3914632   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3596168   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3337608   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 2087304   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3366792   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3296648   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 1441680   | 16-Apr-21 | 06:01 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3635592   | 16-Apr-21 | 06:07 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3212680   | 16-Apr-21 | 06:10 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3677064   | 16-Apr-21 | 06:12 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 1494408   | 16-Apr-21 | 06:12 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3785096   | 16-Apr-21 | 06:13 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3290504   | 16-Apr-21 | 06:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 3480968   | 16-Apr-21 | 06:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3390.2 | 4027776   | 16-Apr-21 | 06:15 | x64      |
| Sqliosim.com                                 | 2017.140.3390.2 | 306584    | 16-Apr-21 | 06:18 | x64      |
| Sqliosim.exe                                 | 2017.140.3390.2 | 3013008   | 16-Apr-21 | 06:18 | x64      |
| Sqllang.dll                                  | 2017.140.3390.2 | 41406368  | 16-Apr-21 | 06:18 | x64      |
| Sqlmin.dll                                   | 2017.140.3390.2 | 40554904  | 16-Apr-21 | 06:18 | x64      |
| Sqlolapss.dll                                | 2017.140.3390.2 | 102280    | 16-Apr-21 | 06:17 | x64      |
| Sqlos.dll                                    | 2017.140.3390.2 | 19336     | 16-Apr-21 | 06:17 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3390.2 | 62848     | 16-Apr-21 | 06:17 | x64      |
| Sqlrepss.dll                                 | 2017.140.3390.2 | 61840     | 16-Apr-21 | 06:17 | x64      |
| Sqlresld.dll                                 | 2017.140.3390.2 | 23944     | 16-Apr-21 | 06:17 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3390.2 | 25504     | 16-Apr-21 | 06:17 | x64      |
| Sqlscm.dll                                   | 2017.140.3390.2 | 65944     | 16-Apr-21 | 06:17 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3390.2 | 20896     | 16-Apr-21 | 06:18 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3390.2 | 5890440   | 16-Apr-21 | 06:18 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3390.2 | 725920    | 16-Apr-21 | 06:17 | x64      |
| Sqlservr.exe                                 | 2017.140.3390.2 | 481680    | 16-Apr-21 | 06:18 | x64      |
| Sqlsvc.dll                                   | 2017.140.3390.2 | 156048    | 16-Apr-21 | 06:17 | x64      |
| Sqltses.dll                                  | 2017.140.3390.2 | 9559432   | 16-Apr-21 | 06:17 | x64      |
| Sqsrvres.dll                                 | 2017.140.3390.2 | 255888    | 16-Apr-21 | 06:18 | x64      |
| Svl.dll                                      | 2017.140.3390.2 | 146824    | 16-Apr-21 | 06:18 | x64      |
| Xe.dll                                       | 2017.140.3390.2 | 666512    | 16-Apr-21 | 06:18 | x64      |
| Xmlrw.dll                                    | 2017.140.3390.2 | 298376    | 16-Apr-21 | 06:18 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3390.2 | 217472    | 16-Apr-21 | 06:18 | x64      |
| Xpadsi.exe                                   | 2017.140.3390.2 | 84872     | 16-Apr-21 | 06:17 | x64      |
| Xplog70.dll                                  | 2017.140.3390.2 | 71056     | 16-Apr-21 | 06:18 | x64      |
| Xpqueue.dll                                  | 2017.140.3390.2 | 67976     | 16-Apr-21 | 06:18 | x64      |
| Xprepl.dll                                   | 2017.140.3390.2 | 96648     | 16-Apr-21 | 06:18 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3390.2 | 25480     | 16-Apr-21 | 06:18 | x64      |
| Xpstar.dll                                   | 2017.140.3390.2 | 445344    | 16-Apr-21 | 06:17 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3390.2 | 153488    | 16-Apr-21 | 06:01 | x86      |
| Batchparser.dll                                             | 2017.140.3390.2 | 173984    | 16-Apr-21 | 06:16 | x64      |
| Bcp.exe                                                     | 2017.140.3390.2 | 113032    | 16-Apr-21 | 06:17 | x64      |
| Commanddest.dll                                             | 2017.140.3390.2 | 238976    | 16-Apr-21 | 06:16 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3390.2 | 109448    | 16-Apr-21 | 06:16 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3390.2 | 180632    | 16-Apr-21 | 06:16 | x64      |
| Distrib.exe                                                 | 2017.140.3390.2 | 198024    | 16-Apr-21 | 06:17 | x64      |
| Dteparse.dll                                                | 2017.140.3390.2 | 104344    | 16-Apr-21 | 06:16 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3390.2 | 82304     | 16-Apr-21 | 06:16 | x64      |
| Dtepkg.dll                                                  | 2017.140.3390.2 | 130960    | 16-Apr-21 | 06:16 | x64      |
| Dtexec.exe                                                  | 2017.140.3390.2 | 66952     | 16-Apr-21 | 06:16 | x64      |
| Dts.dll                                                     | 2017.140.3390.2 | 2994064   | 16-Apr-21 | 06:16 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3390.2 | 468376    | 16-Apr-21 | 06:16 | x64      |
| Dtsconn.dll                                                 | 2017.140.3390.2 | 493464    | 16-Apr-21 | 06:16 | x64      |
| Dtshost.exe                                                 | 2017.140.3390.2 | 99224     | 16-Apr-21 | 06:17 | x64      |
| Dtslog.dll                                                  | 2017.140.3390.2 | 113568    | 16-Apr-21 | 06:16 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3390.2 | 538528    | 16-Apr-21 | 06:17 | x64      |
| Dtspipeline.dll                                             | 2017.140.3390.2 | 1261456   | 16-Apr-21 | 06:16 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3390.2 | 41360     | 16-Apr-21 | 06:16 | x64      |
| Dtuparse.dll                                                | 2017.140.3390.2 | 82336     | 16-Apr-21 | 06:16 | x64      |
| Dtutil.exe                                                  | 2017.140.3390.2 | 141728    | 16-Apr-21 | 06:16 | x64      |
| Exceldest.dll                                               | 2017.140.3390.2 | 253856    | 16-Apr-21 | 06:16 | x64      |
| Excelsrc.dll                                                | 2017.140.3390.2 | 275864    | 16-Apr-21 | 06:16 | x64      |
| Execpackagetask.dll                                         | 2017.140.3390.2 | 161184    | 16-Apr-21 | 06:16 | x64      |
| Flatfiledest.dll                                            | 2017.140.3390.2 | 379808    | 16-Apr-21 | 06:16 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3390.2 | 392608    | 16-Apr-21 | 06:16 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3390.2 | 89488     | 16-Apr-21 | 06:16 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3390.2 | 52624     | 16-Apr-21 | 06:17 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 16-Apr-21 | 06:01 | x86      |
| Logread.exe                                                 | 2017.140.3390.2 | 629648    | 16-Apr-21 | 06:17 | x64      |
| Mergetxt.dll                                                | 2017.140.3390.2 | 58272     | 16-Apr-21 | 06:17 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.71     | 1375112   | 16-Apr-21 | 06:16 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 16-Apr-21 | 06:01 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3390.2     | 130952    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3390.2     | 48520     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3390.2     | 82824     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3390.2     | 66456     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3390.2     | 385424    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3390.2     | 607616    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3390.2 | 1657744   | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3390.2     | 564624    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3390.2 | 145312    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3390.2 | 152464    | 16-Apr-21 | 06:17 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3390.2 | 96160     | 16-Apr-21 | 06:16 | x64      |
| Msgprox.dll                                                 | 2017.140.3390.2 | 265104    | 16-Apr-21 | 06:17 | x64      |
| Msxmlsql.dll                                                | 2017.140.3390.2 | 1441160   | 16-Apr-21 | 06:17 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 16-Apr-21 | 06:01 | x86      |
| Oledbdest.dll                                               | 2017.140.3390.2 | 254360    | 16-Apr-21 | 06:16 | x64      |
| Oledbsrc.dll                                                | 2017.140.3390.2 | 281992    | 16-Apr-21 | 06:16 | x64      |
| Osql.exe                                                    | 2017.140.3390.2 | 68496     | 16-Apr-21 | 06:16 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3390.2 | 468872    | 16-Apr-21 | 06:18 | x64      |
| Rawdest.dll                                                 | 2017.140.3390.2 | 199584    | 16-Apr-21 | 06:17 | x64      |
| Rawsource.dll                                               | 2017.140.3390.2 | 187296    | 16-Apr-21 | 06:17 | x64      |
| Rdistcom.dll                                                | 2017.140.3390.2 | 852360    | 16-Apr-21 | 06:18 | x64      |
| Recordsetdest.dll                                           | 2017.140.3390.2 | 177536    | 16-Apr-21 | 06:17 | x64      |
| Replagnt.dll                                                | 2017.140.3390.2 | 23968     | 16-Apr-21 | 06:18 | x64      |
| Repldp.dll                                                  | 2017.140.3390.2 | 285568    | 16-Apr-21 | 06:18 | x64      |
| Replerrx.dll                                                | 2017.140.3390.2 | 148896    | 16-Apr-21 | 06:18 | x64      |
| Replisapi.dll                                               | 2017.140.3390.2 | 357280    | 16-Apr-21 | 06:18 | x64      |
| Replmerg.exe                                                | 2017.140.3390.2 | 520088    | 16-Apr-21 | 06:18 | x64      |
| Replprov.dll                                                | 2017.140.3390.2 | 797072    | 16-Apr-21 | 06:18 | x64      |
| Replrec.dll                                                 | 2017.140.3390.2 | 972688    | 16-Apr-21 | 06:18 | x64      |
| Replsub.dll                                                 | 2017.140.3390.2 | 440224    | 16-Apr-21 | 06:18 | x64      |
| Replsync.dll                                                | 2017.140.3390.2 | 148352    | 16-Apr-21 | 06:18 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 16-Apr-21 | 06:18 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 16-Apr-21 | 06:18 | x64      |
| Spresolv.dll                                                | 2017.140.3390.2 | 247192    | 16-Apr-21 | 06:18 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3390.2 | 242072    | 16-Apr-21 | 06:18 | x64      |
| Sqldiag.exe                                                 | 2017.140.3390.2 | 1254800   | 16-Apr-21 | 06:18 | x64      |
| Sqldistx.dll                                                | 2017.140.3390.2 | 219520    | 16-Apr-21 | 06:18 | x64      |
| Sqllogship.exe                                              | 14.0.3390.2     | 99216     | 16-Apr-21 | 06:17 | x64      |
| Sqlmergx.dll                                                | 2017.140.3390.2 | 355216    | 16-Apr-21 | 06:18 | x64      |
| Sqlresld.dll                                                | 2017.140.3390.2 | 21904     | 16-Apr-21 | 06:02 | x86      |
| Sqlresld.dll                                                | 2017.140.3390.2 | 23944     | 16-Apr-21 | 06:17 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3390.2 | 22408     | 16-Apr-21 | 06:02 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3390.2 | 25504     | 16-Apr-21 | 06:17 | x64      |
| Sqlscm.dll                                                  | 2017.140.3390.2 | 55184     | 16-Apr-21 | 06:02 | x86      |
| Sqlscm.dll                                                  | 2017.140.3390.2 | 65944     | 16-Apr-21 | 06:17 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3390.2 | 128400    | 16-Apr-21 | 06:02 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3390.2 | 156048    | 16-Apr-21 | 06:17 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3390.2 | 177032    | 16-Apr-21 | 06:17 | x64      |
| Sqlwep140.dll                                               | 2017.140.3390.2 | 98696     | 16-Apr-21 | 06:18 | x64      |
| Ssdebugps.dll                                               | 2017.140.3390.2 | 26512     | 16-Apr-21 | 06:18 | x64      |
| Ssisoledb.dll                                               | 2017.140.3390.2 | 209296    | 16-Apr-21 | 06:17 | x64      |
| Ssradd.dll                                                  | 2017.140.3390.2 | 70032     | 16-Apr-21 | 06:18 | x64      |
| Ssravg.dll                                                  | 2017.140.3390.2 | 70560     | 16-Apr-21 | 06:18 | x64      |
| Ssrdown.dll                                                 | 2017.140.3390.2 | 55184     | 16-Apr-21 | 06:18 | x64      |
| Ssrmax.dll                                                  | 2017.140.3390.2 | 68496     | 16-Apr-21 | 06:18 | x64      |
| Ssrmin.dll                                                  | 2017.140.3390.2 | 68496     | 16-Apr-21 | 06:18 | x64      |
| Ssrpub.dll                                                  | 2017.140.3390.2 | 55696     | 16-Apr-21 | 06:18 | x64      |
| Ssrup.dll                                                   | 2017.140.3390.2 | 55200     | 16-Apr-21 | 06:18 | x64      |
| Tablediff.exe                                               | 14.0.3390.2     | 79752     | 16-Apr-21 | 06:18 | x64      |
| Txagg.dll                                                   | 2017.140.3390.2 | 355224    | 16-Apr-21 | 06:17 | x64      |
| Txbdd.dll                                                   | 2017.140.3390.2 | 163216    | 16-Apr-21 | 06:17 | x64      |
| Txdatacollector.dll                                         | 2017.140.3390.2 | 353696    | 16-Apr-21 | 06:17 | x64      |
| Txdataconvert.dll                                           | 2017.140.3390.2 | 286104    | 16-Apr-21 | 06:17 | x64      |
| Txderived.dll                                               | 2017.140.3390.2 | 597392    | 16-Apr-21 | 06:17 | x64      |
| Txlookup.dll                                                | 2017.140.3390.2 | 521112    | 16-Apr-21 | 06:17 | x64      |
| Txmerge.dll                                                 | 2017.140.3390.2 | 223128    | 16-Apr-21 | 06:17 | x64      |
| Txmergejoin.dll                                             | 2017.140.3390.2 | 268672    | 16-Apr-21 | 06:17 | x64      |
| Txmulticast.dll                                             | 2017.140.3390.2 | 120736    | 16-Apr-21 | 06:17 | x64      |
| Txrowcount.dll                                              | 2017.140.3390.2 | 118688    | 16-Apr-21 | 06:17 | x64      |
| Txsort.dll                                                  | 2017.140.3390.2 | 249760    | 16-Apr-21 | 06:17 | x64      |
| Txsplit.dll                                                 | 2017.140.3390.2 | 589712    | 16-Apr-21 | 06:17 | x64      |
| Txunionall.dll                                              | 2017.140.3390.2 | 175008    | 16-Apr-21 | 06:17 | x64      |
| Xe.dll                                                      | 2017.140.3390.2 | 666512    | 16-Apr-21 | 06:18 | x64      |
| Xmlrw.dll                                                   | 2017.140.3390.2 | 298376    | 16-Apr-21 | 06:18 | x64      |
| Xmlsub.dll                                                  | 2017.140.3390.2 | 255376    | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3390.2 | 1120144   | 16-Apr-21 | 06:17 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlsatellite.dll              | 2017.140.3390.2 | 916880    | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3390.2 | 665504    | 16-Apr-21 | 06:17 | x64      |
| Fdhost.exe               | 2017.140.3390.2 | 109448    | 16-Apr-21 | 06:17 | x64      |
| Fdlauncher.exe           | 2017.140.3390.2 | 57248     | 16-Apr-21 | 06:17 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 16-Apr-21 | 06:17 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlft140ph.dll           | 2017.140.3390.2 | 62864     | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3390.2     | 17296     | 16-Apr-21 | 06:16 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-Apr-21 | 06:01 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 16-Apr-21 | 06:16 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-Apr-21 | 06:01 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 16-Apr-21 | 06:16 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-Apr-21 | 06:01 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 16-Apr-21 | 06:16 | x86      |
| Commanddest.dll                                               | 2017.140.3390.2 | 193928    | 16-Apr-21 | 06:01 | x86      |
| Commanddest.dll                                               | 2017.140.3390.2 | 238976    | 16-Apr-21 | 06:16 | x64      |
| Dteparse.dll                                                  | 2017.140.3390.2 | 93600     | 16-Apr-21 | 06:01 | x86      |
| Dteparse.dll                                                  | 2017.140.3390.2 | 104344    | 16-Apr-21 | 06:16 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3390.2 | 76688     | 16-Apr-21 | 06:01 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3390.2 | 82304     | 16-Apr-21 | 06:16 | x64      |
| Dtepkg.dll                                                    | 2017.140.3390.2 | 109968    | 16-Apr-21 | 06:01 | x86      |
| Dtepkg.dll                                                    | 2017.140.3390.2 | 130960    | 16-Apr-21 | 06:16 | x64      |
| Dtexec.exe                                                    | 2017.140.3390.2 | 60816     | 16-Apr-21 | 06:01 | x86      |
| Dtexec.exe                                                    | 2017.140.3390.2 | 66952     | 16-Apr-21 | 06:16 | x64      |
| Dts.dll                                                       | 2017.140.3390.2 | 2544008   | 16-Apr-21 | 06:01 | x86      |
| Dts.dll                                                       | 2017.140.3390.2 | 2994064   | 16-Apr-21 | 06:16 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3390.2 | 411016    | 16-Apr-21 | 06:01 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3390.2 | 468376    | 16-Apr-21 | 06:16 | x64      |
| Dtsconn.dll                                                   | 2017.140.3390.2 | 395664    | 16-Apr-21 | 06:01 | x86      |
| Dtsconn.dll                                                   | 2017.140.3390.2 | 493464    | 16-Apr-21 | 06:16 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3390.2 | 88480     | 16-Apr-21 | 06:01 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3390.2 | 104328    | 16-Apr-21 | 06:16 | x64      |
| Dtshost.exe                                                   | 2017.140.3390.2 | 84384     | 16-Apr-21 | 06:03 | x86      |
| Dtshost.exe                                                   | 2017.140.3390.2 | 99224     | 16-Apr-21 | 06:17 | x64      |
| Dtslog.dll                                                    | 2017.140.3390.2 | 96128     | 16-Apr-21 | 06:01 | x86      |
| Dtslog.dll                                                    | 2017.140.3390.2 | 113568    | 16-Apr-21 | 06:16 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3390.2 | 534416    | 16-Apr-21 | 06:03 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3390.2 | 538528    | 16-Apr-21 | 06:17 | x64      |
| Dtspipeline.dll                                               | 2017.140.3390.2 | 1053592   | 16-Apr-21 | 06:01 | x86      |
| Dtspipeline.dll                                               | 2017.140.3390.2 | 1261456   | 16-Apr-21 | 06:16 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3390.2 | 35744     | 16-Apr-21 | 06:01 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3390.2 | 41360     | 16-Apr-21 | 06:16 | x64      |
| Dtuparse.dll                                                  | 2017.140.3390.2 | 73112     | 16-Apr-21 | 06:01 | x86      |
| Dtuparse.dll                                                  | 2017.140.3390.2 | 82336     | 16-Apr-21 | 06:16 | x64      |
| Dtutil.exe                                                    | 2017.140.3390.2 | 120720    | 16-Apr-21 | 06:01 | x86      |
| Dtutil.exe                                                    | 2017.140.3390.2 | 141728    | 16-Apr-21 | 06:16 | x64      |
| Exceldest.dll                                                 | 2017.140.3390.2 | 207776    | 16-Apr-21 | 06:01 | x86      |
| Exceldest.dll                                                 | 2017.140.3390.2 | 253856    | 16-Apr-21 | 06:16 | x64      |
| Excelsrc.dll                                                  | 2017.140.3390.2 | 223624    | 16-Apr-21 | 06:01 | x86      |
| Excelsrc.dll                                                  | 2017.140.3390.2 | 275864    | 16-Apr-21 | 06:16 | x64      |
| Execpackagetask.dll                                           | 2017.140.3390.2 | 128392    | 16-Apr-21 | 06:01 | x86      |
| Execpackagetask.dll                                           | 2017.140.3390.2 | 161184    | 16-Apr-21 | 06:16 | x64      |
| Flatfiledest.dll                                              | 2017.140.3390.2 | 325536    | 16-Apr-21 | 06:01 | x86      |
| Flatfiledest.dll                                              | 2017.140.3390.2 | 379808    | 16-Apr-21 | 06:16 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3390.2 | 337296    | 16-Apr-21 | 06:01 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3390.2 | 392608    | 16-Apr-21 | 06:16 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3390.2 | 73632     | 16-Apr-21 | 06:01 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3390.2 | 89488     | 16-Apr-21 | 06:16 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-Apr-21 | 06:01 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 16-Apr-21 | 06:03 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3390.2     | 460176    | 16-Apr-21 | 06:01 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3390.2     | 459664    | 16-Apr-21 | 06:16 | x64      |
| Isserverexec.exe                                              | 14.0.3390.2     | 142224    | 16-Apr-21 | 06:01 | x86      |
| Isserverexec.exe                                              | 14.0.3390.2     | 141712    | 16-Apr-21 | 06:16 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.71     | 1375136   | 16-Apr-21 | 06:01 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.71     | 1375112   | 16-Apr-21 | 06:16 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 16-Apr-21 | 06:00 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-Apr-21 | 06:01 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 16-Apr-21 | 06:03 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3390.2     | 67464     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3390.2 | 100240    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3390.2 | 105352    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3390.2     | 48544     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3390.2     | 48520     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3390.2     | 82832     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3390.2     | 82824     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3390.2     | 66448     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3390.2     | 66456     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3390.2     | 507792    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3390.2     | 507784    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3390.2     | 76688     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3390.2     | 76688     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3390.2     | 408960    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3390.2     | 408984    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3390.2     | 385424    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3390.2     | 607648    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3390.2     | 607616    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3390.2     | 246176    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3390.2     | 246160    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3390.2     | 48024     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 14.0.3390.2     | 48008     | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3390.2 | 135056    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3390.2 | 145312    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3390.2 | 138656    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3390.2 | 152464    | 16-Apr-21 | 06:17 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3390.2     | 212872    | 16-Apr-21 | 06:17 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3390.2 | 83360     | 16-Apr-21 | 06:01 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3390.2 | 96160     | 16-Apr-21 | 06:16 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.71 | 9191824   | 16-Apr-21 | 06:17 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-Apr-21 | 05:58 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 16-Apr-21 | 06:00 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-Apr-21 | 06:01 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 16-Apr-21 | 06:03 | x86      |
| Oledbdest.dll                                                 | 2017.140.3390.2 | 207744    | 16-Apr-21 | 06:01 | x86      |
| Oledbdest.dll                                                 | 2017.140.3390.2 | 254360    | 16-Apr-21 | 06:16 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3390.2 | 226208    | 16-Apr-21 | 06:01 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3390.2 | 281992    | 16-Apr-21 | 06:16 | x64      |
| Rawdest.dll                                                   | 2017.140.3390.2 | 159640    | 16-Apr-21 | 06:02 | x86      |
| Rawdest.dll                                                   | 2017.140.3390.2 | 199584    | 16-Apr-21 | 06:17 | x64      |
| Rawsource.dll                                                 | 2017.140.3390.2 | 146304    | 16-Apr-21 | 06:02 | x86      |
| Rawsource.dll                                                 | 2017.140.3390.2 | 187296    | 16-Apr-21 | 06:17 | x64      |
| Recordsetdest.dll                                             | 2017.140.3390.2 | 142216    | 16-Apr-21 | 06:02 | x86      |
| Recordsetdest.dll                                             | 2017.140.3390.2 | 177536    | 16-Apr-21 | 06:17 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlceip.exe                                                   | 14.0.3390.2     | 255392    | 16-Apr-21 | 06:00 | x86      |
| Sqldest.dll                                                   | 2017.140.3390.2 | 206752    | 16-Apr-21 | 06:02 | x86      |
| Sqldest.dll                                                   | 2017.140.3390.2 | 253856    | 16-Apr-21 | 06:17 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3390.2 | 148360    | 16-Apr-21 | 06:02 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3390.2 | 177032    | 16-Apr-21 | 06:17 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3390.2 | 169872    | 16-Apr-21 | 06:02 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3390.2 | 209296    | 16-Apr-21 | 06:17 | x64      |
| Txagg.dll                                                     | 2017.140.3390.2 | 295312    | 16-Apr-21 | 06:02 | x86      |
| Txagg.dll                                                     | 2017.140.3390.2 | 355224    | 16-Apr-21 | 06:17 | x64      |
| Txbdd.dll                                                     | 2017.140.3390.2 | 129408    | 16-Apr-21 | 06:02 | x86      |
| Txbdd.dll                                                     | 2017.140.3390.2 | 163216    | 16-Apr-21 | 06:17 | x64      |
| Txbestmatch.dll                                               | 2017.140.3390.2 | 486304    | 16-Apr-21 | 06:02 | x86      |
| Txbestmatch.dll                                               | 2017.140.3390.2 | 598408    | 16-Apr-21 | 06:17 | x64      |
| Txcache.dll                                                   | 2017.140.3390.2 | 139168    | 16-Apr-21 | 06:02 | x86      |
| Txcache.dll                                                   | 2017.140.3390.2 | 173472    | 16-Apr-21 | 06:17 | x64      |
| Txcharmap.dll                                                 | 2017.140.3390.2 | 242080    | 16-Apr-21 | 06:02 | x86      |
| Txcharmap.dll                                                 | 2017.140.3390.2 | 279960    | 16-Apr-21 | 06:17 | x64      |
| Txcopymap.dll                                                 | 2017.140.3390.2 | 138640    | 16-Apr-21 | 06:02 | x86      |
| Txcopymap.dll                                                 | 2017.140.3390.2 | 173472    | 16-Apr-21 | 06:17 | x64      |
| Txdataconvert.dll                                             | 2017.140.3390.2 | 246168    | 16-Apr-21 | 06:02 | x86      |
| Txdataconvert.dll                                             | 2017.140.3390.2 | 286104    | 16-Apr-21 | 06:17 | x64      |
| Txderived.dll                                                 | 2017.140.3390.2 | 508808    | 16-Apr-21 | 06:02 | x86      |
| Txderived.dll                                                 | 2017.140.3390.2 | 597392    | 16-Apr-21 | 06:17 | x64      |
| Txfileextractor.dll                                           | 2017.140.3390.2 | 154000    | 16-Apr-21 | 06:02 | x86      |
| Txfileextractor.dll                                           | 2017.140.3390.2 | 191904    | 16-Apr-21 | 06:17 | x64      |
| Txfileinserter.dll                                            | 2017.140.3390.2 | 152480    | 16-Apr-21 | 06:02 | x86      |
| Txfileinserter.dll                                            | 2017.140.3390.2 | 189848    | 16-Apr-21 | 06:17 | x64      |
| Txgroupdups.dll                                               | 2017.140.3390.2 | 224160    | 16-Apr-21 | 06:02 | x86      |
| Txgroupdups.dll                                               | 2017.140.3390.2 | 283520    | 16-Apr-21 | 06:17 | x64      |
| Txlineage.dll                                                 | 2017.140.3390.2 | 103304    | 16-Apr-21 | 06:02 | x86      |
| Txlineage.dll                                                 | 2017.140.3390.2 | 129928    | 16-Apr-21 | 06:17 | x64      |
| Txlookup.dll                                                  | 2017.140.3390.2 | 439696    | 16-Apr-21 | 06:02 | x86      |
| Txlookup.dll                                                  | 2017.140.3390.2 | 521112    | 16-Apr-21 | 06:17 | x64      |
| Txmerge.dll                                                   | 2017.140.3390.2 | 169888    | 16-Apr-21 | 06:02 | x86      |
| Txmerge.dll                                                   | 2017.140.3390.2 | 223128    | 16-Apr-21 | 06:17 | x64      |
| Txmergejoin.dll                                               | 2017.140.3390.2 | 214944    | 16-Apr-21 | 06:02 | x86      |
| Txmergejoin.dll                                               | 2017.140.3390.2 | 268672    | 16-Apr-21 | 06:17 | x64      |
| Txmulticast.dll                                               | 2017.140.3390.2 | 95624     | 16-Apr-21 | 06:02 | x86      |
| Txmulticast.dll                                               | 2017.140.3390.2 | 120736    | 16-Apr-21 | 06:17 | x64      |
| Txpivot.dll                                                   | 2017.140.3390.2 | 173448    | 16-Apr-21 | 06:02 | x86      |
| Txpivot.dll                                                   | 2017.140.3390.2 | 217992    | 16-Apr-21 | 06:17 | x64      |
| Txrowcount.dll                                                | 2017.140.3390.2 | 94624     | 16-Apr-21 | 06:02 | x86      |
| Txrowcount.dll                                                | 2017.140.3390.2 | 118688    | 16-Apr-21 | 06:17 | x64      |
| Txsampling.dll                                                | 2017.140.3390.2 | 128928    | 16-Apr-21 | 06:02 | x86      |
| Txsampling.dll                                                | 2017.140.3390.2 | 165792    | 16-Apr-21 | 06:17 | x64      |
| Txscd.dll                                                     | 2017.140.3390.2 | 163208    | 16-Apr-21 | 06:02 | x86      |
| Txscd.dll                                                     | 2017.140.3390.2 | 213920    | 16-Apr-21 | 06:17 | x64      |
| Txsort.dll                                                    | 2017.140.3390.2 | 201120    | 16-Apr-21 | 06:02 | x86      |
| Txsort.dll                                                    | 2017.140.3390.2 | 249760    | 16-Apr-21 | 06:17 | x64      |
| Txsplit.dll                                                   | 2017.140.3390.2 | 503696    | 16-Apr-21 | 06:02 | x86      |
| Txsplit.dll                                                   | 2017.140.3390.2 | 589712    | 16-Apr-21 | 06:17 | x64      |
| Txtermextraction.dll                                          | 2017.140.3390.2 | 8608160   | 16-Apr-21 | 06:02 | x86      |
| Txtermextraction.dll                                          | 2017.140.3390.2 | 8669576   | 16-Apr-21 | 06:17 | x64      |
| Txtermlookup.dll                                              | 2017.140.3390.2 | 4099992   | 16-Apr-21 | 06:02 | x86      |
| Txtermlookup.dll                                              | 2017.140.3390.2 | 4150160   | 16-Apr-21 | 06:17 | x64      |
| Txunionall.dll                                                | 2017.140.3390.2 | 132496    | 16-Apr-21 | 06:02 | x86      |
| Txunionall.dll                                                | 2017.140.3390.2 | 175008    | 16-Apr-21 | 06:17 | x64      |
| Txunpivot.dll                                                 | 2017.140.3390.2 | 153480    | 16-Apr-21 | 06:02 | x86      |
| Txunpivot.dll                                                 | 2017.140.3390.2 | 192928    | 16-Apr-21 | 06:17 | x64      |
| Xe.dll                                                        | 2017.140.3390.2 | 588704    | 16-Apr-21 | 06:03 | x86      |
| Xe.dll                                                        | 2017.140.3390.2 | 666512    | 16-Apr-21 | 06:18 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 16-Apr-21 | 06:11 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 16-Apr-21 | 06:11 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 16-Apr-21 | 06:11 | x86      |
| Instapi140.dll                                                       | 2017.140.3390.2  | 65408     | 16-Apr-21 | 06:11 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 16-Apr-21 | 06:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 16-Apr-21 | 06:00 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 16-Apr-21 | 05:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 16-Apr-21 | 06:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 16-Apr-21 | 06:06 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 16-Apr-21 | 05:59 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 16-Apr-21 | 05:58 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 16-Apr-21 | 06:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 16-Apr-21 | 05:59 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 16-Apr-21 | 06:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 16-Apr-21 | 06:00 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 16-Apr-21 | 05:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 16-Apr-21 | 06:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 16-Apr-21 | 06:06 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 16-Apr-21 | 05:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 16-Apr-21 | 05:58 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 16-Apr-21 | 06:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 16-Apr-21 | 05:59 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 16-Apr-21 | 06:11 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 16-Apr-21 | 06:11 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3390.2  | 400264    | 16-Apr-21 | 06:11 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3390.2  | 7320968   | 16-Apr-21 | 06:11 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3390.2  | 2257808   | 16-Apr-21 | 06:11 | x64      |
| Secforwarder.dll                                                     | 2017.140.3390.2  | 30600     | 16-Apr-21 | 06:11 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 16-Apr-21 | 06:11 | x64      |
| Sqldk.dll                                                            | 2017.140.3390.2  | 2733464   | 16-Apr-21 | 06:11 | x64      |
| Sqldumper.exe                                                        | 2017.140.3390.2  | 138640    | 16-Apr-21 | 06:11 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 1494408   | 16-Apr-21 | 06:12 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3914632   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3212680   | 16-Apr-21 | 06:10 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3917704   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3820936   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 2087304   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 2033544   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3588488   | 16-Apr-21 | 05:58 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3596168   | 16-Apr-21 | 05:59 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 1441680   | 16-Apr-21 | 06:01 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3390.2  | 3785096   | 16-Apr-21 | 06:13 | x64      |
| Sqlos.dll                                                            | 2017.140.3390.2  | 19336     | 16-Apr-21 | 06:11 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 16-Apr-21 | 06:11 | x64      |
| Sqltses.dll                                                          | 2017.140.3390.2  | 9729440   | 16-Apr-21 | 06:11 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3390.2     | 17296     | 16-Apr-21 | 06:17 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                                | File version    | File size | Date      | Time | Platform |
|------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                              | 2017.140.3390.2 | 1441680   | 16-Apr-21 | 06:03 | x86      |
| Dtaengine.exe                                              | 2017.140.3390.2 | 197520    | 16-Apr-21 | 06:01 | x86      |
| Dteparse.dll                                               | 2017.140.3390.2 | 93600     | 16-Apr-21 | 06:01 | x86      |
| Dteparse.dll                                               | 2017.140.3390.2 | 104344    | 16-Apr-21 | 06:16 | x64      |
| Dteparsemgd.dll                                            | 2017.140.3390.2 | 76688     | 16-Apr-21 | 06:01 | x86      |
| Dteparsemgd.dll                                            | 2017.140.3390.2 | 82304     | 16-Apr-21 | 06:16 | x64      |
| Dtepkg.dll                                                 | 2017.140.3390.2 | 109968    | 16-Apr-21 | 06:01 | x86      |
| Dtepkg.dll                                                 | 2017.140.3390.2 | 130960    | 16-Apr-21 | 06:16 | x64      |
| Dtexec.exe                                                 | 2017.140.3390.2 | 60816     | 16-Apr-21 | 06:01 | x86      |
| Dtexec.exe                                                 | 2017.140.3390.2 | 66952     | 16-Apr-21 | 06:16 | x64      |
| Dts.dll                                                    | 2017.140.3390.2 | 2544008   | 16-Apr-21 | 06:01 | x86      |
| Dts.dll                                                    | 2017.140.3390.2 | 2994064   | 16-Apr-21 | 06:16 | x64      |
| Dtscomexpreval.dll                                         | 2017.140.3390.2 | 411016    | 16-Apr-21 | 06:01 | x86      |
| Dtscomexpreval.dll                                         | 2017.140.3390.2 | 468376    | 16-Apr-21 | 06:16 | x64      |
| Dtsconn.dll                                                | 2017.140.3390.2 | 395664    | 16-Apr-21 | 06:01 | x86      |
| Dtsconn.dll                                                | 2017.140.3390.2 | 493464    | 16-Apr-21 | 06:16 | x64      |
| Dtshost.exe                                                | 2017.140.3390.2 | 84384     | 16-Apr-21 | 06:03 | x86      |
| Dtshost.exe                                                | 2017.140.3390.2 | 99224     | 16-Apr-21 | 06:17 | x64      |
| Dtslog.dll                                                 | 2017.140.3390.2 | 96128     | 16-Apr-21 | 06:01 | x86      |
| Dtslog.dll                                                 | 2017.140.3390.2 | 113568    | 16-Apr-21 | 06:16 | x64      |
| Dtsmsg140.dll                                              | 2017.140.3390.2 | 534416    | 16-Apr-21 | 06:03 | x86      |
| Dtsmsg140.dll                                              | 2017.140.3390.2 | 538528    | 16-Apr-21 | 06:17 | x64      |
| Dtspipeline.dll                                            | 2017.140.3390.2 | 1053592   | 16-Apr-21 | 06:01 | x86      |
| Dtspipeline.dll                                            | 2017.140.3390.2 | 1261456   | 16-Apr-21 | 06:16 | x64      |
| Dtspipelineperf140.dll                                     | 2017.140.3390.2 | 35744     | 16-Apr-21 | 06:01 | x86      |
| Dtspipelineperf140.dll                                     | 2017.140.3390.2 | 41360     | 16-Apr-21 | 06:16 | x64      |
| Dtuparse.dll                                               | 2017.140.3390.2 | 73112     | 16-Apr-21 | 06:01 | x86      |
| Dtuparse.dll                                               | 2017.140.3390.2 | 82336     | 16-Apr-21 | 06:16 | x64      |
| Dtutil.exe                                                 | 2017.140.3390.2 | 120720    | 16-Apr-21 | 06:01 | x86      |
| Dtutil.exe                                                 | 2017.140.3390.2 | 141728    | 16-Apr-21 | 06:16 | x64      |
| Exceldest.dll                                              | 2017.140.3390.2 | 207776    | 16-Apr-21 | 06:01 | x86      |
| Exceldest.dll                                              | 2017.140.3390.2 | 253856    | 16-Apr-21 | 06:16 | x64      |
| Excelsrc.dll                                               | 2017.140.3390.2 | 223624    | 16-Apr-21 | 06:01 | x86      |
| Excelsrc.dll                                               | 2017.140.3390.2 | 275864    | 16-Apr-21 | 06:16 | x64      |
| Flatfiledest.dll                                           | 2017.140.3390.2 | 325536    | 16-Apr-21 | 06:01 | x86      |
| Flatfiledest.dll                                           | 2017.140.3390.2 | 379808    | 16-Apr-21 | 06:16 | x64      |
| Flatfilesrc.dll                                            | 2017.140.3390.2 | 337296    | 16-Apr-21 | 06:01 | x86      |
| Flatfilesrc.dll                                            | 2017.140.3390.2 | 392608    | 16-Apr-21 | 06:16 | x64      |
| Foreachfileenumerator.dll                                  | 2017.140.3390.2 | 73632     | 16-Apr-21 | 06:01 | x86      |
| Foreachfileenumerator.dll                                  | 2017.140.3390.2 | 89488     | 16-Apr-21 | 06:16 | x64      |
| Microsoft.sqlserver.astasks.dll                            | 14.0.3390.2     | 67472     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.astasksui.dll                          | 14.0.3390.2     | 179592    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3390.2     | 403352    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll             | 14.0.3390.2     | 403336    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3390.2     | 2086816   | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                  | 14.0.3390.2     | 2086784   | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3390.2     | 607648    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.manageddts.dll                         | 14.0.3390.2     | 607616    | 16-Apr-21 | 06:17 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll     | 14.0.3390.2     | 246176    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll | 14.0.3390.2     | 48024     | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3390.2 | 135056    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll               | 2017.140.3390.2 | 145312    | 16-Apr-21 | 06:17 | x64      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3390.2 | 138656    | 16-Apr-21 | 06:02 | x86      |
| Microsoft.sqlserver.xevent.dll                             | 2017.140.3390.2 | 152464    | 16-Apr-21 | 06:17 | x64      |
| Msdtssrvrutil.dll                                          | 2017.140.3390.2 | 83360     | 16-Apr-21 | 06:01 | x86      |
| Msdtssrvrutil.dll                                          | 2017.140.3390.2 | 96160     | 16-Apr-21 | 06:16 | x64      |
| Msmgdsrv.dll                                               | 2017.140.249.71 | 7304600   | 16-Apr-21 | 06:03 | x86      |
| Oledbdest.dll                                              | 2017.140.3390.2 | 207744    | 16-Apr-21 | 06:01 | x86      |
| Oledbdest.dll                                              | 2017.140.3390.2 | 254360    | 16-Apr-21 | 06:16 | x64      |
| Oledbsrc.dll                                               | 2017.140.3390.2 | 226208    | 16-Apr-21 | 06:01 | x86      |
| Oledbsrc.dll                                               | 2017.140.3390.2 | 281992    | 16-Apr-21 | 06:16 | x64      |
| Sql_tools_extensions_keyfile.dll                           | 2017.140.3390.2 | 93584     | 16-Apr-21 | 06:16 | x64      |
| Sqlresld.dll                                               | 2017.140.3390.2 | 21904     | 16-Apr-21 | 06:02 | x86      |
| Sqlresld.dll                                               | 2017.140.3390.2 | 23944     | 16-Apr-21 | 06:17 | x64      |
| Sqlresourceloader.dll                                      | 2017.140.3390.2 | 22408     | 16-Apr-21 | 06:02 | x86      |
| Sqlresourceloader.dll                                      | 2017.140.3390.2 | 25504     | 16-Apr-21 | 06:17 | x64      |
| Sqlscm.dll                                                 | 2017.140.3390.2 | 55184     | 16-Apr-21 | 06:02 | x86      |
| Sqlscm.dll                                                 | 2017.140.3390.2 | 65944     | 16-Apr-21 | 06:17 | x64      |
| Sqlsvc.dll                                                 | 2017.140.3390.2 | 128400    | 16-Apr-21 | 06:02 | x86      |
| Sqlsvc.dll                                                 | 2017.140.3390.2 | 156048    | 16-Apr-21 | 06:17 | x64      |
| Sqltaskconnections.dll                                     | 2017.140.3390.2 | 148360    | 16-Apr-21 | 06:02 | x86      |
| Sqltaskconnections.dll                                     | 2017.140.3390.2 | 177032    | 16-Apr-21 | 06:17 | x64      |
| Txdataconvert.dll                                          | 2017.140.3390.2 | 246168    | 16-Apr-21 | 06:02 | x86      |
| Txdataconvert.dll                                          | 2017.140.3390.2 | 286104    | 16-Apr-21 | 06:17 | x64      |
| Xe.dll                                                     | 2017.140.3390.2 | 588704    | 16-Apr-21 | 06:03 | x86      |
| Xe.dll                                                     | 2017.140.3390.2 | 666512    | 16-Apr-21 | 06:18 | x64      |
| Xmlrw.dll                                                  | 2017.140.3390.2 | 250776    | 16-Apr-21 | 06:03 | x86      |
| Xmlrw.dll                                                  | 2017.140.3390.2 | 298376    | 16-Apr-21 | 06:18 | x64      |
| Xmlrwbin.dll                                               | 2017.140.3390.2 | 182672    | 16-Apr-21 | 06:03 | x86      |
| Xmlrwbin.dll                                               | 2017.140.3390.2 | 217472    | 16-Apr-21 | 06:18 | x64      |

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
