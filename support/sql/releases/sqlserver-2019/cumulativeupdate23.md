---
title: Cumulative update 23 for SQL Server 2019 (KB5030333)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 23 (KB5030333).
ms.date: 10/12/2023
ms.custom: KB5030333
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB5030333 - Cumulative Update 23 for SQL Server 2019

_Release Date:_ &nbsp; October 12, 2023  
_Version:_ &nbsp; 15.0.4335.1

## Summary

This article describes Cumulative Update package 23 (CU23) for Microsoft SQL Server 2019. This update contains 24 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2019 Cumulative Update 22, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4335.1**, file version: **2019.150.4335.1**
- Analysis Services - Product version: **15.0.35.41**, file version: **2018.150.35.41**

## Known issues in this update

SQL Server 2019 CU14 introduced a [fix to address wrong results in parallel plans returned by the built-in SESSION_CONTEXT](https://support.microsoft.com/help/5008114). However, this fix might create access violation dump files when the SESSION is reset for reuse. To mitigate this issue and avoid incorrect results, you can disable the original fix, and also disable the parallelism for the built-in `SESSION_CONTEXT`. To do this, use the following trace flags:

- 11042 - This trace flag disables the parallelism for the built-in `SESSION_CONTEXT`.

- 9432 - This trace flag disables the fix that was introduced in SQL Server 2019 CU14.

Microsoft is working on a fix for this issue and it will be available in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area | Component | Platform |
|------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|-------------------------------------------|----------|
| <a id=2593704>[2593704](#2593704) </a> | Fixes an issue that you encounter when selecting other non-entity nodes after selecting an entity node in Master Data Services models. | Master Data Services | Master Data Services| Windows|
| <a id=2654352>[2654352](#2654352) </a> | Fixes an issue in which you search for a specific node and then fail to expand the node on the hierarchy page. | Master Data Services | Master Data Services| Windows|
| <a id=2633976>[2633976](#2633976) </a> | Updates the version of the Microsoft ODBC driver to 17.10.5.1. For more information, see [Release Notes for Microsoft ODBC Driver for SQL Server on Windows](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows). | SQL Connectivity | SQL Connectivity| Windows|
| <a id=2633979>[2633979](#2633979) </a> | Updates the version of the Microsoft OLE DB driver to 18.6.7. For more information, see [Release notes for the Microsoft OLE DB Driver for SQL Server](/sql/connect/oledb/release-notes-for-oledb-driver-for-sql-server).| SQL Connectivity | SQL Connectivity| Windows|
| <a id=1992459>[1992459](#1992459) </a> | Fixes an issue in which restoring a transaction log backup to the specific point in time fails with the following error: </br></br>Msg 9003, Level 20, State 9, Line \<LineNumber> </br>The log scan number (xxx:xxx:xxx) passed to log scan in database 'DatabaseName' is not valid. | SQL Server Engine| Backup Restore| All|
| <a id=2584049>[2584049](#2584049) </a> | Enables IO error mode history in retail builds by using trace flag 3139 to allow the investigation of the assertion failure (Location: readEncoded.cpp:2988; Expression: m_pDecodeSplitInput->GetAvailableFreeSize () >= lengthInNext) that may occur while restoring transaction log backups. |SQL Server Engine | Backup Restore| All|
| <a id=2374314>[2374314](#2374314) </a> | Fixes an issue in which an `INSERT` (or any Data Manipulation Language (DML)) statement is blocked if you run the statement before a clustered columnstore index (CCI) online rebuild or drop and then run the statement during the online rebuild or drop if the statement is still in the procedure cache. | SQL Server Engine| Column Stores | All|
| <a id=2690338>[2690338](#2690338) </a> | Before this update, in some rare cases, if `IDENTITY_INSERT` is set to `ON`, the identity value for the target table is set to the highest value in the source table when joining tables, even if the highest value doesn't satisfy the join condition or the predicate. This update improves the current design and fixes this issue. </br></br>**Note**: To apply this update, you need to set the `QUERY_OPTIMIZER_HOTFIXES` database scoped configuration to `ON`. To turn off this update, you can enable trace flag 13193.| SQL Server Engine| DB Management | All|
| <a id=2567537>[2567537](#2567537) </a> | Fixes an issue in which an availability group that has database level health detection enabled triggers needless failover for the following error 1105 when data files reach the limit size or the configured maximization: </br></br>\<DateTime> Error: 1105, Severity: 17, State: 2. </br>\<DateTime> Could not allocate space for object '\<TableName>' in database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full. Create disk space by deleting unneeded files, dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. | SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=2529767>[2529767](#2529767) </a> | Improves Data Definition Language (DDL) performance to create a large number of tables and partitions when the number of databases on a SQL Server instance exceeds 100. | SQL Server Engine| Methods to access stored data | All|
| <a id=2614132>[2614132](#2614132) </a> | Fixes a potential process termination issue that you might encounter when an `adhoc` query that uses the binary large object (BLOB) encounters an error and tries to clean up during the query shutdown. | SQL Server Engine| Query Execution | All|
| <a id=2647396>[2647396](#2647396) </a> | Fixes race conditions in which certain variables aren't initialized correctly when a batch mode sort query is aborted, which causes an access violation and <code>INVALID_POINTER_READ_c0000005_sqlmin.dll!CBpSortLessFunctor_127,0,1,0_<br>::OptLessFunction</code> exception. | SQL Server Engine| Query Optimizer | All|
| <a id=2693198>[2693198](#2693198) </a> | Fixes an access violation exception that you encounter at `sqlmin!CBpXteHashJoin::FSeparateHash` when you try to run a query that involves an `Adaptive Join (CONCAT)` operator in the query plan. | SQL Server Engine| Query Optimizer | All|
| <a id=2590045>[2590045](#2590045) </a> | Fixes an issue in which the dynamic snapshot fails with the error "Arithmetic overflow error converting expression to data type int" in the `partition_id_eval_proc` column when you try to add new subscriptions to merge publications. | SQL Server Engine| Replication | All|
| <a id=2602743>[2602743](#2602743) </a> | Fixes an issue that you encounter in the following scenario: </br></br>- Configure the "Replication: agent custom shutdown" alert to respond to error 20578. </br></br>- Run `sp_publication_validation` with `@shutdown_agent` as `1` to initiate an article validation. </br></br>In this scenario, you notice that the "Replication: agent custom shutdown" alert doesn't respond, which occurs as error 20578 isn't logged in the application log. | SQL Server Engine| Replication | All|
| <a id=2614095>[2614095](#2614095) </a> | Fixes an issue in which the Snapshot Agent incorrectly generates the script of the `XXX_msrepl_ccs` stored procedure if `@sync_method` is `concurrent`, and replication stored procedures are specified under a custom schema. | SQL Server Engine| Replication | All|
| <a id=2646148>[2646148](#2646148) </a> | Fixes inconsistent results that you encounter when you use Read Committed Snapshot Isolation (RCSI) and the full-text index doesn't pick up the updated data in an incremental crawl.| SQL Server Engine| Search| All|
| <a id=2621966>[2621966](#2621966) </a> | Fixes the following error 2570 that you encounter when you run `DBCC CHECKDB` against a database, which is caused by using negative parameters in the `RANDOM` function against a column that uses dynamic data masking (DDM): </br></br>Msg 2570, Level 16, State 3, Line \<LineNumber> </br>Page (\<PageID>), slot \<SlotID> in object ID \<ObjectID>, index ID \<IndexID>, partition ID \<PartitionID>, alloc unit ID \<UnitID> (type "\<Type>"). Column "\<ColumnName>" value is out of range for data type "\<DataType>". Update column to a legal value. | SQL Server Engine| Security Infrastructure | All|
| <a id=2633609>[2633609](#2633609) </a> | An attacker can send a malformed TDS (Tabular Data Stream) packet that causes a login failure, unavailability, or other undefined behavior.| SQL Server Engine| Security Infrastructure | All|
| <a id=2674865>[2674865](#2674865) </a> | Fixes error 207 (Invalid column name '\<ColumnName>') that you encounter when you run a user-defined function (UDF), which references a dropped column that uses data classification.| SQL Server Engine| Security Infrastructure | All|
| <a id=2639915>[2639915](#2639915) </a> | Adds a compressed memory dump feature that helps create a compressed memory stream to replace the conventional memory stream to speed up the dump process and reduce the size of the dump file. For more information, see [Use the Sqldumper.exe tool to generate a dump file in SQL Server](../../tools/use-sqldumper-generate-dump-file.md#parallel-compression-of-memory-dumps). | SQL Server Engine| SQL OS| Windows|
| <a id=2640296>[2640296](#2640296) </a> | Fixes an issue in which SQL Server continues to generate new dump files when the dump file size is larger than 2 gigabytes (GB). | SQL Server Engine| SQL OS| Windows|
| <a id=2651628>[2651628](#2651628) </a> </br><a id=2746708>[2746708](#2746708) </a> | Starting in SQL Server 2019 CU23, Azul Java is no longer available, and the Microsoft Build of OpenJDK 11 is provided instead.| SQL Setup| Deployment Platform | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU23 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5030333)

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

You can verify the download by computing the hash of the *SQLServer2019-KB5030333-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB5030333-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB5030333-x64.exe| C79367EF48F653A31F98BB8A0CACF382B1C59D290F48E2A6F19D0F6171B31421 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                        File   name                        |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.35.41  | 292760    | 21-Sep-23 | 18:04 | x64      |
| Mashupcompression.dll                                     | 2.87.142.0      | 140672    | 21-Sep-23 | 18:04 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.35.41      | 758168    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 175560    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 199624    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 202184    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 198600    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 214936    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197576    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 193480    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 252360    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 174024    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.35.41      | 197064    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.35.41      | 1098648   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.35.41      | 567240    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 54728     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59336     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 59840     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58776     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 61896     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58312     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 67528     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 53656     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.35.41      | 58264     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 18888     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.35.41      | 17864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516     | 660872    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.dll                                 | 2.87.142.0      | 191352    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.87.142.0      | 30592     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.87.142.0      | 76672     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.87.142.0      | 103808    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37760     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 32120     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41856     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 45952     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 37752     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.87.142.0      | 41864     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516     | 1454464   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516     | 181120    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25        | 929592    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34624     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34600     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 35128     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 46888     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 33064     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 34616     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25        | 37672     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.87.142.0      | 5283720   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.container.exe                            | 2.87.142.0      | 23432     | 21-Sep-23 | 18:04 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.87.142.0      | 22912     | 21-Sep-23 | 18:04 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.87.142.0      | 22912     | 21-Sep-23 | 18:04 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.87.142.0      | 149384    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.87.142.0      | 78720     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14712     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15240     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15232     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15224     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 15744     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14720     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.87.142.0      | 14728     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.87.142.0      | 199560    | 21-Sep-23 | 18:04 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.87.142.0      | 64888     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13176     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13184     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.87.142.0      | 13192     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261   | 2371808   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.shims.dll                                | 2.87.142.0      | 27528     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0         | 140168    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.dll                                | 2.87.142.0      | 14835080  | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 566136    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 676728    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 672640    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 652152    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 701312    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 660352    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 639872    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 881536    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 553848    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.87.142.0      | 648064    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0        | 1437560   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0        | 778632    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.1.61.21      | 1109368   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0        | 126344    | 21-Sep-23 | 18:04 | x86      |
| Msmdctr.dll                                               | 2018.150.35.41  | 38296     | 21-Sep-23 | 18:04 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 66299800  | 21-Sep-23 | 18:04 | x64      |
| Msmdlocal.dll                                             | 2018.150.35.41  | 47788440  | 21-Sep-23 | 18:04 | x86      |
| Msmdpump.dll                                              | 2018.150.35.41  | 10189768  | 21-Sep-23 | 18:04 | x64      |
| Msmdredir.dll                                             | 2018.150.35.41  | 7957912   | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 17304     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 18328     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 21-Sep-23 | 18:04 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.35.41      | 16792     | 21-Sep-23 | 18:04 | x86      |
| Msmdsrv.exe                                               | 2018.150.35.41  | 65837512  | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 833432    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1628056   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1453976   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1642904   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1608600   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1001368   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 992664    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1536920   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1521560   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 810904    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrv.rll                                               | 2018.150.35.41  | 1596312   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 832408    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1624472   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1450904   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1637784   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1604504   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 998808    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 991128    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1532824   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1517976   | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 809880    | 21-Sep-23 | 18:04 | x64      |
| Msmdsrvi.rll                                              | 2018.150.35.41  | 1591704   | 21-Sep-23 | 18:04 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 10187160  | 21-Sep-23 | 18:04 | x64      |
| Msmgdsrv.dll                                              | 2018.150.35.41  | 8281032   | 21-Sep-23 | 18:04 | x86      |
| Msolap.dll                                                | 2018.150.35.41  | 11017160  | 21-Sep-23 | 18:04 | x64      |
| Msolap.dll                                                | 2018.150.35.41  | 8609176   | 21-Sep-23 | 18:04 | x86      |
| Msolui.dll                                                | 2018.150.35.41  | 306584    | 21-Sep-23 | 18:04 | x64      |
| Msolui.dll                                                | 2018.150.35.41  | 286104    | 21-Sep-23 | 18:04 | x86      |
| Powerbiextensions.dll                                     | 2.87.142.0      | 8853888   | 21-Sep-23 | 18:04 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000 | 728448    | 21-Sep-23 | 18:04 | x64      |
| Sqlboot.dll                                               | 2019.150.4335.1 | 215080    | 21-Sep-23 | 18:04 | x64      |
| Sqlceip.exe                                               | 15.0.4335.1     | 297016    | 21-Sep-23 | 18:04 | x86      |
| Sqldumper.exe                                             | 2019.150.4335.1 | 313280    | 21-Sep-23 | 18:04 | x86      |
| Sqldumper.exe                                             | 2019.150.4335.1 | 366632    | 21-Sep-23 | 18:04 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516     | 117640    | 21-Sep-23 | 18:04 | x86      |
| Tmapi.dll                                                 | 2018.150.35.41  | 6178200   | 21-Sep-23 | 18:04 | x64      |
| Tmcachemgr.dll                                            | 2018.150.35.41  | 4917704   | 21-Sep-23 | 18:04 | x64      |
| Tmpersistence.dll                                         | 2018.150.35.41  | 1184664   | 21-Sep-23 | 18:04 | x64      |
| Tmtransactions.dll                                        | 2018.150.35.41  | 6806936   | 21-Sep-23 | 18:04 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 26026440  | 21-Sep-23 | 18:04 | x64      |
| Xmsrv.dll                                                 | 2018.150.35.41  | 35460504  | 21-Sep-23 | 18:04 | x86      |

SQL Server 2019 Database Services Common Core

|              File   name             |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                      | 2019.150.4335.1 | 165840    | 21-Sep-23 | 18:04 | x86      |
| Batchparser.dll                      | 2019.150.4335.1 | 182208    | 21-Sep-23 | 18:04 | x64      |
| Instapi150.dll                       | 2019.150.4335.1 | 75816     | 21-Sep-23 | 18:04 | x86      |
| Instapi150.dll                       | 2019.150.4335.1 | 88104     | 21-Sep-23 | 18:04 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4335.1 | 88120     | 21-Sep-23 | 18:04 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll | 2019.150.4335.1 | 104400    | 21-Sep-23 | 18:04 | x64      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4335.1     | 550864    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.sqlserver.rmo.dll          | 15.0.4335.1     | 550864    | 21-Sep-23 | 18:04 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 27032     | 21-Sep-23 | 18:04 | x86      |
| Msasxpress.dll                       | 2018.150.35.41  | 32152     | 21-Sep-23 | 18:04 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4335.1 | 92200     | 21-Sep-23 | 18:04 | x64      |
| Pbsvcacctsync.dll                    | 2019.150.4335.1 | 75816     | 21-Sep-23 | 18:04 | x86      |
| Sqldumper.exe                        | 2019.150.4335.1 | 313280    | 21-Sep-23 | 18:04 | x86      |
| Sqldumper.exe                        | 2019.150.4335.1 | 366632    | 21-Sep-23 | 18:04 | x64      |
| Sqlftacct.dll                        | 2019.150.4335.1 | 59448     | 21-Sep-23 | 18:04 | x86      |
| Sqlftacct.dll                        | 2019.150.4335.1 | 79824     | 21-Sep-23 | 18:04 | x64      |
| Sqlmanager.dll                       | 2019.150.4335.1 | 743464    | 21-Sep-23 | 18:04 | x86      |
| Sqlmanager.dll                       | 2019.150.4335.1 | 878528    | 21-Sep-23 | 18:04 | x64      |
| Sqlmgmprovider.dll                   | 2019.150.4335.1 | 378832    | 21-Sep-23 | 18:04 | x86      |
| Sqlmgmprovider.dll                   | 2019.150.4335.1 | 432064    | 21-Sep-23 | 18:04 | x64      |
| Sqlsvcsync.dll                       | 2019.150.4335.1 | 276408    | 21-Sep-23 | 18:04 | x86      |
| Sqlsvcsync.dll                       | 2019.150.4335.1 | 358456    | 21-Sep-23 | 18:04 | x64      |
| Svrenumapi150.dll                    | 2019.150.4335.1 | 1161256   | 21-Sep-23 | 18:04 | x64      |
| Svrenumapi150.dll                    | 2019.150.4335.1 | 911400    | 21-Sep-23 | 18:04 | x86      |

SQL Server 2019 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 15.0.4335.1  | 600120    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.ssdqs.core.dll  | 15.0.4335.1  | 600016    | 21-Sep-23 | 18:04 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4335.1  | 1857592   | 21-Sep-23 | 18:04 | x86      |
| Microsoft.ssdqs.infra.dll | 15.0.4335.1  | 1857592   | 21-Sep-23 | 18:05 | x86      |

SQL Server 2019 sql_dreplay_client

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe     | 2019.150.4335.1 | 137256    | 21-Sep-23 | 18:04 | x86      |
| Dreplaycommon.dll     | 2019.150.4335.1 | 667584    | 21-Sep-23 | 18:04 | x86      |
| Dreplayutil.dll       | 2019.150.4335.1 | 305192    | 21-Sep-23 | 18:04 | x86      |
| Instapi150.dll        | 2019.150.4335.1 | 88104     | 21-Sep-23 | 18:04 | x64      |
| Sqlresourceloader.dll | 2019.150.4335.1 | 38952     | 21-Sep-23 | 18:04 | x86      |

SQL Server 2019 sql_dreplay_controller

|      File   name      |   File version  | File size |    Date   |  Time | Platform |
|:---------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll     | 2019.150.4335.1 | 667584    | 21-Sep-23 | 18:04 | x86      |
| Dreplaycontroller.exe | 2019.150.4335.1 | 366648    | 21-Sep-23 | 18:04 | x86      |
| Instapi150.dll        | 2019.150.4335.1 | 88104     | 21-Sep-23 | 18:04 | x64      |
| Sqlresourceloader.dll | 2019.150.4335.1 | 38952     | 21-Sep-23 | 18:04 | x86      |

SQL Server 2019 Database Services Core Instance

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll                 | 2019.150.4335.1 | 4658216   | 21-Sep-23 | 19:03 | x64      |
| Aetm-enclave.dll                           | 2019.150.4335.1 | 4612536   | 21-Sep-23 | 19:03 | x64      |
| Aetm-sgx-enclave-simulator.dll             | 2019.150.4335.1 | 4932008   | 21-Sep-23 | 19:03 | x64      |
| Aetm-sgx-enclave.dll                       | 2019.150.4335.1 | 4873560   | 21-Sep-23 | 19:03 | x64      |
| Azureattest.dll                            | 10.0.18965.1000 | 255056    | 21-Sep-23 | 18:04 | x64      |
| Azureattestmanager.dll                     | 10.0.18965.1000 | 97528     | 21-Sep-23 | 18:04 | x64      |
| Batchparser.dll                            | 2019.150.4335.1 | 182208    | 21-Sep-23 | 19:03 | x64      |
| C1.dll                                     | 19.16.27034.0   | 2438520   | 21-Sep-23 | 19:03 | x64      |
| C2.dll                                     | 19.16.27034.0   | 7239032   | 21-Sep-23 | 19:03 | x64      |
| Cl.exe                                     | 19.16.27034.0   | 424360    | 21-Sep-23 | 19:03 | x64      |
| Clui.dll                                   | 19.16.27034.0   | 541048    | 21-Sep-23 | 19:03 | x64      |
| Datacollectorcontroller.dll                | 2019.150.4335.1 | 280616    | 21-Sep-23 | 19:03 | x64      |
| Dcexec.exe                                 | 2019.150.4335.1 | 88016     | 21-Sep-23 | 19:03 | x64      |
| Fssres.dll                                 | 2019.150.4335.1 | 96312     | 21-Sep-23 | 19:03 | x64      |
| Hadrres.dll                                | 2019.150.4335.1 | 206888    | 21-Sep-23 | 19:03 | x64      |
| Hkcompile.dll                              | 2019.150.4335.1 | 1292240   | 21-Sep-23 | 19:03 | x64      |
| Hkengine.dll                               | 2019.150.4335.1 | 5793744   | 21-Sep-23 | 19:03 | x64      |
| Hkruntime.dll                              | 2019.150.4335.1 | 182224    | 21-Sep-23 | 19:03 | x64      |
| Hktempdb.dll                               | 2019.150.4335.1 | 63528     | 21-Sep-23 | 19:03 | x64      |
| Link.exe                                   | 14.16.27034.0   | 1707936   | 21-Sep-23 | 19:03 | x64      |
| Microsoft.sqlautoadmin.autobackupagent.dll | 15.0.4335.1     | 235576    | 21-Sep-23 | 19:03 | x86      |
| Microsoft.sqlserver.types.dll              | 2019.150.4335.1 | 391104    | 21-Sep-23 | 19:03 | x86      |
| Microsoft.sqlserver.xevent.linq.dll        | 2019.150.4335.1 | 325688    | 21-Sep-23 | 19:03 | x64      |
| Microsoft.sqlserver.xevent.targets.dll     | 2019.150.4335.1 | 92200     | 21-Sep-23 | 19:03 | x64      |
| Msobj140.dll                               | 14.16.27034.0   | 134008    | 21-Sep-23 | 19:03 | x64      |
| Mspdb140.dll                               | 14.16.27034.0   | 632184    | 21-Sep-23 | 19:03 | x64      |
| Mspdbcore.dll                              | 14.16.27034.0   | 632184    | 21-Sep-23 | 19:03 | x64      |
| Msvcp140.dll                               | 14.16.27034.0   | 628200    | 21-Sep-23 | 19:03 | x64      |
| Qds.dll                                    | 2019.150.4335.1 | 1189928   | 21-Sep-23 | 19:03 | x64      |
| Rsfxft.dll                                 | 2019.150.4335.1 | 51256     | 21-Sep-23 | 19:03 | x64      |
| Secforwarder.dll                           | 2019.150.4335.1 | 79808     | 21-Sep-23 | 19:03 | x64      |
| Sqagtres.dll                               | 2019.150.4335.1 | 88016     | 21-Sep-23 | 19:03 | x64      |
| Sqlaamss.dll                               | 2019.150.4335.1 | 108584    | 21-Sep-23 | 19:03 | x64      |
| Sqlaccess.dll                              | 2019.150.4335.1 | 493608    | 21-Sep-23 | 19:03 | x64      |
| Sqlagent.exe                               | 2019.150.4335.1 | 731192    | 21-Sep-23 | 19:03 | x64      |
| Sqlagentctr150.dll                         | 2019.150.4335.1 | 71632     | 21-Sep-23 | 19:03 | x86      |
| Sqlagentctr150.dll                         | 2019.150.4335.1 | 79808     | 21-Sep-23 | 19:03 | x64      |
| Sqlboot.dll                                | 2019.150.4335.1 | 215080    | 21-Sep-23 | 19:03 | x64      |
| Sqlceip.exe                                | 15.0.4335.1     | 297016    | 21-Sep-23 | 19:03 | x86      |
| Sqlcmdss.dll                               | 2019.150.4335.1 | 88016     | 21-Sep-23 | 19:03 | x64      |
| Sqlctr150.dll                              | 2019.150.4335.1 | 116776    | 21-Sep-23 | 19:03 | x86      |
| Sqlctr150.dll                              | 2019.150.4335.1 | 145344    | 21-Sep-23 | 19:03 | x64      |
| Sqldk.dll                                  | 2019.150.4335.1 | 3180584   | 21-Sep-23 | 19:03 | x64      |
| Sqldtsss.dll                               | 2019.150.4335.1 | 108600    | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 1595448   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3508280   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3700792   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4171816   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4286504   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3418168   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3585984   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4163624   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4016064   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4069416   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 2226232   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 2172984   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3876920   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3549224   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4020280   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3827752   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3823672   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3618856   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3508264   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 1538104   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 3913664   | 21-Sep-23 | 19:03 | x64      |
| Sqlevn70.rll                               | 2019.150.4335.1 | 4036664   | 21-Sep-23 | 19:03 | x64      |
| Sqllang.dll                                | 2019.150.4335.1 | 40032192  | 21-Sep-23 | 19:03 | x64      |
| Sqlmin.dll                                 | 2019.150.4335.1 | 40634408  | 21-Sep-23 | 19:03 | x64      |
| Sqlolapss.dll                              | 2019.150.4335.1 | 108480    | 21-Sep-23 | 19:03 | x64      |
| Sqlos.dll                                  | 2019.150.4335.1 | 42944     | 21-Sep-23 | 19:03 | x64      |
| Sqlpowershellss.dll                        | 2019.150.4335.1 | 83920     | 21-Sep-23 | 19:03 | x64      |
| Sqlrepss.dll                               | 2019.150.4335.1 | 88104     | 21-Sep-23 | 19:03 | x64      |
| Sqlresourceloader.dll                      | 2019.150.4335.1 | 51136     | 21-Sep-23 | 19:03 | x64      |
| Sqlscm.dll                                 | 2019.150.4335.1 | 88016     | 21-Sep-23 | 19:03 | x64      |
| Sqlscriptdowngrade.dll                     | 2019.150.4335.1 | 38848     | 21-Sep-23 | 19:03 | x64      |
| Sqlscriptupgrade.dll                       | 2019.150.4335.1 | 5806136   | 21-Sep-23 | 19:03 | x64      |
| Sqlserverspatial150.dll                    | 2019.150.4335.1 | 673744    | 21-Sep-23 | 19:03 | x64      |
| Sqlservr.exe                               | 2019.150.4335.1 | 628776    | 21-Sep-23 | 19:03 | x64      |
| Sqlsvc.dll                                 | 2019.150.4335.1 | 182328    | 21-Sep-23 | 19:03 | x64      |
| Sqltses.dll                                | 2019.150.4335.1 | 9119680   | 21-Sep-23 | 19:03 | x64      |
| Sqsrvres.dll                               | 2019.150.4335.1 | 280528    | 21-Sep-23 | 19:03 | x64      |
| Stretchcodegen.exe                         | 15.0.4335.1     | 59336     | 21-Sep-23 | 19:03 | x86      |
| Svl.dll                                    | 2019.150.4335.1 | 161728    | 21-Sep-23 | 19:03 | x64      |
| Vcruntime140.dll                           | 14.16.27034.0   | 85992     | 21-Sep-23 | 19:03 | x64      |
| Xe.dll                                     | 2019.150.4335.1 | 722880    | 21-Sep-23 | 19:03 | x64      |
| Xpadsi.exe                                 | 2019.150.4335.1 | 116776    | 21-Sep-23 | 19:03 | x64      |
| Xplog70.dll                                | 2019.150.4335.1 | 92216     | 21-Sep-23 | 19:03 | x64      |
| Xpqueue.dll                                | 2019.150.4335.1 | 92096     | 21-Sep-23 | 19:03 | x64      |
| Xprepl.dll                                 | 2019.150.4335.1 | 120872    | 21-Sep-23 | 19:03 | x64      |
| Xpstar.dll                                 | 2019.150.4335.1 | 473128    | 21-Sep-23 | 19:03 | x64      |

SQL Server 2019 Database Services Core Shared

|                           File name                          |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Batchparser.dll                                              | 2019.150.4335.1 | 165840    | 21-Sep-2023 | 18:04 | x86      |
| Batchparser.dll                                              | 2019.150.4335.1 | 182208    | 21-Sep-2023 | 18:04 | x64      |
| Commanddest.dll                                              | 2019.150.4335.1 | 264232    | 21-Sep-2023 | 18:04 | x64      |
| Datacollectortasks.dll                                       | 2019.150.4335.1 | 227264    | 21-Sep-2023 | 18:04 | x64      |
| Distrib.exe                                                  | 2019.150.4335.1 | 243664    | 21-Sep-2023 | 18:04 | x64      |
| Dteparse.dll                                                 | 2019.150.4335.1 | 124864    | 21-Sep-2023 | 18:04 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4335.1 | 133072    | 21-Sep-2023 | 18:04 | x64      |
| Dtepkg.dll                                                   | 2019.150.4335.1 | 149456    | 21-Sep-2023 | 18:04 | x64      |
| Dtexec.exe                                                   | 2019.150.4335.1 | 73664     | 21-Sep-2023 | 18:04 | x64      |
| Dts.dll                                                      | 2019.150.4335.1 | 3143720   | 21-Sep-2023 | 18:04 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4335.1 | 501800    | 21-Sep-2023 | 18:04 | x64      |
| Dtsconn.dll                                                  | 2019.150.4335.1 | 522280    | 21-Sep-2023 | 18:04 | x64      |
| Dtshost.exe                                                  | 2019.150.4335.1 | 107576    | 21-Sep-2023 | 18:04 | x64      |
| Dtsmsg150.dll                                                | 2019.150.4335.1 | 567232    | 21-Sep-2023 | 18:04 | x64      |
| Dtspipeline.dll                                              | 2019.150.4335.1 | 1329088   | 21-Sep-2023 | 18:04 | x64      |
| Dtswizard.exe                                                | 15.0.4335.1     | 886720    | 21-Sep-2023 | 18:04 | x64      |
| Dtuparse.dll                                                 | 2019.150.4335.1 | 100288    | 21-Sep-2023 | 18:04 | x64      |
| Dtutil.exe                                                   | 2019.150.4335.1 | 150976    | 21-Sep-2023 | 18:04 | x64      |
| Exceldest.dll                                                | 2019.150.4335.1 | 280616    | 21-Sep-2023 | 18:04 | x64      |
| Excelsrc.dll                                                 | 2019.150.4335.1 | 309304    | 21-Sep-2023 | 18:04 | x64      |
| Execpackagetask.dll                                          | 2019.150.4335.1 | 186320    | 21-Sep-2023 | 18:04 | x64      |
| Flatfiledest.dll                                             | 2019.150.4335.1 | 411688    | 21-Sep-2023 | 18:04 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4335.1 | 428072    | 21-Sep-2023 | 18:04 | x64      |
| Logread.exe                                                  | 2019.150.4335.1 | 722984    | 21-Sep-2023 | 18:04 | x64      |
| Mergetxt.dll                                                 | 2019.150.4335.1 | 75712     | 21-Sep-2023 | 18:04 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll     | 15.0.4335.1     | 59448     | 21-Sep-2023 | 18:04 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4335.1     | 42944     | 21-Sep-2023 | 18:04 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                 | 15.0.4335.1     | 391208    | 21-Sep-2023 | 18:04 | x86      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4335.1 | 1697832   | 21-Sep-2023 | 18:04 | x64      |
| Microsoft.sqlserver.replication.dll                          | 2019.150.4335.1 | 1640504   | 21-Sep-2023 | 18:04 | x86      |
| Microsoft.sqlserver.rmo.dll                                  | 15.0.4335.1     | 550864    | 21-Sep-2023 | 18:04 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4335.1 | 112680    | 21-Sep-2023 | 18:04 | x64      |
| Msgprox.dll                                                  | 2019.150.4335.1 | 301008    | 21-Sep-2023 | 18:04 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 2729960   | 21-Sep-2023 | 18:04 | x64      |
| Msoledbsql.dll                                               | 2018.186.7.0    | 153560    | 21-Sep-2023 | 18:04 | x64      |
| Msxmlsql.dll                                                 | 2019.150.4335.1 | 1497024   | 21-Sep-2023 | 18:04 | x64      |
| Oledbdest.dll                                                | 2019.150.4335.1 | 280616    | 21-Sep-2023 | 18:04 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4335.1 | 313384    | 21-Sep-2023 | 18:04 | x64      |
| Osql.exe                                                     | 2019.150.4335.1 | 92200     | 21-Sep-2023 | 18:04 | x64      |
| Qrdrsvc.exe                                                  | 2019.150.4335.1 | 501712    | 21-Sep-2023 | 18:04 | x64      |
| Rawdest.dll                                                  | 2019.150.4335.1 | 227264    | 21-Sep-2023 | 18:04 | x64      |
| Rawsource.dll                                                | 2019.150.4335.1 | 211000    | 21-Sep-2023 | 18:04 | x64      |
| Rdistcom.dll                                                 | 2019.150.4335.1 | 915408    | 21-Sep-2023 | 18:04 | x64      |
| Recordsetdest.dll                                            | 2019.150.4335.1 | 202688    | 21-Sep-2023 | 18:04 | x64      |
| Repldp.dll                                                   | 2019.150.4335.1 | 313280    | 21-Sep-2023 | 18:04 | x64      |
| Replerrx.dll                                                 | 2019.150.4335.1 | 182224    | 21-Sep-2023 | 18:04 | x64      |
| Replisapi.dll                                                | 2019.150.4335.1 | 395304    | 21-Sep-2023 | 18:04 | x64      |
| Replmerg.exe                                                 | 2019.150.4335.1 | 563152    | 21-Sep-2023 | 18:04 | x64      |
| Replprov.dll                                                 | 2019.150.4335.1 | 862144    | 21-Sep-2023 | 18:04 | x64      |
| Replrec.dll                                                  | 2019.150.4335.1 | 1034280   | 21-Sep-2023 | 18:04 | x64      |
| Replsub.dll                                                  | 2019.150.4335.1 | 473024    | 21-Sep-2023 | 18:04 | x64      |
| Replsync.dll                                                 | 2019.150.4335.1 | 165840    | 21-Sep-2023 | 18:04 | x64      |
| Spresolv.dll                                                 | 2019.150.4335.1 | 276432    | 21-Sep-2023 | 18:04 | x64      |
| Sqlcmd.exe                                                   | 2019.150.4335.1 | 264248    | 21-Sep-2023 | 18:04 | x64      |
| Sqldiag.exe                                                  | 2019.150.4335.1 | 1140776   | 21-Sep-2023 | 18:04 | x64      |
| Sqldistx.dll                                                 | 2019.150.4335.1 | 251856    | 21-Sep-2023 | 18:04 | x64      |
| Sqllogship.exe                                               | 15.0.4335.1     | 104488    | 21-Sep-2023 | 18:04 | x64      |
| Sqlmergx.dll                                                 | 2019.150.4335.1 | 399296    | 21-Sep-2023 | 18:04 | x64      |
| Sqlresourceloader.dll                                        | 2019.150.4335.1 | 38952     | 21-Sep-2023 | 18:04 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4335.1 | 51136     | 21-Sep-2023 | 18:04 | x64      |
| Sqlscm.dll                                                   | 2019.150.4335.1 | 79928     | 21-Sep-2023 | 18:04 | x86      |
| Sqlscm.dll                                                   | 2019.150.4335.1 | 88016     | 21-Sep-2023 | 18:04 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4335.1 | 149544    | 21-Sep-2023 | 18:04 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4335.1 | 182328    | 21-Sep-2023 | 18:04 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4335.1 | 202808    | 21-Sep-2023 | 18:04 | x64      |
| Ssradd.dll                                                   | 2019.150.4335.1 | 84024     | 21-Sep-2023 | 18:04 | x64      |
| Ssravg.dll                                                   | 2019.150.4335.1 | 83904     | 21-Sep-2023 | 18:04 | x64      |
| Ssrdown.dll                                                  | 2019.150.4335.1 | 75816     | 21-Sep-2023 | 18:04 | x64      |
| Ssrmax.dll                                                   | 2019.150.4335.1 | 83920     | 21-Sep-2023 | 18:04 | x64      |
| Ssrmin.dll                                                   | 2019.150.4335.1 | 83912     | 21-Sep-2023 | 18:04 | x64      |
| Ssrpub.dll                                                   | 2019.150.4335.1 | 79808     | 21-Sep-2023 | 18:04 | x64      |
| Ssrup.dll                                                    | 2019.150.4335.1 | 75728     | 21-Sep-2023 | 18:04 | x64      |
| Txagg.dll                                                    | 2019.150.4335.1 | 391120    | 21-Sep-2023 | 18:04 | x64      |
| Txbdd.dll                                                    | 2019.150.4335.1 | 190520    | 21-Sep-2023 | 18:04 | x64      |
| Txdatacollector.dll                                          | 2019.150.4335.1 | 473128    | 21-Sep-2023 | 18:04 | x64      |
| Txdataconvert.dll                                            | 2019.150.4335.1 | 317480    | 21-Sep-2023 | 18:04 | x64      |
| Txderived.dll                                                | 2019.150.4335.1 | 640968    | 21-Sep-2023 | 18:04 | x64      |
| Txlookup.dll                                                 | 2019.150.4335.1 | 542776    | 21-Sep-2023 | 18:04 | x64      |
| Txmerge.dll                                                  | 2019.150.4335.1 | 247848    | 21-Sep-2023 | 18:04 | x64      |
| Txmergejoin.dll                                              | 2019.150.4335.1 | 309304    | 21-Sep-2023 | 18:04 | x64      |
| Txmulticast.dll                                              | 2019.150.4335.1 | 145360    | 21-Sep-2023 | 18:04 | x64      |
| Txrowcount.dll                                               | 2019.150.4335.1 | 141368    | 21-Sep-2023 | 18:04 | x64      |
| Txsort.dll                                                   | 2019.150.4335.1 | 288704    | 21-Sep-2023 | 18:04 | x64      |
| Txsplit.dll                                                  | 2019.150.4335.1 | 624592    | 21-Sep-2023 | 18:04 | x64      |
| Txunionall.dll                                               | 2019.150.4335.1 | 206784    | 21-Sep-2023 | 18:04 | x64      |
| Xe.dll                                                       | 2019.150.4335.1 | 722880    | 21-Sep-2023 | 18:04 | x64      |
| Xmlsub.dll                                                   | 2019.150.4335.1 | 296912    | 21-Sep-2023 | 18:04 | x64      |

SQL Server 2019 sql_extensibility

|     File   name    |   File version  | File size |    Date   |  Time | Platform |
|:------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4335.1 | 96192     | 21-Sep-23 | 18:04 | x64      |
| Exthost.exe        | 2019.150.4335.1 | 239568    | 21-Sep-23 | 18:04 | x64      |
| Launchpad.exe      | 2019.150.4335.1 | 1230888   | 21-Sep-23 | 18:05 | x64      |
| Sqlsatellite.dll   | 2019.150.4335.1 | 1026000   | 21-Sep-23 | 18:05 | x64      |

SQL Server 2019 Full-Text Engine

|   File   name  |   File version  | File size |    Date   |  Time | Platform |
|:--------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll         | 2019.150.4335.1 | 686016    | 21-Sep-23 | 18:04 | x64      |
| Fdhost.exe     | 2019.150.4335.1 | 128960    | 21-Sep-23 | 18:04 | x64      |
| Fdlauncher.exe | 2019.150.4335.1 | 79824     | 21-Sep-23 | 18:04 | x64      |
| Sqlft150ph.dll | 2019.150.4335.1 | 92096     | 21-Sep-23 | 18:04 | x64      |

SQL Server 2019 sql_inst_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll  | 15.0.4335.1  | 30776     | 21-Sep-23 | 18:04 | x86      |

SQL Server 2019 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                               | 2019.150.4335.1 | 227280    | 21-Sep-23 | 18:05 | x86      |
| Commanddest.dll                                               | 2019.150.4335.1 | 264232    | 21-Sep-23 | 18:05 | x64      |
| Dteparse.dll                                                  | 2019.150.4335.1 | 112696    | 21-Sep-23 | 18:05 | x86      |
| Dteparse.dll                                                  | 2019.150.4335.1 | 124864    | 21-Sep-23 | 18:05 | x64      |
| Dteparsemgd.dll                                               | 2019.150.4335.1 | 116776    | 21-Sep-23 | 18:05 | x86      |
| Dteparsemgd.dll                                               | 2019.150.4335.1 | 133072    | 21-Sep-23 | 18:05 | x64      |
| Dtepkg.dll                                                    | 2019.150.4335.1 | 133176    | 21-Sep-23 | 18:05 | x86      |
| Dtepkg.dll                                                    | 2019.150.4335.1 | 149456    | 21-Sep-23 | 18:05 | x64      |
| Dtexec.exe                                                    | 2019.150.4335.1 | 65064     | 21-Sep-23 | 18:05 | x86      |
| Dtexec.exe                                                    | 2019.150.4335.1 | 73664     | 21-Sep-23 | 18:05 | x64      |
| Dts.dll                                                       | 2019.150.4335.1 | 2762792   | 21-Sep-23 | 18:05 | x86      |
| Dts.dll                                                       | 2019.150.4335.1 | 3143720   | 21-Sep-23 | 18:05 | x64      |
| Dtscomexpreval.dll                                            | 2019.150.4335.1 | 444456    | 21-Sep-23 | 18:05 | x86      |
| Dtscomexpreval.dll                                            | 2019.150.4335.1 | 501800    | 21-Sep-23 | 18:05 | x64      |
| Dtsconn.dll                                                   | 2019.150.4335.1 | 432184    | 21-Sep-23 | 18:05 | x86      |
| Dtsconn.dll                                                   | 2019.150.4335.1 | 522280    | 21-Sep-23 | 18:05 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4335.1 | 113192    | 21-Sep-23 | 18:05 | x64      |
| Dtsdebughost.exe                                              | 2019.150.4335.1 | 94656     | 21-Sep-23 | 18:05 | x86      |
| Dtshost.exe                                                   | 2019.150.4335.1 | 107576    | 21-Sep-23 | 18:05 | x64      |
| Dtshost.exe                                                   | 2019.150.4335.1 | 89656     | 21-Sep-23 | 18:05 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4335.1 | 554960    | 21-Sep-23 | 18:05 | x86      |
| Dtsmsg150.dll                                                 | 2019.150.4335.1 | 567232    | 21-Sep-23 | 18:05 | x64      |
| Dtspipeline.dll                                               | 2019.150.4335.1 | 1120192   | 21-Sep-23 | 18:05 | x86      |
| Dtspipeline.dll                                               | 2019.150.4335.1 | 1329088   | 21-Sep-23 | 18:05 | x64      |
| Dtswizard.exe                                                 | 15.0.4335.1     | 886720    | 21-Sep-23 | 18:05 | x64      |
| Dtswizard.exe                                                 | 15.0.4335.1     | 890832    | 21-Sep-23 | 18:05 | x86      |
| Dtuparse.dll                                                  | 2019.150.4335.1 | 100288    | 21-Sep-23 | 18:05 | x64      |
| Dtuparse.dll                                                  | 2019.150.4335.1 | 88104     | 21-Sep-23 | 18:05 | x86      |
| Dtutil.exe                                                    | 2019.150.4335.1 | 130616    | 21-Sep-23 | 18:05 | x86      |
| Dtutil.exe                                                    | 2019.150.4335.1 | 150976    | 21-Sep-23 | 18:05 | x64      |
| Exceldest.dll                                                 | 2019.150.4335.1 | 235472    | 21-Sep-23 | 18:05 | x86      |
| Exceldest.dll                                                 | 2019.150.4335.1 | 280616    | 21-Sep-23 | 18:05 | x64      |
| Excelsrc.dll                                                  | 2019.150.4335.1 | 260048    | 21-Sep-23 | 18:05 | x86      |
| Excelsrc.dll                                                  | 2019.150.4335.1 | 309304    | 21-Sep-23 | 18:05 | x64      |
| Execpackagetask.dll                                           | 2019.150.4335.1 | 149560    | 21-Sep-23 | 18:05 | x86      |
| Execpackagetask.dll                                           | 2019.150.4335.1 | 186320    | 21-Sep-23 | 18:05 | x64      |
| Flatfiledest.dll                                              | 2019.150.4335.1 | 358344    | 21-Sep-23 | 18:05 | x86      |
| Flatfiledest.dll                                              | 2019.150.4335.1 | 411688    | 21-Sep-23 | 18:05 | x64      |
| Flatfilesrc.dll                                               | 2019.150.4335.1 | 370728    | 21-Sep-23 | 18:05 | x86      |
| Flatfilesrc.dll                                               | 2019.150.4335.1 | 428072    | 21-Sep-23 | 18:05 | x64      |
| Isdbupgradewizard.exe                                         | 15.0.4335.1     | 120768    | 21-Sep-23 | 18:05 | x86      |
| Isdbupgradewizard.exe                                         | 15.0.4335.1     | 120888    | 21-Sep-23 | 18:05 | x86      |
| Isserverexec.exe                                              | 15.0.4335.1     | 145464    | 21-Sep-23 | 18:05 | x64      |
| Isserverexec.exe                                              | 15.0.4335.1     | 149440    | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 15.0.4335.1     | 116776    | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4335.1     | 59432     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 15.0.4335.1     | 59448     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 15.0.4335.1     | 509888    | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4335.1     | 42944     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll  | 15.0.4335.1     | 43048     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 15.0.4335.1     | 391208    | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4335.1     | 59432     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll    | 15.0.4335.1     | 59448     | 21-Sep-23 | 18:05 | x86      |
| Microsoft.sqlserver.scripttask.dll                            | 15.0.4335.1     | 141352    | 21-Sep-23 | 18:05 | x86      |
| Msdtssrvr.exe                                                 | 15.0.4335.1     | 219072    | 21-Sep-23 | 18:05 | x64      |
| Msdtssrvrutil.dll                                             | 2019.150.4335.1 | 100408    | 21-Sep-23 | 18:05 | x86      |
| Msdtssrvrutil.dll                                             | 2019.150.4335.1 | 112680    | 21-Sep-23 | 18:05 | x64      |
| Msmdpp.dll                                                    | 2018.150.35.41  | 10065304  | 21-Sep-23 | 18:05 | x64      |
| Odbcdest.dll                                                  | 2019.150.4335.1 | 321592    | 21-Sep-23 | 18:05 | x86      |
| Odbcdest.dll                                                  | 2019.150.4335.1 | 370744    | 21-Sep-23 | 18:05 | x64      |
| Odbcsrc.dll                                                   | 2019.150.4335.1 | 329784    | 21-Sep-23 | 18:05 | x86      |
| Odbcsrc.dll                                                   | 2019.150.4335.1 | 383016    | 21-Sep-23 | 18:05 | x64      |
| Oledbdest.dll                                                 | 2019.150.4335.1 | 239656    | 21-Sep-23 | 18:05 | x86      |
| Oledbdest.dll                                                 | 2019.150.4335.1 | 280616    | 21-Sep-23 | 18:05 | x64      |
| Oledbsrc.dll                                                  | 2019.150.4335.1 | 264144    | 21-Sep-23 | 18:05 | x86      |
| Oledbsrc.dll                                                  | 2019.150.4335.1 | 313384    | 21-Sep-23 | 18:05 | x64      |
| Rawdest.dll                                                   | 2019.150.4335.1 | 190504    | 21-Sep-23 | 18:05 | x86      |
| Rawdest.dll                                                   | 2019.150.4335.1 | 227264    | 21-Sep-23 | 18:05 | x64      |
| Rawsource.dll                                                 | 2019.150.4335.1 | 178216    | 21-Sep-23 | 18:05 | x86      |
| Rawsource.dll                                                 | 2019.150.4335.1 | 211000    | 21-Sep-23 | 18:05 | x64      |
| Recordsetdest.dll                                             | 2019.150.4335.1 | 174120    | 21-Sep-23 | 18:05 | x86      |
| Recordsetdest.dll                                             | 2019.150.4335.1 | 202688    | 21-Sep-23 | 18:05 | x64      |
| Sqlceip.exe                                                   | 15.0.4335.1     | 297016    | 21-Sep-23 | 18:05 | x86      |
| Sqldest.dll                                                   | 2019.150.4335.1 | 239672    | 21-Sep-23 | 18:05 | x86      |
| Sqldest.dll                                                   | 2019.150.4335.1 | 276520    | 21-Sep-23 | 18:05 | x64      |
| Sqltaskconnections.dll                                        | 2019.150.4335.1 | 170040    | 21-Sep-23 | 18:05 | x86      |
| Sqltaskconnections.dll                                        | 2019.150.4335.1 | 202808    | 21-Sep-23 | 18:05 | x64      |
| Txagg.dll                                                     | 2019.150.4335.1 | 329784    | 21-Sep-23 | 18:05 | x86      |
| Txagg.dll                                                     | 2019.150.4335.1 | 391120    | 21-Sep-23 | 18:05 | x64      |
| Txbdd.dll                                                     | 2019.150.4335.1 | 153536    | 21-Sep-23 | 18:05 | x86      |
| Txbdd.dll                                                     | 2019.150.4335.1 | 190520    | 21-Sep-23 | 18:05 | x64      |
| Txbestmatch.dll                                               | 2019.150.4335.1 | 546768    | 21-Sep-23 | 18:05 | x86      |
| Txbestmatch.dll                                               | 2019.150.4335.1 | 653368    | 21-Sep-23 | 18:05 | x64      |
| Txcache.dll                                                   | 2019.150.4335.1 | 165944    | 21-Sep-23 | 18:05 | x86      |
| Txcache.dll                                                   | 2019.150.4335.1 | 211000    | 21-Sep-23 | 18:05 | x64      |
| Txcharmap.dll                                                 | 2019.150.4335.1 | 272424    | 21-Sep-23 | 18:05 | x86      |
| Txcharmap.dll                                                 | 2019.150.4335.1 | 313384    | 21-Sep-23 | 18:05 | x64      |
| Txcopymap.dll                                                 | 2019.150.4335.1 | 165944    | 21-Sep-23 | 18:05 | x86      |
| Txcopymap.dll                                                 | 2019.150.4335.1 | 198712    | 21-Sep-23 | 18:05 | x64      |
| Txdataconvert.dll                                             | 2019.150.4335.1 | 276536    | 21-Sep-23 | 18:05 | x86      |
| Txdataconvert.dll                                             | 2019.150.4335.1 | 317480    | 21-Sep-23 | 18:05 | x64      |
| Txderived.dll                                                 | 2019.150.4335.1 | 559160    | 21-Sep-23 | 18:05 | x86      |
| Txderived.dll                                                 | 2019.150.4335.1 | 640968    | 21-Sep-23 | 18:05 | x64      |
| Txfileextractor.dll                                           | 2019.150.4335.1 | 182312    | 21-Sep-23 | 18:05 | x86      |
| Txfileextractor.dll                                           | 2019.150.4335.1 | 219072    | 21-Sep-23 | 18:05 | x64      |
| Txfileinserter.dll                                            | 2019.150.4335.1 | 182224    | 21-Sep-23 | 18:05 | x86      |
| Txfileinserter.dll                                            | 2019.150.4335.1 | 215080    | 21-Sep-23 | 18:05 | x64      |
| Txgroupdups.dll                                               | 2019.150.4335.1 | 255936    | 21-Sep-23 | 18:05 | x86      |
| Txgroupdups.dll                                               | 2019.150.4335.1 | 313400    | 21-Sep-23 | 18:05 | x64      |
| Txlineage.dll                                                 | 2019.150.4335.1 | 129064    | 21-Sep-23 | 18:05 | x86      |
| Txlineage.dll                                                 | 2019.150.4335.1 | 153656    | 21-Sep-23 | 18:05 | x64      |
| Txlookup.dll                                                  | 2019.150.4335.1 | 469032    | 21-Sep-23 | 18:05 | x86      |
| Txlookup.dll                                                  | 2019.150.4335.1 | 542776    | 21-Sep-23 | 18:05 | x64      |
| Txmerge.dll                                                   | 2019.150.4335.1 | 202792    | 21-Sep-23 | 18:05 | x86      |
| Txmerge.dll                                                   | 2019.150.4335.1 | 247848    | 21-Sep-23 | 18:05 | x64      |
| Txmergejoin.dll                                               | 2019.150.4335.1 | 247848    | 21-Sep-23 | 18:05 | x86      |
| Txmergejoin.dll                                               | 2019.150.4335.1 | 309304    | 21-Sep-23 | 18:05 | x64      |
| Txmulticast.dll                                               | 2019.150.4335.1 | 116792    | 21-Sep-23 | 18:05 | x86      |
| Txmulticast.dll                                               | 2019.150.4335.1 | 145360    | 21-Sep-23 | 18:05 | x64      |
| Txpivot.dll                                                   | 2019.150.4335.1 | 206888    | 21-Sep-23 | 18:05 | x86      |
| Txpivot.dll                                                   | 2019.150.4335.1 | 239656    | 21-Sep-23 | 18:05 | x64      |
| Txrowcount.dll                                                | 2019.150.4335.1 | 116672    | 21-Sep-23 | 18:05 | x86      |
| Txrowcount.dll                                                | 2019.150.4335.1 | 141368    | 21-Sep-23 | 18:05 | x64      |
| Txsampling.dll                                                | 2019.150.4335.1 | 157752    | 21-Sep-23 | 18:05 | x86      |
| Txsampling.dll                                                | 2019.150.4335.1 | 194616    | 21-Sep-23 | 18:05 | x64      |
| Txscd.dll                                                     | 2019.150.4335.1 | 198696    | 21-Sep-23 | 18:05 | x86      |
| Txscd.dll                                                     | 2019.150.4335.1 | 235472    | 21-Sep-23 | 18:05 | x64      |
| Txsort.dll                                                    | 2019.150.4335.1 | 231464    | 21-Sep-23 | 18:05 | x86      |
| Txsort.dll                                                    | 2019.150.4335.1 | 288704    | 21-Sep-23 | 18:05 | x64      |
| Txsplit.dll                                                   | 2019.150.4335.1 | 550864    | 21-Sep-23 | 18:05 | x86      |
| Txsplit.dll                                                   | 2019.150.4335.1 | 624592    | 21-Sep-23 | 18:05 | x64      |
| Txtermextraction.dll                                          | 2019.150.4335.1 | 8644664   | 21-Sep-23 | 18:05 | x86      |
| Txtermextraction.dll                                          | 2019.150.4335.1 | 8701992   | 21-Sep-23 | 18:05 | x64      |
| Txtermlookup.dll                                              | 2019.150.4335.1 | 4138944   | 21-Sep-23 | 18:05 | x86      |
| Txtermlookup.dll                                              | 2019.150.4335.1 | 4184120   | 21-Sep-23 | 18:05 | x64      |
| Txunionall.dll                                                | 2019.150.4335.1 | 161728    | 21-Sep-23 | 18:05 | x86      |
| Txunionall.dll                                                | 2019.150.4335.1 | 206784    | 21-Sep-23 | 18:05 | x64      |
| Txunpivot.dll                                                 | 2019.150.4335.1 | 182328    | 21-Sep-23 | 18:05 | x86      |
| Txunpivot.dll                                                 | 2019.150.4335.1 | 214976    | 21-Sep-23 | 18:05 | x64      |
| Xe.dll                                                        | 2019.150.4335.1 | 632888    | 21-Sep-23 | 18:05 | x86      |
| Xe.dll                                                        | 2019.150.4335.1 | 722880    | 21-Sep-23 | 18:05 | x64      |

SQL Server 2019 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1964.0     | 559536    | 21-Sep-23 | 19:04 | x86      |
| Dmsnative.dll                                                        | 2018.150.1964.0 | 152496    | 21-Sep-23 | 19:04 | x64      |
| Dwengineservice.dll                                                  | 15.0.1964.0     | 45016     | 21-Sep-23 | 19:04 | x86      |
| Eng_polybase_odbcdrivermongo_2321_mongodbodbc_sb64_dll.64            | 2.3.21.1023     | 18691056  | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdrivermongo_2321_saslsspi_dll.64                    | 1.0.2.1003      | 147504    | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdrivermongo_238_mongodbodbc_sb64_dll.64             | 2.3.8.1008      | 17142672  | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdrivermongo_238_saslsspi_dll.64                     | 1.0.2.1003      | 146304    | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdriveroracle_802_mscurl28_dll.64                    | 8.0.2.304       | 2532096   | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28_dll.64                     | 8.0.2.2592      | 2425088   | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdriveroracle_802_msora28r_dll.64                    | 8.0.2.2592      | 151808    | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdriveroracle_802_msssl28_dll.64                     | 8.0.2.244       | 2416384   | 21-Sep-23 | 19:04 | x64      |
| Eng_polybase_odbcdriveroracle_802_mstls28_dll.64                     | 8.0.2.216       | 2953472   | 21-Sep-23 | 19:04 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109768  | 21-Sep-23 | 19:04 | x64      |
| Icudt58.dll                                                          | 58.3.0.0        | 27110344  | 21-Sep-23 | 19:04 | x64      |
| Icudt58.dll                                                          | 58.2.0.0        | 27109832  | 21-Sep-23 | 19:04 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2431880   | 21-Sep-23 | 19:04 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2551752   | 21-Sep-23 | 19:04 | x64      |
| Icuin58.dll                                                          | 58.3.0.0        | 2562504   | 21-Sep-23 | 19:04 | x64      |
| Icuin58.dll                                                          | 58.2.0.0        | 2425288   | 21-Sep-23 | 19:04 | x64      |
| Icuuc42.dll                                                          | 8.0.2.124       | 15491840  | 21-Sep-23 | 19:04 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1783688   | 21-Sep-23 | 19:04 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1924040   | 21-Sep-23 | 19:04 | x64      |
| Icuuc58.dll                                                          | 58.2.0.0        | 1775048   | 21-Sep-23 | 19:04 | x64      |
| Icuuc58.dll                                                          | 58.3.0.0        | 1888712   | 21-Sep-23 | 19:04 | x64      |
| Instapi150.dll                                                       | 2019.150.4335.1 | 88104     | 21-Sep-23 | 19:04 | x64      |
| Libcrypto-1_1-x64.dll                                                | 1.1.0.10        | 2620304   | 21-Sep-23 | 19:04 | x64      |
| Libcrypto                                                            | 1.1.1.4         | 2953680   | 21-Sep-23 | 19:04 | x64      |
| Libcrypto                                                            | 1.1.1.14        | 4085336   | 21-Sep-23 | 19:04 | x64      |
| Libcrypto                                                            | 1.1.1.11        | 4321232   | 21-Sep-23 | 19:04 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 292224    | 21-Sep-23 | 19:04 | x64      |
| Libsasl.dll                                                          | 2.1.26.0        | 521664    | 21-Sep-23 | 19:04 | x64      |
| Libssl-1_1-x64.dll                                                   | 1.1.0.10        | 648080    | 21-Sep-23 | 19:04 | x64      |
| Libssl                                                               | 1.1.1.14        | 1195600   | 21-Sep-23 | 19:04 | x64      |
| Libssl                                                               | 1.1.1.11        | 1322960   | 21-Sep-23 | 19:04 | x64      |
| Libssl                                                               | 1.1.1.4         | 798160    | 21-Sep-23 | 19:04 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1964.0     | 67544     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1964.0     | 293328    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1964.0     | 1957848   | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1964.0     | 169392    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1964.0     | 649648    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1964.0     | 246192    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1964.0     | 139184    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1964.0     | 79776     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1964.0     | 51104     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1964.0     | 88496     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1964.0     | 1129392   | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1964.0     | 80816     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1964.0     | 70616     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1964.0     | 35248     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1964.0     | 31192     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1964.0     | 46552     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1964.0     | 21448     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1964.0     | 26528     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1964.0     | 131536    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1964.0     | 86488     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1964.0     | 100824    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1964.0     | 293328    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 120240    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 138160    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 141232    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 137680    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 150448    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 139696    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 134608    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 176600    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 117664    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1964.0     | 136656    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1964.0     | 72664     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1964.0     | 21936     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1964.0     | 37280     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1964.0     | 128928    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1964.0     | 3064752   | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1964.0     | 3955672   | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 118232    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133024    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 137688    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 133584    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 148440    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 134088    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 130464    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 170912    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 115144    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1964.0     | 132056    | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1964.0     | 67544     | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1964.0     | 2682800   | 21-Sep-23 | 19:04 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1964.0     | 2436568   | 21-Sep-23 | 19:04 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4335.1 | 452544    | 21-Sep-23 | 19:04 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4335.1 | 7407656   | 21-Sep-23 | 19:04 | x64      |
| Msodbcsql17.dll                                                      | 2017.174.1.1    | 2016120   | 21-Sep-23 | 19:04 | x64      |
| Odbc32.dll                                                           | 10.0.17763.1    | 720792    | 21-Sep-23 | 19:04 | x64      |
| Odbccp32.dll                                                         | 10.0.17763.1    | 138136    | 21-Sep-23 | 19:04 | x64      |
| Odbctrac.dll                                                         | 10.0.17763.1    | 175000    | 21-Sep-23 | 19:04 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 170880    | 21-Sep-23 | 19:04 | x64      |
| Saslplain.dll                                                        | 2.1.26.0        | 377792    | 21-Sep-23 | 19:04 | x64      |
| Secforwarder.dll                                                     | 2019.150.4335.1 | 79808     | 21-Sep-23 | 19:04 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1964.0 | 61400     | 21-Sep-23 | 19:04 | x64      |
| Sqldk.dll                                                            | 2019.150.4335.1 | 3180584   | 21-Sep-23 | 19:04 | x64      |
| Sqldumper.exe                                                        | 2019.150.4335.1 | 366632    | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 1595448   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 4171816   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 3418168   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 4163624   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 4069416   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 2226232   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 2172984   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 3827752   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 3823672   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 1538104   | 21-Sep-23 | 19:04 | x64      |
| Sqlevn70.rll                                                         | 2019.150.4335.1 | 4036664   | 21-Sep-23 | 19:04 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 21-Sep-23 | 19:04 | x64      |
| Sqlos.dll                                                            | 2019.150.4335.1 | 42944     | 21-Sep-23 | 19:04 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1964.0 | 4841432   | 21-Sep-23 | 19:04 | x64      |
| Sqltses.dll                                                          | 2019.150.4335.1 | 9119680   | 21-Sep-23 | 19:04 | x64      |
| Tdataodbc_sb                                                         | 17.0.0.27       | 12914640  | 21-Sep-23 | 19:04 | x64      |
| Tdataodbc_sb                                                         | 16.20.0.1078    | 14995920  | 21-Sep-23 | 19:04 | x64      |
| Terasso.dll                                                          | 16.20.0.13      | 2158896   | 21-Sep-23 | 19:04 | x64      |
| Terasso.dll                                                          | 17.0.0.28       | 2357064   | 21-Sep-23 | 19:04 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 281472    | 21-Sep-23 | 19:04 | x64      |
| Zlibwapi.dll                                                         | 1.2.11.0        | 499248    | 21-Sep-23 | 19:04 | x64      |

SQL Server 2019 sql_shared_mr

| File   name | File version | File size |    Date   |  Time | Platform |
|:-----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll  | 15.0.4335.1  | 30656     | 21-Sep-23 | 18:05 | x86      |

SQL Server 2019 sql_tools_extensions

|                          File   name                         |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                                | 2019.150.4335.1 | 1632296   | 21-Sep-23 | 18:22 | x86      |
| Dtaengine.exe                                                | 2019.150.4335.1 | 219080    | 21-Sep-23 | 18:22 | x86      |
| Dteparse.dll                                                 | 2019.150.4335.1 | 112696    | 21-Sep-23 | 18:22 | x86      |
| Dteparse.dll                                                 | 2019.150.4335.1 | 124864    | 21-Sep-23 | 18:22 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4335.1 | 133072    | 21-Sep-23 | 18:22 | x64      |
| Dteparsemgd.dll                                              | 2019.150.4335.1 | 116776    | 21-Sep-23 | 18:22 | x86      |
| Dtepkg.dll                                                   | 2019.150.4335.1 | 133176    | 21-Sep-23 | 18:22 | x86      |
| Dtepkg.dll                                                   | 2019.150.4335.1 | 149456    | 21-Sep-23 | 18:22 | x64      |
| Dtexec.exe                                                   | 2019.150.4335.1 | 65064     | 21-Sep-23 | 18:22 | x86      |
| Dtexec.exe                                                   | 2019.150.4335.1 | 73664     | 21-Sep-23 | 18:22 | x64      |
| Dts.dll                                                      | 2019.150.4335.1 | 3143720   | 21-Sep-23 | 18:22 | x64      |
| Dts.dll                                                      | 2019.150.4335.1 | 2762792   | 21-Sep-23 | 18:22 | x86      |
| Dtscomexpreval.dll                                           | 2019.150.4335.1 | 501800    | 21-Sep-23 | 18:22 | x64      |
| Dtscomexpreval.dll                                           | 2019.150.4335.1 | 444456    | 21-Sep-23 | 18:22 | x86      |
| Dtsconn.dll                                                  | 2019.150.4335.1 | 432184    | 21-Sep-23 | 18:22 | x86      |
| Dtsconn.dll                                                  | 2019.150.4335.1 | 522280    | 21-Sep-23 | 18:22 | x64      |
| Dtshost.exe                                                  | 2019.150.4335.1 | 107576    | 21-Sep-23 | 18:22 | x64      |
| Dtshost.exe                                                  | 2019.150.4335.1 | 89656     | 21-Sep-23 | 18:22 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4335.1 | 554960    | 21-Sep-23 | 18:22 | x86      |
| Dtsmsg150.dll                                                | 2019.150.4335.1 | 567232    | 21-Sep-23 | 18:22 | x64      |
| Dtspipeline.dll                                              | 2019.150.4335.1 | 1120192   | 21-Sep-23 | 18:22 | x86      |
| Dtspipeline.dll                                              | 2019.150.4335.1 | 1329088   | 21-Sep-23 | 18:22 | x64      |
| Dtswizard.exe                                                | 15.0.4335.1     | 886720    | 21-Sep-23 | 18:22 | x64      |
| Dtswizard.exe                                                | 15.0.4335.1     | 890832    | 21-Sep-23 | 18:22 | x86      |
| Dtuparse.dll                                                 | 2019.150.4335.1 | 100288    | 21-Sep-23 | 18:22 | x64      |
| Dtuparse.dll                                                 | 2019.150.4335.1 | 88104     | 21-Sep-23 | 18:22 | x86      |
| Dtutil.exe                                                   | 2019.150.4335.1 | 130616    | 21-Sep-23 | 18:22 | x86      |
| Dtutil.exe                                                   | 2019.150.4335.1 | 150976    | 21-Sep-23 | 18:22 | x64      |
| Exceldest.dll                                                | 2019.150.4335.1 | 235472    | 21-Sep-23 | 18:22 | x86      |
| Exceldest.dll                                                | 2019.150.4335.1 | 280616    | 21-Sep-23 | 18:22 | x64      |
| Excelsrc.dll                                                 | 2019.150.4335.1 | 260048    | 21-Sep-23 | 18:22 | x86      |
| Excelsrc.dll                                                 | 2019.150.4335.1 | 309304    | 21-Sep-23 | 18:22 | x64      |
| Flatfiledest.dll                                             | 2019.150.4335.1 | 358344    | 21-Sep-23 | 18:22 | x86      |
| Flatfiledest.dll                                             | 2019.150.4335.1 | 411688    | 21-Sep-23 | 18:22 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4335.1 | 428072    | 21-Sep-23 | 18:22 | x64      |
| Flatfilesrc.dll                                              | 2019.150.4335.1 | 370728    | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.astasks.dll                              | 15.0.4335.1     | 116776    | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4335.1     | 403408    | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll               | 15.0.4335.1     | 403392    | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4335.1     | 3004456   | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.configuration.sco.dll                    | 15.0.4335.1     | 3004472   | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4335.1     | 42944     | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.integrationservices.runtimetelemetry.dll | 15.0.4335.1     | 43048     | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.management.integrationservicesenum.dll   | 15.0.4335.1     | 59432     | 21-Sep-23 | 18:22 | x86      |
| Microsoft.sqlserver.olapenum.dll                             | 15.0.18185.0    | 100800    | 21-Sep-23 | 18:22 | x86      |
| Msdtssrvrutil.dll                                            | 2019.150.4335.1 | 112680    | 21-Sep-23 | 18:22 | x64      |
| Msdtssrvrutil.dll                                            | 2019.150.4335.1 | 100408    | 21-Sep-23 | 18:22 | x86      |
| Msmgdsrv.dll                                                 | 2018.150.35.41  | 8281032   | 21-Sep-23 | 18:05 | x86      |
| Oledbdest.dll                                                | 2019.150.4335.1 | 239656    | 21-Sep-23 | 18:22 | x86      |
| Oledbdest.dll                                                | 2019.150.4335.1 | 280616    | 21-Sep-23 | 18:22 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4335.1 | 313384    | 21-Sep-23 | 18:22 | x64      |
| Oledbsrc.dll                                                 | 2019.150.4335.1 | 264144    | 21-Sep-23 | 18:22 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4335.1 | 38952     | 21-Sep-23 | 18:22 | x86      |
| Sqlresourceloader.dll                                        | 2019.150.4335.1 | 51136     | 21-Sep-23 | 18:22 | x64      |
| Sqlscm.dll                                                   | 2019.150.4335.1 | 79928     | 21-Sep-23 | 18:22 | x86      |
| Sqlscm.dll                                                   | 2019.150.4335.1 | 88016     | 21-Sep-23 | 18:22 | x64      |
| Sqlsvc.dll                                                   | 2019.150.4335.1 | 149544    | 21-Sep-23 | 18:22 | x86      |
| Sqlsvc.dll                                                   | 2019.150.4335.1 | 182328    | 21-Sep-23 | 18:22 | x64      |
| Sqltaskconnections.dll                                       | 2019.150.4335.1 | 170040    | 21-Sep-23 | 18:22 | x86      |
| Sqltaskconnections.dll                                       | 2019.150.4335.1 | 202808    | 21-Sep-23 | 18:22 | x64      |
| Txdataconvert.dll                                            | 2019.150.4335.1 | 317480    | 21-Sep-23 | 18:22 | x64      |
| Txdataconvert.dll                                            | 2019.150.4335.1 | 276536    | 21-Sep-23 | 18:22 | x86      |
| Xe.dll                                                       | 2019.150.4335.1 | 632888    | 21-Sep-23 | 18:22 | x86      |
| Xe.dll                                                       | 2019.150.4335.1 | 722880    | 21-Sep-23 | 18:22 | x64      |

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
  - CUs might contain added value over and above hotfixes. This includes supportability, manageability, and reliability updates.
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

One CU package includes all available updates for all SQL Server 2019 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
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
