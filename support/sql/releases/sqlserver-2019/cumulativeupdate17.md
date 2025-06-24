---
title: Cumulative update 17 for SQL Server 2019 (KB5016394)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 17 (KB5016394).
ms.date: 05/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5016394
ms.reviewer: v-cuichen
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5016394 - Cumulative Update 17 for SQL Server 2019

_Release Date:_ &nbsp; August 11, 2022  
_Version:_ &nbsp; 15.0.4249.2

## Summary

This article describes Cumulative Update package 17 (CU17) for Microsoft SQL Server 2019. This update contains 39 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 16, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4249.2**, file version: **2019.150.4249.2**
- Analysis Services - Product version: **15.0.35.33**, file version: **2018.150.35.33**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="14729381">[14729381](#14729381)</a> | Adds support for the missing "`Implementation`" parameter when you use the SharePoint Online Lists. | Analysis Services | Analysis Services | Windows |
| <a id="14915048">[14915048](#14915048)</a> | Resolves the Denial of Service (DoS) vulnerability for the Newtonsoft library in SQL Server 2019. | Analysis Services | Analysis Services | Windows |
| <a id="14507664">[14507664](#14507664)</a> | An error occurs when you execute the `internal.cleanup_server_log` stored procedure in the SSISDB database. Here's the error message: </br></br>#MS_SSISServerCleanupJobLogin##. A cursor with the name 'execution_cursor' does not exist. [SQLSTATE 34000] (Error 16916) | Integration Services | Server | Windows |
| <a id="14676485">[14676485](#14676485)</a> | Error 9003 occurs with the incorrect log sequence number (LSN) when you do a subsequent restore after specifying the LSN at the virtual log file (VLF) boundary by using the `RESTORE WITH STANDBY` statement. Here's the error message: </br></br>Msg 3013, Level 16, State 1, Line \<LineNumber> </br>RESTORE DATABASE is terminating abnormally. </br></br>Msg 9003, Level 17, State 11, Line \<LineNumber> </br>The log scan number (\<LogScanNumber>) passed to log scan in database '\<DatabaseName>' is not valid. This error may indicate data corruption or that the log file (.ldf) does not match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup. | SQL Server Engine | Backup Restore | Windows |
| <a id="14692739">[14692739](#14692739)</a> | [FIX: Access violation dump file occurs during a columnstore index scan (KB5017100)](https://support.microsoft.com/help/5017100) | SQL Server Engine | Column Stores | All |
| <a id="14856153">[14856153](#14856153)</a> | The last-chance exception handling for a Columnstore index occurs after a log-full 9002 error. | SQL Server Engine | Column Stores | All |
| <a id="14899781">[14899781](#14899781)</a> | [Improvement: Enable distributed availability groups on SQL Server Standard editions (KB5016729)](https://support.microsoft.com/help/5016729) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="14638786">[14638786](#14638786)</a> | The dynamic management view (DMV) `sys.dm_hadr_availability_replica_cluster_nodes` returns the invalid `node_name` for certain queries after applying SQL Server 2019 Cumulative Update 14 (CU14). | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14758810">[14758810](#14758810)</a> | A database may fail to resume synchronization during the failover of an Always On availability group because the session working on the database synchronization or recovery is killed by another session. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="14780760">[14780760](#14780760)</a> | An assertion dump occurs in `sqlmin!BOSLockThreadHashTable::AddEntry` during a log backup on a secondary replica of an availability group. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="14812570">[14812570](#14812570)</a> | A latch time-out occurs and the IOCP listener stalls when Service Broker connects to an endpoint by using database mirroring. </br></br>**Note**: This fix is available when TF 12323 is enabled. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="14860468">[14860468](#14860468)</a> | The read-only request still goes to the read-write primary node in an Always On availability group when the read-only routing list node goes down. | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="14910661">[14910661](#14910661)</a> | A memory leak occurs under "Range Index Heap" on the in-memory table that has non-clustered indexes, whenever there are concurrent inserts. | SQL Server Engine | In-Memory OLTP | All |
| <a id="14923176">[14923176](#14923176)</a> | A memory leak occurs in the range index of in-memory tables after the parallel index scan. | SQL Server Engine | In-Memory OLTP | All |
| <a id="14350896">[14350896](#14350896)</a> | Improves the response time of the system view `sys.spt_columns_odbc_view` on Linux. | SQL Server Engine | Linux | Linux |
| <a id="14826907">[14826907](#14826907)</a> | Incorrect reporting of physical sector size for Linux block devices can cause unexpected "misaligned log IOs" warnings for log shipping and Always On availability groups. | SQL Server Engine | Linux | Linux |
| <a id="14679511">[14679511](#14679511)</a> | This fix resolves the following issues: </br></br>- An online index rebuild may not finish when the database is using the simple recovery model. </br></br>- An assertion failure about the latch owner occurs when you reorganize an index. | SQL Server Engine | Methods to access stored data | All |
| <a id="14708235">[14708235](#14708235)</a> | Traversing long IAM chains may cause a non-yielding scheduler and associated dump. | SQL Server Engine | Methods to access stored data | All |
| <a id="14862654">[14862654](#14862654)</a> | An access violation occurs when `XVBChainTails::UpdateChainTails` updates `m_pNewVersionChainTailInsert` and `m_pOldVersionChainTailInsert` and these values aren't allocated. | SQL Server Engine | Methods to access stored data | All |
| <a id="14537603">[14537603](#14537603)</a> | The optimizer may fail to produce the plan and throw an error when you enable the Scalar User-Defined Function (UDF) Inlining feature and try to update a partitioned view by using the output of the UDF. Here's the error message: </br></br>Msg 8624, Level 16, State 21, Line \<LineNumber> </br>Internal Query Processor Error: The query processor could not produce a query plan. For more information, contact Customer Support Services. | SQL Server Engine | Programmability | Windows |
| <a id="14822463">[14822463](#14822463)</a> | An access violation occurs in `CSession::DeleteBlobHandleFactoryPool` while resetting the `SESSION` for reuse. | SQL Server Engine | Programmability | Windows |
| <a id="14871059">[14871059](#14871059)</a> | An access violation occurs when you create a CLR assembly after restoring a database from a snapshot. | SQL Server Engine | Programmability | Windows |
| <a id="14673410">[14673410](#14673410)</a> | Error 2706 occurs when you run `DBCC CHECKDB WITH EXTENDED_LOGICAL_CHECKS` against a database by using the Table-Valued Function (TVF) that uses indexes. Here's the error message: </br></br>Table '%.*ls' does not exist. | SQL Server Engine | Query Execution | Windows |
| <a id="14764339">[14764339](#14764339)</a> | An access violation occurs, and the query is terminated when you use `sp_cursoropen` for `SHORTEST_PATH` over graph tables. | SQL Server Engine | Query Execution | All |
| <a id="14764631">[14764631](#14764631)</a> | An access violation occurs when you try to use an aggregate function together with `WITHIN GROUP (GRAPH PATH)`, and the query doesn't have a suitable `MATCH` clause. | SQL Server Engine | Query Execution | All |
| <a id="14788992">[14788992](#14788992)</a> | An access violation or an assertion failure occurs when you use the `LAST_QUERY_PLAN_STATS` feature while running a parallel query. | SQL Server Engine | Query Execution | Windows |
| <a id="14889419">[14889419](#14889419)</a> | A system assertion failure occurs and the query is terminated when you try to use a derived table within a `MATCH` predicate. | SQL Server Engine | Query Execution | All |
| <a id="14927877">[14927877](#14927877)</a> | An assertion dump occurs in `RaiseInternalError` while processing binary large object (BLOB) data. | SQL Server Engine | Query Execution | Windows |
| <a id="14729398">[14729398](#14729398)</a> | Creating edge constraints on graph tables meets an access violation when you use a node table instead of an edge table in the constraint. | SQL Server Engine | Query Optimizer | All |
| <a id="14861989">[14861989](#14861989)</a> | In Microsoft SQL Server 2019, an index creation script fails and returns error message 8624. Here's the error message: </br></br>Internal Query Processor Error: The query processor could not produce a query plan. For more information, contact Customer Support Services. | SQL Server Engine | Query Optimizer | Windows |
| <a id="14924053">[14924053](#14924053)</a> | In Microsoft SQL Server 2019, running parameterized queries skips the `SelOnSeqPrj` rule. Therefore, pushdown doesn't occur. | SQL Server Engine | Query Optimizer | All |
| <a id="14726037">[14726037](#14726037)</a> | QDS remains stuck in read-only mode if the size-based cleanup index rebuild releases space asynchronously. | SQL Server Engine | Query Store | Windows |
| <a id="14708231">[14708231](#14708231)</a> | [FIX: A subscription is still active after the distribution retention period expires (KB5013181)](https://support.microsoft.com/help/5013181) | SQL Server Engine | Replication | Windows |
| <a id="14737844">[14737844](#14737844)</a> | [FIX: sp_replmonitorsubscriptionpendingcmds returns incorrect pending commands for P2P replication (KB5017009)](https://support.microsoft.com/help/5017009) | SQL Server Engine | Replication | Windows |
| <a id="14884007">[14884007](#14884007)</a> | When you create a peer-to-peer publication by using the last-write-wins conflict resolution policy, and one or few articles in this publication have just 1 column which is the primary key column, running the distribution agent fails and returns the following error message: </br></br> Incorrect syntax near '$sys_mw_cd_id'. | SQL Server Engine | Replication | Windows |
| <a id="14915360">[14915360](#14915360)</a> | The floating-point exception error 3628 occurs when you run a full-text query that contains a `FREETEXTTABLE` function. | SQL Server Engine | Search | All |
| <a id="312902877">[312902877](#312902877)</a> | When you use the `AZDATA BDC ROTATE` command to rotate the password of a SQL Server big data cluster that uses Active Directory, you receive the following error message: </br></br>Failed to update password for existing AD account '\<AccountName>'. Error code: 30 | SQL Server Engine | SQL Big Data Cluster | Linux |
| <a id="14874191">[14874191](#14874191)</a> | [Improvement: Provide the closest matching non-UTF8 collation for the client drivers that don't support UTF-8 (KB5016780)](https://support.microsoft.com/help/5016780) | SQL Server Engine | SQL Server Engine | All |
| <a id="14764719">[14764719](#14764719)</a> | An instance of SQL Server Express LocalDB fails to start and returns error 9003 after multiple backups on the `model` database. | SQL Server Engine | Transaction Services | Windows |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU17 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2022/08/sqlserver2019-kb5016394-x64_b196811983841da3a07a6ef8b776c85d942a138f.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5016394-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5016394-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5016394-x64.exe| B3AF212A50B79CA5B780D0EEB895572C6567ECD516135C0D221309CDF637C8AB |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.33  | 292768    | 22-Jul-22 | 12:45 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 22-Jul-22 | 12:45 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.33      | 758192    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 175536    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 199600    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 202152    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 198576    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 214960    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 197552    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 193440    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 252320    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 174000    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.33      | 197024    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.33      | 1098680   | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.33      | 567200    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 54720     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 59296     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 59824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58800     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 61872     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58296     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58288     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 67504     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 53680     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.33      | 58288     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 18848     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.33      | 17824     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 22-Jul-22 | 12:45 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 22-Jul-22 | 12:45 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 22-Jul-22 | 12:45 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 22-Jul-22 | 12:45 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 22-Jul-22 | 12:45 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 22-Jul-22 | 12:45 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 22-Jul-22 | 12:45 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 22-Jul-22 | 12:45 | x86      |
| Msmdctr.dll                                               | 2018.150.35.33  | 38320     | 22-Jul-22 | 12:46 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.33  | 66291632  | 22-Jul-22 | 12:46 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.33  | 47785376  | 22-Jul-22 | 12:46 | x86      |
| Msmdpump.dll                                              | 2018.150.35.33  | 10188728  | 22-Jul-22 | 12:46 | x64      |
| Msmdredir.dll                                             | 2018.150.35.33  | 7956928   | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 22-Jul-22 | 12:45 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 17312     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 18336     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 22-Jul-22 | 12:46 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.33      | 16800     | 22-Jul-22 | 12:46 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.33  | 65831328  | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 833440    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1628064   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1453984   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1642912   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1608608   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1001376   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 992672    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1536928   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1521568   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 810912    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.33  | 1596320   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 832416    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1624480   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1450912   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1637792   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1604512   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 998816    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 991136    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1532832   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1517984   | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 809888    | 22-Jul-22 | 12:46 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.33  | 1591712   | 22-Jul-22 | 12:46 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.33  | 10185640  | 22-Jul-22 | 12:46 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.33  | 8279472   | 22-Jul-22 | 12:46 | x86      |
| Msolap.dll                                                | 2018.150.35.33  | 11016112  | 22-Jul-22 | 12:46 | x64      |
| Msolap.dll                                                | 2018.150.35.33  | 8608160   | 22-Jul-22 | 12:46 | x86      |
| Msolui.dll                                                | 2018.150.35.33  | 306592    | 22-Jul-22 | 12:46 | x64      |
| Msolui.dll                                                | 2018.150.35.33  | 286112    | 22-Jul-22 | 12:46 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 22-Jul-22 | 12:46 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 22-Jul-22 | 12:46 | x64      |
| Sqlboot.dll                                               | 2019.150.4249.2 | 214968    | 22-Jul-22 | 12:46 | x64      |
| Sqlceip.exe                                               | 15.0.4249.2     | 292768    | 22-Jul-22 | 12:46 | x86      |
| Sqldumper.exe                                             | 2019.150.4249.2 | 186280    | 22-Jul-22 | 12:45 | x64      |
| Sqldumper.exe                                             | 2019.150.4249.2 | 153512    | 22-Jul-22 | 12:46 | x86      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 22-Jul-22 | 12:46 | x86      |
| Tmapi.dll                                                 | 2018.150.35.33  | 6178208   | 22-Jul-22 | 12:46 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.33  | 4917688   | 22-Jul-22 | 12:46 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.33  | 1184672   | 22-Jul-22 | 12:46 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.33  | 6806432   | 22-Jul-22 | 12:46 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.33  | 26025904  | 22-Jul-22 | 12:46 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.33  | 35460528  | 22-Jul-22 | 12:46 | x86      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4249.2 | 182200    | 22-Jul-22 | 12:46 | x64      |
| Batchparser.dll                      | 2019.150.4249.2 | 165816    | 22-Jul-22 | 12:46 | x86      |
| Instapi150.dll                       | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:46 | x64      |
| Instapi150.dll                       | 2019.150.4249.2 | 75688     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4249.2 | 100256    | 22-Jul-22 | 12:46 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4249.2     | 550816    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4249.2     | 550816    | 22-Jul-22 | 12:46 | x86      |
| Msasxpress.dll                       | 2018.150.35.33  | 27072     | 22-Jul-22 | 12:47 | x86      |
| Msasxpress.dll                       | 2018.150.35.33  | 32160     | 22-Jul-22 | 12:47 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4249.2 | 75704     | 22-Jul-22 | 12:46 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:46 | x64      |
| Sqldumper.exe                        | 2019.150.4249.2 | 153512    | 22-Jul-22 | 12:46 | x86      |
| Sqldumper.exe                        | 2019.150.4249.2 | 186280    | 22-Jul-22 | 12:47 | x64      |
| Sqlftacct.dll                        | 2019.150.4249.2 | 59296     | 22-Jul-22 | 12:46 | x86      |
| Sqlftacct.dll                        | 2019.150.4249.2 | 79776     | 22-Jul-22 | 12:47 | x64      |
| Sqlmanager.dll                       | 2019.150.4249.2 | 743352    | 22-Jul-22 | 12:47 | x86      |
| Sqlmanager.dll                       | 2019.150.4249.2 | 878520    | 22-Jul-22 | 12:47 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4249.2 | 432032    | 22-Jul-22 | 12:46 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4249.2 | 378808    | 22-Jul-22 | 12:47 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4249.2 | 276384    | 22-Jul-22 | 12:46 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4249.2 | 358304    | 22-Jul-22 | 12:46 | x64      |
| Svrenumapi150.dll                    | 2019.150.4249.2 | 1161128   | 22-Jul-22 | 12:46 | x64      |
| Svrenumapi150.dll                    | 2019.150.4249.2 | 911272    | 22-Jul-22 | 12:46 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4249.2 | 137144    | 22-Jul-22 | 12:46 | x86      |
| Dreplaycommon.dll     | 2019.150.4249.2 | 666552    | 22-Jul-22 | 12:46 | x86      |
| Dreplayutil.dll       | 2019.150.4249.2 | 305056    | 22-Jul-22 | 12:46 | x86      |
| Instapi150.dll        | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:46 | x64      |
| Sqlresourceloader.dll | 2019.150.4249.2 | 38840     | 22-Jul-22 | 12:46 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4249.2 | 666552    | 22-Jul-22 | 12:46 | x86      |
| Dreplaycontroller.exe | 2019.150.4249.2 | 366520    | 22-Jul-22 | 12:46 | x86      |
| Instapi150.dll        | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:45 | x64      |
| Sqlresourceloader.dll | 2019.150.4249.2 | 38840     | 22-Jul-22 | 12:45 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4249.2 | 4658104   | 22-Jul-22 | 14:01 | x64      |
| Aetm-enclave.dll                           | 2019.150.4249.2 | 4612528   | 22-Jul-22 | 14:01 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4249.2 | 4931872   | 22-Jul-22 | 14:01 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4249.2 | 4873536   | 22-Jul-22 | 14:01 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 22-Jul-22 | 12:45 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 22-Jul-22 | 12:45 | x64      |
| Batchparser.dll                            | 2019.150.4249.2 | 182200    | 22-Jul-22 | 14:01 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 22-Jul-22 | 14:01 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 22-Jul-22 | 14:01 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 22-Jul-22 | 14:01 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 22-Jul-22 | 14:01 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4249.2 | 280504    | 22-Jul-22 | 14:01 | x64      |
| Dcexec.exe                                 | 2019.150.4249.2 | 87992     | 22-Jul-22 | 14:01 | x64      |
| Fssres.dll                                 | 2019.150.4249.2 | 96160     | 22-Jul-22 | 14:01 | x64      |
| Hadrres.dll                                | 2019.150.4249.2 | 202656    | 22-Jul-22 | 14:01 | x64      |
| Hkcompile.dll                              | 2019.150.4249.2 | 1292192   | 22-Jul-22 | 14:01 | x64      |
| Hkengine.dll                               | 2019.150.4249.2 | 5789624   | 22-Jul-22 | 14:01 | x64      |
| Hkruntime.dll                              | 2019.150.4249.2 | 182176    | 22-Jul-22 | 14:01 | x64      |
| Hktempdb.dll                               | 2019.150.4249.2 | 63416     | 22-Jul-22 | 14:01 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 22-Jul-22 | 14:01 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4249.2     | 235424    | 22-Jul-22 | 14:01 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4249.2 | 325544    | 22-Jul-22 | 14:01 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4249.2 | 92064     | 22-Jul-22 | 14:01 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 22-Jul-22 | 14:01 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 22-Jul-22 | 14:01 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 22-Jul-22 | 14:01 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 22-Jul-22 | 14:01 | x64      |
| Qds.dll                                    | 2019.150.4249.2 | 1185696   | 22-Jul-22 | 14:01 | x64      |
| Rsfxft.dll                                 | 2019.150.4249.2 | 51112     | 22-Jul-22 | 14:01 | x64      |
| Secforwarder.dll                           | 2019.150.4249.2 | 79776     | 22-Jul-22 | 14:01 | x64      |
| Sqagtres.dll                               | 2019.150.4249.2 | 87976     | 22-Jul-22 | 14:01 | x64      |
| Sqlaamss.dll                               | 2019.150.4249.2 | 108448    | 22-Jul-22 | 14:01 | x64      |
| Sqlaccess.dll                              | 2019.150.4249.2 | 493496    | 22-Jul-22 | 14:01 | x64      |
| Sqlagent.exe                               | 2019.150.4249.2 | 731064    | 22-Jul-22 | 14:01 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4249.2 | 79800     | 22-Jul-22 | 14:01 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4249.2 | 67512     | 22-Jul-22 | 14:01 | x86      |
| Sqlboot.dll                                | 2019.150.4249.2 | 214968    | 22-Jul-22 | 14:01 | x64      |
| Sqlceip.exe                                | 15.0.4249.2     | 292768    | 22-Jul-22 | 14:01 | x86      |
| Sqlcmdss.dll                               | 2019.150.4249.2 | 87992     | 22-Jul-22 | 14:01 | x64      |
| Sqlctr150.dll                              | 2019.150.4249.2 | 141216    | 22-Jul-22 | 14:01 | x64      |
| Sqlctr150.dll                              | 2019.150.4249.2 | 116640    | 22-Jul-22 | 14:01 | x86      |
| Sqldk.dll                                  | 2019.150.4249.2 | 3155880   | 22-Jul-22 | 14:01 | x64      |
| Sqldtsss.dll                               | 2019.150.4249.2 | 108456    | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 1595320   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3499944   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3696568   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4163496   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4282280   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3413928   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3581880   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4159400   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4011944   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4065192   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 2222008   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 2172840   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3868576   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3545000   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4016040   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3819432   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3819432   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3614632   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3499944   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 1537960   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 3909544   | 22-Jul-22 | 14:01 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4249.2 | 4028320   | 22-Jul-22 | 14:01 | x64      |
| Sqllang.dll                                | 2019.150.4249.2 | 39962536  | 22-Jul-22 | 14:01 | x64      |
| Sqlmin.dll                                 | 2019.150.4249.2 | 40539064  | 22-Jul-22 | 14:01 | x64      |
| Sqlolapss.dll                              | 2019.150.4249.2 | 104360    | 22-Jul-22 | 14:01 | x64      |
| Sqlos.dll                                  | 2019.150.4249.2 | 42912     | 22-Jul-22 | 14:01 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4249.2 | 83880     | 22-Jul-22 | 14:01 | x64      |
| Sqlrepss.dll                               | 2019.150.4249.2 | 83880     | 22-Jul-22 | 14:01 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4249.2 | 51112     | 22-Jul-22 | 14:01 | x64      |
| Sqlscm.dll                                 | 2019.150.4249.2 | 87976     | 22-Jul-22 | 14:01 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4249.2 | 38840     | 22-Jul-22 | 14:01 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4249.2 | 5805992   | 22-Jul-22 | 14:01 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4249.2 | 673704    | 22-Jul-22 | 14:01 | x64      |
| Sqlservr.exe                               | 2019.150.4249.2 | 628664    | 22-Jul-22 | 14:01 | x64      |
| Sqlsvc.dll                                 | 2019.150.4249.2 | 182200    | 22-Jul-22 | 14:01 | x64      |
| Sqltses.dll                                | 2019.150.4249.2 | 9115560   | 22-Jul-22 | 14:01 | x64      |
| Sqsrvres.dll                               | 2019.150.4249.2 | 280480    | 22-Jul-22 | 14:01 | x64      |
| Svl.dll                                    | 2019.150.4249.2 | 161720    | 22-Jul-22 | 14:01 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 22-Jul-22 | 14:01 | x64      |
| Xe.dll                                     | 2019.150.4249.2 | 722856    | 22-Jul-22 | 14:01 | x64      |
| Xpadsi.exe                                 | 2019.150.4249.2 | 116648    | 22-Jul-22 | 14:01 | x64      |
| Xplog70.dll                                | 2019.150.4249.2 | 92072     | 22-Jul-22 | 14:01 | x64      |
| Xpqueue.dll                                | 2019.150.4249.2 | 92072     | 22-Jul-22 | 14:01 | x64      |
| Xprepl.dll                                 | 2019.150.4249.2 | 120760    | 22-Jul-22 | 14:01 | x64      |
| Xpstar.dll                                 | 2019.150.4249.2 | 472992    | 22-Jul-22 | 14:01 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4249.2 | 182200    | 22-Jul-22 | 12:45 | x64      |
| Batchparser.dll                                              | 2019.150.4249.2 | 165816    | 22-Jul-22 | 12:46 | x86      |
| Commanddest.dll                                              | 2019.150.4249.2 | 264096    | 22-Jul-22 | 12:46 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4249.2 | 231336    | 22-Jul-22 | 12:46 | x64      |
| Distrib.exe                                                  | 2019.150.4249.2 | 235448    | 22-Jul-22 | 12:46 | x64      |
| Dteparse.dll                                                 | 2019.150.4249.2 | 124840    | 22-Jul-22 | 12:46 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4249.2 | 133032    | 22-Jul-22 | 12:46 | x64      |
| Dtepkg.dll                                                   | 2019.150.4249.2 | 153504    | 22-Jul-22 | 12:46 | x64      |
| Dtexec.exe                                                   | 2019.150.4249.2 | 72608     | 22-Jul-22 | 12:46 | x64      |
| Dts.dll                                                      | 2019.150.4249.2 | 3143608   | 22-Jul-22 | 12:38 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4249.2 | 501688    | 22-Jul-22 | 12:46 | x64      |
| Dtsconn.dll                                                  | 2019.150.4249.2 | 522144    | 22-Jul-22 | 12:46 | x64      |
| Dtshost.exe                                                  | 2019.150.4249.2 | 105384    | 22-Jul-22 | 12:46 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4249.2 | 567224    | 22-Jul-22 | 12:06 | x64      |
| Dtspipeline.dll                                              | 2019.150.4249.2 | 1329080   | 22-Jul-22 | 12:46 | x64      |
| Dtswizard.exe                                                | 15.0.4249.2     | 886712    | 22-Jul-22 | 12:46 | x64      |
| Dtuparse.dll                                                 | 2019.150.4249.2 | 100264    | 22-Jul-22 | 12:46 | x64      |
| Dtutil.exe                                                   | 2019.150.4249.2 | 148384    | 22-Jul-22 | 12:46 | x64      |
| Exceldest.dll                                                | 2019.150.4249.2 | 280480    | 22-Jul-22 | 12:46 | x64      |
| Excelsrc.dll                                                 | 2019.150.4249.2 | 309152    | 22-Jul-22 | 12:46 | x64      |
| Execpackagetask.dll                                          | 2019.150.4249.2 | 186280    | 22-Jul-22 | 12:45 | x64      |
| Flatfiledest.dll                                             | 2019.150.4249.2 | 411576    | 22-Jul-22 | 12:46 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4249.2 | 427936    | 22-Jul-22 | 12:46 | x64      |
| Logread.exe                                                  | 2019.150.4249.2 | 718752    | 22-Jul-22 | 12:46 | x64      |
| Mergetxt.dll                                                 | 2019.150.4249.2 | 75704     | 22-Jul-22 | 12:45 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4249.2     | 59296     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4249.2     | 42920     | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4249.2     | 391096    | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4249.2 | 1689504   | 22-Jul-22 | 12:46 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4249.2 | 1640352   | 22-Jul-22 | 12:46 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4249.2     | 550816    | 22-Jul-22 | 12:45 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4249.2 | 112560    | 22-Jul-22 | 12:46 | x64      |
| Msgprox.dll                                                  | 2019.150.4249.2 | 300968    | 22-Jul-22 | 12:46 | x64      |
| Msoledbsql.dll                                               | 2018.182.3.0    | 148432    | 22-Jul-22 | 12:45 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4249.2 | 1497016   | 22-Jul-22 | 12:46 | x64      |
| Oledbdest.dll                                                | 2019.150.4249.2 | 280488    | 22-Jul-22 | 12:46 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4249.2 | 313248    | 22-Jul-22 | 12:46 | x64      |
| Osql.exe                                                     | 2019.150.4249.2 | 92064     | 22-Jul-22 | 12:46 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4249.2 | 497568    | 22-Jul-22 | 12:45 | x64      |
| Rawdest.dll                                                  | 2019.150.4249.2 | 227232    | 22-Jul-22 | 12:45 | x64      |
| Rawsource.dll                                                | 2019.150.4249.2 | 210848    | 22-Jul-22 | 12:46 | x64      |
| Rdistcom.dll                                                 | 2019.150.4249.2 | 915360    | 22-Jul-22 | 12:46 | x64      |
| Recordsetdest.dll                                            | 2019.150.4249.2 | 202656    | 22-Jul-22 | 12:46 | x64      |
| Repldp.dll                                                   | 2019.150.4249.2 | 313248    | 22-Jul-22 | 12:46 | x64      |
| Replerrx.dll                                                 | 2019.150.4249.2 | 182200    | 22-Jul-22 | 12:45 | x64      |
| Replisapi.dll                                                | 2019.150.4249.2 | 395168    | 22-Jul-22 | 12:45 | x64      |
| Replmerg.exe                                                 | 2019.150.4249.2 | 563104    | 22-Jul-22 | 12:45 | x64      |
| Replprov.dll                                                 | 2019.150.4249.2 | 858040    | 22-Jul-22 | 12:45 | x64      |
| Replrec.dll                                                  | 2019.150.4249.2 | 1034168   | 22-Jul-22 | 12:45 | x64      |
| Replsub.dll                                                  | 2019.150.4249.2 | 473016    | 22-Jul-22 | 12:45 | x64      |
| Replsync.dll                                                 | 2019.150.4249.2 | 165816    | 22-Jul-22 | 12:45 | x64      |
| Spresolv.dll                                                 | 2019.150.4249.2 | 276408    | 22-Jul-22 | 12:45 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4249.2 | 264096    | 22-Jul-22 | 12:46 | x64      |
| Sqldiag.exe                                                  | 2019.150.4249.2 | 1140640   | 22-Jul-22 | 12:45 | x64      |
| Sqldistx.dll                                                 | 2019.150.4249.2 | 247720    | 22-Jul-22 | 12:45 | x64      |
| Sqllogship.exe                                               | 15.0.4249.2     | 104376    | 22-Jul-22 | 12:45 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4249.2 | 399288    | 22-Jul-22 | 12:46 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4249.2 | 51112     | 22-Jul-22 | 12:45 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4249.2 | 38840     | 22-Jul-22 | 12:46 | x86      |
| Sqlscm.dll                                                   | 2019.150.4249.2 | 79800     | 22-Jul-22 | 12:45 | x86      |
| Sqlscm.dll                                                   | 2019.150.4249.2 | 87976     | 22-Jul-22 | 12:46 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4249.2 | 182200    | 22-Jul-22 | 12:45 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4249.2 | 149408    | 22-Jul-22 | 12:46 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4249.2 | 202664    | 22-Jul-22 | 12:45 | x64      |
| Ssradd.dll                                                   | 2019.150.4249.2 | 83896     | 22-Jul-22 | 12:45 | x64      |
| Ssravg.dll                                                   | 2019.150.4249.2 | 83896     | 22-Jul-22 | 12:45 | x64      |
| Ssrdown.dll                                                  | 2019.150.4249.2 | 75696     | 22-Jul-22 | 12:45 | x64      |
| Ssrmax.dll                                                   | 2019.150.4249.2 | 83896     | 22-Jul-22 | 12:45 | x64      |
| Ssrmin.dll                                                   | 2019.150.4249.2 | 83896     | 22-Jul-22 | 12:45 | x64      |
| Ssrpub.dll                                                   | 2019.150.4249.2 | 75704     | 22-Jul-22 | 12:45 | x64      |
| Ssrup.dll                                                    | 2019.150.4249.2 | 75704     | 22-Jul-22 | 12:45 | x64      |
| Txagg.dll                                                    | 2019.150.4249.2 | 391072    | 22-Jul-22 | 12:46 | x64      |
| Txbdd.dll                                                    | 2019.150.4249.2 | 190368    | 22-Jul-22 | 12:46 | x64      |
| Txdatacollector.dll                                          | 2019.150.4249.2 | 472992    | 22-Jul-22 | 12:46 | x64      |
| Txdataconvert.dll                                            | 2019.150.4249.2 | 317368    | 22-Jul-22 | 12:46 | x64      |
| Txderived.dll                                                | 2019.150.4249.2 | 640952    | 22-Jul-22 | 12:46 | x64      |
| Txlookup.dll                                                 | 2019.150.4249.2 | 542624    | 22-Jul-22 | 12:46 | x64      |
| Txmerge.dll                                                  | 2019.150.4249.2 | 247720    | 22-Jul-22 | 12:46 | x64      |
| Txmergejoin.dll                                              | 2019.150.4249.2 | 309160    | 22-Jul-22 | 12:46 | x64      |
| Txmulticast.dll                                              | 2019.150.4249.2 | 145312    | 22-Jul-22 | 12:46 | x64      |
| Txrowcount.dll                                               | 2019.150.4249.2 | 141216    | 22-Jul-22 | 12:46 | x64      |
| Txsort.dll                                                   | 2019.150.4249.2 | 288672    | 22-Jul-22 | 12:46 | x64      |
| Txsplit.dll                                                  | 2019.150.4249.2 | 624568    | 22-Jul-22 | 12:46 | x64      |
| Txunionall.dll                                               | 2019.150.4249.2 | 198560    | 22-Jul-22 | 12:46 | x64      |
| Xe.dll                                                       | 2019.150.4249.2 | 722856    | 22-Jul-22 | 12:45 | x64      |
| Xmlsub.dll                                                   | 2019.150.4249.2 | 296872    | 22-Jul-22 | 12:45 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4249.2 | 92088     | 22-Jul-22 | 12:46 | x64      |
| Exthost.exe        | 2019.150.4249.2 | 239520    | 22-Jul-22 | 12:46 | x64      |
| Launchpad.exe      | 2019.150.4249.2 | 1222568   | 22-Jul-22 | 12:46 | x64      |
| Sqlsatellite.dll   | 2019.150.4249.2 | 1021856   | 22-Jul-22 | 12:46 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4249.2 | 686008    | 22-Jul-22 | 12:45 | x64      |
| Fdhost.exe     | 2019.150.4249.2 | 128952    | 22-Jul-22 | 12:45 | x64      |
| Fdlauncher.exe | 2019.150.4249.2 | 79784     | 22-Jul-22 | 12:45 | x64      |
| Sqlft150ph.dll | 2019.150.4249.2 | 92064     | 22-Jul-22 | 12:45 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4249.2  | 30648     | 22-Jul-22 | 12:45 | x86      |

SQL Server 2019 Integration Services


|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4249.2 | 264096    | 22-Jul-22 | 12:53 | x64      |
| Commanddest.dll                                               | 2019.150.4249.2 | 227232    | 22-Jul-22 | 12:53 | x86      |
| Dteparse.dll                                                  | 2019.150.4249.2 | 112544    | 22-Jul-22 | 12:53 | x86      |
| Dteparse.dll                                                  | 2019.150.4249.2 | 124840    | 22-Jul-22 | 12:53 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4249.2 | 116640    | 22-Jul-22 | 12:53 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4249.2 | 133032    | 22-Jul-22 | 12:53 | x64      |
| Dtepkg.dll                                                    | 2019.150.4249.2 | 133048    | 22-Jul-22 | 12:53 | x86      |
| Dtepkg.dll                                                    | 2019.150.4249.2 | 153504    | 22-Jul-22 | 12:53 | x64      |
| Dtexec.exe                                                    | 2019.150.4249.2 | 63928     | 22-Jul-22 | 12:53 | x86      |
| Dtexec.exe                                                    | 2019.150.4249.2 | 72608     | 22-Jul-22 | 12:53 | x64      |
| Dts.dll                                                       | 2019.150.4249.2 | 2762664   | 22-Jul-22 | 12:53 | x86      |
| Dts.dll                                                       | 2019.150.4249.2 | 3143608   | 22-Jul-22 | 12:53 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4249.2 | 444344    | 22-Jul-22 | 12:53 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4249.2 | 501688    | 22-Jul-22 | 12:53 | x64      |
| Dtsconn.dll                                                   | 2019.150.4249.2 | 432056    | 22-Jul-22 | 12:53 | x86      |
| Dtsconn.dll                                                   | 2019.150.4249.2 | 522144    | 22-Jul-22 | 12:53 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4249.2 | 112032    | 22-Jul-22 | 12:53 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4249.2 | 93624     | 22-Jul-22 | 12:53 | x86      |
| Dtshost.exe                                                   | 2019.150.4249.2 | 105384    | 22-Jul-22 | 12:53 | x64      |
| Dtshost.exe                                                   | 2019.150.4249.2 | 88488     | 22-Jul-22 | 12:53 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4249.2 | 554936    | 22-Jul-22 | 12:53 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4249.2 | 567224    | 22-Jul-22 | 12:53 | x64      |
| Dtspipeline.dll                                               | 2019.150.4249.2 | 1120160   | 22-Jul-22 | 12:53 | x86      |
| Dtspipeline.dll                                               | 2019.150.4249.2 | 1329080   | 22-Jul-22 | 12:53 | x64      |
| Dtswizard.exe                                                 | 15.0.4249.2     | 886712    | 22-Jul-22 | 12:53 | x64      |
| Dtswizard.exe                                                 | 15.0.4249.2     | 890792    | 22-Jul-22 | 12:53 | x86      |
| Dtuparse.dll                                                  | 2019.150.4249.2 | 100264    | 22-Jul-22 | 12:53 | x64      |
| Dtuparse.dll                                                  | 2019.150.4249.2 | 87968     | 22-Jul-22 | 12:53 | x86      |
| Dtutil.exe                                                    | 2019.150.4249.2 | 129952    | 22-Jul-22 | 12:53 | x86      |
| Dtutil.exe                                                    | 2019.150.4249.2 | 148384    | 22-Jul-22 | 12:53 | x64      |
| Exceldest.dll                                                 | 2019.150.4249.2 | 235448    | 22-Jul-22 | 12:53 | x86      |
| Exceldest.dll                                                 | 2019.150.4249.2 | 280480    | 22-Jul-22 | 12:53 | x64      |
| Excelsrc.dll                                                  | 2019.150.4249.2 | 260024    | 22-Jul-22 | 12:53 | x86      |
| Excelsrc.dll                                                  | 2019.150.4249.2 | 309152    | 22-Jul-22 | 12:53 | x64      |
| Execpackagetask.dll                                           | 2019.150.4249.2 | 149432    | 22-Jul-22 | 12:53 | x86      |
| Execpackagetask.dll                                           | 2019.150.4249.2 | 186280    | 22-Jul-22 | 12:53 | x64      |
| Flatfiledest.dll                                              | 2019.150.4249.2 | 358304    | 22-Jul-22 | 12:53 | x86      |
| Flatfiledest.dll                                              | 2019.150.4249.2 | 411576    | 22-Jul-22 | 12:53 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4249.2 | 370592    | 22-Jul-22 | 12:53 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4249.2 | 427936    | 22-Jul-22 | 12:53 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4249.2     | 120760    | 22-Jul-22 | 12:53 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4249.2     | 120744    | 22-Jul-22 | 12:53 | x86      |
| Isserverexec.exe                                              | 15.0.4249.2     | 149432    | 22-Jul-22 | 12:53 | x86      |
| Isserverexec.exe                                              | 15.0.4249.2     | 145336    | 22-Jul-22 | 12:53 | x64      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4249.2     | 116640    | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4249.2     | 59296     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4249.2     | 59304     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4249.2     | 509864    | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4249.2     | 42920     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4249.2     | 42920     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4249.2     | 391096    | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4249.2     | 59304     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4249.2     | 59320     | 22-Jul-22 | 12:53 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4249.2     | 141240    | 22-Jul-22 | 12:53 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4249.2     | 219048    | 22-Jul-22 | 12:53 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4249.2 | 100264    | 22-Jul-22 | 12:53 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4249.2 | 112560    | 22-Jul-22 | 12:53 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.33  | 10063800  | 22-Jul-22 | 12:46 | x64      |
| Odbcdest.dll                                                  | 2019.150.4249.2 | 321456    | 22-Jul-22 | 12:53 | x86      |
| Odbcdest.dll                                                  | 2019.150.4249.2 | 370600    | 22-Jul-22 | 12:53 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4249.2 | 329656    | 22-Jul-22 | 12:53 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4249.2 | 382904    | 22-Jul-22 | 12:53 | x64      |
| Oledbdest.dll                                                 | 2019.150.4249.2 | 239528    | 22-Jul-22 | 12:53 | x86      |
| Oledbdest.dll                                                 | 2019.150.4249.2 | 280488    | 22-Jul-22 | 12:53 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4249.2 | 264096    | 22-Jul-22 | 12:53 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4249.2 | 313248    | 22-Jul-22 | 12:53 | x64      |
| Rawdest.dll                                                   | 2019.150.4249.2 | 190392    | 22-Jul-22 | 12:53 | x86      |
| Rawdest.dll                                                   | 2019.150.4249.2 | 227232    | 22-Jul-22 | 12:53 | x64      |
| Rawsource.dll                                                 | 2019.150.4249.2 | 178104    | 22-Jul-22 | 12:53 | x86      |
| Rawsource.dll                                                 | 2019.150.4249.2 | 210848    | 22-Jul-22 | 12:53 | x64      |
| Recordsetdest.dll                                             | 2019.150.4249.2 | 173984    | 22-Jul-22 | 12:53 | x86      |
| Recordsetdest.dll                                             | 2019.150.4249.2 | 202656    | 22-Jul-22 | 12:53 | x64      |
| Sqlceip.exe                                                   | 15.0.4249.2     | 292768    | 22-Jul-22 | 12:53 | x86      |
| Sqldest.dll                                                   | 2019.150.4249.2 | 239544    | 22-Jul-22 | 12:53 | x86      |
| Sqldest.dll                                                   | 2019.150.4249.2 | 276384    | 22-Jul-22 | 12:53 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4249.2 | 169912    | 22-Jul-22 | 12:53 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4249.2 | 202664    | 22-Jul-22 | 12:53 | x64      |
| Txagg.dll                                                     | 2019.150.4249.2 | 391072    | 22-Jul-22 | 12:53 | x64      |
| Txagg.dll                                                     | 2019.150.4249.2 | 329656    | 22-Jul-22 | 12:53 | x86      |
| Txbdd.dll                                                     | 2019.150.4249.2 | 157600    | 22-Jul-22 | 12:53 | x86      |
| Txbdd.dll                                                     | 2019.150.4249.2 | 190368    | 22-Jul-22 | 12:53 | x64      |
| Txbestmatch.dll                                               | 2019.150.4249.2 | 546720    | 22-Jul-22 | 12:53 | x86      |
| Txbestmatch.dll                                               | 2019.150.4249.2 | 653240    | 22-Jul-22 | 12:53 | x64      |
| Txcache.dll                                                   | 2019.150.4249.2 | 174008    | 22-Jul-22 | 12:53 | x86      |
| Txcache.dll                                                   | 2019.150.4249.2 | 198560    | 22-Jul-22 | 12:53 | x64      |
| Txcharmap.dll                                                 | 2019.150.4249.2 | 272312    | 22-Jul-22 | 12:53 | x86      |
| Txcharmap.dll                                                 | 2019.150.4249.2 | 313272    | 22-Jul-22 | 12:53 | x64      |
| Txcopymap.dll                                                 | 2019.150.4249.2 | 173984    | 22-Jul-22 | 12:53 | x86      |
| Txcopymap.dll                                                 | 2019.150.4249.2 | 198560    | 22-Jul-22 | 12:53 | x64      |
| Txdataconvert.dll                                             | 2019.150.4249.2 | 276408    | 22-Jul-22 | 12:53 | x86      |
| Txdataconvert.dll                                             | 2019.150.4249.2 | 317368    | 22-Jul-22 | 12:53 | x64      |
| Txderived.dll                                                 | 2019.150.4249.2 | 559032    | 22-Jul-22 | 12:53 | x86      |
| Txderived.dll                                                 | 2019.150.4249.2 | 640952    | 22-Jul-22 | 12:53 | x64      |
| Txfileextractor.dll                                           | 2019.150.4249.2 | 182200    | 22-Jul-22 | 12:53 | x86      |
| Txfileextractor.dll                                           | 2019.150.4249.2 | 219040    | 22-Jul-22 | 12:53 | x64      |
| Txfileinserter.dll                                            | 2019.150.4249.2 | 214944    | 22-Jul-22 | 12:53 | x64      |
| Txfileinserter.dll                                            | 2019.150.4249.2 | 182192    | 22-Jul-22 | 12:53 | x86      |
| Txgroupdups.dll                                               | 2019.150.4249.2 | 255928    | 22-Jul-22 | 12:53 | x86      |
| Txgroupdups.dll                                               | 2019.150.4249.2 | 313248    | 22-Jul-22 | 12:53 | x64      |
| Txlineage.dll                                                 | 2019.150.4249.2 | 128936    | 22-Jul-22 | 12:53 | x86      |
| Txlineage.dll                                                 | 2019.150.4249.2 | 153504    | 22-Jul-22 | 12:53 | x64      |
| Txlookup.dll                                                  | 2019.150.4249.2 | 468920    | 22-Jul-22 | 12:53 | x86      |
| Txlookup.dll                                                  | 2019.150.4249.2 | 542624    | 22-Jul-22 | 12:53 | x64      |
| Txmerge.dll                                                   | 2019.150.4249.2 | 206776    | 22-Jul-22 | 12:53 | x86      |
| Txmerge.dll                                                   | 2019.150.4249.2 | 247720    | 22-Jul-22 | 12:53 | x64      |
| Txmergejoin.dll                                               | 2019.150.4249.2 | 247736    | 22-Jul-22 | 12:53 | x86      |
| Txmergejoin.dll                                               | 2019.150.4249.2 | 309160    | 22-Jul-22 | 12:53 | x64      |
| Txmulticast.dll                                               | 2019.150.4249.2 | 145312    | 22-Jul-22 | 12:53 | x64      |
| Txmulticast.dll                                               | 2019.150.4249.2 | 116648    | 22-Jul-22 | 12:53 | x86      |
| Txpivot.dll                                                   | 2019.150.4249.2 | 206776    | 22-Jul-22 | 12:53 | x86      |
| Txpivot.dll                                                   | 2019.150.4249.2 | 239520    | 22-Jul-22 | 12:53 | x64      |
| Txrowcount.dll                                                | 2019.150.4249.2 | 141216    | 22-Jul-22 | 12:53 | x64      |
| Txrowcount.dll                                                | 2019.150.4249.2 | 112552    | 22-Jul-22 | 12:53 | x86      |
| Txsampling.dll                                                | 2019.150.4249.2 | 194464    | 22-Jul-22 | 12:53 | x64      |
| Txsampling.dll                                                | 2019.150.4249.2 | 161720    | 22-Jul-22 | 12:53 | x86      |
| Txscd.dll                                                     | 2019.150.4249.2 | 198584    | 22-Jul-22 | 12:53 | x86      |
| Txscd.dll                                                     | 2019.150.4249.2 | 235424    | 22-Jul-22 | 12:53 | x64      |
| Txsort.dll                                                    | 2019.150.4249.2 | 231352    | 22-Jul-22 | 12:53 | x86      |
| Txsort.dll                                                    | 2019.150.4249.2 | 288672    | 22-Jul-22 | 12:53 | x64      |
| Txsplit.dll                                                   | 2019.150.4249.2 | 550816    | 22-Jul-22 | 12:53 | x86      |
| Txsplit.dll                                                   | 2019.150.4249.2 | 624568    | 22-Jul-22 | 12:53 | x64      |
| Txtermextraction.dll                                          | 2019.150.4249.2 | 8644512   | 22-Jul-22 | 12:53 | x86      |
| Txtermextraction.dll                                          | 2019.150.4249.2 | 8701872   | 22-Jul-22 | 12:53 | x64      |
| Txtermlookup.dll                                              | 2019.150.4249.2 | 4183968   | 22-Jul-22 | 12:53 | x64      |
| Txtermlookup.dll                                              | 2019.150.4249.2 | 4138936   | 22-Jul-22 | 12:53 | x86      |
| Txunionall.dll                                                | 2019.150.4249.2 | 198560    | 22-Jul-22 | 12:53 | x64      |
| Txunionall.dll                                                | 2019.150.4249.2 | 161704    | 22-Jul-22 | 12:53 | x86      |
| Txunpivot.dll                                                 | 2019.150.4249.2 | 182184    | 22-Jul-22 | 12:53 | x86      |
| Txunpivot.dll                                                 | 2019.150.4249.2 | 214944    | 22-Jul-22 | 12:53 | x64      |
| Xe.dll                                                        | 2019.150.4249.2 | 632760    | 22-Jul-22 | 12:53 | x86      |
| Xe.dll                                                        | 2019.150.4249.2 | 722856    | 22-Jul-22 | 12:53 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1951.0     | 558480    | 22-Jul-22 | 13:39 | x86      |
| Dmsnative.dll                                                        | 2018.150.1951.0 | 151464    | 22-Jul-22 | 13:39 | x64      |
| Dwengineservice.dll                                                  | 15.0.1951.0     | 43944     | 22-Jul-22 | 13:39 | x86      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.116       | 2446928   | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2371      | 2250320   | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2371      | 147024    | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2412624   | 22-Jul-22 | 13:39 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.39        | 2928720   | 22-Jul-22 | 13:39 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 22-Jul-22 | 13:39 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 22-Jul-22 | 13:39 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 22-Jul-22 | 13:39 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 22-Jul-22 | 13:39 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15488080  | 22-Jul-22 | 13:39 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 22-Jul-22 | 13:39 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 22-Jul-22 | 13:39 | x64      |
| Instapi150.dll                                                       | 2019.150.4249.2 | 87968     | 22-Jul-22 | 13:39 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 22-Jul-22 | 13:39 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 22-Jul-22 | 13:39 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 22-Jul-22 | 13:39 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 22-Jul-22 | 13:39 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 22-Jul-22 | 13:39 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1951.0     | 66448     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1951.0     | 292256    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1951.0     | 1955752   | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1951.0     | 168360    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1951.0     | 648080    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1951.0     | 245136    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1951.0     | 138128    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1951.0     | 78752     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1951.0     | 50088     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1951.0     | 87440     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1951.0     | 1128336   | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1951.0     | 79760     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1951.0     | 69520     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1951.0     | 34208     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1951.0     | 30112     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1951.0     | 45472     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1951.0     | 20384     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1951.0     | 25504     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1951.0     | 130472    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1951.0     | 85408     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1951.0     | 99744     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1951.0     | 291744    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 119200    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 137120    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 140192    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 136600    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 149400    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 138656    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 133536    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 175520    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 116128    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1951.0     | 135584    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1951.0     | 71592     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1951.0     | 20888     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1951.0     | 36240     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1951.0     | 127912    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1951.0     | 3063696   | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1951.0     | 3954576   | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 117136    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 131984    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 136592    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 132496    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 147360    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 133008    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 129424    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 169888    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 114064    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1951.0     | 130960    | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1951.0     | 66464     | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1951.0     | 2681744   | 22-Jul-22 | 13:39 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1951.0     | 2435496   | 22-Jul-22 | 13:39 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4249.2 | 452520    | 22-Jul-22 | 13:39 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4249.2 | 7399352   | 22-Jul-22 | 13:39 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 22-Jul-22 | 13:39 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 22-Jul-22 | 13:39 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 22-Jul-22 | 13:39 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 22-Jul-22 | 13:39 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 22-Jul-22 | 13:39 | x64      |
| Secforwarder.dll                                                     | 2019.150.4249.2 | 79776     | 22-Jul-22 | 13:39 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1951.0 | 60320     | 22-Jul-22 | 13:39 | x64      |
| Sqldk.dll                                                            | 2019.150.4249.2 | 3155880   | 22-Jul-22 | 13:39 | x64      |
| Sqldumper.exe                                                        | 2019.150.4249.2 | 186280    | 22-Jul-22 | 13:39 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 1595320   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 4163496   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 3413928   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 4159400   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 4065192   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 2222008   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 2172840   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 3819432   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 3819432   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 1537960   | 22-Jul-22 | 13:33 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4249.2 | 4028320   | 22-Jul-22 | 13:33 | x64      |
| Sqlos.dll                                                            | 2019.150.4249.2 | 42912     | 22-Jul-22 | 13:39 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1951.0 | 4840352   | 22-Jul-22 | 13:39 | x64      |
| Sqltses.dll                                                          | 2019.150.4249.2 | 9115560   | 22-Jul-22 | 13:39 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 22-Jul-22 | 13:39 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 22-Jul-22 | 13:39 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 22-Jul-22 | 13:39 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4249.2  | 30648     | 22-Jul-22 | 12:45 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4249.2 | 1632184   | 22-Jul-22 | 13:00 | x86      |
| Dtaengine.exe                                                | 2019.150.4249.2 | 219064    | 22-Jul-22 | 13:00 | x86      |
| Dteparse.dll                                                 | 2019.150.4249.2 | 124840    | 22-Jul-22 | 13:00 | x64      |
| Dteparse.dll                                                 | 2019.150.4249.2 | 112544    | 22-Jul-22 | 13:00 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4249.2 | 116640    | 22-Jul-22 | 13:00 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4249.2 | 133032    | 22-Jul-22 | 13:00 | x64      |
| Dtepkg.dll                                                   | 2019.150.4249.2 | 153504    | 22-Jul-22 | 13:00 | x64      |
| Dtepkg.dll                                                   | 2019.150.4249.2 | 133048    | 22-Jul-22 | 13:00 | x86      |
| Dtexec.exe                                                   | 2019.150.4249.2 | 63928     | 22-Jul-22 | 13:00 | x86      |
| Dtexec.exe                                                   | 2019.150.4249.2 | 72608     | 22-Jul-22 | 13:00 | x64      |
| Dts.dll                                                      | 2019.150.4249.2 | 3143608   | 22-Jul-22 | 13:00 | x64      |
| Dts.dll                                                      | 2019.150.4249.2 | 2762664   | 22-Jul-22 | 13:00 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4249.2 | 444344    | 22-Jul-22 | 13:00 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4249.2 | 501688    | 22-Jul-22 | 13:00 | x64      |
| Dtsconn.dll                                                  | 2019.150.4249.2 | 432056    | 22-Jul-22 | 13:00 | x86      |
| Dtsconn.dll                                                  | 2019.150.4249.2 | 522144    | 22-Jul-22 | 13:00 | x64      |
| Dtshost.exe                                                  | 2019.150.4249.2 | 105384    | 22-Jul-22 | 13:00 | x64      |
| Dtshost.exe                                                  | 2019.150.4249.2 | 88488     | 22-Jul-22 | 13:00 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4249.2 | 554936    | 22-Jul-22 | 13:00 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4249.2 | 567224    | 22-Jul-22 | 13:00 | x64      |
| Dtspipeline.dll                                              | 2019.150.4249.2 | 1120160   | 22-Jul-22 | 13:00 | x86      |
| Dtspipeline.dll                                              | 2019.150.4249.2 | 1329080   | 22-Jul-22 | 13:00 | x64      |
| Dtswizard.exe                                                | 15.0.4249.2     | 886712    | 22-Jul-22 | 13:00 | x64      |
| Dtswizard.exe                                                | 15.0.4249.2     | 890792    | 22-Jul-22 | 13:00 | x86      |
| Dtuparse.dll                                                 | 2019.150.4249.2 | 100264    | 22-Jul-22 | 13:00 | x64      |
| Dtuparse.dll                                                 | 2019.150.4249.2 | 87968     | 22-Jul-22 | 13:00 | x86      |
| Dtutil.exe                                                   | 2019.150.4249.2 | 129952    | 22-Jul-22 | 13:00 | x86      |
| Dtutil.exe                                                   | 2019.150.4249.2 | 148384    | 22-Jul-22 | 13:00 | x64      |
| Exceldest.dll                                                | 2019.150.4249.2 | 235448    | 22-Jul-22 | 13:00 | x86      |
| Exceldest.dll                                                | 2019.150.4249.2 | 280480    | 22-Jul-22 | 13:00 | x64      |
| Excelsrc.dll                                                 | 2019.150.4249.2 | 260024    | 22-Jul-22 | 13:00 | x86      |
| Excelsrc.dll                                                 | 2019.150.4249.2 | 309152    | 22-Jul-22 | 13:00 | x64      |
| Flatfiledest.dll                                             | 2019.150.4249.2 | 358304    | 22-Jul-22 | 13:00 | x86      |
| Flatfiledest.dll                                             | 2019.150.4249.2 | 411576    | 22-Jul-22 | 13:00 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4249.2 | 427936    | 22-Jul-22 | 13:00 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4249.2 | 370592    | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4249.2     | 116640    | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4249.2     | 403368    | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4249.2     | 403368    | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4249.2     | 3000224   | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4249.2     | 3000232   | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4249.2     | 42920     | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4249.2     | 59304     | 22-Jul-22 | 13:00 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 22-Jul-22 | 13:00 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4249.2 | 100264    | 22-Jul-22 | 13:00 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4249.2 | 112560    | 22-Jul-22 | 13:00 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.33  | 8279472   | 22-Jul-22 | 13:00 | x86      |
| Oledbdest.dll                                                | 2019.150.4249.2 | 239528    | 22-Jul-22 | 13:00 | x86      |
| Oledbdest.dll                                                | 2019.150.4249.2 | 280488    | 22-Jul-22 | 13:00 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4249.2 | 264096    | 22-Jul-22 | 13:00 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4249.2 | 313248    | 22-Jul-22 | 13:00 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4249.2 | 51112     | 22-Jul-22 | 13:00 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4249.2 | 38840     | 22-Jul-22 | 13:00 | x86      |
| Sqlscm.dll                                                   | 2019.150.4249.2 | 87976     | 22-Jul-22 | 13:00 | x64      |
| Sqlscm.dll                                                   | 2019.150.4249.2 | 79800     | 22-Jul-22 | 13:00 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4249.2 | 182200    | 22-Jul-22 | 13:00 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4249.2 | 149408    | 22-Jul-22 | 13:00 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4249.2 | 202664    | 22-Jul-22 | 13:00 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4249.2 | 169912    | 22-Jul-22 | 13:00 | x86      |
| Txdataconvert.dll                                            | 2019.150.4249.2 | 276408    | 22-Jul-22 | 13:00 | x86      |
| Txdataconvert.dll                                            | 2019.150.4249.2 | 317368    | 22-Jul-22 | 13:00 | x64      |
| Xe.dll                                                       | 2019.150.4249.2 | 632760    | 22-Jul-22 | 13:00 | x86      |
| Xe.dll                                                       | 2019.150.4249.2 | 722856    | 22-Jul-22 | 13:00 | x64      |

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
  - CUs may contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
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
