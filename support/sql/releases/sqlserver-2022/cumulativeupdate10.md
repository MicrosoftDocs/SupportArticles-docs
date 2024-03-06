---
title: Cumulative update 10 for SQL Server 2022 (KB5031778)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 10 (KB5031778).
ms.date: 01/29/2024
ms.custom: KB5031778
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5031778 - Cumulative Update 10 for SQL Server 2022

_Release Date:_ &nbsp; November 16, 2023  
_Version:_ &nbsp; 16.0.4095.4

## Summary

This article describes Cumulative Update package 10 (CU10) for Microsoft SQL Server 2022. This update contains 9 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 9, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4095.4**, file version: **2022.160.4095.4**
- Analysis Services - Product version: **16.0.43.222**, file version: **2022.160.43.222**

## Known issues in this update

### Read-scale availability group not displayed in dm_hadr_database_replica_cluster_states

SQL Server 2022 CU10 introduced [fix 2714261](#2714261), which causes an issue with `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups that results in the **Availability Databases** folder in SQL Server Management Studio (SSMS) not showing the databases in the availability group (AG). To mitigate this issue, roll back the patch to CU9.

Microsoft is working on a fix for this issue and it will be available in a future CU.

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description| Fix area| Component | Platform |
|------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------|----------|
| <a id=2751378>[2751378](#2751378) </a> | Fixes an access violation dump issue that you encounter when you run a query on the clustered columnstore table that uses the `READPAST` hint. | SQL Server Engine | Column Stores | All|
| <a id=2732520>[2732520](#2732520) </a> | Before this update, in some rare cases, if `IDENTITY_INSERT` is set to `ON`, the identity value for the target table is set to the highest value in the source table when joining tables, even if the highest value doesn't satisfy the join condition or the predicate. This update improves the current design and fixes this issue. </br></br>**Note**: To apply this update, you need to set the `QUERY_OPTIMIZER_HOTFIXES` database scoped configuration to `ON`. To turn off this update, you can enable trace flag 13193.| SQL Server Engine | DB Management | All|
| <a id=2714261>[2714261](#2714261) </a> | Fixes unexpected characters that you encounter in the `name` column of the `sys.availability_groups_cluster` dynamic management view (DMV) when you use the read-scale availability group. | SQL Server Engine | High Availability and Disaster Recovery | All|
| <a id=2645943>[2645943](#2645943) </a> | Fixes an issue in which running `sys.dm_db_xtp_transactions` might fail with the following error if a large number of transactions are in the In-Memory OLTP database engine: </br></br>Msg 701, Level 17, State 157, Line \<LineNumber> </br>There is insufficient system memory in resource pool 'default' to run this query. | SQL Server Engine | In-Memory OLTP| All|
| <a id=2712771>[2712771](#2712771) </a> | Fixes an issue in which the exported delimited text file always uses a comma (',') as the field terminator when you use `CREATE EXTERNAL TABLE AS SELECT (CETAS)` to export data to a delimited text file, even if the `FIELD_TERMINATOR` character is specified in `CREATE EXTERNAL FILE FORMAT`. | SQL Server Engine | PolyBase| All|
| <a id=2698036>[2698036](#2698036) </a> | The Log Reader Agent creates a dynamic linked server for the listener to verify the metadata when you configure a transactional publication on an Always On availability group (AG). This dynamic linked server is temporary and dropped after the verification. When the AG is deployed with replicas in different subnets, this dynamic linked server connection might time out as it tries to connect serially. After applying the fix, if the Log Reader Agent is configured to use the [MultiSubnetFailover](/sql/relational-databases/replication/agents/replication-log-reader-agent) parameter as `1`, the dynamic linked server is also created with the `MultiSubnetFailover` parameter as `1`, which allows connection to occur in parallel.| SQL Server Engine | Replication | Windows|
| <a id=2695485>[2695485](#2695485) </a> | Fixes the following error that you encounter on the target instance when configuring a Service Broker communication with transport security and the certificate serial number length is greater than 16 bytes: </br></br>The certificate serial number size is 19, however it must be no greater than 16 bytes in length. This occurred in the message with Conversation ID, Initiator: 1, and Message sequence number: 0.| SQL Server Engine | SQL Server Engine| All|
| <a id=2606378>[2606378](#2606378) </a> | Updates the errors 1101 and 1105 to explicitly reflect the fact that even `UNLIMITED` database files are limited to 16 TB. </br></br>Error message: </br></br>1101: Could not allocate a new page for database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full due to lack of storage space or database files reaching the maximum allowed size. Note that UNLIMITED files are still limited to 16TB. Create the necessary space by dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. </br></br>1105: Could not allocate space for object '\<ObjectName>' in database '\<DatabaseName>' because the '\<FilegroupName>' filegroup is full due to lack of storage space or database files reaching the maximum allowed size. Note that UNLIMITED files are still limited to 16TB. Create the necessary space by dropping objects in the filegroup, adding additional files to the filegroup, or setting autogrowth on for existing files in the filegroup. | SQL Server Engine | Storage Management| All|
| <a id=2726328>[2726328](#2726328) </a> | Fixes an assertion failure (Location: "cxrowset.cpp":2006; Expression: cstePrefix >= 1) that you encounter when updating statistics fails with the following error: </br></br>Msg 3624, Level 20, State 1, Line \<LineNumber> </br>A system assertion check has failed. Check the SQL Server error log for details. Typically, an assertion failure is caused by a software bug or data corruption. To check for database corruption, consider running DBCC CHECKDB. If you agreed to send dumps to Microsoft during setup, a mini dump will be sent to Microsoft. An update might be available from Microsoft in the latest Service Pack or in a Hotfix from Technical Support.| SQL Server Engine | Table Index Partition | All|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU10 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5031778)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5031778-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5031778-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5031778-x64.exe|  CFB5CFDF000D9F2FFA40FD373FB99FF970353495D1BF8F572509AA26187F9B5E |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File name                       |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.222 | 336944    | 30-Oct-2023 | 16:44 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.222     | 2903608   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 30-Oct-2023 | 16:44 | x86      |
| Msmdctr.dll                                         | 2022.160.43.222 | 38960     | 30-Oct-2023 | 16:44 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 53974984  | 30-Oct-2023 | 16:44 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 71833648  | 30-Oct-2023 | 16:44 | x64      |
| Msmdpump.dll                                        | 2022.160.43.222 | 10335296  | 30-Oct-2023 | 16:44 | x64      |
| Msmdredir.dll                                       | 2022.160.43.222 | 8132032   | 30-Oct-2023 | 16:44 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.222 | 71384624  | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 956976    | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1884736   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1671728   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1881136   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1848256   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1147440   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1140288   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1769408   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1748936   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 932800    | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1837616   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 955440    | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1882560   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1668656   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1876528   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1844800   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1145288   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1138736   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1765424   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1745472   | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 933424    | 30-Oct-2023 | 16:44 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1833008   | 30-Oct-2023 | 16:44 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 8265680   | 30-Oct-2023 | 16:44 | x86      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 10083888  | 30-Oct-2023 | 16:44 | x64      |
| Msolap.dll                                          | 2022.160.43.222 | 8745008   | 30-Oct-2023 | 16:44 | x86      |
| Msolap.dll                                          | 2022.160.43.222 | 10970568  | 30-Oct-2023 | 16:44 | x64      |
| Msolui.dll                                          | 2022.160.43.222 | 289736    | 30-Oct-2023 | 16:44 | x86      |
| Msolui.dll                                          | 2022.160.43.222 | 308272    | 30-Oct-2023 | 16:44 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 30-Oct-2023 | 16:44 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 30-Oct-2023 | 16:44 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |
| Sqlceip.exe                                         | 16.0.4095.4     | 301008    | 30-Oct-2023 | 16:44 | x86      |
| Sqldumper.exe                                       | 2022.160.4095.4 | 370728    | 30-Oct-2023 | 16:44 | x86      |
| Sqldumper.exe                                       | 2022.160.4095.4 | 436160    | 30-Oct-2023 | 16:44 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 30-Oct-2023 | 16:44 | x86      |
| Tmapi.dll                                           | 2022.160.43.222 | 5884480   | 30-Oct-2023 | 16:44 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.222 | 5575104   | 30-Oct-2023 | 16:44 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.222 | 1481264   | 30-Oct-2023 | 16:44 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.222 | 7198256   | 30-Oct-2023 | 16:44 | x64      |
| Xmsrv.dll                                           | 2022.160.43.222 | 35896256  | 30-Oct-2023 | 16:44 | x86      |
| Xmsrv.dll                                           | 2022.160.43.222 | 26593856  | 30-Oct-2023 | 16:44 | x64      |

SQL Server 2022 Database Services Common Core

|                 File name                  |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4095.4 | 104488    | 30-Oct-2023 | 16:44 | x64      |
| Instapi150.dll                             | 2022.160.4095.4 | 79912     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.222     | 2633776   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.222     | 2933296   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323504   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323512   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4095.4 | 104400    | 30-Oct-2023 | 16:44 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4095.4 | 92200     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4095.4     | 554944    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4095.4     | 555064    | 30-Oct-2023 | 16:44 | x86      |
| Msasxpress.dll                             | 2022.160.43.222 | 27696     | 30-Oct-2023 | 16:44 | x86      |
| Msasxpress.dll                             | 2022.160.43.222 | 32720     | 30-Oct-2023 | 16:44 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |
| Sqldumper.exe                              | 2022.160.4095.4 | 370728    | 30-Oct-2023 | 16:44 | x86      |
| Sqldumper.exe                              | 2022.160.4095.4 | 436160    | 30-Oct-2023 | 16:44 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4095.4 | 395200    | 30-Oct-2023 | 16:44 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4095.4 | 456760    | 30-Oct-2023 | 16:44 | x64      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4095.4     | 309184    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4095.4     | 2070568   | 30-Oct-2023 | 16:44 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |

SQL Server 2022 Data Quality

|        File   name        | File version | File size |    Date   |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4095.4  | 600000    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4095.4  | 600016    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4095.4  | 174032    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4095.4  | 1857472   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4095.4  | 370640    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4095.4  | 370744    | 30-Oct-2023 | 16:44 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 30-Oct-2023 | 18:07 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 30-Oct-2023 | 18:07 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4095.4 | 4719160   | 30-Oct-2023 | 17:41 | x64      |
| Aetm-enclave.dll                             | 2022.160.4095.4 | 4673504   | 30-Oct-2023 | 17:41 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4095.4 | 4909248   | 30-Oct-2023 | 17:41 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4095.4 | 4874512   | 30-Oct-2023 | 17:41 | x64      |
| Dcexec.exe                                   | 2022.160.4095.4 | 96192     | 30-Oct-2023 | 18:07 | x64      |
| Fssres.dll                                   | 2022.160.4095.4 | 100392    | 30-Oct-2023 | 18:07 | x64      |
| Hadrres.dll                                  | 2022.160.4095.4 | 227368    | 30-Oct-2023 | 18:07 | x64      |
| Hkcompile.dll                                | 2022.160.4095.4 | 1411008   | 30-Oct-2023 | 18:07 | x64      |
| Hkengine.dll                                 | 2022.160.4095.4 | 5769256   | 30-Oct-2023 | 17:40 | x64      |
| Hkruntime.dll                                | 2022.160.4095.4 | 190504    | 30-Oct-2023 | 17:40 | x64      |
| Hktempdb.dll                                 | 2022.160.4095.4 | 71632     | 30-Oct-2023 | 17:40 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.222     | 2322368   | 30-Oct-2023 | 18:07 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4095.4 | 333760    | 30-Oct-2023 | 18:07 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4095.4 | 96192     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 30672     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 38864     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 34768     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 38848     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 38952     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 30656     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 30672     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 34768     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 38952     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 30672     | 30-Oct-2023 | 18:07 | x64      |
| Odsole70.rll                                 | 16.0.4095.4     | 38952     | 30-Oct-2023 | 18:07 | x64      |
| Qds.dll                                      | 2022.160.4095.4 | 1800128   | 30-Oct-2023 | 18:07 | x64      |
| Rsfxft.dll                                   | 2022.160.4095.4 | 55352     | 30-Oct-2023 | 18:07 | x64      |
| Secforwarder.dll                             | 2022.160.4095.4 | 83904     | 30-Oct-2023 | 17:40 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 18:07 | x64      |
| Sqlaccess.dll                                | 2022.160.4095.4 | 444472    | 30-Oct-2023 | 18:07 | x64      |
| Sqlagent.exe                                 | 2022.160.4095.4 | 714808    | 30-Oct-2023 | 18:07 | x64      |
| Sqlceip.exe                                  | 16.0.4095.4     | 301008    | 30-Oct-2023 | 18:07 | x86      |
| Sqlctr160.dll                                | 2022.160.4095.4 | 157648    | 30-Oct-2023 | 18:07 | x64      |
| Sqlctr160.dll                                | 2022.160.4095.4 | 129080    | 30-Oct-2023 | 18:07 | x86      |
| Sqldk.dll                                    | 2022.160.4095.4 | 4007976   | 30-Oct-2023 | 18:07 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 1750992   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3852328   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4069416   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4577320   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4708392   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3754040   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3942456   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4577320   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4409384   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4479032   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 2447400   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 2390072   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4266040   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3901480   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4417592   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4212776   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4196392   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3979304   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 3856440   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 1689640   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4302888   | 30-Oct-2023 | 17:40 | x64      |
| Sqlevn70.rll                                 | 2022.160.4095.4 | 4446248   | 30-Oct-2023 | 17:40 | x64      |
| Sqliosim.com                                 | 2022.160.4095.4 | 387112    | 30-Oct-2023 | 18:07 | x64      |
| Sqliosim.exe                                 | 2022.160.4095.4 | 3057720   | 30-Oct-2023 | 18:07 | x64      |
| Sqllang.dll                                  | 2022.160.4095.4 | 48670672  | 30-Oct-2023 | 18:07 | x64      |
| Sqlmin.dll                                   | 2022.160.4095.4 | 51193896  | 30-Oct-2023 | 18:07 | x64      |
| Sqlos.dll                                    | 2022.160.4095.4 | 51152     | 30-Oct-2023 | 17:40 | x64      |
| Sqlrepss.dll                                 | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 18:07 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4095.4 | 51240     | 30-Oct-2023 | 18:07 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4095.4 | 5830696   | 30-Oct-2023 | 18:07 | x64      |
| Sqlservr.exe                                 | 2022.160.4095.4 | 722880    | 30-Oct-2023 | 18:07 | x64      |
| Sqltses.dll                                  | 2022.160.4095.4 | 9386040   | 30-Oct-2023 | 18:07 | x64      |
| Sqsrvres.dll                                 | 2022.160.4095.4 | 305208    | 30-Oct-2023 | 18:07 | x64      |
| Svl.dll                                      | 2022.160.4095.4 | 247848    | 30-Oct-2023 | 17:40 | x64      |
| Xe.dll                                       | 2022.160.4095.4 | 718784    | 30-Oct-2023 | 18:07 | x64      |
| Xpqueue.dll                                  | 2022.160.4095.4 | 100304    | 30-Oct-2023 | 18:07 | x64      |
| Xpstar.dll                                   | 2022.160.4095.4 | 534568    | 30-Oct-2023 | 18:07 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                      | 2022.160.4095.4 | 272336    | 30-Oct-2023 | 16:45 | x64      |
| Datacollectortasks.dll                               | 2022.160.4095.4 | 227280    | 30-Oct-2023 | 16:45 | x64      |
| Distrib.exe                                          | 2022.160.4095.4 | 260032    | 30-Oct-2023 | 16:44 | x64      |
| Dteparse.dll                                         | 2022.160.4095.4 | 133056    | 30-Oct-2023 | 16:45 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4095.4 | 178216    | 30-Oct-2023 | 16:44 | x64      |
| Dtepkg.dll                                           | 2022.160.4095.4 | 153656    | 30-Oct-2023 | 16:45 | x64      |
| Dtexec.exe                                           | 2022.160.4095.4 | 76856     | 30-Oct-2023 | 16:45 | x64      |
| Dts.dll                                              | 2022.160.4095.4 | 3266616   | 30-Oct-2023 | 16:45 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4095.4 | 493608    | 30-Oct-2023 | 16:45 | x64      |
| Dtsconn.dll                                          | 2022.160.4095.4 | 550864    | 30-Oct-2023 | 16:45 | x64      |
| Dtshost.exe                                          | 2022.160.4095.4 | 120256    | 30-Oct-2023 | 16:45 | x64      |
| Dtspipeline.dll                                      | 2022.160.4095.4 | 1337384   | 30-Oct-2023 | 16:45 | x64      |
| Dtuparse.dll                                         | 2022.160.4095.4 | 104384    | 30-Oct-2023 | 16:45 | x64      |
| Dtutil.exe                                           | 2022.160.4095.4 | 166456    | 30-Oct-2023 | 16:45 | x64      |
| Exceldest.dll                                        | 2022.160.4095.4 | 284608    | 30-Oct-2023 | 16:45 | x64      |
| Excelsrc.dll                                         | 2022.160.4095.4 | 305104    | 30-Oct-2023 | 16:45 | x64      |
| Execpackagetask.dll                                  | 2022.160.4095.4 | 182208    | 30-Oct-2023 | 16:45 | x64      |
| Flatfiledest.dll                                     | 2022.160.4095.4 | 423976    | 30-Oct-2023 | 16:45 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4095.4 | 440360    | 30-Oct-2023 | 16:45 | x64      |
| Logread.exe                                          | 2022.160.4095.4 | 788416    | 30-Oct-2023 | 16:44 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.222     | 2933816   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.11.22224.1    | 2039304   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4095.4     | 30672     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 30-Oct-2023 | 16:44 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4095.4     | 391120    | 30-Oct-2023 | 16:45 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4095.4 | 1706024   | 30-Oct-2023 | 16:44 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4095.4     | 554944    | 30-Oct-2023 | 16:44 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4095.4 | 124864    | 30-Oct-2023 | 16:45 | x64      |
| Msgprox.dll                                          | 2022.160.4095.4 | 313384    | 30-Oct-2023 | 16:44 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 2729960   | 30-Oct-2023 | 16:44 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 153560    | 30-Oct-2023 | 16:44 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 30-Oct-2023 | 16:45 | x86      |
| Oledbdest.dll                                        | 2022.160.4095.4 | 288704    | 30-Oct-2023 | 16:45 | x64      |
| Oledbsrc.dll                                         | 2022.160.4095.4 | 313280    | 30-Oct-2023 | 16:45 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4095.4 | 522280    | 30-Oct-2023 | 16:44 | x64      |
| Rawdest.dll                                          | 2022.160.4095.4 | 227280    | 30-Oct-2023 | 16:45 | x64      |
| Rawsource.dll                                        | 2022.160.4095.4 | 215080    | 30-Oct-2023 | 16:45 | x64      |
| Rdistcom.dll                                         | 2022.160.4095.4 | 940072    | 30-Oct-2023 | 16:44 | x64      |
| Recordsetdest.dll                                    | 2022.160.4095.4 | 206784    | 30-Oct-2023 | 16:45 | x64      |
| Repldp.dll                                           | 2022.160.4095.4 | 337856    | 30-Oct-2023 | 16:44 | x64      |
| Replerrx.dll                                         | 2022.160.4095.4 | 198592    | 30-Oct-2023 | 16:44 | x64      |
| Replisapi.dll                                        | 2022.160.4095.4 | 419880    | 30-Oct-2023 | 16:44 | x64      |
| Replmerg.exe                                         | 2022.160.4095.4 | 595920    | 30-Oct-2023 | 16:44 | x64      |
| Replprov.dll                                         | 2022.160.4095.4 | 890920    | 30-Oct-2023 | 16:44 | x64      |
| Replrec.dll                                          | 2022.160.4095.4 | 1058856   | 30-Oct-2023 | 16:44 | x64      |
| Replsub.dll                                          | 2022.160.4095.4 | 501800    | 30-Oct-2023 | 16:44 | x64      |
| Spresolv.dll                                         | 2022.160.4095.4 | 300992    | 30-Oct-2023 | 16:44 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |
| Sqlcmd.exe                                           | 2022.160.4095.4 | 276416    | 30-Oct-2023 | 16:45 | x64      |
| Sqldistx.dll                                         | 2022.160.4095.4 | 268240    | 30-Oct-2023 | 16:44 | x64      |
| Sqlmergx.dll                                         | 2022.160.4095.4 | 423976    | 30-Oct-2023 | 16:44 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4095.4 | 210880    | 30-Oct-2023 | 16:45 | x64      |
| Ssradd.dll                                           | 2022.160.4095.4 | 100288    | 30-Oct-2023 | 16:44 | x64      |
| Ssravg.dll                                           | 2022.160.4095.4 | 100288    | 30-Oct-2023 | 16:44 | x64      |
| Ssrmax.dll                                           | 2022.160.4095.4 | 100288    | 30-Oct-2023 | 16:44 | x64      |
| Ssrmin.dll                                           | 2022.160.4095.4 | 100288    | 30-Oct-2023 | 16:44 | x64      |
| Txagg.dll                                            | 2022.160.4095.4 | 395216    | 30-Oct-2023 | 16:45 | x64      |
| Txbdd.dll                                            | 2022.160.4095.4 | 190400    | 30-Oct-2023 | 16:45 | x64      |
| Txdatacollector.dll                                  | 2022.160.4095.4 | 468944    | 30-Oct-2023 | 16:45 | x64      |
| Txdataconvert.dll                                    | 2022.160.4095.4 | 333864    | 30-Oct-2023 | 16:45 | x64      |
| Txderived.dll                                        | 2022.160.4095.4 | 632872    | 30-Oct-2023 | 16:45 | x64      |
| Txlookup.dll                                         | 2022.160.4095.4 | 608296    | 30-Oct-2023 | 16:45 | x64      |
| Txmerge.dll                                          | 2022.160.4095.4 | 243648    | 30-Oct-2023 | 16:45 | x64      |
| Txmergejoin.dll                                      | 2022.160.4095.4 | 300992    | 30-Oct-2023 | 16:45 | x64      |
| Txmulticast.dll                                      | 2022.160.4095.4 | 145360    | 30-Oct-2023 | 16:45 | x64      |
| Txrowcount.dll                                       | 2022.160.4095.4 | 145360    | 30-Oct-2023 | 16:45 | x64      |
| Txsort.dll                                           | 2022.160.4095.4 | 276416    | 30-Oct-2023 | 16:45 | x64      |
| Txsplit.dll                                          | 2022.160.4095.4 | 620600    | 30-Oct-2023 | 16:45 | x64      |
| Txunionall.dll                                       | 2022.160.4095.4 | 194512    | 30-Oct-2023 | 16:45 | x64      |
| Xe.dll                                               | 2022.160.4095.4 | 718784    | 30-Oct-2023 | 16:45 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4095.4 | 100408    | 30-Oct-2023 | 16:44 | x64      |
| Exthost.exe                   | 2022.160.4095.4 | 247848    | 30-Oct-2023 | 16:44 | x64      |
| Launchpad.exe                 | 2022.160.4095.4 | 1447976   | 30-Oct-2023 | 16:44 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |
| Sqlsatellite.dll              | 2022.160.4095.4 | 1255480   | 30-Oct-2023 | 16:44 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4095.4 | 710592    | 30-Oct-2023 | 16:44 | x64      |
| Fdhost.exe               | 2022.160.4095.4 | 153536    | 30-Oct-2023 | 16:44 | x64      |
| Fdlauncher.exe           | 2022.160.4095.4 | 100304    | 30-Oct-2023 | 16:44 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:44 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 30-Oct-2023 | 16:57 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 30-Oct-2023 | 16:57 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 30-Oct-2023 | 16:57 | x86      |
| Commanddest.dll                                               | 2022.160.4095.4 | 231360    | 30-Oct-2023 | 16:57 | x86      |
| Commanddest.dll                                               | 2022.160.4095.4 | 272336    | 30-Oct-2023 | 16:57 | x64      |
| Dteparse.dll                                                  | 2022.160.4095.4 | 116672    | 30-Oct-2023 | 16:57 | x86      |
| Dteparse.dll                                                  | 2022.160.4095.4 | 133056    | 30-Oct-2023 | 16:57 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4095.4 | 178216    | 30-Oct-2023 | 16:57 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4095.4 | 165824    | 30-Oct-2023 | 16:57 | x86      |
| Dtepkg.dll                                                    | 2022.160.4095.4 | 153656    | 30-Oct-2023 | 16:57 | x64      |
| Dtepkg.dll                                                    | 2022.160.4095.4 | 128960    | 30-Oct-2023 | 16:57 | x86      |
| Dtexec.exe                                                    | 2022.160.4095.4 | 64976     | 30-Oct-2023 | 16:57 | x86      |
| Dtexec.exe                                                    | 2022.160.4095.4 | 76856     | 30-Oct-2023 | 16:57 | x64      |
| Dts.dll                                                       | 2022.160.4095.4 | 2861096   | 30-Oct-2023 | 16:57 | x86      |
| Dts.dll                                                       | 2022.160.4095.4 | 3266616   | 30-Oct-2023 | 16:57 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4095.4 | 444368    | 30-Oct-2023 | 16:57 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4095.4 | 493608    | 30-Oct-2023 | 16:57 | x64      |
| Dtsconn.dll                                                   | 2022.160.4095.4 | 464832    | 30-Oct-2023 | 16:57 | x86      |
| Dtsconn.dll                                                   | 2022.160.4095.4 | 550864    | 30-Oct-2023 | 16:57 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4095.4 | 114640    | 30-Oct-2023 | 16:57 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4095.4 | 94656     | 30-Oct-2023 | 16:57 | x86      |
| Dtshost.exe                                                   | 2022.160.4095.4 | 120256    | 30-Oct-2023 | 16:57 | x64      |
| Dtshost.exe                                                   | 2022.160.4095.4 | 98256     | 30-Oct-2023 | 16:57 | x86      |
| Dtspipeline.dll                                               | 2022.160.4095.4 | 1144768   | 30-Oct-2023 | 16:57 | x86      |
| Dtspipeline.dll                                               | 2022.160.4095.4 | 1337384   | 30-Oct-2023 | 16:57 | x64      |
| Dtuparse.dll                                                  | 2022.160.4095.4 | 104384    | 30-Oct-2023 | 16:57 | x64      |
| Dtuparse.dll                                                  | 2022.160.4095.4 | 88016     | 30-Oct-2023 | 16:57 | x86      |
| Dtutil.exe                                                    | 2022.160.4095.4 | 142272    | 30-Oct-2023 | 16:57 | x86      |
| Dtutil.exe                                                    | 2022.160.4095.4 | 166456    | 30-Oct-2023 | 16:57 | x64      |
| Exceldest.dll                                                 | 2022.160.4095.4 | 247744    | 30-Oct-2023 | 16:57 | x86      |
| Exceldest.dll                                                 | 2022.160.4095.4 | 284608    | 30-Oct-2023 | 16:57 | x64      |
| Excelsrc.dll                                                  | 2022.160.4095.4 | 264144    | 30-Oct-2023 | 16:57 | x86      |
| Excelsrc.dll                                                  | 2022.160.4095.4 | 305104    | 30-Oct-2023 | 16:57 | x64      |
| Execpackagetask.dll                                           | 2022.160.4095.4 | 149456    | 30-Oct-2023 | 16:57 | x86      |
| Execpackagetask.dll                                           | 2022.160.4095.4 | 182208    | 30-Oct-2023 | 16:57 | x64      |
| Flatfiledest.dll                                              | 2022.160.4095.4 | 374824    | 30-Oct-2023 | 16:57 | x86      |
| Flatfiledest.dll                                              | 2022.160.4095.4 | 423976    | 30-Oct-2023 | 16:57 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4095.4 | 391208    | 30-Oct-2023 | 16:57 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4095.4 | 440360    | 30-Oct-2023 | 16:57 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4095.4     | 120768    | 30-Oct-2023 | 16:57 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4095.4     | 120872    | 30-Oct-2023 | 16:57 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933816   | 30-Oct-2023 | 16:46 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933824   | 30-Oct-2023 | 16:46 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4095.4     | 509888    | 30-Oct-2023 | 16:57 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4095.4     | 391120    | 30-Oct-2023 | 16:57 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4095.4     | 219176    | 30-Oct-2023 | 16:57 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4095.4 | 100288    | 30-Oct-2023 | 16:57 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4095.4 | 124864    | 30-Oct-2023 | 16:57 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.222 | 10165808  | 30-Oct-2023 | 16:46 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 30-Oct-2023 | 16:57 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 30-Oct-2023 | 16:57 | x86      |
| Odbcdest.dll                                                  | 2022.160.4095.4 | 341968    | 30-Oct-2023 | 16:57 | x86      |
| Odbcdest.dll                                                  | 2022.160.4095.4 | 383016    | 30-Oct-2023 | 16:57 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4095.4 | 350144    | 30-Oct-2023 | 16:57 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4095.4 | 399400    | 30-Oct-2023 | 16:57 | x64      |
| Oledbdest.dll                                                 | 2022.160.4095.4 | 247848    | 30-Oct-2023 | 16:57 | x86      |
| Oledbdest.dll                                                 | 2022.160.4095.4 | 288704    | 30-Oct-2023 | 16:57 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4095.4 | 268224    | 30-Oct-2023 | 16:57 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4095.4 | 313280    | 30-Oct-2023 | 16:57 | x64      |
| Rawdest.dll                                                   | 2022.160.4095.4 | 190400    | 30-Oct-2023 | 16:57 | x86      |
| Rawdest.dll                                                   | 2022.160.4095.4 | 227280    | 30-Oct-2023 | 16:57 | x64      |
| Rawsource.dll                                                 | 2022.160.4095.4 | 186304    | 30-Oct-2023 | 16:57 | x86      |
| Rawsource.dll                                                 | 2022.160.4095.4 | 215080    | 30-Oct-2023 | 16:57 | x64      |
| Recordsetdest.dll                                             | 2022.160.4095.4 | 174016    | 30-Oct-2023 | 16:57 | x86      |
| Recordsetdest.dll                                             | 2022.160.4095.4 | 206784    | 30-Oct-2023 | 16:57 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4095.4 | 137152    | 30-Oct-2023 | 16:46 | x64      |
| Sqlceip.exe                                                   | 16.0.4095.4     | 301008    | 30-Oct-2023 | 16:57 | x86      |
| Sqldest.dll                                                   | 2022.160.4095.4 | 255952    | 30-Oct-2023 | 16:57 | x86      |
| Sqldest.dll                                                   | 2022.160.4095.4 | 288720    | 30-Oct-2023 | 16:57 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4095.4 | 174016    | 30-Oct-2023 | 16:57 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4095.4 | 210880    | 30-Oct-2023 | 16:57 | x64      |
| Txagg.dll                                                     | 2022.160.4095.4 | 346064    | 30-Oct-2023 | 16:57 | x86      |
| Txagg.dll                                                     | 2022.160.4095.4 | 395216    | 30-Oct-2023 | 16:57 | x64      |
| Txbdd.dll                                                     | 2022.160.4095.4 | 149448    | 30-Oct-2023 | 16:57 | x86      |
| Txbdd.dll                                                     | 2022.160.4095.4 | 190400    | 30-Oct-2023 | 16:57 | x64      |
| Txbestmatch.dll                                               | 2022.160.4095.4 | 567336    | 30-Oct-2023 | 16:57 | x86      |
| Txbestmatch.dll                                               | 2022.160.4095.4 | 661440    | 30-Oct-2023 | 16:57 | x64      |
| Txcache.dll                                                   | 2022.160.4095.4 | 169920    | 30-Oct-2023 | 16:57 | x86      |
| Txcache.dll                                                   | 2022.160.4095.4 | 202688    | 30-Oct-2023 | 16:57 | x64      |
| Txcharmap.dll                                                 | 2022.160.4095.4 | 280528    | 30-Oct-2023 | 16:57 | x86      |
| Txcharmap.dll                                                 | 2022.160.4095.4 | 325672    | 30-Oct-2023 | 16:57 | x64      |
| Txcopymap.dll                                                 | 2022.160.4095.4 | 202688    | 30-Oct-2023 | 16:57 | x64      |
| Txcopymap.dll                                                 | 2022.160.4095.4 | 165944    | 30-Oct-2023 | 16:57 | x86      |
| Txdataconvert.dll                                             | 2022.160.4095.4 | 288704    | 30-Oct-2023 | 16:57 | x86      |
| Txdataconvert.dll                                             | 2022.160.4095.4 | 333864    | 30-Oct-2023 | 16:57 | x64      |
| Txderived.dll                                                 | 2022.160.4095.4 | 559056    | 30-Oct-2023 | 16:57 | x86      |
| Txderived.dll                                                 | 2022.160.4095.4 | 632872    | 30-Oct-2023 | 16:57 | x64      |
| Txfileextractor.dll                                           | 2022.160.4095.4 | 186304    | 30-Oct-2023 | 16:57 | x86      |
| Txfileextractor.dll                                           | 2022.160.4095.4 | 219080    | 30-Oct-2023 | 16:57 | x64      |
| Txfileinserter.dll                                            | 2022.160.4095.4 | 186304    | 30-Oct-2023 | 16:57 | x86      |
| Txfileinserter.dll                                            | 2022.160.4095.4 | 219176    | 30-Oct-2023 | 16:57 | x64      |
| Txgroupdups.dll                                               | 2022.160.4095.4 | 354344    | 30-Oct-2023 | 16:57 | x86      |
| Txgroupdups.dll                                               | 2022.160.4095.4 | 403496    | 30-Oct-2023 | 16:57 | x64      |
| Txlineage.dll                                                 | 2022.160.4095.4 | 157648    | 30-Oct-2023 | 16:57 | x64      |
| Txlineage.dll                                                 | 2022.160.4095.4 | 128960    | 30-Oct-2023 | 16:57 | x86      |
| Txlookup.dll                                                  | 2022.160.4095.4 | 522296    | 30-Oct-2023 | 16:57 | x86      |
| Txlookup.dll                                                  | 2022.160.4095.4 | 608296    | 30-Oct-2023 | 16:57 | x64      |
| Txmerge.dll                                                   | 2022.160.4095.4 | 194496    | 30-Oct-2023 | 16:57 | x86      |
| Txmerge.dll                                                   | 2022.160.4095.4 | 243648    | 30-Oct-2023 | 16:57 | x64      |
| Txmergejoin.dll                                               | 2022.160.4095.4 | 255936    | 30-Oct-2023 | 16:57 | x86      |
| Txmergejoin.dll                                               | 2022.160.4095.4 | 300992    | 30-Oct-2023 | 16:57 | x64      |
| Txmulticast.dll                                               | 2022.160.4095.4 | 116672    | 30-Oct-2023 | 16:57 | x86      |
| Txmulticast.dll                                               | 2022.160.4095.4 | 145360    | 30-Oct-2023 | 16:57 | x64      |
| Txpivot.dll                                                   | 2022.160.4095.4 | 198592    | 30-Oct-2023 | 16:57 | x86      |
| Txpivot.dll                                                   | 2022.160.4095.4 | 239672    | 30-Oct-2023 | 16:57 | x64      |
| Txrowcount.dll                                                | 2022.160.4095.4 | 116672    | 30-Oct-2023 | 16:57 | x86      |
| Txrowcount.dll                                                | 2022.160.4095.4 | 145360    | 30-Oct-2023 | 16:57 | x64      |
| Txsampling.dll                                                | 2022.160.4095.4 | 153536    | 30-Oct-2023 | 16:57 | x86      |
| Txsampling.dll                                                | 2022.160.4095.4 | 186304    | 30-Oct-2023 | 16:57 | x64      |
| Txscd.dll                                                     | 2022.160.4095.4 | 198712    | 30-Oct-2023 | 16:57 | x86      |
| Txscd.dll                                                     | 2022.160.4095.4 | 235472    | 30-Oct-2023 | 16:57 | x64      |
| Txsort.dll                                                    | 2022.160.4095.4 | 231376    | 30-Oct-2023 | 16:57 | x86      |
| Txsort.dll                                                    | 2022.160.4095.4 | 276416    | 30-Oct-2023 | 16:57 | x64      |
| Txsplit.dll                                                   | 2022.160.4095.4 | 550864    | 30-Oct-2023 | 16:57 | x86      |
| Txsplit.dll                                                   | 2022.160.4095.4 | 620600    | 30-Oct-2023 | 16:57 | x64      |
| Txtermextraction.dll                                          | 2022.160.4095.4 | 8648640   | 30-Oct-2023 | 16:57 | x86      |
| Txtermextraction.dll                                          | 2022.160.4095.4 | 8701888   | 30-Oct-2023 | 16:57 | x64      |
| Txtermlookup.dll                                              | 2022.160.4095.4 | 4139064   | 30-Oct-2023 | 16:57 | x86      |
| Txtermlookup.dll                                              | 2022.160.4095.4 | 4184104   | 30-Oct-2023 | 16:57 | x64      |
| Txunionall.dll                                                | 2022.160.4095.4 | 153536    | 30-Oct-2023 | 16:57 | x86      |
| Txunionall.dll                                                | 2022.160.4095.4 | 194512    | 30-Oct-2023 | 16:57 | x64      |
| Txunpivot.dll                                                 | 2022.160.4095.4 | 178112    | 30-Oct-2023 | 16:57 | x86      |
| Txunpivot.dll                                                 | 2022.160.4095.4 | 214976    | 30-Oct-2023 | 16:57 | x64      |
| Xe.dll                                                        | 2022.160.4095.4 | 640976    | 30-Oct-2023 | 16:57 | x86      |
| Xe.dll                                                        | 2022.160.4095.4 | 718784    | 30-Oct-2023 | 16:57 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1029.0     | 559520    | 30-Oct-2023 | 17:46 | x86      |
| Dmsnative.dll                                                        | 2022.160.1029.0 | 152480    | 30-Oct-2023 | 17:46 | x64      |
| Dwengineservice.dll                                                  | 16.0.1029.0     | 44960     | 30-Oct-2023 | 17:46 | x86      |
| Instapi150.dll                                                       | 2022.160.4095.4 | 104488    | 30-Oct-2023 | 17:46 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1029.0     | 67536     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1029.0     | 293328    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1029.0     | 1958352   | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1029.0     | 169424    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1029.0     | 647120    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1029.0     | 246216    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1029.0     | 139216    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1029.0     | 79776     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1029.0     | 51104     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1029.0     | 88480     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1029.0     | 1129376   | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1029.0     | 80848     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1029.0     | 70560     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1029.0     | 35232     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1029.0     | 30624     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1029.0     | 46496     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1029.0     | 21456     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1029.0     | 26528     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1029.0     | 131536    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1029.0     | 86480     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1029.0     | 100768    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1029.0     | 293280    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 120272    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 138192    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 141216    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 137680    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 150480    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 139680    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 134608    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 176592    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 117704    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1029.0     | 136656    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1029.0     | 72656     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1029.0     | 21968     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1029.0     | 37280     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1029.0     | 128928    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1029.0     | 3064736   | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1029.0     | 3955616   | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 118176    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133024    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 137680    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 133584    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 148432    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 134048    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 130464    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 170912    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 115152    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1029.0     | 132000    | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1029.0     | 67488     | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1029.0     | 2682832   | 30-Oct-2023 | 17:46 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1029.0     | 2436512   | 30-Oct-2023 | 17:46 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4095.4 | 296896    | 30-Oct-2023 | 17:46 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4095.4 | 7796776   | 30-Oct-2023 | 17:46 | x64      |
| Secforwarder.dll                                                     | 2022.160.4095.4 | 83904     | 30-Oct-2023 | 17:46 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1029.0 | 61392     | 30-Oct-2023 | 17:46 | x64      |
| Sqldk.dll                                                            | 2022.160.4095.4 | 4007976   | 30-Oct-2023 | 17:46 | x64      |
| Sqldumper.exe                                                        | 2022.160.4095.4 | 436160    | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 1750992   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4577320   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 3754040   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4577320   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4479032   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 2447400   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 2390072   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4212776   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4196392   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 1689640   | 30-Oct-2023 | 17:46 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4095.4 | 4446248   | 30-Oct-2023 | 17:46 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 30-Oct-2023 | 17:46 | x64      |
| Sqlos.dll                                                            | 2022.160.4095.4 | 51152     | 30-Oct-2023 | 17:46 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1029.0 | 4841424   | 30-Oct-2023 | 17:46 | x64      |
| Sqltses.dll                                                          | 2022.160.4095.4 | 9386040   | 30-Oct-2023 | 17:46 | x64      |

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
