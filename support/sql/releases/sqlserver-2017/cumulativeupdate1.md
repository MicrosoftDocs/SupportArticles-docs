---
title: Cumulative update 1 for SQL Server 2017 (KB4038634)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 1 (KB4038634).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4038634, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4038634 - Cumulative Update 1 for SQL Server 2017

_Release Date:_ &nbsp; October 24, 2017  
_Version:_ &nbsp; 14.0.3006.16

## Summary

This article describes Cumulative Update package 1 (CU1) for Microsoft SQL Server 2017. This update contains 71 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 RTM, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3006.16**, file version: **2017.140.3006.16**
- Analysis Services - Product version: **14.0.1.439**, file version: **2017.140.1.439**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix Area | Component | Platform |
|---|---|---|---|---|
| <a id="10682349">[10682349](#10682349)</a> | [FIX: SSAS crashes when you access .vmp files in SQL Server 2017 and SQL Server 2016 (KB4024023)](https://support.microsoft.com/help/4024023) | Analysis Services | Analysis Services | All |
| <a id="10682367">[10682367](#10682367)</a> | [FIX: SSAS crashes when you run a DAX or MDX query in SSAS in Tabular mode (KB4032543)](https://support.microsoft.com/help/4032543) | Analysis Services | Analysis Services | All |
| <a id="10687745">[10687745](#10687745)</a> | [FIX: Dimension security is ignored by Power BI Desktop in SQL Server Analysis Services (Multidimensional model) (KB4018908)](https://support.microsoft.com/help/4018908) | Analysis Services | Analysis Services | All |
| <a id="10687757">[10687757](#10687757)</a> | [FIX: SSAS crashes when you execute an MDX query that refers to a calculated member which is a child member of another hierarchy (KB4022753)](https://support.microsoft.com/help/4022753) | Analysis Services | Analysis Services | All |
| <a id="10687784">[10687784](#10687784)</a> | [FIX: Security Bulletin MS16-136 breaks the SSRS data source type in PowerPivot in SQL Server 2017 and SQL Server 2016 (KB4025402)](https://support.microsoft.com/help/4025402) | Analysis Services | Analysis Services | All |
| <a id="10868739">[10868739](#10868739)</a> | [FIX: SSAS crashes when you process an SSAS database or cube in SQL Server 2014 or 2017 (KB4039509)](https://support.microsoft.com/help/4039509) | Analysis Services | Analysis Services | Windows |
| <a id="10868754">[10868754](#10868754)</a> | [FIX: A memory leak may occur when you perform Process Update operations in SSAS (KB4033789)](https://support.microsoft.com/help/4033789) | Analysis Services | Analysis Services | Windows |
| <a id="10868777">[10868777](#10868777)</a> | [FIX: SQL Server 2016 or 2017 Analysis Services may crash in a specific situation (KB3208545)](https://support.microsoft.com/help/3208545) | Analysis Services | Analysis Services | Windows |
| <a id="10965958">[10965958](#10965958)</a> | [FIX: An unexpected exception error occurs when an XIRR measure processes too many records in SSAS 2016 or 2017 (KB4034789)](https://support.microsoft.com/help/4034789) | Analysis Services | Analysis Services | Windows |
| <a id="10965991">[10965991](#10965991)</a> | [FIX: "Ambiguous paths" error when deploying tabular model database to Analysis Services in SQL Server 2016 or 2017 (KB4040085)](https://support.microsoft.com/help/4040085) | Analysis Services | Analysis Services | Windows |
| <a id="10682338">[10682338](#10682338)</a> | FIX: Incorrect MDX query results if a table cross join is run on a table hierarchy member in SSAS (KB4022594) | Analysis Services | Analysis Services | All |
| <a id="10682343">[10682343](#10682343)</a> | FIX: SSAS crashes when a measure is added that refers to null values in Power BI (KB4021994) | Analysis Services | Analysis Services | All |
| <a id="10682356">[10682356](#10682356)</a> | FIX: SSAS crashes when a numeric calculated column must change its encoding scheme during the `ProcessRecalc` phase (KB3212541) | Analysis Services | Analysis Services | All |
| <a id="10868755">[10868755](#10868755)</a> | [FIX: An error occurs when you export a Reporting Services report to PDF in SQL Server 2017 (KB4040512)](https://support.microsoft.com/help/4040512) | Analysis Services | Reporting Services | All |
| <a id="10965982">[10965982](#10965982)</a> | [FIX: Memory spike in LSASS.EXE when you enable Basic Authentication mode in SSRS 2016 or 2017 (KB4039124)](https://support.microsoft.com/help/4039124) | Analysis Services | Reporting Services | Windows |
| <a id="10965994">[10965994](#10965994)</a> | [FIX: Error when you export an SSRS report on an iOS device in SQL Server 2016 or 2017 (KB4043478)](https://support.microsoft.com/help/4043478) | Analysis Services | Reporting Services | Windows |
| <a id="10965998">[10965998](#10965998)</a> | [FIX: Horizontal scroll bar missing from Subscription page in SSRS 2016 or 2017 web portal (KB4039126)](https://support.microsoft.com/help/4039126) | Analysis Services | Reporting Services | Windows |
| <a id="10965999">[10965999](#10965999)</a> | [FIX: "The folder ... does not exist" error when deleting a folder in web portal of SQL Server 2017 Reporting Service (KB4039125)](https://support.microsoft.com/help/4039125) | Analysis Services | Reporting Services | Windows |
| <a id="10966008">[10966008](#10966008)</a> | [FIX: Report Viewer Web Part doesn't allow a full vertical scrollbar after you set a specific web part height (KB4039058)](https://support.microsoft.com/help/4039058) | Analysis Services | Reporting Services | Windows |
| <a id="10729322">[10729322](#10729322)</a> | FIX: Reporting Services "SortExpression" causes `rsComparisonError` when there's a `NULL` value in a column set as "`DataTimeOffset`" (KB4017827) | Analysis Services | Reporting Services | Windows |
| <a id="10868736">[10868736](#10868736)</a> | [FIX: Error when you export a DQS knowledge base that contains domains in the DQS client in SQL Server 2014 or 2017 (KB4022483)](https://support.microsoft.com/help/4022483) | Data Quality Services | Import-Export | Windows |
| <a id="10966015">[10966015](#10966015)</a> | [FIX: SSIS package that contains German umlauts characters fails on execution after Incremental Package Deployment in SQL Server 2016 or 2017 (KB4038590)](https://support.microsoft.com/help/4038590) | Integration Services | Tools | Windows |
| <a id="10867556">[10867556](#10867556)</a> | [FIX: Excel crashes when you save a workbook as a PDF file by using the Adobe Acrobat PDFMaker add-in if the MDS add-in for Excel in SQL Server is also installed (KB4022895)](https://support.microsoft.com/help/4022895) | Master Data Services | Client | Windows |
| <a id="10687776">[10687776](#10687776)</a> | [FIX: Expanding the Entities folder on the Manage Groups page takes a long time in SQL Server 2017 MDS and SQL Server 2016 MDS (KB4023865)](https://support.microsoft.com/help/4023865) | Master Data Services | Server | All |
| <a id="10682313">[10682313](#10682313)</a> | FIX: Load data from staging tables takes a much longer time to finish when recursive hierarchy is used in Master Data Services (KB4043103) | Master Data Services | Server | All |
| <a id="10986691">[10986691](#10986691)</a> | [FIX: An unexpected error occurs when you use DReplay feature to replay a captured trace in SQL Server 2017 (KB4045678)](https://support.microsoft.com/help/4045678) | SQL Server Client Tools | Database Performance Tools | Windows |
| <a id="10270905">[10270905](#10270905)</a> | [FIX: Backup of availability database via VSS-based application may fail in SQL Server (KB4040108)](https://support.microsoft.com/help/4040108) | SQL Server Engine | Backup Restore | All |
| <a id="10868723">[10868723](#10868723)</a> | [FIX: SQL Server Managed Backup doesn't delete old backups that are beyond the retention period in SQL Server 2014 or 2017 (KB4038882)](https://support.microsoft.com/help/4038882) | SQL Server Engine | Backup Restore | Windows |
| <a id="10868726">[10868726](#10868726)</a> | [FIX: Managed Backup fails intermittently because of SQLVDI error in SQL Server 2014 or 2017 (KB4039511)](https://support.microsoft.com/help/4039511) | SQL Server Engine | Backup Restore | Windows |
| <a id="10868733">[10868733](#10868733)</a> | [FIX: Managed Backup to Microsoft Azure stops after large database backup in SQL Server 2014 or 2017 (KB4040376)](https://support.microsoft.com/help/4040376) | SQL Server Engine | Backup Restore | Windows |
| <a id="10966001">[10966001](#10966001)</a> | [FIX: Constraint violation error returned by the managed_backup.fn_available_backups function after you install the Cumulative Update 2 for SQL Server 2016 SP1 (KB4040531)](https://support.microsoft.com/help/4040531) | SQL Server Engine | Backup Restore | Windows |
| <a id="10966019">[10966019](#10966019)</a> | [FIX: SQL Server Managed Backups don't run a scheduled log backup in SQL Server 2016 or 2017 (KB4040535)](https://support.microsoft.com/help/4040535) | SQL Server Engine | Backup Restore | Windows |
| <a id="10965952">[10965952](#10965952)</a> | [Update to improve the performance for columnstore dynamic management views "column_store_row_groups" and "dm_db_column_store_row_group_physical_stats" in SQL Server 2016 or 2017 (KB4024860)](https://support.microsoft.com/help/4024860) | SQL Server Engine | Column Stores | All |
| <a id="10936099">[10936099](#10936099)</a> | [Update to enable SQL Server 2017 Express edition to act as a witness role in a database mirroring session (KB4045687)](https://support.microsoft.com/help/4045687) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="10921835">[10921835](#10921835)</a> | [FIX: Memory corruption occurs during availability group failovers for DTC transactions in SQL Server 2017 (KB4046065)](https://support.microsoft.com/help/4046065) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="10936097">[10936097](#10936097)</a> | [FIX: SQL Server 2017 reports that all transactions are completed even though some transactions encounter failures while trying to commit (KB4046066)](https://support.microsoft.com/help/4046066) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="10965980">[10965980](#10965980)</a> | [FIX: Database mirroring failover fails with error 3456 in SQL Server 2016 or 2017 (KB4042251)](https://support.microsoft.com/help/4042251) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="10965988">[10965988](#10965988)</a> | [FIX: Automatic seeding in Availability Groups randomly causes error 41169 in SQL Server 2016 or 2017 (KB4040519)](https://support.microsoft.com/help/4040519) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="10936183">[10936183](#10936183)</a> | [FIX: Performance drop when using In-Memory OLTP with Always On availability groups in SQL Server 2016 or 2017 (KB4039868)](https://support.microsoft.com/help/4039868) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="10936185">[10936185](#10936185)</a> | [FIX: Incorrect behavior when you use memory-optimized tables with "where exists" statement in SQL Server 2016 or 2017 (KB4039776)](https://support.microsoft.com/help/4039776) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="10985578">[10985578](#10985578)</a> | [FIX: Error occurs on passing memory-optimized table into inline table-valued function when called from stored procedure in SQL Server 2017 (KB4045329)](https://support.microsoft.com/help/4045329) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="11000432">[11000432](#11000432)</a> | [FIX: An assertion error occurs within minutes or hours after you create a snapshot backup for a database that contains memory-optimized tables in SQL Server 2017 (KB4046099)](https://support.microsoft.com/help/4046099) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="10749795">[10749795](#10749795)</a> | [FIX: Portability and performance differ between Windows and Linux scheduler mappings in SQL Server 2017 (KB4043455)](https://support.microsoft.com/help/4043455) | SQL Server Engine | Linux | Linux |
| <a id="11080104">[11080104](#11080104)</a> | [FIX: DST changes of Sao Paulo time zone aren't determined by SQL Server 2017 on Linux (KB4052938)](https://support.microsoft.com/help/4052938) | SQL Server Engine | Linux | Linux |
| <a id="10966010">[10966010](#10966010)</a> | [FIX: Log chain break in the "managed_backup.fn_available_backups" table in SQL Server 2016 or 2017 (KB4040530)](https://support.microsoft.com/help/4040530) | SQL Server Engine | Management Services | Windows |
| <a id="10936563">[10936563](#10936563)</a> | [FIX: EXCEPTION_ACCESS_VIOLATION error when you execute the sys.sp_MScdc_capture_job stored procedure in SQL Server (KB4039089)](https://support.microsoft.com/help/4039089) | SQL Server Engine | Metadata | All |
| <a id="10938809">[10938809](#10938809)</a> | [FIX: A deadlock condition occurs when you create a new database in SQL Server 2017 (KB4044009)](https://support.microsoft.com/help/4044009) | SQL Server Engine | Metadata | Windows |
| <a id="10070694">[10070694](#10070694)</a> | [FIX: Queries against PolyBase external tables return duplicate rows in SQL Server 2017 and SQL Server 2016 (KB4019840)](https://support.microsoft.com/help/4019840) | SQL Server Engine | PolyBase | All |
| <a id="10965984">[10965984](#10965984)</a> | [FIX: Access violation occurs when a DDL trigger is raised by the CREATE EXTERNAL TABLE command in SQL Server 2016 or 2017 (KB4039966)](https://support.microsoft.com/help/4039966) | SQL Server Engine | PolyBase | Windows |
| <a id="10965968">[10965968](#10965968)</a> | [FIX: Returns incorrect results when computed column is queried after installing hotfix that's described in KB 3213683 and enabling TF 176 in SQL Server 2016 or 2017 (KB4040533)](https://support.microsoft.com/help/4040533) | SQL Server Engine | Programmability | All |
| <a id="10966016">[10966016](#10966016)</a> | [FIX: SSIS package doesn't start when it's run by a CLR stored procedure whose user doesn't have SYSADMIN permissions (KB4039736)](https://support.microsoft.com/help/4039736) | SQL Server Engine | Programmability | Windows |
| <a id="10867554">[10867554](#10867554)</a> | FIX: Remote instance of SQL Server crashes while executing a stored procedure that bulk loads an incomplete data file into a temporary table (KB4043459) | SQL Server Engine | Programmability | Windows |
| <a id="10966009">[10966009](#10966009)</a> | [FIX: EXCEPTION_ACCESS_VIOLATION for query using sys.dm_os_memory_objects statement in SQL Server 2016 or 2017 (KB4038113)](https://support.microsoft.com/help/4038113) | SQL Server Engine | Query Execution | Windows |
| <a id="9704947">[9704947](#9704947)</a> | [Enhancement: New keyword is added to CREATE and UPDATE STATISTICS statements to persist sampling rate for future statistics updates in SQL Server (KB4039284)](https://support.microsoft.com/help/4039284) | SQL Server Engine | Query Optimizer | All |
| <a id="10889338">[10889338](#10889338)</a> | [FIX: A divide-by-zero error occurs when a parallel query is forced to run in a serial mode in SQL Server 2017 (KB4042885)](https://support.microsoft.com/help/4042885) | SQL Server Engine | Query Optimizer | Windows |
| <a id="11003299">[11003299](#11003299)</a> | [FIX: FORCE_LAST_GOOD_PLAN recommendation is stuck in "Verifying" state upon first verification in SQL Server 2017 (KB4046055)](https://support.microsoft.com/help/4046055) | SQL Server Engine | Query Store | Windows |
| <a id="11003402">[11003402](#11003402)</a> | [FIX: Automatic tuning settings can't be configured on ModelDB in SQL Server 2017 (KB4046022)](https://support.microsoft.com/help/4046022) | SQL Server Engine | Query Store | Windows |
| <a id="10691456">[10691456](#10691456)</a> | [FIX: Unable to drop stored procedure execution article from P2P publication in SQL Server (KB4023926)](https://support.microsoft.com/help/4023926) | SQL Server Engine | Replication | Windows |
| <a id="10691460">[10691460](#10691460)</a> | [FIX: Can't disable "change data capture" if any column is encrypted by "Always Encrypted" feature in SQL Server (KB4034376)](https://support.microsoft.com/help/4034376) | SQL Server Engine | Replication | All |
| <a id="10978904">[10978904](#10978904)</a> | [FIX: Change Tracking manual cleanup fails with table non-existence error in SQL Server 2014 and 2017 (KB4043624)](https://support.microsoft.com/help/4043624) | SQL Server Engine | Replication | All |
| <a id="10687780">[10687780](#10687780)</a> | [FIX: A data mask on a floating points column isn't applied in SQL Server 2017 and SQL Server 2016 (KB4023995)](https://support.microsoft.com/help/4023995) | SQL Server Engine | Security Infrastructure | All |
| <a id="10867553">[10867553](#10867553)</a> | [FIX: SUSER_SNAME function returns different results between SQL Server 2014 and SQL Server 2016 or 2017 (KB4025020)](https://support.microsoft.com/help/4025020) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="10982548">[10982548](#10982548)</a> | [FIX: Execution fails when a SQL CLR function invokes Transact-SQL statements through impersonation calls in SQL Server 2017 (KB4046918)](https://support.microsoft.com/help/4046918) | SQL Server Engine | Security Infrastructure | All |
| <a id="10868749">[10868749](#10868749)</a> | [FIX: Access violation for spatial datatypes query via linked server in SQL Server 2014 or 2017 (KB4040401)](https://support.microsoft.com/help/4040401) | SQL Server Engine | SQL OS | Windows |
| <a id="11008122">[11008122](#11008122)</a> | [Update to enable the new dynamic management views and functions in SQL Server 2017 (KB4046638)](https://support.microsoft.com/help/4046638) | SQL Server Engine | Storage Management | Windows |
| <a id="10870647">[10870647](#10870647)</a> | [FIX: Couldn't truncate a partition of the partitioned table if it contains an extended or XML index in SQL Server 2016 or 2017 (KB4024622)](https://support.microsoft.com/help/4024622) | SQL Server Engine | Table Index Partition | Windows |
| <a id="10998915">[10998915](#10998915)</a> | [FIX: DML statements that use cascading operations fail in SQL Server 2017 (KB4046744)](https://support.microsoft.com/help/4046744) | SQL Server Engine | Temporal | Windows |
| <a id="10865727">[10865727](#10865727)</a> | [FIX: Assertion error occurs on the secondary replica when you resume a suspended availability database in SQL Server 2016 or 2017 (KB4024393)](https://support.microsoft.com/help/4024393) | SQL Server Engine | Transaction Services | Windows |
| <a id="10936411">[10936411](#10936411)</a> | [FIX: Indirect checkpoints on tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 or 2017 (KB4040276)](https://support.microsoft.com/help/4040276) | SQL Server Engine | Transaction Services | Windows |
| <a id="10868768">[10868768](#10868768)</a> | [FIX: Access violation occurs when you use sp_xml_preparedocument to open XML documents in SQL Server 2014 or 2017 (KB4039510)](https://support.microsoft.com/help/4039510) | SQL Server Engine | XML | Windows |
| <a id="10998673">[10998673](#10998673)</a> | [FIX: Unable to install SQL Server 2017 when instance name/ID/installation path contains multi-byte characters (KB4046044)](https://support.microsoft.com/help/4046044) | SQL Setup | Deployment Platform | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU1 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2017/12/sqlserver2017-kb4038634-x64_a75ab79103d72ce094866404607c2e84ae777d43.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4038634-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4038634-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4038634-x64.exe| C1187BF68AC07294D8242C4126F021D3BEEF561F86931A8229B3D4AE86993A73 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                  File name                  |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.server.core.dll  | 14.0.1.439       | 1380512   | 01-Oct-17 | 22:06 | x86      |
| Microsoft.data.mashup.dll                   | 2.49.4831.201    | 174816    | 01-Oct-17 | 20:52 | x86      |
| Microsoft.data.mashup.oledb.dll             | 2.49.4831.201    | 36576     | 01-Oct-17 | 20:52 | x86      |
| Microsoft.data.mashup.preview.dll           | 2.49.4831.201    | 48864     | 01-Oct-17 | 20:52 | x86      |
| Microsoft.data.mashup.providercommon.dll    | 2.49.4831.201    | 105184    | 01-Oct-17 | 20:52 | x86      |
| Microsoft.hostintegration.connectors.dll    | 2.49.4831.201    | 5167328   | 01-Oct-17 | 20:52 | x86      |
| Microsoft.mashup.container.exe              | 2.49.4831.201    | 26336     | 01-Oct-17 | 20:52 | x64      |
| Microsoft.mashup.container.netfx40.exe      | 2.49.4831.201    | 26848     | 01-Oct-17 | 20:52 | x64      |
| Microsoft.mashup.container.netfx45.exe      | 2.49.4831.201    | 26848     | 19-Oct-17 | 12:13 | x64      |
| Microsoft.mashup.eventsource.dll            | 2.49.4831.201    | 159456    | 01-Oct-17 | 20:52 | x86      |
| Microsoft.mashup.oauth.dll                  | 2.49.4831.201    | 82656     | 01-Oct-17 | 20:52 | x86      |
| Microsoft.mashup.oledbprovider.dll          | 2.49.4831.201    | 67296     | 19-Oct-17 | 12:13 | x86      |
| Microsoft.mashup.shims.dll                  | 2.49.4831.201    | 25824     | 01-Oct-17 | 20:52 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll | 1.0.0.0          | 151264    | 01-Oct-17 | 20:52 | x86      |
| Microsoft.mashupengine.dll                  | 2.49.4831.201    | 13032160  | 01-Oct-17 | 20:52 | x86      |
| Microsoft.powerbi.adomdclient.dll           | 14.0.1.484       | 1044672   | 01-Oct-17 | 20:52 | x86      |
| Msmdlocal.dll                               | 2017.140.1.439   | 40357024  | 01-Oct-17 | 22:06 | x86      |
| Msmdlocal.dll                               | 2017.140.1.439   | 59898528  | 19-Oct-17 | 12:22 | x64      |
| Msmdpump.dll                                | 2017.140.1.439   | 8544416   | 19-Oct-17 | 12:22 | x64      |
| Msmdsrv.exe                                 | 2017.140.1.439   | 60589352  | 01-Oct-17 | 22:07 | x64      |
| Msmgdsrv.dll                                | 2017.140.1.439   | 8208544   | 01-Oct-17 | 22:07 | x64      |
| Msmgdsrv.dll                                | 2017.140.1.439   | 7310496   | 19-Oct-17 | 12:15 | x86      |
| Powerbiextensions.dll                       | 2.49.4831.201    | 5316832   | 01-Oct-17 | 20:52 | x64      |
| Sql_as_keyfile.dll                          | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlboot.dll                                 | 2017.140.3006.16 | 194720    | 19-Oct-17 | 11:08 | x64      |
| Sqlceip.exe                                 | 14.0.3006.16     | 249504    | 19-Oct-17 | 12:18 | x86      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.analysisservices.adomdclient.dll | 14.0.1.439       | 1088672   | 01-Oct-17 | 22:04 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.1.439       | 1088672   | 01-Oct-17 | 22:06 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.1.439       | 1380648   | 01-Oct-17 | 22:04 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.1.439       | 741536    | 01-Oct-17 | 22:04 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.1.439       | 741536    | 01-Oct-17 | 22:06 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3006.16 | 66720     | 19-Oct-17 | 12:19 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3006.16 | 80544     | 19-Oct-17 | 12:22 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlftacct.dll                              | 2017.140.3006.16 | 53920     | 19-Oct-17 | 11:09 | x86      |
| Sqlftacct.dll                              | 2017.140.3006.16 | 61088     | 19-Oct-17 | 12:22 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3006.16 | 371864    | 19-Oct-17 | 12:15 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3006.16 | 414880    | 19-Oct-17 | 12:21 | x64      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Datacollectorcontroller.dll                  | 2017.140.3006.16 | 224928    | 19-Oct-17 | 11:08 | x64      |
| Fssres.dll                                   | 2017.140.3006.16 | 88224     | 19-Oct-17 | 12:21 | x64      |
| Hadrres.dll                                  | 2017.140.3006.16 | 186528    | 19-Oct-17 | 12:21 | x64      |
| Hkcompile.dll                                | 2017.140.3006.16 | 1421472   | 19-Oct-17 | 11:08 | x64      |
| Hkengine.dll                                 | 2017.140.3006.16 | 5858464   | 19-Oct-17 | 11:08 | x64      |
| Hkruntime.dll                                | 2017.140.3006.16 | 161952    | 19-Oct-17 | 12:21 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.1.439       | 740136    | 19-Oct-17 | 12:20 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3006.16     | 237216    | 19-Oct-17 | 12:20 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3006.16     | 79520     | 19-Oct-17 | 12:09 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3006.16 | 303776    | 19-Oct-17 | 11:02 | x64      |
| Qds.dll                                      | 2017.140.3006.16 | 1164448   | 19-Oct-17 | 14:38 | x64      |
| Sqagtres.dll                                 | 2017.140.3006.16 | 72864     | 19-Oct-17 | 12:22 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlaccess.dll                                | 2017.140.3006.16 | 474784    | 19-Oct-17 | 11:08 | x64      |
| Sqlagent.exe                                 | 2017.140.3006.16 | 578720    | 19-Oct-17 | 12:21 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3006.16 | 60576     | 19-Oct-17 | 11:08 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3006.16 | 51872     | 19-Oct-17 | 12:15 | x86      |
| Sqlboot.dll                                  | 2017.140.3006.16 | 194720    | 19-Oct-17 | 11:08 | x64      |
| Sqlceip.exe                                  | 14.0.3006.16     | 249504    | 19-Oct-17 | 12:18 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3006.16 | 71840     | 19-Oct-17 | 12:21 | x64      |
| Sqldk.dll                                    | 2017.140.3006.16 | 2789024   | 19-Oct-17 | 14:38 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3288224   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3587232   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 1441440   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 2084512   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3205792   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3329696   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3769504   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3907232   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3904160   | 19-Oct-17 | 11:02 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 2031264   | 19-Oct-17 | 11:02 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 4015264   | 19-Oct-17 | 11:02 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3472032   | 19-Oct-17 | 11:03 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3776672   | 19-Oct-17 | 11:03 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3358368   | 19-Oct-17 | 11:03 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3282592   | 19-Oct-17 | 11:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3625632   | 19-Oct-17 | 11:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3393184   | 19-Oct-17 | 11:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3579032   | 19-Oct-17 | 11:04 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3666592   | 19-Oct-17 | 11:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 1494176   | 19-Oct-17 | 11:05 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3810976   | 19-Oct-17 | 11:06 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3006.16 | 3775136   | 19-Oct-17 | 11:07 | x64      |
| Sqllang.dll                                  | 2017.140.3006.16 | 41170080  | 19-Oct-17 | 14:57 | x64      |
| Sqlmin.dll                                   | 2017.140.3006.16 | 40221344  | 19-Oct-17 | 14:50 | x64      |
| Sqlolapss.dll                                | 2017.140.3006.16 | 106656    | 19-Oct-17 | 11:08 | x64      |
| Sqlos.dll                                    | 2017.140.3006.16 | 26272     | 19-Oct-17 | 11:03 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3006.16 | 66720     | 19-Oct-17 | 12:21 | x64      |
| Sqlrepss.dll                                 | 2017.140.3006.16 | 63136     | 19-Oct-17 | 12:21 | x64      |
| Sqlscm.dll                                   | 2017.140.3006.16 | 69280     | 19-Oct-17 | 11:08 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3006.16 | 27800     | 19-Oct-17 | 11:08 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3006.16 | 5871264   | 19-Oct-17 | 09:52 | x64      |
| Sqlservr.exe                                 | 2017.140.3006.16 | 485024    | 19-Oct-17 | 14:38 | x64      |
| Sqlsvc.dll                                   | 2017.140.3006.16 | 160416    | 19-Oct-17 | 12:21 | x64      |
| Sqltses.dll                                  | 2017.140.3006.16 | 9536160   | 19-Oct-17 | 14:38 | x64      |
| Sqsrvres.dll                                 | 2017.140.3006.16 | 259744    | 19-Oct-17 | 12:22 | x64      |
| Svl.dll                                      | 2017.140.3006.16 | 153760    | 19-Oct-17 | 12:22 | x64      |
| Xpadsi.exe                                   | 2017.140.3006.16 | 88224     | 19-Oct-17 | 12:21 | x64      |
| Xplog70.dll                                  | 2017.140.3006.16 | 74400     | 19-Oct-17 | 12:22 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3006.16 | 32416     | 19-Oct-17 | 12:22 | x64      |
| Xpstar.dll                                   | 2017.140.3006.16 | 436384    | 19-Oct-17 | 12:21 | x64      |

SQL Server 2017 Database Services Core Shared

|                   File name                  |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                      | 2017.140.3006.16 | 2996896   | 19-Oct-17 | 12:19 | x64      |
| Dtsconn.dll                                  | 2017.140.3006.16 | 495264    | 19-Oct-17 | 12:19 | x64      |
| Dtshost.exe                                  | 2017.140.3006.16 | 103072    | 19-Oct-17 | 12:21 | x64      |
| Dtspipeline.dll                              | 2017.140.3006.16 | 1264288   | 19-Oct-17 | 12:19 | x64      |
| Dtutil.exe                                   | 2017.140.3006.16 | 145568    | 19-Oct-17 | 12:19 | x64      |
| Microsoft.analysisservices.applocal.core.dll | 14.0.1.439       | 1381536   | 01-Oct-17 | 22:06 | x86      |
| Msxmlsql.dll                                 | 2017.140.3006.16 | 1450656   | 19-Oct-17 | 11:08 | x64      |
| Sql_engine_core_shared_keyfile.dll           | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlscm.dll                                   | 2017.140.3006.16 | 59544     | 19-Oct-17 | 11:01 | x86      |
| Sqlscm.dll                                   | 2017.140.3006.16 | 69280     | 19-Oct-17 | 11:08 | x64      |
| Sqlsvc.dll                                   | 2017.140.3006.16 | 133280    | 19-Oct-17 | 11:01 | x86      |
| Sqlsvc.dll                                   | 2017.140.3006.16 | 160416    | 19-Oct-17 | 12:21 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3006.16 | 1121440   | 19-Oct-17 | 12:21 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlsatellite.dll              | 2017.140.3006.16 | 918688    | 19-Oct-17 | 12:22 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version   | File size |    Date   |  Time | Platform |
|:------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3006.16 | 665760    | 19-Oct-17 | 11:08 | x64      |
| Fdhost.exe               | 2017.140.3006.16 | 113312    | 19-Oct-17 | 12:21 | x64      |
| Fdlauncher.exe           | 2017.140.3006.16 | 61600     | 19-Oct-17 | 11:08 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlft140ph.dll           | 2017.140.3006.16 | 66208     | 19-Oct-17 | 11:08 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version   | File size |    Date   |  Time | Platform |
|:-----------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3006.16     | 23712     | 19-Oct-17 | 11:08 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version   | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.70         | 75248     | 15-Sep-17 | 06:38 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.70         | 36336     | 15-Sep-17 | 06:38 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.70         | 76272     | 19-Oct-17 | 12:10 | x86      |
| Dts.dll                                                       | 2017.140.3006.16 | 2548384   | 19-Oct-17 | 11:01 | x86      |
| Dts.dll                                                       | 2017.140.3006.16 | 2996896   | 19-Oct-17 | 12:19 | x64      |
| Dtsconn.dll                                                   | 2017.140.3006.16 | 397984    | 19-Oct-17 | 11:01 | x86      |
| Dtsconn.dll                                                   | 2017.140.3006.16 | 495264    | 19-Oct-17 | 12:19 | x64      |
| Dtshost.exe                                                   | 2017.140.3006.16 | 88224     | 19-Oct-17 | 12:15 | x86      |
| Dtshost.exe                                                   | 2017.140.3006.16 | 103072    | 19-Oct-17 | 12:21 | x64      |
| Dtspipeline.dll                                               | 2017.140.3006.16 | 1057440   | 19-Oct-17 | 12:10 | x86      |
| Dtspipeline.dll                                               | 2017.140.3006.16 | 1264288   | 19-Oct-17 | 12:19 | x64      |
| Dtutil.exe                                                    | 2017.140.3006.16 | 125088    | 19-Oct-17 | 11:01 | x86      |
| Dtutil.exe                                                    | 2017.140.3006.16 | 145568    | 19-Oct-17 | 12:19 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3006.16     | 477344    | 19-Oct-17 | 12:58 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3006.16     | 476832    | 19-Oct-17 | 13:08 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.1.439       | 1381536   | 01-Oct-17 | 22:04 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.1.439       | 1381536   | 01-Oct-17 | 22:06 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3006.16     | 493728    | 19-Oct-17 | 09:51 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3006.16     | 493728    | 19-Oct-17 | 11:08 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3006.16     | 83616     | 19-Oct-17 | 12:15 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3006.16     | 83616     | 19-Oct-17 | 12:20 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3006.16     | 415392    | 19-Oct-17 | 12:42 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3006.16     | 415392    | 19-Oct-17 | 12:59 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3006.16     | 219808    | 19-Oct-17 | 12:21 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlceip.exe                                                   | 14.0.3006.16     | 249504    | 19-Oct-17 | 12:18 | x86      |

SQL Server 2017 sql_polybase_core_inst

|   File name  |   File version   | File size |    Date   |  Time | Platform |
|:------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| `Sqlevn70.rll` | 2017.140.3006.16 | 1494176   | 19-Oct-17 | 11:05 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3904160   | 19-Oct-17 | 11:02 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3205792   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3907232   | 19-Oct-17 | 11:01 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3810976   | 19-Oct-17 | 11:06 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 2084512   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 2031264   | 19-Oct-17 | 11:02 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3579032   | 19-Oct-17 | 11:04 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3587232   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 1441440   | 19-Oct-17 | 11:00 | x64      |
| `Sqlevn70.rll` | 2017.140.3006.16 | 3775136   | 19-Oct-17 | 11:07 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3006.16     | 23712     | 19-Oct-17 | 11:08 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |

SQL Server 2017 sql_tools_extensions

|                    File name                   |   File version   | File size |    Date   |  Time | Platform |
|:----------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dts.dll                                        | 2017.140.3006.16 | 2548384   | 19-Oct-17 | 11:01 | x86      |
| Dts.dll                                        | 2017.140.3006.16 | 2996896   | 19-Oct-17 | 12:19 | x64      |
| Dtsconn.dll                                    | 2017.140.3006.16 | 397984    | 19-Oct-17 | 11:01 | x86      |
| Dtsconn.dll                                    | 2017.140.3006.16 | 495264    | 19-Oct-17 | 12:19 | x64      |
| Dtshost.exe                                    | 2017.140.3006.16 | 88224     | 19-Oct-17 | 12:15 | x86      |
| Dtshost.exe                                    | 2017.140.3006.16 | 103072    | 19-Oct-17 | 12:21 | x64      |
| Dtspipeline.dll                                | 2017.140.3006.16 | 1057440   | 19-Oct-17 | 12:10 | x86      |
| Dtspipeline.dll                                | 2017.140.3006.16 | 1264288   | 19-Oct-17 | 12:19 | x64      |
| Dtutil.exe                                     | 2017.140.3006.16 | 125088    | 19-Oct-17 | 11:01 | x86      |
| Dtutil.exe                                     | 2017.140.3006.16 | 145568    | 19-Oct-17 | 12:19 | x64      |
| Microsoft.sqlserver.astasksui.dll              | 14.0.3006.16     | 184480    | 19-Oct-17 | 13:08 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3006.16     | 406688    | 19-Oct-17 | 11:01 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll | 14.0.3006.16     | 406688    | 19-Oct-17 | 12:20 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3006.16     | 2093216   | 19-Oct-17 | 12:15 | x86      |
| Microsoft.sqlserver.configuration.sco.dll      | 14.0.3006.16     | 2093216   | 19-Oct-17 | 12:20 | x86      |
| Msmgdsrv.dll                                   | 2017.140.1.439   | 7310496   | 19-Oct-17 | 12:15 | x86      |
| Sql_tools_extensions_keyfile.dll               | 2017.140.3006.16 | 100512    | 19-Oct-17 | 12:19 | x64      |
| Sqlscm.dll                                     | 2017.140.3006.16 | 59544     | 19-Oct-17 | 11:01 | x86      |
| Sqlscm.dll                                     | 2017.140.3006.16 | 69280     | 19-Oct-17 | 11:08 | x64      |
| Sqlsvc.dll                                     | 2017.140.3006.16 | 133280    | 19-Oct-17 | 11:01 | x86      |
| Sqlsvc.dll                                     | 2017.140.3006.16 | 160416    | 19-Oct-17 | 12:21 | x64      |

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
