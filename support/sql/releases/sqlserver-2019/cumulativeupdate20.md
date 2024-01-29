---
title: Cumulative update 20 for SQL Server 2019 (KB5024276)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 20 (KB5024276).
ms.date: 06/30/2023
ms.custom: KB5024276
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5024276 - Cumulative Update 20 for SQL Server 2019

_Release Date:_ &nbsp; April 13, 2023  
_Version:_ &nbsp; 15.0.4312.2

## Summary

This article describes Cumulative Update package 20 (CU20) for Microsoft SQL Server 2019. This update contains 24 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 19, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4312.2**, file version: **2019.150.4312.2**
- Analysis Services - Product version: **15.0.35.39**, file version: **2018.150.35.39**

## Known issues in this update

### Issue one: Access violation when session is reset

SQL Server 2019 CU14 introduced a [fix to address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the `SESSION` is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.

Microsoft is working on a fix for this issue and it will be available in a future CU.

### Issue two

After you install this cumulative update, external data sources using the generic ODBC connector may no longer work. When you try to query external tables that were created before installing this cumulative update, you receive the following error message:

> Msg 7320, Level 16, State 110, Line 68  
> Cannot execute the query "Remote Query" against OLE DB provider "MSOLEDBSQL" for linked server "(null)". Object reference not set to an instance of an object.

If you try to create a new external table, you receive the following error message:

> Msg 110813, Level 16, State 1, Line 64  
> Object reference not set to an instance of an object.

To work around this issue, you can uninstall this cumulative update or add the `Driver` keyword to the `CONNECTION_OPTIONS` argument. For more information, see [Generic ODBC external data sources may not work after installing Cumulative Update](https://techcommunity.microsoft.com/t5/sql-server-support-blog/generic-odbc-external-data-sources-may-not-work-after-installing/ba-p/3783873).

### Issue three

This issue is caused by a change introduced in this cumulative update for the [Managed Instance link](/azure/azure-sql/managed-instance/managed-instance-link-feature-overview) feature. Assume that the databases of an Always On availability group have one of the following conditions:

- The databases use memory-optimized tables, the FileStream class, or multiple log files.

- You upgrade a replica to this cumulative update. For example, the primary replica is upgraded to SQL Server 2019 CU20, and the secondary replica remains SQL Server 2019 CU19.

- The databases indicate the "Not Synchronizing" status.

- You review the `sys.dm_exec_requests` DMV and notice the `DB STARTUP` command is blocked on wait `HADR_RECOVERY_WAIT_FOR_UNDO`.

In this scenario, you restart the SQL Server instance hosting the primary replica of the availability group. Then the databases start to synchronize. Additionally, you might notice the following error messages logged in the SQL Server error log and Extended Event logs:

> Error 9642, Severity 16, State 3: An error occurred in a Service Broker/Database Mirroring transport connection endpoint. Error: 8474, State: 11. (Near endpoint role: target, far endpoint address: '')

If you have applied this cumulative update to one or more secondary replicas and are currently not synchronizing with the primary replica, you can use the following steps to mitigate this issue:

1. Add trace flag 12324 as a startup parameter on all replicas (including the primary replica). Restart the secondary replicas to activate this trace flag. Meanwhile, the primary replica should be synchronized with all secondary replicas restarted with trace flag 12324 as the startup parameter.

2. After all secondary replicas are updated and restarted, fail over the primary replica, now as a secondary role, and restart it to enable trace flag 12324.

3. Apply this cumulative update to the old primary replica and restart it in the secondary role.

4. Remove trace flag 12324 as the startup parameter from all replicas, and disable trace flag 12324 on all replicas by executing the `DBCC TRACEOFF(12324, -1)` statement.

> [!NOTE]
> Trace flag 12324 impacts only the Managed Instance Link feature and is only used to activate the changes in SQL Server 2019 CU20.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="2204516">[2204516](#2204516)</a> | Fixes an issue that can cause corruption of the internal data structure that the Analysis Services engine uses to manage memory. | Analysis Services | Analysis Services | Windows |
| <a id="2279650">[2279650](#2279650)</a> | Fixes a failure in SQL Server Analysis Services (SSAS) that you encounter after you rename partitions to the same name in a multidimensional model. | Analysis Services | Analysis Services | Windows |
| <a id="2255878">[2255878](#2255878)</a> | Fixes security vulnerabilities [CVE-2015-6420](https://nvd.nist.gov/vuln/detail/CVE-2015-6420) and [CVE-2017-15708](https://nvd.nist.gov/vuln/detail/CVE-2017-15708). | Integration Services | Integration Services | Windows |
| <a id="2284765">[2284765](#2284765)</a> | Fixes a `DateTime` issue where the month and day are incorrectly recognized in Master Data Services (MDS) that you encounter when the input format doesn't match the preset format. | Master Data Services | Master Data Services | Windows |
| <a id="2290381">[2290381](#2290381)</a> | Fixes an access violation issue, most often seen on a database in an availability group, that you encounter during virtual device interface (VDI) backups.| SQL Server Engine| Backup Restore | All |
| <a id="2128204">[2128204](#2128204)</a> | Fixes an assertion failure (Location: interop.cpp:125; Expression: 'RTL_ASSERT(nullptr != error) or (nullptr == error)') that you encounter when memory-optimized tempdb metadata is enabled. | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="2268752">[2268752](#2268752)</a> | Fixes a memory leak issue that you encounter when configuring SQL Server log shipping that's in standby or read-only mode for an In-memory OLTP database. </br></br>**Note**: You need to turn on trace flag 9953 during startup to avoid the issue. | SQL Server Engine | In-Memory OLTP | All |
| <a id="2251105">[2251105](#2251105)</a> | Updates the error message that's returned in the `SqlBackendNotSupported` exception when you run `CREATE EXTERNAL TABLE` by using a Synapse serverless external data source to the following one: </br></br>Azure Synapse Serverless SQL Pool is not a supported data source. | SQL Server Engine | PolyBase | All |
| <a id="2285519">[2285519](#2285519)</a> | Fixes a failure where the `DateTime` field can't be pushed down to some PolyBase generic ODBC external data sources such as Denodo when you query an external table by using a filter clause for a `DateTime` field. | SQL Server Engine | PolyBase | All |
| <a id="2280420">[2280420](#2280420)</a> </br> <a id="2292769">[2292769](#2292769)</a> | [FIX: Scalar UDF Inlining issues in SQL Server 2022 and 2019 (KB4538581)](https://support.microsoft.com/help/4538581) | SQL Server Engine| Query Execution | All |
| <a id="2162863">[2162863](#2162863)</a> | Fixes an access violation that may be encountered when querying the `sys.dm_os_memory_objects` dynamic management view (DMV). | SQL Server Engine | Query Execution | All |
| <a id="2204764">[2204764](#2204764)</a> | Fixes access violations and `INVALID_POINTER_READ_c0000005_sqlmin.dll!CProfileList::FGetPartitionSummaryXML` exceptions that you may encounter during the execution of `sys.dm_exec_query_plan_stats`. | SQL Server Engine | Query Execution | Windows |
| <a id="2275387">[2275387](#2275387)</a> | Fixes an assertion failure (Location: bpctxt.cpp:129; Expression: 'm_cCreated < m_cMaxBatches') that you encounter when running window queries that have aggregate functions in batch mode. | SQL Server Engine | Query Execution | All |
| <a id="2292999">[2292999](#2292999)</a> | Fixes an issue where running the `ALTER ASSEMBLY` command for a complex common language runtime (CLR) assembly can cause some of the other commands that are executed in parallel to time out. | SQL Server Engine | Query Execution | All |
| <a id="2112485">[2112485](#2112485)</a> | Fixes an issue where the cardinality estimation (CE) uniformly increases after each `LEFT JOIN` or `RIGHT JOIN` combines, which causes overestimation. This fix adds a limitation to the CE when the join predicates are the primary keys of the tables that are involved. </br></br>**Note**: Trace flag 9440 will turn off the functionality provided by this fix for databases with a compatibility level of 160 and earlier. | SQL Server Engine | Query Optimizer | All |
| <a id="2161795">[2161795](#2161795)</a> | Fixes an assertion failure (Location: purecall.cpp:51; Expression: !"purecall") that you encounter after you cancel a user-defined stored procedure that is still running. | SQL Server Engine | Query Optimizer | All |
| <a id="2216357">[2216357](#2216357)</a> | Produces consistent results for statements that perform multiple updates to a variable when the query optimization hotfixes are enabled, such as `SELECT @sum = @sum + c FROM t`. | SQL Server Engine | Query Optimizer | All |
| <a id="2264977">[2264977](#2264977)</a> | Fixes an issue that's caused by automatic parameterization of queries where interleaved execution of multi-statement table-valued functions (MSTVFs) may return incorrect results or cause a deadlock on the first execution. | SQL Server Engine | Query Optimizer | All |
| <a id="2299078">[2299078](#2299078)</a> | Fixes an issue where the `KILL STATS JOB` process leaks reference counts on some items when multiple asynchronous statistics jobs are running, which causes those items to remain in the queue (visible via `sys.dm_exec_background_job_queue`) until the SQL Server instance is restarted. | SQL Server Engine | Query Optimizer | All |
| <a id="2162994">[2162994](#2162994)</a> | Fixes an issue where the `DataAccess` property for the linked server is reset to `False` when you execute the `sp_addsubscription` stored procedure or create a subscription through the New Subscription Wizard on server A after: </br></br>1. You have a linked server on server A for server B and have used the linked server for data access. </br></br>2. You configure server A as the Publisher and server B as the Subscriber and create transactional replication. | SQL Server Engine | Replication | Windows |
| <a id="2212160">[2212160](#2212160)</a> </br><a id="2269819">[2269819](#2269819)</a> | Before the fix, you can still enable transactional replication or change data capture (CDC) and delayed durability on a database at the same time, even if transactional replication or CDC and delayed durability aren't compatible. This fix explicitly prevents you from enabling transactional replication or CDC and delayed durability on a database at the same time by returning the following error 22891 or 22892: </br></br>22891: Could not enable '\<FeatureName>' for database '\<DatabaseName>'. '\<FeatureName>' cannot be enabled on a DB with delayed durability set. </br></br>22892: Could not enable delayed durability on DB. Delayed durability cannot be enabled on a DB while '\<FeatureName>' is enabled. </br></br>For more information, see [Delayed durability and other SQL Server features](/sql/relational-databases/logs/control-transaction-durability#bkmk_OtherSQLFeatures). | SQL Server Engine | Replication | All |
| <a id="2021114">[2021114](#2021114)</a> | [FIX: Error may occur when setting the SQL Server Agent job history log (KB5024352)](../sqlserver-2022/error-set-sql-server-agent-job-history-log.md)| SQL Server Engine | SQL Agent | Linux |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU20 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5024276)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5024276-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5024276-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5024276-x64.exe| FD387773E613FECF9664CAF1777B48F3AB8C48A0B7BD863DEA40446867B7209C |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.39  | 292776    | 01-Apr-23 | 12:50 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 01-Apr-23 | 12:50 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.39      | 758224    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 175568    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 199632    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 202192    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 198608    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 214992    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 197584    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 193488    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 252368    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 174032    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.39      | 197072    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.39      | 1098664   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.39      | 567248    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 54696     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 59304     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 59816     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58832     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 61864     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58320     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58320     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 67496     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 53712     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.39      | 58280     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 18896     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17832     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.39      | 17872     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 01-Apr-23 | 12:50 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 01-Apr-23 | 12:50 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 01-Apr-23 | 12:50 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 01-Apr-23 | 12:50 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 01-Apr-23 | 12:50 | x86      |
| Msmdctr.dll                                               | 2018.150.35.39  | 38352     | 01-Apr-23 | 12:50 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.39  | 47787944  | 01-Apr-23 | 12:50 | x86      |
| Msmdlocal.dll                                             | 2018.150.35.39  | 66299856  | 01-Apr-23 | 12:50 | x64      |
| Msmdpump.dll                                              | 2018.150.35.39  | 10189736  | 01-Apr-23 | 12:50 | x64      |
| Msmdredir.dll                                             | 2018.150.35.39  | 7957928   | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16848     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17360     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17320     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17320     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 17360     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 18344     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 01-Apr-23 | 12:50 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.39      | 16808     | 01-Apr-23 | 12:50 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.39  | 65835472  | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 833448    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1628072   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1454032   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1642960   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1608608   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1001376   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 992720    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1536976   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1521576   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 810920    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.39  | 1596368   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 832464    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1624528   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1450960   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1637840   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1604560   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 998864    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 991184    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1532880   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1518032   | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 809936    | 01-Apr-23 | 12:50 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.39  | 1591760   | 01-Apr-23 | 12:50 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.39  | 8281000   | 01-Apr-23 | 12:50 | x86      |
| Msmgdsrv.dll                                              | 2018.150.35.39  | 10187176  | 01-Apr-23 | 12:50 | x64      |
| Msolap.dll                                                | 2018.150.35.39  | 8609232   | 01-Apr-23 | 12:50 | x86      |
| Msolap.dll                                                | 2018.150.35.39  | 11017120  | 01-Apr-23 | 12:50 | x64      |
| Msolui.dll                                                | 2018.150.35.39  | 286160    | 01-Apr-23 | 12:50 | x86      |
| Msolui.dll                                                | 2018.150.35.39  | 306640    | 01-Apr-23 | 12:50 | x64      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 01-Apr-23 | 12:50 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 01-Apr-23 | 12:50 | x64      |
| Sqlboot.dll                                               | 2019.150.4312.2 | 214992    | 01-Apr-23 | 12:50 | x64      |
| Sqlceip.exe                                               | 15.0.4312.2     | 292800    | 01-Apr-23 | 12:50 | x86      |
| Sqldumper.exe                                             | 2019.150.4312.2 | 153536    | 01-Apr-23 | 12:50 | x86      |
| Sqldumper.exe                                             | 2019.150.4312.2 | 186264    | 01-Apr-23 | 12:50 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 01-Apr-23 | 12:50 | x86      |
| Tmapi.dll                                                 | 2018.150.35.39  | 6178216   | 01-Apr-23 | 12:50 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.39  | 4917664   | 01-Apr-23 | 12:50 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.39  | 1184680   | 01-Apr-23 | 12:50 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.39  | 6806952   | 01-Apr-23 | 12:50 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.39  | 35460560  | 01-Apr-23 | 12:50 | x86      |
| Xmsrv.dll                                                 | 2018.150.35.39  | 26026448  | 01-Apr-23 | 12:50 | x64      |

SQL Server 2019 Database Services Common Core

|               File name              |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4312.2 | 165840    | 01-Apr-23 | 12:50 | x86      |
| Batchparser.dll                      | 2019.150.4312.2 | 182208    | 01-Apr-23 | 12:50 | x64      |
| Instapi150.dll                       | 2019.150.4312.2 | 88016     | 01-Apr-23 | 12:50 | x64      |
| Instapi150.dll                       | 2019.150.4312.2 | 75680     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4312.2 | 100240    | 01-Apr-23 | 12:50 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4312.2 | 87968     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4312.2     | 550856    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4312.2     | 550816    | 01-Apr-23 | 12:50 | x86      |
| Msasxpress.dll                       | 2018.150.35.39  | 27088     | 01-Apr-23 | 12:50 | x86      |
| Msasxpress.dll                       | 2018.150.35.39  | 32208     | 01-Apr-23 | 12:50 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4312.2 | 75664     | 01-Apr-23 | 12:50 | x86      |
| Pbsvcacctsync.dll                    | 2019.150.4312.2 | 92112     | 01-Apr-23 | 12:50 | x64      |
| Sqldumper.exe                        | 2019.150.4312.2 | 153536    | 01-Apr-23 | 12:50 | x86      |
| Sqldumper.exe                        | 2019.150.4312.2 | 186264    | 01-Apr-23 | 12:50 | x64      |
| Sqlftacct.dll                        | 2019.150.4312.2 | 59336     | 01-Apr-23 | 12:50 | x86      |
| Sqlftacct.dll                        | 2019.150.4312.2 | 79808     | 01-Apr-23 | 12:50 | x64      |
| Sqlmanager.dll                       | 2019.150.4312.2 | 743328    | 01-Apr-23 | 12:50 | x86      |
| Sqlmanager.dll                       | 2019.150.4312.2 | 878496    | 01-Apr-23 | 12:50 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4312.2 | 378816    | 01-Apr-23 | 12:50 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4312.2 | 432064    | 01-Apr-23 | 12:50 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4312.2 | 276416    | 01-Apr-23 | 12:50 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4312.2 | 358304    | 01-Apr-23 | 12:50 | x64      |
| Svrenumapi150.dll                    | 2019.150.4312.2 | 1161104   | 01-Apr-23 | 12:50 | x64      |
| Svrenumapi150.dll                    | 2019.150.4312.2 | 911248    | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 Data Quality

|         File name         | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4312.2  | 600000    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4312.2  | 599968    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4312.2  | 1857488   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4312.2  | 1857488   | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 sql_dreplay_client

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4312.2 | 137120    | 01-Apr-23 | 12:50 | x86      |
| Dreplaycommon.dll     | 2019.150.4312.2 | 667600    | 01-Apr-23 | 12:50 | x86      |
| Dreplayutil.dll       | 2019.150.4312.2 | 305104    | 01-Apr-23 | 12:50 | x86      |
| Instapi150.dll        | 2019.150.4312.2 | 88016     | 01-Apr-23 | 12:50 | x64      |
| Sqlresourceloader.dll | 2019.150.4312.2 | 38864     | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 sql_dreplay_controller

|       File name       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4312.2 | 667600    | 01-Apr-23 | 12:50 | x86      |
| Dreplaycontroller.exe | 2019.150.4312.2 | 366480    | 01-Apr-23 | 12:50 | x86      |
| Instapi150.dll        | 2019.150.4312.2 | 88016     | 01-Apr-23 | 12:50 | x64      |
| Sqlresourceloader.dll | 2019.150.4312.2 | 38864     | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 Database Services Core Instance

|                  File name                 |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4312.2 | 4658080   | 01-Apr-23 | 16:08 | x64      |
| Aetm-enclave.dll                           | 2019.150.4312.2 | 4612488   | 01-Apr-23 | 16:08 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4312.2 | 4931856   | 01-Apr-23 | 16:09 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4312.2 | 4873560   | 01-Apr-23 | 16:08 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 01-Apr-23 | 16:08 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 01-Apr-23 | 16:08 | x64      |
| Batchparser.dll                            | 2019.150.4312.2 | 182208    | 01-Apr-23 | 16:08 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 01-Apr-23 | 16:08 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 01-Apr-23 | 16:08 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 01-Apr-23 | 16:08 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 01-Apr-23 | 16:08 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4312.2 | 280464    | 01-Apr-23 | 16:08 | x64      |
| Dcexec.exe                                 | 2019.150.4312.2 | 87952     | 01-Apr-23 | 16:09 | x64      |
| Fssres.dll                                 | 2019.150.4312.2 | 96160     | 01-Apr-23 | 16:08 | x64      |
| Hadrres.dll                                | 2019.150.4312.2 | 206784    | 01-Apr-23 | 16:08 | x64      |
| Hkcompile.dll                              | 2019.150.4312.2 | 1292176   | 01-Apr-23 | 16:08 | x64      |
| Hkengine.dll                               | 2019.150.4312.2 | 5793680   | 01-Apr-23 | 16:08 | x64      |
| Hkruntime.dll                              | 2019.150.4312.2 | 182208    | 01-Apr-23 | 16:08 | x64      |
| Hktempdb.dll                               | 2019.150.4312.2 | 63392     | 01-Apr-23 | 16:08 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 01-Apr-23 | 16:08 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4312.2     | 235408    | 01-Apr-23 | 16:08 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4312.2 | 391056    | 01-Apr-23 | 16:09 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4312.2 | 325520    | 01-Apr-23 | 16:09 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4312.2 | 92112     | 01-Apr-23 | 16:09 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 01-Apr-23 | 16:08 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 01-Apr-23 | 16:08 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 01-Apr-23 | 16:08 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 01-Apr-23 | 16:08 | x64      |
| Qds.dll                                    | 2019.150.4312.2 | 1185728   | 01-Apr-23 | 16:08 | x64      |
| Rsfxft.dll                                 | 2019.150.4312.2 | 51088     | 01-Apr-23 | 16:09 | x64      |
| Secforwarder.dll                           | 2019.150.4312.2 | 79808     | 01-Apr-23 | 16:00 | x64      |
| Sqagtres.dll                               | 2019.150.4312.2 | 88016     | 01-Apr-23 | 16:09 | x64      |
| Sqlaamss.dll                               | 2019.150.4312.2 | 108496    | 01-Apr-23 | 16:09 | x64      |
| Sqlaccess.dll                              | 2019.150.4312.2 | 493520    | 01-Apr-23 | 16:09 | x64      |
| Sqlagent.exe                               | 2019.150.4312.2 | 731040    | 01-Apr-23 | 16:09 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4312.2 | 71632     | 01-Apr-23 | 16:09 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4312.2 | 79776     | 01-Apr-23 | 16:09 | x64      |
| Sqlboot.dll                                | 2019.150.4312.2 | 214992    | 01-Apr-23 | 16:09 | x64      |
| Sqlceip.exe                                | 15.0.4312.2     | 292800    | 01-Apr-23 | 16:09 | x86      |
| Sqlcmdss.dll                               | 2019.150.4312.2 | 88016     | 01-Apr-23 | 16:08 | x64      |
| Sqlctr150.dll                              | 2019.150.4312.2 | 116688    | 01-Apr-23 | 16:08 | x86      |
| Sqlctr150.dll                              | 2019.150.4312.2 | 145312    | 01-Apr-23 | 16:08 | x64      |
| Sqldk.dll                                  | 2019.150.4312.2 | 3159968   | 01-Apr-23 | 16:00 | x64      |
| Sqldtsss.dll                               | 2019.150.4312.2 | 108496    | 01-Apr-23 | 16:09 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 1595344   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3504016   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3700640   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4167584   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4286368   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3418016   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3586000   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4163472   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4016024   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4065168   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 2226064   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 2172832   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3872672   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3549072   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4020128   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3823568   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3823504   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3618768   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3504016   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 1537952   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 3913680   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                               | 2019.150.4312.2 | 4032416   | 01-Apr-23 | 15:56 | x64      |
| Sqllang.dll                                | 2019.150.4312.2 | 39860176  | 01-Apr-23 | 16:09 | x64      |
| Sqlmin.dll                                 | 2019.150.4312.2 | 40557984  | 01-Apr-23 | 16:09 | x64      |
| Sqlolapss.dll                              | 2019.150.4312.2 | 108448    | 01-Apr-23 | 16:09 | x64      |
| Sqlos.dll                                  | 2019.150.4312.2 | 42960     | 01-Apr-23 | 16:00 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4312.2 | 83920     | 01-Apr-23 | 16:09 | x64      |
| Sqlrepss.dll                               | 2019.150.4312.2 | 88016     | 01-Apr-23 | 16:09 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4312.2 | 51104     | 01-Apr-23 | 16:08 | x64      |
| Sqlscm.dll                                 | 2019.150.4312.2 | 88000     | 01-Apr-23 | 16:09 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4312.2 | 38864     | 01-Apr-23 | 16:09 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4312.2 | 5806016   | 01-Apr-23 | 16:08 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4312.2 | 673696    | 01-Apr-23 | 16:08 | x64      |
| Sqlservr.exe                               | 2019.150.4312.2 | 628688    | 01-Apr-23 | 16:08 | x64      |
| Sqlsvc.dll                                 | 2019.150.4312.2 | 182160    | 01-Apr-23 | 16:09 | x64      |
| Sqltses.dll                                | 2019.150.4312.2 | 9119648   | 01-Apr-23 | 16:00 | x64      |
| Sqsrvres.dll                               | 2019.150.4312.2 | 280512    | 01-Apr-23 | 16:08 | x64      |
| Stretchcodegen.exe                         | 15.0.4312.2     | 59344     | 01-Apr-23 | 16:08 | x86      |
| Svl.dll                                    | 2019.150.4312.2 | 161744    | 01-Apr-23 | 16:08 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 01-Apr-23 | 16:08 | x64      |
| Xe.dll                                     | 2019.150.4312.2 | 722896    | 01-Apr-23 | 16:09 | x64      |
| Xpadsi.exe                                 | 2019.150.4312.2 | 116688    | 01-Apr-23 | 16:08 | x64      |
| Xplog70.dll                                | 2019.150.4312.2 | 92104     | 01-Apr-23 | 16:09 | x64      |
| Xpqueue.dll                                | 2019.150.4312.2 | 92112     | 01-Apr-23 | 16:08 | x64      |
| Xprepl.dll                                 | 2019.150.4312.2 | 120768    | 01-Apr-23 | 16:08 | x64      |
| Xpstar.dll                                 | 2019.150.4312.2 | 472992    | 01-Apr-23 | 16:09 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4312.2 | 165840    | 01-Apr-23 | 12:50 | x86      |
| Batchparser.dll                                              | 2019.150.4312.2 | 182208    | 01-Apr-23 | 12:50 | x64      |
| Commanddest.dll                                              | 2019.150.4312.2 | 264080    | 01-Apr-23 | 12:50 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4312.2 | 227264    | 01-Apr-23 | 12:50 | x64      |
| Distrib.exe                                                  | 2019.150.4312.2 | 243664    | 01-Apr-23 | 12:50 | x64      |
| Dteparse.dll                                                 | 2019.150.4312.2 | 124864    | 01-Apr-23 | 12:50 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4312.2 | 133072    | 01-Apr-23 | 12:50 | x64      |
| Dtepkg.dll                                                   | 2019.150.4312.2 | 149408    | 01-Apr-23 | 12:50 | x64      |
| Dtexec.exe                                                   | 2019.150.4312.2 | 72592     | 01-Apr-23 | 12:50 | x64      |
| Dts.dll                                                      | 2019.150.4312.2 | 3143632   | 01-Apr-23 | 12:50 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4312.2 | 501712    | 01-Apr-23 | 12:50 | x64      |
| Dtsconn.dll                                                  | 2019.150.4312.2 | 522192    | 01-Apr-23 | 12:50 | x64      |
| Dtshost.exe                                                  | 2019.150.4312.2 | 106448    | 01-Apr-23 | 12:50 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4312.2 | 567232    | 01-Apr-23 | 12:50 | x64      |
| Dtspipeline.dll                                              | 2019.150.4312.2 | 1329056   | 01-Apr-23 | 12:50 | x64      |
| Dtswizard.exe                                                | 15.0.4312.2     | 886720    | 01-Apr-23 | 12:50 | x64      |
| Dtuparse.dll                                                 | 2019.150.4312.2 | 100296    | 01-Apr-23 | 12:50 | x64      |
| Dtutil.exe                                                   | 2019.150.4312.2 | 149408    | 01-Apr-23 | 12:50 | x64      |
| Exceldest.dll                                                | 2019.150.4312.2 | 280520    | 01-Apr-23 | 12:50 | x64      |
| Excelsrc.dll                                                 | 2019.150.4312.2 | 309184    | 01-Apr-23 | 12:50 | x64      |
| Execpackagetask.dll                                          | 2019.150.4312.2 | 186320    | 01-Apr-23 | 12:50 | x64      |
| Flatfiledest.dll                                             | 2019.150.4312.2 | 411600    | 01-Apr-23 | 12:50 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4312.2 | 427936    | 01-Apr-23 | 12:50 | x64      |
| Logread.exe                                                  | 2019.150.4312.2 | 722880    | 01-Apr-23 | 12:50 | x64      |
| Mergetxt.dll                                                 | 2019.150.4312.2 | 75712     | 01-Apr-23 | 12:50 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4312.2     | 59344     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4312.2     | 42944     | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4312.2     | 391072    | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4312.2 | 1697680   | 01-Apr-23 | 12:50 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4312.2 | 1640384   | 01-Apr-23 | 12:50 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4312.2     | 550816    | 01-Apr-23 | 12:50 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4312.2 | 112576    | 01-Apr-23 | 12:50 | x64      |
| Msgprox.dll                                                  | 2019.150.4312.2 | 300960    | 01-Apr-23 | 12:50 | x64      |
| Msoledbsql.dll                                               | 2018.186.5.0    | 2734064   | 01-Apr-23 | 12:50 | x64      |
| Msoledbsql.dll                                               | 2018.186.5.0    | 153616    | 01-Apr-23 | 12:50 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4312.2 | 1496992   | 01-Apr-23 | 12:50 | x64      |
| Oledbdest.dll                                                | 2019.150.4312.2 | 280528    | 01-Apr-23 | 12:50 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4312.2 | 313280    | 01-Apr-23 | 12:50 | x64      |
| Osql.exe                                                     | 2019.150.4312.2 | 92064     | 01-Apr-23 | 12:50 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4312.2 | 497568    | 01-Apr-23 | 12:50 | x64      |
| Rawdest.dll                                                  | 2019.150.4312.2 | 227264    | 01-Apr-23 | 12:50 | x64      |
| Rawsource.dll                                                | 2019.150.4312.2 | 210832    | 01-Apr-23 | 12:50 | x64      |
| Rdistcom.dll                                                 | 2019.150.4312.2 | 915360    | 01-Apr-23 | 12:50 | x64      |
| Recordsetdest.dll                                            | 2019.150.4312.2 | 202704    | 01-Apr-23 | 12:50 | x64      |
| Repldp.dll                                                   | 2019.150.4312.2 | 313248    | 01-Apr-23 | 12:50 | x64      |
| Replerrx.dll                                                 | 2019.150.4312.2 | 182224    | 01-Apr-23 | 12:50 | x64      |
| Replisapi.dll                                                | 2019.150.4312.2 | 395168    | 01-Apr-23 | 12:50 | x64      |
| Replmerg.exe                                                 | 2019.150.4312.2 | 563104    | 01-Apr-23 | 12:50 | x64      |
| Replprov.dll                                                 | 2019.150.4312.2 | 862112    | 01-Apr-23 | 12:50 | x64      |
| Replrec.dll                                                  | 2019.150.4312.2 | 1034144   | 01-Apr-23 | 12:50 | x64      |
| Replsub.dll                                                  | 2019.150.4312.2 | 473040    | 01-Apr-23 | 12:50 | x64      |
| Replsync.dll                                                 | 2019.150.4312.2 | 165840    | 01-Apr-23 | 12:50 | x64      |
| Spresolv.dll                                                 | 2019.150.4312.2 | 276432    | 01-Apr-23 | 12:50 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4312.2 | 264080    | 01-Apr-23 | 12:50 | x64      |
| Sqldiag.exe                                                  | 2019.150.4312.2 | 1140640   | 01-Apr-23 | 12:50 | x64      |
| Sqldistx.dll                                                 | 2019.150.4312.2 | 251856    | 01-Apr-23 | 12:50 | x64      |
| Sqllogship.exe                                               | 15.0.4312.2     | 104352    | 01-Apr-23 | 12:50 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4312.2 | 399264    | 01-Apr-23 | 12:50 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4312.2 | 51104     | 01-Apr-23 | 12:50 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4312.2 | 38864     | 01-Apr-23 | 12:50 | x86      |
| Sqlscm.dll                                                   | 2019.150.4312.2 | 79824     | 01-Apr-23 | 12:50 | x86      |
| Sqlscm.dll                                                   | 2019.150.4312.2 | 88000     | 01-Apr-23 | 12:50 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4312.2 | 149456    | 01-Apr-23 | 12:50 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4312.2 | 182160    | 01-Apr-23 | 12:50 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4312.2 | 202704    | 01-Apr-23 | 12:50 | x64      |
| Ssradd.dll                                                   | 2019.150.4312.2 | 83920     | 01-Apr-23 | 12:50 | x64      |
| Ssravg.dll                                                   | 2019.150.4312.2 | 83904     | 01-Apr-23 | 12:50 | x64      |
| Ssrdown.dll                                                  | 2019.150.4312.2 | 75728     | 01-Apr-23 | 12:50 | x64      |
| Ssrmax.dll                                                   | 2019.150.4312.2 | 83904     | 01-Apr-23 | 12:50 | x64      |
| Ssrmin.dll                                                   | 2019.150.4312.2 | 83904     | 01-Apr-23 | 12:50 | x64      |
| Ssrpub.dll                                                   | 2019.150.4312.2 | 79824     | 01-Apr-23 | 12:50 | x64      |
| Ssrup.dll                                                    | 2019.150.4312.2 | 75712     | 01-Apr-23 | 12:50 | x64      |
| Txagg.dll                                                    | 2019.150.4312.2 | 391056    | 01-Apr-23 | 12:50 | x64      |
| Txbdd.dll                                                    | 2019.150.4312.2 | 194512    | 01-Apr-23 | 12:50 | x64      |
| Txdatacollector.dll                                          | 2019.150.4312.2 | 473040    | 01-Apr-23 | 12:50 | x64      |
| Txdataconvert.dll                                            | 2019.150.4312.2 | 317344    | 01-Apr-23 | 12:50 | x64      |
| Txderived.dll                                                | 2019.150.4312.2 | 640928    | 01-Apr-23 | 12:50 | x64      |
| Txlookup.dll                                                 | 2019.150.4312.2 | 542672    | 01-Apr-23 | 12:50 | x64      |
| Txmerge.dll                                                  | 2019.150.4312.2 | 247744    | 01-Apr-23 | 12:50 | x64      |
| Txmergejoin.dll                                              | 2019.150.4312.2 | 309200    | 01-Apr-23 | 12:50 | x64      |
| Txmulticast.dll                                              | 2019.150.4312.2 | 145360    | 01-Apr-23 | 12:50 | x64      |
| Txrowcount.dll                                               | 2019.150.4312.2 | 141264    | 01-Apr-23 | 12:50 | x64      |
| Txsort.dll                                                   | 2019.150.4312.2 | 288704    | 01-Apr-23 | 12:50 | x64      |
| Txsplit.dll                                                  | 2019.150.4312.2 | 624544    | 01-Apr-23 | 12:50 | x64      |
| Txunionall.dll                                               | 2019.150.4312.2 | 198608    | 01-Apr-23 | 12:50 | x64      |
| Xe.dll                                                       | 2019.150.4312.2 | 722896    | 01-Apr-23 | 12:50 | x64      |
| Xmlsub.dll                                                   | 2019.150.4312.2 | 296896    | 01-Apr-23 | 12:50 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4312.2 | 96160     | 01-Apr-23 | 12:50 | x64      |
| Exthost.exe        | 2019.150.4312.2 | 239520    | 01-Apr-23 | 12:50 | x64      |
| Launchpad.exe      | 2019.150.4312.2 | 1230784   | 01-Apr-23 | 12:50 | x64      |
| Sqlsatellite.dll   | 2019.150.4312.2 | 1025952   | 01-Apr-23 | 12:50 | x64      |

SQL Server 2019 Full-Text Engine

|    File name   |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4312.2 | 686032    | 01-Apr-23 | 12:50 | x64      |
| Fdhost.exe     | 2019.150.4312.2 | 128928    | 01-Apr-23 | 12:50 | x64      |
| Fdlauncher.exe | 2019.150.4312.2 | 79824     | 01-Apr-23 | 12:50 | x64      |
| Sqlft150ph.dll | 2019.150.4312.2 | 92064     | 01-Apr-23 | 12:50 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4312.2  | 30656     | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4312.2 | 227264    | 01-Apr-23 | 12:56 | x86      |
| Commanddest.dll                                               | 2019.150.4312.2 | 264080    | 01-Apr-23 | 12:56 | x64      |
| Dteparse.dll                                                  | 2019.150.4312.2 | 124864    | 01-Apr-23 | 12:56 | x64      |
| Dteparse.dll                                                  | 2019.150.4312.2 | 112576    | 01-Apr-23 | 12:56 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4312.2 | 116672    | 01-Apr-23 | 12:56 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4312.2 | 133072    | 01-Apr-23 | 12:56 | x64      |
| Dtepkg.dll                                                    | 2019.150.4312.2 | 149408    | 01-Apr-23 | 12:56 | x64      |
| Dtepkg.dll                                                    | 2019.150.4312.2 | 133056    | 01-Apr-23 | 12:56 | x86      |
| Dtexec.exe                                                    | 2019.150.4312.2 | 72592     | 01-Apr-23 | 12:56 | x64      |
| Dtexec.exe                                                    | 2019.150.4312.2 | 63888     | 01-Apr-23 | 12:56 | x86      |
| Dts.dll                                                       | 2019.150.4312.2 | 2762688   | 01-Apr-23 | 12:56 | x86      |
| Dts.dll                                                       | 2019.150.4312.2 | 3143632   | 01-Apr-23 | 12:56 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4312.2 | 444352    | 01-Apr-23 | 12:56 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4312.2 | 501712    | 01-Apr-23 | 12:56 | x64      |
| Dtsconn.dll                                                   | 2019.150.4312.2 | 522192    | 01-Apr-23 | 12:56 | x64      |
| Dtsconn.dll                                                   | 2019.150.4312.2 | 432080    | 01-Apr-23 | 12:56 | x86      |
| Dtsdebughost.exe                                              | 2019.150.4312.2 | 112072    | 01-Apr-23 | 12:56 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4312.2 | 93648     | 01-Apr-23 | 12:56 | x86      |
| Dtshost.exe                                                   | 2019.150.4312.2 | 106448    | 01-Apr-23 | 12:56 | x64      |
| Dtshost.exe                                                   | 2019.150.4312.2 | 89040     | 01-Apr-23 | 12:56 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4312.2 | 554912    | 01-Apr-23 | 12:56 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4312.2 | 567232    | 01-Apr-23 | 12:56 | x64      |
| Dtspipeline.dll                                               | 2019.150.4312.2 | 1120208   | 01-Apr-23 | 12:56 | x86      |
| Dtspipeline.dll                                               | 2019.150.4312.2 | 1329056   | 01-Apr-23 | 12:56 | x64      |
| Dtswizard.exe                                                 | 15.0.4312.2     | 886720    | 01-Apr-23 | 12:56 | x64      |
| Dtswizard.exe                                                 | 15.0.4312.2     | 890816    | 01-Apr-23 | 12:56 | x86      |
| Dtuparse.dll                                                  | 2019.150.4312.2 | 100296    | 01-Apr-23 | 12:56 | x64      |
| Dtuparse.dll                                                  | 2019.150.4312.2 | 88000     | 01-Apr-23 | 12:56 | x86      |
| Dtutil.exe                                                    | 2019.150.4312.2 | 130464    | 01-Apr-23 | 12:56 | x86      |
| Dtutil.exe                                                    | 2019.150.4312.2 | 149408    | 01-Apr-23 | 12:56 | x64      |
| Exceldest.dll                                                 | 2019.150.4312.2 | 280520    | 01-Apr-23 | 12:56 | x64      |
| Exceldest.dll                                                 | 2019.150.4312.2 | 235424    | 01-Apr-23 | 12:56 | x86      |
| Excelsrc.dll                                                  | 2019.150.4312.2 | 309184    | 01-Apr-23 | 12:56 | x64      |
| Excelsrc.dll                                                  | 2019.150.4312.2 | 260048    | 01-Apr-23 | 12:56 | x86      |
| Execpackagetask.dll                                           | 2019.150.4312.2 | 149440    | 01-Apr-23 | 12:56 | x86      |
| Execpackagetask.dll                                           | 2019.150.4312.2 | 186320    | 01-Apr-23 | 12:56 | x64      |
| Flatfiledest.dll                                              | 2019.150.4312.2 | 358336    | 01-Apr-23 | 12:56 | x86      |
| Flatfiledest.dll                                              | 2019.150.4312.2 | 411600    | 01-Apr-23 | 12:56 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4312.2 | 370624    | 01-Apr-23 | 12:56 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4312.2 | 427936    | 01-Apr-23 | 12:56 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4312.2     | 120784    | 01-Apr-23 | 12:56 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4312.2     | 120768    | 01-Apr-23 | 12:56 | x86      |
| Isserverexec.exe                                              | 15.0.4312.2     | 145352    | 01-Apr-23 | 12:56 | x64      |
| Isserverexec.exe                                              | 15.0.4312.2     | 149440    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4312.2     | 116640    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4312.2     | 59344     | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4312.2     | 509856    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4312.2     | 509888    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4312.2     | 42896     | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4312.2     | 42944     | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4312.2     | 391072    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4312.2     | 59296     | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4312.2     | 59344     | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4312.2     | 141216    | 01-Apr-23 | 12:56 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4312.2     | 141216    | 01-Apr-23 | 12:56 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4312.2     | 219088    | 01-Apr-23 | 12:56 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4312.2 | 100288    | 01-Apr-23 | 12:56 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4312.2 | 112576    | 01-Apr-23 | 12:56 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.39  | 10065320  | 01-Apr-23 | 12:50 | x64      |
| Odbcdest.dll                                                  | 2019.150.4312.2 | 370576    | 01-Apr-23 | 12:56 | x64      |
| Odbcdest.dll                                                  | 2019.150.4312.2 | 321440    | 01-Apr-23 | 12:56 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4312.2 | 382864    | 01-Apr-23 | 12:56 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4312.2 | 329680    | 01-Apr-23 | 12:56 | x86      |
| Oledbdest.dll                                                 | 2019.150.4312.2 | 280528    | 01-Apr-23 | 12:56 | x64      |
| Oledbdest.dll                                                 | 2019.150.4312.2 | 239568    | 01-Apr-23 | 12:56 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4312.2 | 313280    | 01-Apr-23 | 12:56 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4312.2 | 264128    | 01-Apr-23 | 12:56 | x86      |
| Rawdest.dll                                                   | 2019.150.4312.2 | 227264    | 01-Apr-23 | 12:56 | x64      |
| Rawdest.dll                                                   | 2019.150.4312.2 | 190416    | 01-Apr-23 | 12:56 | x86      |
| Rawsource.dll                                                 | 2019.150.4312.2 | 210832    | 01-Apr-23 | 12:56 | x64      |
| Rawsource.dll                                                 | 2019.150.4312.2 | 178128    | 01-Apr-23 | 12:56 | x86      |
| Recordsetdest.dll                                             | 2019.150.4312.2 | 174016    | 01-Apr-23 | 12:56 | x86      |
| Recordsetdest.dll                                             | 2019.150.4312.2 | 202704    | 01-Apr-23 | 12:56 | x64      |
| Sqlceip.exe                                                   | 15.0.4312.2     | 292800    | 01-Apr-23 | 12:56 | x86      |
| Sqldest.dll                                                   | 2019.150.4312.2 | 239552    | 01-Apr-23 | 12:56 | x86      |
| Sqldest.dll                                                   | 2019.150.4312.2 | 276424    | 01-Apr-23 | 12:56 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4312.2 | 169920    | 01-Apr-23 | 12:56 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4312.2 | 202704    | 01-Apr-23 | 12:56 | x64      |
| Txagg.dll                                                     | 2019.150.4312.2 | 329680    | 01-Apr-23 | 12:56 | x86      |
| Txagg.dll                                                     | 2019.150.4312.2 | 391056    | 01-Apr-23 | 12:56 | x64      |
| Txbdd.dll                                                     | 2019.150.4312.2 | 153544    | 01-Apr-23 | 12:56 | x86      |
| Txbdd.dll                                                     | 2019.150.4312.2 | 194512    | 01-Apr-23 | 12:56 | x64      |
| Txbestmatch.dll                                               | 2019.150.4312.2 | 546752    | 01-Apr-23 | 12:56 | x86      |
| Txbestmatch.dll                                               | 2019.150.4312.2 | 653248    | 01-Apr-23 | 12:56 | x64      |
| Txcache.dll                                                   | 2019.150.4312.2 | 165832    | 01-Apr-23 | 12:56 | x86      |
| Txcache.dll                                                   | 2019.150.4312.2 | 198592    | 01-Apr-23 | 12:56 | x64      |
| Txcharmap.dll                                                 | 2019.150.4312.2 | 272336    | 01-Apr-23 | 12:56 | x86      |
| Txcharmap.dll                                                 | 2019.150.4312.2 | 313248    | 01-Apr-23 | 12:56 | x64      |
| Txcopymap.dll                                                 | 2019.150.4312.2 | 165824    | 01-Apr-23 | 12:56 | x86      |
| Txcopymap.dll                                                 | 2019.150.4312.2 | 198608    | 01-Apr-23 | 12:56 | x64      |
| Txdataconvert.dll                                             | 2019.150.4312.2 | 276432    | 01-Apr-23 | 12:56 | x86      |
| Txdataconvert.dll                                             | 2019.150.4312.2 | 317344    | 01-Apr-23 | 12:56 | x64      |
| Txderived.dll                                                 | 2019.150.4312.2 | 559040    | 01-Apr-23 | 12:56 | x86      |
| Txderived.dll                                                 | 2019.150.4312.2 | 640928    | 01-Apr-23 | 12:56 | x64      |
| Txfileextractor.dll                                           | 2019.150.4312.2 | 182208    | 01-Apr-23 | 12:56 | x86      |
| Txfileextractor.dll                                           | 2019.150.4312.2 | 219072    | 01-Apr-23 | 12:56 | x64      |
| Txfileinserter.dll                                            | 2019.150.4312.2 | 182224    | 01-Apr-23 | 12:56 | x86      |
| Txfileinserter.dll                                            | 2019.150.4312.2 | 214992    | 01-Apr-23 | 12:56 | x64      |
| Txgroupdups.dll                                               | 2019.150.4312.2 | 255952    | 01-Apr-23 | 12:56 | x86      |
| Txgroupdups.dll                                               | 2019.150.4312.2 | 313248    | 01-Apr-23 | 12:56 | x64      |
| Txlineage.dll                                                 | 2019.150.4312.2 | 128976    | 01-Apr-23 | 12:56 | x86      |
| Txlineage.dll                                                 | 2019.150.4312.2 | 153552    | 01-Apr-23 | 12:56 | x64      |
| Txlookup.dll                                                  | 2019.150.4312.2 | 468944    | 01-Apr-23 | 12:56 | x86      |
| Txlookup.dll                                                  | 2019.150.4312.2 | 542672    | 01-Apr-23 | 12:56 | x64      |
| Txmerge.dll                                                   | 2019.150.4312.2 | 202704    | 01-Apr-23 | 12:56 | x86      |
| Txmerge.dll                                                   | 2019.150.4312.2 | 247744    | 01-Apr-23 | 12:56 | x64      |
| Txmergejoin.dll                                               | 2019.150.4312.2 | 247744    | 01-Apr-23 | 12:56 | x86      |
| Txmergejoin.dll                                               | 2019.150.4312.2 | 309200    | 01-Apr-23 | 12:56 | x64      |
| Txmulticast.dll                                               | 2019.150.4312.2 | 116672    | 01-Apr-23 | 12:56 | x86      |
| Txmulticast.dll                                               | 2019.150.4312.2 | 145360    | 01-Apr-23 | 12:56 | x64      |
| Txpivot.dll                                                   | 2019.150.4312.2 | 206784    | 01-Apr-23 | 12:56 | x86      |
| Txpivot.dll                                                   | 2019.150.4312.2 | 239552    | 01-Apr-23 | 12:56 | x64      |
| Txrowcount.dll                                                | 2019.150.4312.2 | 112592    | 01-Apr-23 | 12:56 | x86      |
| Txrowcount.dll                                                | 2019.150.4312.2 | 141264    | 01-Apr-23 | 12:56 | x64      |
| Txsampling.dll                                                | 2019.150.4312.2 | 157632    | 01-Apr-23 | 12:56 | x86      |
| Txsampling.dll                                                | 2019.150.4312.2 | 194496    | 01-Apr-23 | 12:56 | x64      |
| Txscd.dll                                                     | 2019.150.4312.2 | 198592    | 01-Apr-23 | 12:56 | x86      |
| Txscd.dll                                                     | 2019.150.4312.2 | 235472    | 01-Apr-23 | 12:56 | x64      |
| Txsort.dll                                                    | 2019.150.4312.2 | 231360    | 01-Apr-23 | 12:56 | x86      |
| Txsort.dll                                                    | 2019.150.4312.2 | 288704    | 01-Apr-23 | 12:56 | x64      |
| Txsplit.dll                                                   | 2019.150.4312.2 | 550864    | 01-Apr-23 | 12:56 | x86      |
| Txsplit.dll                                                   | 2019.150.4312.2 | 624544    | 01-Apr-23 | 12:56 | x64      |
| Txtermextraction.dll                                          | 2019.150.4312.2 | 8644544   | 01-Apr-23 | 12:56 | x86      |
| Txtermextraction.dll                                          | 2019.150.4312.2 | 8701840   | 01-Apr-23 | 12:56 | x64      |
| Txtermlookup.dll                                              | 2019.150.4312.2 | 4138944   | 01-Apr-23 | 12:56 | x86      |
| Txtermlookup.dll                                              | 2019.150.4312.2 | 4183968   | 01-Apr-23 | 12:56 | x64      |
| Txunionall.dll                                                | 2019.150.4312.2 | 161728    | 01-Apr-23 | 12:56 | x86      |
| Txunionall.dll                                                | 2019.150.4312.2 | 198608    | 01-Apr-23 | 12:56 | x64      |
| Txunpivot.dll                                                 | 2019.150.4312.2 | 182208    | 01-Apr-23 | 12:56 | x86      |
| Txunpivot.dll                                                 | 2019.150.4312.2 | 214992    | 01-Apr-23 | 12:56 | x64      |
| Xe.dll                                                        | 2019.150.4312.2 | 632720    | 01-Apr-23 | 12:56 | x86      |
| Xe.dll                                                        | 2019.150.4312.2 | 722896    | 01-Apr-23 | 12:56 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1963.0     | 559576    | 01-Apr-23 | 16:01 | x86      |
| Dmsnative.dll                                                        | 2018.150.1963.0 | 152496    | 01-Apr-23 | 16:01 | x64      |
| Dwengineservice.dll                                                  | 15.0.1963.0     | 45016     | 01-Apr-23 | 16:01 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 01-Apr-23 | 16:01 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 01-Apr-23 | 16:01 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 01-Apr-23 | 16:01 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 01-Apr-23 | 16:01 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 01-Apr-23 | 16:01 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 01-Apr-23 | 16:01 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 01-Apr-23 | 16:01 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 01-Apr-23 | 16:01 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 01-Apr-23 | 16:01 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 01-Apr-23 | 16:01 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 01-Apr-23 | 16:01 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 01-Apr-23 | 16:01 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 01-Apr-23 | 16:01 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 01-Apr-23 | 16:01 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 01-Apr-23 | 16:01 | x64      |
| Instapi150.dll                                                       | 2019.150.4312.2 | 88016     | 01-Apr-23 | 16:01 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 01-Apr-23 | 16:01 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 01-Apr-23 | 16:01 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 01-Apr-23 | 16:01 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 01-Apr-23 | 16:01 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 01-Apr-23 | 16:01 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 01-Apr-23 | 16:01 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 01-Apr-23 | 16:01 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 01-Apr-23 | 16:01 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 01-Apr-23 | 16:01 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 01-Apr-23 | 16:01 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1963.0     | 67504     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1963.0     | 293296    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1963.0     | 1957808   | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1963.0     | 169432    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1963.0     | 649688    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1963.0     | 246192    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1963.0     | 139224    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1963.0     | 79832     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1963.0     | 51160     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1963.0     | 88536     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1963.0     | 1129432   | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1963.0     | 80856     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1963.0     | 70576     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1963.0     | 35248     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1963.0     | 31152     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1963.0     | 46512     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1963.0     | 21424     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1963.0     | 26544     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1963.0     | 131504    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1963.0     | 86488     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1963.0     | 100784    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1963.0     | 293296    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 120240    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 138160    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 141232    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 137688    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 150448    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 139696    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 134576    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 176560    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 117680    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1963.0     | 136624    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1963.0     | 72624     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1963.0     | 21936     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1963.0     | 37336     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1963.0     | 128984    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1963.0     | 3064752   | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1963.0     | 3955632   | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 118232    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 133080    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 137688    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 133592    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 148440    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 134064    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 130480    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 170968    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 115160    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1963.0     | 132016    | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1963.0     | 67504     | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1963.0     | 2682800   | 01-Apr-23 | 16:01 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1963.0     | 2436568   | 01-Apr-23 | 16:01 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4312.2 | 452560    | 01-Apr-23 | 16:01 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4312.2 | 7403472   | 01-Apr-23 | 16:01 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 01-Apr-23 | 16:01 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 01-Apr-23 | 16:01 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 01-Apr-23 | 16:01 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 01-Apr-23 | 16:01 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 01-Apr-23 | 16:01 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 01-Apr-23 | 16:01 | x64      |
| Secforwarder.dll                                                     | 2019.150.4312.2 | 79808     | 01-Apr-23 | 16:01 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1963.0 | 61360     | 01-Apr-23 | 16:01 | x64      |
| Sqldk.dll                                                            | 2019.150.4312.2 | 3159968   | 01-Apr-23 | 16:01 | x64      |
| Sqldumper.exe                                                        | 2019.150.4312.2 | 186264    | 01-Apr-23 | 16:01 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 1595344   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 4167584   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 3418016   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 4163472   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 4065168   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 2226064   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 2172832   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 3823568   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 3823504   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 1537952   | 01-Apr-23 | 15:56 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4312.2 | 4032416   | 01-Apr-23 | 15:56 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.3.1   | 1898432   | 01-Apr-23 | 16:01 | x64      |
| Sqlos.dll                                                            | 2019.150.4312.2 | 42960     | 01-Apr-23 | 16:01 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1963.0 | 4841392   | 01-Apr-23 | 16:01 | x64      |
| Sqltses.dll                                                          | 2019.150.4312.2 | 9119648   | 01-Apr-23 | 16:01 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 01-Apr-23 | 16:01 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 01-Apr-23 | 16:01 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 01-Apr-23 | 16:01 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 01-Apr-23 | 16:01 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 01-Apr-23 | 16:01 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 01-Apr-23 | 16:01 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4312.2  | 30664     | 01-Apr-23 | 12:50 | x86      |

SQL Server 2019 sql_tools_extensions

|                           File name                          |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4312.2 | 1632192   | 01-Apr-23 | 13:06 | x86      |
| Dtaengine.exe                                                | 2019.150.4312.2 | 219040    | 01-Apr-23 | 13:06 | x86      |
| Dteparse.dll                                                 | 2019.150.4312.2 | 112576    | 01-Apr-23 | 13:06 | x86      |
| Dteparse.dll                                                 | 2019.150.4312.2 | 124864    | 01-Apr-23 | 13:06 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4312.2 | 116672    | 01-Apr-23 | 13:06 | x86      |
| Dteparsemgd.dll                                              | 2019.150.4312.2 | 133072    | 01-Apr-23 | 13:06 | x64      |
| Dtepkg.dll                                                   | 2019.150.4312.2 | 133056    | 01-Apr-23 | 13:06 | x86      |
| Dtepkg.dll                                                   | 2019.150.4312.2 | 149408    | 01-Apr-23 | 13:06 | x64      |
| Dtexec.exe                                                   | 2019.150.4312.2 | 63888     | 01-Apr-23 | 13:06 | x86      |
| Dtexec.exe                                                   | 2019.150.4312.2 | 72592     | 01-Apr-23 | 13:06 | x64      |
| Dts.dll                                                      | 2019.150.4312.2 | 2762688   | 01-Apr-23 | 13:06 | x86      |
| Dts.dll                                                      | 2019.150.4312.2 | 3143632   | 01-Apr-23 | 13:06 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4312.2 | 444352    | 01-Apr-23 | 13:06 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4312.2 | 501712    | 01-Apr-23 | 13:06 | x64      |
| Dtsconn.dll                                                  | 2019.150.4312.2 | 432080    | 01-Apr-23 | 13:06 | x86      |
| Dtsconn.dll                                                  | 2019.150.4312.2 | 522192    | 01-Apr-23 | 13:06 | x64      |
| Dtshost.exe                                                  | 2019.150.4312.2 | 106448    | 01-Apr-23 | 13:06 | x64      |
| Dtshost.exe                                                  | 2019.150.4312.2 | 89040     | 01-Apr-23 | 13:06 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4312.2 | 554912    | 01-Apr-23 | 13:06 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4312.2 | 567232    | 01-Apr-23 | 13:06 | x64      |
| Dtspipeline.dll                                              | 2019.150.4312.2 | 1329056   | 01-Apr-23 | 13:06 | x64      |
| Dtspipeline.dll                                              | 2019.150.4312.2 | 1120208   | 01-Apr-23 | 13:06 | x86      |
| Dtswizard.exe                                                | 15.0.4312.2     | 886720    | 01-Apr-23 | 13:06 | x64      |
| Dtswizard.exe                                                | 15.0.4312.2     | 890816    | 01-Apr-23 | 13:06 | x86      |
| Dtuparse.dll                                                 | 2019.150.4312.2 | 100296    | 01-Apr-23 | 13:06 | x64      |
| Dtuparse.dll                                                 | 2019.150.4312.2 | 88000     | 01-Apr-23 | 13:06 | x86      |
| Dtutil.exe                                                   | 2019.150.4312.2 | 130464    | 01-Apr-23 | 13:06 | x86      |
| Dtutil.exe                                                   | 2019.150.4312.2 | 149408    | 01-Apr-23 | 13:06 | x64      |
| Exceldest.dll                                                | 2019.150.4312.2 | 235424    | 01-Apr-23 | 13:06 | x86      |
| Exceldest.dll                                                | 2019.150.4312.2 | 280520    | 01-Apr-23 | 13:06 | x64      |
| Excelsrc.dll                                                 | 2019.150.4312.2 | 260048    | 01-Apr-23 | 13:06 | x86      |
| Excelsrc.dll                                                 | 2019.150.4312.2 | 309184    | 01-Apr-23 | 13:06 | x64      |
| Flatfiledest.dll                                             | 2019.150.4312.2 | 358336    | 01-Apr-23 | 13:06 | x86      |
| Flatfiledest.dll                                             | 2019.150.4312.2 | 411600    | 01-Apr-23 | 13:06 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4312.2 | 370624    | 01-Apr-23 | 13:06 | x86      |
| Flatfilesrc.dll                                              | 2019.150.4312.2 | 427936    | 01-Apr-23 | 13:06 | x64      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4312.2     | 116688    | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4312.2     | 403408    | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4312.2     | 403408    | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4312.2     | 3004352   | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4312.2     | 3004368   | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4312.2     | 42896     | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4312.2     | 42944     | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4312.2     | 59296     | 01-Apr-23 | 13:06 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 01-Apr-23 | 13:06 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4312.2 | 100288    | 01-Apr-23 | 13:06 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4312.2 | 112576    | 01-Apr-23 | 13:06 | x64      |
| Msmgdsrv.dll                                                 | 2018.150.35.39  | 8281000   | 01-Apr-23 | 12:50 | x86      |
| Oledbdest.dll                                                | 2019.150.4312.2 | 239568    | 01-Apr-23 | 13:06 | x86      |
| Oledbdest.dll                                                | 2019.150.4312.2 | 280528    | 01-Apr-23 | 13:06 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4312.2 | 264128    | 01-Apr-23 | 13:06 | x86      |
| Oledbsrc.dll                                                 | 2019.150.4312.2 | 313280    | 01-Apr-23 | 13:06 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4312.2 | 38864     | 01-Apr-23 | 13:06 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4312.2 | 51104     | 01-Apr-23 | 13:06 | x64      |
| Sqlscm.dll                                                   | 2019.150.4312.2 | 79824     | 01-Apr-23 | 13:06 | x86      |
| Sqlscm.dll                                                   | 2019.150.4312.2 | 88000     | 01-Apr-23 | 13:06 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4312.2 | 149456    | 01-Apr-23 | 13:06 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4312.2 | 182160    | 01-Apr-23 | 13:06 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4312.2 | 169920    | 01-Apr-23 | 13:06 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4312.2 | 202704    | 01-Apr-23 | 13:06 | x64      |
| Txdataconvert.dll                                            | 2019.150.4312.2 | 276432    | 01-Apr-23 | 13:06 | x86      |
| Txdataconvert.dll                                            | 2019.150.4312.2 | 317344    | 01-Apr-23 | 13:06 | x64      |
| Xe.dll                                                       | 2019.150.4312.2 | 632720    | 01-Apr-23 | 13:06 | x86      |
| Xe.dll                                                       | 2019.150.4312.2 | 722896    | 01-Apr-23 | 13:06 | x64      |

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
