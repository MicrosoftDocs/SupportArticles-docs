---
title: Cumulative update 16 for SQL Server 2022 (KB5048033)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 16 (KB5048033).
ms.date: 04/30/2025
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5048033
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5048033 - Cumulative Update 16 for SQL Server 2022

_Release Date:_ &nbsp; November 14, 2024  
_Version:_ &nbsp; 16.0.4165.4

## Summary

This article describes Cumulative Update package 16 (CU16) for Microsoft SQL Server 2022. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 15 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4165.4**, file version: **2022.160.4165.4**
- Analysis Services - Product version: **16.0.43.239**, file version: **2022.160.43.239**

## Known issues in this update

### Access violation when session is reset

[!INCLUDE [av-sesssion-context-2022](../includes/av-sesssion-context-2022.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following Microsoft Knowledge Base articles.

| Bug reference| Description | Fix area| Component | Platform |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|-------------------------------------------|----------|
| <a id=3426244>[3426244](#3426244) </a> | Fixes an issue in which Data Analysis Expressions (DAX) queries that use `SUMMARIZECOLUMNS` and `ROLLUPGROUP` with multidimensional models might produce incorrect results when running multiple queries that have different sub-selects without clearing the cache, which causes inaccurate totals starting from the second query. | Analysis Services | Analysis Services | Windows|
| <a id=3518505>[3518505](#3518505) </a> | Fixes an issue in which the Data Quality Services (DQS) format is invalid when exporting cleaned data to SQL Server.| Data Quality Services | Data Quality Services | Windows|
| <a id=3518497>[3518497](#3518497) </a> | Fixes an issue in which the menu for editing model permissions appears in the wrong location on some system versions (for example, Windows Server 2019).| Master Data Services| Master Data Services| Windows|
| <a id=3586315>[3586315](#3586315) </a> | [FIX: Database is suspended incorrectly when you run ALTER SERVER CONFIGURATION (KB5048510)](database-suspend-incorrect-run-alter-server-configuration.md) | SQL Server Engine | Backup Restore| All|
| <a id=2331381>[2331381](#2331381) </a> | Fixes an issue that causes the `BACKUP SERVER WITH METADATA_ONLY` snapshot command to fail with the following errors when the SQL Server instance has more than 64 databases: </br></br>Msg 3088, Level 16, State 1, Line \<LineNumber> </br>Server \<ServerName> with dbid \<DatabaseID> failed to resume in session \<SessionID>. </br></br>Msg 925, Level 19, State 1, Line \<LineNumber> </br>Maximum number of databases used for each query has been exceeded. The maximum allowed is 64. </br></br>Msg 0, Level 20, State 0, Line \<LineNumber> </br>A severe error occurred on the current command.  The results, if any, should be discarded.| SQL Server Engine | Backup Restore| All|
| <a id=3567000>[3567000](#3567000) </a> | Fixes a deadlock issue that you might encounter when performing a Transact-SQL snapshot backup using the `METADATA_ONLY` option under heavy concurrent OLTP workloads, which causes an eventual time-out of the backup with the following errors: </br></br>Error: 3041, Severity: 16, State: 1. </br>BACKUP failed to complete the command BACKUP DATABASE \<DatabaseName>. Check the backup application log for detailed messages. </br></br>\<DateTime> ERROR: [PID:\<PID>:Backup:\<BackupID>] Snapshot failed with message 'Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.'. | SQL Server Engine | Backup Restore| All|
| <a id=3418488>[3418488](#3418488) </a> | Fixes a patching error that you encounter in secondary replicas of an availability group with databases that have SQL replication or change data capture (CDC) enabled. For more information, see [known issue of SQL Server 2022 CU15](cumulativeupdate15.md#issue-one-patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-or-cdc) or [known issue one of SQL Server 2022 CU14](cumulativeupdate14.md#issue-one-patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-or-cdc). | SQL Server Engine | High Availability and Disaster Recovery | Windows|
| <a id=3487067>[3487067](#3487067) </a> | Fixes an issue that causes database corruption if a system failure with `alternatewritethrough` mode occurs.| SQL Server Engine | Linux | Linux|
| <a id=3435174>[3435174](#3435174) </a> | Fixes incorrect results that you might encounter when you use the contained availability group (AG) and remove plans for a specific object by altering it from either a contained AG or non-contained AG connection. When you make changes from a contained AG or non-contained AG connection, the other connection continues to use the old plan for the altered object until it's manually removed from the plan cache. | SQL Server Engine | Programmability | All|
| <a id=2696108>[2696108](#2696108) </a> | Removes unnecessary log messages written to the SQL Server error log by the `sys.sp_flush_ct_internal_table_on_demand` stored procedure.| SQL Server Engine | Replication | All|
| <a id=3419788>[3419788](#3419788) </a> | Allows you to disable [OLE DB streaming](/sql/relational-databases/replication/agents/replication-distribution-agent) by passing -UseOledbStreaming 0 for the Replication Distribution Agent to avoid the error mentioned in [Error message when you run the Distribution Agent in SQL Server](../../database-engine/replication/error-run-distribution-agent.md).| SQL Server Engine | Replication | All|
| <a id=3459385>[3459385](#3459385) </a> | Fixes an issue in which the full-text auto crawl monitor is aborted when you use full-text search.| SQL Server Engine | Search| All|
| <a id=3461615>[3461615](#3461615) </a> | Fixes an issue in which `fdhost` frequently restarts due to out-of-memory (OOM) of `fdhost` when there are too many outstanding global batches from SQL Server in the cloud.| SQL Server Engine | Search| All|
| <a id=3495266>[3495266](#3495266) </a> | Fixes an issue in which the SQL Server error log might include invalid characters for SQL Server Agent login attempts when the Agent runs a job on a scheduler configured to run automatically once the Agent starts. | SQL Server Engine | SQL Agent | Windows|
| <a id=3530163>[3530163](#3530163) </a> | Fixes an issue in which upgrading from SQL Server 2017 or SQL Server 2019 to SQL Server 2022 is blocked during the database `model_msdb` upgrade phase. The following message appears in the SQL Server error log: </br></br>\<DateTime> Database 'model_msdb' running the upgrade step from version \<VersionNumber> to version 957. </br></br>Additionally, you might see the following error message when trying to log in: </br></br>\<DateTime> Logon Error: 18401, Severity: 14, State: 1. </br>\<DateTime> Logon Login failed for user 'UserName'. Reason: Server is in script upgrade mode. Only administrator can connect at this time. [CLIENT: ClientID] | SQL Server Engine | SQL Server Engine | All|
| <a id=3417400>[3417400](#3417400) </a> | Fixes a contention issue with high `KTM_RECOVERY_MANAGER` wait times that you might encounter when running XA distributed transactions. </br></br>**Note**: You need to turn on trace flag 8531 as a startup trace flag.| SQL Server Engine | Transaction Services| All|

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU16 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5048033)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5048033-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5048033-x64.exe SHA256`

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5048033-x64.exe| 169493E443AA9BDED1E18DE8F454560407AB634BA9F7A5FFA6A55F3A675F3A84  |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

|                      File name                      |   File version  | File size |     Date    |  Time | Platform |
|:---------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Anglesharp.dll                                      | 0.9.9.0         | 1240112   | 06-Nov-2024 | 20:08 | x86      |
| Asplatformhost.dll                                  | 2022.160.43.239 | 336944    | 06-Nov-2024 | 19:58 | x64      |
| Mashupcompression.dll                               | 2.127.602.0     | 141760    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.analysisservices.minterop.dll             | 16.0.43.239     | 865216    | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.analysisservices.server.core.dll          | 16.0.43.239     | 2903640   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.data.edm.netfx35.dll                      | 5.7.0.62516     | 661936    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.dll                           | 2.127.602.0     | 224184    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.oledb.dll                     | 2.127.602.0     | 32192     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.preview.dll                   | 2.127.602.0     | 153528    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.dll            | 2.127.602.0     | 113088    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 33216     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47040     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42928     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 47024     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 38832     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.providercommon.resources.dll  | 2.127.602.0     | 42944     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.mashup.sqlclient.dll                 | 2.127.602.0     | 25536     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.odata.netfx35.dll                    | 5.7.0.62516     | 1455536   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.odata.query.netfx35.dll              | 5.7.0.62516     | 182200    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.dll                        | 1.0.0.25        | 931680    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 35200     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 36704     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 37216     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 39808     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sapclient.resources.dll              | 1.0.0.25        | 49024     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sqlclient.dll                        | 2.17.23292.1    | 1997744   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sqlclient.sni.dll                    | 2.1.1.0         | 511920    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.dataintegration.fuzzyclustering.dll       | 1.0.0.0         | 40368     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.dataintegration.fuzzymatching.dll         | 1.0.0.0         | 628144    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.dataintegration.fuzzymatchingcommon.dll   | 1.0.0.0         | 390064    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.exchange.webservices.dll                  | 15.0.913.15     | 1124272   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.hostintegration.connectors.dll            | 2.127.602.0     | 4964800   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identity.client.dll                       | 4.57.0.0        | 1653680   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll           | 6.35.0.41201    | 111536    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.logging.dll                 | 6.35.0.41201    | 38320     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.protocols.dll               | 6.35.0.41201    | 39856     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll | 6.35.0.41201    | 114096    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.tokens.dll                  | 6.35.0.41201    | 992192    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.cdm.icdmprovider.dll               | 2.127.602.0     | 21952     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.container.exe                      | 2.127.602.0     | 25024     | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.mashup.container.netfx40.exe              | 2.127.602.0     | 24000     | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.mashup.container.netfx45.exe              | 2.127.602.0     | 23992     | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.mashup.eventsource.dll                    | 2.127.602.0     | 150448    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.dll                          | 2.127.602.0     | 94144     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15808     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16320     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16312     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16816     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 17344     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 15792     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oauth.resources.dll                | 2.127.602.0     | 16304     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbinterop.dll                   | 2.127.602.0     | 201144    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.mashup.oledbprovider.dll                  | 2.127.602.0     | 67008     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14264     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14272     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.oledbprovider.resources.dll        | 2.127.602.0     | 14256     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.sapbwprovider.dll                  | 2.127.602.0     | 334256    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.scriptdom.dll                      | 2.40.4554.261   | 2365872   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.shims.dll                          | 2.127.602.0     | 29616     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashup.storage.xmlserializers.dll         | 1.0.0.0         | 141248    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.dll                          | 2.127.602.0     | 15941040  | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.dll                | 2.127.602.0     | 7617472   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39360     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40368     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 40888     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 42424     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 47024     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 35872     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 36288     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39856     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.library45.resources.dll      | 2.127.602.0     | 39872     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 620464    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 747448    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 739248    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 718776    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 776128    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 726960    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 702384    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 980912    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 612272    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mashupengine.resources.dll                | 2.127.602.0     | 714672    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.mshtml.dll                                | 7.0.3300.1      | 8017840   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.odata.core.netfx35.dll                    | 6.15.0.0        | 1438656   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.odata.core.netfx35.v7.dll                 | 7.4.0.11102     | 1262000   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.odata.edm.netfx35.dll                     | 6.15.0.0        | 779712    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.odata.edm.netfx35.v7.dll                  | 7.4.0.11102     | 745920    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.powerbi.adomdclient.dll                   | 16.0.122.20     | 1216944   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.spatial.netfx35.dll                       | 6.15.0.0        | 127408    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.spatial.netfx35.v7.dll                    | 7.4.0.11102     | 125368    | 06-Nov-2024 | 20:08 | x86      |
| Msmdctr.dll                                         | 2022.160.43.239 | 38984     | 06-Nov-2024 | 19:58 | x64      |
| Msmdlocal.dll                                       | 2022.160.43.239 | 53975640  | 06-Nov-2024 | 19:58 | x86      |
| Msmdlocal.dll                                       | 2022.160.43.239 | 71818808  | 06-Nov-2024 | 19:58 | x64      |
| Msmdpump.dll                                        | 2022.160.43.239 | 10333632  | 06-Nov-2024 | 19:58 | x64      |
| Msmdredir.dll                                       | 2022.160.43.239 | 8132032   | 06-Nov-2024 | 19:58 | x86      |
| Msmdsrv.exe                                         | 2022.160.43.239 | 71365704  | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 956880    | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1884720   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1671728   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1881160   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1848272   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1147440   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1140272   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1769520   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1749064   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 932912    | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrv.rll                                         | 2022.160.43.239 | 1837616   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 955464    | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1882576   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1668544   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1876552   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1844808   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1145416   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1138640   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1765456   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1745480   | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 933448    | 06-Nov-2024 | 19:58 | x64      |
| Msmdsrvi.rll                                        | 2022.160.43.239 | 1833032   | 06-Nov-2024 | 19:58 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.239 | 10083400  | 06-Nov-2024 | 19:58 | x64      |
| Msmgdsrv.dll                                        | 2022.160.43.239 | 8265264   | 06-Nov-2024 | 19:58 | x86      |
| Msolap.dll                                          | 2022.160.43.239 | 10969648  | 06-Nov-2024 | 19:58 | x64      |
| Msolap.dll                                          | 2022.160.43.239 | 8744024   | 06-Nov-2024 | 19:58 | x86      |
| Msolui.dll                                          | 2022.160.43.239 | 308176    | 06-Nov-2024 | 19:58 | x64      |
| Msolui.dll                                          | 2022.160.43.239 | 289832    | 06-Nov-2024 | 19:58 | x86      |
| Newtonsoft.json.dll                                 | 13.0.3.27908    | 722264    | 06-Nov-2024 | 20:08 | x86      |
| Parquetsharp.dll                                    | 0.0.0.0         | 412592    | 06-Nov-2024 | 20:08 | x64      |
| Parquetsharpnative.dll                              | 7.0.0.17        | 20091320  | 06-Nov-2024 | 20:08 | x64      |
| Powerbiextensions.dll                               | 2.127.602.0     | 11111344  | 06-Nov-2024 | 20:08 | x86      |
| Private_odbc32.dll                                  | 10.0.19041.1    | 735288    | 06-Nov-2024 | 20:08 | x64      |
| Sni.dll                                             | 1.1.1.0         | 555424    | 06-Nov-2024 | 20:08 | x64      |
| Sql_as_keyfile.dll                                  | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 19:58 | x64      |
| Sqlceip.exe                                         | 16.0.4165.4     | 301112    | 06-Nov-2024 | 20:08 | x86      |
| Sqldumper.exe                                       | 2022.160.4165.4 | 378952    | 06-Nov-2024 | 19:58 | x86      |
| Sqldumper.exe                                       | 2022.160.4165.4 | 448552    | 06-Nov-2024 | 19:58 | x64      |
| System.identitymodel.tokens.jwt.dll                 | 6.35.0.41201    | 77248     | 06-Nov-2024 | 20:08 | x86      |
| System.spatial.netfx35.dll                          | 5.7.0.62516     | 118704    | 06-Nov-2024 | 20:08 | x86      |
| Tmapi.dll                                           | 2022.160.43.239 | 5884504   | 06-Nov-2024 | 19:58 | x64      |
| Tmcachemgr.dll                                      | 2022.160.43.239 | 5575224   | 06-Nov-2024 | 19:58 | x64      |
| Tmpersistence.dll                                   | 2022.160.43.239 | 1481288   | 06-Nov-2024 | 19:58 | x64      |
| Tmtransactions.dll                                  | 2022.160.43.239 | 7198296   | 06-Nov-2024 | 19:58 | x64      |
| Xmsrv.dll                                           | 2022.160.43.239 | 26593328  | 06-Nov-2024 | 19:58 | x64      |
| Xmsrv.dll                                           | 2022.160.43.239 | 35895760  | 06-Nov-2024 | 19:58 | x86      |

SQL Server 2022 Database Services Common Core

|                  File name                 |   File version  | File size |     Date    |  Time | Platform |
|:------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Instapi150.dll                             | 2022.160.4165.4 | 104504    | 06-Nov-2024 | 19:58 | x64      |
| Instapi150.dll                             | 2022.160.4165.4 | 79912     | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.239     | 2633776   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.analysisservices.adomdclient.dll | 16.0.43.239     | 2633800   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.analysisservices.core.dll        | 16.0.43.239     | 2933328   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.analysisservices.xmla.dll        | 16.0.43.239     | 2323528   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4165.4 | 104504    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.sqlserver.mgdsqldumper.dll       | 2022.160.4165.4 | 92224     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.rmo.dll                | 16.0.4165.4     | 555064    | 06-Nov-2024 | 20:08 | x86      |
| Msasxpress.dll                             | 2022.160.43.239 | 27720     | 06-Nov-2024 | 19:58 | x86      |
| Msasxpress.dll                             | 2022.160.43.239 | 32816     | 06-Nov-2024 | 19:58 | x64      |
| Sql_common_core_keyfile.dll                | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 19:58 | x64      |
| Sqldumper.exe                              | 2022.160.4165.4 | 378952    | 06-Nov-2024 | 19:58 | x86      |
| Sqldumper.exe                              | 2022.160.4165.4 | 448552    | 06-Nov-2024 | 19:58 | x64      |
| Sqlmgmprovider.dll                         | 2022.160.4165.4 | 395320    | 06-Nov-2024 | 20:08 | x86      |
| Sqlmgmprovider.dll                         | 2022.160.4165.4 | 456760    | 06-Nov-2024 | 20:08 | x64      |
| Sqlsvcsync.dll                             | 2022.160.4165.4 | 280616    | 06-Nov-2024 | 20:08 | x86      |
| Sqlsvcsync.dll                             | 2022.160.4165.4 | 362552    | 06-Nov-2024 | 20:08 | x64      |
| Svrenumapi150.dll                          | 2022.160.4165.4 | 1247296   | 06-Nov-2024 | 20:08 | x64      |
| Svrenumapi150.dll                          | 2022.160.4165.4 | 972840    | 06-Nov-2024 | 20:08 | x86      |

SQL Server 2022 Data Quality Client

|             File name            |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.studio.infra.dll | 16.0.4165.4     | 309320    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.studio.views.dll | 16.0.4165.4     | 2070600   | 06-Nov-2024 | 20:08 | x86      |
| Sql_dqc_keyfile.dll              | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 20:08 | x64      |

SQL Server 2022 Data Quality

|           File name           | File version | File size |     Date    |  Time | Platform |
|:-----------------------------:|:------------:|:---------:|:-----------:|:-----:|:--------:|
| Microsoft.ssdqs.cleansing.dll | 16.0.4165.4  | 469072    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.cleansing.dll | 16.0.4165.4  | 469032    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4165.4  | 600104    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.core.dll      | 16.0.4165.4  | 600104    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4165.4  | 174120    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.dll           | 16.0.4165.4  | 174144    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4165.4  | 1857576   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.infra.dll     | 16.0.4165.4  | 1857592   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4165.4  | 370728    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.ssdqs.proxy.dll     | 16.0.4165.4  | 370728    | 06-Nov-2024 | 20:08 | x86      |

SQL Server 2022 Database Services Core Instance

|                   File name                  |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Adal.dll                                     | 3.6.1.64359     | 1618832   | 06-Nov-2024 | 20:09 | x64      |
| Adalsqlrda.dll                               | 3.6.1.64359     | 1618832   | 06-Nov-2024 | 20:09 | x64      |
| Aetm-enclave-simulator.dll                   | 2022.160.4165.4 | 5995048   | 06-Nov-2024 | 20:50 | x64      |
| Aetm-enclave.dll                             | 2022.160.4165.4 | 5959696   | 06-Nov-2024 | 20:50 | x64      |
| Aetm-sgx-enclave-simulator.dll               | 2022.160.4165.4 | 6194808   | 06-Nov-2024 | 20:50 | x64      |
| Aetm-sgx-enclave.dll                         | 2022.160.4165.4 | 6160680   | 06-Nov-2024 | 20:50 | x64      |
| Dcexec.exe                                   | 2022.160.4165.4 | 96336     | 06-Nov-2024 | 20:50 | x64      |
| Fssres.dll                                   | 2022.160.4165.4 | 100392    | 06-Nov-2024 | 20:50 | x64      |
| Hadrres.dll                                  | 2022.160.4165.4 | 227384    | 06-Nov-2024 | 20:50 | x64      |
| Hkcompile.dll                                | 2022.160.4165.4 | 1427496   | 06-Nov-2024 | 20:50 | x64      |
| Hkengine.dll                                 | 2022.160.4165.4 | 5769272   | 06-Nov-2024 | 20:50 | x64      |
| Hkruntime.dll                                | 2022.160.4165.4 | 190504    | 06-Nov-2024 | 20:50 | x64      |
| Hktempdb.dll                                 | 2022.160.4165.4 | 71720     | 06-Nov-2024 | 20:50 | x64      |
| Microsoft.analysisservices.applocal.xmla.dll | 16.0.43.239     | 2322504   | 06-Nov-2024 | 20:09 | x86      |
| Microsoft.sqlserver.xe.core.dll              | 2022.160.4165.4 | 84048     | 06-Nov-2024 | 20:50 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll | 2022.160.4165.4 | 182352    | 06-Nov-2024 | 20:50 | x64      |
| Microsoft.sqlserver.xevent.dll               | 2022.160.4165.4 | 198728    | 06-Nov-2024 | 20:50 | x64      |
| Microsoft.sqlserver.xevent.linq.dll          | 2022.160.4165.4 | 333896    | 06-Nov-2024 | 20:50 | x64      |
| Microsoft.sqlserver.xevent.targets.dll       | 2022.160.4165.4 | 96296     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 30792     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 38976     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 34888     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 38984     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 38976     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 30792     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 30784     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 34896     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 38984     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 30800     | 06-Nov-2024 | 20:50 | x64      |
| Odsole70.rll                                 | 16.0.4165.4     | 38976     | 06-Nov-2024 | 20:50 | x64      |
| Qds.dll                                      | 2022.160.4165.4 | 1808424   | 06-Nov-2024 | 20:50 | x64      |
| Rsfxft.dll                                   | 2022.160.4165.4 | 55368     | 06-Nov-2024 | 20:50 | x64      |
| Secforwarder.dll                             | 2022.160.4165.4 | 84040     | 06-Nov-2024 | 20:50 | x64      |
| Sql_engine_core_inst_keyfile.dll             | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 20:09 | x64      |
| Sqlaamss.dll                                 | 2022.160.4165.4 | 120912    | 06-Nov-2024 | 20:50 | x64      |
| Sqlaccess.dll                                | 2022.160.4165.4 | 444488    | 06-Nov-2024 | 20:50 | x64      |
| Sqlagent.exe                                 | 2022.160.4165.4 | 722984    | 06-Nov-2024 | 20:50 | x64      |
| Sqlceip.exe                                  | 16.0.4165.4     | 301112    | 06-Nov-2024 | 20:50 | x86      |
| Sqlcmdss.dll                                 | 2022.160.4165.4 | 104504    | 06-Nov-2024 | 20:50 | x64      |
| Sqlctr160.dll                                | 2022.160.4165.4 | 129064    | 06-Nov-2024 | 20:50 | x86      |
| Sqlctr160.dll                                | 2022.160.4165.4 | 157768    | 06-Nov-2024 | 20:50 | x64      |
| Sqldk.dll                                    | 2022.160.4165.4 | 4024360   | 06-Nov-2024 | 20:50 | x64      |
| Sqldtsss.dll                                 | 2022.160.4165.4 | 120888    | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 1759304   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3872832   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4089928   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4601928   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4737104   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3774536   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3962960   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4601920   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4429888   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4503616   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 2459720   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 2402376   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4286536   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3922000   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4442192   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4233288   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4216904   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3999824   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 3876928   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 1697872   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4327496   | 06-Nov-2024 | 20:50 | x64      |
| Sqlevn70.rll                                 | 2022.160.4165.4 | 4466768   | 06-Nov-2024 | 20:50 | x64      |
| Sqliosim.com                                 | 2022.160.4165.4 | 387152    | 06-Nov-2024 | 20:50 | x64      |
| Sqliosim.exe                                 | 2022.160.4165.4 | 3057720   | 06-Nov-2024 | 20:50 | x64      |
| Sqllang.dll                                  | 2022.160.4165.4 | 48924752  | 06-Nov-2024 | 20:50 | x64      |
| Sqlmin.dll                                   | 2022.160.4165.4 | 51275856  | 06-Nov-2024 | 20:50 | x64      |
| Sqlolapss.dll                                | 2022.160.4165.4 | 116776    | 06-Nov-2024 | 20:50 | x64      |
| Sqlos.dll                                    | 2022.160.4165.4 | 51280     | 06-Nov-2024 | 20:50 | x64      |
| Sqlpowershellss.dll                          | 2022.160.4165.4 | 100408    | 06-Nov-2024 | 20:50 | x64      |
| Sqlrepss.dll                                 | 2022.160.4165.4 | 145448    | 06-Nov-2024 | 20:50 | x64      |
| Sqlscriptdowngrade.dll                       | 2022.160.4165.4 | 51256     | 06-Nov-2024 | 20:50 | x64      |
| Sqlscriptupgrade.dll                         | 2022.160.4165.4 | 5834808   | 06-Nov-2024 | 20:50 | x64      |
| Sqlservr.exe                                 | 2022.160.4165.4 | 723000    | 06-Nov-2024 | 20:50 | x64      |
| Sqlsvc.dll                                   | 2022.160.4165.4 | 194632    | 06-Nov-2024 | 20:50 | x64      |
| Sqltses.dll                                  | 2022.160.4165.4 | 10668112  | 06-Nov-2024 | 20:50 | x64      |
| Sqsrvres.dll                                 | 2022.160.4165.4 | 305208    | 06-Nov-2024 | 20:50 | x64      |
| Svl.dll                                      | 2022.160.4165.4 | 247888    | 06-Nov-2024 | 20:50 | x64      |
| Xe.dll                                       | 2022.160.4165.4 | 718888    | 06-Nov-2024 | 20:50 | x64      |
| Xpqueue.dll                                  | 2022.160.4165.4 | 100392    | 06-Nov-2024 | 20:50 | x64      |
| Xpstar.dll                                   | 2022.160.4165.4 | 534608    | 06-Nov-2024 | 20:50 | x64      |

SQL Server 2022 Database Services Core Shared

|                       File name                      |   File version   | File size |     Date    |  Time | Platform |
|:----------------------------------------------------:|:----------------:|:---------:|:-----------:|:-----:|:--------:|
| Azure.core.dll                                       | 1.3600.23.56006  | 384432    | 06-Nov-2024 | 20:08 | x86      |
| Azure.identity.dll                                   | 1.1000.423.56303 | 334768    | 06-Nov-2024 | 20:08 | x86      |
| Bcp.exe                                              | 2022.160.4165.4  | 141376    | 06-Nov-2024 | 20:08 | x64      |
| Commanddest.dll                                      | 2022.160.4165.4  | 272424    | 06-Nov-2024 | 20:08 | x64      |
| Datacollectortasks.dll                               | 2022.160.4165.4  | 227400    | 06-Nov-2024 | 20:08 | x64      |
| Distrib.exe                                          | 2022.160.4165.4  | 260176    | 06-Nov-2024 | 20:08 | x64      |
| Dteparse.dll                                         | 2022.160.4165.4  | 133200    | 06-Nov-2024 | 20:08 | x64      |
| Dteparsemgd.dll                                      | 2022.160.4165.4  | 178216    | 06-Nov-2024 | 20:08 | x64      |
| Dtepkg.dll                                           | 2022.160.4165.4  | 153640    | 06-Nov-2024 | 20:08 | x64      |
| Dtexec.exe                                           | 2022.160.4165.4  | 76872     | 06-Nov-2024 | 20:08 | x64      |
| Dts.dll                                              | 2022.160.4165.4  | 3266600   | 06-Nov-2024 | 20:08 | x64      |
| Dtscomexpreval.dll                                   | 2022.160.4165.4  | 493608    | 06-Nov-2024 | 20:08 | x64      |
| Dtsconn.dll                                          | 2022.160.4165.4  | 550952    | 06-Nov-2024 | 20:08 | x64      |
| Dtshost.exe                                          | 2022.160.4165.4  | 120392    | 06-Nov-2024 | 20:08 | x64      |
| Dtslog.dll                                           | 2022.160.4165.4  | 137256    | 06-Nov-2024 | 20:08 | x64      |
| Dtspipeline.dll                                      | 2022.160.4165.4  | 1337424   | 06-Nov-2024 | 20:08 | x64      |
| Dtuparse.dll                                         | 2022.160.4165.4  | 104520    | 06-Nov-2024 | 20:08 | x64      |
| Dtutil.exe                                           | 2022.160.4165.4  | 166440    | 06-Nov-2024 | 20:08 | x64      |
| Exceldest.dll                                        | 2022.160.4165.4  | 284712    | 06-Nov-2024 | 20:08 | x64      |
| Excelsrc.dll                                         | 2022.160.4165.4  | 305224    | 06-Nov-2024 | 20:08 | x64      |
| Execpackagetask.dll                                  | 2022.160.4165.4  | 182328    | 06-Nov-2024 | 20:08 | x64      |
| Flatfiledest.dll                                     | 2022.160.4165.4  | 423992    | 06-Nov-2024 | 20:08 | x64      |
| Flatfilesrc.dll                                      | 2022.160.4165.4  | 440376    | 06-Nov-2024 | 20:08 | x64      |
| Logread.exe                                          | 2022.160.4165.4  | 792616    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.analysisservices.applocal.core.dll         | 16.0.43.239      | 2933808   | 06-Nov-2024 | 19:58 | x86      |
| Microsoft.bcl.asyncinterfaces.dll                    | 6.0.21.52210     | 22144     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sqlclient.dll                         | 5.13.23292.1     | 2048632   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.data.sqlclient.sni.dll                     | 5.1.1.0          | 504872    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.data.tools.sql.batchparser.dll             | 17.100.23.0      | 42416     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.datatransformationservices.scalehelper.dll | 16.0.4165.4      | 30760     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identity.client.dll                        | 4.56.0.0         | 1652320   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identity.client.extensions.msal.dll        | 4.56.0.0         | 66552     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.abstractions.dll             | 6.24.0.31013     | 18864     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.jsonwebtokens.dll            | 6.24.0.31013     | 85424     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.logging.dll                  | 6.24.0.31013     | 34224     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.protocols.dll                | 6.24.0.31013     | 38288     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.protocols.openidconnect.dll  | 6.24.0.31013     | 114048    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.identitymodel.tokens.dll                   | 6.24.0.31013     | 986032    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.connectioninfo.dll               | 17.100.23.0      | 126496    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.dmf.common.dll                   | 17.100.23.0      | 63520     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll         | 16.0.4165.4      | 391208    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.management.sdk.sfc.dll           | 17.100.23.0      | 513464    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.replication.dll                  | 2022.160.4165.4  | 1718312   | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.sqlserver.rmo.dll                          | 16.0.4165.4      | 555064    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.servicebrokerenum.dll            | 17.100.23.0      | 37920     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.smo.dll                          | 17.100.23.0      | 4451872   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.smoextended.dll                  | 17.100.23.0      | 161208    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.sqlclrprovider.dll               | 17.100.23.0      | 21536     | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.sqlenum.dll                      | 17.100.23.0      | 1587744   | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll         | 2022.160.4165.4  | 182352    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.sqlserver.xevent.dll                       | 2022.160.4165.4  | 198728    | 06-Nov-2024 | 20:08 | x64      |
| Msdtssrvrutil.dll                                    | 2022.160.4165.4  | 124984    | 06-Nov-2024 | 20:08 | x64      |
| Msgprox.dll                                          | 2022.160.4165.4  | 313424    | 06-Nov-2024 | 20:08 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 2750472   | 06-Nov-2024 | 20:08 | x64      |
| Msoledbsql.dll                                       | 2018.187.4.0     | 153608    | 06-Nov-2024 | 20:08 | x64      |
| Newtonsoft.json.dll                                  | 13.0.1.25517     | 704408    | 06-Nov-2024 | 20:08 | x86      |
| Oledbdest.dll                                        | 2022.160.4165.4  | 288840    | 06-Nov-2024 | 20:08 | x64      |
| Oledbsrc.dll                                         | 2022.160.4165.4  | 313384    | 06-Nov-2024 | 20:08 | x64      |
| Qrdrsvc.exe                                          | 2022.160.4165.4  | 526416    | 06-Nov-2024 | 20:08 | x64      |
| Rawdest.dll                                          | 2022.160.4165.4  | 227408    | 06-Nov-2024 | 20:08 | x64      |
| Rawsource.dll                                        | 2022.160.4165.4  | 215096    | 06-Nov-2024 | 20:08 | x64      |
| Rdistcom.dll                                         | 2022.160.4165.4  | 944168    | 06-Nov-2024 | 20:08 | x64      |
| Recordsetdest.dll                                    | 2022.160.4165.4  | 206928    | 06-Nov-2024 | 20:08 | x64      |
| Repldp.dll                                           | 2022.160.4165.4  | 337992    | 06-Nov-2024 | 20:08 | x64      |
| Replerrx.dll                                         | 2022.160.4165.4  | 198728    | 06-Nov-2024 | 20:08 | x64      |
| Replisapi.dll                                        | 2022.160.4165.4  | 419912    | 06-Nov-2024 | 20:08 | x64      |
| Replmerg.exe                                         | 2022.160.4165.4  | 596032    | 06-Nov-2024 | 20:08 | x64      |
| Replprov.dll                                         | 2022.160.4165.4  | 890960    | 06-Nov-2024 | 20:08 | x64      |
| Replrec.dll                                          | 2022.160.4165.4  | 1058880   | 06-Nov-2024 | 20:08 | x64      |
| Replsub.dll                                          | 2022.160.4165.4  | 501800    | 06-Nov-2024 | 20:08 | x64      |
| Spresolv.dll                                         | 2022.160.4165.4  | 301128    | 06-Nov-2024 | 20:08 | x64      |
| Sql_engine_core_shared_keyfile.dll                   | 2022.160.4165.4  | 137272    | 06-Nov-2024 | 19:58 | x64      |
| Sqlcmd.exe                                           | 2022.160.4165.4  | 276520    | 06-Nov-2024 | 20:08 | x64      |
| Sqldiag.exe                                          | 2022.160.4165.4  | 1140792   | 06-Nov-2024 | 20:08 | x64      |
| Sqldistx.dll                                         | 2022.160.4165.4  | 268344    | 06-Nov-2024 | 20:08 | x64      |
| Sqlmergx.dll                                         | 2022.160.4165.4  | 424016    | 06-Nov-2024 | 20:08 | x64      |
| Sqlnclirda11.dll                                     | 2011.110.5069.66 | 3478208   | 06-Nov-2024 | 20:08 | x64      |
| Sqlsvc.dll                                           | 2022.160.4165.4  | 194632    | 06-Nov-2024 | 20:08 | x64      |
| Sqlsvc.dll                                           | 2022.160.4165.4  | 153664    | 06-Nov-2024 | 20:08 | x86      |
| Sqltaskconnections.dll                               | 2022.160.4165.4  | 211024    | 06-Nov-2024 | 20:08 | x64      |
| Ssradd.dll                                           | 2022.160.4165.4  | 100432    | 06-Nov-2024 | 20:08 | x64      |
| Ssravg.dll                                           | 2022.160.4165.4  | 100392    | 06-Nov-2024 | 20:08 | x64      |
| Ssrmax.dll                                           | 2022.160.4165.4  | 100416    | 06-Nov-2024 | 20:08 | x64      |
| Ssrmin.dll                                           | 2022.160.4165.4  | 100392    | 06-Nov-2024 | 20:08 | x64      |
| System.diagnostics.diagnosticsource.dll              | 7.0.423.11508    | 173232    | 06-Nov-2024 | 20:08 | x86      |
| System.memory.dll                                    | 4.6.31308.1      | 142240    | 06-Nov-2024 | 20:08 | x86      |
| System.runtime.compilerservices.unsafe.dll           | 6.0.21.52210     | 18024     | 06-Nov-2024 | 20:08 | x86      |
| System.security.cryptography.protecteddata.dll       | 7.0.22.51805     | 21640     | 06-Nov-2024 | 20:08 | x86      |
| Txagg.dll                                            | 2022.160.4165.4  | 395304    | 06-Nov-2024 | 20:08 | x64      |
| Txbdd.dll                                            | 2022.160.4165.4  | 190520    | 06-Nov-2024 | 20:08 | x64      |
| Txdatacollector.dll                                  | 2022.160.4165.4  | 469056    | 06-Nov-2024 | 20:08 | x64      |
| Txdataconvert.dll                                    | 2022.160.4165.4  | 333880    | 06-Nov-2024 | 20:08 | x64      |
| Txderived.dll                                        | 2022.160.4165.4  | 632872    | 06-Nov-2024 | 20:08 | x64      |
| Txlookup.dll                                         | 2022.160.4165.4  | 608336    | 06-Nov-2024 | 20:08 | x64      |
| Txmerge.dll                                          | 2022.160.4165.4  | 243784    | 06-Nov-2024 | 20:08 | x64      |
| Txmergejoin.dll                                      | 2022.160.4165.4  | 301136    | 06-Nov-2024 | 20:08 | x64      |
| Txmulticast.dll                                      | 2022.160.4165.4  | 145488    | 06-Nov-2024 | 20:08 | x64      |
| Txrowcount.dll                                       | 2022.160.4165.4  | 145464    | 06-Nov-2024 | 20:08 | x64      |
| Txsort.dll                                           | 2022.160.4165.4  | 276552    | 06-Nov-2024 | 20:08 | x64      |
| Txsplit.dll                                          | 2022.160.4165.4  | 620584    | 06-Nov-2024 | 20:08 | x64      |
| Txunionall.dll                                       | 2022.160.4165.4  | 194632    | 06-Nov-2024 | 20:08 | x64      |
| Xe.dll                                               | 2022.160.4165.4  | 718888    | 06-Nov-2024 | 20:08 | x64      |

SQL Server 2022 sql_extensibility

|           File name           |   File version  | File size |     Date    |  Time | Platform |
|:-----------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Commonlauncher.dll            | 2022.160.4165.4 | 100432    | 06-Nov-2024 | 20:08 | x64      |
| Exthost.exe                   | 2022.160.4165.4 | 247848    | 06-Nov-2024 | 20:08 | x64      |
| Launchpad.exe                 | 2022.160.4165.4 | 1452088   | 06-Nov-2024 | 20:08 | x64      |
| Sql_extensibility_keyfile.dll | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 20:08 | x64      |
| Sqlsatellite.dll              | 2022.160.4165.4 | 1255488   | 06-Nov-2024 | 20:08 | x64      |

SQL Server 2022 Full-Text Engine

|         File name        |   File version  | File size |     Date    |  Time | Platform |
|:------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Fd.dll                   | 2022.160.4165.4 | 710696    | 06-Nov-2024 | 20:08 | x64      |
| Fdhost.exe               | 2022.160.4165.4 | 153640    | 06-Nov-2024 | 20:08 | x64      |
| Fdlauncher.exe           | 2022.160.4165.4 | 100432    | 06-Nov-2024 | 20:08 | x64      |
| Sql_fulltext_keyfile.dll | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 20:08 | x64      |

SQL Server 2022 Integration Services

|                           File name                           |   File version  | File size |     Date    |  Time | Platform |
|:-------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Attunity.sqlserver.cdccontroltask.dll                         | 7.0.0.133       | 78272     | 06-Nov-2024 | 20:08 | x86      |
| Attunity.sqlserver.cdcsplit.dll                               | 7.0.0.133       | 39320     | 06-Nov-2024 | 20:08 | x86      |
| Attunity.sqlserver.cdcsrc.dll                                 | 7.0.0.133       | 79808     | 06-Nov-2024 | 20:08 | x86      |
| Commanddest.dll                                               | 2022.160.4165.4 | 231488    | 06-Nov-2024 | 20:08 | x86      |
| Commanddest.dll                                               | 2022.160.4165.4 | 272424    | 06-Nov-2024 | 20:08 | x64      |
| Dteparse.dll                                                  | 2022.160.4165.4 | 116800    | 06-Nov-2024 | 20:08 | x86      |
| Dteparse.dll                                                  | 2022.160.4165.4 | 133200    | 06-Nov-2024 | 20:08 | x64      |
| Dteparsemgd.dll                                               | 2022.160.4165.4 | 165960    | 06-Nov-2024 | 20:08 | x86      |
| Dteparsemgd.dll                                               | 2022.160.4165.4 | 178216    | 06-Nov-2024 | 20:08 | x64      |
| Dtepkg.dll                                                    | 2022.160.4165.4 | 129104    | 06-Nov-2024 | 20:08 | x86      |
| Dtepkg.dll                                                    | 2022.160.4165.4 | 153640    | 06-Nov-2024 | 20:08 | x64      |
| Dtexec.exe                                                    | 2022.160.4165.4 | 65096     | 06-Nov-2024 | 20:08 | x86      |
| Dtexec.exe                                                    | 2022.160.4165.4 | 76872     | 06-Nov-2024 | 20:08 | x64      |
| Dts.dll                                                       | 2022.160.4165.4 | 2861120   | 06-Nov-2024 | 20:08 | x86      |
| Dts.dll                                                       | 2022.160.4165.4 | 3266600   | 06-Nov-2024 | 20:08 | x64      |
| Dtscomexpreval.dll                                            | 2022.160.4165.4 | 444488    | 06-Nov-2024 | 20:08 | x86      |
| Dtscomexpreval.dll                                            | 2022.160.4165.4 | 493608    | 06-Nov-2024 | 20:08 | x64      |
| Dtsconn.dll                                                   | 2022.160.4165.4 | 464976    | 06-Nov-2024 | 20:08 | x86      |
| Dtsconn.dll                                                   | 2022.160.4165.4 | 550952    | 06-Nov-2024 | 20:08 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4165.4 | 114744    | 06-Nov-2024 | 20:08 | x64      |
| Dtsdebughost.exe                                              | 2022.160.4165.4 | 94800     | 06-Nov-2024 | 20:08 | x86      |
| Dtshost.exe                                                   | 2022.160.4165.4 | 120392    | 06-Nov-2024 | 20:08 | x64      |
| Dtshost.exe                                                   | 2022.160.4165.4 | 98384     | 06-Nov-2024 | 20:08 | x86      |
| Dtslog.dll                                                    | 2022.160.4165.4 | 120912    | 06-Nov-2024 | 20:08 | x86      |
| Dtslog.dll                                                    | 2022.160.4165.4 | 137256    | 06-Nov-2024 | 20:08 | x64      |
| Dtspipeline.dll                                               | 2022.160.4165.4 | 1144888   | 06-Nov-2024 | 20:08 | x86      |
| Dtspipeline.dll                                               | 2022.160.4165.4 | 1337424   | 06-Nov-2024 | 20:08 | x64      |
| Dtuparse.dll                                                  | 2022.160.4165.4 | 104520    | 06-Nov-2024 | 20:08 | x64      |
| Dtuparse.dll                                                  | 2022.160.4165.4 | 88136     | 06-Nov-2024 | 20:08 | x86      |
| Dtutil.exe                                                    | 2022.160.4165.4 | 142416    | 06-Nov-2024 | 20:08 | x86      |
| Dtutil.exe                                                    | 2022.160.4165.4 | 166440    | 06-Nov-2024 | 20:08 | x64      |
| Exceldest.dll                                                 | 2022.160.4165.4 | 247872    | 06-Nov-2024 | 20:08 | x86      |
| Exceldest.dll                                                 | 2022.160.4165.4 | 284712    | 06-Nov-2024 | 20:08 | x64      |
| Excelsrc.dll                                                  | 2022.160.4165.4 | 264256    | 06-Nov-2024 | 20:08 | x86      |
| Excelsrc.dll                                                  | 2022.160.4165.4 | 305224    | 06-Nov-2024 | 20:08 | x64      |
| Execpackagetask.dll                                           | 2022.160.4165.4 | 149584    | 06-Nov-2024 | 20:08 | x86      |
| Execpackagetask.dll                                           | 2022.160.4165.4 | 182328    | 06-Nov-2024 | 20:08 | x64      |
| Flatfiledest.dll                                              | 2022.160.4165.4 | 374856    | 06-Nov-2024 | 20:08 | x86      |
| Flatfiledest.dll                                              | 2022.160.4165.4 | 423992    | 06-Nov-2024 | 20:08 | x64      |
| Flatfilesrc.dll                                               | 2022.160.4165.4 | 391208    | 06-Nov-2024 | 20:08 | x86      |
| Flatfilesrc.dll                                               | 2022.160.4165.4 | 440376    | 06-Nov-2024 | 20:08 | x64      |
| Isdbupgradewizard.exe                                         | 16.0.4165.4     | 120872    | 06-Nov-2024 | 20:08 | x86      |
| Isdbupgradewizard.exe                                         | 16.0.4165.4     | 120872    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.239     | 2933808   | 06-Nov-2024 | 19:59 | x86      |
| Microsoft.analysisservices.applocal.core.dll                  | 16.0.43.239     | 2933832   | 06-Nov-2024 | 19:59 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4165.4     | 509992    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.integrationservices.isserverdbupgrade.dll | 16.0.4165.4     | 509992    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.maintenanceplantasks.dll                  | 16.0.4165.4     | 391208    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4165.4 | 170048    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.xevent.configuration.dll                  | 2022.160.4165.4 | 182352    | 06-Nov-2024 | 20:08 | x64      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4165.4 | 178216    | 06-Nov-2024 | 20:08 | x86      |
| Microsoft.sqlserver.xevent.dll                                | 2022.160.4165.4 | 198728    | 06-Nov-2024 | 20:08 | x64      |
| Msdtssrvr.exe                                                 | 16.0.4165.4     | 219192    | 06-Nov-2024 | 20:08 | x64      |
| Msdtssrvrutil.dll                                             | 2022.160.4165.4 | 100416    | 06-Nov-2024 | 20:08 | x86      |
| Msdtssrvrutil.dll                                             | 2022.160.4165.4 | 124984    | 06-Nov-2024 | 20:08 | x64      |
| Msmdpp.dll                                                    | 2022.160.43.239 | 10164264  | 06-Nov-2024 | 19:59 | x64      |
| Newtonsoft.json.dll                                           | 13.0.1.25517    | 704408    | 06-Nov-2024 | 20:08 | x86      |
| Odbcdest.dll                                                  | 2022.160.4165.4 | 342088    | 06-Nov-2024 | 20:08 | x86      |
| Odbcdest.dll                                                  | 2022.160.4165.4 | 383016    | 06-Nov-2024 | 20:08 | x64      |
| Odbcsrc.dll                                                   | 2022.160.4165.4 | 350280    | 06-Nov-2024 | 20:08 | x86      |
| Odbcsrc.dll                                                   | 2022.160.4165.4 | 399400    | 06-Nov-2024 | 20:08 | x64      |
| Oledbdest.dll                                                 | 2022.160.4165.4 | 247888    | 06-Nov-2024 | 20:08 | x86      |
| Oledbdest.dll                                                 | 2022.160.4165.4 | 288840    | 06-Nov-2024 | 20:08 | x64      |
| Oledbsrc.dll                                                  | 2022.160.4165.4 | 268360    | 06-Nov-2024 | 20:08 | x86      |
| Oledbsrc.dll                                                  | 2022.160.4165.4 | 313384    | 06-Nov-2024 | 20:08 | x64      |
| Rawdest.dll                                                   | 2022.160.4165.4 | 227408    | 06-Nov-2024 | 20:08 | x64      |
| Rawdest.dll                                                   | 2022.160.4165.4 | 190528    | 06-Nov-2024 | 20:08 | x86      |
| Rawsource.dll                                                 | 2022.160.4165.4 | 215096    | 06-Nov-2024 | 20:08 | x64      |
| Rawsource.dll                                                 | 2022.160.4165.4 | 186448    | 06-Nov-2024 | 20:08 | x86      |
| Recordsetdest.dll                                             | 2022.160.4165.4 | 174120    | 06-Nov-2024 | 20:08 | x86      |
| Recordsetdest.dll                                             | 2022.160.4165.4 | 206928    | 06-Nov-2024 | 20:08 | x64      |
| Sql_is_keyfile.dll                                            | 2022.160.4165.4 | 137272    | 06-Nov-2024 | 19:59 | x64      |
| Sqlceip.exe                                                   | 16.0.4165.4     | 301112    | 06-Nov-2024 | 20:08 | x86      |
| Sqldest.dll                                                   | 2022.160.4165.4 | 256080    | 06-Nov-2024 | 20:08 | x86      |
| Sqldest.dll                                                   | 2022.160.4165.4 | 288840    | 06-Nov-2024 | 20:08 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4165.4 | 211024    | 06-Nov-2024 | 20:08 | x64      |
| Sqltaskconnections.dll                                        | 2022.160.4165.4 | 174152    | 06-Nov-2024 | 20:08 | x86      |
| Txagg.dll                                                     | 2022.160.4165.4 | 346176    | 06-Nov-2024 | 20:08 | x86      |
| Txagg.dll                                                     | 2022.160.4165.4 | 395304    | 06-Nov-2024 | 20:08 | x64      |
| Txbdd.dll                                                     | 2022.160.4165.4 | 149584    | 06-Nov-2024 | 20:08 | x86      |
| Txbdd.dll                                                     | 2022.160.4165.4 | 190520    | 06-Nov-2024 | 20:08 | x64      |
| Txbestmatch.dll                                               | 2022.160.4165.4 | 567376    | 06-Nov-2024 | 20:08 | x86      |
| Txbestmatch.dll                                               | 2022.160.4165.4 | 661576    | 06-Nov-2024 | 20:08 | x64      |
| Txcache.dll                                                   | 2022.160.4165.4 | 170056    | 06-Nov-2024 | 20:08 | x86      |
| Txcache.dll                                                   | 2022.160.4165.4 | 202792    | 06-Nov-2024 | 20:08 | x64      |
| Txcharmap.dll                                                 | 2022.160.4165.4 | 280656    | 06-Nov-2024 | 20:08 | x86      |
| Txcharmap.dll                                                 | 2022.160.4165.4 | 325688    | 06-Nov-2024 | 20:08 | x64      |
| Txcopymap.dll                                                 | 2022.160.4165.4 | 165952    | 06-Nov-2024 | 20:08 | x86      |
| Txcopymap.dll                                                 | 2022.160.4165.4 | 202808    | 06-Nov-2024 | 20:08 | x64      |
| Txdataconvert.dll                                             | 2022.160.4165.4 | 288840    | 06-Nov-2024 | 20:08 | x86      |
| Txdataconvert.dll                                             | 2022.160.4165.4 | 333880    | 06-Nov-2024 | 20:08 | x64      |
| Txderived.dll                                                 | 2022.160.4165.4 | 559168    | 06-Nov-2024 | 20:08 | x86      |
| Txderived.dll                                                 | 2022.160.4165.4 | 632872    | 06-Nov-2024 | 20:08 | x64      |
| Txfileextractor.dll                                           | 2022.160.4165.4 | 186432    | 06-Nov-2024 | 20:08 | x86      |
| Txfileextractor.dll                                           | 2022.160.4165.4 | 219176    | 06-Nov-2024 | 20:08 | x64      |
| Txfileinserter.dll                                            | 2022.160.4165.4 | 186448    | 06-Nov-2024 | 20:08 | x86      |
| Txfileinserter.dll                                            | 2022.160.4165.4 | 219216    | 06-Nov-2024 | 20:08 | x64      |
| Txgroupdups.dll                                               | 2022.160.4165.4 | 354384    | 06-Nov-2024 | 20:08 | x86      |
| Txgroupdups.dll                                               | 2022.160.4165.4 | 403496    | 06-Nov-2024 | 20:08 | x64      |
| Txlineage.dll                                                 | 2022.160.4165.4 | 129088    | 06-Nov-2024 | 20:08 | x86      |
| Txlineage.dll                                                 | 2022.160.4165.4 | 157776    | 06-Nov-2024 | 20:08 | x64      |
| Txlookup.dll                                                  | 2022.160.4165.4 | 522304    | 06-Nov-2024 | 20:08 | x86      |
| Txlookup.dll                                                  | 2022.160.4165.4 | 608336    | 06-Nov-2024 | 20:08 | x64      |
| Txmerge.dll                                                   | 2022.160.4165.4 | 194624    | 06-Nov-2024 | 20:08 | x86      |
| Txmerge.dll                                                   | 2022.160.4165.4 | 243784    | 06-Nov-2024 | 20:08 | x64      |
| Txmergejoin.dll                                               | 2022.160.4165.4 | 256080    | 06-Nov-2024 | 20:08 | x86      |
| Txmergejoin.dll                                               | 2022.160.4165.4 | 301136    | 06-Nov-2024 | 20:08 | x64      |
| Txmulticast.dll                                               | 2022.160.4165.4 | 116816    | 06-Nov-2024 | 20:08 | x86      |
| Txmulticast.dll                                               | 2022.160.4165.4 | 145488    | 06-Nov-2024 | 20:08 | x64      |
| Txpivot.dll                                                   | 2022.160.4165.4 | 198736    | 06-Nov-2024 | 20:08 | x86      |
| Txpivot.dll                                                   | 2022.160.4165.4 | 239656    | 06-Nov-2024 | 20:08 | x64      |
| Txrowcount.dll                                                | 2022.160.4165.4 | 116776    | 06-Nov-2024 | 20:08 | x86      |
| Txrowcount.dll                                                | 2022.160.4165.4 | 145464    | 06-Nov-2024 | 20:08 | x64      |
| Txsampling.dll                                                | 2022.160.4165.4 | 153680    | 06-Nov-2024 | 20:08 | x86      |
| Txsampling.dll                                                | 2022.160.4165.4 | 186448    | 06-Nov-2024 | 20:08 | x64      |
| Txscd.dll                                                     | 2022.160.4165.4 | 198720    | 06-Nov-2024 | 20:08 | x86      |
| Txscd.dll                                                     | 2022.160.4165.4 | 235600    | 06-Nov-2024 | 20:08 | x64      |
| Txsort.dll                                                    | 2022.160.4165.4 | 231496    | 06-Nov-2024 | 20:08 | x86      |
| Txsort.dll                                                    | 2022.160.4165.4 | 276552    | 06-Nov-2024 | 20:08 | x64      |
| Txsplit.dll                                                   | 2022.160.4165.4 | 550976    | 06-Nov-2024 | 20:08 | x86      |
| Txsplit.dll                                                   | 2022.160.4165.4 | 620584    | 06-Nov-2024 | 20:08 | x64      |
| Txtermextraction.dll                                          | 2022.160.4165.4 | 8648744   | 06-Nov-2024 | 20:08 | x86      |
| Txtermextraction.dll                                          | 2022.160.4165.4 | 8702016   | 06-Nov-2024 | 20:08 | x64      |
| Txtermlookup.dll                                              | 2022.160.4165.4 | 4139064   | 06-Nov-2024 | 20:08 | x86      |
| Txtermlookup.dll                                              | 2022.160.4165.4 | 4184104   | 06-Nov-2024 | 20:08 | x64      |
| Txunionall.dll                                                | 2022.160.4165.4 | 153672    | 06-Nov-2024 | 20:08 | x86      |
| Txunionall.dll                                                | 2022.160.4165.4 | 194632    | 06-Nov-2024 | 20:08 | x64      |
| Txunpivot.dll                                                 | 2022.160.4165.4 | 178240    | 06-Nov-2024 | 20:08 | x86      |
| Txunpivot.dll                                                 | 2022.160.4165.4 | 215080    | 06-Nov-2024 | 20:08 | x64      |
| Xe.dll                                                        | 2022.160.4165.4 | 641064    | 06-Nov-2024 | 20:08 | x86      |
| Xe.dll                                                        | 2022.160.4165.4 | 718888    | 06-Nov-2024 | 20:08 | x64      |

SQL Server 2022 sql_polybase_core_inst

|                               File name                              |   File version  | File size |     Date    |  Time | Platform |
|:--------------------------------------------------------------------:|:---------------:|:---------:|:-----------:|:-----:|:--------:|
| Dms.dll                                                              | 16.0.1046.0     | 559680    | 06-Nov-2024 | 20:32 | x86      |
| Dmsnative.dll                                                        | 2022.160.1046.0 | 152640    | 06-Nov-2024 | 20:32 | x64      |
| Dwengineservice.dll                                                  | 16.0.1046.0     | 45112     | 06-Nov-2024 | 20:32 | x86      |
| Instapi150.dll                                                       | 2022.160.4165.4 | 104504    | 06-Nov-2024 | 20:32 | x64      |
| Microsoft.sqlserver.datawarehouse.backup.backupmetadata.dll          | 16.0.1046.0     | 67640     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.catalog.dll                        | 16.0.1046.0     | 293456    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.common.dll                         | 16.0.1046.0     | 1958472   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.configuration.dll                  | 16.0.1046.0     | 169520    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.common.dll            | 16.0.1046.0     | 647224    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.manager.dll           | 16.0.1046.0     | 246368    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagetypes.dll      | 16.0.1046.0     | 139344    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.datamovement.messagingprotocol.dll | 16.0.1046.0     | 79968     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.diagnostics.dll                    | 16.0.1046.0     | 51248     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.distributor.dll                    | 16.0.1046.0     | 88656     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.dll                         | 16.0.1046.0     | 1129528   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.engine.statsstream.dll             | 16.0.1046.0     | 80992     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.eventing.dll                       | 16.0.1046.0     | 70736     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.appliance.dll               | 16.0.1046.0     | 35376     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.interface.dll               | 16.0.1046.0     | 30784     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.polybase.dll                | 16.0.1046.0     | 46672     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.fabric.xdbinterface.dll            | 16.0.1046.0     | 21552     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.failover.dll                       | 16.0.1046.0     | 26672     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.hadoop.hadoopbridge.dll            | 16.0.1046.0     | 131664    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.loadercommon.dll                   | 16.0.1046.0     | 86624     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.loadmanager.dll                    | 16.0.1046.0     | 100960    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.dll                   | 16.0.1046.0     | 293432    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 120376    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 138296    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 141384    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 137776    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 150592    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 139832    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 134712    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 176688    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 117816    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.localization.resources.dll         | 16.0.1046.0     | 136768    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.nodes.dll                          | 16.0.1046.0     | 72784     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.nulltransaction.dll                | 16.0.1046.0     | 22064     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.parallelizer.dll                   | 16.0.1046.0     | 37432     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.resourcemanagement.dll             | 16.0.1046.0     | 129072    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.dll                            | 16.0.1046.0     | 3064912   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.dll                     | 16.0.1046.0     | 3955784   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 118336    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133184    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 137776    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 133680    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 148528    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 134192    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 130624    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 171064    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 115256    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sql.parser.resources.dll           | 16.0.1046.0     | 132152    | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.sqldistributor.dll                 | 16.0.1046.0     | 67664     | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.transactsql.scriptdom.dll          | 16.0.1046.0     | 2682936   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.datawarehouse.utilities.dll                      | 16.0.1046.0     | 2436664   | 06-Nov-2024 | 20:32 | x86      |
| Microsoft.sqlserver.xe.core.dll                                      | 2022.160.4165.4 | 84048     | 06-Nov-2024 | 20:32 | x64      |
| Microsoft.sqlserver.xevent.configuration.dll                         | 2022.160.4165.4 | 182352    | 06-Nov-2024 | 20:32 | x64      |
| Microsoft.sqlserver.xevent.dll                                       | 2022.160.4165.4 | 198728    | 06-Nov-2024 | 20:32 | x64      |
| Mpdwinterop.dll                                                      | 2022.160.4165.4 | 297000    | 06-Nov-2024 | 20:32 | x64      |
| Mpdwsvc.exe                                                          | 2022.160.4165.4 | 9078840   | 06-Nov-2024 | 20:32 | x64      |
| Secforwarder.dll                                                     | 2022.160.4165.4 | 84040     | 06-Nov-2024 | 20:32 | x64      |
| Sharedmemory.dll                                                     | 2022.160.1046.0 | 61504     | 06-Nov-2024 | 20:32 | x64      |
| Sqldk.dll                                                            | 2022.160.4165.4 | 4024360   | 06-Nov-2024 | 20:32 | x64      |
| Sqldumper.exe                                                        | 2022.160.4165.4 | 448552    | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 1759304   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4601928   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 3774536   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4601920   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4503616   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 2459720   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 2402376   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4233288   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4216904   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 1697872   | 06-Nov-2024 | 20:32 | x64      |
| Sqlevn70.rll                                                         | 2022.160.4165.4 | 4466768   | 06-Nov-2024 | 20:32 | x64      |
| Sqlncli17e.dll                                                       | 2017.1710.6.1   | 1898520   | 06-Nov-2024 | 20:32 | x64      |
| Sqlos.dll                                                            | 2022.160.4165.4 | 51280     | 06-Nov-2024 | 20:32 | x64      |
| Sqlsortpdw.dll                                                       | 2022.160.1046.0 | 4841520   | 06-Nov-2024 | 20:32 | x64      |
| Sqltses.dll                                                          | 2022.160.4165.4 | 10668112  | 06-Nov-2024 | 20:32 | x64      |

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
