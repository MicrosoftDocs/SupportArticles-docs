---
title: Cumulative update 22 for SQL Server 2022 (KB5068450)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 cumulative update 22 (KB5068450).
ms.date: 10/23/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5068450
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5068450 - Cumulative Update 22 for SQL Server 2022

_Release Date:_ &nbsp; November 13, 2025  
_Version:_ &nbsp; 16.0.4225.2

## Summary

This article describes Cumulative Update package 22 (CU22) for Microsoft SQL Server 2022. This update contains 20 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 21. It updates components in the following builds:

- SQL Server - Product version: **16.0.4225.2**, file version: **2022.160.4225.2**
- Analysis Services - Product version: **16.0.43.252**, file version: **2022.160.43.252**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-session-context.md)]

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug reference                          | Description                                                                                                                                                                                                                                                                | Fix area                       | Component                               | Platform |
| :------------------------------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----------------------------- | :-------------------------------------- | :------- |
| <a id=4660895>[4660895](#4660895) </a> | Fixes an issue in SQL Server Analysis Services in which Row-Level Security (RLS) filters could be skipped when combined with Object-Level Security (OLS) and Column-Level Security (CLS) in certain multi-role configurations.                                                | Analysis Services              | Analysis Services                       | Windows  |
| <a id=4573341>[4573341](#4573341) </a> | Upgrade `Microsoft.Rest.ClientRuntime` version to 2.3.24 on SSIS to fix vulnerability (CVE-2022-26907).                                                                                                                                                                    | Integration Services           | Integration Services                    | Windows  |
| <a id=4598768>[4598768](#4598768) </a> | Fixes an issue that causes inconsistent behavior when you import a certificate by using the drop-down menu or when you use the import button in the Configuration Manager.<br><br>Also fixes an issue in which selecting a certificate by using the thumbprint fails if the case doesn't match. | SQL Connectivity               | SQL Connectivity                        | Windows  |
| <a id=4675941>[4675941](#4675941) </a> | Fixes an issue in which transient negative elapsed time values on a secondary replica of an availability group causes data movement to pause.                                                                                                                                 | SQL Server Engine              | High Availability and Disaster Recovery | All      |
| <a id=4713591>[4713591](#4713591) </a> | Fixes access violation dump files during OLEDB calls if the Service Principal Name is missing.                                                                                                                                                                                | SQL Server Engine              | Security Infrastructure                 | All      |
| <a id=4582175>[4582175](#4582175) </a> | Enables caps for CacheStore PHDR usage when queries consume too much of the server's memory.                                                                                                                                                                               | SQL Server Engine              | SQL OS                                  | Windows  |
| <a id=4723355>[4723355](#4723355) </a> | Fixes an issue when the SQL Agent reads feature switches for Managed Instances (MI).                                                                                                                                                                                       | SQL Agent for Managed Instance | SQL Agent for Managed Instance          | Windows  |
| <a id=4573769>[4573769](#4573769) </a> | Introduces automatic cleanup of stale Log-Replay Service (LRS) metadata (older than 36 days)                                                                                                                                                                               | SQL Satellite                  | Cleanup service                         | Windows  |
| <a id=4339844>[4339844](#4339844) </a> | Fixed an assertion failure `File: <writeEncoded.cpp>, line='' Failed Assertion = 'pCurTargetBuf == pSource->m_pDirectEncodeTarget'` during a differential backup that uses compression on databases that contain large volumes of FILESTREAM records.                               | SQL Server Engine              | Backup Restore                          | Windows  |
| <a id=4552086>[4552086](#4552086) </a> | Fixes incorrect handling of write errors during a seeding restore process that's caused by misinterpretation of system error codes.                                                                                                                                                        | SQL Server Engine              | Backup Restore                          | All      |
| <a id=4644033>[4644033](#4644033) </a> | Fixes incorrect error handling that could cause the program not to respond when you run DBCC CHECKDB, CHECKTABLE, or CHECKFILEGROUP.                                                                                                                                                            | SQL Server Engine              | Backup Restore                          | All      |
| <a id=4642574>[4642574](#4642574) </a> | Fixes dump files during data copy from I/O pipeline when you perform a database restore process on versioned MI that has the worker.cl.wcow.sql22 app type.                                                                                                                  | SQL Server Engine              | Backup Restore                          | All      |
| <a id=4729459>[4729459](#4729459) </a> | Fixes an issue in sys.database_automatic_tuning_mode in which database state transitions can cause access violations while a query is running this DMV.                                                                                                                     | SQL Server Engine              | Database Automatic Tuning               | All      |
| <a id=4498278>[4498278](#4498278) </a> | Fixes an issue in which one or more databases enter the suspect state instead of the expected resolving state when a replica is removed from an availability group or the availability group is dropped while the associated replica is offline.                          | SQL Server Engine              | High Availability and Disaster Recovery | All      |
| <a id=4467909>[4467909](#4467909) </a> | Fixes an issue in which non-yielding scheduler dump files are generated in PmmLogAcceptBlock on the Availability Group secondary replica if persistent log buffer is enabled and the database's log cache contains primarily tiny log records.                                       | SQL Server Engine              | Log Management                          | All      |
| <a id=4713355>[4713355](#4713355) </a> | Fixes the `sp_do_backup` stored procedure under the `managed_backup`view to remove a SQL injection vulnerability. This stored procedure is for internal use only.                                                                                                          | SQL Server Engine              | Management Services                     | All      |
| <a id=4471009>[4471009](#4471009) </a> | Fixes an issue in which DBCC CHECKDB with EXTENDED_LOGICAL_CHECKS fails and returns an exception if there are both persisted and non-persisted computed columns in a table while trace flag 176 is enabled.                                                                        | SQL Server Engine              | Programmability                         | All      |
| <a id=4729881>[4729881](#4729881) </a> | Fixes an issue in which error codes aren't captured immediately after certain function calls. This condition causes the code to be overwritten and retry checks to behave incorrectly.                                                                                                     | SQL Server Engine              | SQL OS                                  | All      |
| <a id=4723335>[4723335](#4723335) </a> | Fixes an access violation dump file caused by an out-of-memory condition when fetching AAD authentication certificates.                                                                                                                                                                       | SQL Server Engine              | Security Infrastructure                 | All      |
| <a id=4511222>[4511222](#4511222) </a> | Fixes incorrect display values of the Instant File Initialization and Lock Pages in Memory fields in SQL Server Configuration Manager.                                                                                                                                     | SQL Server Client Tools        | SQL Server Configuration Manager        | Windows  |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?id=105013)

> [!NOTE]
>
> - Microsoft Download Center always offers the latest SQL Server 2022 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU22 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5068450)

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

You can verify the download by computing the hash of the *SQLServer2022-KB5068450-x64.exe* file through the following command:

`certutil -hashfile SQLServer2022-KB5068450-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2022-KB5068450-x64.exe | B06B59D7A41CC57BF0CC3EAEADB4E5FC196EA72E8FD1914C42760E31ADBF40E6 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5068450](https://download.microsoft.com/download/86c16950-c7c8-494e-829e-58d857c6d10a/KB5068450.csv).

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
