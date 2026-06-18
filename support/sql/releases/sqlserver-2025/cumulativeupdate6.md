---
title: Cumulative Update 6 for SQL Server 2025 (KB5093421)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2025 Cumulative Update 6 (KB5093421).
ms.date: 06/17/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5093421
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2025 on Windows
- SQL Server 2025 on Linux
---

# KB5093421 - Cumulative Update 6 for SQL Server 2025

_Release Date:_ &nbsp; June 17, 2026  
_Version:_ &nbsp; 17.0.4055.5  

## Summary

This article describes Cumulative Update (CU6) for Microsoft SQL Server 2025. This update package contains 19 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2025 Cumulative Update 5. It updates components in the following builds:

- SQL Server - Product version: **17.0.4055.5**, file version: **2025.170.4055.5**
- Analysis Services - Product version: **17.0.25.223**, file version: **2025.170.25.223**

[!INCLUDE [enable-encryption-extended-protection](../includes/enable-encryption-extended-protection.md)]

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-sesssion-context.md)]

### Linked server queries that use MSDASQL fail and generate error 7416

[!INCLUDE [msdasql-error-7416](../includes/msdasql-error-7416.md)]

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2025, SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug Reference                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Fix Area             | Component                               | Platform |
| :------------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------- | :-------------------------------------- | :------- |
| <a id=5094785>[5094785](#5094785)</a> | Fixes an issue that can occur during parallel vector index builds and that can cause resource exhaustion and performance degradation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | SQL Server Engine    | Query Processing                        | All      |
| <a id=5152151>[5152151](#5152151)</a> | Fixes an issue in which changing the collation setup can block `mssql-conf` unexpectedly on systems that have a high CPU count.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5195494>[5195494](#5195494)</a> | Fixes an issue in which altering a disabled DDL trigger causes a memory access violation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | SQL Server Engine    | Programmability                         | All      |
| <a id=5200910>[5200910](#5200910)</a> | Fixes an issue in which file creation fails unexpectedly on file systems that don't support hard links.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5218020>[5218020](#5218020)</a> | Updates the Pacemaker resource agent to treat a forwarder replica as the local primary for the local availability group orchestrator.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | SQL Server Engine    | High Availability and Disaster Recovery | Linux    |
| <a id=5218889>[5218889](#5218889)</a> | Fixes Error 17750 (DLL load failure) that can occur when you run `sp_executesql` in a Linux container that's configured by using the `Korean_Wansung_CI_AS` collation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5221609>[5221609](#5221609)</a> | Fixes a failure that can occur on Linux when you run striped backups that have 16 or more stripes if Transparent Huge Pages (THP) is enabled.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5228161>[5228161](#5228161)</a> | Adds more detailed error information to the Windows Failover Cluster log when the availability group resource DLL can't retrieve diagnostic column information.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | SQL Server Engine    | High Availability and Disaster Recovery | Windows  |
| <a id=5229575>[5229575](#5229575)</a> | Fixes a scheduling issue that can prevent a thread from suspending during an index rebuild. This issue causes the program to stop responding.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5240442>[5240442](#5240442)</a> | Changes the default value of the `FULLTEXT_INDEX_VERSION` database scoped configuration to `2` on Azure SQL Managed Instance.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | SQL Server Engine    | Search                                  | Windows  |
| <a id=5240590>[5240590](#5240590)</a> | Fixes an issue in which DDL operations on Change Data Capture (CDC) tables can trigger date conversion errors.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | SQL Server Engine    | Linux                                   | Linux    |
| <a id=5248649>[5248649](#5248649)</a> | Updates the `bcp` utility to support bulk import and bulk export of the `vector(16)` and `vector(32)` data types. Support for `vector(16)` in `bcp` becomes functional only after the next ODBC driver release. Also adds the `-H` (`HostNameInCertificate`) and `-J` (`ServerCertificate`) options for strict TLS certificate validation.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | SQL Connectivity     | SQL Connectivity                        | Windows  |
| <a id=5251310>[5251310](#5251310)</a> | Fixes several issues that can cause `tempdb` space usage accounting to be inaccurate in uncommon cases.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | SQL Server Engine    | SQL OS                                  | All      |
| <a id=5255250>[5255250](#5255250)</a> | Upgrades SQL Server Integration Services (SSIS) password-based encryption (`EncryptAllWithPassword` and `EncryptSensitiveWithPassword`) to use PBKDF2 with SHA-256 and 100,000 iterations for packages that target SQL Server 2025. Packages that are saved after this update, including packages that are generated by the Import and Export Wizard, require compatible versions of SQL Server Data Tools (SSDT) and SQL Server Management Studio (SSMS) to open. Until Microsoft releases compatible versions, users can't open these packages in SSDT or SSMS. For compatible versions, see the [SSDT](https://marketplace.visualstudio.com/items?itemName=SSIS.MicrosoftDataToolsIntegrationServices) and [SSMS](https://aka.ms/SSMSReleaseNote) release notes. Packages that target SQL Server 2022 and earlier versions aren't affected. | Integration Services | Integration Services                    | Windows  |
| <a id=5256562>[5256562](#5256562)</a> | Fixes a failed assertion that's related to thread trace elements that can occur on the primary replica of an availability group.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | SQL Server Engine    | High Availability and Disaster Recovery | All      |
| <a id=5258873>[5258873](#5258873)</a> | Fixes an issue in which SSIS packages can't be deployed or run successfully if they connect to SQL Server instances that are configured by using `Encrypt=Strict`.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | Integration Services | Integration Services                    | Windows  |
| <a id=5266605>[5266605](#5266605)</a> | Fixes handling of zero-length TLS records in the SNI SSL provider.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | SQL Server Engine    | Unified Communication Stack             | All      |
| <a id=5267380>[5267380](#5267380)</a> | Fixes a possible failure that can occur on a DML operation that inserts a `NULL` JSON document into a JSON index column.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | SQL Server Engine    | Programmability                         | All      |

## How to obtain or download this CU or the latest CU package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2025 now](https://www.microsoft.com/download/details.aspx?id=108540)

> [!NOTE]
>
> - Microsoft Download Center always offers the latest SQL Server 2025 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2025 CU6 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5093421)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202025) contains this SQL Server 2025 CU and previously released SQL Server 2025 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that's available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2025 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2025 Release Notes](/sql/linux/sql-server-linux-release-notes-2025).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the _SQLServer2025-KB5093421-x64.exe_ file through the following command:

`certutil -hashfile SQLServer2025-KB5093421-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2025-KB5093421-x64.exe | 1D91082726FD4331F7D48FF992BA3C7511599F881FBE3ABE431148AA9CE74441 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5093421](https://download.microsoft.com/download/c81f7935-380f-42f7-b5c2-bf21c00004c7/KB5093421.csv).

</details>

## Notes for this update

<details>
<summary><b>Prerequisites</b></summary>

To apply this cumulative update package, you must be running SQL Server 2025.

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

- Each new CU contains all the fixes that were included in the previous CU for the installed version of SQL Server.
- SQL Server CUs are certified to the same levels as service packs, and should be installed at the same level of confidence.
- We recommend ongoing, proactive installation of CUs as they become available according to these guidelines:
  - Historical data shows that a significant number of support cases involve an issue that was already addressed in a released CU.
  - CUs might contain added value over and above hotfixes, such as supportability, manageability, and reliability updates.
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
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/blog/ssis/ssis-with-alwayson/388091)) for information about how to apply an update in these environments.

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

One CU package includes all available updates for all SQL Server 2025 components (features). However, the cumulative update package updates only those components that are currently installed on the SQL Server instance that you select to be serviced. If a SQL Server feature (for example, Analysis Services) is added to the instance after this CU is applied, you must reapply this CU to update the new feature to this CU.

</details>

<details>
<summary><b>Support for this update</b></summary>

If other issues occur, or if any troubleshooting is required, you might have to create a service request. The usual support costs will apply to additional support questions and to issues that don't qualify for this specific cumulative update package. For a complete list of Microsoft Customer Service and Support telephone numbers, or to create a separate service request, go to the [Microsoft support website](https://support.microsoft.com/contactus/?ws=support).
</details>

## How to uninstall this update

<details>
<summary><b>How to uninstall this update on Windows</b></summary>

1. In Control Panel, open the **Programs and Features** item, and then select **View installed updates**.
1. Locate the entry that corresponds to this cumulative update package under **SQL Server 2025**.
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
