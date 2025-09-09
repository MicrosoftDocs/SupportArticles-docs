---
title: Cumulative update 16 for SQL Server 2017 (KB4508218)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2017 cumulative update 16 (KB4508218).
ms.date: 07/26/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB4508218, linux-related-content
appliesto:
- SQL Server 2017 on Windows
- SQL Server 2017 on Linux
---

# KB4508218 - Cumulative Update 16 for SQL Server 2017

_Release Date:_ &nbsp; August 01, 2019  
_Version:_ &nbsp; 14.0.3223.3

## Summary

> [!NOTE]
> Due to a change made in SQL Server 2017 CU16, any single-stripe TDE compressed backups taken on SQL Server 2017 CU7 through CU12 will not be able to be restored on SQL Server 2017 CU16. Downgrade to the previous CU in order to restore these backups. This issue will be fixed in a future CU.

This article describes Cumulative Update package 16 (CU16) for Microsoft SQL Server 2017. This update contains 40 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2017 Cumulative Update 15, and it updates components in the following builds:

- SQL Server - Product version: **14.0.3223.3**, file version: **2017.140.3223.3**
- Analysis Services - Product version: **14.0.249.14**, file version: **2017.140.249.14**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2019 and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference | Description | Fix area | Component | Platform |
|---|---|---|---|---|
| <a id="12887076">[12887076](#12887076)</a> | [FIX: Refresh command stops responding occasionally because of thread deadlock in SSAS 2017 Tabular mode (KB4501542)](https://support.microsoft.com/help/4501542) | Analysis Services | Analysis Services | Windows |
| <a id="12905640">[12905640](#12905640)</a> | [FIX: Database is inaccessible when you upgrade tabular model compatibility level from 1103 to 1400 in SQL Server 2017 (KB4513235)](https://support.microsoft.com/help/4513235) | Analysis Services | Analysis Services | Windows |
| <a id="12947204">[12947204](#12947204)</a> | [FIX: Database may crash when multiple threads update permissions on the same database in SQL Server 2016 and 2017 (KB4497222)](https://support.microsoft.com/help/4497222) | Analysis Services | Analysis Services | Windows |
| <a id="12991748">[12991748](#12991748)</a> | [FIX: Data processing is much slower in SSAS 2016 SP2 and 2017 than in SSAS 2016 SP1 (KB4508621)](https://support.microsoft.com/help/4508621) | Analysis Services | Analysis Services | Windows |
| <a id="13017382">[13017382](#13017382)</a> | [FIX: SSAS 2017 crashes intermittently due to c0000005 Access violation error (KB4512603)](https://support.microsoft.com/help/4512603) | Analysis Services | Analysis Services | Windows |
| <a id="12119927">[12119927](#12119927)</a> | [FIX: Deadlock errors when you run an SSIS package in parallel in SQL Server (KB4338773)](https://support.microsoft.com/help/4338773) | Integration Services | Integration Services | Windows |
| <a id="13002397">[13002397](#13002397)</a> | [FIX: Unexpected index will be deleted when you delete attribute including index in SQL Server 2017 (KB4509084)](https://support.microsoft.com/help/4509084) | Master Data Services | Server | Windows |
| <a id="12680777">[12680777](#12680777)</a> | [FIX: Intermittent failures when you back up to Azure storage from SQL Server 2017 (KB4514829)](https://support.microsoft.com/help/4514829) | SQL Server Engine | Backup Restore | Windows |
| <a id="12757005">[12757005](#12757005)</a> | [FIX: Error occurs when you back up a virtual machine with non-component based backup in SQL Server 2016 and 2017 (KB4493364)](https://support.microsoft.com/help/4493364) | SQL Server Engine | Backup Restore | Windows |
| <a id="12978596">[12978596](#12978596)</a> | [FIX: Restore or RESTORE VERIFYONLY of a TDE-compressed backup fails in SQL Server 2016 and 2017 (KB4513097)](https://support.microsoft.com/help/4513097) | SQL Server Engine | Backup Restore | Windows |
| <a id="12965938">[12965938](#12965938)</a> | [FIX: Access violation occurs when you insert LOB data in Clustered Columnstore Index in SQL Server 2017 (KB4512026)](https://support.microsoft.com/help/4512026) | SQL Server Engine | Column Stores | All |
| <a id="13051092">[13051092](#13051092)</a> | [FIX: Poor performance occurs when you run a query against columnstore in an RCSI-enabled database in SQL Server 2016 and 2017 (KB4459709)](https://support.microsoft.com/help/4459709) | SQL Server Engine | Column Stores | Windows |
| <a id="13017918">[13017918](#13017918)</a> | [FIX: Prolonged non-transactional usage of FileTable without instance restart may cause non-yielding scheduler error or server crash in SQL Server 2017 (KB4510934)](https://support.microsoft.com/help/4510934) | SQL Server Engine | FileStream and FileTable | Windows |
| <a id="12827636">[12827636](#12827636)</a> | [FIX: Internal thread deadlock may occur on primary or secondary replica of availability group in SQL Server 2016 SP2 and 2017 (KB4513236)](https://support.microsoft.com/help/4513236) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12947197">[12947197](#12947197)</a> | [FIX: Access violation occurs when you query sys.dm_hadr_availability_replica_states in SQL Server 2016 and 2017 (KB4491560)](https://support.microsoft.com/help/4491560) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12947201">[12947201](#12947201)</a> | [FIX: Access violation occurs when you run a query against sys.availability_replicas in SQL Server 2016 and 2017 (KB4494225)](https://support.microsoft.com/help/4494225) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12960368">[12960368](#12960368)</a> | [FIX: "sys.fn_hadr_backup_is_preferred_replica(database)" query fails for WSFC type in SQL Server 2017 (KB4508623)](https://support.microsoft.com/help/4508623) | SQL Server Engine | High Availability and Disaster Recovery | Windows |
| <a id="12996125">[12996125](#12996125)</a> | [FIX: Async secondary replica receives logs from primary replica in SQL Server 2017 on Linux but it doesn't harden or redone (KB4513237)](https://support.microsoft.com/help/4513237) | SQL Server Engine | High Availability and Disaster Recovery | All |
| <a id="12947196">[12947196](#12947196)</a> | [FIX: Assertion error occurs when you run a query to access sys.dm_db_xtp_checkpoint_files in SQL Server 2016 and 2017 (KB4502428)](https://support.microsoft.com/help/4502428) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="12969979">[12969979](#12969979)</a> | [FIX: Resolving state occurs when an assertion occurs in SQL Server 2017 (KB4511885)](https://support.microsoft.com/help/4511885) | SQL Server Engine | In-Memory OLTP | Windows |
| <a id="13042973">[13042973](#13042973)</a> | [Improvement: Microsoft Distributed Transaction Coordinator is enabled on Linux in SQL Server 2017 (KB4512820)](https://support.microsoft.com/help/4512820) | SQL Server Engine | Linux | Linux |
| <a id="12283135">[12283135](#12283135)</a> | [FIX: Access violation occurs when you start the Full-Text service in Linux in SQL Server 2017 (KB4513095)](https://support.microsoft.com/help/4513095) | SQL Server Engine | Linux | Linux |
| <a id="12352573">[12352573](#12352573)</a> | [FIX: SQL Server 2017 on Linux fails in script upgrade mode for the database SSISDB after you apply CU9 (KB4512979)](https://support.microsoft.com/help/4512979) | SQL Server Engine | Linux | Linux |
| <a id="13035016">[13035016](#13035016)</a> | [FIX: Slow performance occurs as CMEMTHREAD waiting occurs due to temporary table cachestore memory object contention in SQL Server 2016 and 2017 (KB4578496)](https://support.microsoft.com/help/4578496) | SQL Server Engine | Metadata | Windows |
| <a id="13042881">[13042881](#13042881)</a> | [FIX: Querying sys.tables returns temporary tables created by concurrent users starting from SQL Server 2012 (KB4512956)](https://support.microsoft.com/help/4512956) | SQL Server Engine | Metadata | Windows |
| <a id="13019220">[13019220](#13019220)</a> | [FIX: Extended event sql_statement_post_compile doesn't populate object_name field in SQL Server 2017 (KB4512150)](https://support.microsoft.com/help/4512150) | SQL Server Engine | Programmability | Windows |
| <a id="12822164">[12822164](#12822164)</a> | [FIX: Filtered index may be corrupted when you rebuild index in parallel in SQL Server 2017 (KB4489150)](https://support.microsoft.com/help/4489150) | SQL Server Engine | Query Optimizer | All |
| <a id="12883479">[12883479](#12883479)</a> | [FIX: DBCC SHOW_STATISTICS permission check fails with an AV error in SQL Server 2016 and 2017 (KB4511593)](https://support.microsoft.com/help/4511593) | SQL Server Engine | Query Optimizer | Windows |
| <a id="12942301">[12942301](#12942301)</a> | [FIX: Access Violation occurs when you use LOG function with a remote query in SQL Server 2016 or 2017 (KB4512151)](https://support.microsoft.com/help/4512151) | SQL Server Engine | Query Optimizer | All |
| <a id="12947206">[12947206](#12947206)</a> | [FIX: SQL Server 2017 doesn't perform the requested pre-row assignments when you use MERGE statement that performs assignments of local variables for each row (KB4502400)](https://support.microsoft.com/help/4502400) | SQL Server Engine | Query Optimizer | All |
| <a id="12912593">[12912593](#12912593)</a> | [FIX: Filled transaction log causes outages when you run Query Store in SQL Server 2016 and 2017 (KB4511715)](https://support.microsoft.com/help/4511715) | SQL Server Engine | Query Store | Windows |
| <a id="12947202">[12947202](#12947202)</a> | [FIX: Adding new Publication may fail if distribution database is in AG and collation is set to BIN in SQL Server 2016 and 2017 (KB4494805)](https://support.microsoft.com/help/4494805) | SQL Server Engine | Replication | Windows |
| <a id="13010512">[13010512](#13010512)</a> | [FIX: Intermittent "row not found" error at Azure SQL DB Subscriber caused by duplication of BEGIN TRAN statements (KB4508472)](https://support.microsoft.com/help/4508472) | SQL Server Engine | Replication | Windows |
| <a id="13045214">[13045214](#13045214)</a> | [FIX: Syscommittab cleanup causes a lock escalation that will block the syscommittab flush in SQL Server 2017 (KB4512016)](https://support.microsoft.com/help/4512016) | SQL Server Engine | Replication | Windows |
| <a id="12963180">[12963180](#12963180)</a> | [FIX: Data masking may not be applied when you use PIVOT or UNPIVOT function on masked column in SQL Server 2016 and 2017 (KB4512130)](https://support.microsoft.com/help/4512130) | SQL Server Engine | Security Infrastructure | Windows |
| <a id="12965328">[12965328](#12965328)</a> | [FIX: Login to SQL Server 2017 on Linux takes more time with SQL authentication than SQL Server 2017 on Windows (KB4508065)](https://support.microsoft.com/help/4508065) | SQL Server Engine | Security Infrastructure | Linux |
| <a id="12949744">[12949744](#12949744)</a> | [FIX: Geocentric Datum of Australia 2020 is added to SQL Server 2017 (KB4506023)](https://support.microsoft.com/help/4506023) | SQL Server Engine | Spatial | All |
| <a id="12870479">[12870479](#12870479)</a> | [FIX: SQL Server 2017 on Linux fails with last chance exception error (KB4512210)](https://support.microsoft.com/help/4512210) | SQL Server Engine | SQL OS | Linux |
| <a id="12947198">[12947198](#12947198)</a> | [FIX: Indirect checkpoints on tempdb database cause "Non-yielding scheduler" error in SQL Server 2016 and 2017 (KB4497928)](https://support.microsoft.com/help/4497928) | SQL Server Engine | Transaction Services | All |
| <a id="13049894">[13049894](#13049894)</a> | [FIX: Repair fails for Machine Learning components on server with no Internet access (KB4513096)](https://support.microsoft.com/help/4513096) | SQL Setup | Deployment Platform | Windows |

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

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2017 CU16 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2019/07/sqlserver2017-kb4508218-x64_a7fefaa78e201c654262066d84eb5e1c1fbe3282.exe)

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2017 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2017 Release Notes](/sql/linux/sql-server-linux-release-notes-2017#cuinstall).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2017-KB4508218-x64.exe* file by using the following command:

`certutil -hashfile SQLServer2017-KB4508218-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2017-KB4508218-x64.exe| 3F2A21CB6D68DB0F184416C903815D3798A3E5883E61D1A4FC78D679F9FDF15F |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2017 Analysis Services

|                      File name                     |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                 | 2017.140.249.14 | 266336    | 13-Jul-19 | 04:32 | x64      |
| Microsoft.analysisservices.minterop.dll            | 14.0.249.14     | 741688    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.analysisservices.server.core.dll         | 14.0.249.14     | 1380664   | 13-Jul-19 | 04:32 | x86      |
| Microsoft.analysisservices.server.tabular.dll      | 14.0.249.14     | 984168    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.analysisservices.server.tabular.json.dll | 14.0.249.14     | 521320    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.applicationinsights.dll                  | 2.7.0.13435     | 329872    | 13-Jul-19 | 04:26 | x86      |
| Microsoft.data.mashup.dll                          | 2.57.5068.261   | 180424    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.data.mashup.oledb.dll                    | 2.57.5068.261   | 37584     | 13-Jul-19 | 04:31 | x86      |
| Microsoft.data.mashup.preview.dll                  | 2.57.5068.261   | 54472     | 13-Jul-19 | 04:31 | x86      |
| Microsoft.data.mashup.providercommon.dll           | 2.57.5068.261   | 107728    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.hostintegration.connectors.dll           | 2.57.5068.261   | 5223112   | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashup.container.exe                     | 2.57.5068.261   | 26312     | 13-Jul-19 | 04:31 | x64      |
| Microsoft.mashup.container.netfx40.exe             | 2.57.5068.261   | 26824     | 13-Jul-19 | 04:31 | x64      |
| Microsoft.mashup.container.netfx45.exe             | 2.57.5068.261   | 26824     | 13-Jul-19 | 04:31 | x64      |
| Microsoft.mashup.eventsource.dll                   | 2.57.5068.261   | 159440    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashup.oauth.dll                         | 2.57.5068.261   | 84176     | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashup.oledbprovider.dll                 | 2.57.5068.261   | 67280     | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashup.shims.dll                         | 2.57.5068.261   | 25808     | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll        | 1.0.0.0         | 151240    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.mashupengine.dll                         | 2.57.5068.261   | 13608144  | 13-Jul-19 | 04:31 | x86      |
| Microsoft.powerbi.adomdclient.dll                  | 15.0.1.272      | 1106088   | 13-Jul-19 | 04:31 | x86      |
| Msmdctr.dll                                        | 2017.140.249.14 | 40248     | 13-Jul-19 | 04:33 | x64      |
| Msmdlocal.dll                                      | 2017.140.249.14 | 40413792  | 13-Jul-19 | 04:20 | x86      |
| Msmdlocal.dll                                      | 2017.140.249.14 | 60753208  | 13-Jul-19 | 04:33 | x64      |
| Msmdpump.dll                                       | 2017.140.249.14 | 9338984   | 13-Jul-19 | 04:33 | x64      |
| Msmdredir.dll                                      | 2017.140.249.14 | 7095392   | 13-Jul-19 | 04:20 | x86      |
| Msmdsrv.exe                                        | 2017.140.249.14 | 60651616  | 13-Jul-19 | 04:33 | x64      |
| Msmgdsrv.dll                                       | 2017.140.249.14 | 7311456   | 13-Jul-19 | 04:20 | x86      |
| Msmgdsrv.dll                                       | 2017.140.249.14 | 9007416   | 13-Jul-19 | 04:33 | x64      |
| Msolap.dll                                         | 2017.140.249.14 | 7779944   | 13-Jul-19 | 04:20 | x86      |
| Msolap.dll                                         | 2017.140.249.14 | 10262632  | 13-Jul-19 | 04:33 | x64      |
| Msolui.dll                                         | 2017.140.249.14 | 287544    | 13-Jul-19 | 04:20 | x86      |
| Msolui.dll                                         | 2017.140.249.14 | 310888    | 13-Jul-19 | 04:33 | x64      |
| Powerbiextensions.dll                              | 2.57.5068.261   | 6606536   | 13-Jul-19 | 04:31 | x86      |
| Sql_as_keyfile.dll                                 | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlboot.dll                                        | 2017.140.3223.3 | 196200    | 13-Jul-19 | 04:33 | x64      |
| Sqlceip.exe                                        | 14.0.3223.3     | 261944    | 13-Jul-19 | 04:26 | x86      |
| Sqldumper.exe                                      | 2017.140.3223.3 | 121960    | 13-Jul-19 | 04:27 | x86      |
| Sqldumper.exe                                      | 2017.140.3223.3 | 144184    | 13-Jul-19 | 04:34 | x64      |
| Tmapi.dll                                          | 2017.140.249.14 | 5821752   | 13-Jul-19 | 04:33 | x64      |
| Tmcachemgr.dll                                     | 2017.140.249.14 | 4164920   | 13-Jul-19 | 04:33 | x64      |
| Tmpersistence.dll                                  | 2017.140.249.14 | 1132136   | 13-Jul-19 | 04:33 | x64      |
| Tmtransactions.dll                                 | 2017.140.249.14 | 1641064   | 13-Jul-19 | 04:33 | x64      |
| Xe.dll                                             | 2017.140.3223.3 | 673384    | 13-Jul-19 | 04:33 | x64      |
| Xmlrw.dll                                          | 2017.140.3223.3 | 257640    | 13-Jul-19 | 04:20 | x86      |
| Xmlrw.dll                                          | 2017.140.3223.3 | 305256    | 13-Jul-19 | 04:33 | x64      |
| Xmlrwbin.dll                                       | 2017.140.3223.3 | 189544    | 13-Jul-19 | 04:20 | x86      |
| Xmlrwbin.dll                                       | 2017.140.3223.3 | 224360    | 13-Jul-19 | 04:33 | x64      |
| Xmsrv.dll                                          | 2017.140.249.14 | 33353312  | 13-Jul-19 | 04:20 | x86      |
| Xmsrv.dll                                          | 2017.140.249.14 | 25379432  | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 Database Services Common Core

|                  File name                 |   File version   | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                            | 2017.140.3223.3  | 160568    | 13-Jul-19 | 04:19 | x86      |
| Batchparser.dll                            | 2017.140.3223.3  | 180840    | 13-Jul-19 | 04:32 | x64      |
| Instapi140.dll                             | 2017.140.3223.3  | 61032     | 13-Jul-19 | 04:20 | x86      |
| Instapi140.dll                             | 2017.140.3223.3  | 70760     | 13-Jul-19 | 04:33 | x64      |
| Isacctchange.dll                           | 2017.140.3223.3  | 29504     | 13-Jul-19 | 04:19 | x86      |
| Isacctchange.dll                           | 2017.140.3223.3  | 30816     | 13-Jul-19 | 04:32 | x64      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.14      | 1088824   | 13-Jul-19 | 04:19 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 14.0.249.14      | 1088616   | 13-Jul-19 | 04:32 | x86      |
| Microsoft.analysisservices.core.dll        | 14.0.249.14      | 1381688   | 13-Jul-19 | 04:19 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.14      | 741688    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.analysisservices.xmla.dll        | 14.0.249.14      | 741688    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlserver.edition.dll            | 14.0.3223.3      | 36960     | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3223.3  | 78440     | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.mgdsqldumper.v4x.dll   | 2017.140.3223.3  | 82024     | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3223.3      | 571496    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.rmo.dll                | 14.0.3223.3      | 571496    | 13-Jul-19 | 04:33 | x86      |
| Msasxpress.dll                             | 2017.140.249.14  | 31848     | 13-Jul-19 | 04:20 | x86      |
| Msasxpress.dll                             | 2017.140.249.14  | 35936     | 13-Jul-19 | 04:33 | x64      |
| Pbsvcacctsync.dll                          | 2017.140.3223.3  | 68200     | 13-Jul-19 | 04:20 | x86      |
| Pbsvcacctsync.dll                          | 2017.140.3223.3  | 82536     | 13-Jul-19 | 04:33 | x64      |
| Sql_common_core_keyfile.dll                | 2017.140.3223.3  | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqldumper.exe                              | 2017.140.3223.3  | 121960    | 13-Jul-19 | 04:27 | x86      |
| Sqldumper.exe                              | 2017.140.3223.3  | 144184    | 13-Jul-19 | 04:34 | x64      |
| Sqlftacct.dll                              | 2017.140.3223.3  | 55400     | 13-Jul-19 | 04:20 | x86      |
| Sqlftacct.dll                              | 2017.140.3223.3  | 62568     | 13-Jul-19 | 04:33 | x64      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 602848    | 13-Jul-19 | 04:20 | x86      |
| Sqlmanager.dll                             | 2017.140.17218.0 | 734952    | 13-Jul-19 | 04:33 | x64      |
| Sqlmgmprovider.dll                         | 2017.140.3223.3  | 373864    | 13-Jul-19 | 04:20 | x86      |
| Sqlmgmprovider.dll                         | 2017.140.3223.3  | 418920    | 13-Jul-19 | 04:33 | x64      |
| Sqlsecacctchg.dll                          | 2017.140.3223.3  | 34920     | 13-Jul-19 | 04:20 | x86      |
| Sqlsecacctchg.dll                          | 2017.140.3223.3  | 37480     | 13-Jul-19 | 04:33 | x64      |
| Sqlsvcsync.dll                             | 2017.140.3223.3  | 273512    | 13-Jul-19 | 04:20 | x86      |
| Sqlsvcsync.dll                             | 2017.140.3223.3  | 355944    | 13-Jul-19 | 04:33 | x64      |
| Sqltdiagn.dll                              | 2017.140.3223.3  | 60520     | 13-Jul-19 | 04:20 | x86      |
| Sqltdiagn.dll                              | 2017.140.3223.3  | 67688     | 13-Jul-19 | 04:33 | x64      |
| Svrenumapi140.dll                          | 2017.140.3223.3  | 894056    | 13-Jul-19 | 04:20 | x86      |
| Svrenumapi140.dll                          | 2017.140.3223.3  | 1173608   | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 Data Quality Client

|      File name      |   File version  | File size |    Date   |  Time | Platform |
|:-------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dumpbin.exe         | 12.10.30102.2   | 24624     | 13-Jul-19 | 04:20 | x86      |
| Link.exe            | 12.10.30102.2   | 852528    | 13-Jul-19 | 04:20 | x86      |
| Mspdb120.dll        | 12.10.30102.2   | 259632    | 13-Jul-19 | 04:20 | x86      |
| Sql_dqc_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Stdole.dll          | 7.0.9466.0      | 32296     | 13-Jul-19 | 04:20 | x86      |

SQL Server 2017 Data Quality

|                     File name                     | File version | File size |    Date   |  Time | Platform |
|:-------------------------------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.practices.enterpriselibrary.common.dll  | 4.1.0.0      | 208648    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.practices.enterpriselibrary.logging.dll | 4.1.0.0      | 264968    | 13-Jul-19 | 04:32 | x86      |

SQL Server 2017 sql_dreplay_client

|            File name           |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplayclient.exe              | 2017.140.3223.3 | 121144    | 13-Jul-19 | 04:19 | x86      |
| Dreplaycommon.dll              | 2017.140.3223.3 | 698984    | 13-Jul-19 | 04:19 | x86      |
| Dreplayserverps.dll            | 2017.140.3223.3 | 32872     | 13-Jul-19 | 04:19 | x86      |
| Dreplayutil.dll                | 2017.140.3223.3 | 310072    | 13-Jul-19 | 04:19 | x86      |
| Instapi140.dll                 | 2017.140.3223.3 | 70760     | 13-Jul-19 | 04:33 | x64      |
| Sql_dreplay_client_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlresourceloader.dll          | 2017.140.3223.3 | 29288     | 13-Jul-19 | 04:20 | x86      |

SQL Server 2017 sql_dreplay_controller

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dreplaycommon.dll                  | 2017.140.3223.3 | 698984    | 13-Jul-19 | 04:19 | x86      |
| Dreplaycontroller.exe              | 2017.140.3223.3 | 350312    | 13-Jul-19 | 04:19 | x86      |
| Dreplayprocess.dll                 | 2017.140.3223.3 | 171624    | 13-Jul-19 | 04:19 | x86      |
| Dreplayserverps.dll                | 2017.140.3223.3 | 32872     | 13-Jul-19 | 04:19 | x86      |
| Instapi140.dll                     | 2017.140.3223.3 | 70760     | 13-Jul-19 | 04:33 | x64      |
| Sql_dreplay_controller_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlresourceloader.dll              | 2017.140.3223.3 | 29288     | 13-Jul-19 | 04:20 | x86      |

SQL Server 2017 Database Services Core Instance

|                   File name                  |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Backuptourl.exe                              | 14.0.3223.3     | 40544     | 13-Jul-19 | 04:32 | x64      |
| Batchparser.dll                              | 2017.140.3223.3 | 180840    | 13-Jul-19 | 04:32 | x64      |
| C1.dll                                       | 18.10.40116.18  | 925232    | 13-Jul-19 | 04:34 | x64      |
| C2.dll                                       | 18.10.40116.18  | 5341440   | 13-Jul-19 | 04:34 | x64      |
| Cl.exe                                       | 18.10.40116.18  | 192048    | 13-Jul-19 | 04:34 | x64      |
| Clui.dll                                     | 18.10.40116.10  | 486144    | 13-Jul-19 | 04:29 | x64      |
| Databasemailprotocols.dll                    | 14.0.17178.0    | 48352     | 13-Jul-19 | 04:32 | x86      |
| Datacollectorcontroller.dll                  | 2017.140.3223.3 | 226624    | 13-Jul-19 | 04:32 | x64      |
| Dcexec.exe                                   | 2017.140.3223.3 | 74560     | 13-Jul-19 | 04:32 | x64      |
| Fssres.dll                                   | 2017.140.3223.3 | 89704     | 13-Jul-19 | 04:33 | x64      |
| Hadrres.dll                                  | 2017.140.3223.3 | 188008    | 13-Jul-19 | 04:33 | x64      |
| Hkcompile.dll                                | 2017.140.3223.3 | 1422952   | 13-Jul-19 | 04:33 | x64      |
| Hkengine.dll                                 | 2017.140.3223.3 | 5858400   | 13-Jul-19 | 04:33 | x64      |
| Hkruntime.dll                                | 2017.140.3223.3 | 163136    | 13-Jul-19 | 04:33 | x64      |
| Link.exe                                     | 12.10.40116.18  | 1017392   | 13-Jul-19 | 04:34 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 14.0.249.14     | 741176    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.applicationinsights.dll            | 2.7.0.13435     | 329872    | 13-Jul-19 | 04:26 | x86      |
| Microsoft.sqlautoadmin.autobackupagent.dll   | 14.0.3223.3     | 236344    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlautoadmin.sqlautoadmin.dll      | 14.0.3223.3     | 79672     | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlserver.types.dll                | 2017.140.3223.3 | 392808    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.vdiinterface.dll         | 2017.140.3223.3 | 72296     | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xe.core.dll              | 2017.140.3223.3 | 65128     | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2017.140.3223.3 | 159544    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2017.140.3223.3 | 303720    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2017.140.3223.3 | 75064     | 13-Jul-19 | 04:33 | x64      |
| Msobj120.dll                                 | 12.10.40116.18  | 129576    | 13-Jul-19 | 04:34 | x64      |
| Mspdb120.dll                                 | 12.10.40116.18  | 559144    | 13-Jul-19 | 04:34 | x64      |
| Mspdbcore.dll                                | 12.10.40116.18  | 559144    | 13-Jul-19 | 04:34 | x64      |
| Msvcp120.dll                                 | 12.10.40116.18  | 661040    | 13-Jul-19 | 04:34 | x64      |
| Msvcr120.dll                                 | 12.10.40116.18  | 964656    | 13-Jul-19 | 04:34 | x64      |
| Odsole70.dll                                 | 2017.140.3223.3 | 92776     | 13-Jul-19 | 04:33 | x64      |
| Opends60.dll                                 | 2017.140.3223.3 | 32864     | 13-Jul-19 | 04:33 | x64      |
| Qds.dll                                      | 2017.140.3223.3 | 1178728   | 13-Jul-19 | 04:33 | x64      |
| Rsfxft.dll                                   | 2017.140.3223.3 | 34616     | 13-Jul-19 | 04:33 | x64      |
| Secforwarder.dll                             | 2017.140.3223.3 | 37480     | 13-Jul-19 | 04:33 | x64      |
| Sqagtres.dll                                 | 2017.140.3223.3 | 74344     | 13-Jul-19 | 04:33 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlaamss.dll                                 | 2017.140.3223.3 | 90216     | 13-Jul-19 | 04:33 | x64      |
| Sqlaccess.dll                                | 2017.140.3223.3 | 475752    | 13-Jul-19 | 04:33 | x64      |
| Sqlagent.exe                                 | 2017.140.3223.3 | 582248    | 13-Jul-19 | 04:33 | x64      |
| Sqlagentctr140.dll                           | 2017.140.3223.3 | 52840     | 13-Jul-19 | 04:20 | x86      |
| Sqlagentctr140.dll                           | 2017.140.3223.3 | 62264     | 13-Jul-19 | 04:33 | x64      |
| Sqlagentlog.dll                              | 2017.140.3223.3 | 32872     | 13-Jul-19 | 04:33 | x64      |
| Sqlagentmail.dll                             | 2017.140.3223.3 | 53864     | 13-Jul-19 | 04:33 | x64      |
| Sqlboot.dll                                  | 2017.140.3223.3 | 196200    | 13-Jul-19 | 04:33 | x64      |
| Sqlceip.exe                                  | 14.0.3223.3     | 261944    | 13-Jul-19 | 04:26 | x86      |
| Sqlcmdss.dll                                 | 2017.140.3223.3 | 72808     | 13-Jul-19 | 04:33 | x64      |
| Sqlctr140.dll                                | 2017.140.3223.3 | 112232    | 13-Jul-19 | 04:20 | x86      |
| Sqlctr140.dll                                | 2017.140.3223.3 | 129128    | 13-Jul-19 | 04:33 | x64      |
| Sqldk.dll                                    | 2017.140.3223.3 | 2800232   | 13-Jul-19 | 04:33 | x64      |
| Sqldtsss.dll                                 | 2017.140.3223.3 | 107832    | 13-Jul-19 | 04:33 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3921000   | 13-Jul-19 | 04:16 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3294312   | 13-Jul-19 | 04:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3638888   | 13-Jul-19 | 04:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3370600   | 13-Jul-19 | 04:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3917928   | 13-Jul-19 | 04:17 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3680360   | 13-Jul-19 | 04:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3788392   | 13-Jul-19 | 04:21 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3790440   | 13-Jul-19 | 04:23 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 2091624   | 13-Jul-19 | 04:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3591784   | 13-Jul-19 | 04:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3405416   | 13-Jul-19 | 04:24 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3599976   | 13-Jul-19 | 04:25 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3216488   | 13-Jul-19 | 04:26 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3484776   | 13-Jul-19 | 04:26 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 4030568   | 13-Jul-19 | 04:28 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 2038376   | 13-Jul-19 | 04:29 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3824232   | 13-Jul-19 | 04:30 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3783272   | 13-Jul-19 | 04:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 1499232   | 13-Jul-19 | 04:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3299944   | 13-Jul-19 | 04:34 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 3341416   | 13-Jul-19 | 04:36 | x64      |
| `Sqlevn70.rll`                                 | 2017.140.3223.3 | 1446504   | 13-Jul-19 | 04:38 | x64      |
| Sqliosim.com                                 | 2017.140.3223.3 | 313448    | 13-Jul-19 | 04:33 | x64      |
| Sqliosim.exe                                 | 2017.140.3223.3 | 3019880   | 13-Jul-19 | 04:33 | x64      |
| Sqllang.dll                                  | 2017.140.3223.3 | 41295976  | 13-Jul-19 | 04:33 | x64      |
| Sqlmin.dll                                   | 2017.140.3223.3 | 40508512  | 13-Jul-19 | 04:33 | x64      |
| Sqlolapss.dll                                | 2017.140.3223.3 | 107624    | 13-Jul-19 | 04:33 | x64      |
| Sqlos.dll                                    | 2017.140.3223.3 | 26216     | 13-Jul-19 | 04:33 | x64      |
| Sqlpowershellss.dll                          | 2017.140.3223.3 | 68408     | 13-Jul-19 | 04:33 | x64      |
| Sqlrepss.dll                                 | 2017.140.3223.3 | 64824     | 13-Jul-19 | 04:33 | x64      |
| Sqlresld.dll                                 | 2017.140.3223.3 | 30816     | 13-Jul-19 | 04:33 | x64      |
| Sqlresourceloader.dll                        | 2017.140.3223.3 | 32360     | 13-Jul-19 | 04:33 | x64      |
| Sqlscm.dll                                   | 2017.140.3223.3 | 71480     | 13-Jul-19 | 04:33 | x64      |
| Sqlscriptdowngrade.dll                       | 2017.140.3223.3 | 27752     | 13-Jul-19 | 04:33 | x64      |
| Sqlscriptupgrade.dll                         | 2017.140.3223.3 | 5881960   | 13-Jul-19 | 04:33 | x64      |
| Sqlserverspatial140.dll                      | 2017.140.3223.3 | 732768    | 13-Jul-19 | 04:33 | x64      |
| Sqlservr.exe                                 | 2017.140.3223.3 | 487528    | 13-Jul-19 | 04:33 | x64      |
| Sqlsvc.dll                                   | 2017.140.3223.3 | 161896    | 13-Jul-19 | 04:33 | x64      |
| Sqltses.dll                                  | 2017.140.3223.3 | 9564264   | 13-Jul-19 | 04:33 | x64      |
| Sqsrvres.dll                                 | 2017.140.3223.3 | 261224    | 13-Jul-19 | 04:33 | x64      |
| Svl.dll                                      | 2017.140.3223.3 | 153704    | 13-Jul-19 | 04:33 | x64      |
| Xe.dll                                       | 2017.140.3223.3 | 673384    | 13-Jul-19 | 04:33 | x64      |
| Xmlrw.dll                                    | 2017.140.3223.3 | 305256    | 13-Jul-19 | 04:33 | x64      |
| Xmlrwbin.dll                                 | 2017.140.3223.3 | 224360    | 13-Jul-19 | 04:33 | x64      |
| Xpadsi.exe                                   | 2017.140.3223.3 | 89704     | 13-Jul-19 | 04:33 | x64      |
| Xplog70.dll                                  | 2017.140.3223.3 | 76088     | 13-Jul-19 | 04:33 | x64      |
| Xpqueue.dll                                  | 2017.140.3223.3 | 74856     | 13-Jul-19 | 04:33 | x64      |
| Xprepl.dll                                   | 2017.140.3223.3 | 101992    | 13-Jul-19 | 04:33 | x64      |
| Xpsqlbot.dll                                 | 2017.140.3223.3 | 32360     | 13-Jul-19 | 04:33 | x64      |
| Xpstar.dll                                   | 2017.140.3223.3 | 438376    | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 Database Services Core Shared

|                          File name                          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Batchparser.dll                                             | 2017.140.3223.3 | 160568    | 13-Jul-19 | 04:19 | x86      |
| Batchparser.dll                                             | 2017.140.3223.3 | 180840    | 13-Jul-19 | 04:32 | x64      |
| Bcp.exe                                                     | 2017.140.3223.3 | 120128    | 13-Jul-19 | 04:33 | x64      |
| Commanddest.dll                                             | 2017.140.3223.3 | 245864    | 13-Jul-19 | 04:32 | x64      |
| Datacollectorenumerators.dll                                | 2017.140.3223.3 | 116328    | 13-Jul-19 | 04:32 | x64      |
| Datacollectortasks.dll                                      | 2017.140.3223.3 | 187496    | 13-Jul-19 | 04:32 | x64      |
| Distrib.exe                                                 | 2017.140.3223.3 | 203576    | 13-Jul-19 | 04:33 | x64      |
| Dteparse.dll                                                | 2017.140.3223.3 | 111208    | 13-Jul-19 | 04:32 | x64      |
| Dteparsemgd.dll                                             | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtepkg.dll                                                  | 2017.140.3223.3 | 138040    | 13-Jul-19 | 04:32 | x64      |
| Dtexec.exe                                                  | 2017.140.3223.3 | 73832     | 13-Jul-19 | 04:32 | x64      |
| Dts.dll                                                     | 2017.140.3223.3 | 2998880   | 13-Jul-19 | 04:32 | x64      |
| Dtscomexpreval.dll                                          | 2017.140.3223.3 | 475240    | 13-Jul-19 | 04:32 | x64      |
| Dtsconn.dll                                                 | 2017.140.3223.3 | 497256    | 13-Jul-19 | 04:32 | x64      |
| Dtshost.exe                                                 | 2017.140.3223.3 | 104552    | 13-Jul-19 | 04:33 | x64      |
| Dtslog.dll                                                  | 2017.140.3223.3 | 120424    | 13-Jul-19 | 04:32 | x64      |
| Dtsmsg140.dll                                               | 2017.140.3223.3 | 545384    | 13-Jul-19 | 04:33 | x64      |
| Dtspipeline.dll                                             | 2017.140.3223.3 | 1266280   | 13-Jul-19 | 04:32 | x64      |
| Dtspipelineperf140.dll                                      | 2017.140.3223.3 | 48232     | 13-Jul-19 | 04:32 | x64      |
| Dtuparse.dll                                                | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtutil.exe                                                  | 2017.140.3223.3 | 147048    | 13-Jul-19 | 04:32 | x64      |
| Exceldest.dll                                               | 2017.140.3223.3 | 260712    | 13-Jul-19 | 04:32 | x64      |
| Excelsrc.dll                                                | 2017.140.3223.3 | 282728    | 13-Jul-19 | 04:32 | x64      |
| Execpackagetask.dll                                         | 2017.140.3223.3 | 168040    | 13-Jul-19 | 04:32 | x64      |
| Flatfiledest.dll                                            | 2017.140.3223.3 | 386664    | 13-Jul-19 | 04:32 | x64      |
| Flatfilesrc.dll                                             | 2017.140.3223.3 | 398952    | 13-Jul-19 | 04:32 | x64      |
| Foreachfileenumerator.dll                                   | 2017.140.3223.3 | 96360     | 13-Jul-19 | 04:32 | x64      |
| Hkengperfctrs.dll                                           | 2017.140.3223.3 | 59496     | 13-Jul-19 | 04:33 | x64      |
| Ionic.zip.dll                                               | 1.9.1.8         | 471440    | 13-Jul-19 | 04:31 | x86      |
| Logread.exe                                                 | 2017.140.3223.3 | 634984    | 13-Jul-19 | 04:33 | x64      |
| Mergetxt.dll                                                | 2017.140.3223.3 | 63808     | 13-Jul-19 | 04:33 | x64      |
| Microsoft.analysisservices.applocal.core.dll                | 14.0.249.14     | 1381480   | 13-Jul-19 | 04:32 | x86      |
| Microsoft.data.datafeedclient.dll                           | 13.1.1.0        | 171208    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.exceptionmessagebox.dll                           | 14.0.3223.3     | 137832    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll | 14.0.3223.3     | 89704     | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.manageddts.dll                          | 14.0.3223.3     | 613992    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.replication.dll                         | 2017.140.3223.3 | 1663800   | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.rmo.dll                                 | 14.0.3223.3     | 571496    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.dll                              | 2017.140.3223.3 | 159544    | 13-Jul-19 | 04:33 | x64      |
| Msdtssrvrutil.dll                                           | 2017.140.3223.3 | 103016    | 13-Jul-19 | 04:32 | x64      |
| Msgprox.dll                                                 | 2017.140.3223.3 | 270440    | 13-Jul-19 | 04:33 | x64      |
| Msxmlsql.dll                                                | 2017.140.3223.3 | 1448040   | 13-Jul-19 | 04:33 | x64      |
| Newtonsoft.json.dll                                         | 6.0.8.18111     | 522856    | 13-Jul-19 | 04:31 | x86      |
| Oledbdest.dll                                               | 2017.140.3223.3 | 261224    | 13-Jul-19 | 04:32 | x64      |
| Oledbsrc.dll                                                | 2017.140.3223.3 | 289080    | 13-Jul-19 | 04:32 | x64      |
| Osql.exe                                                    | 2017.140.3223.3 | 75368     | 13-Jul-19 | 04:32 | x64      |
| Qrdrsvc.exe                                                 | 2017.140.3223.3 | 474216    | 13-Jul-19 | 04:33 | x64      |
| Rawdest.dll                                                 | 2017.140.3223.3 | 206432    | 13-Jul-19 | 04:33 | x64      |
| Rawsource.dll                                               | 2017.140.3223.3 | 194152    | 13-Jul-19 | 04:33 | x64      |
| Rdistcom.dll                                                | 2017.140.3223.3 | 857704    | 13-Jul-19 | 04:33 | x64      |
| Recordsetdest.dll                                           | 2017.140.3223.3 | 184424    | 13-Jul-19 | 04:33 | x64      |
| Replagnt.dll                                                | 2017.140.3223.3 | 31032     | 13-Jul-19 | 04:33 | x64      |
| Repldp.dll                                                  | 2017.140.3223.3 | 290920    | 13-Jul-19 | 04:33 | x64      |
| Replerrx.dll                                                | 2017.140.3223.3 | 154208    | 13-Jul-19 | 04:33 | x64      |
| Replisapi.dll                                               | 2017.140.3223.3 | 362088    | 13-Jul-19 | 04:33 | x64      |
| Replmerg.exe                                                | 2017.140.3223.3 | 524896    | 13-Jul-19 | 04:33 | x64      |
| Replprov.dll                                                | 2017.140.3223.3 | 802616    | 13-Jul-19 | 04:33 | x64      |
| Replrec.dll                                                 | 2017.140.3223.3 | 975976    | 13-Jul-19 | 04:33 | x64      |
| Replsub.dll                                                 | 2017.140.3223.3 | 445544    | 13-Jul-19 | 04:33 | x64      |
| Replsync.dll                                                | 2017.140.3223.3 | 154424    | 13-Jul-19 | 04:33 | x64      |
| Sort00001000.dll                                            | 4.0.30319.576   | 871680    | 13-Jul-19 | 04:33 | x64      |
| Sort00060101.dll                                            | 4.0.30319.576   | 75016     | 13-Jul-19 | 04:33 | x64      |
| Spresolv.dll                                                | 2017.140.3223.3 | 252008    | 13-Jul-19 | 04:33 | x64      |
| Sql_engine_core_shared_keyfile.dll                          | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlcmd.exe                                                  | 2017.140.3223.3 | 248936    | 13-Jul-19 | 04:33 | x64      |
| Sqldiag.exe                                                 | 2017.140.3223.3 | 1257576   | 13-Jul-19 | 04:33 | x64      |
| Sqldistx.dll                                                | 2017.140.3223.3 | 225384    | 13-Jul-19 | 04:33 | x64      |
| Sqllogship.exe                                              | 14.0.3223.3     | 105576    | 13-Jul-19 | 04:33 | x64      |
| Sqlmergx.dll                                                | 2017.140.3223.3 | 360552    | 13-Jul-19 | 04:33 | x64      |
| Sqlresld.dll                                                | 2017.140.3223.3 | 28776     | 13-Jul-19 | 04:20 | x86      |
| Sqlresld.dll                                                | 2017.140.3223.3 | 30816     | 13-Jul-19 | 04:33 | x64      |
| Sqlresourceloader.dll                                       | 2017.140.3223.3 | 29288     | 13-Jul-19 | 04:20 | x86      |
| Sqlresourceloader.dll                                       | 2017.140.3223.3 | 32360     | 13-Jul-19 | 04:33 | x64      |
| Sqlscm.dll                                                  | 2017.140.3223.3 | 61032     | 13-Jul-19 | 04:20 | x86      |
| Sqlscm.dll                                                  | 2017.140.3223.3 | 71480     | 13-Jul-19 | 04:33 | x64      |
| Sqlsvc.dll                                                  | 2017.140.3223.3 | 134760    | 13-Jul-19 | 04:20 | x86      |
| Sqlsvc.dll                                                  | 2017.140.3223.3 | 161896    | 13-Jul-19 | 04:33 | x64      |
| Sqltaskconnections.dll                                      | 2017.140.3223.3 | 183912    | 13-Jul-19 | 04:33 | x64      |
| Sqlwep140.dll                                               | 2017.140.3223.3 | 105568    | 13-Jul-19 | 04:33 | x64      |
| Ssdebugps.dll                                               | 2017.140.3223.3 | 33384     | 13-Jul-19 | 04:33 | x64      |
| Ssisoledb.dll                                               | 2017.140.3223.3 | 216168    | 13-Jul-19 | 04:33 | x64      |
| Ssradd.dll                                                  | 2017.140.3223.3 | 75368     | 13-Jul-19 | 04:33 | x64      |
| Ssravg.dll                                                  | 2017.140.3223.3 | 76088     | 13-Jul-19 | 04:33 | x64      |
| Ssrdown.dll                                                 | 2017.140.3223.3 | 61240     | 13-Jul-19 | 04:33 | x64      |
| Ssrmax.dll                                                  | 2017.140.3223.3 | 74064     | 13-Jul-19 | 04:33 | x64      |
| Ssrmin.dll                                                  | 2017.140.3223.3 | 74552     | 13-Jul-19 | 04:33 | x64      |
| Ssrpub.dll                                                  | 2017.140.3223.3 | 61752     | 13-Jul-19 | 04:33 | x64      |
| Ssrup.dll                                                   | 2017.140.3223.3 | 61240     | 13-Jul-19 | 04:33 | x64      |
| Tablediff.exe                                               | 14.0.3223.3     | 86632     | 13-Jul-19 | 04:33 | x64      |
| Txagg.dll                                                   | 2017.140.3223.3 | 362088    | 13-Jul-19 | 04:33 | x64      |
| Txbdd.dll                                                   | 2017.140.3223.3 | 170088    | 13-Jul-19 | 04:33 | x64      |
| Txdatacollector.dll                                         | 2017.140.3223.3 | 360552    | 13-Jul-19 | 04:33 | x64      |
| Txdataconvert.dll                                           | 2017.140.3223.3 | 292968    | 13-Jul-19 | 04:33 | x64      |
| Txderived.dll                                               | 2017.140.3223.3 | 604264    | 13-Jul-19 | 04:33 | x64      |
| Txlookup.dll                                                | 2017.140.3223.3 | 527976    | 13-Jul-19 | 04:33 | x64      |
| Txmerge.dll                                                 | 2017.140.3223.3 | 229992    | 13-Jul-19 | 04:33 | x64      |
| Txmergejoin.dll                                             | 2017.140.3223.3 | 275560    | 13-Jul-19 | 04:33 | x64      |
| Txmulticast.dll                                             | 2017.140.3223.3 | 127592    | 13-Jul-19 | 04:33 | x64      |
| Txrowcount.dll                                              | 2017.140.3223.3 | 125536    | 13-Jul-19 | 04:33 | x64      |
| Txsort.dll                                                  | 2017.140.3223.3 | 256616    | 13-Jul-19 | 04:33 | x64      |
| Txsplit.dll                                                 | 2017.140.3223.3 | 596584    | 13-Jul-19 | 04:33 | x64      |
| Txunionall.dll                                              | 2017.140.3223.3 | 181864    | 13-Jul-19 | 04:33 | x64      |
| Xe.dll                                                      | 2017.140.3223.3 | 673384    | 13-Jul-19 | 04:33 | x64      |
| Xmlrw.dll                                                   | 2017.140.3223.3 | 305256    | 13-Jul-19 | 04:33 | x64      |
| Xmlsub.dll                                                  | 2017.140.3223.3 | 261224    | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 sql_extensibility

|           File name           |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Launchpad.exe                 | 2017.140.3223.3 | 1124968   | 13-Jul-19 | 04:33 | x64      |
| Sql_extensibility_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlsatellite.dll              | 2017.140.3223.3 | 922448    | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 Full-Text Engine

|         File name        |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2017.140.3223.3 | 671328    | 13-Jul-19 | 04:33 | x64      |
| Fdhost.exe               | 2017.140.3223.3 | 115008    | 13-Jul-19 | 04:33 | x64      |
| Fdlauncher.exe           | 2017.140.3223.3 | 62800     | 13-Jul-19 | 04:33 | x64      |
| Nlsdl.dll                | 6.0.6001.18000  | 46360     | 13-Jul-19 | 04:33 | x64      |
| Sql_fulltext_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlft140ph.dll           | 2017.140.3223.3 | 68200     | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 sql_inst_mr

|        File name        |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Imrdll.dll              | 14.0.3223.3     | 23656     | 13-Jul-19 | 04:32 | x86      |
| Sql_inst_mr_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |

SQL Server 2017 Integration Services

|                           File name                           |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 13-Jul-19 | 04:19 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 5.0.0.112       | 75264     | 13-Jul-19 | 04:32 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 13-Jul-19 | 04:19 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 5.0.0.112       | 36352     | 13-Jul-19 | 04:32 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 13-Jul-19 | 04:19 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 5.0.0.112       | 76288     | 13-Jul-19 | 04:32 | x86      |
| Commanddest.dll                                               | 2017.140.3223.3 | 200808    | 13-Jul-19 | 04:19 | x86      |
| Commanddest.dll                                               | 2017.140.3223.3 | 245864    | 13-Jul-19 | 04:32 | x64      |
| Dteparse.dll                                                  | 2017.140.3223.3 | 100968    | 13-Jul-19 | 04:19 | x86      |
| Dteparse.dll                                                  | 2017.140.3223.3 | 111208    | 13-Jul-19 | 04:32 | x64      |
| Dteparsemgd.dll                                               | 2017.140.3223.3 | 83560     | 13-Jul-19 | 04:19 | x86      |
| Dteparsemgd.dll                                               | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtepkg.dll                                                    | 2017.140.3223.3 | 116840    | 13-Jul-19 | 04:19 | x86      |
| Dtepkg.dll                                                    | 2017.140.3223.3 | 138040    | 13-Jul-19 | 04:32 | x64      |
| Dtexec.exe                                                    | 2017.140.3223.3 | 67680     | 13-Jul-19 | 04:19 | x86      |
| Dtexec.exe                                                    | 2017.140.3223.3 | 73832     | 13-Jul-19 | 04:32 | x64      |
| Dts.dll                                                       | 2017.140.3223.3 | 2549560   | 13-Jul-19 | 04:19 | x86      |
| Dts.dll                                                       | 2017.140.3223.3 | 2998880   | 13-Jul-19 | 04:32 | x64      |
| Dtscomexpreval.dll                                            | 2017.140.3223.3 | 417896    | 13-Jul-19 | 04:19 | x86      |
| Dtscomexpreval.dll                                            | 2017.140.3223.3 | 475240    | 13-Jul-19 | 04:32 | x64      |
| Dtsconn.dll                                                   | 2017.140.3223.3 | 399672    | 13-Jul-19 | 04:19 | x86      |
| Dtsconn.dll                                                   | 2017.140.3223.3 | 497256    | 13-Jul-19 | 04:32 | x64      |
| Dtsdebughost.exe                                              | 2017.140.3223.3 | 95336     | 13-Jul-19 | 04:19 | x86      |
| Dtsdebughost.exe                                              | 2017.140.3223.3 | 111208    | 13-Jul-19 | 04:32 | x64      |
| Dtshost.exe                                                   | 2017.140.3223.3 | 89704     | 13-Jul-19 | 04:20 | x86      |
| Dtshost.exe                                                   | 2017.140.3223.3 | 104552    | 13-Jul-19 | 04:33 | x64      |
| Dtslog.dll                                                    | 2017.140.3223.3 | 103016    | 13-Jul-19 | 04:19 | x86      |
| Dtslog.dll                                                    | 2017.140.3223.3 | 120424    | 13-Jul-19 | 04:32 | x64      |
| Dtsmsg140.dll                                                 | 2017.140.3223.3 | 541288    | 13-Jul-19 | 04:20 | x86      |
| Dtsmsg140.dll                                                 | 2017.140.3223.3 | 545384    | 13-Jul-19 | 04:33 | x64      |
| Dtspipeline.dll                                               | 2017.140.3223.3 | 1059432   | 13-Jul-19 | 04:19 | x86      |
| Dtspipeline.dll                                               | 2017.140.3223.3 | 1266280   | 13-Jul-19 | 04:32 | x64      |
| Dtspipelineperf140.dll                                        | 2017.140.3223.3 | 42600     | 13-Jul-19 | 04:19 | x86      |
| Dtspipelineperf140.dll                                        | 2017.140.3223.3 | 48232     | 13-Jul-19 | 04:32 | x64      |
| Dtuparse.dll                                                  | 2017.140.3223.3 | 80488     | 13-Jul-19 | 04:19 | x86      |
| Dtuparse.dll                                                  | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtutil.exe                                                    | 2017.140.3223.3 | 126264    | 13-Jul-19 | 04:19 | x86      |
| Dtutil.exe                                                    | 2017.140.3223.3 | 147048    | 13-Jul-19 | 04:32 | x64      |
| Exceldest.dll                                                 | 2017.140.3223.3 | 214632    | 13-Jul-19 | 04:19 | x86      |
| Exceldest.dll                                                 | 2017.140.3223.3 | 260712    | 13-Jul-19 | 04:32 | x64      |
| Excelsrc.dll                                                  | 2017.140.3223.3 | 230504    | 13-Jul-19 | 04:19 | x86      |
| Excelsrc.dll                                                  | 2017.140.3223.3 | 282728    | 13-Jul-19 | 04:32 | x64      |
| Execpackagetask.dll                                           | 2017.140.3223.3 | 135272    | 13-Jul-19 | 04:19 | x86      |
| Execpackagetask.dll                                           | 2017.140.3223.3 | 168040    | 13-Jul-19 | 04:32 | x64      |
| Flatfiledest.dll                                              | 2017.140.3223.3 | 333112    | 13-Jul-19 | 04:19 | x86      |
| Flatfiledest.dll                                              | 2017.140.3223.3 | 386664    | 13-Jul-19 | 04:32 | x64      |
| Flatfilesrc.dll                                               | 2017.140.3223.3 | 344376    | 13-Jul-19 | 04:19 | x86      |
| Flatfilesrc.dll                                               | 2017.140.3223.3 | 398952    | 13-Jul-19 | 04:32 | x64      |
| Foreachfileenumerator.dll                                     | 2017.140.3223.3 | 80696     | 13-Jul-19 | 04:19 | x86      |
| Foreachfileenumerator.dll                                     | 2017.140.3223.3 | 96360     | 13-Jul-19 | 04:32 | x64      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 13-Jul-19 | 04:31 | x86      |
| Ionic.zip.dll                                                 | 1.9.1.8         | 471440    | 13-Jul-19 | 04:31 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3223.3     | 467256    | 13-Jul-19 | 04:19 | x86      |
| Isdeploymentwizard.exe                                        | 14.0.3223.3     | 466744    | 13-Jul-19 | 04:32 | x64      |
| Isserverexec.exe                                              | 14.0.3223.3     | 149096    | 13-Jul-19 | 04:19 | x86      |
| Isserverexec.exe                                              | 14.0.3223.3     | 148792    | 13-Jul-19 | 04:32 | x64      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.14     | 1381480   | 13-Jul-19 | 04:19 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 14.0.249.14     | 1381480   | 13-Jul-19 | 04:32 | x86      |
| Microsoft.applicationinsights.dll                             | 2.7.0.13435     | 329872    | 13-Jul-19 | 04:26 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.data.datafeedclient.dll                             | 13.1.1.0        | 171208    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.sqlserver.astasks.dll                               | 14.0.3223.3     | 73016     | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3223.3 | 107328    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.bulkinserttaskconnections.dll             | 2017.140.3223.3 | 112224    | 13-Jul-19 | 04:32 | x64      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3223.3     | 89912     | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservice.hadoopcomponents.dll   | 14.0.3223.3     | 89704     | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3223.3     | 502376    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 14.0.3223.3     | 502368    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3223.3     | 83560     | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.server.dll            | 14.0.3223.3     | 83552     | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3223.3     | 415848    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.integrationservices.wizard.common.dll     | 14.0.3223.3     | 415848    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3223.3     | 613992    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                            | 14.0.3223.3     | 613992    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3223.3     | 252736    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll        | 14.0.3223.3     | 252736    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3223.3 | 141920    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3223.3 | 145512    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2017.140.3223.3 | 159544    | 13-Jul-19 | 04:33 | x64      |
| Msdtssrvr.exe                                                 | 14.0.3223.3     | 219960    | 13-Jul-19 | 04:33 | x64      |
| Msdtssrvrutil.dll                                             | 2017.140.3223.3 | 90216     | 13-Jul-19 | 04:19 | x86      |
| Msdtssrvrutil.dll                                             | 2017.140.3223.3 | 103016    | 13-Jul-19 | 04:32 | x64      |
| Msmdpp.dll                                                    | 2017.140.249.14 | 9198688   | 13-Jul-19 | 04:33 | x64      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 13-Jul-19 | 04:21 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 13-Jul-19 | 04:31 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 522856    | 13-Jul-19 | 04:31 | x86      |
| Newtonsoft.json.dll                                           | 6.0.8.18111     | 513424    | 13-Jul-19 | 04:36 | x86      |
| Oledbdest.dll                                                 | 2017.140.3223.3 | 214632    | 13-Jul-19 | 04:19 | x86      |
| Oledbdest.dll                                                 | 2017.140.3223.3 | 261224    | 13-Jul-19 | 04:32 | x64      |
| Oledbsrc.dll                                                  | 2017.140.3223.3 | 233272    | 13-Jul-19 | 04:19 | x86      |
| Oledbsrc.dll                                                  | 2017.140.3223.3 | 289080    | 13-Jul-19 | 04:32 | x64      |
| Rawdest.dll                                                   | 2017.140.3223.3 | 166504    | 13-Jul-19 | 04:20 | x86      |
| Rawdest.dll                                                   | 2017.140.3223.3 | 206432    | 13-Jul-19 | 04:33 | x64      |
| Rawsource.dll                                                 | 2017.140.3223.3 | 153192    | 13-Jul-19 | 04:20 | x86      |
| Rawsource.dll                                                 | 2017.140.3223.3 | 194152    | 13-Jul-19 | 04:33 | x64      |
| Recordsetdest.dll                                             | 2017.140.3223.3 | 149096    | 13-Jul-19 | 04:20 | x86      |
| Recordsetdest.dll                                             | 2017.140.3223.3 | 184424    | 13-Jul-19 | 04:33 | x64      |
| Sql_is_keyfile.dll                                            | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlceip.exe                                                   | 14.0.3223.3     | 261944    | 13-Jul-19 | 04:26 | x86      |
| Sqldest.dll                                                   | 2017.140.3223.3 | 213608    | 13-Jul-19 | 04:20 | x86      |
| Sqldest.dll                                                   | 2017.140.3223.3 | 260712    | 13-Jul-19 | 04:33 | x64      |
| Sqltaskconnections.dll                                        | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:20 | x86      |
| Sqltaskconnections.dll                                        | 2017.140.3223.3 | 183912    | 13-Jul-19 | 04:33 | x64      |
| Ssisoledb.dll                                                 | 2017.140.3223.3 | 176744    | 13-Jul-19 | 04:20 | x86      |
| Ssisoledb.dll                                                 | 2017.140.3223.3 | 216168    | 13-Jul-19 | 04:33 | x64      |
| Txagg.dll                                                     | 2017.140.3223.3 | 302392    | 13-Jul-19 | 04:20 | x86      |
| Txagg.dll                                                     | 2017.140.3223.3 | 362088    | 13-Jul-19 | 04:33 | x64      |
| Txbdd.dll                                                     | 2017.140.3223.3 | 139368    | 13-Jul-19 | 04:20 | x86      |
| Txbdd.dll                                                     | 2017.140.3223.3 | 170088    | 13-Jul-19 | 04:33 | x64      |
| Txbestmatch.dll                                               | 2017.140.3223.3 | 493160    | 13-Jul-19 | 04:20 | x86      |
| Txbestmatch.dll                                               | 2017.140.3223.3 | 605288    | 13-Jul-19 | 04:33 | x64      |
| Txcache.dll                                                   | 2017.140.3223.3 | 146024    | 13-Jul-19 | 04:20 | x86      |
| Txcache.dll                                                   | 2017.140.3223.3 | 180328    | 13-Jul-19 | 04:33 | x64      |
| Txcharmap.dll                                                 | 2017.140.3223.3 | 248936    | 13-Jul-19 | 04:20 | x86      |
| Txcharmap.dll                                                 | 2017.140.3223.3 | 286816    | 13-Jul-19 | 04:33 | x64      |
| Txcopymap.dll                                                 | 2017.140.3223.3 | 145512    | 13-Jul-19 | 04:20 | x86      |
| Txcopymap.dll                                                 | 2017.140.3223.3 | 180328    | 13-Jul-19 | 04:33 | x64      |
| Txdataconvert.dll                                             | 2017.140.3223.3 | 253032    | 13-Jul-19 | 04:20 | x86      |
| Txdataconvert.dll                                             | 2017.140.3223.3 | 292968    | 13-Jul-19 | 04:33 | x64      |
| Txderived.dll                                                 | 2017.140.3223.3 | 515688    | 13-Jul-19 | 04:20 | x86      |
| Txderived.dll                                                 | 2017.140.3223.3 | 604264    | 13-Jul-19 | 04:33 | x64      |
| Txfileextractor.dll                                           | 2017.140.3223.3 | 160872    | 13-Jul-19 | 04:20 | x86      |
| Txfileextractor.dll                                           | 2017.140.3223.3 | 198760    | 13-Jul-19 | 04:33 | x64      |
| Txfileinserter.dll                                            | 2017.140.3223.3 | 159336    | 13-Jul-19 | 04:20 | x86      |
| Txfileinserter.dll                                            | 2017.140.3223.3 | 196712    | 13-Jul-19 | 04:33 | x64      |
| Txgroupdups.dll                                               | 2017.140.3223.3 | 231016    | 13-Jul-19 | 04:20 | x86      |
| Txgroupdups.dll                                               | 2017.140.3223.3 | 290408    | 13-Jul-19 | 04:33 | x64      |
| Txlineage.dll                                                 | 2017.140.3223.3 | 110184    | 13-Jul-19 | 04:20 | x86      |
| Txlineage.dll                                                 | 2017.140.3223.3 | 136808    | 13-Jul-19 | 04:33 | x64      |
| Txlookup.dll                                                  | 2017.140.3223.3 | 446568    | 13-Jul-19 | 04:20 | x86      |
| Txlookup.dll                                                  | 2017.140.3223.3 | 527976    | 13-Jul-19 | 04:33 | x64      |
| Txmerge.dll                                                   | 2017.140.3223.3 | 176744    | 13-Jul-19 | 04:20 | x86      |
| Txmerge.dll                                                   | 2017.140.3223.3 | 229992    | 13-Jul-19 | 04:33 | x64      |
| Txmergejoin.dll                                               | 2017.140.3223.3 | 221800    | 13-Jul-19 | 04:20 | x86      |
| Txmergejoin.dll                                               | 2017.140.3223.3 | 275560    | 13-Jul-19 | 04:33 | x64      |
| Txmulticast.dll                                               | 2017.140.3223.3 | 102504    | 13-Jul-19 | 04:20 | x86      |
| Txmulticast.dll                                               | 2017.140.3223.3 | 127592    | 13-Jul-19 | 04:33 | x64      |
| Txpivot.dll                                                   | 2017.140.3223.3 | 180328    | 13-Jul-19 | 04:20 | x86      |
| Txpivot.dll                                                   | 2017.140.3223.3 | 224872    | 13-Jul-19 | 04:33 | x64      |
| Txrowcount.dll                                                | 2017.140.3223.3 | 101480    | 13-Jul-19 | 04:20 | x86      |
| Txrowcount.dll                                                | 2017.140.3223.3 | 125536    | 13-Jul-19 | 04:33 | x64      |
| Txsampling.dll                                                | 2017.140.3223.3 | 135784    | 13-Jul-19 | 04:20 | x86      |
| Txsampling.dll                                                | 2017.140.3223.3 | 172648    | 13-Jul-19 | 04:33 | x64      |
| Txscd.dll                                                     | 2017.140.3223.3 | 170088    | 13-Jul-19 | 04:20 | x86      |
| Txscd.dll                                                     | 2017.140.3223.3 | 220776    | 13-Jul-19 | 04:33 | x64      |
| Txsort.dll                                                    | 2017.140.3223.3 | 207976    | 13-Jul-19 | 04:20 | x86      |
| Txsort.dll                                                    | 2017.140.3223.3 | 256616    | 13-Jul-19 | 04:33 | x64      |
| Txsplit.dll                                                   | 2017.140.3223.3 | 510568    | 13-Jul-19 | 04:20 | x86      |
| Txsplit.dll                                                   | 2017.140.3223.3 | 596584    | 13-Jul-19 | 04:33 | x64      |
| Txtermextraction.dll                                          | 2017.140.3223.3 | 8615224   | 13-Jul-19 | 04:20 | x86      |
| Txtermextraction.dll                                          | 2017.140.3223.3 | 8676456   | 13-Jul-19 | 04:33 | x64      |
| Txtermlookup.dll                                              | 2017.140.3223.3 | 4107088   | 13-Jul-19 | 04:20 | x86      |
| Txtermlookup.dll                                              | 2017.140.3223.3 | 4157032   | 13-Jul-19 | 04:33 | x64      |
| Txunionall.dll                                                | 2017.140.3223.3 | 139368    | 13-Jul-19 | 04:20 | x86      |
| Txunionall.dll                                                | 2017.140.3223.3 | 181864    | 13-Jul-19 | 04:33 | x64      |
| Txunpivot.dll                                                 | 2017.140.3223.3 | 160360    | 13-Jul-19 | 04:20 | x86      |
| Txunpivot.dll                                                 | 2017.140.3223.3 | 199784    | 13-Jul-19 | 04:33 | x64      |
| Xe.dll                                                        | 2017.140.3223.3 | 595560    | 13-Jul-19 | 04:20 | x86      |
| Xe.dll                                                        | 2017.140.3223.3 | 673384    | 13-Jul-19 | 04:33 | x64      |

SQL Server 2017 sql_polybase_core_inst

|                               File name                              |   File version   | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:----------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 13.0.9124.22     | 523848    | 13-Jul-19 | 04:34 | x86      |
| Dmsnative.dll                                                        | 2016.130.9124.22 | 78408     | 13-Jul-19 | 04:34 | x64      |
| Dwengineservice.dll                                                  | 13.0.9124.22     | 45640     | 13-Jul-19 | 04:34 | x86      |
| Instapi140.dll                                                       | 2017.140.3223.3  | 70760     | 13-Jul-19 | 04:34 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 13.0.9124.22     | 74824     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 13.0.9124.22     | 213576    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 13.0.9124.22     | 1799240   | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 13.0.9124.22     | 116808    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 13.0.9124.22     | 390216    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 13.0.9124.22     | 196168    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 13.0.9124.22     | 131144    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 13.0.9124.22     | 63048     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 13.0.9124.22     | 55368     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 13.0.9124.22     | 93768     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 13.0.9124.22     | 792648    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 13.0.9124.22     | 87624     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 13.0.9124.22     | 77896     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 13.0.9124.22     | 42056     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 13.0.9124.22     | 36936     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 13.0.9124.22     | 47688     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 13.0.9124.22     | 27208     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 13.0.9124.22     | 32328     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 13.0.9124.22     | 129608    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 13.0.9124.22     | 95304     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 13.0.9124.22     | 109128    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 13.0.9124.22     | 264264    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 105032    | 13-Jul-19 | 04:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 119368    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 122440    | 13-Jul-19 | 04:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118856    | 13-Jul-19 | 04:17 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 129096    | 13-Jul-19 | 04:18 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 121416    | 13-Jul-19 | 04:29 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 116296    | 13-Jul-19 | 04:24 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 149576    | 13-Jul-19 | 04:28 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 102984    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 13.0.9124.22     | 118344    | 13-Jul-19 | 04:29 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 13.0.9124.22     | 70216     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 13.0.9124.22     | 28744     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 13.0.9124.22     | 43592     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 13.0.9124.22     | 83528     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.setup.componentupgradelibrary.dll  | 13.0.9124.22     | 136776    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 13.0.9124.22     | 2340936   | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 13.0.9124.22     | 3860040   | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 110664    | 13-Jul-19 | 04:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123464    | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 128072    | 13-Jul-19 | 04:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 123976    | 13-Jul-19 | 04:17 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 136776    | 13-Jul-19 | 04:18 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 124488    | 13-Jul-19 | 04:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 121416    | 13-Jul-19 | 04:24 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 156232    | 13-Jul-19 | 04:28 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 108616    | 13-Jul-19 | 04:31 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 13.0.9124.22     | 122952    | 13-Jul-19 | 04:29 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 13.0.9124.22     | 70216     | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 13.0.9124.22     | 2756168   | 13-Jul-19 | 04:34 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 13.0.9124.22     | 751688    | 13-Jul-19 | 04:34 | x86      |
| Mpdwinterop.dll                                                      | 2017.140.3223.3  | 407144    | 13-Jul-19 | 04:34 | x64      |
| Mpdwsvc.exe                                                          | 2017.140.3223.3  | 7326016   | 13-Jul-19 | 04:34 | x64      |
| Pdwodbcsql11.dll                                                     | 2017.140.3223.3  | 2263144   | 13-Jul-19 | 04:34 | x64      |
| Secforwarder.dll                                                     | 2017.140.3223.3  | 37480     | 13-Jul-19 | 04:34 | x64      |
| Sharedmemory.dll                                                     | 2016.130.9124.22 | 64584     | 13-Jul-19 | 04:34 | x64      |
| Sqldk.dll                                                            | 2017.140.3223.3  | 2733152   | 13-Jul-19 | 04:34 | x64      |
| Sqldumper.exe                                                        | 2017.140.3223.3  | 144184    | 13-Jul-19 | 04:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 1499232   | 13-Jul-19 | 04:34 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3917928   | 13-Jul-19 | 04:17 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3216488   | 13-Jul-19 | 04:26 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3921000   | 13-Jul-19 | 04:16 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3824232   | 13-Jul-19 | 04:30 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 2091624   | 13-Jul-19 | 04:24 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 2038376   | 13-Jul-19 | 04:29 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3591784   | 13-Jul-19 | 04:24 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3599976   | 13-Jul-19 | 04:25 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 1446504   | 13-Jul-19 | 04:38 | x64      |
| `Sqlevn70.rll`                                                         | 2017.140.3223.3  | 3788392   | 13-Jul-19 | 04:21 | x64      |
| Sqlos.dll                                                            | 2017.140.3223.3  | 26216     | 13-Jul-19 | 04:34 | x64      |
| Sqlsortpdw.dll                                                       | 2016.130.9124.22 | 4347976   | 13-Jul-19 | 04:34 | x64      |
| Sqltses.dll                                                          | 2017.140.3223.3  | 9734760   | 13-Jul-19 | 04:34 | x64      |

SQL Server 2017 sql_shared_mr

|              File name             |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Smrdll.dll                         | 14.0.3223.3     | 23656     | 13-Jul-19 | 04:33 | x86      |
| Sql_engine_core_shared_keyfile.dll | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |

SQL Server 2017 sql_tools_extensions

|                        File name                       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Autoadmin.dll                                          | 2017.140.3223.3 | 1448552   | 13-Jul-19 | 04:20 | x86      |
| Dtaengine.exe                                          | 2017.140.3223.3 | 204600    | 13-Jul-19 | 04:19 | x86      |
| Dteparse.dll                                           | 2017.140.3223.3 | 100968    | 13-Jul-19 | 04:19 | x86      |
| Dteparse.dll                                           | 2017.140.3223.3 | 111208    | 13-Jul-19 | 04:32 | x64      |
| Dteparsemgd.dll                                        | 2017.140.3223.3 | 83560     | 13-Jul-19 | 04:19 | x86      |
| Dteparsemgd.dll                                        | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtepkg.dll                                             | 2017.140.3223.3 | 116840    | 13-Jul-19 | 04:19 | x86      |
| Dtepkg.dll                                             | 2017.140.3223.3 | 138040    | 13-Jul-19 | 04:32 | x64      |
| Dtexec.exe                                             | 2017.140.3223.3 | 67680     | 13-Jul-19 | 04:19 | x86      |
| Dtexec.exe                                             | 2017.140.3223.3 | 73832     | 13-Jul-19 | 04:32 | x64      |
| Dts.dll                                                | 2017.140.3223.3 | 2549560   | 13-Jul-19 | 04:19 | x86      |
| Dts.dll                                                | 2017.140.3223.3 | 2998880   | 13-Jul-19 | 04:32 | x64      |
| Dtscomexpreval.dll                                     | 2017.140.3223.3 | 417896    | 13-Jul-19 | 04:19 | x86      |
| Dtscomexpreval.dll                                     | 2017.140.3223.3 | 475240    | 13-Jul-19 | 04:32 | x64      |
| Dtsconn.dll                                            | 2017.140.3223.3 | 399672    | 13-Jul-19 | 04:19 | x86      |
| Dtsconn.dll                                            | 2017.140.3223.3 | 497256    | 13-Jul-19 | 04:32 | x64      |
| Dtshost.exe                                            | 2017.140.3223.3 | 89704     | 13-Jul-19 | 04:20 | x86      |
| Dtshost.exe                                            | 2017.140.3223.3 | 104552    | 13-Jul-19 | 04:33 | x64      |
| Dtslog.dll                                             | 2017.140.3223.3 | 103016    | 13-Jul-19 | 04:19 | x86      |
| Dtslog.dll                                             | 2017.140.3223.3 | 120424    | 13-Jul-19 | 04:32 | x64      |
| Dtsmsg140.dll                                          | 2017.140.3223.3 | 541288    | 13-Jul-19 | 04:20 | x86      |
| Dtsmsg140.dll                                          | 2017.140.3223.3 | 545384    | 13-Jul-19 | 04:33 | x64      |
| Dtspipeline.dll                                        | 2017.140.3223.3 | 1059432   | 13-Jul-19 | 04:19 | x86      |
| Dtspipeline.dll                                        | 2017.140.3223.3 | 1266280   | 13-Jul-19 | 04:32 | x64      |
| Dtspipelineperf140.dll                                 | 2017.140.3223.3 | 42600     | 13-Jul-19 | 04:19 | x86      |
| Dtspipelineperf140.dll                                 | 2017.140.3223.3 | 48232     | 13-Jul-19 | 04:32 | x64      |
| Dtuparse.dll                                           | 2017.140.3223.3 | 80488     | 13-Jul-19 | 04:19 | x86      |
| Dtuparse.dll                                           | 2017.140.3223.3 | 89192     | 13-Jul-19 | 04:32 | x64      |
| Dtutil.exe                                             | 2017.140.3223.3 | 126264    | 13-Jul-19 | 04:19 | x86      |
| Dtutil.exe                                             | 2017.140.3223.3 | 147048    | 13-Jul-19 | 04:32 | x64      |
| Exceldest.dll                                          | 2017.140.3223.3 | 214632    | 13-Jul-19 | 04:19 | x86      |
| Exceldest.dll                                          | 2017.140.3223.3 | 260712    | 13-Jul-19 | 04:32 | x64      |
| Excelsrc.dll                                           | 2017.140.3223.3 | 230504    | 13-Jul-19 | 04:19 | x86      |
| Excelsrc.dll                                           | 2017.140.3223.3 | 282728    | 13-Jul-19 | 04:32 | x64      |
| Flatfiledest.dll                                       | 2017.140.3223.3 | 333112    | 13-Jul-19 | 04:19 | x86      |
| Flatfiledest.dll                                       | 2017.140.3223.3 | 386664    | 13-Jul-19 | 04:32 | x64      |
| Flatfilesrc.dll                                        | 2017.140.3223.3 | 344376    | 13-Jul-19 | 04:19 | x86      |
| Flatfilesrc.dll                                        | 2017.140.3223.3 | 398952    | 13-Jul-19 | 04:32 | x64      |
| Foreachfileenumerator.dll                              | 2017.140.3223.3 | 80696     | 13-Jul-19 | 04:19 | x86      |
| Foreachfileenumerator.dll                              | 2017.140.3223.3 | 96360     | 13-Jul-19 | 04:32 | x64      |
| Microsoft.sqlserver.astasks.dll                        | 14.0.3223.3     | 72808     | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.astasksui.dll                      | 14.0.3223.3     | 186680    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3223.3     | 409704    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.chainer.infrastructure.dll         | 14.0.3223.3     | 409912    | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3223.3     | 2093376   | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.configuration.sco.dll              | 14.0.3223.3     | 2093160   | 13-Jul-19 | 04:32 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3223.3     | 613992    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.manageddts.dll                     | 14.0.3223.3     | 613992    | 13-Jul-19 | 04:33 | x86      |
| Microsoft.sqlserver.management.integrationservices.dll | 14.0.3223.3     | 252736    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3223.3 | 141920    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll           | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:33 | x64      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3223.3 | 145512    | 13-Jul-19 | 04:19 | x86      |
| Microsoft.sqlserver.xevent.dll                         | 2017.140.3223.3 | 159544    | 13-Jul-19 | 04:33 | x64      |
| Msdtssrvrutil.dll                                      | 2017.140.3223.3 | 90216     | 13-Jul-19 | 04:19 | x86      |
| Msdtssrvrutil.dll                                      | 2017.140.3223.3 | 103016    | 13-Jul-19 | 04:32 | x64      |
| Msmgdsrv.dll                                           | 2017.140.249.14 | 7311456   | 13-Jul-19 | 04:20 | x86      |
| Oledbdest.dll                                          | 2017.140.3223.3 | 214632    | 13-Jul-19 | 04:19 | x86      |
| Oledbdest.dll                                          | 2017.140.3223.3 | 261224    | 13-Jul-19 | 04:32 | x64      |
| Oledbsrc.dll                                           | 2017.140.3223.3 | 233272    | 13-Jul-19 | 04:19 | x86      |
| Oledbsrc.dll                                           | 2017.140.3223.3 | 289080    | 13-Jul-19 | 04:32 | x64      |
| Sql_tools_extensions_keyfile.dll                       | 2017.140.3223.3 | 100456    | 13-Jul-19 | 04:32 | x64      |
| Sqlresld.dll                                           | 2017.140.3223.3 | 28776     | 13-Jul-19 | 04:20 | x86      |
| Sqlresld.dll                                           | 2017.140.3223.3 | 30816     | 13-Jul-19 | 04:33 | x64      |
| Sqlresourceloader.dll                                  | 2017.140.3223.3 | 29288     | 13-Jul-19 | 04:20 | x86      |
| Sqlresourceloader.dll                                  | 2017.140.3223.3 | 32360     | 13-Jul-19 | 04:33 | x64      |
| Sqlscm.dll                                             | 2017.140.3223.3 | 61032     | 13-Jul-19 | 04:20 | x86      |
| Sqlscm.dll                                             | 2017.140.3223.3 | 71480     | 13-Jul-19 | 04:33 | x64      |
| Sqlsvc.dll                                             | 2017.140.3223.3 | 134760    | 13-Jul-19 | 04:20 | x86      |
| Sqlsvc.dll                                             | 2017.140.3223.3 | 161896    | 13-Jul-19 | 04:33 | x64      |
| Sqltaskconnections.dll                                 | 2017.140.3223.3 | 152168    | 13-Jul-19 | 04:20 | x86      |
| Sqltaskconnections.dll                                 | 2017.140.3223.3 | 183912    | 13-Jul-19 | 04:33 | x64      |
| Txdataconvert.dll                                      | 2017.140.3223.3 | 253032    | 13-Jul-19 | 04:20 | x86      |
| Txdataconvert.dll                                      | 2017.140.3223.3 | 292968    | 13-Jul-19 | 04:33 | x64      |
| Xe.dll                                                 | 2017.140.3223.3 | 595560    | 13-Jul-19 | 04:20 | x86      |
| Xe.dll                                                 | 2017.140.3223.3 | 673384    | 13-Jul-19 | 04:33 | x64      |
| Xmlrw.dll                                              | 2017.140.3223.3 | 257640    | 13-Jul-19 | 04:20 | x86      |
| Xmlrw.dll                                              | 2017.140.3223.3 | 305256    | 13-Jul-19 | 04:33 | x64      |
| Xmlrwbin.dll                                           | 2017.140.3223.3 | 189544    | 13-Jul-19 | 04:20 | x86      |
| Xmlrwbin.dll                                           | 2017.140.3223.3 | 224360    | 13-Jul-19 | 04:33 | x64      |

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
