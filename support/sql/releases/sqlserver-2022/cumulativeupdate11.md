---
title: Cumulative update 11 for SQL Server 2022 (KB5032679)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 11 (KB5032679).
ms.date: 05/30/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5032679
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5032679 - Cumulative Update 11 for SQL Server 2022

_Release Date:_ &nbsp; January 11, 2024  
_Version:_ &nbsp; 16.0.4105.2

## Summary

This article describes Cumulative Update package 11 (CU11) for Microsoft SQL Server 2022. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 10, and it updates components in the following builds:

- SQL Server - Product version: **16.0.4105.2**, file version: **2022.160.4105.2**
- Analysis Services - Product version: **16.0.43.222**, file version: **2022.160.43.222**
## Known issues in this update

### Issue one: Read-scale availability group not displayed in dm_hadr_database_replica_cluster_states

SQL Server 2022 CU10 introduced [fix 2714261](cumulativeupdate10.md#2714261), which causes an issue with `sys.dm_hadr_database_replica_cluster_states` for read-scale availability groups that results in the **Availability Databases** folder in SQL Server Management Studio (SSMS) not showing the databases in the availability group (AG). To mitigate this issue, roll back the patch to CU9.

This issue is fixed in [SQL Server 2022 CU12](cumulativeupdate12.md#2923126).

### Issue two: Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area | Component | Platform |
|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------|-------------------------------------------|----------|
| <a id=2767578>[2767578](#2767578) </a> | Fixes an issue in which the **Find Parent** feature fails if the target of the feature is a node that is searched.| Master Data Services | Master Data Services| Windows|
| <a id=2773751>[2773751](#2773751) </a> | Fixes an issue in which downloading an attachment fails if an entity newly created uses a code value existing in a deletion record. | Master Data Services | Master Data Services| Windows|
| <a id=2807414>[2807414](#2807414) </a> | Fixes a dump issue and `INVALID_POINTER_WRITE_c0000005_sqllang.dll!CBatch::PTaskGetWithAddRef` exception that you might encounter when the reference on a connection object that's obtained by the session monitor isn't released under a failure condition, which can cause dangling session objects.| SQL Connectivity | SQL Connectivity| All|
| <a id=2702535>[2702535](#2702535) </a> | Fixes an access violation at `InitCollationSensitiveLookupHash` that you encounter when running a string column point search on an In-Memory OLTP columnstore table.| SQL Server Engine| Column Stores | Windows|
| <a id=2710571>[2710571](#2710571) </a> | Fixes an issue in which the creation of a contained availability group fails with a dump generated if a login has the **sysadmin** role and some other server-level roles that only exist in the SQL Server instance, which causes the SQL Server instance to stop responding.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=2766491>[2766491](#2766491) </a> | Fixes an access violation dump issue that you encounter when dropping a distributed availability group (AG) that has a suspect AG database on a forwarder.| SQL Server Engine| High Availability and Disaster Recovery | All|
| <a id=2765109>[2765109](#2765109) </a> | Fixes a performance issue in query execution time that you encounter after you run the `OPTIMIZE` operation for a delta table in S3-compatible object storage. After applying the fix, it also improves the performance of querying delta tables from Azure Blob Storage and Azure Data Lake Storage Gen2.| SQL Server Engine| PolyBase| All|
| <a id=2766490>[2766490](#2766490) </a> | Fixes an intra-query deadlock that you might encounter when running some query plans that involve nested loop joins in batch mode.| SQL Server Engine| Query Execution | All|
| <a id=2770546>[2770546](#2770546) </a> | Fixes an assertion failure (Location: IntSafeWrapperRetail.cpp:31; Expression: !"Arithmetic operation failed") that you encounter while using the `LIKE` predicate. | SQL Server Engine| Query Execution | All|
| <a id=2787964>[2787964](#2787964) </a> | Fixes an issue in which the Cardinality Estimation (CE) feedback generates an empty `USE HINT` clause as the query hint.| SQL Server Engine| Query Execution | All|
| <a id=1982808>[1982808](#1982808) </a> | Fixes an issue in which the distribution agent fails when you set up transactional replication with memory-optimized tables at the Subscriber that has the "replication support only" option. Additionally, you receive the following error message: </br></br>MSupd_articlename stored procedure fails with error 12302 when the subscription is created with @sync_type = "replication support only". | SQL Server Engine| Replication | Windows|
| <a id=2782283>[2782283](#2782283) </a> | Consider the following scenario: </br></br>- You create a table that has a full-text index. </br>- The full-text index fragment is partitioned because it's too large. </br>- You clone the database and then run `DBCC CHECKDB` to check the clone database. </br></br>In this scenario, the command fails and the following error 2601 occurs: </br></br>Msg 2601, Level 14, State 1, Line \<LineNumber> </br>Cannot insert duplicate key row in object '\<ObjectName>' with unique index '\<IndexName>'. The duplicate key value is \<KeyValue>. | SQL Server Engine| Search| All|
| <a id=2789527>[2789527](#2789527) </a> | Fixes the following error 9833 that you encounter when running the `sp_helplogins` stored procedure against a database with UTF-8 character encoding: </br></br>Msg 9833, Level 16, State 2, Procedure sp_helplogins, Line \<LineNumber> [Batch State Line 0] </br>Invalid data for UTF8-encoded characters| SQL Server Engine|Security Infrastructure| All|
| <a id=2744933>[2744933](#2744933) </a> | Fixes a non-yielding scheduler dump issue with `sqldk!SOS_Node::SpreadMultipleTasksAcrossNodes` that you encounter when running an instance on hardware that has more than 64 logical processors per NUMA node. After applying the fix, SQL Server detects machines that have more than 64 logical processors per NUMA node at startup and shuts the SQL Server service down. For more information, see the note in [Compute capacity limits by edition of SQL Server](/sql/sql-server/compute-capacity-limits-by-edition-of-sql-server).| SQL Server Engine| SQL OS| All|
| <a id=2782340>[2782340](#2782340) </a> | Fixes a "Stalled Resource Monitor" dump issue that you might encounter after out-of-memory (OOM) exceptions are raised, such as error 701.| SQL Server Engine| SQL OS| All|
| <a id=2724957>[2724957](#2724957) </a> | Fixes an issue in which the setup might fail to add the `SQL_SNAC_SDK` feature when you install SQL Server if the machine has a later version of the `SQL_SNAC_CORE` feature in *msoledbsql.msi* installed than that of the SQL Server installation media. After applying the fix, SQL Server Setup detects this condition, and it will block a new installation and prevent a failure during the installation. </br></br>**Note**: To work around this issue and unblock SQL Server Setup, go to **Uninstall or change a program** in the Control Panel, select **Microsoft OLE DB Driver for SQL Server**, and then select **Change** to install all features in **Microsoft OLE DB Driver for SQL Server Setup**. Rerun SQL Server Setup when it's finished. | SQL Setup| Deployment Platform | Windows|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center will always offer the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU11 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5032679)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5032679-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5032679-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5032679-x64.exe| A7C447E35606C4B64817CD1C4CB6FB18DAAECC13D5998C052E81BC2AC574CB5D |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                     File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Asplatformhost.dll                                  | 2022.160.43.222 | 336944    | 14-Nov-2023 | 19:01 | x64      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.222     | 2903608   | 14-Nov-2023 | 19:01 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.108.3243.0    | 24480     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.data.sqlclient.dll                        | 1.14.21068.1    | 1920960   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identity.client.dll                       | 4.14.0.0        | 1350048   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 5.6.0.61018     | 65952     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.logging.dll                 | 5.6.0.61018     | 26528     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.protocols.dll               | 5.6.0.61018     | 32192     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 5.6.0.61018     | 103328    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 5.6.0.61018     | 162720    | 14-Nov-2023 | 19:03 | x86      |
| Msmdctr.dll                                         | 2022.160.43.222 | 38960     | 14-Nov-2023 | 19:01 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 53974984  | 14-Nov-2023 | 19:01 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.222 | 71833648  | 14-Nov-2023 | 19:01 | x64      |
| Msmdpump.dll                                        | 2022.160.43.222 | 10335296  | 14-Nov-2023 | 19:01 | x64      |
| Msmdredir.dll                                       | 2022.160.43.222 | 8132032   | 14-Nov-2023 | 19:01 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.222 | 71384624  | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 956976    | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1884736   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1671728   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1881136   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1848256   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1147440   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1140288   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1769408   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1748936   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 932800    | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.222 | 1837616   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 955440    | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1882560   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1668656   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1876528   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1844800   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1145288   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1138736   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1765424   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1745472   | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 933424    | 14-Nov-2023 | 19:01 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.222 | 1833008   | 14-Nov-2023 | 19:01 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 10083888  | 14-Nov-2023 | 19:01 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.222 | 8265680   | 14-Nov-2023 | 19:01 | x86      |
| Msolap.dll                                          | 2022.160.43.222 | 10970568  | 14-Nov-2023 | 19:01 | x64      |
| Msolap.dll                                          | 2022.160.43.222 | 8745008   | 14-Nov-2023 | 19:01 | x86      |
| Msolui.dll                                          | 2022.160.43.222 | 289736    | 14-Nov-2023 | 19:01 | x86      |
| Msolui.dll                                          | 2022.160.43.222 | 308272    | 14-Nov-2023 | 19:01 | x64      |
| Newtonsoft.json.dll                                 | 13.0.1.25517    | 704448    | 14-Nov-2023 | 19:03 | x86      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 14-Nov-2023 | 19:03 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:00 | x64      |
| Sqlceip.exe                                         | 16.0.4105.2     | 300992    | 14-Nov-2023 | 19:03 | x86      |
| Sqldumper.exe                                       | 2022.160.4105.2 | 370728    | 14-Nov-2023 | 19:03 | x86      |
| Sqldumper.exe                                       | 2022.160.4105.2 | 436280    | 14-Nov-2023 | 19:03 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 5.6.0.61018     | 83872     | 14-Nov-2023 | 19:03 | x86      |
| Tmapi.dll                                           | 2022.160.43.222 | 5884480   | 14-Nov-2023 | 19:01 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.222 | 5575104   | 14-Nov-2023 | 19:01 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.222 | 1481264   | 14-Nov-2023 | 19:01 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.222 | 7198256   | 14-Nov-2023 | 19:01 | x64      |
| Xmsrv.dll                                           | 2022.160.43.222 | 26593856  | 14-Nov-2023 | 19:01 | x64      |
| Xmsrv.dll                                           | 2022.160.43.222 | 35896256  | 14-Nov-2023 | 19:01 | x86      |

SQL Server 2022 Database Services Common Core

|                 File   name                |   File version  | File size |    Date   |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4105.2 | 104488    | 14-Nov-2023 | 19:03 | x64      |
| Instapi150.dll                             | 2022.160.4105.2 | 79912     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.222     | 2633776   | 14-Nov-2023 | 19:00 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.222     | 2633776   | 14-Nov-2023 | 19:00 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.222     | 2933296   | 14-Nov-2023 | 19:00 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323504   | 14-Nov-2023 | 19:00 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.222     | 2323512   | 14-Nov-2023 | 19:00 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4105.2 | 104392    | 14-Nov-2023 | 19:03 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4105.2 | 92112     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4105.2     | 554952    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4105.2     | 555048    | 14-Nov-2023 | 19:03 | x86      |
| Msasxpress.dll                             | 2022.160.43.222 | 27696     | 14-Nov-2023 | 19:00 | x86      |
| Msasxpress.dll                             | 2022.160.43.222 | 32720     | 14-Nov-2023 | 19:00 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:00 | x64      |
| Sqldumper.exe                              | 2022.160.4105.2 | 370728    | 14-Nov-2023 | 19:03 | x86      |
| Sqldumper.exe                              | 2022.160.4105.2 | 436280    | 14-Nov-2023 | 19:03 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4105.2 | 395304    | 14-Nov-2023 | 19:03 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4105.2 | 456640    | 14-Nov-2023 | 19:03 | x64      |

SQL Server 2022 Data Quality Client

|            File   name           |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4105.2     | 309200    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4105.2     | 2070568   | 14-Nov-2023 | 19:03 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:03 | x64      |

SQL Server 2022 Data Quality

|         File name         | File version | File size |     Date    |  Time | Platform |
|:-------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.core.dll  | 16.0.4105.2  | 600008    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.core.dll  | 16.0.4105.2  | 600120    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.dll       | 16.0.4105.2  | 174120    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4105.2  | 1857576   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.infra.dll | 16.0.4105.2  | 1857592   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4105.2  | 370624    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.ssdqs.proxy.dll | 16.0.4105.2  | 370744    | 14-Nov-2023 | 19:03 | x86      |

SQL Server 2022 Database Services Core Instance

|                  File   name                 |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 14-Nov-2023 | 20:12 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 14-Nov-2023 | 20:12 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4105.2 | 4719144   | 14-Nov-2023 | 19:48 | x64      |
| Aetm-enclave.dll                             | 2022.160.4105.2 | 4673600   | 14-Nov-2023 | 19:48 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4105.2 | 4909128   | 14-Nov-2023 | 19:48 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4105.2 | 4874616   | 14-Nov-2023 | 19:48 | x64      |
| Dcexec.exe                                   | 2022.160.4105.2 | 96312     | 14-Nov-2023 | 20:12 | x64      |
| Fssres.dll                                   | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 20:12 | x64      |
| Hadrres.dll                                  | 2022.160.4105.2 | 227264    | 14-Nov-2023 | 20:12 | x64      |
| Hkcompile.dll                                | 2022.160.4105.2 | 1411024   | 14-Nov-2023 | 20:12 | x64      |
| Hkengine.dll                                 | 2022.160.4105.2 | 5769256   | 14-Nov-2023 | 20:12 | x64      |
| Hkruntime.dll                                | 2022.160.4105.2 | 190520    | 14-Nov-2023 | 20:12 | x64      |
| Hktempdb.dll                                 | 2022.160.4105.2 | 71616     | 14-Nov-2023 | 20:12 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.222     | 2322368   | 14-Nov-2023 | 20:12 | x86      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4105.2 | 333864    | 14-Nov-2023 | 20:12 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4105.2 | 96192     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 30760     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 38952     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 34872     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 38968     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 38968     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 30760     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 30760     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 34872     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 38848     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 30760     | 14-Nov-2023 | 20:12 | x64      |
| Odsole70.rll                                 | 16.0.4105.2     | 38968     | 14-Nov-2023 | 20:12 | x64      |
| Qds.dll                                      | 2022.160.4105.2 | 1800232   | 14-Nov-2023 | 20:12 | x64      |
| Rsfxft.dll                                   | 2022.160.4105.2 | 55336     | 14-Nov-2023 | 20:12 | x64      |
| Secforwarder.dll                             | 2022.160.4105.2 | 84008     | 14-Nov-2023 | 20:12 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 20:12 | x64      |
| Sqlaccess.dll                                | 2022.160.4105.2 | 444352    | 14-Nov-2023 | 20:12 | x64      |
| Sqlagent.exe                                 | 2022.160.4105.2 | 714688    | 14-Nov-2023 | 20:12 | x64      |
| Sqlceip.exe                                  | 16.0.4105.2     | 300992    | 14-Nov-2023 | 20:12 | x86      |
| Sqlctr160.dll                                | 2022.160.4105.2 | 129064    | 14-Nov-2023 | 20:12 | x86      |
| Sqlctr160.dll                                | 2022.160.4105.2 | 157648    | 14-Nov-2023 | 20:12 | x64      |
| Sqldk.dll                                    | 2022.160.4105.2 | 4011968   | 14-Nov-2023 | 20:12 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 1755176   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3852240   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4069416   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4581416   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4712504   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3754024   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3942440   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4581416   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4409384   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4483008   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 2447416   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 2390072   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4266024   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3901496   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4417592   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4212776   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4196392   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3979304   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 3856320   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 1689656   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4302888   | 14-Nov-2023 | 19:48 | x64      |
| Sqlevn70.rll                                 | 2022.160.4105.2 | 4446248   | 14-Nov-2023 | 19:48 | x64      |
| Sqliosim.com                                 | 2022.160.4105.2 | 387008    | 14-Nov-2023 | 20:12 | x64      |
| Sqliosim.exe                                 | 2022.160.4105.2 | 3057704   | 14-Nov-2023 | 20:12 | x64      |
| Sqllang.dll                                  | 2022.160.4105.2 | 48699328  | 14-Nov-2023 | 20:12 | x64      |
| Sqlmin.dll                                   | 2022.160.4105.2 | 51193912  | 14-Nov-2023 | 20:12 | x64      |
| Sqlos.dll                                    | 2022.160.4105.2 | 51144     | 14-Nov-2023 | 20:12 | x64      |
| Sqlrepss.dll                                 | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 20:12 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4105.2 | 51240     | 14-Nov-2023 | 20:12 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4105.2 | 5830696   | 14-Nov-2023 | 20:12 | x64      |
| Sqlservr.exe                                 | 2022.160.4105.2 | 882624    | 14-Nov-2023 | 20:12 | x64      |
| Sqltses.dll                                  | 2022.160.4105.2 | 9386040   | 14-Nov-2023 | 20:12 | x64      |
| Sqsrvres.dll                                 | 2022.160.4105.2 | 305104    | 14-Nov-2023 | 20:12 | x64      |
| Svl.dll                                      | 2022.160.4105.2 | 247848    | 14-Nov-2023 | 20:12 | x64      |
| Xe.dll                                       | 2022.160.4105.2 | 718904    | 14-Nov-2023 | 20:12 | x64      |
| Xpqueue.dll                                  | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 20:12 | x64      |
| Xpstar.dll                                   | 2022.160.4105.2 | 534584    | 14-Nov-2023 | 20:12 | x64      |

SQL Server 2022 Database Services Core Shared

|                      File   name                     |   File version  | File size |    Date   |  Time | Platform |
|:----------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commanddest.dll                                      | 2022.160.4105.2 | 272336    | 14-Nov-2023 | 19:03 | x64      |
| Datacollectortasks.dll                               | 2022.160.4105.2 | 227272    | 14-Nov-2023 | 19:04 | x64      |
| Distrib.exe                                          | 2022.160.4105.2 | 260032    | 14-Nov-2023 | 19:03 | x64      |
| Dteparse.dll                                         | 2022.160.4105.2 | 133056    | 14-Nov-2023 | 19:03 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4105.2 | 178232    | 14-Nov-2023 | 19:03 | x64      |
| Dtepkg.dll                                           | 2022.160.4105.2 | 153552    | 14-Nov-2023 | 19:03 | x64      |
| Dtexec.exe                                           | 2022.160.4105.2 | 76736     | 14-Nov-2023 | 19:03 | x64      |
| Dts.dll                                              | 2022.160.4105.2 | 3266512   | 14-Nov-2023 | 19:04 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4105.2 | 493608    | 14-Nov-2023 | 19:03 | x64      |
| Dtsconn.dll                                          | 2022.160.4105.2 | 550848    | 14-Nov-2023 | 19:04 | x64      |
| Dtshost.exe                                          | 2022.160.4105.2 | 120256    | 14-Nov-2023 | 19:03 | x64      |
| Dtspipeline.dll                                      | 2022.160.4105.2 | 1337280   | 14-Nov-2023 | 19:03 | x64      |
| Dtuparse.dll                                         | 2022.160.4105.2 | 104488    | 14-Nov-2023 | 19:03 | x64      |
| Dtutil.exe                                           | 2022.160.4105.2 | 166336    | 14-Nov-2023 | 19:03 | x64      |
| Exceldest.dll                                        | 2022.160.4105.2 | 284624    | 14-Nov-2023 | 19:03 | x64      |
| Excelsrc.dll                                         | 2022.160.4105.2 | 305088    | 14-Nov-2023 | 19:03 | x64      |
| Execpackagetask.dll                                  | 2022.160.4105.2 | 182312    | 14-Nov-2023 | 19:03 | x64      |
| Flatfiledest.dll                                     | 2022.160.4105.2 | 423992    | 14-Nov-2023 | 19:03 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4105.2 | 440360    | 14-Nov-2023 | 19:03 | x64      |
| Logread.exe                                          | 2022.160.4105.2 | 788432    | 14-Nov-2023 | 19:03 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.222     | 2933816   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.data.sqlclient.dll                         | 3.15.23292.1    | 2047112   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 3.0.1.0         | 470928    | 14-Nov-2023 | 19:03 | x64      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4105.2     | 30760     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identity.client.dll                        | 4.36.1.0        | 1503672   | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 5.5.0.60624     | 66096     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.logging.dll                  | 5.5.0.60624     | 32296     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.protocols.dll                | 5.5.0.60624     | 37416     | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 5.5.0.60624     | 109096    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 5.5.0.60624     | 167672    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4105.2     | 391224    | 14-Nov-2023 | 19:03 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4105.2 | 1705920   | 14-Nov-2023 | 19:03 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4105.2     | 555048    | 14-Nov-2023 | 19:03 | x86      |
| Msdtssrvrutil.dll                                    | 2022.160.4105.2 | 124984    | 14-Nov-2023 | 19:03 | x64      |
| Msgprox.dll                                          | 2022.160.4105.2 | 313280    | 14-Nov-2023 | 19:03 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 2729960   | 14-Nov-2023 | 19:04 | x64      |
| Msoledbsql.dll                                       | 2018.186.7.0    | 153560    | 14-Nov-2023 | 19:03 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517    | 704408    | 14-Nov-2023 | 19:04 | x86      |
| Oledbdest.dll                                        | 2022.160.4105.2 | 288704    | 14-Nov-2023 | 19:03 | x64      |
| Oledbsrc.dll                                         | 2022.160.4105.2 | 313384    | 14-Nov-2023 | 19:03 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4105.2 | 522280    | 14-Nov-2023 | 19:03 | x64      |
| Rawdest.dll                                          | 2022.160.4105.2 | 227368    | 14-Nov-2023 | 19:03 | x64      |
| Rawsource.dll                                        | 2022.160.4105.2 | 214992    | 14-Nov-2023 | 19:03 | x64      |
| Rdistcom.dll                                         | 2022.160.4105.2 | 940072    | 14-Nov-2023 | 19:03 | x64      |
| Recordsetdest.dll                                    | 2022.160.4105.2 | 206888    | 14-Nov-2023 | 19:03 | x64      |
| Repldp.dll                                           | 2022.160.4105.2 | 337856    | 14-Nov-2023 | 19:03 | x64      |
| Replerrx.dll                                         | 2022.160.4105.2 | 198600    | 14-Nov-2023 | 19:03 | x64      |
| Replisapi.dll                                        | 2022.160.4105.2 | 419776    | 14-Nov-2023 | 19:03 | x64      |
| Replmerg.exe                                         | 2022.160.4105.2 | 596008    | 14-Nov-2023 | 19:03 | x64      |
| Replprov.dll                                         | 2022.160.4105.2 | 890936    | 14-Nov-2023 | 19:03 | x64      |
| Replrec.dll                                          | 2022.160.4105.2 | 1058856   | 14-Nov-2023 | 19:03 | x64      |
| Replsub.dll                                          | 2022.160.4105.2 | 501696    | 14-Nov-2023 | 19:03 | x64      |
| Spresolv.dll                                         | 2022.160.4105.2 | 300992    | 14-Nov-2023 | 19:03 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:03 | x64      |
| Sqlcmd.exe                                           | 2022.160.4105.2 | 276416    | 14-Nov-2023 | 19:03 | x64      |
| Sqldistx.dll                                         | 2022.160.4105.2 | 268224    | 14-Nov-2023 | 19:03 | x64      |
| Sqlmergx.dll                                         | 2022.160.4105.2 | 423976    | 14-Nov-2023 | 19:03 | x64      |
| Sqltaskconnections.dll                               | 2022.160.4105.2 | 210880    | 14-Nov-2023 | 19:04 | x64      |
| Ssradd.dll                                           | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 19:03 | x64      |
| Ssravg.dll                                           | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 19:04 | x64      |
| Ssrmax.dll                                           | 2022.160.4105.2 | 100304    | 14-Nov-2023 | 19:03 | x64      |
| Ssrmin.dll                                           | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 19:03 | x64      |
| Txagg.dll                                            | 2022.160.4105.2 | 395304    | 14-Nov-2023 | 19:03 | x64      |
| Txbdd.dll                                            | 2022.160.4105.2 | 190504    | 14-Nov-2023 | 19:04 | x64      |
| Txdatacollector.dll                                  | 2022.160.4105.2 | 468928    | 14-Nov-2023 | 19:04 | x64      |
| Txdataconvert.dll                                    | 2022.160.4105.2 | 333864    | 14-Nov-2023 | 19:04 | x64      |
| Txderived.dll                                        | 2022.160.4105.2 | 632872    | 14-Nov-2023 | 19:03 | x64      |
| Txlookup.dll                                         | 2022.160.4105.2 | 608312    | 14-Nov-2023 | 19:03 | x64      |
| Txmerge.dll                                          | 2022.160.4105.2 | 243752    | 14-Nov-2023 | 19:03 | x64      |
| Txmergejoin.dll                                      | 2022.160.4105.2 | 301008    | 14-Nov-2023 | 19:03 | x64      |
| Txmulticast.dll                                      | 2022.160.4105.2 | 145464    | 14-Nov-2023 | 19:03 | x64      |
| Txrowcount.dll                                       | 2022.160.4105.2 | 145352    | 14-Nov-2023 | 19:03 | x64      |
| Txsort.dll                                           | 2022.160.4105.2 | 276432    | 14-Nov-2023 | 19:03 | x64      |
| Txsplit.dll                                          | 2022.160.4105.2 | 620584    | 14-Nov-2023 | 19:03 | x64      |
| Txunionall.dll                                       | 2022.160.4105.2 | 194512    | 14-Nov-2023 | 19:03 | x64      |
| Xe.dll                                               | 2022.160.4105.2 | 718904    | 14-Nov-2023 | 19:04 | x64      |

SQL Server 2022 sql_extensibility

|          File   name          |   File version  | File size |    Date   |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4105.2 | 100392    | 14-Nov-2023 | 19:03 | x64      |
| Exthost.exe                   | 2022.160.4105.2 | 247864    | 14-Nov-2023 | 19:03 | x64      |
| Launchpad.exe                 | 2022.160.4105.2 | 1447872   | 14-Nov-2023 | 19:03 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:00 | x64      |
| Sqlsatellite.dll              | 2022.160.4105.2 | 1255480   | 14-Nov-2023 | 19:03 | x64      |

SQL Server 2022 Full-Text Engine

|        File   name       |   File version  | File size |    Date   |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4105.2 | 710592    | 14-Nov-2023 | 19:03 | x64      |
| Fdhost.exe               | 2022.160.4105.2 | 153640    | 14-Nov-2023 | 19:03 | x64      |
| Fdlauncher.exe           | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 19:03 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:00 | x64      |

SQL Server 2022 Integration Services

|                          File   name                          |   File version  | File size |    Date   |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 14-Nov-2023 | 19:09 | x86      |
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 14-Nov-2023 | 19:10 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 14-Nov-2023 | 19:09 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 14-Nov-2023 | 19:10 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 14-Nov-2023 | 19:09 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 14-Nov-2023 | 19:10 | x86      |
| Commanddest.dll                                               | 2022.160.4105.2 | 231464    | 14-Nov-2023 | 19:09 | x86      |
| Commanddest.dll                                               | 2022.160.4105.2 | 272336    | 14-Nov-2023 | 19:09 | x64      |
| Dteparse.dll                                                  | 2022.160.4105.2 | 116672    | 14-Nov-2023 | 19:09 | x86      |
| Dteparse.dll                                                  | 2022.160.4105.2 | 133056    | 14-Nov-2023 | 19:09 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4105.2 | 165928    | 14-Nov-2023 | 19:09 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4105.2 | 178232    | 14-Nov-2023 | 19:09 | x64      |
| Dtepkg.dll                                                    | 2022.160.4105.2 | 129064    | 14-Nov-2023 | 19:09 | x86      |
| Dtepkg.dll                                                    | 2022.160.4105.2 | 153552    | 14-Nov-2023 | 19:09 | x64      |
| Dtexec.exe                                                    | 2022.160.4105.2 | 64960     | 14-Nov-2023 | 19:09 | x86      |
| Dtexec.exe                                                    | 2022.160.4105.2 | 76736     | 14-Nov-2023 | 19:09 | x64      |
| Dts.dll                                                       | 2022.160.4105.2 | 2861096   | 14-Nov-2023 | 19:09 | x86      |
| Dts.dll                                                       | 2022.160.4105.2 | 3266512   | 14-Nov-2023 | 19:10 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4105.2 | 444368    | 14-Nov-2023 | 19:09 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4105.2 | 493608    | 14-Nov-2023 | 19:09 | x64      |
| Dtsconn.dll                                                   | 2022.160.4105.2 | 464952    | 14-Nov-2023 | 19:09 | x86      |
| Dtsconn.dll                                                   | 2022.160.4105.2 | 550848    | 14-Nov-2023 | 19:10 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4105.2 | 114624    | 14-Nov-2023 | 19:09 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4105.2 | 94760     | 14-Nov-2023 | 19:09 | x86      |
| Dtshost.exe                                                   | 2022.160.4105.2 | 98256     | 14-Nov-2023 | 19:09 | x86      |
| Dtshost.exe                                                   | 2022.160.4105.2 | 120256    | 14-Nov-2023 | 19:09 | x64      |
| Dtspipeline.dll                                               | 2022.160.4105.2 | 1144768   | 14-Nov-2023 | 19:09 | x86      |
| Dtspipeline.dll                                               | 2022.160.4105.2 | 1337280   | 14-Nov-2023 | 19:10 | x64      |
| Dtuparse.dll                                                  | 2022.160.4105.2 | 88016     | 14-Nov-2023 | 19:09 | x86      |
| Dtuparse.dll                                                  | 2022.160.4105.2 | 104488    | 14-Nov-2023 | 19:09 | x64      |
| Dtutil.exe                                                    | 2022.160.4105.2 | 142392    | 14-Nov-2023 | 19:09 | x86      |
| Dtutil.exe                                                    | 2022.160.4105.2 | 166336    | 14-Nov-2023 | 19:09 | x64      |
| Exceldest.dll                                                 | 2022.160.4105.2 | 247848    | 14-Nov-2023 | 19:09 | x86      |
| Exceldest.dll                                                 | 2022.160.4105.2 | 284624    | 14-Nov-2023 | 19:09 | x64      |
| Excelsrc.dll                                                  | 2022.160.4105.2 | 264232    | 14-Nov-2023 | 19:09 | x86      |
| Excelsrc.dll                                                  | 2022.160.4105.2 | 305088    | 14-Nov-2023 | 19:09 | x64      |
| Execpackagetask.dll                                           | 2022.160.4105.2 | 149544    | 14-Nov-2023 | 19:09 | x86      |
| Execpackagetask.dll                                           | 2022.160.4105.2 | 182312    | 14-Nov-2023 | 19:09 | x64      |
| Flatfiledest.dll                                              | 2022.160.4105.2 | 374720    | 14-Nov-2023 | 19:09 | x86      |
| Flatfiledest.dll                                              | 2022.160.4105.2 | 423992    | 14-Nov-2023 | 19:09 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4105.2 | 391104    | 14-Nov-2023 | 19:09 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4105.2 | 440360    | 14-Nov-2023 | 19:09 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4105.2     | 120776    | 14-Nov-2023 | 19:09 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4105.2     | 120872    | 14-Nov-2023 | 19:09 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933816   | 14-Nov-2023 | 19:01 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.222     | 2933824   | 14-Nov-2023 | 19:01 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4105.2     | 509888    | 14-Nov-2023 | 19:09 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4105.2     | 510008    | 14-Nov-2023 | 19:09 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4105.2     | 391224    | 14-Nov-2023 | 19:09 | x86      |
| Msdtssrvr.exe                                                 | 16.0.4105.2     | 219176    | 14-Nov-2023 | 19:09 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4105.2 | 100288    | 14-Nov-2023 | 19:09 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4105.2 | 124984    | 14-Nov-2023 | 19:09 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.222 | 10165808  | 14-Nov-2023 | 19:01 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 14-Nov-2023 | 19:09 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 14-Nov-2023 | 19:09 | x86      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 14-Nov-2023 | 19:10 | x86      |
| Odbcdest.dll                                                  | 2022.160.4105.2 | 342056    | 14-Nov-2023 | 19:09 | x86      |
| Odbcdest.dll                                                  | 2022.160.4105.2 | 383016    | 14-Nov-2023 | 19:09 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4105.2 | 350248    | 14-Nov-2023 | 19:09 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4105.2 | 399400    | 14-Nov-2023 | 19:09 | x64      |
| Oledbdest.dll                                                 | 2022.160.4105.2 | 247848    | 14-Nov-2023 | 19:09 | x86      |
| Oledbdest.dll                                                 | 2022.160.4105.2 | 288704    | 14-Nov-2023 | 19:09 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4105.2 | 268328    | 14-Nov-2023 | 19:09 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4105.2 | 313384    | 14-Nov-2023 | 19:09 | x64      |
| Rawdest.dll                                                   | 2022.160.4105.2 | 190520    | 14-Nov-2023 | 19:09 | x86      |
| Rawdest.dll                                                   | 2022.160.4105.2 | 227368    | 14-Nov-2023 | 19:09 | x64      |
| Rawsource.dll                                                 | 2022.160.4105.2 | 186424    | 14-Nov-2023 | 19:09 | x86      |
| Rawsource.dll                                                 | 2022.160.4105.2 | 214992    | 14-Nov-2023 | 19:09 | x64      |
| Recordsetdest.dll                                             | 2022.160.4105.2 | 174120    | 14-Nov-2023 | 19:09 | x86      |
| Recordsetdest.dll                                             | 2022.160.4105.2 | 206888    | 14-Nov-2023 | 19:09 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4105.2 | 137152    | 14-Nov-2023 | 19:01 | x64      |
| Sqlceip.exe                                                   | 16.0.4105.2     | 300992    | 14-Nov-2023 | 19:10 | x86      |
| Sqldest.dll                                                   | 2022.160.4105.2 | 256040    | 14-Nov-2023 | 19:09 | x86      |
| Sqldest.dll                                                   | 2022.160.4105.2 | 288704    | 14-Nov-2023 | 19:10 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4105.2 | 174032    | 14-Nov-2023 | 19:09 | x86      |
| Sqltaskconnections.dll                                        | 2022.160.4105.2 | 210880    | 14-Nov-2023 | 19:10 | x64      |
| Txagg.dll                                                     | 2022.160.4105.2 | 346152    | 14-Nov-2023 | 19:09 | x86      |
| Txagg.dll                                                     | 2022.160.4105.2 | 395304    | 14-Nov-2023 | 19:10 | x64      |
| Txbdd.dll                                                     | 2022.160.4105.2 | 149560    | 14-Nov-2023 | 19:09 | x86      |
| Txbdd.dll                                                     | 2022.160.4105.2 | 190504    | 14-Nov-2023 | 19:10 | x64      |
| Txbestmatch.dll                                               | 2022.160.4105.2 | 567336    | 14-Nov-2023 | 19:09 | x86      |
| Txbestmatch.dll                                               | 2022.160.4105.2 | 661440    | 14-Nov-2023 | 19:10 | x64      |
| Txcache.dll                                                   | 2022.160.4105.2 | 169920    | 14-Nov-2023 | 19:09 | x86      |
| Txcache.dll                                                   | 2022.160.4105.2 | 202688    | 14-Nov-2023 | 19:10 | x64      |
| Txcharmap.dll                                                 | 2022.160.4105.2 | 280512    | 14-Nov-2023 | 19:09 | x86      |
| Txcharmap.dll                                                 | 2022.160.4105.2 | 325672    | 14-Nov-2023 | 19:10 | x64      |
| Txcopymap.dll                                                 | 2022.160.4105.2 | 165824    | 14-Nov-2023 | 19:09 | x86      |
| Txcopymap.dll                                                 | 2022.160.4105.2 | 202688    | 14-Nov-2023 | 19:10 | x64      |
| Txdataconvert.dll                                             | 2022.160.4105.2 | 288824    | 14-Nov-2023 | 19:09 | x86      |
| Txdataconvert.dll                                             | 2022.160.4105.2 | 333864    | 14-Nov-2023 | 19:10 | x64      |
| Txderived.dll                                                 | 2022.160.4105.2 | 559144    | 14-Nov-2023 | 19:09 | x86      |
| Txderived.dll                                                 | 2022.160.4105.2 | 632872    | 14-Nov-2023 | 19:10 | x64      |
| Txfileextractor.dll                                           | 2022.160.4105.2 | 186408    | 14-Nov-2023 | 19:09 | x86      |
| Txfileextractor.dll                                           | 2022.160.4105.2 | 219176    | 14-Nov-2023 | 19:10 | x64      |
| Txfileinserter.dll                                            | 2022.160.4105.2 | 186424    | 14-Nov-2023 | 19:09 | x86      |
| Txfileinserter.dll                                            | 2022.160.4105.2 | 219176    | 14-Nov-2023 | 19:10 | x64      |
| Txgroupdups.dll                                               | 2022.160.4105.2 | 354344    | 14-Nov-2023 | 19:09 | x86      |
| Txgroupdups.dll                                               | 2022.160.4105.2 | 403496    | 14-Nov-2023 | 19:10 | x64      |
| Txlineage.dll                                                 | 2022.160.4105.2 | 128960    | 14-Nov-2023 | 19:09 | x86      |
| Txlineage.dll                                                 | 2022.160.4105.2 | 157632    | 14-Nov-2023 | 19:10 | x64      |
| Txlookup.dll                                                  | 2022.160.4105.2 | 522296    | 14-Nov-2023 | 19:09 | x86      |
| Txlookup.dll                                                  | 2022.160.4105.2 | 608312    | 14-Nov-2023 | 19:10 | x64      |
| Txmerge.dll                                                   | 2022.160.4105.2 | 194600    | 14-Nov-2023 | 19:09 | x86      |
| Txmerge.dll                                                   | 2022.160.4105.2 | 243752    | 14-Nov-2023 | 19:10 | x64      |
| Txmergejoin.dll                                               | 2022.160.4105.2 | 256040    | 14-Nov-2023 | 19:09 | x86      |
| Txmergejoin.dll                                               | 2022.160.4105.2 | 301008    | 14-Nov-2023 | 19:10 | x64      |
| Txmulticast.dll                                               | 2022.160.4105.2 | 116680    | 14-Nov-2023 | 19:09 | x86      |
| Txmulticast.dll                                               | 2022.160.4105.2 | 145464    | 14-Nov-2023 | 19:10 | x64      |
| Txpivot.dll                                                   | 2022.160.4105.2 | 198696    | 14-Nov-2023 | 19:09 | x86      |
| Txpivot.dll                                                   | 2022.160.4105.2 | 239656    | 14-Nov-2023 | 19:10 | x64      |
| Txrowcount.dll                                                | 2022.160.4105.2 | 116672    | 14-Nov-2023 | 19:09 | x86      |
| Txrowcount.dll                                                | 2022.160.4105.2 | 145352    | 14-Nov-2023 | 19:10 | x64      |
| Txsampling.dll                                                | 2022.160.4105.2 | 153536    | 14-Nov-2023 | 19:09 | x86      |
| Txsampling.dll                                                | 2022.160.4105.2 | 186408    | 14-Nov-2023 | 19:10 | x64      |
| Txscd.dll                                                     | 2022.160.4105.2 | 198696    | 14-Nov-2023 | 19:09 | x86      |
| Txscd.dll                                                     | 2022.160.4105.2 | 235560    | 14-Nov-2023 | 19:10 | x64      |
| Txsort.dll                                                    | 2022.160.4105.2 | 231360    | 14-Nov-2023 | 19:09 | x86      |
| Txsort.dll                                                    | 2022.160.4105.2 | 276432    | 14-Nov-2023 | 19:10 | x64      |
| Txsplit.dll                                                   | 2022.160.4105.2 | 550952    | 14-Nov-2023 | 19:09 | x86      |
| Txsplit.dll                                                   | 2022.160.4105.2 | 620584    | 14-Nov-2023 | 19:10 | x64      |
| Txtermextraction.dll                                          | 2022.160.4105.2 | 8648744   | 14-Nov-2023 | 19:09 | x86      |
| Txtermextraction.dll                                          | 2022.160.4105.2 | 8702008   | 14-Nov-2023 | 19:10 | x64      |
| Txtermlookup.dll                                              | 2022.160.4105.2 | 4138944   | 14-Nov-2023 | 19:09 | x86      |
| Txtermlookup.dll                                              | 2022.160.4105.2 | 4184120   | 14-Nov-2023 | 19:10 | x64      |
| Txunionall.dll                                                | 2022.160.4105.2 | 153640    | 14-Nov-2023 | 19:09 | x86      |
| Txunionall.dll                                                | 2022.160.4105.2 | 194512    | 14-Nov-2023 | 19:10 | x64      |
| Txunpivot.dll                                                 | 2022.160.4105.2 | 178216    | 14-Nov-2023 | 19:09 | x86      |
| Txunpivot.dll                                                 | 2022.160.4105.2 | 214992    | 14-Nov-2023 | 19:10 | x64      |
| Xe.dll                                                        | 2022.160.4105.2 | 640960    | 14-Nov-2023 | 19:09 | x86      |
| Xe.dll                                                        | 2022.160.4105.2 | 718904    | 14-Nov-2023 | 19:10 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                              File   name                             |   File version  | File size |    Date   |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:---------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1032.0     | 559672    | 14-Nov-2023 | 20:13 | x86      |
| Dmsnative.dll                                                        | 2022.160.1032.0 | 152632    | 14-Nov-2023 | 20:13 | x64      |
| Dwengineservice.dll                                                  | 16.0.1032.0     | 45120     | 14-Nov-2023 | 20:13 | x86      |
| Instapi150.dll                                                       | 2022.160.4105.2 | 104488    | 14-Nov-2023 | 20:13 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1032.0     | 67640     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1032.0     | 293432    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1032.0     | 1958464   | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1032.0     | 169528    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1032.0     | 647232    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1032.0     | 246328    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1032.0     | 139320    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1032.0     | 79928     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1032.0     | 51256     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1032.0     | 88624     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1032.0     | 1129528   | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1032.0     | 80952     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1032.0     | 70712     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1032.0     | 35384     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1032.0     | 30784     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1032.0     | 46648     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1032.0     | 21552     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1032.0     | 26680     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1032.0     | 131648    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1032.0     | 86584     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1032.0     | 100928    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1032.0     | 293432    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 120384    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 138304    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 141368    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 137792    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 150584    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 139840    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 134712    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 176696    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 117824    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1032.0     | 136760    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1032.0     | 72760     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1032.0     | 22072     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1032.0     | 37432     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1032.0     | 129088    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1032.0     | 3064896   | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1032.0     | 3955768   | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 118336    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 133176    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 137784    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 133688    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 148544    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 134200    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 130616    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 171064    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 115256    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1032.0     | 132160    | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1032.0     | 67640     | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1032.0     | 2682936   | 14-Nov-2023 | 20:13 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1032.0     | 2436664   | 14-Nov-2023 | 20:13 | x86      |
| Mpdwinterop.dll                                                      | 2022.160.4105.2 | 296896    | 14-Nov-2023 | 20:13 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4105.2 | 7796688   | 14-Nov-2023 | 20:13 | x64      |
| Secforwarder.dll                                                     | 2022.160.4105.2 | 84008     | 14-Nov-2023 | 20:13 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1032.0 | 61488     | 14-Nov-2023 | 20:13 | x64      |
| Sqldk.dll                                                            | 2022.160.4105.2 | 4011968   | 14-Nov-2023 | 20:13 | x64      |
| Sqldumper.exe                                                        | 2022.160.4105.2 | 436280    | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 1755176   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4581416   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 3754024   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4581416   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4483008   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 2447416   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 2390072   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4212776   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4196392   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 1689656   | 14-Nov-2023 | 20:13 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4105.2 | 4446248   | 14-Nov-2023 | 20:13 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.5.1   | 1902528   | 14-Nov-2023 | 20:13 | x64      |
| Sqlos.dll                                                            | 2022.160.4105.2 | 51144     | 14-Nov-2023 | 20:13 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1032.0 | 4841536   | 14-Nov-2023 | 20:13 | x64      |
| Sqltses.dll                                                          | 2022.160.4105.2 | 9386040   | 14-Nov-2023 | 20:13 | x64      |

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

