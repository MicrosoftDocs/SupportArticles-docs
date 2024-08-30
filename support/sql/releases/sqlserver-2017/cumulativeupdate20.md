---
title: Cumulative update 20 for SQL Server 2017 (KB4541283)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 20 (KB4541283).
ms.date: 07/26/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4541283, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4541283 - Cumulative Update 20 for SQL Server 2017

_Release Date:_ &nbsp; April 7, 2020  
_Version:_ &nbsp; 14.0.3294.2

## Summary

This article describes Cumulative Update package 20 (CU20) for Microsoft SQL Server 2017. This update contains 36 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 19, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3294.2**, file version: **2017.140.3294.2**
- Analysis Services - Product version: **14.0.249.36**, file version: **2017.140.249.36**

## Known issues in this update

Under certain circumstances, there's a known uninstall issue with this SQL Server 2017 CU20.  If you uninstall this CU, SQL Server doesn’t come online, and you find the following SQL Server error log message:

> The script level for 'system_xevents_modification.sql' in database 'master' cannot be downgraded from XXXXXXXXX to XXXXXXXXX, which is supported by this server. This usually implies that a future database was attached and the downgrade path is not supported by the current installation. Install a newer version of SQL Server and re-try opening the database.

Mitigation is to enable Trace Flag - T902, then SQL Server will come online and you're done. You don’t need to uninstall it again. To upgrade to new CU, you need to remove this flag first.

