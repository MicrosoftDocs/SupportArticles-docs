---
title: Cumulative update 19 for SQL Server 2017 (KB4535007)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 19 (KB4535007).
ms.date: 08/04/2023
ms.custom: KB4535007
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4535007 - Cumulative Update 19 for SQL Server 2017

_Release Date:_ &nbsp; February 5, 2020  
_Version:_ &nbsp; 14.0.3281.6

## Summary

This article describes Cumulative Update package 19 (CU19) for Microsoft SQL Server 2017. This update contains 32 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 18, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3281.6**, file version: **2017.140.3281.6**
- Analysis Services - Product version: **14.0.249.28**, file version: **2017.140.249.28**

## Known issues in this update

There are no known issues with this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area | Component | Platform |
|---------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------|-----------------------------------------|----------|
| <a id=13323994>[13323994](#13323994) </a> | [FIX: Synchronized job may fail when the target servers start to synchronize the database in SQL Server 2016 and 2017 (KB4527355)](https://support.microsoft.com/help/4527355) | Analysis Services| Analysis Services | Windows |
| <a id=13324006>[13324006](#13324006) </a> | [FIX: Memory may not get released when you process partitions with data in SQL Server 2016 and 2017 (KB4529876)](https://support.microsoft.com/help/4529876) | Analysis Services | Analysis Services | Windows |
| <a id=13324020>[13324020](#13324020) </a> | [FIX: IsError function fails to detect error in Excel XIRR function when MDX query is executed from SSIS 2016 and 2017 (KB4530475)](https://support.microsoft.com/help/4530475) | Analysis Services | Analysis Services | Windows |
| <a id=13356804>[13356804](#13356804) </a> | [FIX: cleanup_server_retention_window does not function properly when you try to cleanup execution logs in SSISDB (KB4538447)](https://support.microsoft.com/help/4538447) | Integration Services | Integration Services | Windows |
| <a id=13320404>[13320404](#13320404) </a> | [FIX: Debugging an SSIS package in SSDT 2017 always starts DtsDebugHost in 32-bit instead of 64-bit (KB4534893)](https://support.microsoft.com/help/4534893) | Integration Services | Tools | Windows|
| <a id=13257848>[13257848](#13257848) </a> | [FIX: SQLDiag fails to generate output due to missing stored procedure tempdb.dbo.sp_sqldiag14 in SQL Server 2017 (KB4531736)](https://support.microsoft.com/help/4531736) | SQL Server Client Tools | SQLDiag | Windows |
| <a id=13200685>[13200685](#13200685) </a> | [FIX: SQL Server 2016 and 2017 database remains in frozen I/O state indefinitely when backed up by VSS (KB4523102)](https://support.microsoft.com/help/4523102) | SQL Server Engine | Backup Restore | Windows |
| <a id=13293961>[13293961](#13293961) </a> | [FIX: Non-yielding scheduler condition occurs when you run batch mode query with multiple joins in SQL Server 2017 (KB4538377)](https://support.microsoft.com/help/4538377) | SQL Server Engine | Column Stores | Windows |
| <a id=13324012>[13324012](#13324012) </a> | [FIX: Error 8959 may occur on IAM page when you query sys.dm_db_index_physical_stats against partitioned columnstore table after partition switch in SQL Server (KB4528067)](https://support.microsoft.com/help/4528067) | SQL Server Engine | Column Stores | Windows |
| <a id=13324014>[13324014](#13324014) </a> | [FIX: Unable to restore SQL Server 2012 databases on SQL Server 2016 and 2017 because of NCCI (KB4528066)](https://support.microsoft.com/help/4528066) | SQL Server Engine | Column Stores | Windows |
| <a id=13336052>[13336052](#13336052) </a> | [FIX: Access violation occurs when you run DBCC CHECKTABLE against a table with Clustered Columnstore Index in SQL Server 2017 (KB4537350)](https://support.microsoft.com/help/4537350) | SQL Server Engine | Column Stores | Windows |
| <a id=13264329>[13264329](#13264329) </a> | [Improvement: Download new CAB files that have fixes for R/Python runtime features (KB4538205)](https://support.microsoft.com/help/4538205) | SQL Server Engine | Extensibility | Windows |
| <a id=13315613>[13315613](#13315613) </a> | [FIX: Database initialization may fail by using automatic seeding in SQL Server 2017 (KB4538275)](https://support.microsoft.com/help/4538275) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id=13325751>[13325751](#13325751) </a> | [FIX: Error occurs and AG will be in non-synchronizing state when failover happens in primary AG of Distributed Availability Group in SQL Server 2017 on Linux (KB4538174)](https://support.microsoft.com/help/4538174) | SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id=13356506>[13356506](#13356506) </a> | [FIX: Secondary replica update may fail if availability group configured on Linux in SQL Server 2017 (KB4538356)](https://support.microsoft.com/help/4538356)| SQL Server Engine | High Availability and Disaster Recovery | Linux |
| <a id=13358148>[13358148](#13358148) </a> | [FIX: Transaction commit may cause extra latency at low workloads in SQL Server 2017 (KB4538849)](https://support.microsoft.com/help/4538849)| SQL Server Engine| High Availability and Disaster Recovery | Windows |
| <a id=13323986>[13323986](#13323986) </a> | [FIX: Assertion error occurs when you use IDENT_CURRENT on view that has identity columns in SQL Server 2016 and 2017 (KB4528250)](https://support.microsoft.com/help/4528250) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id=13298386>[13298386](#13298386) </a> | [FIX: "Expired BLOB handle" error occurs when cross-database transaction involves communication with MSDTC in SQL Server 2017 (KB4538268)](https://support.microsoft.com/help/4538268) | SQL Server Engine | Query Execution | All |
| <a id=13323996>[13323996](#13323996) </a> | [FIX: Access violation occurs when you use sys.dm_os_memory_objects in SQL Server 2016 and 2017 (KB4530212)](https://support.microsoft.com/help/4530212) | SQL Server Engine | Query Execution | Linux |
| <a id=13324000>[13324000](#13324000) </a> | [FIX: Error 8601 occurs when you run a query with partition function in SQL Server (KB4530251)](https://support.microsoft.com/help/4530251) | SQL Server Engine | Query Execution | Windows |
| <a id=13324002>[13324002](#13324002) </a> | [FIX: Non-yielding scheduler issue occurs in SQL Server 2016 and 2017 when you run an online build for an index that's not partition-aligned (KB4530443)](https://support.microsoft.com/help/4530443) | SQL Server Engine | Query Execution | Windows |
| <a id=13324008>[13324008](#13324008) </a> | [FIX: You may encounter a non-yielding scheduler condition when you run query with parallel batch-mode sort operator in SQL Server 2016 and 2017 (KB4527716)](https://support.microsoft.com/help/4527716)| SQL Server Engine | Query Execution | Windows |
| <a id=13135043>[13135043](#13135043) </a> | [FIX: Slow query performance when using query predicates with UPPER, LOWER or RTRIM with default CE in SQL Server 2017 (KB4538497)](https://support.microsoft.com/help/4538497)| SQL Server Engine | Query Optimizer | Windows |
| <a id=13189393>[13189393](#13189393) </a> | [FIX: Access violation occurs when you join two columns in SQL Server 2017 in which Adaptive joins are permitted (KB4537438)](https://support.microsoft.com/help/4537438) | SQL Server Engine | Query Optimizer | All |
| <a id=13323988>[13323988](#13323988) </a> | [FIX: CREATE INDEX with new CE reads the partition table and results in huge row count higher than the total table row count in SQL Server 2016 and 2017 (KB4531010)](https://support.microsoft.com/help/4531010) | SQL Server Engine | Query Optimizer | Windows |
| <a id=13333767>[13333767](#13333767) </a> | [FIX: Deadlock may occur when you create a database by using non-default collation in SQL Server 2017 (KB4537649)](https://support.microsoft.com/help/4537649) | SQL Server Engine | Query Store | Windows |
| <a id=13288075>[13288075](#13288075) </a> | [FIX: Assertion occurs when sys.sp_cdc_enable_table is used to enable CDC on column set table in SQL Server 2017 (KB4531386)](https://support.microsoft.com/help/4531386) | SQL Server Engine | Replication | Windows |
| <a id=13312017>[13312017](#13312017) </a> | [FIX: Change Tracking cleanup does not work when invalid cleanup and hardened cleanup version are negative in SQL Server 2017 (KB4538365)](https://support.microsoft.com/help/4538365) | SQL Server Engine | Replication | Windows |
| <a id=13324018>[13324018](#13324018) </a> | [FIX: Scripts generated by SSMS collect different wait types after you install SQL Server 2016 or 2017 (KB4530259)](https://support.microsoft.com/help/4530259)| SQL Server Engine | SQL OS | Windows |
| <a id=13343024>[13343024](#13343024) </a> | [FIX: The "is_media_read_only" value remains unchanged for a SQL Server data file even though the media is no longer read-only (KB4538378)](https://support.microsoft.com/help/4538378) | SQL Server Engine | Storage Management | Windows |
| <a id=13323998>[13323998](#13323998) </a> | [FIX: MDS and/or LocalDB patch installation fails if you patch SQL Server 2016 or 2017 with a next CU (KB4524542)](https://support.microsoft.com/help/4524542) | SQL Setup | Patching | Windows |
| <a id=13357902>[13357902](#13357902) </a> | [FIX: Error occurs in sp_xml_preparedocument where MSXMLSQL tries to access virtual address space beyond limit in SQL Server 2017 (KB4540449)](https://support.microsoft.com/help/4540449) | SQL Server Engine | XML | All |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU19 now](https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2020/02/sqlserver2017-kb4535007-x64_6c883a7a36a1029066e2be6ab9eeab0967804580.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4535007-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4535007-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4535007-x64.exe| E0CB8C5420E9E7CFD4B3B4E37126FF54ECF1A1BBC3C1B4B75362315C965AB368 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.28 | 259464    | 24-Jan-20 | 09:37 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.28     | 734600    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.28     | 1373576   | 24-Jan-20 | 09:38 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.28     | 977288    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.28     | 514440    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 24-Jan-20 | 09:29 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 24-Jan-20 | 09:29 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 24-Jan-20 | 09:30 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 24-Jan-20 | 09:29 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 24-Jan-20 | 09:29 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 24-Jan-20 | 09:29 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 24-Jan-20 | 09:29 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 24-Jan-20 | 09:29 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 24-Jan-20 | 09:29 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 24-Jan-20 | 09:29 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 24-Jan-20 | 09:29 | x86      |
| Msmdctr.dll                                        | 2017.140.249.28 | 33160     | 24-Jan-20 | 09:39 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.28 | 60753288  | 24-Jan-20 | 09:39 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.28 | 40412552  | 24-Jan-20 | 09:50 | x86      |
| Msmdpump.dll                                       | 2017.140.249.28 | 9332616   | 24-Jan-20 | 09:39 | x64      |
| Msmdredir.dll                                      | 2017.140.249.28 | 7088008   | 24-Jan-20 | 09:50 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.28 | 60653656  | 24-Jan-20 | 09:39 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.28 | 9000328   | 24-Jan-20 | 09:39 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.28 | 7304792   | 24-Jan-20 | 09:50 | x86      |
| Msolap.dll                                         | 2017.140.249.28 | 10256472  | 24-Jan-20 | 09:39 | x64      |
| Msolap.dll                                         | 2017.140.249.28 | 7772760   | 24-Jan-20 | 09:50 | x86      |
| Msolui.dll                                         | 2017.140.249.28 | 304008    | 24-Jan-20 | 09:39 | x64      |
| Msolui.dll                                         | 2017.140.249.28 | 280456    | 24-Jan-20 | 09:50 | x86      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 24-Jan-20 | 09:29 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlboot.dll                                        | 2017.140.3281.6 | 191064    | 24-Jan-20 | 09:39 | x64      |
| Sqlceip.exe                                        | 14.0.3281.6     | 254856    | 24-Jan-20 | 09:29 | x86      |
| Sqldumper.exe                                      | 2017.140.3281.6 | 116104    | 24-Jan-20 | 09:30 | x86      |
| Sqldumper.exe                                      | 2017.140.3281.6 | 138632    | 24-Jan-20 | 09:44 | x64      |
| Tmapi.dll                                          | 2017.140.249.28 | 5814664   | 24-Jan-20 | 09:39 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.28 | 4158040   | 24-Jan-20 | 09:39 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.28 | 1125464   | 24-Jan-20 | 09:39 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.28 | 1634184   | 24-Jan-20 | 09:39 | x64      |
| Xe.dll                                             | 2017.140.3281.6 | 666712    | 24-Jan-20 | 09:39 | x64      |
| Xmlrw.dll                                          | 2017.140.3281.6 | 298584    | 24-Jan-20 | 09:39 | x64      |
| Xmlrw.dll                                          | 2017.140.3281.6 | 250760    | 24-Jan-20 | 09:50 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3281.6 | 217480    | 24-Jan-20 | 09:39 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3281.6 | 182664    | 24-Jan-20 | 09:50 | x86      |
| Xmsrv.dll                                          | 2017.140.249.28 | 25372552  | 24-Jan-20 | 09:39 | x64      |
| Xmsrv.dll                                          | 2017.140.249.28 | 33346440  | 24-Jan-20 | 09:50 | x86      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time | Platform |
|--------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                            | 2017.140.3281.6  | 174168    | 24-Jan-20 | 09:37 | x64      |
| Batchparser.dll                            | 2017.140.3281.6  | 153688    | 24-Jan-20 | 09:49 | x86      |
| Instapi140.dll                             | 2017.140.3281.6  | 65624     | 24-Jan-20 | 09:39 | x64      |
| Instapi140.dll                             | 2017.140.3281.6  | 55896     | 24-Jan-20 | 09:50 | x86      |
| Isacctchange.dll                           | 2017.140.3281.6  | 24152     | 24-Jan-20 | 09:38 | x64      |
| Isacctchange.dll                           | 2017.140.3281.6  | 22616     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.28      | 1081736   | 24-Jan-20 | 09:38 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.28      | 1081736   | 24-Jan-20 | 09:49 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.28      | 1374840   | 24-Jan-20 | 09:49 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.28      | 734600    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.28      | 734808    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3281.6      | 30088     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3281.6  | 75144     | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3281.6  | 71560     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3281.6      | 564616    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3281.6      | 564824    | 24-Jan-20 | 09:49 | x86      |
| Msasxpress.dll                             | 2017.140.249.28  | 29064     | 24-Jan-20 | 09:39 | x64      |
| Msasxpress.dll                             | 2017.140.249.28  | 24960     | 24-Jan-20 | 09:50 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3281.6  | 77192     | 24-Jan-20 | 09:39 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3281.6  | 62552     | 24-Jan-20 | 09:50 | x86      |
| Sql_common_core_keyfile.dll                | 2017.140.3281.6  | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqldumper.exe                              | 2017.140.3281.6  | 116104    | 24-Jan-20 | 09:30 | x86      |
| Sqldumper.exe                              | 2017.140.3281.6  | 138632    | 24-Jan-20 | 09:44 | x64      |
| Sqlftacct.dll                              | 2017.140.3281.6  | 57224     | 24-Jan-20 | 09:39 | x64      |
| Sqlftacct.dll                              | 2017.140.3281.6  | 49032     | 24-Jan-20 | 09:50 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 24-Jan-20 | 09:38 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 24-Jan-20 | 09:49 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3281.6  | 413064    | 24-Jan-20 | 09:38 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3281.6  | 368520    | 24-Jan-20 | 09:49 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3281.6  | 30600     | 24-Jan-20 | 09:39 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3281.6  | 28032     | 24-Jan-20 | 09:50 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3281.6  | 351320    | 24-Jan-20 | 09:39 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3281.6  | 267352    | 24-Jan-20 | 09:50 | x86      |
| Sqltdiagn.dll                              | 2017.140.3281.6  | 61016     | 24-Jan-20 | 09:38 | x64      |
| Sqltdiagn.dll                              | 2017.140.3281.6  | 53640     | 24-Jan-20 | 09:49 | x86      |
| Svrenumapi140.dll                          | 2017.140.3281.6  | 1167752   | 24-Jan-20 | 09:39 | x64      |
| Svrenumapi140.dll                          | 2017.140.3281.6  | 888408    | 24-Jan-20 | 09:50 | x86      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 24-Jan-20 | 09:50 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 24-Jan-20 | 09:50 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 24-Jan-20 | 09:50 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 24-Jan-20 | 09:50 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 24-Jan-20 | 09:49 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3281.6 | 114056    | 24-Jan-20 | 09:49 | x86      |
| Dreplaycommon.dll              | 2017.140.3281.6 | 693128    | 24-Jan-20 | 09:49 | x86      |
| Dreplayserverps.dll            | 2017.140.3281.6 | 26200     | 24-Jan-20 | 09:49 | x86      |
| Dreplayutil.dll                | 2017.140.3281.6 | 303200    | 24-Jan-20 | 09:49 | x86      |
| Instapi140.dll                 | 2017.140.3281.6 | 65624     | 24-Jan-20 | 09:39 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlresourceloader.dll          | 2017.140.3281.6 | 22408     | 24-Jan-20 | 09:49 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3281.6 | 693128    | 24-Jan-20 | 09:49 | x86      |
| Dreplaycontroller.exe              | 2017.140.3281.6 | 343640    | 24-Jan-20 | 09:49 | x86      |
| Dreplayprocess.dll                 | 2017.140.3281.6 | 164960    | 24-Jan-20 | 09:49 | x86      |
| Dreplayserverps.dll                | 2017.140.3281.6 | 26200     | 24-Jan-20 | 09:49 | x86      |
| Instapi140.dll                     | 2017.140.3281.6 | 65624     | 24-Jan-20 | 09:39 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlresourceloader.dll              | 2017.140.3281.6 | 22408     | 24-Jan-20 | 09:49 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Backuptourl.exe                              | 14.0.3281.6     | 33880     | 24-Jan-20 | 09:37 | x64      |
| Batchparser.dll                              | 2017.140.3281.6 | 174168    | 24-Jan-20 | 09:37 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 24-Jan-20 | 09:35 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 24-Jan-20 | 09:35 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 24-Jan-20 | 09:35 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 24-Jan-20 | 09:35 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 24-Jan-20 | 09:37 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3281.6 | 220552    | 24-Jan-20 | 09:37 | x64      |
| Dcexec.exe                                   | 2017.140.3281.6 | 67672     | 24-Jan-20 | 09:37 | x64      |
| Fssres.dll                                   | 2017.140.3281.6 | 83848     | 24-Jan-20 | 09:39 | x64      |
| Hadrres.dll                                  | 2017.140.3281.6 | 182872    | 24-Jan-20 | 09:39 | x64      |
| Hkcompile.dll                                | 2017.140.3281.6 | 1416280   | 24-Jan-20 | 09:39 | x64      |
| Hkengine.dll                                 | 2017.140.3281.6 | 5852248   | 24-Jan-20 | 09:39 | x64      |
| Hkruntime.dll                                | 2017.140.3281.6 | 156040    | 24-Jan-20 | 09:39 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 24-Jan-20 | 09:35 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.28     | 734088    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3281.6     | 229464    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3281.6     | 72584     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3281.6 | 385928    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3281.6 | 65416     | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3281.6 | 58248     | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3281.6 | 145496    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3281.6 | 152696    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3281.6 | 297056    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3281.6 | 67976     | 24-Jan-20 | 09:38 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 24-Jan-20 | 09:35 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 24-Jan-20 | 09:35 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 24-Jan-20 | 09:35 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 24-Jan-20 | 09:35 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 24-Jan-20 | 09:35 | x64      |
| Odsole70.dll                                 | 2017.140.3281.6 | 85896     | 24-Jan-20 | 09:39 | x64      |
| Opends60.dll                                 | 2017.140.3281.6 | 25992     | 24-Jan-20 | 09:39 | x64      |
| Qds.dll                                      | 2017.140.3281.6 | 1175128   | 24-Jan-20 | 09:39 | x64      |
| Rsfxft.dll                                   | 2017.140.3281.6 | 27736     | 24-Jan-20 | 09:39 | x64      |
| Secforwarder.dll                             | 2017.140.3281.6 | 30600     | 24-Jan-20 | 09:39 | x64      |
| Sqagtres.dll                                 | 2017.140.3281.6 | 69208     | 24-Jan-20 | 09:39 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlaamss.dll                                 | 2017.140.3281.6 | 84872     | 24-Jan-20 | 09:38 | x64      |
| Sqlaccess.dll                                | 2017.140.3281.6 | 469080    | 24-Jan-20 | 09:39 | x64      |
| Sqlagent.exe                                 | 2017.140.3281.6 | 597896    | 24-Jan-20 | 09:38 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3281.6 | 56200     | 24-Jan-20 | 09:38 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3281.6 | 47496     | 24-Jan-20 | 09:49 | x86      |
| Sqlagentlog.dll                              | 2017.140.3281.6 | 25992     | 24-Jan-20 | 09:38 | x64      |
| Sqlagentmail.dll                             | 2017.140.3281.6 | 46984     | 24-Jan-20 | 09:38 | x64      |
| Sqlboot.dll                                  | 2017.140.3281.6 | 191064    | 24-Jan-20 | 09:39 | x64      |
| Sqlceip.exe                                  | 14.0.3281.6     | 254856    | 24-Jan-20 | 09:29 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3281.6 | 67464     | 24-Jan-20 | 09:38 | x64      |
| Sqlctr140.dll                                | 2017.140.3281.6 | 123784    | 24-Jan-20 | 09:39 | x64      |
| Sqlctr140.dll                                | 2017.140.3281.6 | 106376    | 24-Jan-20 | 09:50 | x86      |
| Sqldk.dll                                    | 2017.140.3281.6 | 2796120   | 24-Jan-20 | 09:38 | x64      |
| Sqldtsss.dll                                 | 2017.140.3281.6 | 102280    | 24-Jan-20 | 09:38 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 1493600   | 24-Jan-20 | 09:24 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3634264   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3586440   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 1440864   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3294808   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 2085976   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3336280   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3675256   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3778168   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3783768   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3785304   | 24-Jan-20 | 09:28 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 2032736   | 24-Jan-20 | 09:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3916376   | 24-Jan-20 | 09:32 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3913336   | 24-Jan-20 | 09:33 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3289176   | 24-Jan-20 | 09:38 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3819608   | 24-Jan-20 | 09:38 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3400280   | 24-Jan-20 | 09:41 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3365472   | 24-Jan-20 | 09:43 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3479640   | 24-Jan-20 | 09:43 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3594872   | 24-Jan-20 | 09:43 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 3211352   | 24-Jan-20 | 09:44 | x64      |
| Sqlevn70.rll                                 | 2017.140.3281.6 | 4025432   | 24-Jan-20 | 09:47 | x64      |
| Sqliosim.com                                 | 2017.140.3281.6 | 306568    | 24-Jan-20 | 09:39 | x64      |
| Sqliosim.exe                                 | 2017.140.3281.6 | 3013216   | 24-Jan-20 | 09:39 | x64      |
| Sqllang.dll                                  | 2017.140.3281.6 | 41238408  | 24-Jan-20 | 09:39 | x64      |
| Sqlmin.dll                                   | 2017.140.3281.6 | 40414296  | 24-Jan-20 | 09:39 | x64      |
| Sqlolapss.dll                                | 2017.140.3281.6 | 102488    | 24-Jan-20 | 09:38 | x64      |
| Sqlos.dll                                    | 2017.140.3281.6 | 19336     | 24-Jan-20 | 09:38 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3281.6 | 62856     | 24-Jan-20 | 09:38 | x64      |
| Sqlrepss.dll                                 | 2017.140.3281.6 | 61832     | 24-Jan-20 | 09:38 | x64      |
| Sqlresld.dll                                 | 2017.140.3281.6 | 24160     | 24-Jan-20 | 09:38 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3281.6 | 25480     | 24-Jan-20 | 09:38 | x64      |
| Sqlscm.dll                                   | 2017.140.3281.6 | 65928     | 24-Jan-20 | 09:38 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3281.6 | 20872     | 24-Jan-20 | 09:39 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3281.6 | 5885528   | 24-Jan-20 | 09:39 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3281.6 | 725896    | 24-Jan-20 | 09:38 | x64      |
| Sqlservr.exe                                 | 2017.140.3281.6 | 481880    | 24-Jan-20 | 09:39 | x64      |
| Sqlsvc.dll                                   | 2017.140.3281.6 | 156040    | 24-Jan-20 | 09:38 | x64      |
| Sqltses.dll                                  | 2017.140.3281.6 | 9556056   | 24-Jan-20 | 09:38 | x64      |
| Sqsrvres.dll                                 | 2017.140.3281.6 | 256088    | 24-Jan-20 | 09:39 | x64      |
| Svl.dll                                      | 2017.140.3281.6 | 146824    | 24-Jan-20 | 09:39 | x64      |
| Xe.dll                                       | 2017.140.3281.6 | 666712    | 24-Jan-20 | 09:39 | x64      |
| Xmlrw.dll                                    | 2017.140.3281.6 | 298584    | 24-Jan-20 | 09:39 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3281.6 | 217480    | 24-Jan-20 | 09:39 | x64      |
| Xpadsi.exe                                   | 2017.140.3281.6 | 85080     | 24-Jan-20 | 09:39 | x64      |
| Xplog70.dll                                  | 2017.140.3281.6 | 71048     | 24-Jan-20 | 09:39 | x64      |
| Xpqueue.dll                                  | 2017.140.3281.6 | 68184     | 24-Jan-20 | 09:39 | x64      |
| Xprepl.dll                                   | 2017.140.3281.6 | 96648     | 24-Jan-20 | 09:39 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3281.6 | 25480     | 24-Jan-20 | 09:39 | x64      |
| Xpstar.dll                                   | 2017.140.3281.6 | 445528    | 24-Jan-20 | 09:39 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3281.6 | 174168    | 24-Jan-20 | 09:37 | x64      |
| Batchparser.dll                                             | 2017.140.3281.6 | 153688    | 24-Jan-20 | 09:49 | x86      |
| Bcp.exe                                                     | 2017.140.3281.6 | 113272    | 24-Jan-20 | 09:39 | x64      |
| Commanddest.dll                                             | 2017.140.3281.6 | 238984    | 24-Jan-20 | 09:37 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3281.6 | 109448    | 24-Jan-20 | 09:37 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3281.6 | 180616    | 24-Jan-20 | 09:37 | x64      |
| Distrib.exe                                                 | 2017.140.3281.6 | 198232    | 24-Jan-20 | 09:39 | x64      |
| Dteparse.dll                                                | 2017.140.3281.6 | 104328    | 24-Jan-20 | 09:37 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dtepkg.dll                                                  | 2017.140.3281.6 | 131160    | 24-Jan-20 | 09:37 | x64      |
| Dtexec.exe                                                  | 2017.140.3281.6 | 66952     | 24-Jan-20 | 09:37 | x64      |
| Dts.dll                                                     | 2017.140.3281.6 | 2994056   | 24-Jan-20 | 09:37 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3281.6 | 468360    | 24-Jan-20 | 09:37 | x64      |
| Dtsconn.dll                                                 | 2017.140.3281.6 | 491912    | 24-Jan-20 | 09:37 | x64      |
| Dtshost.exe                                                 | 2017.140.3281.6 | 99208     | 24-Jan-20 | 09:39 | x64      |
| Dtslog.dll                                                  | 2017.140.3281.6 | 113784    | 24-Jan-20 | 09:37 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3281.6 | 538712    | 24-Jan-20 | 09:39 | x64      |
| Dtspipeline.dll                                             | 2017.140.3281.6 | 1261448   | 24-Jan-20 | 09:37 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3281.6 | 41560     | 24-Jan-20 | 09:37 | x64      |
| Dtuparse.dll                                                | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dtutil.exe                                                  | 2017.140.3281.6 | 141704    | 24-Jan-20 | 09:37 | x64      |
| Exceldest.dll                                               | 2017.140.3281.6 | 253832    | 24-Jan-20 | 09:38 | x64      |
| Excelsrc.dll                                                | 2017.140.3281.6 | 275848    | 24-Jan-20 | 09:38 | x64      |
| Execpackagetask.dll                                         | 2017.140.3281.6 | 161160    | 24-Jan-20 | 09:38 | x64      |
| Flatfiledest.dll                                            | 2017.140.3281.6 | 379784    | 24-Jan-20 | 09:38 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3281.6 | 392584    | 24-Jan-20 | 09:38 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3281.6 | 89480     | 24-Jan-20 | 09:38 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3281.6 | 52616     | 24-Jan-20 | 09:39 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 24-Jan-20 | 09:36 | x86      |
| Logread.exe                                                 | 2017.140.3281.6 | 629848    | 24-Jan-20 | 09:39 | x64      |
| Mergetxt.dll                                                | 2017.140.3281.6 | 58248     | 24-Jan-20 | 09:39 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.28     | 1374600   | 24-Jan-20 | 09:38 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 24-Jan-20 | 09:36 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3281.6     | 131160    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3281.6     | 48008     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3281.6     | 83032     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3281.6     | 66440     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3281.6     | 385112    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3281.6     | 607112    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3281.6 | 1657736   | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3281.6     | 564824    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3281.6 | 145496    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3281.6 | 152696    | 24-Jan-20 | 09:38 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3281.6 | 96344     | 24-Jan-20 | 09:38 | x64      |
| Msgprox.dll                                                 | 2017.140.3281.6 | 265096    | 24-Jan-20 | 09:39 | x64      |
| Msxmlsql.dll                                                | 2017.140.3281.6 | 1441160   | 24-Jan-20 | 09:39 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 24-Jan-20 | 09:36 | x86      |
| Oledbdest.dll                                               | 2017.140.3281.6 | 254344    | 24-Jan-20 | 09:38 | x64      |
| Oledbsrc.dll                                                | 2017.140.3281.6 | 281992    | 24-Jan-20 | 09:38 | x64      |
| Osql.exe                                                    | 2017.140.3281.6 | 68696     | 24-Jan-20 | 09:38 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3281.6 | 468872    | 24-Jan-20 | 09:39 | x64      |
| Rawdest.dll                                                 | 2017.140.3281.6 | 199560    | 24-Jan-20 | 09:39 | x64      |
| Rawsource.dll                                               | 2017.140.3281.6 | 187272    | 24-Jan-20 | 09:39 | x64      |
| Rdistcom.dll                                                | 2017.140.3281.6 | 852360    | 24-Jan-20 | 09:39 | x64      |
| Recordsetdest.dll                                           | 2017.140.3281.6 | 177544    | 24-Jan-20 | 09:39 | x64      |
| Replagnt.dll                                                | 2017.140.3281.6 | 23944     | 24-Jan-20 | 09:39 | x64      |
| Repldp.dll                                                  | 2017.140.3281.6 | 285576    | 24-Jan-20 | 09:39 | x64      |
| Replerrx.dll                                                | 2017.140.3281.6 | 148872    | 24-Jan-20 | 09:39 | x64      |
| Replisapi.dll                                               | 2017.140.3281.6 | 357464    | 24-Jan-20 | 09:39 | x64      |
| Replmerg.exe                                                | 2017.140.3281.6 | 520072    | 24-Jan-20 | 09:39 | x64      |
| Replprov.dll                                                | 2017.140.3281.6 | 797272    | 24-Jan-20 | 09:39 | x64      |
| Replrec.dll                                                 | 2017.140.3281.6 | 970120    | 24-Jan-20 | 09:39 | x64      |
| Replsub.dll                                                 | 2017.140.3281.6 | 440408    | 24-Jan-20 | 09:39 | x64      |
| Replsync.dll                                                | 2017.140.3281.6 | 148360    | 24-Jan-20 | 09:39 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 24-Jan-20 | 09:39 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 24-Jan-20 | 09:39 | x64      |
| Spresolv.dll                                                | 2017.140.3281.6 | 247384    | 24-Jan-20 | 09:39 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3281.6 | 242056    | 24-Jan-20 | 09:39 | x64      |
| Sqldiag.exe                                                 | 2017.140.3281.6 | 1255008   | 24-Jan-20 | 09:39 | x64      |
| Sqldistx.dll                                                | 2017.140.3281.6 | 219528    | 24-Jan-20 | 09:39 | x64      |
| Sqllogship.exe                                              | 14.0.3281.6     | 98912     | 24-Jan-20 | 09:38 | x64      |
| Sqlmergx.dll                                                | 2017.140.3281.6 | 355416    | 24-Jan-20 | 09:39 | x64      |
| Sqlresld.dll                                                | 2017.140.3281.6 | 24160     | 24-Jan-20 | 09:38 | x64      |
| Sqlresld.dll                                                | 2017.140.3281.6 | 22104     | 24-Jan-20 | 09:49 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3281.6 | 25480     | 24-Jan-20 | 09:38 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3281.6 | 22408     | 24-Jan-20 | 09:49 | x86      |
| Sqlscm.dll                                                  | 2017.140.3281.6 | 65928     | 24-Jan-20 | 09:38 | x64      |
| Sqlscm.dll                                                  | 2017.140.3281.6 | 55176     | 24-Jan-20 | 09:49 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3281.6 | 156040    | 24-Jan-20 | 09:38 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3281.6 | 128600    | 24-Jan-20 | 09:49 | x86      |
| Sqltaskconnections.dll                                      | 2017.140.3281.6 | 177240    | 24-Jan-20 | 09:38 | x64      |
| Sqlwep140.dll                                               | 2017.140.3281.6 | 98696     | 24-Jan-20 | 09:39 | x64      |
| Ssdebugps.dll                                               | 2017.140.3281.6 | 26504     | 24-Jan-20 | 09:39 | x64      |
| Ssisoledb.dll                                               | 2017.140.3281.6 | 209288    | 24-Jan-20 | 09:38 | x64      |
| Ssradd.dll                                                  | 2017.140.3281.6 | 70240     | 24-Jan-20 | 09:39 | x64      |
| Ssravg.dll                                                  | 2017.140.3281.6 | 70536     | 24-Jan-20 | 09:39 | x64      |
| Ssrdown.dll                                                 | 2017.140.3281.6 | 55176     | 24-Jan-20 | 09:39 | x64      |
| Ssrmax.dll                                                  | 2017.140.3281.6 | 68488     | 24-Jan-20 | 09:39 | x64      |
| Ssrmin.dll                                                  | 2017.140.3281.6 | 68488     | 24-Jan-20 | 09:39 | x64      |
| Ssrpub.dll                                                  | 2017.140.3281.6 | 55688     | 24-Jan-20 | 09:39 | x64      |
| Ssrup.dll                                                   | 2017.140.3281.6 | 55176     | 24-Jan-20 | 09:39 | x64      |
| Tablediff.exe                                               | 14.0.3281.6     | 79960     | 24-Jan-20 | 09:39 | x64      |
| Txagg.dll                                                   | 2017.140.3281.6 | 355208    | 24-Jan-20 | 09:39 | x64      |
| Txbdd.dll                                                   | 2017.140.3281.6 | 163208    | 24-Jan-20 | 09:39 | x64      |
| Txdatacollector.dll                                         | 2017.140.3281.6 | 353672    | 24-Jan-20 | 09:39 | x64      |
| Txdataconvert.dll                                           | 2017.140.3281.6 | 286088    | 24-Jan-20 | 09:39 | x64      |
| Txderived.dll                                               | 2017.140.3281.6 | 597592    | 24-Jan-20 | 09:39 | x64      |
| Txlookup.dll                                                | 2017.140.3281.6 | 521096    | 24-Jan-20 | 09:39 | x64      |
| Txmerge.dll                                                 | 2017.140.3281.6 | 223112    | 24-Jan-20 | 09:39 | x64      |
| Txmergejoin.dll                                             | 2017.140.3281.6 | 268680    | 24-Jan-20 | 09:39 | x64      |
| Txmulticast.dll                                             | 2017.140.3281.6 | 120712    | 24-Jan-20 | 09:39 | x64      |
| Txrowcount.dll                                              | 2017.140.3281.6 | 118664    | 24-Jan-20 | 09:39 | x64      |
| Txsort.dll                                                  | 2017.140.3281.6 | 249736    | 24-Jan-20 | 09:39 | x64      |
| Txsplit.dll                                                 | 2017.140.3281.6 | 589704    | 24-Jan-20 | 09:39 | x64      |
| Txunionall.dll                                              | 2017.140.3281.6 | 174984    | 24-Jan-20 | 09:39 | x64      |
| Xe.dll                                                      | 2017.140.3281.6 | 666712    | 24-Jan-20 | 09:39 | x64      |
| Xmlrw.dll                                                   | 2017.140.3281.6 | 298584    | 24-Jan-20 | 09:39 | x64      |
| Xmlsub.dll                                                  | 2017.140.3281.6 | 255576    | 24-Jan-20 | 09:39 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3281.6 | 1119112   | 24-Jan-20 | 09:39 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlsatellite.dll              | 2017.140.3281.6 | 916872    | 24-Jan-20 | 09:39 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3281.6 | 665480    | 24-Jan-20 | 09:39 | x64      |
| Fdhost.exe               | 2017.140.3281.6 | 109448    | 24-Jan-20 | 09:39 | x64      |
| Fdlauncher.exe           | 2017.140.3281.6 | 57224     | 24-Jan-20 | 09:39 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 24-Jan-20 | 09:38 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlft140ph.dll           | 2017.140.3281.6 | 63064     | 24-Jan-20 | 09:39 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3281.6     | 16984     | 24-Jan-20 | 09:38 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 24-Jan-20 | 09:37 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 24-Jan-20 | 09:49 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 24-Jan-20 | 09:37 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 24-Jan-20 | 09:49 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 24-Jan-20 | 09:37 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 24-Jan-20 | 09:49 | x86      |
| Commanddest.dll                                               | 2017.140.3281.6 | 238984    | 24-Jan-20 | 09:37 | x64      |
| Commanddest.dll                                               | 2017.140.3281.6 | 193928    | 24-Jan-20 | 09:49 | x86      |
| Dteparse.dll                                                  | 2017.140.3281.6 | 104328    | 24-Jan-20 | 09:37 | x64      |
| Dteparse.dll                                                  | 2017.140.3281.6 | 93816     | 24-Jan-20 | 09:49 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3281.6 | 76680     | 24-Jan-20 | 09:49 | x86      |
| Dtepkg.dll                                                    | 2017.140.3281.6 | 131160    | 24-Jan-20 | 09:37 | x64      |
| Dtepkg.dll                                                    | 2017.140.3281.6 | 109960    | 24-Jan-20 | 09:49 | x86      |
| Dtexec.exe                                                    | 2017.140.3281.6 | 66952     | 24-Jan-20 | 09:37 | x64      |
| Dtexec.exe                                                    | 2017.140.3281.6 | 60808     | 24-Jan-20 | 09:49 | x86      |
| Dts.dll                                                       | 2017.140.3281.6 | 2994056   | 24-Jan-20 | 09:37 | x64      |
| Dts.dll                                                       | 2017.140.3281.6 | 2544216   | 24-Jan-20 | 09:49 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3281.6 | 468360    | 24-Jan-20 | 09:37 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3281.6 | 411256    | 24-Jan-20 | 09:49 | x86      |
| Dtsconn.dll                                                   | 2017.140.3281.6 | 491912    | 24-Jan-20 | 09:37 | x64      |
| Dtsconn.dll                                                   | 2017.140.3281.6 | 393816    | 24-Jan-20 | 09:49 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3281.6 | 104328    | 24-Jan-20 | 09:37 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3281.6 | 88664     | 24-Jan-20 | 09:49 | x86      |
| Dtshost.exe                                                   | 2017.140.3281.6 | 99208     | 24-Jan-20 | 09:39 | x64      |
| Dtshost.exe                                                   | 2017.140.3281.6 | 84568     | 24-Jan-20 | 09:50 | x86      |
| Dtslog.dll                                                    | 2017.140.3281.6 | 113784    | 24-Jan-20 | 09:37 | x64      |
| Dtslog.dll                                                    | 2017.140.3281.6 | 96136     | 24-Jan-20 | 09:49 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3281.6 | 538712    | 24-Jan-20 | 09:39 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3281.6 | 534408    | 24-Jan-20 | 09:50 | x86      |
| Dtspipeline.dll                                               | 2017.140.3281.6 | 1261448   | 24-Jan-20 | 09:37 | x64      |
| Dtspipeline.dll                                               | 2017.140.3281.6 | 1053784   | 24-Jan-20 | 09:49 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3281.6 | 41560     | 24-Jan-20 | 09:37 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3281.6 | 35720     | 24-Jan-20 | 09:49 | x86      |
| Dtuparse.dll                                                  | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dtuparse.dll                                                  | 2017.140.3281.6 | 73304     | 24-Jan-20 | 09:49 | x86      |
| Dtutil.exe                                                    | 2017.140.3281.6 | 141704    | 24-Jan-20 | 09:37 | x64      |
| Dtutil.exe                                                    | 2017.140.3281.6 | 120712    | 24-Jan-20 | 09:49 | x86      |
| Exceldest.dll                                                 | 2017.140.3281.6 | 253832    | 24-Jan-20 | 09:38 | x64      |
| Exceldest.dll                                                 | 2017.140.3281.6 | 207752    | 24-Jan-20 | 09:49 | x86      |
| Excelsrc.dll                                                  | 2017.140.3281.6 | 275848    | 24-Jan-20 | 09:38 | x64      |
| Excelsrc.dll                                                  | 2017.140.3281.6 | 223624    | 24-Jan-20 | 09:49 | x86      |
| Execpackagetask.dll                                           | 2017.140.3281.6 | 161160    | 24-Jan-20 | 09:38 | x64      |
| Execpackagetask.dll                                           | 2017.140.3281.6 | 128600    | 24-Jan-20 | 09:49 | x86      |
| Flatfiledest.dll                                              | 2017.140.3281.6 | 379784    | 24-Jan-20 | 09:38 | x64      |
| Flatfiledest.dll                                              | 2017.140.3281.6 | 325720    | 24-Jan-20 | 09:49 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3281.6 | 392584    | 24-Jan-20 | 09:38 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3281.6 | 337288    | 24-Jan-20 | 09:49 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3281.6 | 89480     | 24-Jan-20 | 09:38 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3281.6 | 73608     | 24-Jan-20 | 09:49 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 24-Jan-20 | 09:36 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 24-Jan-20 | 09:49 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3281.6     | 459656    | 24-Jan-20 | 09:38 | x64      |
| Isdeploymentwizard.exe                                        | 14.0.3281.6     | 460168    | 24-Jan-20 | 09:49 | x86      |
| Isserverexec.exe                                              | 14.0.3281.6     | 141704    | 24-Jan-20 | 09:38 | x64      |
| Isserverexec.exe                                              | 14.0.3281.6     | 142424    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.28     | 1374600   | 24-Jan-20 | 09:38 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.28     | 1374600   | 24-Jan-20 | 09:49 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 24-Jan-20 | 09:29 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 24-Jan-20 | 09:36 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3281.6     | 65928     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3281.6 | 105352    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3281.6 | 100232    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3281.6     | 48008     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3281.6     | 48216     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3281.6     | 83032     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3281.6     | 83032     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3281.6     | 66440     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3281.6     | 66440     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3281.6     | 505952    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3281.6     | 505944    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3281.6     | 76680     | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3281.6     | 76680     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3281.6     | 408968    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3281.6     | 408968    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3281.6     | 385112    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3281.6     | 607112    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3281.6     | 607112    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3281.6     | 245640    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3281.6     | 245640    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3281.6 | 145496    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3281.6 | 135048    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3281.6 | 152696    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3281.6 | 138632    | 24-Jan-20 | 09:49 | x86      |
| Msdtssrvr.exe                                                 | 14.0.3281.6     | 212872    | 24-Jan-20 | 09:38 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3281.6 | 96344     | 24-Jan-20 | 09:38 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3281.6 | 83576     | 24-Jan-20 | 09:49 | x86      |
| Msmdpp.dll                                                    | 2017.140.249.28 | 9191816   | 24-Jan-20 | 09:39 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 24-Jan-20 | 09:36 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 24-Jan-20 | 09:44 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 24-Jan-20 | 09:48 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 24-Jan-20 | 09:49 | x86      |
| Oledbdest.dll                                                 | 2017.140.3281.6 | 254344    | 24-Jan-20 | 09:38 | x64      |
| Oledbdest.dll                                                 | 2017.140.3281.6 | 207752    | 24-Jan-20 | 09:49 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3281.6 | 281992    | 24-Jan-20 | 09:38 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3281.6 | 226400    | 24-Jan-20 | 09:49 | x86      |
| Rawdest.dll                                                   | 2017.140.3281.6 | 199560    | 24-Jan-20 | 09:39 | x64      |
| Rawdest.dll                                                   | 2017.140.3281.6 | 159832    | 24-Jan-20 | 09:49 | x86      |
| Rawsource.dll                                                 | 2017.140.3281.6 | 187272    | 24-Jan-20 | 09:39 | x64      |
| Rawsource.dll                                                 | 2017.140.3281.6 | 146312    | 24-Jan-20 | 09:49 | x86      |
| Recordsetdest.dll                                             | 2017.140.3281.6 | 177544    | 24-Jan-20 | 09:39 | x64      |
| Recordsetdest.dll                                             | 2017.140.3281.6 | 142216    | 24-Jan-20 | 09:49 | x86      |
| Sql_is_keyfile.dll                                            | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlceip.exe                                                   | 14.0.3281.6     | 254856    | 24-Jan-20 | 09:29 | x86      |
| Sqldest.dll                                                   | 2017.140.3281.6 | 253832    | 24-Jan-20 | 09:38 | x64      |
| Sqldest.dll                                                   | 2017.140.3281.6 | 206728    | 24-Jan-20 | 09:49 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3281.6 | 177240    | 24-Jan-20 | 09:38 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3281.6 | 148568    | 24-Jan-20 | 09:49 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3281.6 | 209288    | 24-Jan-20 | 09:38 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3281.6 | 169864    | 24-Jan-20 | 09:49 | x86      |
| Txagg.dll                                                     | 2017.140.3281.6 | 355208    | 24-Jan-20 | 09:39 | x64      |
| Txagg.dll                                                     | 2017.140.3281.6 | 295512    | 24-Jan-20 | 09:50 | x86      |
| Txbdd.dll                                                     | 2017.140.3281.6 | 163208    | 24-Jan-20 | 09:39 | x64      |
| Txbdd.dll                                                     | 2017.140.3281.6 | 129416    | 24-Jan-20 | 09:50 | x86      |
| Txbestmatch.dll                                               | 2017.140.3281.6 | 598408    | 24-Jan-20 | 09:39 | x64      |
| Txbestmatch.dll                                               | 2017.140.3281.6 | 486488    | 24-Jan-20 | 09:50 | x86      |
| Txcache.dll                                                   | 2017.140.3281.6 | 173448    | 24-Jan-20 | 09:39 | x64      |
| Txcache.dll                                                   | 2017.140.3281.6 | 139144    | 24-Jan-20 | 09:50 | x86      |
| Txcharmap.dll                                                 | 2017.140.3281.6 | 279944    | 24-Jan-20 | 09:39 | x64      |
| Txcharmap.dll                                                 | 2017.140.3281.6 | 242272    | 24-Jan-20 | 09:50 | x86      |
| Txcopymap.dll                                                 | 2017.140.3281.6 | 178272    | 24-Jan-20 | 09:39 | x64      |
| Txcopymap.dll                                                 | 2017.140.3281.6 | 138848    | 24-Jan-20 | 09:50 | x86      |
| Txdataconvert.dll                                             | 2017.140.3281.6 | 286088    | 24-Jan-20 | 09:39 | x64      |
| Txdataconvert.dll                                             | 2017.140.3281.6 | 246152    | 24-Jan-20 | 09:50 | x86      |
| Txderived.dll                                                 | 2017.140.3281.6 | 597592    | 24-Jan-20 | 09:39 | x64      |
| Txderived.dll                                                 | 2017.140.3281.6 | 508808    | 24-Jan-20 | 09:50 | x86      |
| Txfileextractor.dll                                           | 2017.140.3281.6 | 191880    | 24-Jan-20 | 09:39 | x64      |
| Txfileextractor.dll                                           | 2017.140.3281.6 | 154200    | 24-Jan-20 | 09:50 | x86      |
| Txfileinserter.dll                                            | 2017.140.3281.6 | 189832    | 24-Jan-20 | 09:39 | x64      |
| Txfileinserter.dll                                            | 2017.140.3281.6 | 152664    | 24-Jan-20 | 09:50 | x86      |
| Txgroupdups.dll                                               | 2017.140.3281.6 | 283736    | 24-Jan-20 | 09:39 | x64      |
| Txgroupdups.dll                                               | 2017.140.3281.6 | 224136    | 24-Jan-20 | 09:50 | x86      |
| Txlineage.dll                                                 | 2017.140.3281.6 | 129928    | 24-Jan-20 | 09:39 | x64      |
| Txlineage.dll                                                 | 2017.140.3281.6 | 103520    | 24-Jan-20 | 09:50 | x86      |
| Txlookup.dll                                                  | 2017.140.3281.6 | 521096    | 24-Jan-20 | 09:39 | x64      |
| Txlookup.dll                                                  | 2017.140.3281.6 | 439896    | 24-Jan-20 | 09:50 | x86      |
| Txmerge.dll                                                   | 2017.140.3281.6 | 223112    | 24-Jan-20 | 09:39 | x64      |
| Txmerge.dll                                                   | 2017.140.3281.6 | 170072    | 24-Jan-20 | 09:50 | x86      |
| Txmergejoin.dll                                               | 2017.140.3281.6 | 268680    | 24-Jan-20 | 09:39 | x64      |
| Txmergejoin.dll                                               | 2017.140.3281.6 | 214920    | 24-Jan-20 | 09:50 | x86      |
| Txmulticast.dll                                               | 2017.140.3281.6 | 120712    | 24-Jan-20 | 09:39 | x64      |
| Txmulticast.dll                                               | 2017.140.3281.6 | 95832     | 24-Jan-20 | 09:50 | x86      |
| Txpivot.dll                                                   | 2017.140.3281.6 | 217992    | 24-Jan-20 | 09:39 | x64      |
| Txpivot.dll                                                   | 2017.140.3281.6 | 173448    | 24-Jan-20 | 09:50 | x86      |
| Txrowcount.dll                                                | 2017.140.3281.6 | 118664    | 24-Jan-20 | 09:39 | x64      |
| Txrowcount.dll                                                | 2017.140.3281.6 | 94808     | 24-Jan-20 | 09:50 | x86      |
| Txsampling.dll                                                | 2017.140.3281.6 | 165768    | 24-Jan-20 | 09:39 | x64      |
| Txsampling.dll                                                | 2017.140.3281.6 | 129120    | 24-Jan-20 | 09:50 | x86      |
| Txscd.dll                                                     | 2017.140.3281.6 | 213896    | 24-Jan-20 | 09:39 | x64      |
| Txscd.dll                                                     | 2017.140.3281.6 | 163424    | 24-Jan-20 | 09:50 | x86      |
| Txsort.dll                                                    | 2017.140.3281.6 | 249736    | 24-Jan-20 | 09:39 | x64      |
| Txsort.dll                                                    | 2017.140.3281.6 | 201096    | 24-Jan-20 | 09:50 | x86      |
| Txsplit.dll                                                   | 2017.140.3281.6 | 589704    | 24-Jan-20 | 09:39 | x64      |
| Txsplit.dll                                                   | 2017.140.3281.6 | 503688    | 24-Jan-20 | 09:50 | x86      |
| Txtermextraction.dll                                          | 2017.140.3281.6 | 8669576   | 24-Jan-20 | 09:39 | x64      |
| Txtermextraction.dll                                          | 2017.140.3281.6 | 8608136   | 24-Jan-20 | 09:50 | x86      |
| Txtermlookup.dll                                              | 2017.140.3281.6 | 4150152   | 24-Jan-20 | 09:39 | x64      |
| Txtermlookup.dll                                              | 2017.140.3281.6 | 4099976   | 24-Jan-20 | 09:50 | x86      |
| Txunionall.dll                                                | 2017.140.3281.6 | 174984    | 24-Jan-20 | 09:39 | x64      |
| Txunionall.dll                                                | 2017.140.3281.6 | 132728    | 24-Jan-20 | 09:50 | x86      |
| Txunpivot.dll                                                 | 2017.140.3281.6 | 192904    | 24-Jan-20 | 09:39 | x64      |
| Txunpivot.dll                                                 | 2017.140.3281.6 | 153688    | 24-Jan-20 | 09:50 | x86      |
| Xe.dll                                                        | 2017.140.3281.6 | 666712    | 24-Jan-20 | 09:39 | x64      |
| Xe.dll                                                        | 2017.140.3281.6 | 588680    | 24-Jan-20 | 09:50 | x86      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 24-Jan-20 | 09:24 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 24-Jan-20 | 09:24 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 24-Jan-20 | 09:24 | x86      |
| Instapi140.dll                                                       | 2017.140.3281.6  | 65624     | 24-Jan-20 | 09:24 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 24-Jan-20 | 09:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 24-Jan-20 | 09:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 24-Jan-20 | 09:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 24-Jan-20 | 09:37 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 24-Jan-20 | 09:35 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 24-Jan-20 | 09:30 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 24-Jan-20 | 09:33 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 24-Jan-20 | 09:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 24-Jan-20 | 09:41 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 24-Jan-20 | 09:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 24-Jan-20 | 09:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 24-Jan-20 | 09:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 24-Jan-20 | 09:37 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 24-Jan-20 | 09:35 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 24-Jan-20 | 09:30 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 24-Jan-20 | 09:33 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 24-Jan-20 | 09:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 24-Jan-20 | 09:41 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 24-Jan-20 | 09:24 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 24-Jan-20 | 09:24 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3281.6  | 400264    | 24-Jan-20 | 09:24 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3281.6  | 7321688   | 24-Jan-20 | 09:24 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3281.6  | 2257800   | 24-Jan-20 | 09:24 | x64      |
| Secforwarder.dll                                                     | 2017.140.3281.6  | 30600     | 24-Jan-20 | 09:24 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 24-Jan-20 | 09:24 | x64      |
| Sqldk.dll                                                            | 2017.140.3281.6  | 2729352   | 24-Jan-20 | 09:24 | x64      |
| Sqldumper.exe                                                        | 2017.140.3281.6  | 138632    | 24-Jan-20 | 09:24 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 1493600   | 24-Jan-20 | 09:24 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3913336   | 24-Jan-20 | 09:33 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3211352   | 24-Jan-20 | 09:44 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3916376   | 24-Jan-20 | 09:32 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3819608   | 24-Jan-20 | 09:38 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 2085976   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 2032736   | 24-Jan-20 | 09:32 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3586440   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3594872   | 24-Jan-20 | 09:43 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 1440864   | 24-Jan-20 | 09:25 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3281.6  | 3783768   | 24-Jan-20 | 09:25 | x64      |
| Sqlos.dll                                                            | 2017.140.3281.6  | 19336     | 24-Jan-20 | 09:24 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 24-Jan-20 | 09:24 | x64      |
| Sqltses.dll                                                          | 2017.140.3281.6  | 9729416   | 24-Jan-20 | 09:24 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3281.6     | 16776     | 24-Jan-20 | 09:38 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version    | File size | Date      | Time | Platform |
|--------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                          | 2017.140.3281.6 | 1441672   | 24-Jan-20 | 09:50 | x86      |
| Dtaengine.exe                                          | 2017.140.3281.6 | 197720    | 24-Jan-20 | 09:49 | x86      |
| Dteparse.dll                                           | 2017.140.3281.6 | 104328    | 24-Jan-20 | 09:37 | x64      |
| Dteparse.dll                                           | 2017.140.3281.6 | 93816     | 24-Jan-20 | 09:49 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3281.6 | 76680     | 24-Jan-20 | 09:49 | x86      |
| Dtepkg.dll                                             | 2017.140.3281.6 | 131160    | 24-Jan-20 | 09:37 | x64      |
| Dtepkg.dll                                             | 2017.140.3281.6 | 109960    | 24-Jan-20 | 09:49 | x86      |
| Dtexec.exe                                             | 2017.140.3281.6 | 66952     | 24-Jan-20 | 09:37 | x64      |
| Dtexec.exe                                             | 2017.140.3281.6 | 60808     | 24-Jan-20 | 09:49 | x86      |
| Dts.dll                                                | 2017.140.3281.6 | 2994056   | 24-Jan-20 | 09:37 | x64      |
| Dts.dll                                                | 2017.140.3281.6 | 2544216   | 24-Jan-20 | 09:49 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3281.6 | 468360    | 24-Jan-20 | 09:37 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3281.6 | 411256    | 24-Jan-20 | 09:49 | x86      |
| Dtsconn.dll                                            | 2017.140.3281.6 | 491912    | 24-Jan-20 | 09:37 | x64      |
| Dtsconn.dll                                            | 2017.140.3281.6 | 393816    | 24-Jan-20 | 09:49 | x86      |
| Dtshost.exe                                            | 2017.140.3281.6 | 99208     | 24-Jan-20 | 09:39 | x64      |
| Dtshost.exe                                            | 2017.140.3281.6 | 84568     | 24-Jan-20 | 09:50 | x86      |
| Dtslog.dll                                             | 2017.140.3281.6 | 113784    | 24-Jan-20 | 09:37 | x64      |
| Dtslog.dll                                             | 2017.140.3281.6 | 96136     | 24-Jan-20 | 09:49 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3281.6 | 538712    | 24-Jan-20 | 09:39 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3281.6 | 534408    | 24-Jan-20 | 09:50 | x86      |
| Dtspipeline.dll                                        | 2017.140.3281.6 | 1261448   | 24-Jan-20 | 09:37 | x64      |
| Dtspipeline.dll                                        | 2017.140.3281.6 | 1053784   | 24-Jan-20 | 09:49 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3281.6 | 41560     | 24-Jan-20 | 09:37 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3281.6 | 35720     | 24-Jan-20 | 09:49 | x86      |
| Dtuparse.dll                                           | 2017.140.3281.6 | 82312     | 24-Jan-20 | 09:37 | x64      |
| Dtuparse.dll                                           | 2017.140.3281.6 | 73304     | 24-Jan-20 | 09:49 | x86      |
| Dtutil.exe                                             | 2017.140.3281.6 | 141704    | 24-Jan-20 | 09:37 | x64      |
| Dtutil.exe                                             | 2017.140.3281.6 | 120712    | 24-Jan-20 | 09:49 | x86      |
| Exceldest.dll                                          | 2017.140.3281.6 | 253832    | 24-Jan-20 | 09:38 | x64      |
| Exceldest.dll                                          | 2017.140.3281.6 | 207752    | 24-Jan-20 | 09:49 | x86      |
| Excelsrc.dll                                           | 2017.140.3281.6 | 275848    | 24-Jan-20 | 09:38 | x64      |
| Excelsrc.dll                                           | 2017.140.3281.6 | 223624    | 24-Jan-20 | 09:49 | x86      |
| Flatfiledest.dll                                       | 2017.140.3281.6 | 379784    | 24-Jan-20 | 09:38 | x64      |
| Flatfiledest.dll                                       | 2017.140.3281.6 | 325720    | 24-Jan-20 | 09:49 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3281.6 | 392584    | 24-Jan-20 | 09:38 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3281.6 | 337288    | 24-Jan-20 | 09:49 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3281.6 | 89480     | 24-Jan-20 | 09:38 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3281.6 | 73608     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3281.6     | 65928     | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3281.6     | 179592    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3281.6     | 402824    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3281.6     | 402824    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3281.6     | 2086280   | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3281.6     | 2086280   | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3281.6     | 607112    | 24-Jan-20 | 09:38 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3281.6     | 607112    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3281.6     | 245640    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3281.6 | 145496    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3281.6 | 135048    | 24-Jan-20 | 09:49 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3281.6 | 152696    | 24-Jan-20 | 09:38 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3281.6 | 138632    | 24-Jan-20 | 09:49 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3281.6 | 96344     | 24-Jan-20 | 09:38 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3281.6 | 83576     | 24-Jan-20 | 09:49 | x86      |
| Msmgdsrv.dll                                           | 2017.140.249.28 | 7304792   | 24-Jan-20 | 09:50 | x86      |
| Oledbdest.dll                                          | 2017.140.3281.6 | 254344    | 24-Jan-20 | 09:38 | x64      |
| Oledbdest.dll                                          | 2017.140.3281.6 | 207752    | 24-Jan-20 | 09:49 | x86      |
| Oledbsrc.dll                                           | 2017.140.3281.6 | 281992    | 24-Jan-20 | 09:38 | x64      |
| Oledbsrc.dll                                           | 2017.140.3281.6 | 226400    | 24-Jan-20 | 09:49 | x86      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3281.6 | 93784     | 24-Jan-20 | 09:38 | x64      |
| Sqlresld.dll                                           | 2017.140.3281.6 | 24160     | 24-Jan-20 | 09:38 | x64      |
| Sqlresld.dll                                           | 2017.140.3281.6 | 22104     | 24-Jan-20 | 09:49 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3281.6 | 25480     | 24-Jan-20 | 09:38 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3281.6 | 22408     | 24-Jan-20 | 09:49 | x86      |
| Sqlscm.dll                                             | 2017.140.3281.6 | 65928     | 24-Jan-20 | 09:38 | x64      |
| Sqlscm.dll                                             | 2017.140.3281.6 | 55176     | 24-Jan-20 | 09:49 | x86      |
| Sqlsvc.dll                                             | 2017.140.3281.6 | 156040    | 24-Jan-20 | 09:38 | x64      |
| Sqlsvc.dll                                             | 2017.140.3281.6 | 128600    | 24-Jan-20 | 09:49 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3281.6 | 177240    | 24-Jan-20 | 09:38 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3281.6 | 148568    | 24-Jan-20 | 09:49 | x86      |
| Txdataconvert.dll                                      | 2017.140.3281.6 | 286088    | 24-Jan-20 | 09:39 | x64      |
| Txdataconvert.dll                                      | 2017.140.3281.6 | 246152    | 24-Jan-20 | 09:50 | x86      |
| Xe.dll                                                 | 2017.140.3281.6 | 666712    | 24-Jan-20 | 09:39 | x64      |
| Xe.dll                                                 | 2017.140.3281.6 | 588680    | 24-Jan-20 | 09:50 | x86      |
| Xmlrw.dll                                              | 2017.140.3281.6 | 298584    | 24-Jan-20 | 09:39 | x64      |
| Xmlrw.dll                                              | 2017.140.3281.6 | 250760    | 24-Jan-20 | 09:50 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3281.6 | 217480    | 24-Jan-20 | 09:39 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3281.6 | 182664    | 24-Jan-20 | 09:50 | x86      |

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
