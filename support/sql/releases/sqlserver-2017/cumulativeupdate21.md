---
title: Cumulative update 21 for SQL Server 2017 (KB4557397)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 21 (KB4557397).
ms.date: 08/04/2023
ms.custom: KB4557397, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4557397 - Cumulative Update 21 for SQL Server 2017

_Release Date:_ &nbsp; July 1, 2020  
_Version:_ &nbsp; 14.0.3335.7

## Summary

This article describes Cumulative Update package 21 (CU21) for Microsoft SQL Server 2017. This update contains 32 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 20, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3335.7**, file version: **2017.140.3335.7**
- Analysis Services - Product version: **14.0.249.51**, file version: **2017.140.249.51**

## Known issues in this update

There's a known issue that affects the Filestream and FileTable features on Windows Server 2012 and Windows 8 operating systems. Don't apply this CU if you use one of these SQL Server features and you're running on one of these identified operating systems.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area | Component| Platform |
|---------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|----------------------------------------------|----------|
| <a id=13455278>[13455278](#13455278) </a> | When you use mashup to import from Active Directory by using the default M query generated from the connection wizard, you may encounter "Key Expression Error: The key didn't match any rows in the table." | Analysis Services | Analysis Services | Windows |
| <a id=13468501>[13468501](#13468501) </a> | Assume that you run an MDX query with YTD and select multiple members on column, you notice that incorrect result may return in SSAS Tabular instance. However, correct result returns if you run the similar MDX query with YTD but select each individual member on column. | Analysis Services | Analysis Services | Windows |
| <a id=13473122>[13473122](#13473122) </a> | When you try to refresh a model that contains many measures with `USERELATIONSHIP` function, SSAS can take many minutes before sending out queries to read from the data source. This fix can improve the processing performance and data source queries will be sent out very soon after the initial "sequence point algorithm" step. | Analysis Services | Analysis Services | Windows |
| <a id=13495359>[13495359](#13495359) </a> | Error occurs when you create a session cube on a database and then try to query from that session cube in SQL Server 2017. </br></br>"Server: The operation has been cancelled because there is not enough memory available for the application. If using a 32-bit version of the product, consider upgrading to the 64-bit version or increasing the amount of memory available on the machine." | Analysis Services | Analysis Services | Windows |
| <a id=13530057>[13530057](#13530057) </a> | This improves MDX query execution performance against a dimension user hierarchy that is ragged hierarchy (HidememberIf property set) and has deep hierarchy level in SSAS Multidimensional instance. | Analysis Services | Analysis Services | Windows |
| <a id=13490178>[13490178](#13490178) </a> | Fixes long duration taken for Integration Services Project deployment through PowerShell by improving search of operation messages in deployment process.| Integration services | Server | Windows |
| <a id=13574528>[13574528](#13574528) </a> | Improves SSISDB performance by adding indexes to `event_message_context and execution_property_override_values` tables in SQL Server 2017. | Integration services | Server | Windows |
| <a id=13564527>[13564527](#13564527) </a> | Column Description disappears after exporting/importing models through MDSModelDeploy for an approval required entity in SQL Server 2017.| Master Data Services | Master Data Services | Windows |
| <a id=13323992>[13323992](#13323992) </a> | [FIX: Non-yielding scheduler condition occurs if large number of row-column values are processed in row groups in SQL Server 2016 and 2017 (KB4521599)](https://support.microsoft.com/help/4521599) | SQL Server Engine | Column Stores | All |
| <a id=13503404>[13503404](#13503404) </a> | R Setup components fail to download CAB files when TLS 1.0 is disabled. This update includes a new R Setup version to add support for TLS1.2. | SQL Server Engine| Extensibility| Windows|
| <a id=13421890>[13421890](#13421890) </a> | [FIX: Access violation may occur when enumerating files in a FileTable in SQL Server (KB4540896)](https://support.microsoft.com/help/4540896) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=13543457>[13543457](#13543457) </a> | When using FileTables in SQL Server, you may notice dumps being generated periodically that contain an assertion in function `FFtFileObject::ProcessPostCreate`. In some environments, these dumps may trigger a failover (FtFileObject::ProcessPostCreate file = fftfo.cpp line = \<LineNumber>expression = FALSE). | SQL Server Engine | FileStream and FileTable | Windows |
| <a id=13578386>[13578386](#13578386) </a> | [Improvement: A manual method to set maximum group commit time in SQL Server 2017 (KB4565944)](https://support.microsoft.com/help/4565944) | SQL Server Engine| High Availability and Disaster Recovery| Windows|
| <a id=13508566>[13508566](#13508566) </a> | [FIX: Availability Group failover generates lot of dumps as DTC support is toggled between PER_DB and NONE multiple times (KB4562173)](https://support.microsoft.com/help/4562173) | SQL Server Engine| High Availability and Disaster Recovery| Windows|
| <a id=13477385>[13477385](#13477385) </a> | Fixes an assertion exception (Location:sosmemobj.cpp:LineNumber, Expression: pvb->FInUse ()) while querying the DMV `sys.dm_hadr_automatic_seeding`. | SQL Server Engine| High Availability and Disaster Recovery| All|
| <a id=13554273>[13554273](#13554273) </a> | This update contains an improvement for object level lock optimization on secondary replicas of Always On availability groups and addresses the schema lock contention on secondary replica redo, when the number of logical processors is large. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id=13502024>[13502024](#13502024) </a> | `sys.key_constraints` reports two rows (duplicate) for an index if we have an XML component id with an id that is the same as the `object_id` of a primary key. | SQL Server Engine| Metadata | Windows|
| <a id=13387895>[13387895](#13387895) </a> | [FIX: Assertion failure occurs when you try to insert record into a page in fully logged mode in SQL Server 2017 (KB4567166)](https://support.microsoft.com/help/4567166) | SQL Server Engine | Methods to access stored data | Windows |
| <a id=13422969>[13422969](#13422969) </a> | [FIX: Assertion exception occurs when you query the DMV sys.dm_db_file_space_usage in SQL Server 2017 and 2019 (KB4564868)](https://support.microsoft.com/help/4564868) | SQL Server Engine| Methods to access stored data | Windows |
| <a id=13458572>[13458572](#13458572) </a> | Spatial data types (Geometry and Geography) are implemented as CLR data types in SQL Server. When the application domain hosting the spatial data type structures is unloaded, the engine treats this as a schema change to the underlying objects referenced in the cursor. As a result, spatial query may fail with related error message when the schema change is detected. | SQL Server Engine | Programmability | Windows |
| <a id=13515392>[13515392](#13515392) </a> | Fixes an access violation while frequently restarting Extended Event session with QueryPlanProfile event in SQL Server 2017. | SQL Server Engine| Query Execution| Windows |
| <a id=13525859>[13525859](#13525859) </a> | Fixes an access violation with recursive CTE whose anchor member is a clustered Columnstore index. | SQL Server Engine| Query Execution| Windows|
| <a id=13530833>[13530833](#13530833) </a> | Access violation exception occurs when a query that references a non-existing partition function is executed in SQL Server 2017. | SQL Server Engine| Query Execution| Windows|
| <a id=13488604>[13488604](#13488604) </a> | The `DELETE` from `CONSTITUENT` table in SQL Server 2017 fails with error even when the table has no matching rows in the referenced tables. </br></br> Msg 547, Level 16, State 0, Line LineNumber </br>The DELETE statement conflicted with the REFERENCE constraint "ConstraintName". The conflict occurred in database "DatabaseName", table "TableName", column 'ColumnName'.The statement has been terminated. | SQL Server Engine | Query Optimizer | Windows |
| <a id=13561699>[13561699](#13561699) </a> | Fixes an issue where `sys.dm_db_stats_histogram` doesn't show NULL value histogram step in SQL Server 2017. | SQL Server Engine| Query Optimizer| All|
| <a id=13516058>[13516058](#13516058) </a> | This improvement can force the Query Store option to be turned off by specifying the additional option `FORCED` in the `ALTER DB` command. `FORCED` option allows you to turn off Query Store immediately by aborting all background tasks. </br>`ALTER DATABASE {0} SET QUERY_STORE = OFF (FORCED)` | SQL Server Engine | Query Store | Windows |
| <a id=13042339>[13042339](#13042339) </a> | [FIX: Transactional replication publications can support URL type device to initialize subscriptions from backups in Azure Blob Storage in SQL Server 2017 (KB4569425)](https://support.microsoft.com/help/4569425)| SQL Server Engine | Replication | Windows |
| <a id=13603817>[13603817](#13603817) </a> | [FIX: Assertion dump may occur when Implicit Transactions are enabled in SQL Server 2016 and 2017 (KB4563597)](https://support.microsoft.com/help/4563597) | SQL Server Engine | Replication | Windows |
| <a id=13546338>[13546338](#13546338) </a> | [FIX: High CPU usage causes performance issues in SQL Server 2016 and 2017 (KB3195888)](https://support.microsoft.com/help/3195888) | SQL Server Engine | SQL OS | All |
| <a id=13502382>[13502382](#13502382) </a> | Fixes self-deadlock with database log flush queue spinlock.| SQL Server Engine| SQL OS | Linux |
| <a id=13563530>[13563530](#13563530) </a> | Executing `sys.fn_xe_file_target_read_file` may cause SQL Server to stop responding. | SQL Server Engine | SQL OS | Windows |
| <a id=13545675>[13545675](#13545675) </a> | [FIX: Script downgrade may fail when Cumulative Update 20 (CU20) is uninstalled from SQL Server 2017 (KB4567837)](https://support.microsoft.com/help/4567837)| SQL Setup | Uninstall | Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU21 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/07/sqlserver2017-kb4557397-x64_e91bfa33a34accf82a0c374c9e8b7d0ce3b7ce05.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4557397-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4557397-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4557397-x64.exe| 95D63825AEA88EDE26E920018B3C6A9768FFFA4EBE70B3E10D216DDE2879E8D0 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Asplatformhost.dll                                 | 2017.140.249.51 | 259464    | 13-Jun-20 | 03:31  | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.51     | 734608    | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.51     | 1373584   | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.51     | 977288    | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.51     | 514448    | 13-Jun-20 | 03:31  | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 15-Apr-20 | 18:50 | x86      |
| Microsoft.data.edm.netfx35.dll                     | 5.7.0.62516     | 661072    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.mashup.dll                          | 2.80.5803.541   | 186232    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.80.5803.541   | 30080     | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.80.5803.541   | 74832     | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.80.5803.541   | 102264    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.odata.netfx35.dll                   | 5.7.0.62516     | 1454672   | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.odata.query.netfx35.dll             | 5.7.0.62516     | 181112    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.data.sapclient.dll                       | 1.0.0.25        | 920656    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.80.5803.541   | 5262728   | 5-Jun-20  | 13:21 | x86      |
| Microsoft.mashup.container.exe                     | 2.80.5803.541   | 22392     | 5-Jun-20  | 13:20 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.80.5803.541   | 21880     | 5-Jun-20  | 13:20 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.80.5803.541   | 22096     | 5-Jun-20  | 13:20 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.80.5803.541   | 149368    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.80.5803.541   | 78712     | 5-Jun-20  | 13:20 | x86      |
| Microsoft.mashup.oledbinterop.dll                  | 2.80.5803.541   | 192392    | 5-Jun-20  | 13:20 | x64      |
| Microsoft.mashup.oledbprovider.dll                 | 2.80.5803.541   | 59984     | 5-Jun-20  | 13:20 | x86      |
| Microsoft.mashup.shims.dll                         | 2.80.5803.541   | 27512     | 5-Jun-20  | 13:20 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 140368    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.mashupengine.dll                         | 2.80.5803.541   | 14271872  | 5-Jun-20  | 13:20 | x86      |
| Microsoft.odata.core.netfx35.dll                   | 6.15.0.0        | 1437568   | 5-Jun-20  | 13:20 | x86      |
| Microsoft.odata.edm.netfx35.dll                    | 6.15.0.0        | 778632    | 5-Jun-20  | 13:20 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.1.27.19      | 1104976   | 5-Jun-20  | 13:20 | x86      |
| Microsoft.spatial.netfx35.dll                      | 6.15.0.0        | 126336    | 5-Jun-20  | 13:20 | x86      |
| Msmdctr.dll                                        | 2017.140.249.51 | 33168     | 13-Jun-20 | 03:31  | x64      |
| Msmdlocal.dll                                      | 2017.140.249.51 | 60752776  | 13-Jun-20 | 03:31  | x64      |
| Msmdlocal.dll                                      | 2017.140.249.51 | 40412552  | 13-Jun-20 | 03:33  | x86      |
| Msmdpump.dll                                       | 2017.140.249.51 | 9332616   | 13-Jun-20 | 03:31  | x64      |
| Msmdredir.dll                                      | 2017.140.249.51 | 7088528   | 13-Jun-20 | 03:33  | x86      |
| Msmdsrv.exe                                        | 2017.140.249.51 | 60652944  | 13-Jun-20 | 03:31  | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.51 | 9000848   | 13-Jun-20 | 03:31  | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.51 | 7304584   | 13-Jun-20 | 03:33  | x86      |
| Msolap.dll                                         | 2017.140.249.51 | 10256776  | 13-Jun-20 | 03:31  | x64      |
| Msolap.dll                                         | 2017.140.249.51 | 7772552   | 13-Jun-20 | 03:33  | x86      |
| Msolui.dll                                         | 2017.140.249.51 | 304016    | 13-Jun-20 | 03:31  | x64      |
| Msolui.dll                                         | 2017.140.249.51 | 280464    | 13-Jun-20 | 03:33  | x86      |
| Powerbiextensions.dll                              | 2.80.5803.541   | 9470032   | 5-Jun-20  | 13:20 | x86      |
| Private_odbc32.dll                                 | 10.0.14832.1000 | 728456    | 5-Jun-20  | 13:20 | x64      |
| Sql_as_keyfile.dll                                 | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqlboot.dll                                        | 2017.140.3335.7 | 190864    | 13-Jun-20 | 03:46  | x64      |
| Sqlceip.exe                                        | 14.0.3335.7     | 254864    | 13-Jun-20 | 03:54  | x86      |
| Sqldumper.exe                                      | 2017.140.3335.7 | 116104    | 13-Jun-20 | 03:38  | x86      |
| Sqldumper.exe                                      | 2017.140.3335.7 | 138632    | 13-Jun-20 | 03:45  | x64      |
| System.spatial.netfx35.dll                         | 5.7.0.62516     | 117640    | 5-Jun-20  | 13:20 | x86      |
| Tmapi.dll                                          | 2017.140.249.51 | 5814664   | 13-Jun-20 | 03:31  | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.51 | 4157832   | 13-Jun-20 | 03:31  | x64      |
| Tmpersistence.dll                                  | 2017.140.249.51 | 1125264   | 13-Jun-20 | 03:31  | x64      |
| Tmtransactions.dll                                 | 2017.140.249.51 | 1634200   | 13-Jun-20 | 03:31  | x64      |
| Xe.dll                                             | 2017.140.3335.7 | 666504    | 13-Jun-20 | 03:37  | x64      |
| Xmlrw.dll                                          | 2017.140.3335.7 | 250768    | 13-Jun-20 | 03:38  | x86      |
| Xmlrw.dll                                          | 2017.140.3335.7 | 298384    | 13-Jun-20 | 03:46  | x64      |
| Xmlrwbin.dll                                       | 2017.140.3335.7 | 182672    | 13-Jun-20 | 03:38  | x86      |
| Xmlrwbin.dll                                       | 2017.140.3335.7 | 217488    | 13-Jun-20 | 03:46  | x64      |
| Xmsrv.dll                                          | 2017.140.249.51 | 25375632  | 13-Jun-20 | 03:31  | x64      |
| Xmsrv.dll                                          | 2017.140.249.51 | 33349000  | 13-Jun-20 | 03:33  | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time  | Platform |
|--------------------------------------------|------------------|-----------|-----------|-------|----------|
| Batchparser.dll                            | 2017.140.3335.7  | 173968    | 13-Jun-20 | 03:31  | x64      |
| Batchparser.dll                            | 2017.140.3335.7  | 153488    | 13-Jun-20 | 03:32  | x86      |
| Instapi140.dll                             | 2017.140.3335.7  | 55696     | 13-Jun-20 | 03:33  | x86      |
| Instapi140.dll                             | 2017.140.3335.7  | 65424     | 13-Jun-20 | 03:37  | x64      |
| Isacctchange.dll                           | 2017.140.3335.7  | 22416     | 13-Jun-20 | 03:45  | x86      |
| Isacctchange.dll                           | 2017.140.3335.7  | 23952     | 13-Jun-20 | 03:46  | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.51      | 1081744   | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.51      | 1081736   | 13-Jun-20 | 03:32  | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.51      | 1374608   | 13-Jun-20 | 03:32  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.51      | 734600    | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.51      | 734608    | 13-Jun-20 | 03:33  | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3335.7      | 30096     | 13-Jun-20 | 03:37  | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3335.7  | 71560     | 13-Jun-20 | 03:32  | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3335.7  | 75152     | 13-Jun-20 | 03:33  | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3335.7      | 564624    | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3335.7      | 564616    | 13-Jun-20 | 04:01  | x86      |
| Msasxpress.dll                             | 2017.140.249.51  | 29064     | 13-Jun-20 | 03:31  | x64      |
| Msasxpress.dll                             | 2017.140.249.51  | 24968     | 13-Jun-20 | 03:33  | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3335.7  | 62352     | 13-Jun-20 | 03:46  | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3335.7  | 77192     | 13-Jun-20 | 03:54  | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3335.7  | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqldumper.exe                              | 2017.140.3335.7  | 116104    | 13-Jun-20 | 03:38  | x86      |
| Sqldumper.exe                              | 2017.140.3335.7  | 138632    | 13-Jun-20 | 03:45  | x64      |
| Sqlftacct.dll                              | 2017.140.3335.7  | 49048     | 13-Jun-20 | 03:46  | x86      |
| Sqlftacct.dll                              | 2017.140.3335.7  | 57240     | 13-Jun-20 | 03:54  | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 17-Apr-20 | 17:00 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 17-Apr-20 | 17:01 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3335.7  | 368520    | 13-Jun-20 | 03:54  | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3335.7  | 413064    | 13-Jun-20 | 03:54  | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3335.7  | 28040     | 13-Jun-20 | 03:46  | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3335.7  | 30600     | 13-Jun-20 | 03:54  | x64      |
| Sqlsvcsync.dll                             | 2017.140.3335.7  | 267152    | 13-Jun-20 | 03:37  | x86      |
| Sqlsvcsync.dll                             | 2017.140.3335.7  | 351112    | 13-Jun-20 | 03:37  | x64      |
| Sqltdiagn.dll                              | 2017.140.3335.7  | 53648     | 13-Jun-20 | 03:32  | x86      |
| Sqltdiagn.dll                              | 2017.140.3335.7  | 60816     | 13-Jun-20 | 03:33  | x64      |
| Svrenumapi140.dll                          | 2017.140.3335.7  | 888216    | 13-Jun-20 | 03:37  | x86      |
| Svrenumapi140.dll                          | 2017.140.3335.7  | 1168264   | 13-Jun-20 | 03:46  | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time  | Platform |
|---------------------|-----------------|-----------|-----------|-------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 17-Apr-20 | 15:46 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 17-Apr-20 | 15:46 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 17-Apr-20 | 15:46 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 17-Apr-20 | 15:47 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time  | Platform |
|---------------------------------------------------|--------------|-----------|-----------|-------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 15-Apr-20 | 18:35 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 15-Apr-20 | 18:35 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3335.7 | 114064    | 13-Jun-20 | 03:53 | x86      |
| Dreplaycommon.dll              | 2017.140.3335.7 | 693128    | 13-Jun-20 | 03:45 | x86      |
| Dreplayserverps.dll            | 2017.140.3335.7 | 25992     | 13-Jun-20 | 03:31 | x86      |
| Dreplayutil.dll                | 2017.140.3335.7 | 302984    | 13-Jun-20 | 03:53 | x86      |
| Instapi140.dll                 | 2017.140.3335.7 | 65424     | 13-Jun-20 | 03:37 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |
| Sqlresourceloader.dll          | 2017.140.3335.7 | 22424     | 13-Jun-20 | 03:31 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3335.7 | 693128    | 13-Jun-20 | 03:45 | x86      |
| Dreplaycontroller.exe              | 2017.140.3335.7 | 343448    | 13-Jun-20 | 03:54 | x86      |
| Dreplayprocess.dll                 | 2017.140.3335.7 | 164752    | 13-Jun-20 | 03:53 | x86      |
| Dreplayserverps.dll                | 2017.140.3335.7 | 25992     | 13-Jun-20 | 03:31 | x86      |
| Instapi140.dll                     | 2017.140.3335.7 | 65424     | 13-Jun-20 | 03:37 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |
| Sqlresourceloader.dll              | 2017.140.3335.7 | 22424     | 13-Jun-20 | 03:31 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time  | Platform |
|----------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Backuptourl.exe                              | 14.0.3335.7     | 33680     | 13-Jun-20 | 03:37  | x64      |
| Batchparser.dll                              | 2017.140.3335.7 | 173968    | 13-Jun-20 | 03:31  | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 17-Apr-20 | 15:45 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 17-Apr-20 | 15:45 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 17-Apr-20 | 15:45 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 17-Apr-20 | 15:47 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 17-Apr-20 | 17:01 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3335.7 | 220568    | 13-Jun-20 | 03:54  | x64      |
| Dcexec.exe                                   | 2017.140.3335.7 | 67480     | 13-Jun-20 | 03:54  | x64      |
| Fssres.dll                                   | 2017.140.3335.7 | 83848     | 13-Jun-20 | 03:54  | x64      |
| Hadrres.dll                                  | 2017.140.3335.7 | 182672    | 13-Jun-20 | 03:46  | x64      |
| Hkcompile.dll                                | 2017.140.3335.7 | 1416080   | 13-Jun-20 | 03:54  | x64      |
| Hkengine.dll                                 | 2017.140.3335.7 | 5852048   | 13-Jun-20 | 03:54  | x64      |
| Hkruntime.dll                                | 2017.140.3335.7 | 156048    | 13-Jun-20 | 04:01  | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 17-Apr-20 | 15:45 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.51     | 734096    | 13-Jun-20 | 03:31  | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 15-Apr-20 | 18:50 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3335.7     | 229264    | 13-Jun-20 | 04:01  | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3335.7     | 72600     | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3335.7 | 385928    | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3335.7 | 65416     | 13-Jun-20 | 03:33  | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3335.7 | 58248     | 13-Jun-20 | 03:45  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3335.7 | 145296    | 13-Jun-20 | 03:53  | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3335.7 | 152456    | 13-Jun-20 | 03:53  | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3335.7 | 296840    | 13-Jun-20 | 03:53  | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3335.7 | 67984     | 13-Jun-20 | 03:53  | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 17-Apr-20 | 15:45 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 17-Apr-20 | 15:45 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 17-Apr-20 | 15:45 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 17-Apr-20 | 15:45 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 17-Apr-20 | 15:45 | x64      |
| Odsole70.dll                                 | 2017.140.3335.7 | 85912     | 13-Jun-20 | 03:54  | x64      |
| Opends60.dll                                 | 2017.140.3335.7 | 25992     | 13-Jun-20 | 03:33  | x64      |
| Qds.dll                                      | 2017.140.3335.7 | 1175944   | 13-Jun-20 | 06:32  | x64      |
| Rsfxft.dll                                   | 2017.140.3335.7 | 27528     | 13-Jun-20 | 03:32  | x64      |
| Secforwarder.dll                             | 2017.140.3335.7 | 30608     | 13-Jun-20 | 03:53  | x64      |
| Sqagtres.dll                                 | 2017.140.3335.7 | 69008     | 13-Jun-20 | 03:46  | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqlaamss.dll                                 | 2017.140.3335.7 | 84872     | 13-Jun-20 | 03:54  | x64      |
| Sqlaccess.dll                                | 2017.140.3335.7 | 468888    | 13-Jun-20 | 03:37  | x64      |
| Sqlagent.exe                                 | 2017.140.3335.7 | 598408    | 13-Jun-20 | 03:54  | x64      |
| Sqlagentctr140.dll                           | 2017.140.3335.7 | 56200     | 13-Jun-20 | 03:46  | x64      |
| Sqlagentctr140.dll                           | 2017.140.3335.7 | 47496     | 13-Jun-20 | 03:46  | x86      |
| Sqlagentlog.dll                              | 2017.140.3335.7 | 26000     | 13-Jun-20 | 03:31  | x64      |
| Sqlagentmail.dll                             | 2017.140.3335.7 | 46992     | 13-Jun-20 | 03:31  | x64      |
| Sqlboot.dll                                  | 2017.140.3335.7 | 190864    | 13-Jun-20 | 03:46  | x64      |
| Sqlceip.exe                                  | 14.0.3335.7     | 254864    | 13-Jun-20 | 03:54  | x86      |
| Sqlcmdss.dll                                 | 2017.140.3335.7 | 67464     | 13-Jun-20 | 03:46  | x64      |
| Sqlctr140.dll                                | 2017.140.3335.7 | 123792    | 13-Jun-20 | 03:46  | x64      |
| Sqlctr140.dll                                | 2017.140.3335.7 | 106384    | 13-Jun-20 | 03:54  | x86      |
| Sqldk.dll                                    | 2017.140.3335.7 | 2798480   | 13-Jun-20 | 06:32  | x64      |
| Sqldtsss.dll                                 | 2017.140.3335.7 | 102288    | 13-Jun-20 | 04:19  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 1441168   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3289992   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3820432   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 1493904   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 2086792   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3295632   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3595664   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3914128   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3212176   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 4026768   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3635592   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3676552   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3917184   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3587976   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 2033032   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3784584   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3337096   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3366280   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3779464   | 13-Jun-20 | 03:38  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3401608   | 13-Jun-20 | 03:38  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3786632   | 13-Jun-20 | 03:38  | x64      |
| Sqlevn70.rll                                 | 2017.140.3335.7 | 3480456   | 13-Jun-20 | 03:38  | x64      |
| Sqliosim.com                                 | 2017.140.3335.7 | 306568    | 13-Jun-20 | 03:54  | x64      |
| Sqliosim.exe                                 | 2017.140.3335.7 | 3013016   | 13-Jun-20 | 03:54  | x64      |
| Sqllang.dll                                  | 2017.140.3335.7 | 41249160  | 13-Jun-20 | 06:49  | x64      |
| Sqlmin.dll                                   | 2017.140.3335.7 | 40420744  | 13-Jun-20 | 06:45  | x64      |
| Sqlolapss.dll                                | 2017.140.3335.7 | 102296    | 13-Jun-20 | 03:46  | x64      |
| Sqlos.dll                                    | 2017.140.3335.7 | 19344     | 13-Jun-20 | 03:46  | x64      |
| Sqlpowershellss.dll                          | 2017.140.3335.7 | 62856     | 13-Jun-20 | 03:46  | x64      |
| Sqlrepss.dll                                 | 2017.140.3335.7 | 61832     | 13-Jun-20 | 03:46  | x64      |
| Sqlresld.dll                                 | 2017.140.3335.7 | 23960     | 13-Jun-20 | 03:31  | x64      |
| Sqlresourceloader.dll                        | 2017.140.3335.7 | 25488     | 13-Jun-20 | 03:33  | x64      |
| Sqlscm.dll                                   | 2017.140.3335.7 | 65936     | 13-Jun-20 | 03:37  | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3335.7 | 20872     | 13-Jun-20 | 03:31  | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3335.7 | 5890448   | 13-Jun-20 | 03:46  | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3335.7 | 725904    | 13-Jun-20 | 03:46  | x64      |
| Sqlservr.exe                                 | 2017.140.3335.7 | 481672    | 13-Jun-20 | 06:32  | x64      |
| Sqlsvc.dll                                   | 2017.140.3335.7 | 156056    | 13-Jun-20 | 03:46  | x64      |
| Sqltses.dll                                  | 2017.140.3335.7 | 9555856   | 13-Jun-20 | 06:32  | x64      |
| Sqsrvres.dll                                 | 2017.140.3335.7 | 255880    | 13-Jun-20 | 03:54  | x64      |
| Svl.dll                                      | 2017.140.3335.7 | 146824    | 13-Jun-20 | 04:01  | x64      |
| Xe.dll                                       | 2017.140.3335.7 | 666504    | 13-Jun-20 | 03:37  | x64      |
| Xmlrw.dll                                    | 2017.140.3335.7 | 298384    | 13-Jun-20 | 03:46  | x64      |
| Xmlrwbin.dll                                 | 2017.140.3335.7 | 217488    | 13-Jun-20 | 03:46  | x64      |
| Xpadsi.exe                                   | 2017.140.3335.7 | 84872     | 13-Jun-20 | 03:37  | x64      |
| Xplog70.dll                                  | 2017.140.3335.7 | 71056     | 13-Jun-20 | 04:01  | x64      |
| Xpqueue.dll                                  | 2017.140.3335.7 | 67992     | 13-Jun-20 | 03:37  | x64      |
| Xprepl.dll                                   | 2017.140.3335.7 | 96648     | 13-Jun-20 | 03:46  | x64      |
| Xpsqlbot.dll                                 | 2017.140.3335.7 | 25488     | 13-Jun-20 | 03:37  | x64      |
| Xpstar.dll                                   | 2017.140.3335.7 | 445328    | 13-Jun-20 | 04:01  | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time  | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Batchparser.dll                                             | 2017.140.3335.7 | 173968    | 13-Jun-20 | 03:31  | x64      |
| Batchparser.dll                                             | 2017.140.3335.7 | 153488    | 13-Jun-20 | 03:32  | x86      |
| Bcp.exe                                                     | 2017.140.3335.7 | 113032    | 13-Jun-20 | 03:46  | x64      |
| Commanddest.dll                                             | 2017.140.3335.7 | 239000    | 13-Jun-20 | 03:54  | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3335.7 | 109456    | 13-Jun-20 | 03:46  | x64      |
| Datacollectortasks.dll                                      | 2017.140.3335.7 | 180624    | 13-Jun-20 | 03:46  | x64      |
| Distrib.exe                                                 | 2017.140.3335.7 | 198032    | 13-Jun-20 | 03:46  | x64      |
| Dteparse.dll                                                | 2017.140.3335.7 | 104336    | 13-Jun-20 | 03:46  | x64      |
| Dteparsemgd.dll                                             | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:54  | x64      |
| Dtepkg.dll                                                  | 2017.140.3335.7 | 130968    | 13-Jun-20 | 03:53  | x64      |
| Dtexec.exe                                                  | 2017.140.3335.7 | 66952     | 13-Jun-20 | 03:53  | x64      |
| Dts.dll                                                     | 2017.140.3335.7 | 2994072   | 13-Jun-20 | 03:53  | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3335.7 | 468368    | 13-Jun-20 | 03:46  | x64      |
| Dtsconn.dll                                                 | 2017.140.3335.7 | 493448    | 13-Jun-20 | 03:54  | x64      |
| Dtshost.exe                                                 | 2017.140.3335.7 | 99216     | 13-Jun-20 | 03:46  | x64      |
| Dtslog.dll                                                  | 2017.140.3335.7 | 113552    | 13-Jun-20 | 03:46  | x64      |
| Dtsmsg140.dll                                               | 2017.140.3335.7 | 538504    | 13-Jun-20 | 03:38  | x64      |
| Dtspipeline.dll                                             | 2017.140.3335.7 | 1261456   | 13-Jun-20 | 03:54  | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3335.7 | 41360     | 13-Jun-20 | 03:46  | x64      |
| Dtuparse.dll                                                | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:46  | x64      |
| Dtutil.exe                                                  | 2017.140.3335.7 | 141712    | 13-Jun-20 | 03:54  | x64      |
| Exceldest.dll                                               | 2017.140.3335.7 | 253832    | 13-Jun-20 | 03:54  | x64      |
| Excelsrc.dll                                                | 2017.140.3335.7 | 275856    | 13-Jun-20 | 03:46  | x64      |
| Execpackagetask.dll                                         | 2017.140.3335.7 | 161160    | 13-Jun-20 | 03:46  | x64      |
| Flatfiledest.dll                                            | 2017.140.3335.7 | 379784    | 13-Jun-20 | 03:53  | x64      |
| Flatfilesrc.dll                                             | 2017.140.3335.7 | 392584    | 13-Jun-20 | 03:54  | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3335.7 | 89480     | 13-Jun-20 | 03:46  | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3335.7 | 52632     | 13-Jun-20 | 03:46  | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 17-Apr-20 | 16:23 | x86      |
| Logread.exe                                                 | 2017.140.3335.7 | 629640    | 13-Jun-20 | 03:46  | x64      |
| Mergetxt.dll                                                | 2017.140.3335.7 | 58248     | 13-Jun-20 | 03:37  | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.51     | 1374608   | 13-Jun-20 | 03:31  | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 15-Apr-20 | 18:35 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3335.7     | 130960    | 13-Jun-20 | 03:38  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3335.7     | 48008     | 13-Jun-20 | 03:33  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3335.7     | 82824     | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3335.7     | 66448     | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3335.7     | 384904    | 13-Jun-20 | 04:07  | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3335.7     | 607120    | 13-Jun-20 | 03:46  | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3335.7 | 1657736   | 13-Jun-20 | 03:54  | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3335.7     | 564616    | 13-Jun-20 | 04:01  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3335.7 | 145296    | 13-Jun-20 | 03:53  | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3335.7 | 152456    | 13-Jun-20 | 03:53  | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3335.7 | 96152     | 13-Jun-20 | 03:46  | x64      |
| Msgprox.dll                                                 | 2017.140.3335.7 | 265104    | 13-Jun-20 | 03:46  | x64      |
| Msxmlsql.dll                                                | 2017.140.3335.7 | 1441160   | 13-Jun-20 | 03:46  | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 15-Apr-20 | 18:34 | x86      |
| Oledbdest.dll                                               | 2017.140.3335.7 | 254352    | 13-Jun-20 | 03:53  | x64      |
| Oledbsrc.dll                                                | 2017.140.3335.7 | 281992    | 13-Jun-20 | 03:54  | x64      |
| Osql.exe                                                    | 2017.140.3335.7 | 68496     | 13-Jun-20 | 03:38  | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3335.7 | 468872    | 13-Jun-20 | 03:46  | x64      |
| Rawdest.dll                                                 | 2017.140.3335.7 | 199560    | 13-Jun-20 | 03:46  | x64      |
| Rawsource.dll                                               | 2017.140.3335.7 | 187280    | 13-Jun-20 | 03:54  | x64      |
| Rdistcom.dll                                                | 2017.140.3335.7 | 852368    | 13-Jun-20 | 03:46  | x64      |
| Recordsetdest.dll                                           | 2017.140.3335.7 | 177552    | 13-Jun-20 | 03:46  | x64      |
| Replagnt.dll                                                | 2017.140.3335.7 | 23952     | 13-Jun-20 | 03:37  | x64      |
| Repldp.dll                                                  | 2017.140.3335.7 | 285576    | 13-Jun-20 | 03:37  | x64      |
| Replerrx.dll                                                | 2017.140.3335.7 | 148872    | 13-Jun-20 | 03:46  | x64      |
| Replisapi.dll                                               | 2017.140.3335.7 | 357264    | 13-Jun-20 | 03:46  | x64      |
| Replmerg.exe                                                | 2017.140.3335.7 | 520072    | 13-Jun-20 | 03:46  | x64      |
| Replprov.dll                                                | 2017.140.3335.7 | 797072    | 13-Jun-20 | 03:46  | x64      |
| Replrec.dll                                                 | 2017.140.3335.7 | 970120    | 13-Jun-20 | 03:46  | x64      |
| Replsub.dll                                                 | 2017.140.3335.7 | 440208    | 13-Jun-20 | 03:46  | x64      |
| Replsync.dll                                                | 2017.140.3335.7 | 148360    | 13-Jun-20 | 03:46  | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 15-Apr-20 | 18:36 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 15-Apr-20 | 18:36 | x64      |
| Spresolv.dll                                                | 2017.140.3335.7 | 247176    | 13-Jun-20 | 03:46  | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqlcmd.exe                                                  | 2017.140.3335.7 | 242056    | 13-Jun-20 | 03:37  | x64      |
| Sqldiag.exe                                                 | 2017.140.3335.7 | 1254792   | 13-Jun-20 | 03:37  | x64      |
| Sqldistx.dll                                                | 2017.140.3335.7 | 219536    | 13-Jun-20 | 03:46  | x64      |
| Sqllogship.exe                                              | 14.0.3335.7     | 98712     | 13-Jun-20 | 03:38  | x64      |
| Sqlmergx.dll                                                | 2017.140.3335.7 | 355216    | 13-Jun-20 | 03:46  | x64      |
| Sqlresld.dll                                                | 2017.140.3335.7 | 23960     | 13-Jun-20 | 03:31  | x64      |
| Sqlresld.dll                                                | 2017.140.3335.7 | 21904     | 13-Jun-20 | 03:37  | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3335.7 | 22424     | 13-Jun-20 | 03:31  | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3335.7 | 25488     | 13-Jun-20 | 03:33  | x64      |
| Sqlscm.dll                                                  | 2017.140.3335.7 | 65936     | 13-Jun-20 | 03:37  | x64      |
| Sqlscm.dll                                                  | 2017.140.3335.7 | 55176     | 13-Jun-20 | 03:37  | x86      |
| Sqlsvc.dll                                                  | 2017.140.3335.7 | 128400    | 13-Jun-20 | 03:46  | x86      |
| Sqlsvc.dll                                                  | 2017.140.3335.7 | 156056    | 13-Jun-20 | 03:46  | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3335.7 | 177040    | 13-Jun-20 | 03:46  | x64      |
| Sqlwep140.dll                                               | 2017.140.3335.7 | 98704     | 13-Jun-20 | 03:33  | x64      |
| Ssdebugps.dll                                               | 2017.140.3335.7 | 26512     | 13-Jun-20 | 03:46  | x64      |
| Ssisoledb.dll                                               | 2017.140.3335.7 | 209288    | 13-Jun-20 | 03:46  | x64      |
| Ssradd.dll                                                  | 2017.140.3335.7 | 70024     | 13-Jun-20 | 03:37  | x64      |
| Ssravg.dll                                                  | 2017.140.3335.7 | 70536     | 13-Jun-20 | 03:38  | x64      |
| Ssrdown.dll                                                 | 2017.140.3335.7 | 55192     | 13-Jun-20 | 03:37  | x64      |
| Ssrmax.dll                                                  | 2017.140.3335.7 | 68496     | 13-Jun-20 | 03:38  | x64      |
| Ssrmin.dll                                                  | 2017.140.3335.7 | 68496     | 13-Jun-20 | 03:46  | x64      |
| Ssrpub.dll                                                  | 2017.140.3335.7 | 55688     | 13-Jun-20 | 03:37  | x64      |
| Ssrup.dll                                                   | 2017.140.3335.7 | 55176     | 13-Jun-20 | 03:37  | x64      |
| Tablediff.exe                                               | 14.0.3335.7     | 79760     | 13-Jun-20 | 03:31  | x64      |
| Txagg.dll                                                   | 2017.140.3335.7 | 355208    | 13-Jun-20 | 03:46  | x64      |
| Txbdd.dll                                                   | 2017.140.3335.7 | 163216    | 13-Jun-20 | 03:46  | x64      |
| Txdatacollector.dll                                         | 2017.140.3335.7 | 353680    | 13-Jun-20 | 03:46  | x64      |
| Txdataconvert.dll                                           | 2017.140.3335.7 | 286088    | 13-Jun-20 | 03:46  | x64      |
| Txderived.dll                                               | 2017.140.3335.7 | 597392    | 13-Jun-20 | 03:46  | x64      |
| Txlookup.dll                                                | 2017.140.3335.7 | 521096    | 13-Jun-20 | 03:46  | x64      |
| Txmerge.dll                                                 | 2017.140.3335.7 | 223112    | 13-Jun-20 | 03:54  | x64      |
| Txmergejoin.dll                                             | 2017.140.3335.7 | 268680    | 13-Jun-20 | 03:54  | x64      |
| Txmulticast.dll                                             | 2017.140.3335.7 | 120720    | 13-Jun-20 | 03:46  | x64      |
| Txrowcount.dll                                              | 2017.140.3335.7 | 118664    | 13-Jun-20 | 03:54  | x64      |
| Txsort.dll                                                  | 2017.140.3335.7 | 249744    | 13-Jun-20 | 03:54  | x64      |
| Txsplit.dll                                                 | 2017.140.3335.7 | 589704    | 13-Jun-20 | 03:54  | x64      |
| Txunionall.dll                                              | 2017.140.3335.7 | 174992    | 13-Jun-20 | 03:46  | x64      |
| Xe.dll                                                      | 2017.140.3335.7 | 666504    | 13-Jun-20 | 03:37  | x64      |
| Xmlrw.dll                                                   | 2017.140.3335.7 | 298384    | 13-Jun-20 | 03:46  | x64      |
| Xmlsub.dll                                                  | 2017.140.3335.7 | 255376    | 13-Jun-20 | 03:37  | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3335.7 | 1119120   | 13-Jun-20 | 04:13 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |
| Sqlsatellite.dll              | 2017.140.3335.7 | 916872    | 13-Jun-20 | 04:07 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time  | Platform |
|--------------------------|-----------------|-----------|-----------|-------|----------|
| Fd.dll                   | 2017.140.3335.7 | 665480    | 13-Jun-20 | 03:46  | x64      |
| Fdhost.exe               | 2017.140.3335.7 | 109456    | 13-Jun-20 | 03:54  | x64      |
| Fdlauncher.exe           | 2017.140.3335.7 | 57232     | 13-Jun-20 | 03:37  | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 15-Apr-20 | 18:36 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqlft140ph.dll           | 2017.140.3335.7 | 62864     | 13-Jun-20 | 03:33  | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3335.7     | 16784     | 13-Jun-20 | 03:38 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time  | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|-------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 15-Apr-20 | 18:34 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 15-Apr-20 | 18:35 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 15-Apr-20 | 18:35 | x86      |
| Commanddest.dll                                               | 2017.140.3335.7 | 239000    | 13-Jun-20 | 03:54  | x64      |
| Commanddest.dll                                               | 2017.140.3335.7 | 193936    | 13-Jun-20 | 03:54  | x86      |
| Dteparse.dll                                                  | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:45  | x86      |
| Dteparse.dll                                                  | 2017.140.3335.7 | 104336    | 13-Jun-20 | 03:46  | x64      |
| Dteparsemgd.dll                                               | 2017.140.3335.7 | 76680     | 13-Jun-20 | 03:45  | x86      |
| Dteparsemgd.dll                                               | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:54  | x64      |
| Dtepkg.dll                                                    | 2017.140.3335.7 | 130968    | 13-Jun-20 | 03:53  | x64      |
| Dtepkg.dll                                                    | 2017.140.3335.7 | 109968    | 13-Jun-20 | 03:54  | x86      |
| Dtexec.exe                                                    | 2017.140.3335.7 | 66952     | 13-Jun-20 | 03:53  | x64      |
| Dtexec.exe                                                    | 2017.140.3335.7 | 60808     | 13-Jun-20 | 03:54  | x86      |
| Dts.dll                                                       | 2017.140.3335.7 | 2994072   | 13-Jun-20 | 03:53  | x64      |
| Dts.dll                                                       | 2017.140.3335.7 | 2544024   | 13-Jun-20 | 03:54  | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3335.7 | 411024    | 13-Jun-20 | 03:45  | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3335.7 | 468368    | 13-Jun-20 | 03:46  | x64      |
| Dtsconn.dll                                                   | 2017.140.3335.7 | 395672    | 13-Jun-20 | 03:53  | x86      |
| Dtsconn.dll                                                   | 2017.140.3335.7 | 493448    | 13-Jun-20 | 03:54  | x64      |
| Dtsdebughost.exe                                              | 2017.140.3335.7 | 88464     | 13-Jun-20 | 03:46  | x86      |
| Dtsdebughost.exe                                              | 2017.140.3335.7 | 104328    | 13-Jun-20 | 03:46  | x64      |
| Dtshost.exe                                                   | 2017.140.3335.7 | 84368     | 13-Jun-20 | 03:46  | x86      |
| Dtshost.exe                                                   | 2017.140.3335.7 | 99216     | 13-Jun-20 | 03:46  | x64      |
| Dtslog.dll                                                    | 2017.140.3335.7 | 113552    | 13-Jun-20 | 03:46  | x64      |
| Dtslog.dll                                                    | 2017.140.3335.7 | 96136     | 13-Jun-20 | 03:54  | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3335.7 | 534424    | 13-Jun-20 | 03:37  | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3335.7 | 538504    | 13-Jun-20 | 03:38  | x64      |
| Dtspipeline.dll                                               | 2017.140.3335.7 | 1053576   | 13-Jun-20 | 03:53  | x86      |
| Dtspipeline.dll                                               | 2017.140.3335.7 | 1261456   | 13-Jun-20 | 03:54  | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3335.7 | 41360     | 13-Jun-20 | 03:46  | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3335.7 | 35728     | 13-Jun-20 | 03:54  | x86      |
| Dtuparse.dll                                                  | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:46  | x64      |
| Dtuparse.dll                                                  | 2017.140.3335.7 | 73104     | 13-Jun-20 | 03:53  | x86      |
| Dtutil.exe                                                    | 2017.140.3335.7 | 120712    | 13-Jun-20 | 03:54  | x86      |
| Dtutil.exe                                                    | 2017.140.3335.7 | 141712    | 13-Jun-20 | 03:54  | x64      |
| Exceldest.dll                                                 | 2017.140.3335.7 | 207752    | 13-Jun-20 | 03:45  | x86      |
| Exceldest.dll                                                 | 2017.140.3335.7 | 253832    | 13-Jun-20 | 03:54  | x64      |
| Excelsrc.dll                                                  | 2017.140.3335.7 | 223632    | 13-Jun-20 | 03:45  | x86      |
| Excelsrc.dll                                                  | 2017.140.3335.7 | 275856    | 13-Jun-20 | 03:46  | x64      |
| Execpackagetask.dll                                           | 2017.140.3335.7 | 128408    | 13-Jun-20 | 03:46  | x86      |
| Execpackagetask.dll                                           | 2017.140.3335.7 | 161160    | 13-Jun-20 | 03:46  | x64      |
| Flatfiledest.dll                                              | 2017.140.3335.7 | 325520    | 13-Jun-20 | 03:53  | x86      |
| Flatfiledest.dll                                              | 2017.140.3335.7 | 379784    | 13-Jun-20 | 03:53  | x64      |
| Flatfilesrc.dll                                               | 2017.140.3335.7 | 337304    | 13-Jun-20 | 03:53  | x86      |
| Flatfilesrc.dll                                               | 2017.140.3335.7 | 392584    | 13-Jun-20 | 03:54  | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3335.7 | 73624     | 13-Jun-20 | 03:46  | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3335.7 | 89480     | 13-Jun-20 | 03:46  | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 17-Apr-20 | 16:23 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3335.7     | 460176    | 13-Jun-20 | 04:19  | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3335.7     | 459656    | 13-Jun-20 | 04:24  | x64      |
| Isserverexec.exe                                              | 14.0.3335.7     | 141712    | 13-Jun-20 | 03:53  | x64      |
| Isserverexec.exe                                              | 14.0.3335.7     | 142224    | 13-Jun-20 | 03:53  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.51     | 1374608   | 13-Jun-20 | 03:31  | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.51     | 1374608   | 13-Jun-20 | 03:32  | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 15-Apr-20 | 18:50 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 15-Apr-20 | 18:35 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3335.7     | 67456     | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3335.7 | 105360    | 13-Jun-20 | 03:46  | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3335.7 | 100248    | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3335.7     | 48008     | 13-Jun-20 | 03:33  | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3335.7     | 48016     | 13-Jun-20 | 03:37  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3335.7     | 82824     | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3335.7     | 82832     | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3335.7     | 66440     | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3335.7     | 66448     | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3335.7     | 507280    | 13-Jun-20 | 03:33  | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3335.7     | 507280    | 13-Jun-20 | 03:33  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3335.7     | 76688     | 13-Jun-20 | 03:46  | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3335.7     | 76688     | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3335.7     | 408976    | 13-Jun-20 | 04:19  | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3335.7     | 408968    | 13-Jun-20 | 04:24  | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3335.7     | 384904    | 13-Jun-20 | 04:07  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3335.7     | 607120    | 13-Jun-20 | 03:46  | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3335.7     | 607120    | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3335.7     | 245640    | 13-Jun-20 | 03:46  | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3335.7     | 245640    | 13-Jun-20 | 03:53  | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3335.7 | 145296    | 13-Jun-20 | 03:53  | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3335.7 | 135048    | 13-Jun-20 | 03:54  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3335.7 | 138632    | 13-Jun-20 | 03:45  | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3335.7 | 152456    | 13-Jun-20 | 03:53  | x64      |
| Msdtssrvr.exe                                                 | 14.0.3335.7     | 212872    | 13-Jun-20 | 03:54  | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3335.7 | 96152     | 13-Jun-20 | 03:46  | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3335.7 | 83344     | 13-Jun-20 | 03:53  | x86      |
| Msmdpp.dll                                                    | 2017.140.249.51 | 9191824   | 13-Jun-20 | 03:31  | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 15-Apr-20 | 18:34 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 15-Apr-20 | 18:35 | x86      |
| Oledbdest.dll                                                 | 2017.140.3335.7 | 254352    | 13-Jun-20 | 03:53  | x64      |
| Oledbdest.dll                                                 | 2017.140.3335.7 | 207768    | 13-Jun-20 | 03:54  | x86      |
| Oledbsrc.dll                                                  | 2017.140.3335.7 | 226184    | 13-Jun-20 | 03:45  | x86      |
| Oledbsrc.dll                                                  | 2017.140.3335.7 | 281992    | 13-Jun-20 | 03:54  | x64      |
| Rawdest.dll                                                   | 2017.140.3335.7 | 199560    | 13-Jun-20 | 03:46  | x64      |
| Rawdest.dll                                                   | 2017.140.3335.7 | 159624    | 13-Jun-20 | 03:46  | x86      |
| Rawsource.dll                                                 | 2017.140.3335.7 | 146312    | 13-Jun-20 | 03:53  | x86      |
| Rawsource.dll                                                 | 2017.140.3335.7 | 187280    | 13-Jun-20 | 03:54  | x64      |
| Recordsetdest.dll                                             | 2017.140.3335.7 | 142224    | 13-Jun-20 | 03:46  | x86      |
| Recordsetdest.dll                                             | 2017.140.3335.7 | 177552    | 13-Jun-20 | 03:46  | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37  | x64      |
| Sqlceip.exe                                                   | 14.0.3335.7     | 254864    | 13-Jun-20 | 03:54  | x86      |
| Sqldest.dll                                                   | 2017.140.3335.7 | 206728    | 13-Jun-20 | 03:53  | x86      |
| Sqldest.dll                                                   | 2017.140.3335.7 | 253848    | 13-Jun-20 | 03:54  | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3335.7 | 148368    | 13-Jun-20 | 03:46  | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3335.7 | 177040    | 13-Jun-20 | 03:46  | x64      |
| Ssisoledb.dll                                                 | 2017.140.3335.7 | 209288    | 13-Jun-20 | 03:46  | x64      |
| Ssisoledb.dll                                                 | 2017.140.3335.7 | 169872    | 13-Jun-20 | 03:53  | x86      |
| Txagg.dll                                                     | 2017.140.3335.7 | 295312    | 13-Jun-20 | 03:46  | x86      |
| Txagg.dll                                                     | 2017.140.3335.7 | 355208    | 13-Jun-20 | 03:46  | x64      |
| Txbdd.dll                                                     | 2017.140.3335.7 | 163216    | 13-Jun-20 | 03:46  | x64      |
| Txbdd.dll                                                     | 2017.140.3335.7 | 129424    | 13-Jun-20 | 03:46  | x86      |
| Txbestmatch.dll                                               | 2017.140.3335.7 | 486288    | 13-Jun-20 | 03:46  | x86      |
| Txbestmatch.dll                                               | 2017.140.3335.7 | 598416    | 13-Jun-20 | 03:54  | x64      |
| Txcache.dll                                                   | 2017.140.3335.7 | 139152    | 13-Jun-20 | 03:46  | x86      |
| Txcache.dll                                                   | 2017.140.3335.7 | 173456    | 13-Jun-20 | 03:54  | x64      |
| Txcharmap.dll                                                 | 2017.140.3335.7 | 242064    | 13-Jun-20 | 03:46  | x86      |
| Txcharmap.dll                                                 | 2017.140.3335.7 | 279952    | 13-Jun-20 | 03:46  | x64      |
| Txcopymap.dll                                                 | 2017.140.3335.7 | 173464    | 13-Jun-20 | 03:46  | x64      |
| Txcopymap.dll                                                 | 2017.140.3335.7 | 138640    | 13-Jun-20 | 03:54  | x86      |
| Txdataconvert.dll                                             | 2017.140.3335.7 | 246152    | 13-Jun-20 | 03:46  | x86      |
| Txdataconvert.dll                                             | 2017.140.3335.7 | 286088    | 13-Jun-20 | 03:46  | x64      |
| Txderived.dll                                                 | 2017.140.3335.7 | 508816    | 13-Jun-20 | 03:46  | x86      |
| Txderived.dll                                                 | 2017.140.3335.7 | 597392    | 13-Jun-20 | 03:46  | x64      |
| Txfileextractor.dll                                           | 2017.140.3335.7 | 153992    | 13-Jun-20 | 03:46  | x86      |
| Txfileextractor.dll                                           | 2017.140.3335.7 | 191880    | 13-Jun-20 | 03:54  | x64      |
| Txfileinserter.dll                                            | 2017.140.3335.7 | 152464    | 13-Jun-20 | 03:53  | x86      |
| Txfileinserter.dll                                            | 2017.140.3335.7 | 189840    | 13-Jun-20 | 03:54  | x64      |
| Txgroupdups.dll                                               | 2017.140.3335.7 | 224136    | 13-Jun-20 | 03:46  | x86      |
| Txgroupdups.dll                                               | 2017.140.3335.7 | 283544    | 13-Jun-20 | 03:54  | x64      |
| Txlineage.dll                                                 | 2017.140.3335.7 | 103320    | 13-Jun-20 | 03:53  | x86      |
| Txlineage.dll                                                 | 2017.140.3335.7 | 129928    | 13-Jun-20 | 03:54  | x64      |
| Txlookup.dll                                                  | 2017.140.3335.7 | 521096    | 13-Jun-20 | 03:46  | x64      |
| Txlookup.dll                                                  | 2017.140.3335.7 | 439696    | 13-Jun-20 | 03:53  | x86      |
| Txmerge.dll                                                   | 2017.140.3335.7 | 169864    | 13-Jun-20 | 03:46  | x86      |
| Txmerge.dll                                                   | 2017.140.3335.7 | 223112    | 13-Jun-20 | 03:54  | x64      |
| Txmergejoin.dll                                               | 2017.140.3335.7 | 214920    | 13-Jun-20 | 03:46  | x86      |
| Txmergejoin.dll                                               | 2017.140.3335.7 | 268680    | 13-Jun-20 | 03:54  | x64      |
| Txmulticast.dll                                               | 2017.140.3335.7 | 120720    | 13-Jun-20 | 03:46  | x64      |
| Txmulticast.dll                                               | 2017.140.3335.7 | 95632     | 13-Jun-20 | 03:46  | x86      |
| Txpivot.dll                                                   | 2017.140.3335.7 | 173456    | 13-Jun-20 | 03:46  | x86      |
| Txpivot.dll                                                   | 2017.140.3335.7 | 218000    | 13-Jun-20 | 03:54  | x64      |
| Txrowcount.dll                                                | 2017.140.3335.7 | 94616     | 13-Jun-20 | 03:53  | x86      |
| Txrowcount.dll                                                | 2017.140.3335.7 | 118664    | 13-Jun-20 | 03:54  | x64      |
| Txsampling.dll                                                | 2017.140.3335.7 | 128904    | 13-Jun-20 | 03:46  | x86      |
| Txsampling.dll                                                | 2017.140.3335.7 | 165784    | 13-Jun-20 | 03:46  | x64      |
| Txscd.dll                                                     | 2017.140.3335.7 | 163208    | 13-Jun-20 | 03:46  | x86      |
| Txscd.dll                                                     | 2017.140.3335.7 | 213904    | 13-Jun-20 | 03:46  | x64      |
| Txsort.dll                                                    | 2017.140.3335.7 | 201096    | 13-Jun-20 | 03:54  | x86      |
| Txsort.dll                                                    | 2017.140.3335.7 | 249744    | 13-Jun-20 | 03:54  | x64      |
| Txsplit.dll                                                   | 2017.140.3335.7 | 503696    | 13-Jun-20 | 03:53  | x86      |
| Txsplit.dll                                                   | 2017.140.3335.7 | 589704    | 13-Jun-20 | 03:54  | x64      |
| Txtermextraction.dll                                          | 2017.140.3335.7 | 8608144   | 13-Jun-20 | 03:53  | x86      |
| Txtermextraction.dll                                          | 2017.140.3335.7 | 8669576   | 13-Jun-20 | 03:54  | x64      |
| Txtermlookup.dll                                              | 2017.140.3335.7 | 4099976   | 13-Jun-20 | 03:53  | x86      |
| Txtermlookup.dll                                              | 2017.140.3335.7 | 4150168   | 13-Jun-20 | 03:54  | x64      |
| Txunionall.dll                                                | 2017.140.3335.7 | 132488    | 13-Jun-20 | 03:46  | x86      |
| Txunionall.dll                                                | 2017.140.3335.7 | 174992    | 13-Jun-20 | 03:46  | x64      |
| Txunpivot.dll                                                 | 2017.140.3335.7 | 192904    | 13-Jun-20 | 03:46  | x64      |
| Txunpivot.dll                                                 | 2017.140.3335.7 | 153496    | 13-Jun-20 | 03:54  | x86      |
| Xe.dll                                                        | 2017.140.3335.7 | 666504    | 13-Jun-20 | 03:37  | x64      |
| Xe.dll                                                        | 2017.140.3335.7 | 588680    | 13-Jun-20 | 03:37  | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time  | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|-------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 17-Apr-20 | 17:34 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 17-Apr-20 | 17:33 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 17-Apr-20 | 17:34 | x86      |
| Instapi140.dll                                                       | 2017.140.3335.7  | 65424     | 13-Jun-20 | 03:37  | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 17-Apr-20 | 17:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 17-Apr-20 | 17:48 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 17-Apr-20 | 17:49 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 17-Apr-20 | 17:34 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 17-Apr-20 | 17:34 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3335.7  | 400272    | 13-Jun-20 | 03:54  | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3335.7  | 7321488   | 13-Jun-20 | 04:13  | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3335.7  | 2257800   | 13-Jun-20 | 03:46  | x64      |
| Secforwarder.dll                                                     | 2017.140.3335.7  | 30608     | 13-Jun-20 | 03:53  | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 17-Apr-20 | 16:41 | x64      |
| Sqldk.dll                                                            | 2017.140.3335.7  | 2732944   | 13-Jun-20 | 04:19  | x64      |
| Sqldumper.exe                                                        | 2017.140.3335.7  | 138632    | 13-Jun-20 | 03:45  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 1493904   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3914128   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3212176   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3917184   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3820432   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 2086792   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 2033032   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3587976   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3595664   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 1441168   | 13-Jun-20 | 03:37  | x64      |
| Sqlevn70.rll                                                         | 2017.140.3335.7  | 3784584   | 13-Jun-20 | 03:37  | x64      |
| Sqlos.dll                                                            | 2017.140.3335.7  | 19344     | 13-Jun-20 | 03:46  | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 17-Apr-20 | 17:33 | x64      |
| Sqltses.dll                                                          | 2017.140.3335.7  | 9729416   | 13-Jun-20 | 04:19  | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3335.7     | 16776     | 13-Jun-20 | 03:46 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version    | File size | Date      | Time | Platform |
|--------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                          | 2017.140.3335.7 | 1441680   | 13-Jun-20 | 03:53 | x86      |
| Dtaengine.exe                                          | 2017.140.3335.7 | 197520    | 13-Jun-20 | 03:53 | x86      |
| Dteparse.dll                                           | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:45 | x86      |
| Dteparse.dll                                           | 2017.140.3335.7 | 104336    | 13-Jun-20 | 03:46 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3335.7 | 76680     | 13-Jun-20 | 03:45 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:54 | x64      |
| Dtepkg.dll                                             | 2017.140.3335.7 | 130968    | 13-Jun-20 | 03:53 | x64      |
| Dtepkg.dll                                             | 2017.140.3335.7 | 109968    | 13-Jun-20 | 03:54 | x86      |
| Dtexec.exe                                             | 2017.140.3335.7 | 66952     | 13-Jun-20 | 03:53 | x64      |
| Dtexec.exe                                             | 2017.140.3335.7 | 60808     | 13-Jun-20 | 03:54 | x86      |
| Dts.dll                                                | 2017.140.3335.7 | 2994072   | 13-Jun-20 | 03:53 | x64      |
| Dts.dll                                                | 2017.140.3335.7 | 2544024   | 13-Jun-20 | 03:54 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3335.7 | 411024    | 13-Jun-20 | 03:45 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3335.7 | 468368    | 13-Jun-20 | 03:46 | x64      |
| Dtsconn.dll                                            | 2017.140.3335.7 | 395672    | 13-Jun-20 | 03:53 | x86      |
| Dtsconn.dll                                            | 2017.140.3335.7 | 493448    | 13-Jun-20 | 03:54 | x64      |
| Dtshost.exe                                            | 2017.140.3335.7 | 84368     | 13-Jun-20 | 03:46 | x86      |
| Dtshost.exe                                            | 2017.140.3335.7 | 99216     | 13-Jun-20 | 03:46 | x64      |
| Dtslog.dll                                             | 2017.140.3335.7 | 113552    | 13-Jun-20 | 03:46 | x64      |
| Dtslog.dll                                             | 2017.140.3335.7 | 96136     | 13-Jun-20 | 03:54 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3335.7 | 534424    | 13-Jun-20 | 03:37 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3335.7 | 538504    | 13-Jun-20 | 03:38 | x64      |
| Dtspipeline.dll                                        | 2017.140.3335.7 | 1053576   | 13-Jun-20 | 03:53 | x86      |
| Dtspipeline.dll                                        | 2017.140.3335.7 | 1261456   | 13-Jun-20 | 03:54 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3335.7 | 41360     | 13-Jun-20 | 03:46 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3335.7 | 35728     | 13-Jun-20 | 03:54 | x86      |
| Dtuparse.dll                                           | 2017.140.3335.7 | 82312     | 13-Jun-20 | 03:46 | x64      |
| Dtuparse.dll                                           | 2017.140.3335.7 | 73104     | 13-Jun-20 | 03:53 | x86      |
| Dtutil.exe                                             | 2017.140.3335.7 | 120712    | 13-Jun-20 | 03:54 | x86      |
| Dtutil.exe                                             | 2017.140.3335.7 | 141712    | 13-Jun-20 | 03:54 | x64      |
| Exceldest.dll                                          | 2017.140.3335.7 | 207752    | 13-Jun-20 | 03:45 | x86      |
| Exceldest.dll                                          | 2017.140.3335.7 | 253832    | 13-Jun-20 | 03:54 | x64      |
| Excelsrc.dll                                           | 2017.140.3335.7 | 223632    | 13-Jun-20 | 03:45 | x86      |
| Excelsrc.dll                                           | 2017.140.3335.7 | 275856    | 13-Jun-20 | 03:46 | x64      |
| Flatfiledest.dll                                       | 2017.140.3335.7 | 325520    | 13-Jun-20 | 03:53 | x86      |
| Flatfiledest.dll                                       | 2017.140.3335.7 | 379784    | 13-Jun-20 | 03:53 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3335.7 | 337304    | 13-Jun-20 | 03:53 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3335.7 | 392584    | 13-Jun-20 | 03:54 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3335.7 | 73624     | 13-Jun-20 | 03:46 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3335.7 | 89480     | 13-Jun-20 | 03:46 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3335.7     | 67464     | 13-Jun-20 | 03:54 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3335.7     | 179592    | 13-Jun-20 | 04:30 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3335.7     | 402824    | 13-Jun-20 | 03:46 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3335.7     | 402824    | 13-Jun-20 | 03:46 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3335.7     | 2086288   | 13-Jun-20 | 03:46 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3335.7     | 2086280   | 13-Jun-20 | 03:54 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3335.7     | 607120    | 13-Jun-20 | 03:46 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3335.7     | 607120    | 13-Jun-20 | 03:54 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3335.7     | 245640    | 13-Jun-20 | 03:53 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3335.7 | 145296    | 13-Jun-20 | 03:53 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3335.7 | 135048    | 13-Jun-20 | 03:54 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3335.7 | 138632    | 13-Jun-20 | 03:45 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3335.7 | 152456    | 13-Jun-20 | 03:53 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3335.7 | 96152     | 13-Jun-20 | 03:46 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3335.7 | 83344     | 13-Jun-20 | 03:53 | x86      |
| Msmgdsrv.dll                                           | 2017.140.249.51 | 7304584   | 13-Jun-20 | 03:33 | x86      |
| Oledbdest.dll                                          | 2017.140.3335.7 | 254352    | 13-Jun-20 | 03:53 | x64      |
| Oledbdest.dll                                          | 2017.140.3335.7 | 207768    | 13-Jun-20 | 03:54 | x86      |
| Oledbsrc.dll                                           | 2017.140.3335.7 | 226184    | 13-Jun-20 | 03:45 | x86      |
| Oledbsrc.dll                                           | 2017.140.3335.7 | 281992    | 13-Jun-20 | 03:54 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3335.7 | 93584     | 13-Jun-20 | 03:37 | x64      |
| Sqlresld.dll                                           | 2017.140.3335.7 | 23960     | 13-Jun-20 | 03:31 | x64      |
| Sqlresld.dll                                           | 2017.140.3335.7 | 21904     | 13-Jun-20 | 03:37 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3335.7 | 22424     | 13-Jun-20 | 03:31 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3335.7 | 25488     | 13-Jun-20 | 03:33 | x64      |
| Sqlscm.dll                                             | 2017.140.3335.7 | 65936     | 13-Jun-20 | 03:37 | x64      |
| Sqlscm.dll                                             | 2017.140.3335.7 | 55176     | 13-Jun-20 | 03:37 | x86      |
| Sqlsvc.dll                                             | 2017.140.3335.7 | 128400    | 13-Jun-20 | 03:46 | x86      |
| Sqlsvc.dll                                             | 2017.140.3335.7 | 156056    | 13-Jun-20 | 03:46 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3335.7 | 148368    | 13-Jun-20 | 03:46 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3335.7 | 177040    | 13-Jun-20 | 03:46 | x64      |
| Txdataconvert.dll                                      | 2017.140.3335.7 | 246152    | 13-Jun-20 | 03:46 | x86      |
| Txdataconvert.dll                                      | 2017.140.3335.7 | 286088    | 13-Jun-20 | 03:46 | x64      |
| Xe.dll                                                 | 2017.140.3335.7 | 666504    | 13-Jun-20 | 03:37 | x64      |
| Xe.dll                                                 | 2017.140.3335.7 | 588680    | 13-Jun-20 | 03:37 | x86      |
| Xmlrw.dll                                              | 2017.140.3335.7 | 250768    | 13-Jun-20 | 03:38 | x86      |
| Xmlrw.dll                                              | 2017.140.3335.7 | 298384    | 13-Jun-20 | 03:46 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3335.7 | 182672    | 13-Jun-20 | 03:38 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3335.7 | 217488    | 13-Jun-20 | 03:46 | x64      |

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
