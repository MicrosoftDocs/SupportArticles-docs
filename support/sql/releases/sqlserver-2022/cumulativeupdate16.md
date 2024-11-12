---
title: Cumulative update 16 for SQL Server 2022 (KB5048033)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 16 (KB5048033).
ms.date: 11/14/2024
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
- Analysis Services - Product version: **16.0.43.233**, file version: **2022.160.43.233**

## Known issues in this update

### Patching error for secondary replicas in an availability group with databases enabled replication, CDC, or SSISDB

[!INCLUDE [patching-error-2022](../includes/patching-error-2022.md)]

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
| <a id=3567000>[3567000](#3567000) </a> | Fixes a deadlock issue that you might encounter when performing a Transact-SQL snapshot backup using the `METADATA_ONLY` option under heavy concurrent OLTP workloads, which causes an eventual time-out of the backup with the following errors: </br></br>Error: 3041, Severity: 16, State: 1. </br>BACKUP failed to complete the command BACKUP DATABASE \<DatabaseName>. Check the backup application log for detailed messages. </br></br>\<DataTime> ERROR: [PID:\<PID>:Backup:\<BackupID>] Snapshot failed with message 'Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.'. | SQL Server Engine | Backup Restore| All|
| <a id=3418488>[3418488](#3418488) </a> | Fixes a patching error that you encounter in secondary replicas of an availability group with databases that have SQL replication, change data capture (CDC), or SQL Server Integration Services database (SSISDB) enabled. For more information, see [known issue of SQL Server 2022 CU15](../../releases/sqlserver-2022/cumulativeupdate15.md#patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-cdc-or-ssisdb) or [known issue one of SQL Server 2022 CU14](../../releases/sqlserver-2022/cumulativeupdate14.md#issue-one-patching-error-for-secondary-replicas-in-an-availability-group-with-databases-enabled-replication-cdc-or-ssisdb). | SQL Server Engine | High Availability and Disaster Recovery | Windows|
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
|SQLServer2022-KB5048033-x64.exe|   |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

