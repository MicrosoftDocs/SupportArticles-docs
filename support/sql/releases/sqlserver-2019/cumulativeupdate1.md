---
title: Cumulative Update 1 for SQL Server 2019 (KB4527376)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2019 cumulative update 1 (KB4527376).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4527376
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2019 on Windows
- SQL Server 2019 on Linux
---

# KB4527376 - Cumulative Update 1 for SQL Server 2019

_Release Date:_ &nbsp; January 07, 2020  
_Version:_ &nbsp; 15.0.4003.23

## Summary

This article describes Cumulative Update package 1 (CU1) for Microsoft SQL Server 2019. This update contains 61 [fixes](#improvements-and-fixes-included-in-this-cumulative-update) that were issued after the release of SQL Server 2019 RTM, and it updates components in the following builds:

- SQL Server - Product version: **15.0.4003.23**, file version: **2019.150.4003.23**
- Analysis Services - Product version: **15.0.32.52**, file version: **2018.150.32.52**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this cumulative update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|----------------------------------------------|-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|----------|
| <a id="13234376">[13234376](#13234376)</a> | [FIX: Package execution may be impacted in SQL Server 2019 Integration Services (KB4530097)](https://support.microsoft.com/help/4530097) | Integration services | Integration services | Windows |
| <a id="13211958">[13211958](#13211958)</a> | [FIX: File content is sent twice when copied to HDFS using Hadoop File System Task in SQL Server 2017 and 2019 (KB4516999)](https://support.microsoft.com/help/4516999) | Integration Services | Tasks_Components | Windows |
| <a id="13202468">[13202468](#13202468)</a> | [FIX: Restore fails when you try to restore compressed TDE backups prior to SQL Server 2016 SP2 CU4 on SQL Server 2016 SP2 CU8 (KB4529942)](https://support.microsoft.com/help/4529942) | SQL Server Engine | Backup Restore | Windows |
| <a id="13211965">[13211965](#13211965)</a> | [FIX: SQL Writer Service fails to back up in non-component backup path in SQL Server 2016, 2017 and 2019 (KB4521659)](https://support.microsoft.com/help/4521659) | SQL Server Engine | Backup Restore | Windows |
| <a id="13211960">[13211960](#13211960)</a> | [FIX: Non-yielding scheduler error occurs when you run batch query with sort operation in SQL Server 2017 and 2019 (KB4522405)](https://support.microsoft.com/help/4522405) | SQL Server Engine | Column Stores | All |
| <a id="13255810">[13255810](#13255810)</a> | [FIX: Unsigned files are installed through the Microsoft MPI in SQL Server 2019 (KB4529944)](https://support.microsoft.com/help/4529944) | SQL Server Engine |Extensibility | Windows |
| <a id="13261241">[13261241](#13261241)</a> | [FIX: PolyBase Hadoop queries may fail when the launchpadd service is restarted or killed in SQL Server 2019 (KB4530468)](https://support.microsoft.com/help/4530468) | SQL Server Engine | Extensibility | Linux |
| <a id="13224872">[13224872](#13224872)</a> | [FIX: "The File location cannot be opened" error occurs when you try to open a FileTable directory in SQL Server (KB4530720)](https://support.microsoft.com/help/4530720) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="13198910">[13198910](#13198910)</a> | [FIX: Transaction log isn't truncated on a single node Availability Group in SQL Server (KB4515772)](https://support.microsoft.com/help/4515772) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13221770">[13221770](#13221770)</a> | [FIX: Dump is generated when you create an AG with more than 122 characters in SQL Server 2019 (KB4536077)](https://support.microsoft.com/help/4536077) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13239089">[13239089](#13239089)</a> | [FIX: Worker stealing stops working when AG contains one or more encrypted databases in SQL Server 2019 (KB4530054)](https://support.microsoft.com/help/4530054) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13239100">[13239100](#13239100)</a> | [FIX: Access violation occurs when worker stealing is enabled and CPU capacity reaches maximal configured value in SQL Server 2019 (KB4530055)](https://support.microsoft.com/help/4530055) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="13294167">[13294167](#13294167)</a> | [FIX: Upgrading FCI passive node from SQL Server 2019 RC1 to RTM fails when you try to access the MSSQL\JOBS on the shared drive (KB4533251)](https://support.microsoft.com/help/4533251) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="13234475">[13234475](#13234475)</a> | [Improvement: Add new fields to latch_suspend_end Extended Event in SQL Server 2019 (KB4530280)](https://support.microsoft.com/help/4530280) | SQL Server Engine | Metadata | All |
| <a id="13264231">[13264231](#13264231)</a> | [Improvement: Update the hktempdb.dll version in SQL Server 2019 (KB4531125)](https://support.microsoft.com/help/4531125) | SQL Server Engine | Metadata | All |
| <a id="13166853">[13166853](#13166853)</a> | [FIX: Stack dump occurs when table type has a user-defined constraint in SQL Server 2016, 2017 and 2019(KB4519796)](https://support.microsoft.com/help/4519796) | SQL Server Engine | Metadata | Windows |
| <a id="13166854">[13166854](#13166854)</a> | [FIX: ObjectPropertyEx Cardinality property for columnstore table doesn't include rows in delta store rowset or account rows in deleted bitmap rowset in SQL Server 2019 (KB4521702)](https://support.microsoft.com/help/4521702) | SQL Server Engine | Metadata | Windows |
| <a id="13211966">[13211966](#13211966)</a> | [FIX: Access violation occurs when a clone database verification fails in SQL Server 2016, 2017 and 2019 (KB4521960)](https://support.microsoft.com/help/4521960) | SQL Server Engine | Metadata | Windows |
| <a id="13234473">[13234473](#13234473)</a> | [FIX: "Debug Assertion Failed" error if you create objects that are not hashed by name in SQL Server 2019 (KB4528139)](https://support.microsoft.com/help/4528139) | SQL Server Engine | Metadata | All |
| <a id="13234474">[13234474](#13234474)</a> | [FIX: Access violation occurs when attempting to fetch the IAM page of the table in SQL Server 2019 (KB4528490)](https://support.microsoft.com/help/4528490) | SQL Server Engine | Metadata | All |
| <a id="13234476">[13234476](#13234476)</a> | [FIX: Access violation occurs when you call HkError.Throw() in SQL Server 2019 (KB4528491)](https://support.microsoft.com/help/4528491) | SQL Server Engine | Metadata | All |
| <a id="13234477">[13234477](#13234477)</a> | [FIX: DTC transaction scenario reports unsupported transaction error when HkTempdb transaction is used in SQL Server 2019 (KB4528492)](https://support.microsoft.com/help/4528492) | SQL Server Engine | Metadata | All |
| <a id="13240653">[13240653](#13240653)</a> | [FIX: Typo in error message for Columnstore indexes on temporary tables in SQL Server 2019 (KB4530281)](https://support.microsoft.com/help/4530281) | SQL Server Engine | Metadata | All |
| <a id="13265941">[13265941](#13265941)</a> | [Improvement: Update PolyBase vbump to 150.1812.0 in SQL Server 2019 (KB4531025)](https://support.microsoft.com/help/4531025) | SQL Server Engine | PolyBase | Linux |
| <a id="13187033">[13187033](#13187033)</a> | [FIX: Two issues with remote Hadoop bridge process in SQL Server 2019 (KB4530827)](https://support.microsoft.com/help/4530827) | SQL Server Engine | PolyBase | Linux |
| <a id="13262614">[13262614](#13262614)</a> | [FIX: Non-yielding scheduler error when Polybase function call to shared memory takes long time in SQL Server 2019 (KB4530499)](https://support.microsoft.com/help/4530499) | SQL Server Engine | PolyBase | All |
| <a id="13262844">[13262844](#13262844)</a> | [FIX: Spurious lines may be added to the SQL Server error log at each initialization in SQL Server 2019 (KB4531224)](https://support.microsoft.com/help/4531224) | SQL Server Engine | PolyBase | All |
| <a id="13262848">[13262848](#13262848)</a> | [FIX: PolyBase query may hang when DMS restarts in SQL Server 2019 (KB4531225)](https://support.microsoft.com/help/4531225) | SQL ServSer Engine | PolyBase | All |
| <a id="13198916">[13198916](#13198916)</a> | [FIX: Orphaned CLR sessions cause blocking in SQL Server (KB4517771)](https://support.microsoft.com/help/4517771) | SQL Server Engine | Programmability | Windows |
| <a id="13211959">[13211959](#13211959)</a> | [FIX: Access violation occurs when you run queries that involve PIVOT or UNPIVOT in SQL Server 2016, 2017 and 2019 (KB4518364)](https://support.microsoft.com/help/4518364) | SQL Server Engine | Programmability | Windows |
| <a id="13238936">[13238936](#13238936)</a> | [FIX: Using temporary tables across multiple scopes may cause Error 213 or access violation in SQL Server 2019 (KB4528168)](https://support.microsoft.com/help/4528168) | SQL Server Engine | Programmability | All |
| <a id="13240867">[13240867](#13240867)</a> | [FIX: Access violation occurs when you query sys.dm_db_persisted_sku_features DMV in SQL Server 2019 (KB4528097)](https://support.microsoft.com/help/4528097) | SQL Server Engine | Programmability | All |
| <a id="13262517">[13262517](#13262517)</a> | [FIX: Access violation occurs when you set database containment to NONE in SQL Server 2019 (KB4531049)](https://support.microsoft.com/help/4531049) | SQL Server Engine | Programmability | All |
| <a id="13234379">[13234379](#13234379)</a> | [FIX: Assertion error when you run internal query in batch mode for populating full-text index on computed LOB in SQL Server 2019 (KB4528337)](https://support.microsoft.com/help/4528337) | SQL Server Engine | Query Execution | All |
| <a id="13253822">[13253822](#13253822)</a> | [FIX: "A system assertion check has failed" error when a procedure call is made from CLR with an OUTPUT large object argument (KB4527538)](https://support.microsoft.com/help/4527538) | SQL Server Engine | Query Execution | All |
| <a id="13264113">[13264113](#13264113)</a> | [FIX: Error 8601 occurs when you run a query with partition function in SQL Server (KB4530251)](https://support.microsoft.com/help/4530251) | SQL Server Engine | Query Execution | Windows |
| <a id="13222690">[13222690](#13222690)</a> | [FIX: Incorrect results occur with index intersection on partitioned table with a clustered columnstore index in SQL Server (KB4519366)](https://support.microsoft.com/help/4519366) | SQL Server Engine | Query Optimizer | All |
| <a id="13262555">[13262555](#13262555)</a> | [Improvement: Corrupted statistics can be detected by using extended_logical_checks in SQL Server 2019 (KB4530907)](https://support.microsoft.com/help/4530907) | SQL Server Engine | Query Optimizer | All |
| <a id="13256585">[13256585](#13256585)</a> | [Improvement: Execute Database upgrade scripts when Database state changes in SQL Server 2019 (KB4530283)](https://support.microsoft.com/help/4530283) | SQL Server Engine | Replication | Windows |
| <a id="13200684">[13200684](#13200684)</a> | [FIX: Error occurs when CDC capture process tries to insert duplicate key in table "cdc.lsn_time_mapping" in SQL Server 2016, 2017 and 2019 (KB4521739)](https://support.microsoft.com/help/4521739) | SQL Server Engine | Replication | All |
| <a id="13254376">[13254376](#13254376)</a> | [Improvement: Update SDK to improve security of Always Encrypted by using secure enclaves in SQL Server 2019 (KB4530286)](https://support.microsoft.com/help/4530286) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13254382">[13254382](#13254382)</a> | [Improvement: Update error messages of Always Encrypted with secure enclaves in SQL Server 2019 (KB4530079)](https://support.microsoft.com/help/4530079) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13254394">[13254394](#13254394)</a> | [Improvement: Update the misspelled words in server_principal_sid and server_principal_name description in SQL Server 2019 (KB4530080)](https://support.microsoft.com/help/4530080) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13254405">[13254405](#13254405)</a> | [Improvement: Add support to create index on encrypted unique identifier using Always Encrypted feature in SQL Server 2019 (KB4530814)](https://support.microsoft.com/help/4530814) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13255812">[13255812](#13255812)</a> | [Improvement: Add unlimited buffer size to support TDS V1 and V2 in SQL Server 2019 (KB4530302)](https://support.microsoft.com/help/4530302) | SQL Server Engine | Security Infrastructure | All |
| <a id="13251715">[13251715](#13251715)</a> | [FIX: Audit of batch may be skipped when the batch causes a failure that closes the session in SQL Server 2019 (KB4529893)](https://support.microsoft.com/help/4529893) | SQL Server Engine | Security Infrastructure | All |
| <a id="13254368">[13254368](#13254368)</a> | [FIX: Error occurs when you try to install SQL Server 2019 on a low power CPU (KB4530084)](https://support.microsoft.com/help/4530084) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13254399">[13254399](#13254399)</a> | [FIX: Data masking of user-defined functions may result in crashes in SQL Server 2019 (KB4530303)](https://support.microsoft.com/help/4530303) | SQL Server Engine | Security Infrastructure | All |
| <a id="13259822">[13259822](#13259822)</a> | [FIX: sp_describe_parameter_encryption returns different results with different parameter positions in SQL Server 2019 (KB4530427)](https://support.microsoft.com/help/4530427) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="13234380">[13234380](#13234380)</a> | [FIX: PolyBase DMVs may return unexpected results after changing PolyBase enabled setting in SQL Server 2019 (KB4529848)](https://support.microsoft.com/help/4529848) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13262593">[13262593](#13262593)</a> | [FIX: Data pool database may be deleted if you fail to drop database on master in SQL Server 2019 (KB4530496)](https://support.microsoft.com/help/4530496) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13262616">[13262616](#13262616)</a> | [FIX: FSM may be called when you create a database in SQL Server 2019 Big Data Clusters (KB4530769)](https://support.microsoft.com/help/4530769) | SQL Server Engine | SQL BDC Polybase | All |
| <a id="13262868">[13262868](#13262868)</a> | [FIX: NullPointerException occurs when the name node is not active and the HTTP request has other failures in SQL Server 2019 (KB4531026)](https://support.microsoft.com/help/4531026) | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13263004">[13263004](#13263004)</a> | [FIX: Query may fail when you join a storage pool table with a data pool table in SQL Server 2019 (KB4531029)](https://support.microsoft.com/help/4531029) | SQL Server Engine | SQL BDC Polybase | All|
| <a id="13265940">[13265940](#13265940)</a> | [FIX: Error occurs when you select from storage pool table and insert into another external table in SQL Server 2019 (KB4531226)](https://support.microsoft.com/help/4531226) | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13268527">[13268527](#13268527)</a> | [FIX: DMVs fail when Big Data Cluster has multiple compute nodes in SQL Server 2019 (KB4531349)](https://support.microsoft.com/help/4531349) | SQL Server Engine | SQL BDC Polybase | Linux |
| <a id="13211951">[13211951](#13211951)</a> | [FIX: SQL Server 2017 and 2019 on Linux fails with an Assertion error (KB4522002)](https://support.microsoft.com/help/4522002) | SQL Server Engine | SQL OS | Linux |
| <a id="13218547">[13218547](#13218547)</a> | [FIX: Database cannot recover and reports error 5243 in SQL Server (KB4526315)](https://support.microsoft.com/help/4526315) | SQL Server Engine | Storage Management | Windows |
| <a id="13198914">[13198914](#13198914)</a> | [FIX: Access violation occurs when you enable TF 3924 to clean orphaned DTC transactions in SQL Server 2016, 2017 and 2019 (KB4519668)](https://support.microsoft.com/help/4519668) | SQL Server Engine | Transaction Services | Windows |
| <a id="13262374">[13262374](#13262374)</a> | [FIX: Assertion dump occurs when sp_cdc_disable_db is executed to disable CDC or when distributed transaction is committed after ROLLBACK SAVEPOINT in SQL Server (KB4530500)](https://support.microsoft.com/help/4530500) | SQL Server Engine | Transaction Services | Windows |
| <a id="13268501">[13268501](#13268501)</a> | [FIX: Heap corruption occurs when ADR is disabled and aborted transactions are present in SQL Server 2019 database (KB4531238)](https://support.microsoft.com/help/4531238) | SQL Server Engine | Transaction Services | All |

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

 :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2019 CU1 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/01/sqlserver2019-kb4527376-x64_01dcaca398f0c3380264078463fc1a6cc859ec7c.exe)

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

You can verify the download by computing the hash of the *SQLServer2019-KB4527376-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2019-KB4527376-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2019-KB4527376-x64.exe|4718B10E0F6F4A0F79D8157A7BC1D2D46F84977ACFACEEB680B0B1194E66E1E3|

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2019 Analysis Services

|                         File name                         |   File version   | File size |    Date   |  Time | Platform |
|:---------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                        | 2018.150.32.52   | 291728    | 06-Dec-19 | 15:32 | x64      |
| Mashupcompression.dll                                     | 2.72.5556.181    | 140664    | 06-Dec-19 | 15:32 | x64      |
| Microsoft.analysisservices.minterop.dll                   | 15.0.32.52       | 757640    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 195976    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 196488    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 197520    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 198536    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 201104    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 213896    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 172936    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 174480    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 192400    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.core.resources.dll      | 15.0.32.52       | 251272    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.dll             | 15.0.32.52       | 1097304   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll        | 15.0.32.52       | 479840    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57440     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57952     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 58256     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 58976     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 61024     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 52832     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 53856     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 57232     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.server.tabular.resources.dll   | 15.0.32.52       | 66648     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16776     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16784     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16992     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 16992     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.analysisservices.timedimgenerator.resources.dll | 15.0.32.52       | 17800     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.edm.netfx35.dll                            | 5.7.0.62516      | 660856    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.dll                                 | 2.72.5556.181    | 180600    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.oledb.dll                           | 2.72.5556.181    | 30072     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.preview.dll                         | 2.72.5556.181    | 74616     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.dll                  | 2.72.5556.181    | 102264    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 29048     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 41848     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 28536     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 37752     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll        | 2.72.5556.181    | 45944     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.odata.netfx35.dll                          | 5.7.0.62516      | 1454456   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.odata.query.netfx35.dll                    | 5.7.0.62516      | 181112    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.dll                              | 1.0.0.25         | 920680    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25976     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 37752     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 23928     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 25464     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.data.sapclient.resources.dll                    | 1.0.0.25         | 28536     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.hostintegration.connectors.dll                  | 2.72.5556.181    | 5242744   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.container.exe                            | 2.72.5556.181    | 19832     | 06-Dec-19 | 15:32 | x64      |
| Microsoft.mashup.container.netfx40.exe                    | 2.72.5556.181    | 19832     | 06-Dec-19 | 15:32 | x64      |
| Microsoft.mashup.container.netfx45.exe                    | 2.72.5556.181    | 19832     | 06-Dec-19 | 15:32 | x64      |
| Microsoft.mashup.eventsource.dll                          | 2.72.5556.181    | 149368    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.dll                                | 2.72.5556.181    | 82296     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15224     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15432     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 14712     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oauth.resources.dll                      | 2.72.5556.181    | 15736     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oledbinterop.dll                         | 2.72.5556.181    | 190840    | 06-Dec-19 | 15:32 | x64      |
| Microsoft.mashup.oledbprovider.dll                        | 2.72.5556.181    | 59768     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll              | 2.72.5556.181    | 13176     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.scriptdom.dll                            | 2.40.4554.261    | 2371808   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.shims.dll                                | 2.72.5556.181    | 26488     | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll               | 1.0.0.0          | 140152    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.dll                                | 2.72.5556.181    | 14094200  | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 623480    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 627576    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 635768    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 643960    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 652152    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 676728    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 533368    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 541560    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 615288    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.mashupengine.resources.dll                      | 2.72.5556.181    | 848760    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.odata.core.netfx35.dll                          | 6.15.0.0         | 1437560   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.odata.edm.netfx35.dll                           | 6.15.0.0         | 778616    | 06-Dec-19 | 15:32 | x86      |
| Microsoft.powerbi.adomdclient.dll                         | 15.0.30.15       | 1100152   | 06-Dec-19 | 15:32 | x86      |
| Microsoft.spatial.netfx35.dll                             | 6.15.0.0         | 126328    | 06-Dec-19 | 15:32 | x86      |
| Msmdctr.dll                                               | 2018.150.32.52   | 37472     | 06-Dec-19 | 15:32 | x64      |
| Msmdlocal.dll                                             | 2018.150.32.52   | 66188384  | 06-Dec-19 | 15:32 | x64      |
| Msmdlocal.dll                                             | 2018.150.32.52   | 47704160  | 06-Dec-19 | 15:32 | x86      |
| Msmdpump.dll                                              | 2018.150.32.52   | 10187664  | 06-Dec-19 | 15:32 | x64      |
| Msmdredir.dll                                             | 2018.150.32.52   | 7955552   | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15960     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15968     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16264     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16480     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 15968     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 16472     | 06-Dec-19 | 15:32 | x86      |
| Msmdspdm.resources.dll                                    | 15.0.32.52       | 17504     | 06-Dec-19 | 15:32 | x86      |
| Msmdsrv.exe                                               | 2018.150.32.52   | 65722976  | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1000328   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1453456   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1521032   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1536392   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1595784   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1608072   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1627528   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 1642376   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 809864    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 832392    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrv.rll                                               | 2018.150.32.52   | 991624    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1450592   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1517664   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1532504   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1591904   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1604704   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1624160   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 1637472   | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 808536    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 831584    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 990328    | 06-Dec-19 | 15:32 | x64      |
| Msmdsrvi.rll                                              | 2018.150.32.52   | 998496    | 06-Dec-19 | 15:32 | x64      |
| Msmgdsrv.dll                                              | 2018.150.32.52   | 10184592  | 06-Dec-19 | 15:32 | x64      |
| Msmgdsrv.dll                                              | 2018.150.32.52   | 8278416   | 06-Dec-19 | 15:32 | x86      |
| Msolap.dll                                                | 2018.150.32.52   | 11014544  | 06-Dec-19 | 15:32 | x64      |
| Msolap.dll                                                | 2018.150.32.52   | 8607120   | 06-Dec-19 | 15:32 | x86      |
| Msolui.dll                                                | 2018.150.32.52   | 305552    | 06-Dec-19 | 15:32 | x64      |
| Msolui.dll                                                | 2018.150.32.52   | 285280    | 06-Dec-19 | 15:32 | x86      |
| Powerbiextensions.dll                                     | 2.72.5556.181    | 9252728   | 06-Dec-19 | 15:32 | x86      |
| Private_odbc32.dll                                        | 10.0.14832.1000  | 728440    | 06-Dec-19 | 15:32 | x64      |
| Sqlceip.exe                                               | 15.0.4003.23     | 290616    | 06-Dec-19 | 15:32 | x86      |
| Sqldumper.exe                                             | 2019.150.4003.23 | 159336    | 06-Dec-19 | 15:32 | x86      |
| Sqldumper.exe                                             | 2019.150.4003.23 | 192312    | 06-Dec-19 | 15:32 | x64      |
| System.spatial.netfx35.dll                                | 5.7.0.62516      | 117624    | 06-Dec-19 | 15:32 | x86      |
| Tmapi.dll                                                 | 2018.150.32.52   | 6177160   | 06-Dec-19 | 15:32 | x64      |
| Tmcachemgr.dll                                            | 2018.150.32.52   | 4916616   | 06-Dec-19 | 15:32 | x64      |
| Tmpersistence.dll                                         | 2018.150.32.52   | 1183624   | 06-Dec-19 | 15:32 | x64      |
| Tmtransactions.dll                                        | 2018.150.32.52   | 6806624   | 06-Dec-19 | 15:32 | x64      |
| Xmsrv.dll                                                 | 2018.150.32.52   | 26021264  | 06-Dec-19 | 15:32 | x64      |
| Xmsrv.dll                                                 | 2018.150.32.52   | 35457936  | 06-Dec-19 | 15:32 | x86      |

SQL Server 2019 Database Services Common Core

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.4003.23 | 81720     | 06-Dec-19 | 15:33 | x86      |
| Instapi140.dll | 2019.150.4003.23 | 94008     | 06-Dec-19 | 15:33 | x64      |
| Msasxpress.dll | 2018.150.32.52   | 25992     | 06-Dec-19 | 15:33 | x86      |
| Msasxpress.dll | 2018.150.32.52   | 31120     | 06-Dec-19 | 15:33 | x64      |
| Sqldumper.exe  | 2019.150.4003.23 | 159336    | 06-Dec-19 | 15:33 | x86      |
| Sqldumper.exe  | 2019.150.4003.23 | 192312    | 06-Dec-19 | 15:33 | x64      |

SQL Server 2019 sql_dreplay_client

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.4003.23 | 94008     | 06-Dec-19 | 15:33 | x64      |

SQL Server 2019 sql_dreplay_controller

|    File name   |   File version   | File size |    Date   |  Time | Platform |
|:--------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi140.dll | 2019.150.4003.23 | 94008     | 06-Dec-19 | 15:33 | x64      |

SQL Server 2019 Database Services Core Instance

|            File name           |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Aetm-enclave-simulator.dll     | 2019.150.4003.23 | 4659816   | 06-Dec-19 | 17:34 | x64      |
| Aetm-enclave.dll               | 2019.150.4003.23 | 4603952   | 06-Dec-19 | 17:34 | x64      |
| Aetm-sgx-enclave-simulator.dll | 2019.150.4003.23 | 4925152   | 06-Dec-19 | 17:34 | x64      |
| Aetm-sgx-enclave.dll           | 2019.150.4003.23 | 4866248   | 06-Dec-19 | 17:34 | x64      |
| Azureattest.dll                | 10.0.18965.1000  | 255056    | 06-Dec-19 | 17:34 | x64      |
| Azureattestmanager.dll         | 10.0.18965.1000  | 97528     | 06-Dec-19 | 17:34 | x64      |
| Hkcompile.dll                  | 2019.150.4003.23 | 1298016   | 06-Dec-19 | 17:34 | x64      |
| Hkengine.dll                   | 2019.150.4003.23 | 5791544   | 06-Dec-19 | 17:34 | x64      |
| Hkruntime.dll                  | 2019.150.4003.23 | 188008    | 06-Dec-19 | 17:34 | x64      |
| Hktempdb.dll                   | 2019.150.4003.23 | 69224     | 06-Dec-19 | 17:34 | x64      |
| Qds.dll                        | 2019.150.4003.23 | 1175136   | 06-Dec-19 | 17:34 | x64      |
| Rsfxft.dll                     | 2019.150.4003.23 | 57144     | 06-Dec-19 | 17:34 | x64      |
| Secforwarder.dll               | 2019.150.4003.23 | 85816     | 06-Dec-19 | 17:34 | x64      |
| Sqlaccess.dll                  | 2019.150.4003.23 | 499304    | 06-Dec-19 | 17:34 | x64      |
| Sqlagent.exe                   | 2019.150.4003.23 | 695912    | 06-Dec-19 | 17:34 | x64      |
| Sqlceip.exe                    | 15.0.4003.23     | 290616    | 06-Dec-19 | 17:34 | x86      |
| Sqlctr150.dll                  | 2019.150.4003.23 | 147048    | 06-Dec-19 | 17:34 | x64      |
| Sqlctr150.dll                  | 2019.150.4003.23 | 122464    | 06-Dec-19 | 17:34 | x86      |
| Sqldk.dll                      | 2019.150.4003.23 | 3128936   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 1535800   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 1593144   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 2166584   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 2215736   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3399480   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3485496   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3489592   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3530552   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3567416   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3600184   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3682104   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3800912   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3804984   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3854160   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3891000   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3993392   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 3997496   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 4009776   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 4046648   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 4140856   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 4144952   | 06-Dec-19 | 17:34 | x64      |
| `Sqlevn70.rll`                   | 2019.150.4003.23 | 4263736   | 06-Dec-19 | 17:34 | x64      |
| Sqllang.dll                    | 2019.150.4003.23 | 39472952  | 06-Dec-19 | 17:34 | x64      |
| Sqlmin.dll                     | 2019.150.4003.23 | 39791416  | 06-Dec-19 | 17:34 | x64      |
| Sqlos.dll                      | 2019.150.4003.23 | 53048     | 06-Dec-19 | 17:34 | x64      |
| Sqlscriptdowngrade.dll         | 2019.150.4003.23 | 48952     | 06-Dec-19 | 17:34 | x64      |
| Sqlscriptupgrade.dll           | 2019.150.4003.23 | 5910352   | 06-Dec-19 | 17:34 | x64      |
| Sqlservr.exe                   | 2019.150.4003.23 | 630376    | 06-Dec-19 | 17:34 | x64      |
| Sqltses.dll                    | 2019.150.4003.23 | 9076328   | 06-Dec-19 | 17:34 | x64      |
| Svl.dll                        | 2019.150.4003.23 | 167528    | 06-Dec-19 | 17:34 | x64      |

SQL Server 2019 Database Services Core Shared

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dtsmsg140.dll                                            | 2019.150.4003.23 | 573032    | 06-Dec-19 | 15:31 | x64      |
| Dtspipeline.dll                                          | 2019.150.4003.23 | 1335096   | 06-Dec-19 | 15:31 | x64      |
| Flatfiledest.dll                                         | 2019.150.4003.23 | 417384    | 06-Dec-19 | 15:31 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4003.23 | 433768    | 06-Dec-19 | 15:31 | x64      |
| Logread.exe                                              | 2019.150.4003.23 | 724584    | 06-Dec-19 | 15:31 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4003.23     | 65336     | 06-Dec-19 | 15:31 | x86      |
| Qrdrsvc.exe                                              | 2019.150.4003.23 | 503400    | 06-Dec-19 | 15:31 | x64      |
| Rdistcom.dll                                             | 2019.150.4003.23 | 921192    | 06-Dec-19 | 15:31 | x64      |
| Replmerg.exe                                             | 2019.150.4003.23 | 568936    | 06-Dec-19 | 15:31 | x64      |
| Replprov.dll                                             | 2019.150.4003.23 | 859752    | 06-Dec-19 | 15:31 | x64      |
| Replrec.dll                                              | 2019.150.4003.23 | 1035880   | 06-Dec-19 | 15:31 | x64      |
| Replsub.dll                                              | 2019.150.4003.23 | 478824    | 06-Dec-19 | 15:31 | x64      |
| Spresolv.dll                                             | 2019.150.4003.23 | 282216    | 06-Dec-19 | 15:31 | x64      |

SQL Server 2019 sql_extensibility

|      File name     |   File version   | File size |    Date   |  Time | Platform |
|:------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll | 2019.150.4003.23 | 97888     | 06-Dec-19 | 15:33 | x64      |
| Exthost.exe        | 2019.150.4003.23 | 237160    | 06-Dec-19 | 15:33 | x64      |
| Launchpad.exe      | 2019.150.4003.23 | 1228392   | 06-Dec-19 | 15:33 | x64      |
| Sqlsatellite.dll   | 2019.150.4003.23 | 1027688   | 06-Dec-19 | 15:33 | x64      |

SQL Server 2019 sql_inst_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll | 15.0.4003.23 | 36664     | 06-Dec-19 | 15:33 | x86      |

SQL Server 2019 Integration Services

|                         File name                        |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dtsmsg140.dll                                            | 2019.150.4003.23 | 560952    | 06-Dec-19 | 16:29 | x86      |
| Dtsmsg140.dll                                            | 2019.150.4003.23 | 573032    | 06-Dec-19 | 16:29 | x64      |
| Dtspipeline.dll                                          | 2019.150.4003.23 | 1122104   | 06-Dec-19 | 16:29 | x86      |
| Dtspipeline.dll                                          | 2019.150.4003.23 | 1335096   | 06-Dec-19 | 16:29 | x64      |
| Flatfiledest.dll                                         | 2019.150.4003.23 | 417384    | 06-Dec-19 | 16:29 | x64      |
| Flatfiledest.dll                                         | 2019.150.4003.23 | 364136    | 06-Dec-19 | 16:29 | x86      |
| Flatfilesrc.dll                                          | 2019.150.4003.23 | 433768    | 06-Dec-19 | 16:29 | x64      |
| Flatfilesrc.dll                                          | 2019.150.4003.23 | 376424    | 06-Dec-19 | 16:29 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll | 15.0.4003.23     | 65336     | 06-Dec-19 | 16:29 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4003.23     | 147040    | 06-Dec-19 | 16:29 | x86      |
| Microsoft.sqlserver.scripttask.dll                       | 15.0.4003.23     | 147048    | 06-Dec-19 | 16:29 | x86      |
| Msdtssrvr.exe                                            | 15.0.4003.23     | 225080    | 06-Dec-19 | 16:29 | x64      |
| Msmdpp.dll                                               | 2018.150.32.52   | 10061704  | 06-Dec-19 | 16:29 | x64      |
| Odbcdest.dll                                             | 2019.150.4003.23 | 376424    | 06-Dec-19 | 16:29 | x64      |
| Odbcdest.dll                                             | 2019.150.4003.23 | 323176    | 06-Dec-19 | 16:29 | x86      |
| Odbcsrc.dll                                              | 2019.150.4003.23 | 388704    | 06-Dec-19 | 16:29 | x64      |
| Odbcsrc.dll                                              | 2019.150.4003.23 | 331576    | 06-Dec-19 | 16:29 | x86      |
| Sqlceip.exe                                              | 15.0.4003.23     | 290616    | 06-Dec-19 | 16:29 | x86      |

SQL Server 2019 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 15.0.1815.0      | 557392    | 06-Dec-19 | 17:30 | x86      |
| Dmsnative.dll                                                        | 2018.150.1815.0  | 139088    | 06-Dec-19 | 17:30 | x64      |
| Dwengineservice.dll                                                  | 15.0.1815.0      | 50304     | 06-Dec-19 | 17:30 | x86      |
| Instapi140.dll                                                       | 2019.150.4003.23 | 94008     | 06-Dec-19 | 17:30 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 15.0.1815.0      | 73344     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 15.0.1815.0      | 299136    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 15.0.1815.0      | 1955456   | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 15.0.1815.0      | 176464    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 15.0.1815.0      | 626000    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 15.0.1815.0      | 249680    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 15.0.1815.0      | 144720    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 15.0.1815.0      | 85352     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 15.0.1815.0      | 56960     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 15.0.1815.0      | 94544     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 15.0.1815.0      | 1134208   | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 15.0.1815.0      | 86864     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 15.0.1815.0      | 76416     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 15.0.1815.0      | 41296     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 15.0.1815.0      | 36480     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 15.0.1815.0      | 49792     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 15.0.1815.0      | 27264     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 15.0.1815.0      | 32592     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 15.0.1815.0      | 137552    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 15.0.1815.0      | 92520     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 15.0.1815.0      | 106624    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 15.0.1815.0      | 295040    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 124544    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 141952    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 145024    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 141440    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 153728    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 143480    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 138360    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 179024    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 121976    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 15.0.1815.0      | 140416    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 15.0.1815.0      | 78464     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 15.0.1815.0      | 27776     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 15.0.1815.0      | 43136     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 15.0.1815.0      | 134272    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 15.0.1815.0      | 3034448   | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 15.0.1815.0      | 3958912   | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 124240    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 139088    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 143720    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 139600    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 154448    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 139904    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 136528    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 176976    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 121168    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 15.0.1815.0      | 138064    | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 15.0.1815.0      | 72320     | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 15.0.1815.0      | 2688128   | 06-Dec-19 | 17:30 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 15.0.1815.0      | 2442880   | 06-Dec-19 | 17:30 | x86      |
| Mpdwinterop.dll                                                      | 2019.150.4003.23 | 458336    | 06-Dec-19 | 17:30 | x64      |
| Mpdwsvc.exe                                                          | 2019.150.4003.23 | 7380792   | 06-Dec-19 | 17:30 | x64      |
| Secforwarder.dll                                                     | 2019.150.4003.23 | 85816     | 06-Dec-19 | 17:30 | x64      |
| Sharedmemory.dll                                                     | 2018.150.1815.0  | 66688     | 06-Dec-19 | 17:30 | x64      |
| Sqldk.dll                                                            | 2019.150.4003.23 | 3128936   | 06-Dec-19 | 17:30 | x64      |
| Sqldumper.exe                                                        | 2019.150.4003.23 | 192312    | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 1593144   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 4144952   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 3399480   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 4140856   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 4046648   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 2215736   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 2166584   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 3804984   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 3800912   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 1535800   | 06-Dec-19 | 17:30 | x64      |
| `Sqlevn70.rll`                                                         | 2019.150.4003.23 | 4009776   | 06-Dec-19 | 17:30 | x64      |
| Sqlos.dll                                                            | 2019.150.4003.23 | 53048     | 06-Dec-19 | 17:30 | x64      |
| Sqlsortpdw.dll                                                       | 2018.150.1815.0  | 4846928   | 06-Dec-19 | 17:30 | x64      |
| Sqltses.dll                                                          | 2019.150.4003.23 | 9076328   | 06-Dec-19 | 17:30 | x64      |

SQL Server 2019 sql_shared_mr

|  File name | File version | File size |    Date   |  Time | Platform |
|:----------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll | 15.0.4003.23 | 36664     | 06-Dec-19 | 15:33 | x86      |

SQL Server 2019 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dtsmsg140.dll                                  | 2019.150.4003.23 | 560952    | 06-Dec-19 | 15:55 | x86      |
| Dtsmsg140.dll                                  | 2019.150.4003.23 | 573032    | 06-Dec-19 | 15:55 | x64      |
| Dtspipeline.dll                                | 2019.150.4003.23 | 1335096   | 06-Dec-19 | 15:55 | x64      |
| Dtspipeline.dll                                | 2019.150.4003.23 | 1122104   | 06-Dec-19 | 15:55 | x86      |
| Flatfiledest.dll                               | 2019.150.4003.23 | 364136    | 06-Dec-19 | 15:55 | x86      |
| Flatfiledest.dll                               | 2019.150.4003.23 | 417384    | 06-Dec-19 | 15:55 | x64      |
| Flatfilesrc.dll                                | 2019.150.4003.23 | 376424    | 06-Dec-19 | 15:55 | x86      |
| Flatfilesrc.dll                                | 2019.150.4003.23 | 433768    | 06-Dec-19 | 15:55 | x64      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 15.0.4003.23     | 409400    | 06-Dec-19 | 15:55 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 15.0.4003.23     | 3006264   | 06-Dec-19 | 15:55 | x86      |
| Msmgdsrv.dll                                   | 2018.150.32.52   | 8278416   | 06-Dec-19 | 15:55 | x86      |

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