SQL Server 2017 CU21 or any later CU release contains the fix.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with other people so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this servicing update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description| Fix area| Component | Platform |
|---------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-----------------------------------------|----------|
| <a id=13367989>[13367989](#13367989) </a> | [FIX: Analysis Services Execute DDL task may fail to impersonate the user context to the remote Analysis services instance in SQL Server 2017 (KB4539023)](https://support.microsoft.com/help/4539023) | Analysis Services | Analysis Services | Windows |
| <a id=13421896>[13421896](#13421896) </a> | [FIX: DAX query causes server to have exceptions in TBB heap and crash in Windows heap in SQL Server 2016 and 2017 (KB4540385)](https://support.microsoft.com/help/4540385)| Analysis Services | Analysis Services | Windows |
| <a id=13378811>[13378811](#13378811) </a> | DMV query `$system.DISCOVER_STORAGE_TABLES` may execute slowly against in-memory model that contains many tables and large table row counts in SQL Server 2017. | Analysis Services | Analysis Services | Windows |
| <a id=13378402>[13378402](#13378402) </a> | Floating point exception error occurs during Clustered Columnstore Index Rebuild in SQL Server 2017. | SQL Server Engine | Column Stores | Windows|
| <a id=13361135>[13361135](#13361135) </a> | [FIX: Database creation to Azure blob storage from SQL Server 2017 or 2019 on Linux may fail with error (KB4548523)](https://support.microsoft.com/help/4548523) | SQL Server Engine | DB Management | All |
| <a id=13047035>[13047035](#13047035) </a> | [FIX: Error occurs when you try to create a differential backup on secondary replica in SQL Server 2017 (KB4551221)](https://support.microsoft.com/help/4551221) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13421855>[13421855](#13421855) </a> | [FIX: Missing log block may occur when you use Always On availability group in SQL Server (KB4541309)](https://support.microsoft.com/help/4541309) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13421857>[13421857](#13421857) </a> | [FIX: Non-yielding Scheduler error may occur with Always On availability group in Microsoft SQL Server (KB4541303)](https://support.microsoft.com/help/4541303)| SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13421879>[13421879](#13421879) </a> | [FIX: Fix incorrect values in auto seeding XEvents in SQL Server (KB4541300)](https://support.microsoft.com/help/4541300)| SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13431247>[13431247](#13431247) </a> | Access violation occurs when you enable Parallel Recovery by turning of Trace Flag 3459 during runtime and there's in-memory table in the database. | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id=13421864>[13421864](#13421864) </a> | [FIX: Intermittent non-yielding scheduler occurs when memory-optimized database running under heavy I/O activities in SQL Server (KB4541724)](https://support.microsoft.com/help/4541724) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id=13243017>[13243017](#13243017) </a> | [Mssql-conf tool fails if IPV6 is disabled on the Linux system (KB4532432)](https://support.microsoft.com/help/4532432)| SQL Server Engine | Linux | Linux|
| <a id=13368462>[13368462](#13368462) </a> | [FIX: Management Data Warehouse Server Activity Collection Set may fail in SQL Server (KB4541762)](https://support.microsoft.com/help/4541762) | SQL Server Engine | Management Services | Windows |
| <a id=13421885>[13421885](#13421885) </a> | [FIX: System or background task may fail when number of sessions reaches the maximum limit in SQL Server 2016, 2017 and 2019 (KB4540107)](https://support.microsoft.com/help/4540107)| SQL Server Engine | Programmability | Windows |
| <a id=13421915>[13421915](#13421915) </a> | [FIX: Non-yielding scheduler condition occurs with CONNECTION_MANAGER spinlock in SQL Server (KB4540342)](https://support.microsoft.com/help/4540342)| SQL Server Engine | Programmability | Windows |
| <a id=13421868>[13421868](#13421868) </a> | [FIX: Access violation occurs with wait_info XEvent on busy SQL Server (KB4539880)](https://support.microsoft.com/help/4539880) | SQL Server Engine | Query Execution | Windows |
| <a id=13421906>[13421906](#13421906) </a> | [FIX: MERGE statement fails with assert “Attempt to access expired blob handle (1)” in SQL Server 2016, 2017 and 2019 (KB4540346)](https://support.microsoft.com/help/4540346) | SQL Server Engine | Query Execution | Windows|
| <a id=12795916>[12795916](#12795916) </a> | [FIX: Assertion error occurs when you run resumable index statement in SQL Server 2017 (KB4551220)](https://support.microsoft.com/help/4551220) | SQL Server Engine | Query Optimizer | All |
| <a id=13421851>[13421851](#13421851) </a> | [FIX: Parallel sampled filtered statistics may cause incorrect histogram scaling in SQL Server (KB4543027)](https://support.microsoft.com/help/4543027) | SQL Server Engine | Query Optimizer | All |
| <a id=13421859>[13421859](#13421859) </a> | [FIX: Access Violation occurs when you run query on computed columns in SQL Server (KB4541096)](https://support.microsoft.com/help/4541096) | SQL Server Engine | Query Optimizer | All |
| <a id=13375414>[13375414](#13375414) </a> | When you run a query against a table with filtered index, the query may fail and stack dump may be generated. | SQL Server Engine | Query Optimizer | Windows |
| <a id=13380148>[13380148](#13380148) </a> | Memory dump may be generated for non-yielding scheduler condition (message 17883) when query plan is forced (using QDS, Plan Guide or USE PLAN hint) for queries that contain large number of joins. Having adaptive join feature enabled increases the risk of seeing this issue for complex queries. | SQL Server Engine | Query Optimizer | Windows|
| <a id=13388961>[13388961](#13388961) </a> | [FIX: Distribution Agent "Parameterized values for above command" log message is missing (KB4552478)](https://support.microsoft.com/help/4552478)| SQL Server Engine | Replication | Windows |
| <a id=13421888>[13421888](#13421888) </a> | [FIX: Access violation occurs when change tracking auto cleanup tries to clean up side tables in SQL Server (KB4539815)](https://support.microsoft.com/help/4539815) | SQL Server Engine | Replication | Windows |
| <a id=13421901>[13421901](#13421901) </a> | [FIX: Non-yielding scheduler dump occurs in InterlockedCompareExchangePointer and SOS_RWLock in SQL Server 2016, 2017 and 2019 (KB4540903)](https://support.microsoft.com/help/4540903) | SQL Server Engine | Replication | Windows |
| <a id=13421877>[13421877](#13421877) </a> | Non-yielding scheduler dump in InterlockedCompareExchangePointer and `SOS_RWLock` on the publisher in SQL Server 2017. | SQL Server Engine | Replication | Windows |
| <a id=13421910>[13421910](#13421910) </a> | [FIX: SQL Server may terminate due to lock conflicts during error message processing in SQL Server 2016, 2017 and 2019 (KB4540901)](https://support.microsoft.com/help/4540901) | SQL Server Engine | Security Infrastructure | Windows |
| <a id=13091545>[13091545](#13091545) </a> | [FIX: Geocentric Datum of Australia 2020 is added to SQL Server 2014, 2016 and 2017 (KB4506023)](https://support.microsoft.com/help/4506023) | SQL Server Engine | Spatial | All|
| <a id=13421862>[13421862](#13421862) </a> | [FIX: Assertion occurs when you process a malformed XML message sent as message in Service Broker queue in SQL Server (KB4541520)](https://support.microsoft.com/help/4541520) | SQL Server Engine | Service Broker | Windows |
| <a id=13359750>[13359750](#13359750) </a> | [Improvement: Size and retention policy are increased in default XEvent trace system_health in SQL Server 2016, 2017 and 2019 (KB4541132)](https://support.microsoft.com/help/4541132) | SQL Server Engine | SQL OS | All |
| <a id=13401115>[13401115](#13401115) </a> | [FIX: Fix incorrect memory page accounting that causes out-of-memory errors in SQL Server 2017 and 2019 (KB4536005)](https://support.microsoft.com/help/4536005) | SQL Server Engine | SQL OS | All |
| <a id=13434971>[13434971](#13434971) </a> | [FIX: Access violation exception occurs when promoting latches of frequently used database pages in SQL Server 2017 (KB4551720)](https://support.microsoft.com/help/4551720) | SQL Server Engine | SQL OS | All |
| <a id=13398892>[13398892](#13398892) </a> | Extended Event `session_nt_username` name is truncated and reported incorrectly in SQL Server 2017. | SQL Server Engine | SQL OS | Linux |
| <a id=13431232>[13431232](#13431232) </a> | Improves speed of memory dump generation (filtered dumps) using Page exclusion bitmap mechanism. The PageExclusionBitmap is turned on by default in SQL Server 2017. | SQL Server Engine | SQL OS | All |
| <a id=13421875>[13421875](#13421875) </a> | [FIX: Error occurs when you rename a column on temporal current table in SQL Server (KB4541435)](https://support.microsoft.com/help/4541435) | SQL Server Engine | Temporal | Windows |
| <a id=13421881>[13421881](#13421881) </a> | [FIX: Assertion failure occurs when persistent log buffer is used in SQL Server (KB4541770)](https://support.microsoft.com/help/4541770) | SQL Server Engine | Transaction Services | Windows |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU20 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2020/04/sqlserver2017-kb4541283-x64_b0f1a8f63ba7e9c155546a49f18fd95bc5e9aeaa.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4541283-x64.exe* file through the following command:

`certutil -hashfile SQLServer2017-KB4541283-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4541283-x64.exe| 90677F7D8FF04691BD5BD7653B9E2498EECCAC1AD331B1DD12249190B4F442FC |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

| File   name                                        | File version    | File size | Date      | Time | Platform |
|----------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Asplatformhost.dll                                 | 2017.140.249.36 | 259464    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.36     | 734600    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.36     | 1373576   | 14-Mar-20 | 02:13 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.36     | 977504    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.36     | 514440    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 14-Mar-20 | 02:02 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 14-Mar-20 | 02:06 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 14-Mar-20 | 02:06 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 14-Mar-20 | 02:06 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 14-Mar-20 | 02:06 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 14-Mar-20 | 02:06 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 14-Mar-20 | 02:06 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 14-Mar-20 | 02:06 | x86      |
| Msmdctr.dll                                        | 2017.140.249.36 | 33160     | 14-Mar-20 | 02:15 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.36 | 40412552  | 14-Mar-20 | 02:05 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.36 | 60753288  | 14-Mar-20 | 02:15 | x64      |
| Msmdpump.dll                                       | 2017.140.249.36 | 9332832   | 14-Mar-20 | 02:15 | x64      |
| Msmdredir.dll                                      | 2017.140.249.36 | 7088216   | 14-Mar-20 | 02:05 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.36 | 60651608  | 14-Mar-20 | 02:15 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.36 | 7304584   | 14-Mar-20 | 02:05 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.36 | 9000328   | 14-Mar-20 | 02:15 | x64      |
| Msolap.dll                                         | 2017.140.249.36 | 7772768   | 14-Mar-20 | 02:05 | x86      |
| Msolap.dll                                         | 2017.140.249.36 | 10256264  | 14-Mar-20 | 02:15 | x64      |
| Msolui.dll                                         | 2017.140.249.36 | 280456    | 14-Mar-20 | 02:05 | x86      |
| Msolui.dll                                         | 2017.140.249.36 | 304224    | 14-Mar-20 | 02:15 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 14-Mar-20 | 02:06 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlboot.dll                                        | 2017.140.3294.2 | 190856    | 14-Mar-20 | 02:15 | x64      |
| Sqlceip.exe                                        | 14.0.3294.2     | 255096    | 14-Mar-20 | 02:02 | x86      |
| Sqldumper.exe                                      | 2017.140.3294.2 | 138632    | 14-Mar-20 | 01:51 | x64      |
| Sqldumper.exe                                      | 2017.140.3294.2 | 116320    | 14-Mar-20 | 02:09 | x86      |
| Tmapi.dll                                          | 2017.140.249.36 | 5814664   | 14-Mar-20 | 02:15 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.36 | 4157832   | 14-Mar-20 | 02:15 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.36 | 1125256   | 14-Mar-20 | 02:15 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.36 | 1634184   | 14-Mar-20 | 02:15 | x64      |
| Xe.dll                                             | 2017.140.3294.2 | 666504    | 14-Mar-20 | 02:15 | x64      |
| Xmlrw.dll                                          | 2017.140.3294.2 | 250760    | 14-Mar-20 | 02:05 | x86      |
| Xmlrw.dll                                          | 2017.140.3294.2 | 298376    | 14-Mar-20 | 02:15 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3294.2 | 182880    | 14-Mar-20 | 02:05 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3294.2 | 217696    | 14-Mar-20 | 02:15 | x64      |
| Xmsrv.dll                                          | 2017.140.249.36 | 33349000  | 14-Mar-20 | 02:05 | x86      |
| Xmsrv.dll                                          | 2017.140.249.36 | 25375840  | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 Database Services Common Core

| File   name                                | File version     | File size | Date      | Time | Platform |
|--------------------------------------------|------------------|-----------|-----------|------|----------|
| Batchparser.dll                            | 2017.140.3294.2  | 153480    | 14-Mar-20 | 02:02 | x86      |
| Batchparser.dll                            | 2017.140.3294.2  | 173960    | 14-Mar-20 | 02:13 | x64      |
| Instapi140.dll                             | 2017.140.3294.2  | 55688     | 14-Mar-20 | 02:05 | x86      |
| Instapi140.dll                             | 2017.140.3294.2  | 65416     | 14-Mar-20 | 02:15 | x64      |
| Isacctchange.dll                           | 2017.140.3294.2  | 22624     | 14-Mar-20 | 02:02 | x86      |
| Isacctchange.dll                           | 2017.140.3294.2  | 23944     | 14-Mar-20 | 02:13 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.36      | 1081736   | 14-Mar-20 | 02:03 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.36      | 1081736   | 14-Mar-20 | 02:13 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.36      | 1374600   | 14-Mar-20 | 02:03 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.36      | 734600    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.36      | 734600    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3294.2      | 30088     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3294.2  | 71560     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3294.2  | 75144     | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3294.2      | 564856    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3294.2      | 564832    | 14-Mar-20 | 02:13 | x86      |
| Msasxpress.dll                             | 2017.140.249.36  | 25208     | 14-Mar-20 | 02:05 | x86      |
| Msasxpress.dll                             | 2017.140.249.36  | 29064     | 14-Mar-20 | 02:15 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3294.2  | 62344     | 14-Mar-20 | 02:05 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3294.2  | 77408     | 14-Mar-20 | 02:15 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3294.2  | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqldumper.exe                              | 2017.140.3294.2  | 138632    | 14-Mar-20 | 01:51 | x64      |
| Sqldumper.exe                              | 2017.140.3294.2  | 116320    | 14-Mar-20 | 02:09 | x86      |
| Sqlftacct.dll                              | 2017.140.3294.2  | 49032     | 14-Mar-20 | 02:05 | x86      |
| Sqlftacct.dll                              | 2017.140.3294.2  | 57224     | 14-Mar-20 | 02:15 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 14-Mar-20 | 02:03 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 14-Mar-20 | 02:15 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3294.2  | 368520    | 14-Mar-20 | 02:03 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3294.2  | 413064    | 14-Mar-20 | 02:15 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3294.2  | 28256     | 14-Mar-20 | 02:05 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3294.2  | 30600     | 14-Mar-20 | 02:15 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3294.2  | 267144    | 14-Mar-20 | 02:05 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3294.2  | 351112    | 14-Mar-20 | 02:15 | x64      |
| Sqltdiagn.dll                              | 2017.140.3294.2  | 53640     | 14-Mar-20 | 02:03 | x86      |
| Sqltdiagn.dll                              | 2017.140.3294.2  | 60808     | 14-Mar-20 | 02:15 | x64      |
| Svrenumapi140.dll                          | 2017.140.3294.2  | 888416    | 14-Mar-20 | 02:05 | x86      |
| Svrenumapi140.dll                          | 2017.140.3294.2  | 1167752   | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 Data Quality Client

| File   name         | File version    | File size | Date      | Time | Platform |
|---------------------|-----------------|-----------|-----------|------|----------|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 14-Mar-20 | 02:05 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 14-Mar-20 | 02:05 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 14-Mar-20 | 02:05 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 14-Mar-20 | 02:05 | x86      |

SQL Server 2017 Data Quality

| File   name                                       | File version | File size | Date      | Time | Platform |
|---------------------------------------------------|--------------|-----------|-----------|------|----------|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 14-Mar-20 | 02:13 | x86      |

SQL Server 2017 sql_dreplay_client

| File   name                    | File version    | File size | Date      | Time | Platform |
|--------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplayclient.exe              | 2017.140.3294.2 | 114272    | 14-Mar-20 | 02:02 | x86      |
| Dreplaycommon.dll              | 2017.140.3294.2 | 693128    | 14-Mar-20 | 02:02 | x86      |
| Dreplayserverps.dll            | 2017.140.3294.2 | 25992     | 14-Mar-20 | 02:02 | x86      |
| Dreplayutil.dll                | 2017.140.3294.2 | 302984    | 14-Mar-20 | 02:02 | x86      |
| Instapi140.dll                 | 2017.140.3294.2 | 65416     | 14-Mar-20 | 02:15 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlresourceloader.dll          | 2017.140.3294.2 | 22408     | 14-Mar-20 | 02:03 | x86      |

SQL Server 2017 sql_dreplay_controller

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Dreplaycommon.dll                  | 2017.140.3294.2 | 693128    | 14-Mar-20 | 02:02 | x86      |
| Dreplaycontroller.exe              | 2017.140.3294.2 | 343432    | 14-Mar-20 | 02:02 | x86      |
| Dreplayprocess.dll                 | 2017.140.3294.2 | 164744    | 14-Mar-20 | 02:02 | x86      |
| Dreplayserverps.dll                | 2017.140.3294.2 | 25992     | 14-Mar-20 | 02:02 | x86      |
| Instapi140.dll                     | 2017.140.3294.2 | 65416     | 14-Mar-20 | 02:15 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlresourceloader.dll              | 2017.140.3294.2 | 22408     | 14-Mar-20 | 02:03 | x86      |

SQL Server 2017 Database Services Core Instance

| File   name                                  | File version    | File size | Date      | Time | Platform |
|----------------------------------------------|-----------------|-----------|-----------|------|----------|
| Backuptourl.exe                              | 14.0.3294.2     | 33888     | 14-Mar-20 | 02:13 | x64      |
| Batchparser.dll                              | 2017.140.3294.2 | 173960    | 14-Mar-20 | 02:13 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 14-Mar-20 | 02:11 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 14-Mar-20 | 02:11 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 14-Mar-20 | 02:11 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 14-Mar-20 | 02:10 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 14-Mar-20 | 02:13 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3294.2 | 220768    | 14-Mar-20 | 02:13 | x64      |
| Dcexec.exe                                   | 2017.140.3294.2 | 67680     | 14-Mar-20 | 02:13 | x64      |
| Fssres.dll                                   | 2017.140.3294.2 | 83848     | 14-Mar-20 | 02:15 | x64      |
| Hadrres.dll                                  | 2017.140.3294.2 | 182664    | 14-Mar-20 | 02:15 | x64      |
| Hkcompile.dll                                | 2017.140.3294.2 | 1416072   | 14-Mar-20 | 02:15 | x64      |
| Hkengine.dll                                 | 2017.140.3294.2 | 5852040   | 14-Mar-20 | 02:15 | x64      |
| Hkruntime.dll                                | 2017.140.3294.2 | 156256    | 14-Mar-20 | 02:15 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 14-Mar-20 | 02:11 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.36     | 734088    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 14-Mar-20 | 02:02 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3294.2     | 229496    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3294.2     | 72584     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3294.2 | 385928    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3294.2 | 65416     | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3294.2 | 58248     | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3294.2 | 145288    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3294.2 | 152456    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3294.2 | 296840    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3294.2 | 67976     | 14-Mar-20 | 02:13 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 14-Mar-20 | 02:11 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 14-Mar-20 | 02:11 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 14-Mar-20 | 02:11 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 14-Mar-20 | 02:11 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 14-Mar-20 | 02:11 | x64      |
| Odsole70.dll                                 | 2017.140.3294.2 | 85896     | 14-Mar-20 | 02:15 | x64      |
| Opends60.dll                                 | 2017.140.3294.2 | 25992     | 14-Mar-20 | 02:15 | x64      |
| Qds.dll                                      | 2017.140.3294.2 | 1175136   | 14-Mar-20 | 02:15 | x64      |
| Rsfxft.dll                                   | 2017.140.3294.2 | 27528     | 14-Mar-20 | 02:15 | x64      |
| Secforwarder.dll                             | 2017.140.3294.2 | 30600     | 14-Mar-20 | 02:15 | x64      |
| Sqagtres.dll                                 | 2017.140.3294.2 | 69000     | 14-Mar-20 | 02:15 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlaamss.dll                                 | 2017.140.3294.2 | 84872     | 14-Mar-20 | 02:15 | x64      |
| Sqlaccess.dll                                | 2017.140.3294.2 | 468872    | 14-Mar-20 | 02:15 | x64      |
| Sqlagent.exe                                 | 2017.140.3294.2 | 598408    | 14-Mar-20 | 02:15 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3294.2 | 47496     | 14-Mar-20 | 02:03 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3294.2 | 56416     | 14-Mar-20 | 02:15 | x64      |
| Sqlagentlog.dll                              | 2017.140.3294.2 | 25992     | 14-Mar-20 | 02:15 | x64      |
| Sqlagentmail.dll                             | 2017.140.3294.2 | 46984     | 14-Mar-20 | 02:15 | x64      |
| Sqlboot.dll                                  | 2017.140.3294.2 | 190856    | 14-Mar-20 | 02:15 | x64      |
| Sqlceip.exe                                  | 14.0.3294.2     | 255096    | 14-Mar-20 | 02:02 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3294.2 | 67680     | 14-Mar-20 | 02:15 | x64      |
| Sqlctr140.dll                                | 2017.140.3294.2 | 106376    | 14-Mar-20 | 02:05 | x86      |
| Sqlctr140.dll                                | 2017.140.3294.2 | 123784    | 14-Mar-20 | 02:15 | x64      |
| Sqldk.dll                                    | 2017.140.3294.2 | 2799496   | 14-Mar-20 | 02:15 | x64      |
| Sqldtsss.dll                                 | 2017.140.3294.2 | 102280    | 14-Mar-20 | 02:15 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3595136   | 14-Mar-20 | 01:50 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3913608   | 14-Mar-20 | 01:50 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3916168   | 14-Mar-20 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3400584   | 14-Mar-20 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3778440   | 14-Mar-20 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3784072   | 14-Mar-20 | 01:51 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3336584   | 14-Mar-20 | 01:55 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 1440648   | 14-Mar-20 | 01:55 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3365768   | 14-Mar-20 | 01:55 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3479944   | 14-Mar-20 | 01:58 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3634568   | 14-Mar-20 | 01:59 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3819400   | 14-Mar-20 | 02:00 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3288968   | 14-Mar-20 | 02:01 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 4025736   | 14-Mar-20 | 02:01 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3675528   | 14-Mar-20 | 02:02 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 2086280   | 14-Mar-20 | 02:04 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3211656   | 14-Mar-20 | 02:06 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3295112   | 14-Mar-20 | 02:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3785608   | 14-Mar-20 | 02:08 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 3586952   | 14-Mar-20 | 02:09 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 2033032   | 14-Mar-20 | 02:10 | x64      |
| Sqlevn70.rll                                 | 2017.140.3294.2 | 1493384   | 14-Mar-20 | 02:12 | x64      |
| Sqliosim.com                                 | 2017.140.3294.2 | 306784    | 14-Mar-20 | 02:15 | x64      |
| Sqliosim.exe                                 | 2017.140.3294.2 | 3013000   | 14-Mar-20 | 02:15 | x64      |
| Sqllang.dll                                  | 2017.140.3294.2 | 41243528  | 14-Mar-20 | 02:15 | x64      |
| Sqlmin.dll                                   | 2017.140.3294.2 | 40417160  | 14-Mar-20 | 02:15 | x64      |
| Sqlolapss.dll                                | 2017.140.3294.2 | 102496    | 14-Mar-20 | 02:15 | x64      |
| Sqlos.dll                                    | 2017.140.3294.2 | 19552     | 14-Mar-20 | 02:15 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3294.2 | 63072     | 14-Mar-20 | 02:15 | x64      |
| Sqlrepss.dll                                 | 2017.140.3294.2 | 61832     | 14-Mar-20 | 02:15 | x64      |
| Sqlresld.dll                                 | 2017.140.3294.2 | 23944     | 14-Mar-20 | 02:15 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3294.2 | 25480     | 14-Mar-20 | 02:15 | x64      |
| Sqlscm.dll                                   | 2017.140.3294.2 | 66144     | 14-Mar-20 | 02:15 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3294.2 | 20872     | 14-Mar-20 | 02:15 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3294.2 | 5888392   | 14-Mar-20 | 02:15 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3294.2 | 725896    | 14-Mar-20 | 02:15 | x64      |
| Sqlservr.exe                                 | 2017.140.3294.2 | 481888    | 14-Mar-20 | 02:15 | x64      |
| Sqlsvc.dll                                   | 2017.140.3294.2 | 156248    | 14-Mar-20 | 02:15 | x64      |
| Sqltses.dll                                  | 2017.140.3294.2 | 9555848   | 14-Mar-20 | 02:15 | x64      |
| Sqsrvres.dll                                 | 2017.140.3294.2 | 255880    | 14-Mar-20 | 02:15 | x64      |
| Svl.dll                                      | 2017.140.3294.2 | 146824    | 14-Mar-20 | 02:15 | x64      |
| Xe.dll                                       | 2017.140.3294.2 | 666504    | 14-Mar-20 | 02:15 | x64      |
| Xmlrw.dll                                    | 2017.140.3294.2 | 298376    | 14-Mar-20 | 02:15 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3294.2 | 217696    | 14-Mar-20 | 02:15 | x64      |
| Xpadsi.exe                                   | 2017.140.3294.2 | 84872     | 14-Mar-20 | 02:15 | x64      |
| Xplog70.dll                                  | 2017.140.3294.2 | 71288     | 14-Mar-20 | 02:15 | x64      |
| Xpqueue.dll                                  | 2017.140.3294.2 | 68192     | 14-Mar-20 | 02:15 | x64      |
| Xprepl.dll                                   | 2017.140.3294.2 | 96648     | 14-Mar-20 | 02:15 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3294.2 | 25480     | 14-Mar-20 | 02:15 | x64      |
| Xpstar.dll                                   | 2017.140.3294.2 | 445320    | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 Database Services Core Shared

| File   name                                                 | File version    | File size | Date      | Time | Platform |
|-------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Batchparser.dll                                             | 2017.140.3294.2 | 153480    | 14-Mar-20 | 02:02 | x86      |
| Batchparser.dll                                             | 2017.140.3294.2 | 173960    | 14-Mar-20 | 02:13 | x64      |
| Bcp.exe                                                     | 2017.140.3294.2 | 113032    | 14-Mar-20 | 02:15 | x64      |
| Commanddest.dll                                             | 2017.140.3294.2 | 239200    | 14-Mar-20 | 02:13 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3294.2 | 109448    | 14-Mar-20 | 02:13 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3294.2 | 180832    | 14-Mar-20 | 02:13 | x64      |
| Distrib.exe                                                 | 2017.140.3294.2 | 198240    | 14-Mar-20 | 02:15 | x64      |
| Dteparse.dll                                                | 2017.140.3294.2 | 104536    | 14-Mar-20 | 02:13 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3294.2 | 82528     | 14-Mar-20 | 02:13 | x64      |
| Dtepkg.dll                                                  | 2017.140.3294.2 | 130952    | 14-Mar-20 | 02:13 | x64      |
| Dtexec.exe                                                  | 2017.140.3294.2 | 67168     | 14-Mar-20 | 02:13 | x64      |
| Dts.dll                                                     | 2017.140.3294.2 | 2994264   | 14-Mar-20 | 02:13 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3294.2 | 468360    | 14-Mar-20 | 02:13 | x64      |
| Dtsconn.dll                                                 | 2017.140.3294.2 | 493664    | 14-Mar-20 | 02:13 | x64      |
| Dtshost.exe                                                 | 2017.140.3294.2 | 99424     | 14-Mar-20 | 02:15 | x64      |
| Dtslog.dll                                                  | 2017.140.3294.2 | 113536    | 14-Mar-20 | 02:13 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3294.2 | 538720    | 14-Mar-20 | 02:15 | x64      |
| Dtspipeline.dll                                             | 2017.140.3294.2 | 1261664   | 14-Mar-20 | 02:13 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3294.2 | 41352     | 14-Mar-20 | 02:13 | x64      |
| Dtuparse.dll                                                | 2017.140.3294.2 | 82312     | 14-Mar-20 | 02:13 | x64      |
| Dtutil.exe                                                  | 2017.140.3294.2 | 141704    | 14-Mar-20 | 02:13 | x64      |
| Exceldest.dll                                               | 2017.140.3294.2 | 254048    | 14-Mar-20 | 02:13 | x64      |
| Excelsrc.dll                                                | 2017.140.3294.2 | 275848    | 14-Mar-20 | 02:13 | x64      |
| Execpackagetask.dll                                         | 2017.140.3294.2 | 161376    | 14-Mar-20 | 02:13 | x64      |
| Flatfiledest.dll                                            | 2017.140.3294.2 | 380024    | 14-Mar-20 | 02:13 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3294.2 | 392584    | 14-Mar-20 | 02:13 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3294.2 | 89480     | 14-Mar-20 | 02:13 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3294.2 | 52824     | 14-Mar-20 | 02:15 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 14-Mar-20 | 01:51 | x86      |
| Logread.exe                                                 | 2017.140.3294.2 | 629640    | 14-Mar-20 | 02:15 | x64      |
| Mergetxt.dll                                                | 2017.140.3294.2 | 58248     | 14-Mar-20 | 02:15 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.36     | 1374600   | 14-Mar-20 | 02:13 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3294.2     | 130952    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll    | 14.0.3294.2     | 48008     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3294.2     | 83040     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll      | 14.0.3294.2     | 66656     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                | 14.0.3294.2     | 384904    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3294.2     | 607112    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3294.2 | 1657736   | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3294.2     | 564856    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3294.2 | 145288    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3294.2 | 152456    | 14-Mar-20 | 02:13 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3294.2 | 96136     | 14-Mar-20 | 02:13 | x64      |
| Msgprox.dll                                                 | 2017.140.3294.2 | 265312    | 14-Mar-20 | 02:15 | x64      |
| Msxmlsql.dll                                                | 2017.140.3294.2 | 1441160   | 14-Mar-20 | 02:15 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 14-Mar-20 | 01:51 | x86      |
| Oledbdest.dll                                               | 2017.140.3294.2 | 254344    | 14-Mar-20 | 02:13 | x64      |
| Oledbsrc.dll                                                | 2017.140.3294.2 | 282208    | 14-Mar-20 | 02:13 | x64      |
| Osql.exe                                                    | 2017.140.3294.2 | 68488     | 14-Mar-20 | 02:13 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3294.2 | 469088    | 14-Mar-20 | 02:15 | x64      |
| Rawdest.dll                                                 | 2017.140.3294.2 | 199560    | 14-Mar-20 | 02:15 | x64      |
| Rawsource.dll                                               | 2017.140.3294.2 | 187272    | 14-Mar-20 | 02:15 | x64      |
| Rdistcom.dll                                                | 2017.140.3294.2 | 852360    | 14-Mar-20 | 02:15 | x64      |
| Recordsetdest.dll                                           | 2017.140.3294.2 | 177784    | 14-Mar-20 | 02:15 | x64      |
| Replagnt.dll                                                | 2017.140.3294.2 | 23944     | 14-Mar-20 | 02:15 | x64      |
| Repldp.dll                                                  | 2017.140.3294.2 | 285576    | 14-Mar-20 | 02:15 | x64      |
| Replerrx.dll                                                | 2017.140.3294.2 | 148872    | 14-Mar-20 | 02:15 | x64      |
| Replisapi.dll                                               | 2017.140.3294.2 | 357472    | 14-Mar-20 | 02:15 | x64      |
| Replmerg.exe                                                | 2017.140.3294.2 | 520072    | 14-Mar-20 | 02:15 | x64      |
| Replprov.dll                                                | 2017.140.3294.2 | 797280    | 14-Mar-20 | 02:15 | x64      |
| Replrec.dll                                                 | 2017.140.3294.2 | 970120    | 14-Mar-20 | 02:15 | x64      |
| Replsub.dll                                                 | 2017.140.3294.2 | 440416    | 14-Mar-20 | 02:15 | x64      |
| Replsync.dll                                                | 2017.140.3294.2 | 148360    | 14-Mar-20 | 02:15 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 14-Mar-20 | 02:15 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 14-Mar-20 | 02:15 | x64      |
| Spresolv.dll                                                | 2017.140.3294.2 | 247176    | 14-Mar-20 | 02:15 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3294.2 | 242272    | 14-Mar-20 | 02:15 | x64      |
| Sqldiag.exe                                                 | 2017.140.3294.2 | 1254792   | 14-Mar-20 | 02:15 | x64      |
| Sqldistx.dll                                                | 2017.140.3294.2 | 219744    | 14-Mar-20 | 02:15 | x64      |
| Sqllogship.exe                                              | 14.0.3294.2     | 98696     | 14-Mar-20 | 02:15 | x64      |
| Sqlmergx.dll                                                | 2017.140.3294.2 | 355208    | 14-Mar-20 | 02:15 | x64      |
| Sqlresld.dll                                                | 2017.140.3294.2 | 21896     | 14-Mar-20 | 02:03 | x86      |
| Sqlresld.dll                                                | 2017.140.3294.2 | 23944     | 14-Mar-20 | 02:15 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3294.2 | 22408     | 14-Mar-20 | 02:03 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3294.2 | 25480     | 14-Mar-20 | 02:15 | x64      |
| Sqlscm.dll                                                  | 2017.140.3294.2 | 55392     | 14-Mar-20 | 02:03 | x86      |
| Sqlscm.dll                                                  | 2017.140.3294.2 | 66144     | 14-Mar-20 | 02:15 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3294.2 | 128632    | 14-Mar-20 | 02:03 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3294.2 | 156248    | 14-Mar-20 | 02:15 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3294.2 | 177272    | 14-Mar-20 | 02:15 | x64      |
| Sqlwep140.dll                                               | 2017.140.3294.2 | 98696     | 14-Mar-20 | 02:15 | x64      |
| Ssdebugps.dll                                               | 2017.140.3294.2 | 26504     | 14-Mar-20 | 02:15 | x64      |
| Ssisoledb.dll                                               | 2017.140.3294.2 | 209496    | 14-Mar-20 | 02:15 | x64      |
| Ssradd.dll                                                  | 2017.140.3294.2 | 70240     | 14-Mar-20 | 02:15 | x64      |
| Ssravg.dll                                                  | 2017.140.3294.2 | 70752     | 14-Mar-20 | 02:15 | x64      |
| Ssrdown.dll                                                 | 2017.140.3294.2 | 55176     | 14-Mar-20 | 02:15 | x64      |
| Ssrmax.dll                                                  | 2017.140.3294.2 | 68488     | 14-Mar-20 | 02:15 | x64      |
| Ssrmin.dll                                                  | 2017.140.3294.2 | 68488     | 14-Mar-20 | 02:15 | x64      |
| Ssrpub.dll                                                  | 2017.140.3294.2 | 55904     | 14-Mar-20 | 02:15 | x64      |
| Ssrup.dll                                                   | 2017.140.3294.2 | 55392     | 14-Mar-20 | 02:15 | x64      |
| Tablediff.exe                                               | 14.0.3294.2     | 79752     | 14-Mar-20 | 02:15 | x64      |
| Txagg.dll                                                   | 2017.140.3294.2 | 355424    | 14-Mar-20 | 02:15 | x64      |
| Txbdd.dll                                                   | 2017.140.3294.2 | 163424    | 14-Mar-20 | 02:15 | x64      |
| Txdatacollector.dll                                         | 2017.140.3294.2 | 360328    | 14-Mar-20 | 02:15 | x64      |
| Txdataconvert.dll                                           | 2017.140.3294.2 | 286088    | 14-Mar-20 | 02:15 | x64      |
| Txderived.dll                                               | 2017.140.3294.2 | 597600    | 14-Mar-20 | 02:15 | x64      |
| Txlookup.dll                                                | 2017.140.3294.2 | 521312    | 14-Mar-20 | 02:15 | x64      |
| Txmerge.dll                                                 | 2017.140.3294.2 | 223328    | 14-Mar-20 | 02:15 | x64      |
| Txmergejoin.dll                                             | 2017.140.3294.2 | 268896    | 14-Mar-20 | 02:15 | x64      |
| Txmulticast.dll                                             | 2017.140.3294.2 | 120928    | 14-Mar-20 | 02:15 | x64      |
| Txrowcount.dll                                              | 2017.140.3294.2 | 118664    | 14-Mar-20 | 02:15 | x64      |
| Txsort.dll                                                  | 2017.140.3294.2 | 249736    | 14-Mar-20 | 02:15 | x64      |
| Txsplit.dll                                                 | 2017.140.3294.2 | 589920    | 14-Mar-20 | 02:15 | x64      |
| Txunionall.dll                                              | 2017.140.3294.2 | 177032    | 14-Mar-20 | 02:15 | x64      |
| Xe.dll                                                      | 2017.140.3294.2 | 666504    | 14-Mar-20 | 02:15 | x64      |
| Xmlrw.dll                                                   | 2017.140.3294.2 | 298376    | 14-Mar-20 | 02:15 | x64      |
| Xmlsub.dll                                                  | 2017.140.3294.2 | 255368    | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 sql_extensibility

| File   name                   | File version    | File size | Date      | Time | Platform |
|-------------------------------|-----------------|-----------|-----------|------|----------|
| Launchpad.exe                 | 2017.140.3294.2 | 1119112   | 14-Mar-20 | 02:15 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlsatellite.dll              | 2017.140.3294.2 | 917080    | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 Full-Text Engine

| File   name              | File version    | File size | Date      | Time | Platform |
|--------------------------|-----------------|-----------|-----------|------|----------|
| Fd.dll                   | 2017.140.3294.2 | 665696    | 14-Mar-20 | 02:15 | x64      |
| Fdhost.exe               | 2017.140.3294.2 | 109448    | 14-Mar-20 | 02:15 | x64      |
| Fdlauncher.exe           | 2017.140.3294.2 | 57440     | 14-Mar-20 | 02:15 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 14-Mar-20 | 02:15 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlft140ph.dll           | 2017.140.3294.2 | 62856     | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 sql_inst_mr

| File   name             | File version    | File size | Date      | Time | Platform |
|-------------------------|-----------------|-----------|-----------|------|----------|
| Imrdll.dll              | 14.0.3294.2     | 16776     | 14-Mar-20 | 02:13 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |

SQL Server 2017 Integration Services

| File   name                                                   | File version    | File size | Date      | Time | Platform |
|---------------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 14-Mar-20 | 02:02 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 14-Mar-20 | 02:13 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 14-Mar-20 | 02:02 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 14-Mar-20 | 02:13 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 14-Mar-20 | 02:02 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 14-Mar-20 | 02:13 | x86      |
| Commanddest.dll                                               | 2017.140.3294.2 | 193928    | 14-Mar-20 | 02:02 | x86      |
| Commanddest.dll                                               | 2017.140.3294.2 | 239200    | 14-Mar-20 | 02:13 | x64      |
| Dteparse.dll                                                  | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:02 | x86      |
| Dteparse.dll                                                  | 2017.140.3294.2 | 104536    | 14-Mar-20 | 02:13 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3294.2 | 76896     | 14-Mar-20 | 02:02 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3294.2 | 82528     | 14-Mar-20 | 02:13 | x64      |
| Dtepkg.dll                                                    | 2017.140.3294.2 | 110176    | 14-Mar-20 | 02:02 | x86      |
| Dtepkg.dll                                                    | 2017.140.3294.2 | 130952    | 14-Mar-20 | 02:13 | x64      |
| Dtexec.exe                                                    | 2017.140.3294.2 | 61528     | 14-Mar-20 | 02:02 | x86      |
| Dtexec.exe                                                    | 2017.140.3294.2 | 67168     | 14-Mar-20 | 02:13 | x64      |
| Dts.dll                                                       | 2017.140.3294.2 | 2544008   | 14-Mar-20 | 02:02 | x86      |
| Dts.dll                                                       | 2017.140.3294.2 | 2994264   | 14-Mar-20 | 02:13 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3294.2 | 411256    | 14-Mar-20 | 02:02 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3294.2 | 468360    | 14-Mar-20 | 02:13 | x64      |
| Dtsconn.dll                                                   | 2017.140.3294.2 | 395656    | 14-Mar-20 | 02:02 | x86      |
| Dtsconn.dll                                                   | 2017.140.3294.2 | 493664    | 14-Mar-20 | 02:13 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3294.2 | 88456     | 14-Mar-20 | 02:02 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3294.2 | 104328    | 14-Mar-20 | 02:13 | x64      |
| Dtshost.exe                                                   | 2017.140.3294.2 | 84576     | 14-Mar-20 | 02:05 | x86      |
| Dtshost.exe                                                   | 2017.140.3294.2 | 99424     | 14-Mar-20 | 02:15 | x64      |
| Dtslog.dll                                                    | 2017.140.3294.2 | 96136     | 14-Mar-20 | 02:02 | x86      |
| Dtslog.dll                                                    | 2017.140.3294.2 | 113536    | 14-Mar-20 | 02:13 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3294.2 | 534408    | 14-Mar-20 | 02:05 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3294.2 | 538720    | 14-Mar-20 | 02:15 | x64      |
| Dtspipeline.dll                                               | 2017.140.3294.2 | 1053576   | 14-Mar-20 | 02:02 | x86      |
| Dtspipeline.dll                                               | 2017.140.3294.2 | 1261664   | 14-Mar-20 | 02:13 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3294.2 | 35936     | 14-Mar-20 | 02:02 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3294.2 | 41352     | 14-Mar-20 | 02:13 | x64      |
| Dtuparse.dll                                                  | 2017.140.3294.2 | 73096     | 14-Mar-20 | 02:02 | x86      |
| Dtuparse.dll                                                  | 2017.140.3294.2 | 82312     | 14-Mar-20 | 02:13 | x64      |
| Dtutil.exe                                                    | 2017.140.3294.2 | 120928    | 14-Mar-20 | 02:02 | x86      |
| Dtutil.exe                                                    | 2017.140.3294.2 | 141704    | 14-Mar-20 | 02:13 | x64      |
| Exceldest.dll                                                 | 2017.140.3294.2 | 207752    | 14-Mar-20 | 02:02 | x86      |
| Exceldest.dll                                                 | 2017.140.3294.2 | 254048    | 14-Mar-20 | 02:13 | x64      |
| Excelsrc.dll                                                  | 2017.140.3294.2 | 223624    | 14-Mar-20 | 02:02 | x86      |
| Excelsrc.dll                                                  | 2017.140.3294.2 | 275848    | 14-Mar-20 | 02:13 | x64      |
| Execpackagetask.dll                                           | 2017.140.3294.2 | 128392    | 14-Mar-20 | 02:02 | x86      |
| Execpackagetask.dll                                           | 2017.140.3294.2 | 161376    | 14-Mar-20 | 02:13 | x64      |
| Flatfiledest.dll                                              | 2017.140.3294.2 | 325512    | 14-Mar-20 | 02:02 | x86      |
| Flatfiledest.dll                                              | 2017.140.3294.2 | 380024    | 14-Mar-20 | 02:13 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3294.2 | 337288    | 14-Mar-20 | 02:02 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3294.2 | 392584    | 14-Mar-20 | 02:13 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3294.2 | 73608     | 14-Mar-20 | 02:02 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3294.2 | 89480     | 14-Mar-20 | 02:13 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 14-Mar-20 | 01:51 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 14-Mar-20 | 02:16 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3294.2     | 460168    | 14-Mar-20 | 02:02 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3294.2     | 459872    | 14-Mar-20 | 02:13 | x64      |
| Isserverexec.exe                                              | 14.0.3294.2     | 142216    | 14-Mar-20 | 02:02 | x86      |
| Isserverexec.exe                                              | 14.0.3294.2     | 141704    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.36     | 1374600   | 14-Mar-20 | 02:03 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.36     | 1374600   | 14-Mar-20 | 02:13 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 14-Mar-20 | 02:02 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 14-Mar-20 | 02:16 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3294.2     | 67680     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3294.2 | 100448    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3294.2 | 105352    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3294.2     | 48008     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoop.common.dll      | 14.0.3294.2     | 48008     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3294.2     | 83032     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3294.2     | 83040     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3294.2     | 66440     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservice.hadooptasks.dll        | 14.0.3294.2     | 66656     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3294.2     | 505736    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3294.2     | 505736    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3294.2     | 76680     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3294.2     | 76680     | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3294.2     | 408968    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3294.2     | 408968    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 14.0.3294.2     | 384904    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3294.2     | 607112    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3294.2     | 607112    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3294.2     | 245856    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3294.2     | 245640    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3294.2 | 135048    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3294.2 | 145288    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3294.2 | 138848    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3294.2 | 152456    | 14-Mar-20 | 02:13 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3294.2     | 213088    | 14-Mar-20 | 02:15 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3294.2 | 83336     | 14-Mar-20 | 02:02 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3294.2 | 96136     | 14-Mar-20 | 02:13 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.36 | 9191816   | 14-Mar-20 | 02:15 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 14-Mar-20 | 01:51 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 14-Mar-20 | 01:59 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 14-Mar-20 | 02:12 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 14-Mar-20 | 02:16 | x86      |
| Oledbdest.dll                                                 | 2017.140.3294.2 | 207752    | 14-Mar-20 | 02:02 | x86      |
| Oledbdest.dll                                                 | 2017.140.3294.2 | 254344    | 14-Mar-20 | 02:13 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3294.2 | 226184    | 14-Mar-20 | 02:02 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3294.2 | 282208    | 14-Mar-20 | 02:13 | x64      |
| Rawdest.dll                                                   | 2017.140.3294.2 | 159840    | 14-Mar-20 | 02:03 | x86      |
| Rawdest.dll                                                   | 2017.140.3294.2 | 199560    | 14-Mar-20 | 02:15 | x64      |
| Rawsource.dll                                                 | 2017.140.3294.2 | 146312    | 14-Mar-20 | 02:03 | x86      |
| Rawsource.dll                                                 | 2017.140.3294.2 | 187272    | 14-Mar-20 | 02:15 | x64      |
| Recordsetdest.dll                                             | 2017.140.3294.2 | 142216    | 14-Mar-20 | 02:03 | x86      |
| Recordsetdest.dll                                             | 2017.140.3294.2 | 177784    | 14-Mar-20 | 02:15 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlceip.exe                                                   | 14.0.3294.2     | 255096    | 14-Mar-20 | 02:02 | x86      |
| Sqldest.dll                                                   | 2017.140.3294.2 | 206944    | 14-Mar-20 | 02:03 | x86      |
| Sqldest.dll                                                   | 2017.140.3294.2 | 254048    | 14-Mar-20 | 02:15 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3294.2 | 148360    | 14-Mar-20 | 02:03 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3294.2 | 177272    | 14-Mar-20 | 02:15 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3294.2 | 170080    | 14-Mar-20 | 02:03 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3294.2 | 209496    | 14-Mar-20 | 02:15 | x64      |
| Txagg.dll                                                     | 2017.140.3294.2 | 295304    | 14-Mar-20 | 02:05 | x86      |
| Txagg.dll                                                     | 2017.140.3294.2 | 355424    | 14-Mar-20 | 02:15 | x64      |
| Txbdd.dll                                                     | 2017.140.3294.2 | 132488    | 14-Mar-20 | 02:05 | x86      |
| Txbdd.dll                                                     | 2017.140.3294.2 | 163424    | 14-Mar-20 | 02:15 | x64      |
| Txbestmatch.dll                                               | 2017.140.3294.2 | 486496    | 14-Mar-20 | 02:05 | x86      |
| Txbestmatch.dll                                               | 2017.140.3294.2 | 598408    | 14-Mar-20 | 02:15 | x64      |
| Txcache.dll                                                   | 2017.140.3294.2 | 139144    | 14-Mar-20 | 02:05 | x86      |
| Txcache.dll                                                   | 2017.140.3294.2 | 173664    | 14-Mar-20 | 02:15 | x64      |
| Txcharmap.dll                                                 | 2017.140.3294.2 | 242056    | 14-Mar-20 | 02:05 | x86      |
| Txcharmap.dll                                                 | 2017.140.3294.2 | 279944    | 14-Mar-20 | 02:15 | x64      |
| Txcopymap.dll                                                 | 2017.140.3294.2 | 138848    | 14-Mar-20 | 02:05 | x86      |
| Txcopymap.dll                                                 | 2017.140.3294.2 | 173448    | 14-Mar-20 | 02:15 | x64      |
| Txdataconvert.dll                                             | 2017.140.3294.2 | 246368    | 14-Mar-20 | 02:05 | x86      |
| Txdataconvert.dll                                             | 2017.140.3294.2 | 286088    | 14-Mar-20 | 02:15 | x64      |
| Txderived.dll                                                 | 2017.140.3294.2 | 508808    | 14-Mar-20 | 02:05 | x86      |
| Txderived.dll                                                 | 2017.140.3294.2 | 597600    | 14-Mar-20 | 02:15 | x64      |
| Txfileextractor.dll                                           | 2017.140.3294.2 | 153992    | 14-Mar-20 | 02:05 | x86      |
| Txfileextractor.dll                                           | 2017.140.3294.2 | 192096    | 14-Mar-20 | 02:15 | x64      |
| Txfileinserter.dll                                            | 2017.140.3294.2 | 152456    | 14-Mar-20 | 02:05 | x86      |
| Txfileinserter.dll                                            | 2017.140.3294.2 | 189832    | 14-Mar-20 | 02:15 | x64      |
| Txgroupdups.dll                                               | 2017.140.3294.2 | 224136    | 14-Mar-20 | 02:05 | x86      |
| Txgroupdups.dll                                               | 2017.140.3294.2 | 283528    | 14-Mar-20 | 02:15 | x64      |
| Txlineage.dll                                                 | 2017.140.3294.2 | 103304    | 14-Mar-20 | 02:05 | x86      |
| Txlineage.dll                                                 | 2017.140.3294.2 | 130144    | 14-Mar-20 | 02:15 | x64      |
| Txlookup.dll                                                  | 2017.140.3294.2 | 439688    | 14-Mar-20 | 02:05 | x86      |
| Txlookup.dll                                                  | 2017.140.3294.2 | 521312    | 14-Mar-20 | 02:15 | x64      |
| Txmerge.dll                                                   | 2017.140.3294.2 | 169864    | 14-Mar-20 | 02:05 | x86      |
| Txmerge.dll                                                   | 2017.140.3294.2 | 223328    | 14-Mar-20 | 02:15 | x64      |
| Txmergejoin.dll                                               | 2017.140.3294.2 | 215136    | 14-Mar-20 | 02:05 | x86      |
| Txmergejoin.dll                                               | 2017.140.3294.2 | 268896    | 14-Mar-20 | 02:15 | x64      |
| Txmulticast.dll                                               | 2017.140.3294.2 | 95624     | 14-Mar-20 | 02:05 | x86      |
| Txmulticast.dll                                               | 2017.140.3294.2 | 120928    | 14-Mar-20 | 02:15 | x64      |
| Txpivot.dll                                                   | 2017.140.3294.2 | 173448    | 14-Mar-20 | 02:05 | x86      |
| Txpivot.dll                                                   | 2017.140.3294.2 | 218208    | 14-Mar-20 | 02:15 | x64      |
| Txrowcount.dll                                                | 2017.140.3294.2 | 94600     | 14-Mar-20 | 02:05 | x86      |
| Txrowcount.dll                                                | 2017.140.3294.2 | 118664    | 14-Mar-20 | 02:15 | x64      |
| Txsampling.dll                                                | 2017.140.3294.2 | 128904    | 14-Mar-20 | 02:05 | x86      |
| Txsampling.dll                                                | 2017.140.3294.2 | 165768    | 14-Mar-20 | 02:15 | x64      |
| Txscd.dll                                                     | 2017.140.3294.2 | 163208    | 14-Mar-20 | 02:05 | x86      |
| Txscd.dll                                                     | 2017.140.3294.2 | 213896    | 14-Mar-20 | 02:15 | x64      |
| Txsort.dll                                                    | 2017.140.3294.2 | 201096    | 14-Mar-20 | 02:05 | x86      |
| Txsort.dll                                                    | 2017.140.3294.2 | 249736    | 14-Mar-20 | 02:15 | x64      |
| Txsplit.dll                                                   | 2017.140.3294.2 | 503688    | 14-Mar-20 | 02:05 | x86      |
| Txsplit.dll                                                   | 2017.140.3294.2 | 589920    | 14-Mar-20 | 02:15 | x64      |
| Txtermextraction.dll                                          | 2017.140.3294.2 | 8608136   | 14-Mar-20 | 02:05 | x86      |
| Txtermextraction.dll                                          | 2017.140.3294.2 | 8669576   | 14-Mar-20 | 02:15 | x64      |
| Txtermlookup.dll                                              | 2017.140.3294.2 | 4100192   | 14-Mar-20 | 02:05 | x86      |
| Txtermlookup.dll                                              | 2017.140.3294.2 | 4150368   | 14-Mar-20 | 02:15 | x64      |
| Txunionall.dll                                                | 2017.140.3294.2 | 132488    | 14-Mar-20 | 02:05 | x86      |
| Txunionall.dll                                                | 2017.140.3294.2 | 177032    | 14-Mar-20 | 02:15 | x64      |
| Txunpivot.dll                                                 | 2017.140.3294.2 | 153480    | 14-Mar-20 | 02:05 | x86      |
| Txunpivot.dll                                                 | 2017.140.3294.2 | 193120    | 14-Mar-20 | 02:15 | x64      |
| Xe.dll                                                        | 2017.140.3294.2 | 588680    | 14-Mar-20 | 02:05 | x86      |
| Xe.dll                                                        | 2017.140.3294.2 | 666504    | 14-Mar-20 | 02:15 | x64      |

SQL Server 2017 sql_polybase_core_inst

| File   name                                                          | File version     | File size | Date      | Time | Platform |
|----------------------------------------------------------------------|------------------|-----------|-----------|------|----------|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 14-Mar-20 | 02:10 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 14-Mar-20 | 02:10 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 14-Mar-20 | 02:10 | x86      |
| Instapi140.dll                                                       | 2017.140.3294.2  | 65416     | 14-Mar-20 | 02:10 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 14-Mar-20 | 01:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 14-Mar-20 | 02:09 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 14-Mar-20 | 02:08 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 14-Mar-20 | 01:57 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 14-Mar-20 | 01:57 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 14-Mar-20 | 01:56 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 14-Mar-20 | 02:15 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 14-Mar-20 | 01:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 14-Mar-20 | 02:09 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 14-Mar-20 | 02:08 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 14-Mar-20 | 01:57 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 14-Mar-20 | 01:57 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 14-Mar-20 | 01:56 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 14-Mar-20 | 02:06 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 14-Mar-20 | 01:51 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 14-Mar-20 | 02:15 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 14-Mar-20 | 02:10 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 14-Mar-20 | 02:10 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3294.2  | 400264    | 14-Mar-20 | 02:10 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3294.2  | 7321184   | 14-Mar-20 | 02:10 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3294.2  | 2258016   | 14-Mar-20 | 02:10 | x64      |
| Secforwarder.dll                                                     | 2017.140.3294.2  | 30600     | 14-Mar-20 | 02:10 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 14-Mar-20 | 02:10 | x64      |
| Sqldk.dll                                                            | 2017.140.3294.2  | 2732424   | 14-Mar-20 | 02:10 | x64      |
| Sqldumper.exe                                                        | 2017.140.3294.2  | 138632    | 14-Mar-20 | 02:10 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 1493384   | 14-Mar-20 | 02:12 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3913608   | 14-Mar-20 | 01:50 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3211656   | 14-Mar-20 | 02:06 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3916168   | 14-Mar-20 | 01:51 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3819400   | 14-Mar-20 | 02:00 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 2086280   | 14-Mar-20 | 02:04 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 2033032   | 14-Mar-20 | 02:10 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3586952   | 14-Mar-20 | 02:09 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3595136   | 14-Mar-20 | 01:50 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 1440648   | 14-Mar-20 | 01:55 | x64      |
| Sqlevn70.rll                                                         | 2017.140.3294.2  | 3784072   | 14-Mar-20 | 01:51 | x64      |
| Sqlos.dll                                                            | 2017.140.3294.2  | 19552     | 14-Mar-20 | 02:10 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 14-Mar-20 | 02:10 | x64      |
| Sqltses.dll                                                          | 2017.140.3294.2  | 9729632   | 14-Mar-20 | 02:10 | x64      |

SQL Server 2017 sql_shared_mr

| File   name                        | File version    | File size | Date      | Time | Platform |
|------------------------------------|-----------------|-----------|-----------|------|----------|
| Smrdll.dll                         | 14.0.3294.2     | 16776     | 14-Mar-20 | 02:15 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |

SQL Server 2017 sql_tools_extensions

| File   name                                            | File version    | File size | Date      | Time | Platform |
|--------------------------------------------------------|-----------------|-----------|-----------|------|----------|
| Autoadmin.dll                                          | 2017.140.3294.2 | 1441672   | 14-Mar-20 | 02:05 | x86      |
| Dtaengine.exe                                          | 2017.140.3294.2 | 197512    | 14-Mar-20 | 02:02 | x86      |
| Dteparse.dll                                           | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:02 | x86      |
| Dteparse.dll                                           | 2017.140.3294.2 | 104536    | 14-Mar-20 | 02:13 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3294.2 | 76896     | 14-Mar-20 | 02:02 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3294.2 | 82528     | 14-Mar-20 | 02:13 | x64      |
| Dtepkg.dll                                             | 2017.140.3294.2 | 110176    | 14-Mar-20 | 02:02 | x86      |
| Dtepkg.dll                                             | 2017.140.3294.2 | 130952    | 14-Mar-20 | 02:13 | x64      |
| Dtexec.exe                                             | 2017.140.3294.2 | 61528     | 14-Mar-20 | 02:02 | x86      |
| Dtexec.exe                                             | 2017.140.3294.2 | 67168     | 14-Mar-20 | 02:13 | x64      |
| Dts.dll                                                | 2017.140.3294.2 | 2544008   | 14-Mar-20 | 02:02 | x86      |
| Dts.dll                                                | 2017.140.3294.2 | 2994264   | 14-Mar-20 | 02:13 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3294.2 | 411256    | 14-Mar-20 | 02:02 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3294.2 | 468360    | 14-Mar-20 | 02:13 | x64      |
| Dtsconn.dll                                            | 2017.140.3294.2 | 395656    | 14-Mar-20 | 02:02 | x86      |
| Dtsconn.dll                                            | 2017.140.3294.2 | 493664    | 14-Mar-20 | 02:13 | x64      |
| Dtshost.exe                                            | 2017.140.3294.2 | 84576     | 14-Mar-20 | 02:05 | x86      |
| Dtshost.exe                                            | 2017.140.3294.2 | 99424     | 14-Mar-20 | 02:15 | x64      |
| Dtslog.dll                                             | 2017.140.3294.2 | 96136     | 14-Mar-20 | 02:02 | x86      |
| Dtslog.dll                                             | 2017.140.3294.2 | 113536    | 14-Mar-20 | 02:13 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3294.2 | 534408    | 14-Mar-20 | 02:05 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3294.2 | 538720    | 14-Mar-20 | 02:15 | x64      |
| Dtspipeline.dll                                        | 2017.140.3294.2 | 1053576   | 14-Mar-20 | 02:02 | x86      |
| Dtspipeline.dll                                        | 2017.140.3294.2 | 1261664   | 14-Mar-20 | 02:13 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3294.2 | 35936     | 14-Mar-20 | 02:02 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3294.2 | 41352     | 14-Mar-20 | 02:13 | x64      |
| Dtuparse.dll                                           | 2017.140.3294.2 | 73096     | 14-Mar-20 | 02:02 | x86      |
| Dtuparse.dll                                           | 2017.140.3294.2 | 82312     | 14-Mar-20 | 02:13 | x64      |
| Dtutil.exe                                             | 2017.140.3294.2 | 120928    | 14-Mar-20 | 02:02 | x86      |
| Dtutil.exe                                             | 2017.140.3294.2 | 141704    | 14-Mar-20 | 02:13 | x64      |
| Exceldest.dll                                          | 2017.140.3294.2 | 207752    | 14-Mar-20 | 02:02 | x86      |
| Exceldest.dll                                          | 2017.140.3294.2 | 254048    | 14-Mar-20 | 02:13 | x64      |
| Excelsrc.dll                                           | 2017.140.3294.2 | 223624    | 14-Mar-20 | 02:02 | x86      |
| Excelsrc.dll                                           | 2017.140.3294.2 | 275848    | 14-Mar-20 | 02:13 | x64      |
| Flatfiledest.dll                                       | 2017.140.3294.2 | 325512    | 14-Mar-20 | 02:02 | x86      |
| Flatfiledest.dll                                       | 2017.140.3294.2 | 380024    | 14-Mar-20 | 02:13 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3294.2 | 337288    | 14-Mar-20 | 02:02 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3294.2 | 392584    | 14-Mar-20 | 02:13 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3294.2 | 73608     | 14-Mar-20 | 02:02 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3294.2 | 89480     | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3294.2     | 67464     | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3294.2     | 179800    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3294.2     | 403040    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3294.2     | 403040    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3294.2     | 2086280   | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3294.2     | 2086280   | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3294.2     | 607112    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3294.2     | 607112    | 14-Mar-20 | 02:13 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3294.2     | 245856    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3294.2 | 135048    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3294.2 | 145288    | 14-Mar-20 | 02:13 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3294.2 | 138848    | 14-Mar-20 | 02:03 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3294.2 | 152456    | 14-Mar-20 | 02:13 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3294.2 | 83336     | 14-Mar-20 | 02:02 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3294.2 | 96136     | 14-Mar-20 | 02:13 | x64      |
| Msmgdsrv.dll                                           | 2017.140.249.36 | 7304584   | 14-Mar-20 | 02:05 | x86      |
| Oledbdest.dll                                          | 2017.140.3294.2 | 207752    | 14-Mar-20 | 02:02 | x86      |
| Oledbdest.dll                                          | 2017.140.3294.2 | 254344    | 14-Mar-20 | 02:13 | x64      |
| Oledbsrc.dll                                           | 2017.140.3294.2 | 226184    | 14-Mar-20 | 02:02 | x86      |
| Oledbsrc.dll                                           | 2017.140.3294.2 | 282208    | 14-Mar-20 | 02:13 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3294.2 | 93576     | 14-Mar-20 | 02:13 | x64      |
| Sqlresld.dll                                           | 2017.140.3294.2 | 21896     | 14-Mar-20 | 02:03 | x86      |
| Sqlresld.dll                                           | 2017.140.3294.2 | 23944     | 14-Mar-20 | 02:15 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3294.2 | 22408     | 14-Mar-20 | 02:03 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3294.2 | 25480     | 14-Mar-20 | 02:15 | x64      |
| Sqlscm.dll                                             | 2017.140.3294.2 | 55392     | 14-Mar-20 | 02:03 | x86      |
| Sqlscm.dll                                             | 2017.140.3294.2 | 66144     | 14-Mar-20 | 02:15 | x64      |
| Sqlsvc.dll                                             | 2017.140.3294.2 | 128632    | 14-Mar-20 | 02:03 | x86      |
| Sqlsvc.dll                                             | 2017.140.3294.2 | 156248    | 14-Mar-20 | 02:15 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3294.2 | 148360    | 14-Mar-20 | 02:03 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3294.2 | 177272    | 14-Mar-20 | 02:15 | x64      |
| Txdataconvert.dll                                      | 2017.140.3294.2 | 246368    | 14-Mar-20 | 02:05 | x86      |
| Txdataconvert.dll                                      | 2017.140.3294.2 | 286088    | 14-Mar-20 | 02:15 | x64      |
| Xe.dll                                                 | 2017.140.3294.2 | 588680    | 14-Mar-20 | 02:05 | x86      |
| Xe.dll                                                 | 2017.140.3294.2 | 666504    | 14-Mar-20 | 02:15 | x64      |
| Xmlrw.dll                                              | 2017.140.3294.2 | 250760    | 14-Mar-20 | 02:05 | x86      |
| Xmlrw.dll                                              | 2017.140.3294.2 | 298376    | 14-Mar-20 | 02:15 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3294.2 | 182880    | 14-Mar-20 | 02:05 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3294.2 | 217696    | 14-Mar-20 | 02:15 | x64      |

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
