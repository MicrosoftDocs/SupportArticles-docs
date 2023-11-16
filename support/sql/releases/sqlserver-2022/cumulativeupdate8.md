---
title: Cumulative update 8 for SQL Server 2022 (KB5029666)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 8 (KB5029666).
ms.date: 09/14/2023
ms.custom: KB5029666
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5029666 - Cumulative Update 8 for SQL Server 2022

_Release Date:_ &nbsp; September 14, 2023  
_Version:_ &nbsp; 16.0.4075.1

## Summary

This article describes Cumulative Update package 8 (CU8) for Microsoft SQL Server 2022. This update contains 12 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 7, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4075.1**, file version: **2022.160.4075.1**
- Analysis Services - Product version: **16.0.43.221**, file version: **2022.160.43.221**

## Known issues in this update

There are no known issues in this cumulative update.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area | Component | Platform |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2603906>[2603906](#2603906) </a> | Fixes an issue that you encounter when selecting other non-entity nodes after selecting an entity node in Master Data Services models.| Master Data Services | Master Data Services| Windows|
| <a id=2584051>[2584051](#2584051) </a> | Enables IO error mode history in retail builds by using trace flag 3139 to allow the investigation of the assertion failure (Location: readEncoded.cpp:2988; Expression:  m_pDecodeSplitInput->GetAvailableFreeSize () >= lengthInNext) that may occur while restoring transaction log backups.| SQL Server Engine | Backup Restore| All|
| <a id=2567536>[2567536](#2567536) </a> | Fixes an issue in which an availability group that has database level health detection enabled triggers needless failover for the following error 1105 when data files reach the limit size or the configured maximization: </br></br>\<DateTime> Error: 1105, Severity: 17, State: 2. </br>\<DateTime> Could not allocate space for object '\<TableName>' in database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full. Create disk space by deleting unneeded files, dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. | SQL Server Engine| High Availability and Disaster Recovery | Windows|
| <a id=2595013>[2595013](#2595013) </a> | Fixes an issue in which the log shipping backup fails with the error "Could not retrieve backup settings for primary ID" when you upgrade a SQL Server instance that has a log shipping configuration to SQL Server 2022. | SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=2583619>[2583619](#2583619) </a> | Provides the details of the corrupt checkpoint file that's associated with the in-memory database when you try to restore a database but it fails with the following error: </br></br>[ERROR] Recovery failed with error 0x84000004 on database 10. This error will be mapped to 'HK_E_RESTORE_ABORTED' (0x82000018). (sql\ntdbms\hekaton\runtime\src\hkruntime.cpp : 5051 - 'HkRtRestoreDatabase') | SQL Server Engine| In-Memory OLTP|Windows |
| <a id=2464304>[2464304](#2464304) </a> | Fixes an issue in which the Query Store (QDS) cleanup task doesn't clean up statistics. Before applying the fix, the QDS size keeps growing when you keep running more workloads until it switches to the `READ_ONLY` state. Additionally, without this fix, the cleanup task randomly deletes queries instead of deleting queries that have lower importance when the QDS size approaches the maximum size.| SQL Server Engine|Query Store|All |
| <a id=2519092>[2519092](#2519092) </a> | Fixes an issue in which the dynamic snapshot fails with the error "Arithmetic overflow error converting expression to data type int" in the `partition_id_eval_proc` column when you try to add new subscriptions to merge publications.| SQL Server Engine| Replication | Windows|
| <a id=2606680>[2606680](#2606680) </a> | Fixes the following error 2570 that you encounter when you run `DBCC CHECKDB` against a database, which is caused by using negative parameters in the `RANDOM` function against a column that uses dynamic data masking (DDM): </br></br>Msg 2570, Level 16, State 3, Line \<LineNumber> </br>Page (\<PageID>), slot \<SlotID> in object ID \<ObjectID>, index ID \<IndexID>, partition ID \<PartitionID>, alloc unit ID \<UnitID> (type "\<Type>"). Column "\<ColumnName>" value is out of range for data type "\<DataType>". Update column to a legal value.| SQL Server Engine|Security Infrastructure|All |
| <a id=2591508>[2591508](#2591508) </a> | Adds a compressed memory dump feature that helps create a compressed memory stream to replace the conventional memory stream to speed up the dump process and reduce the size of the dump file. For more information, see [Use the Sqldumper.exe tool to generate a dump file in SQL Server](../../tools/use-sqldumper-generate-dump-file.md#parallel-compression-of-memory-dumps).| SQL Server Engine|SQL OS |Windows |
| <a id=2330273>[2330273](#2330273) </a> | Fixes an assertion dump issue (Location: sebind.h:1206; Expression: bufferLen >= colLen) that you encounter when running an `INSERT` statement against the table that has the **nvarchar(n)** column as an index column.| SQL Server Engine| SQL Server Engine |All |
| <a id=2557552>[2557552](#2557552) </a> | Fixes error 692 that occurs when you create a non-clustered index under the following scenario: </br></br>- A clustered index already exists in the table. </br></br>- You create a non-clustered index that has the `RESUMABLE` option. </br></br>- The non-clustered index has an `INCLUDE` clause that has the key columns from the clustered index but in a different order. </br></br>Error message: </br></br>Msg 692, Level 22, State 1, line \<LineNumber> </br>Internal error. Buffer provided to write a fixed column value is too large. Run DBCC CHECKDB to check for any corruption. </br></br>**Note**: Specifying the included columns in the same order as in the clustered index or removing them from the `INCLUDE` clause can prevent the error. | SQL Server Engine| Table Index Partition | All|
| <a id=2587977>[2587977](#2587977) </a> | Fixes the error "The service cannot be started, either because it is disabled or because it has no enabled devices associated with it" that you encounter when performing an in-place upgrade to SQL Server 2022 while the SQL Writer service is disabled.|SQL Setup |Patching |Windows |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

> [!NOTE]
>
> - Microsoft Download Center will always present the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU8 now](https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/updt/2023/09/sqlserver2022-kb5029666-x64_30b8b3666963cf01cb09b35c26a34a04d89cde8d.exe)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202022) contains this SQL Server 2022 CU and previously released SQL Server 2022 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2022 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2022 Release Notes](/sql/linux/sql-server-linux-release-notes-2022).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the *SQLServer2022-KB5029666-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5029666-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5029666-x64.exe|  505FF05430527FF1549DA0778C1710D433915D25C510CA261C850BF58C3EC2D2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.221 | 336792    | 23-Aug-23 | 14:39 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.221     | 2903464   | 23-Aug-23 | 14:40 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 23-Aug-23 | 14:39 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 23-Aug-23 | 14:39 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 23-Aug-23 | 14:39 | x86      |
| Msmdctr.dll                                         | 2022.160.43.221 | 38864     | 23-Aug-23 | 14:40 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.221 | 53929928  | 23-Aug-23 | 14:40 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.221 | 71768016  | 23-Aug-23 | 14:40 | x64      |
| Msmdpump.dll                                        | 2022.160.43.221 | 10335184  | 23-Aug-23 | 14:40 | x64      |
| Msmdredir.dll                                       | 2022.160.43.221 | 8131992   | 23-Aug-23 | 14:40 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.221 | 71309264  | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 956328    | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1884096   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1671080   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1880520   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1847720   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1146824   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1139624   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1768896   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1748392   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 932288    | 23-Aug-23 | 14:40 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.221 | 1837000   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 954816    | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1882024   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1668040   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1875912   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1844168   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1144744   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1138088   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1764808   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1744840   | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 932264    | 23-Aug-23 | 14:40 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.221 | 1832360   | 23-Aug-23 | 14:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.221 | 10083792  | 23-Aug-23 | 14:40 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.221 | 8265640   | 23-Aug-23 | 14:40 | x86      |
| Msolap.dll                                          | 2022.160.43.221 | 10970064  | 23-Aug-23 | 14:40 | x64      |
| Msolap.dll                                          | 2022.160.43.221 | 8744912   | 23-Aug-23 | 14:40 | x86      |
| Msolui.dll                                          | 2022.160.43.221 | 289744    | 23-Aug-23 | 14:40 | x86      |
| Msolui.dll                                          | 2022.160.43.221 | 308176    | 23-Aug-23 | 14:40 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 23-Aug-23 | 14:39 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 23-Aug-23 | 14:39 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:39 | x64      |
| Sqlceip.exe                                         | 16.0.4075.1     | 301008    | 23-Aug-23 | 14:43 | x86      |
| Sqldumper.exe                                       | 2022.160.4075.1 | 370640    | 23-Aug-23 | 14:43 | x86      |
| Sqldumper.exe                                       | 2022.160.4075.1 | 436176    | 23-Aug-23 | 14:43 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 23-Aug-23 | 14:39 | x86      |
| Tmapi.dll                                           | 2022.160.43.221 | 5884312   | 23-Aug-23 | 14:40 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.221 | 5575064   | 23-Aug-23 | 14:40 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.221 | 1481112   | 23-Aug-23 | 14:40 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.221 | 7198120   | 23-Aug-23 | 14:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.221 | 26594256  | 23-Aug-23 | 14:40 | x64      |
| Xmsrv.dll                                           | 2022.160.43.221 | 35896272  | 23-Aug-23 | 14:40 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4075.1 | 104488    | 23-Aug-23 | 14:43 | x64      |
| Instapi150.dll                             | 2022.160.4075.1 | 79912     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.221     | 2633680   | 23-Aug-23 | 14:38 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.221     | 2633664   | 23-Aug-23 | 14:38 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.221     | 2933200   | 23-Aug-23 | 14:38 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.221     | 2323408   | 23-Aug-23 | 14:38 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.221     | 2323352   | 23-Aug-23 | 14:38 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4075.1 | 104504    | 23-Aug-23 | 14:43 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4075.1 | 92200     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4075.1     | 554944    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4075.1     | 555064    | 23-Aug-23 | 14:43 | x86      |
| Msasxpress.dll                             | 2022.160.43.221 | 27600     | 23-Aug-23 | 14:38 | x86      |
| Msasxpress.dll                             | 2022.160.43.221 | 32680     | 23-Aug-23 | 14:38 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:38 | x64      |
| Sqldumper.exe                              | 2022.160.4075.1 | 370640    | 23-Aug-23 | 14:43 | x86      |
| Sqldumper.exe                              | 2022.160.4075.1 | 436176    | 23-Aug-23 | 14:43 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4075.1 | 395200    | 23-Aug-23 | 14:43 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4075.1 | 456640    | 23-Aug-23 | 14:43 | x64      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.views.dll | 16.0.4075.1     | 2070568   | 23-Aug-23 | 14:43 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:43 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4075.1  | 600000    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4075.1  | 600016    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4075.1  | 174016    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4075.1  | 1857472   | 23-Aug-23 | 14:43 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4075.1  | 1857576   | 23-Aug-23 | 14:43 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4075.1  | 370624    | 23-Aug-23 | 14:43 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   | Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 24-Aug-23 | 00:59 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 24-Aug-23 | 00:59 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4075.1 | 4719160   | 24-Aug-23 | 00:59 | x64      |
| Aetm-enclave.dll                             | 2022.160.4075.1 | 4673600   | 24-Aug-23 | 00:59 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4075.1 | 4909248   | 24-Aug-23 | 00:59 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4075.1 | 4874496   | 24-Aug-23 | 00:59 | x64      |
| Dcexec.exe                                   | 2022.160.4075.1 | 96208     | 24-Aug-23 | 00:59 | x64      |
| Fssres.dll                                   | 2022.160.4075.1 | 100288    | 24-Aug-23 | 00:59 | x64      |
| Hadrres.dll                                  | 2022.160.4075.1 | 227264    | 24-Aug-23 | 00:59 | x64      |
| Hkcompile.dll                                | 2022.160.4075.1 | 1411008   | 24-Aug-23 | 00:59 | x64      |
| Hkengine.dll                                 | 2022.160.4075.1 | 5765056   | 24-Aug-23 | 00:59 | x64      |
| Hkruntime.dll                                | 2022.160.4075.1 | 190400    | 24-Aug-23 | 00:59 | x64      |
| Hktempdb.dll                                 | 2022.160.4075.1 | 71632     | 24-Aug-23 | 00:59 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.221     | 2322384   | 24-Aug-23 | 00:59 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4075.1 | 333880    | 24-Aug-23 | 00:59 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4075.1 | 96296     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 30656     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 38864     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 34872     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 38848     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 38848     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 30656     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 30656     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 34856     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 38864     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 30776     | 24-Aug-23 | 00:59 | x64      |
| `Odsole70.rll`                                 | 16.0.4075.1     | 38952     | 24-Aug-23 | 00:59 | x64      |
| Qds.dll                                      | 2022.160.4075.1 | 1800232   | 24-Aug-23 | 00:59 | x64      |
| Rsfxft.dll                                   | 2022.160.4075.1 | 55352     | 24-Aug-23 | 00:59 | x64      |
| Secforwarder.dll                             | 2022.160.4075.1 | 84008     | 24-Aug-23 | 00:38 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4075.1 | 137256    | 24-Aug-23 | 00:59 | x64      |
| Sqlaccess.dll                                | 2022.160.4075.1 | 444456    | 24-Aug-23 | 00:59 | x64      |
| Sqlagent.exe                                 | 2022.160.4075.1 | 714688    | 24-Aug-23 | 00:59 | x64      |
| Sqlceip.exe                                  | 16.0.4075.1     | 301008    | 24-Aug-23 | 00:59 | x86      |
| Sqlctr160.dll                                | 2022.160.4075.1 | 157736    | 24-Aug-23 | 00:59 | x64      |
| Sqlctr160.dll                                | 2022.160.4075.1 | 128960    | 24-Aug-23 | 00:59 | x86      |
| Sqldk.dll                                    | 2022.160.4075.1 | 4003880   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 1746984   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3848248   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4065336   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4573224   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4704296   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3749944   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3938344   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4573224   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4405288   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4474936   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 2443304   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 2385976   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4261928   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3897384   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4413496   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4208680   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4192296   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3975208   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 3852328   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 1685560   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4298792   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                 | 2022.160.4075.1 | 4442152   | 24-Aug-23 | 00:38 | x64      |
| Sqliosim.com                                 | 2022.160.4075.1 | 387112    | 24-Aug-23 | 00:59 | x64      |
| Sqliosim.exe                                 | 2022.160.4075.1 | 3057704   | 24-Aug-23 | 00:59 | x64      |
| Sqllang.dll                                  | 2022.160.4075.1 | 48568360  | 24-Aug-23 | 00:59 | x64      |
| Sqlmin.dll                                   | 2022.160.4075.1 | 51124176  | 24-Aug-23 | 00:59 | x64      |
| Sqlos.dll                                    | 2022.160.4075.1 | 51136     | 24-Aug-23 | 00:38 | x64      |
| Sqlrepss.dll                                 | 2022.160.4075.1 | 137256    | 24-Aug-23 | 00:59 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4075.1 | 51240     | 24-Aug-23 | 00:59 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4075.1 | 5830712   | 24-Aug-23 | 00:59 | x64      |
| Sqlservr.exe                                 | 2022.160.4075.1 | 714792    | 24-Aug-23 | 00:59 | x64      |
| Sqltses.dll                                  | 2022.160.4075.1 | 9385936   | 24-Aug-23 | 00:38 | x64      |
| Sqsrvres.dll                                 | 2022.160.4075.1 | 305104    | 24-Aug-23 | 00:59 | x64      |
| Svl.dll                                      | 2022.160.4075.1 | 247848    | 24-Aug-23 | 00:59 | x64      |
| Xe.dll                                       | 2022.160.4075.1 | 718784    | 24-Aug-23 | 00:59 | x64      |
| Xpstar.dll                                   | 2022.160.4075.1 | 534464    | 24-Aug-23 | 00:59 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                      | 2022.160.4075.1 | 272320    | 23-Aug-23 | 14:43 | x64      |
| Datacollectortasks.dll                               | 2022.160.4075.1 | 227280    | 23-Aug-23 | 14:43 | x64      |
| Distrib.exe                                          | 2022.160.4075.1 | 260032    | 23-Aug-23 | 14:43 | x64      |
| Dteparse.dll                                         | 2022.160.4075.1 | 133056    | 23-Aug-23 | 14:43 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4075.1 | 178120    | 23-Aug-23 | 14:43 | x64      |
| Dtepkg.dll                                           | 2022.160.4075.1 | 153536    | 23-Aug-23 | 14:43 | x64      |
| Dtexec.exe                                           | 2022.160.4075.1 | 76840     | 23-Aug-23 | 14:43 | x64      |
| Dts.dll                                              | 2022.160.4075.1 | 3266600   | 23-Aug-23 | 14:43 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4075.1 | 493624    | 23-Aug-23 | 14:43 | x64      |
| Dtsconn.dll                                          | 2022.160.4075.1 | 550864    | 23-Aug-23 | 14:43 | x64      |
| Dtshost.exe                                          | 2022.160.4075.1 | 120360    | 23-Aug-23 | 14:43 | x64      |
| Dtspipeline.dll                                      | 2022.160.4075.1 | 1337280   | 23-Aug-23 | 14:43 | x64      |
| Dtuparse.dll                                         | 2022.160.4075.1 | 104384    | 23-Aug-23 | 14:43 | x64      |
| Dtutil.exe                                           | 2022.160.4075.1 | 166456    | 23-Aug-23 | 14:43 | x64      |
| Exceldest.dll                                        | 2022.160.4075.1 | 284608    | 23-Aug-23 | 14:43 | x64      |
| Excelsrc.dll                                         | 2022.160.4075.1 | 305088    | 23-Aug-23 | 14:43 | x64      |
| Execpackagetask.dll                                  | 2022.160.4075.1 | 182208    | 23-Aug-23 | 14:43 | x64      |
| Flatfiledest.dll                                     | 2022.160.4075.1 | 423872    | 23-Aug-23 | 14:43 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4075.1 | 440256    | 23-Aug-23 | 14:43 | x64      |
| Logread.exe                                          | 2022.160.4075.1 | 788416    | 23-Aug-23 | 14:43 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.221     | 2933696   | 23-Aug-23 | 14:43 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 23-Aug-23 | 14:43 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4075.1     | 30656     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4075.1     | 391224    | 23-Aug-23 | 14:43 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4075.1 | 1706024   | 23-Aug-23 | 14:43 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4075.1     | 555064    | 23-Aug-23 | 14:43 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4075.1 | 124864    | 23-Aug-23 | 14:43 | x64      |
| Msgprox.dll                                          | 2022.160.4075.1 | 313384    | 23-Aug-23 | 14:43 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 2729992   | 23-Aug-23 | 14:43 | x64      |
| Msoledbsql.dll                                       | 2018.186.6.0    | 153608    | 23-Aug-23 | 14:43 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 23-Aug-23 | 14:43 | x86      |
| Oledbdest.dll                                        | 2022.160.4075.1 | 288704    | 23-Aug-23 | 14:43 | x64      |
| Oledbsrc.dll                                         | 2022.160.4075.1 | 313280    | 23-Aug-23 | 14:43 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4075.1 | 522192    | 23-Aug-23 | 14:43 | x64      |
| Rawdest.dll                                          | 2022.160.4075.1 | 227264    | 23-Aug-23 | 14:43 | x64      |
| Rawsource.dll                                        | 2022.160.4075.1 | 214976    | 23-Aug-23 | 14:43 | x64      |
| Rdistcom.dll                                         | 2022.160.4075.1 | 939968    | 23-Aug-23 | 14:43 | x64      |
| Recordsetdest.dll                                    | 2022.160.4075.1 | 206792    | 23-Aug-23 | 14:43 | x64      |
| Repldp.dll                                           | 2022.160.4075.1 | 337856    | 23-Aug-23 | 14:43 | x64      |
| Replerrx.dll                                         | 2022.160.4075.1 | 198712    | 23-Aug-23 | 14:43 | x64      |
| Replisapi.dll                                        | 2022.160.4075.1 | 419896    | 23-Aug-23 | 14:43 | x64      |
| Replmerg.exe                                         | 2022.160.4075.1 | 596008    | 23-Aug-23 | 14:43 | x64      |
| Replprov.dll                                         | 2022.160.4075.1 | 890920    | 23-Aug-23 | 14:43 | x64      |
| Replrec.dll                                          | 2022.160.4075.1 | 1058752   | 23-Aug-23 | 14:43 | x64      |
| Replsub.dll                                          | 2022.160.4075.1 | 501816    | 23-Aug-23 | 14:43 | x64      |
| Spresolv.dll                                         | 2022.160.4075.1 | 301096    | 23-Aug-23 | 14:43 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:43 | x64      |
| Sqlcmd.exe                                           | 2022.160.4075.1 | 276416    | 23-Aug-23 | 14:43 | x64      |
| Sqldistx.dll                                         | 2022.160.4075.1 | 268224    | 23-Aug-23 | 14:43 | x64      |
| Sqlmergx.dll                                         | 2022.160.4075.1 | 423976    | 23-Aug-23 | 14:43 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4075.1 | 210896    | 23-Aug-23 | 14:43 | x64      |
| Txagg.dll                                            | 2022.160.4075.1 | 395200    | 23-Aug-23 | 14:43 | x64      |
| Txbdd.dll                                            | 2022.160.4075.1 | 190400    | 23-Aug-23 | 14:43 | x64      |
| Txdatacollector.dll                                  | 2022.160.4075.1 | 468928    | 23-Aug-23 | 14:43 | x64      |
| Txdataconvert.dll                                    | 2022.160.4075.1 | 333880    | 23-Aug-23 | 14:43 | x64      |
| Txderived.dll                                        | 2022.160.4075.1 | 632872    | 23-Aug-23 | 14:43 | x64      |
| Txlookup.dll                                         | 2022.160.4075.1 | 608208    | 23-Aug-23 | 14:43 | x64      |
| Txmerge.dll                                          | 2022.160.4075.1 | 243664    | 23-Aug-23 | 14:43 | x64      |
| Txmergejoin.dll                                      | 2022.160.4075.1 | 300992    | 23-Aug-23 | 14:43 | x64      |
| Txmulticast.dll                                      | 2022.160.4075.1 | 145344    | 23-Aug-23 | 14:43 | x64      |
| Txrowcount.dll                                       | 2022.160.4075.1 | 145344    | 23-Aug-23 | 14:43 | x64      |
| Txsort.dll                                           | 2022.160.4075.1 | 276416    | 23-Aug-23 | 14:43 | x64      |
| Txsplit.dll                                          | 2022.160.4075.1 | 620584    | 23-Aug-23 | 14:43 | x64      |
| Txunionall.dll                                       | 2022.160.4075.1 | 194600    | 23-Aug-23 | 14:43 | x64      |
| Xe.dll                                               | 2022.160.4075.1 | 718784    | 23-Aug-23 | 14:43 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4075.1 | 100392    | 23-Aug-23 | 14:43 | x64      |
| Exthost.exe                   | 2022.160.4075.1 | 247760    | 23-Aug-23 | 14:43 | x64      |
| Launchpad.exe                 | 2022.160.4075.1 | 1447872   | 23-Aug-23 | 14:43 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:39 | x64      |
| Sqlsatellite.dll              | 2022.160.4075.1 | 1255360   | 23-Aug-23 | 14:43 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4075.1 | 710608    | 23-Aug-23 | 14:43 | x64      |
| Fdhost.exe               | 2022.160.4075.1 | 153536    | 23-Aug-23 | 14:43 | x64      |
| Fdlauncher.exe           | 2022.160.4075.1 | 100288    | 23-Aug-23 | 14:43 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:39 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 23-Aug-23 | 14:51 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 23-Aug-23 | 14:51 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 23-Aug-23 | 14:51 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 23-Aug-23 | 14:51 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 23-Aug-23 | 14:51 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 23-Aug-23 | 14:51 | x86      |
| Commanddest.dll                                               | 2022.160.4075.1 | 231360    | 23-Aug-23 | 14:50 | x86      |
| Commanddest.dll                                               | 2022.160.4075.1 | 272320    | 23-Aug-23 | 14:50 | x64      |
| Dteparse.dll                                                  | 2022.160.4075.1 | 116776    | 23-Aug-23 | 14:50 | x86      |
| Dteparse.dll                                                  | 2022.160.4075.1 | 133056    | 23-Aug-23 | 14:51 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4075.1 | 165824    | 23-Aug-23 | 14:50 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4075.1 | 178120    | 23-Aug-23 | 14:50 | x64      |
| Dtepkg.dll                                                    | 2022.160.4075.1 | 129064    | 23-Aug-23 | 14:50 | x86      |
| Dtepkg.dll                                                    | 2022.160.4075.1 | 153536    | 23-Aug-23 | 14:51 | x64      |
| Dtexec.exe                                                    | 2022.160.4075.1 | 65064     | 23-Aug-23 | 14:50 | x86      |
| Dtexec.exe                                                    | 2022.160.4075.1 | 76840     | 23-Aug-23 | 14:51 | x64      |
| Dts.dll                                                       | 2022.160.4075.1 | 2861096   | 23-Aug-23 | 14:50 | x86      |
| Dts.dll                                                       | 2022.160.4075.1 | 3266600   | 23-Aug-23 | 14:51 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4075.1 | 444456    | 23-Aug-23 | 14:50 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4075.1 | 493624    | 23-Aug-23 | 14:51 | x64      |
| Dtsconn.dll                                                   | 2022.160.4075.1 | 464952    | 23-Aug-23 | 14:50 | x86      |
| Dtsconn.dll                                                   | 2022.160.4075.1 | 550864    | 23-Aug-23 | 14:51 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4075.1 | 94760     | 23-Aug-23 | 14:50 | x86      |
| Dtsdebughost.exe                                              | 2022.160.4075.1 | 114624    | 23-Aug-23 | 14:50 | x64      |
| Dtshost.exe                                                   | 2022.160.4075.1 | 98344     | 23-Aug-23 | 14:50 | x86      |
| Dtshost.exe                                                   | 2022.160.4075.1 | 120360    | 23-Aug-23 | 14:51 | x64      |
| Dtspipeline.dll                                               | 2022.160.4075.1 | 1144872   | 23-Aug-23 | 14:50 | x86      |
| Dtspipeline.dll                                               | 2022.160.4075.1 | 1337280   | 23-Aug-23 | 14:51 | x64      |
| Dtuparse.dll                                                  | 2022.160.4075.1 | 88000     | 23-Aug-23 | 14:50 | x86      |
| Dtuparse.dll                                                  | 2022.160.4075.1 | 104384    | 23-Aug-23 | 14:51 | x64      |
| Dtutil.exe                                                    | 2022.160.4075.1 | 142376    | 23-Aug-23 | 14:50 | x86      |
| Dtutil.exe                                                    | 2022.160.4075.1 | 166456    | 23-Aug-23 | 14:51 | x64      |
| Exceldest.dll                                                 | 2022.160.4075.1 | 247848    | 23-Aug-23 | 14:50 | x86      |
| Exceldest.dll                                                 | 2022.160.4075.1 | 284608    | 23-Aug-23 | 14:51 | x64      |
| Excelsrc.dll                                                  | 2022.160.4075.1 | 264144    | 23-Aug-23 | 14:50 | x86      |
| Excelsrc.dll                                                  | 2022.160.4075.1 | 305088    | 23-Aug-23 | 14:50 | x64      |
| Execpackagetask.dll                                           | 2022.160.4075.1 | 149440    | 23-Aug-23 | 14:50 | x86      |
| Execpackagetask.dll                                           | 2022.160.4075.1 | 182208    | 23-Aug-23 | 14:50 | x64      |
| Flatfiledest.dll                                              | 2022.160.4075.1 | 374720    | 23-Aug-23 | 14:50 | x86      |
| Flatfiledest.dll                                              | 2022.160.4075.1 | 423872    | 23-Aug-23 | 14:51 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4075.1 | 391104    | 23-Aug-23 | 14:50 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4075.1 | 440256    | 23-Aug-23 | 14:50 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4075.1     | 120768    | 23-Aug-23 | 14:50 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4075.1     | 120872    | 23-Aug-23 | 14:51 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.221     | 2933696   | 23-Aug-23 | 14:51 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.221     | 2933712   | 23-Aug-23 | 14:51 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4075.1     | 509888    | 23-Aug-23 | 14:50 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4075.1     | 510008    | 23-Aug-23 | 14:50 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4075.1     | 391224    | 23-Aug-23 | 14:50 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4075.1     | 219192    | 23-Aug-23 | 14:50 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4075.1 | 100288    | 23-Aug-23 | 14:50 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4075.1 | 124864    | 23-Aug-23 | 14:51 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.221 | 10165696  | 23-Aug-23 | 14:51 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-23 | 14:50 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-23 | 14:50 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 23-Aug-23 | 14:51 | x86      |
| Odbcdest.dll                                                  | 2022.160.4075.1 | 341968    | 23-Aug-23 | 14:50 | x86      |
| Odbcdest.dll                                                  | 2022.160.4075.1 | 382912    | 23-Aug-23 | 14:50 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4075.1 | 350144    | 23-Aug-23 | 14:50 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4075.1 | 399416    | 23-Aug-23 | 14:51 | x64      |
| Oledbdest.dll                                                 | 2022.160.4075.1 | 247744    | 23-Aug-23 | 14:50 | x86      |
| Oledbdest.dll                                                 | 2022.160.4075.1 | 288704    | 23-Aug-23 | 14:50 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4075.1 | 268240    | 23-Aug-23 | 14:50 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4075.1 | 313280    | 23-Aug-23 | 14:51 | x64      |
| Rawdest.dll                                                   | 2022.160.4075.1 | 190400    | 23-Aug-23 | 14:50 | x86      |
| Rawdest.dll                                                   | 2022.160.4075.1 | 227264    | 23-Aug-23 | 14:51 | x64      |
| Rawsource.dll                                                 | 2022.160.4075.1 | 186304    | 23-Aug-23 | 14:50 | x86      |
| Rawsource.dll                                                 | 2022.160.4075.1 | 214976    | 23-Aug-23 | 14:51 | x64      |
| Recordsetdest.dll                                             | 2022.160.4075.1 | 174120    | 23-Aug-23 | 14:50 | x86      |
| Recordsetdest.dll                                             | 2022.160.4075.1 | 206792    | 23-Aug-23 | 14:51 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4075.1 | 137256    | 23-Aug-23 | 14:50 | x64      |
| Sqlceip.exe                                                   | 16.0.4075.1     | 301008    | 23-Aug-23 | 14:51 | x86      |
| Sqldest.dll                                                   | 2022.160.4075.1 | 255936    | 23-Aug-23 | 14:50 | x86      |
| Sqldest.dll                                                   | 2022.160.4075.1 | 288704    | 23-Aug-23 | 14:51 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4075.1 | 174016    | 23-Aug-23 | 14:50 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4075.1 | 210896    | 23-Aug-23 | 14:51 | x64      |
| Txagg.dll                                                     | 2022.160.4075.1 | 346048    | 23-Aug-23 | 14:50 | x86      |
| Txagg.dll                                                     | 2022.160.4075.1 | 395200    | 23-Aug-23 | 14:51 | x64      |
| Txbdd.dll                                                     | 2022.160.4075.1 | 149544    | 23-Aug-23 | 14:51 | x86      |
| Txbdd.dll                                                     | 2022.160.4075.1 | 190400    | 23-Aug-23 | 14:51 | x64      |
| Txbestmatch.dll                                               | 2022.160.4075.1 | 567232    | 23-Aug-23 | 14:51 | x86      |
| Txbestmatch.dll                                               | 2022.160.4075.1 | 661440    | 23-Aug-23 | 14:51 | x64      |
| Txcache.dll                                                   | 2022.160.4075.1 | 169920    | 23-Aug-23 | 14:50 | x86      |
| Txcache.dll                                                   | 2022.160.4075.1 | 202792    | 23-Aug-23 | 14:51 | x64      |
| Txcharmap.dll                                                 | 2022.160.4075.1 | 280512    | 23-Aug-23 | 14:50 | x86      |
| Txcharmap.dll                                                 | 2022.160.4075.1 | 325688    | 23-Aug-23 | 14:51 | x64      |
| Txcopymap.dll                                                 | 2022.160.4075.1 | 165928    | 23-Aug-23 | 14:50 | x86      |
| Txcopymap.dll                                                 | 2022.160.4075.1 | 202688    | 23-Aug-23 | 14:51 | x64      |
| Txdataconvert.dll                                             | 2022.160.4075.1 | 288704    | 23-Aug-23 | 14:50 | x86      |
| Txdataconvert.dll                                             | 2022.160.4075.1 | 333880    | 23-Aug-23 | 14:51 | x64      |
| Txderived.dll                                                 | 2022.160.4075.1 | 559040    | 23-Aug-23 | 14:50 | x86      |
| Txderived.dll                                                 | 2022.160.4075.1 | 632872    | 23-Aug-23 | 14:51 | x64      |
| Txfileextractor.dll                                           | 2022.160.4075.1 | 186408    | 23-Aug-23 | 14:51 | x86      |
| Txfileextractor.dll                                           | 2022.160.4075.1 | 219088    | 23-Aug-23 | 14:51 | x64      |
| Txfileinserter.dll                                            | 2022.160.4075.1 | 186424    | 23-Aug-23 | 14:51 | x86      |
| Txfileinserter.dll                                            | 2022.160.4075.1 | 219072    | 23-Aug-23 | 14:51 | x64      |
| Txgroupdups.dll                                               | 2022.160.4075.1 | 354240    | 23-Aug-23 | 14:51 | x86      |
| Txgroupdups.dll                                               | 2022.160.4075.1 | 403392    | 23-Aug-23 | 14:51 | x64      |
| Txlineage.dll                                                 | 2022.160.4075.1 | 129064    | 23-Aug-23 | 14:51 | x86      |
| Txlineage.dll                                                 | 2022.160.4075.1 | 157632    | 23-Aug-23 | 14:51 | x64      |
| Txlookup.dll                                                  | 2022.160.4075.1 | 522192    | 23-Aug-23 | 14:51 | x86      |
| Txlookup.dll                                                  | 2022.160.4075.1 | 608208    | 23-Aug-23 | 14:51 | x64      |
| Txmerge.dll                                                   | 2022.160.4075.1 | 194496    | 23-Aug-23 | 14:51 | x86      |
| Txmerge.dll                                                   | 2022.160.4075.1 | 243664    | 23-Aug-23 | 14:51 | x64      |
| Txmergejoin.dll                                               | 2022.160.4075.1 | 255952    | 23-Aug-23 | 14:51 | x86      |
| Txmergejoin.dll                                               | 2022.160.4075.1 | 300992    | 23-Aug-23 | 14:51 | x64      |
| Txmulticast.dll                                               | 2022.160.4075.1 | 116776    | 23-Aug-23 | 14:51 | x86      |
| Txmulticast.dll                                               | 2022.160.4075.1 | 145344    | 23-Aug-23 | 14:51 | x64      |
| Txpivot.dll                                                   | 2022.160.4075.1 | 198592    | 23-Aug-23 | 14:51 | x86      |
| Txpivot.dll                                                   | 2022.160.4075.1 | 239656    | 23-Aug-23 | 14:51 | x64      |
| Txrowcount.dll                                                | 2022.160.4075.1 | 116776    | 23-Aug-23 | 14:51 | x86      |
| Txrowcount.dll                                                | 2022.160.4075.1 | 145344    | 23-Aug-23 | 14:51 | x64      |
| Txsampling.dll                                                | 2022.160.4075.1 | 153656    | 23-Aug-23 | 14:51 | x86      |
| Txsampling.dll                                                | 2022.160.4075.1 | 186304    | 23-Aug-23 | 14:51 | x64      |
| Txscd.dll                                                     | 2022.160.4075.1 | 198592    | 23-Aug-23 | 14:51 | x86      |
| Txscd.dll                                                     | 2022.160.4075.1 | 235456    | 23-Aug-23 | 14:51 | x64      |
| Txsort.dll                                                    | 2022.160.4075.1 | 231360    | 23-Aug-23 | 14:51 | x86      |
| Txsort.dll                                                    | 2022.160.4075.1 | 276416    | 23-Aug-23 | 14:51 | x64      |
| Txsplit.dll                                                   | 2022.160.4075.1 | 550864    | 23-Aug-23 | 14:51 | x86      |
| Txsplit.dll                                                   | 2022.160.4075.1 | 620584    | 23-Aug-23 | 14:51 | x64      |
| Txtermextraction.dll                                          | 2022.160.4075.1 | 8648640   | 23-Aug-23 | 14:51 | x86      |
| Txtermextraction.dll                                          | 2022.160.4075.1 | 8701992   | 23-Aug-23 | 14:51 | x64      |
| Txtermlookup.dll                                              | 2022.160.4075.1 | 4138944   | 23-Aug-23 | 14:51 | x86      |
| Txtermlookup.dll                                              | 2022.160.4075.1 | 4184000   | 23-Aug-23 | 14:51 | x64      |
| Txunionall.dll                                                | 2022.160.4075.1 | 153536    | 23-Aug-23 | 14:51 | x86      |
| Txunionall.dll                                                | 2022.160.4075.1 | 194600    | 23-Aug-23 | 14:51 | x64      |
| Txunpivot.dll                                                 | 2022.160.4075.1 | 178216    | 23-Aug-23 | 14:51 | x86      |
| Txunpivot.dll                                                 | 2022.160.4075.1 | 214976    | 23-Aug-23 | 14:51 | x64      |
| Xe.dll                                                        | 2022.160.4075.1 | 640960    | 23-Aug-23 | 14:51 | x86      |
| Xe.dll                                                        | 2022.160.4075.1 | 718784    | 23-Aug-23 | 14:51 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   | Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:----:|:--------:|
| Dms.dll                                                              | 16.0.1029.0     | 559520    | 24-Aug-23 | 00:38 | x86      |
| Dmsnative.dll                                                        | 2022.160.1029.0 | 152480    | 24-Aug-23 | 00:38 | x64      |
| Dwengineservice.dll                                                  | 16.0.1029.0     | 44960     | 24-Aug-23 | 00:38 | x86      |
| Instapi150.dll                                                       | 2022.160.4075.1 | 104488    | 24-Aug-23 | 00:38 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1029.0     | 67536     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1029.0     | 293328    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1029.0     | 1958352   | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1029.0     | 169424    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1029.0     | 647120    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1029.0     | 246216    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1029.0     | 139216    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1029.0     | 79776     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1029.0     | 51104     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1029.0     | 88480     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1029.0     | 1129376   | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1029.0     | 80848     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1029.0     | 70560     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1029.0     | 35232     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1029.0     | 30624     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1029.0     | 46496     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1029.0     | 21456     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1029.0     | 26528     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1029.0     | 131536    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1029.0     | 86480     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1029.0     | 100768    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1029.0     | 293280    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 120272    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 138192    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 141216    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 137680    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 150480    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 139680    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 134608    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 176592    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 117704    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 136656    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1029.0     | 72656     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1029.0     | 21968     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1029.0     | 37280     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1029.0     | 128928    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1029.0     | 3064736   | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1029.0     | 3955616   | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 118176    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133024    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 137680    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133584    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 148432    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 134048    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 130464    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 170912    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 115152    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 132000    | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1029.0     | 67488     | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1029.0     | 2682832   | 24-Aug-23 | 00:38 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1029.0     | 2436512   | 24-Aug-23 | 00:38 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4075.1 | 296896    | 24-Aug-23 | 00:38 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4075.1 | 7796688   | 24-Aug-23 | 00:38 | x64      |
| Secforwarder.dll                                                     | 2022.160.4075.1 | 84008     | 24-Aug-23 | 00:38 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1029.0 | 61392     | 24-Aug-23 | 00:38 | x64      |
| Sqldk.dll                                                            | 2022.160.4075.1 | 4003880   | 24-Aug-23 | 00:38 | x64      |
| Sqldumper.exe                                                        | 2022.160.4075.1 | 436176    | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 1746984   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4573224   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 3749944   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4573224   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4474936   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 2443304   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 2385976   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4208680   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4192296   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 1685560   | 24-Aug-23 | 00:38 | x64      |
| `Sqlevn70.rll`                                                         | 2022.160.4075.1 | 4442152   | 24-Aug-23 | 00:38 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.4.1   | 1898392   | 24-Aug-23 | 00:38 | x64      |
| Sqlos.dll                                                            | 2022.160.4075.1 | 51136     | 24-Aug-23 | 00:38 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1029.0 | 4841424   | 24-Aug-23 | 00:38 | x64      |
| Sqltses.dll                                                          | 2022.160.4075.1 | 9385936   | 24-Aug-23 | 00:38 | x64      |

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2022.

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

One CU package includes all available updates for all SQL Server 2022 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2022**.
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
