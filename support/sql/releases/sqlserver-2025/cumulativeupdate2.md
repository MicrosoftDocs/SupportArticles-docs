---
title: Cumulative Update 2 for SQL Server 2025 (KB5075211)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2025 Cumulative Update 2 (KB5075211).
ms.date: 02/12/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5075211
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2025 on Windows
- SQL Server 2025 on Linux
---

# KB5075211 - Cumulative Update 2 for SQL Server 2025

_Release Date:_ &nbsp; February 12, 2026  
_Version:_ &nbsp; 17.0.4015.4  

## Summary

This article describes Cumulative Update (CU2) for Microsoft SQL Server 2025. This update package contains six [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the initial release of SQL Server 2025. It updates components in the following builds:

- SQL Server - Product version: **17.0.4015.4**, file version: **2025.170.4015.4**
- Analysis Services - Product version: **17.0.25.223**, file version: **2025.170.25.223**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2025, SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug reference                         | Description                                                                                                                                                                                                                | Fix area                | Component                               | Platform |
| :------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------- | :-------------------------------------- | :------- |
<a id=4838699>[4838699](#4838699)</a> | Fixes an issue that causes `StripedVdi` tests to fail if the `Sqlvdi.dll` file isn't registered on running instances.     | SQL Server Engine       | Backup Restore                         | Windows      |
| <a id=4860948>[4860948](#4860948)</a> | For `cluster_type = NONE or EXTERNAL`, availability group (AG) properties exist on only the local replica. This update writes the properties to the AG configuration so that all AG replicas receive the same properties.                                                                                                                               | SQL Server Engine        | High Availability and Disaster Recovery                        | All  |
| <a id=4869015>[4869015](#4869015)</a> | Fixes a potential inaccuracy in resource governor accounting for the `tempdb` space if accelerated database recovery is enabled for `tempdb`.                                                                                                                                   | SQL Server Engine       | Resource Governor                                   | All    |
| <a id=4924793>[4924793](#4924793)</a> | Fixes an issue in which an assertion and a dump file are generated around midnight on New Year’s Day during an operation that accesses Azure Blob Storage.                                                         | SQL Server Engine       | Storage Management                                   | All    |
| <a id=4925942>[4925942](#4925942)</a> | Fixes an issue that triggers nonyielding scheduler dump files in `PmmLogAcceptBlock` on the availability group (AG) secondary replica. The issue occurs if the persistent log buffer is enabled, and the database log cache contains primarily tiny log records.                                                                                                       | SQL Server Engine | Log Management        | All  |
| <a id=4931611>[4931611](#4931611)</a> | Fixes an issue in which the distributor is part of an availability group (AG) and uses case-sensitive (_CS) collation. The distribution agent incorrectly uses the AG primary replica name instead of AG listener name.                                                                                                                | SQL Server Engine       | Replication        | All  |  

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2025 CU2 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5075211)

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

You can verify the download by computing the hash of the _SQLServer2025-KB5075211-x64.exe_ file through the following command:

`certutil -hashfile SQLServer2025-KB5075211-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2025-KB5075211-x64.exe | 96ECDF19BBAA193D3689F22DE20E122656F9AD9357B851A3D0FA3FCBEECC9525 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5075211](https://download.microsoft.com/download/0d286e28-0ed5-4303-b01f-b9179448065a/KB5075211.csv).

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

- Each new CU contains all the fixes that were included with the previous CU for the installed version of SQL Server.
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
