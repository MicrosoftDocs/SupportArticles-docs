---
title: Cumulative update 1 for SQL Server 2025 (KB5074901)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2025 Cumulative Update 1 (KB5074901).
ms.date: 01/20/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5074901
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2025 on Windows
- SQL Server 2025 on Linux
---

# KB5074901 - Cumulative Update 1 for SQL Server 2025

_Release Date:_ &nbsp; January 15, 2026  
_Version:_ &nbsp; 17.0.4005.7  

## Summary

> [!NOTE]  
> This cumulative update is temporarily unavailable for download because of a [known issue related to Database Mail](#database-mail-stops-working-after-updating).

This article describes Cumulative Update package 1 (CU1) for Microsoft SQL Server 2025. This update contains 16 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the initial release of SQL Server 2025. It updates components in the following builds:

- SQL Server - Product version: **17.0.4005.7**, file version: **2025.170.4005.7**
- Analysis Services - Product version: **17.0.25.223**, file version: **2025.170.25.223**

## Known issues in this update

### Database Mail stops working after updating

[!INCLUDE [database-mail-stops](../includes/database-mail-stops.md)]

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2025, SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug reference                         | Description                                                                                                                                                                                                                | Fix area                | Component                               | Platform |
| :------------------------------------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------- | :-------------------------------------- | :------- |
| <a id=4729051>[4729051](#4729051)</a> | Fixes an issue in which DBCC CHECKDB with EXTENDED_LOGICAL_CHECKS stops responding and returns an exception if there are both persisted and non-persisted computed columns in a table while trace flag 176 is enabled.     | SQL Server Engine       | Programmability                         | All      |
| <a id=4787271>[4787271](#4787271)</a> | Fixes an issue that causes SQLCMD to crash when you use the -N switch in a :CONNECT command.                                                                                                                               | SQL Connectivity        | SQL Connectivity                        | Windows  |
| <a id=4796293>[4796293](#4796293)</a> | Fixes incorrect CPU usage metrics in sys.dm_os_ring_buffers DMV for SQL Server on Linux.                                                                                                                                   | SQL Server Engine       | Linux                                   | Linux    |
| <a id=4796318>[4796318](#4796318)</a> | Fixes an issue that causes SQL Server on Linux to fail when it reads an invalid ID type from the Domain Controller.                                                                                                        | SQL Server Engine       | Linux                                   | Linux    |
| <a id=4796384>[4796384](#4796384)</a> | Fixed an issue in SQL Server on Linux that prevents Active Directory logins from working when the keytab is updated after the privileged user password is rotated.                                                         | SQL Server Engine       | Linux                                   | Linux    |
| <a id=4809134>[4809134](#4809134)</a> | Fixes an issue that causes SQL Server Configuration Manager (SSCM) to stop responding when importing a certificate.                                                                                                        | SQL Server Client Tools | SQL Server Configuration Manager        | Windows  |
| <a id=4814064>[4814064](#4814064)</a> | Fixes an issue during a Daylight Saving Time "Fall Back" in which timestamps may have an incorrect time zone.                                                                                                                | SQL Server Engine       | LibOS                                   | Linux    |
| <a id=4814070>[4814070](#4814070)</a> | SQL Server 2025 can now be registered on Linux containers by setting the MSSQL_PID environment variable to StandardDeveloper or EnterpriseDeveloper.                                                                       | SQL Setup               | Linux                                   | Linux    |
| <a id=4818774>[4818774](#4818774)</a> | Fixes an issue in which VDI restore operations on Linux containers can run out of memory unexpectedly if memory is limited by a Linux cgroup.                                                                              | SQL Server Engine       | Linux                                   | Linux    |
| <a id=4836615>[4836615](#4836615)</a> | Restricts the privilege for dbcc stackdump so that only the sysadmin can invoke the dump file.                                                                                                                             | SQL Server Engine       | Security Infrastructure                 | All      |
| <a id=4860665>[4860665](#4860665)</a> | Enables creating or restoring the database by using a listener for Container Availability Group Connection. This feature lets Contained AG users create and restore the database without a connection to the SQL instance. | SQL Server Engine       | High Availability and Disaster Recovery | All      |
| <a id=4861315>[4861315](#4861315)</a> | If traceflag 15918 is enabled by using DBCC TRACEON on a SQL Server instance by having startup traceflag 15923 enabled, this configuration might cause the SQL Server process to stop responding.                          | SQL Server Engine       | Resource Governor                       | All      |
| <a id=4861456>[4861456](#4861456)</a> | Adds an information message in the error log if the deprecated lightweight pooling configuration is enabled.                                                                                                               | SQL Server Engine       | SQL OS                                  | Windows  |
| <a id=4866542>[4866542](#4866542)</a> | Removes `.rtf` from full-text system DMVs on the Linux platform. This document type was previously incorrectly reported as supported.                                                                                      | SQL Server Engine       | Search                                  | Linux    |
| <a id=4866716>[4866716](#4866716)</a> | Allows the use of sys.fn_xe_file_target_read_file() function to read the system_health event session data in Azure SQL Managed Instance.                                                                                   | SQL Server Engine       | SQL OS                                  | Windows  |
| <a id=4873449>[4873449](#4873449)</a> | Fixes an issue in which creating a full‑text index on a .docx file produced incorrect results if a paragraph began with a hyperlink and the preceding paragraph did not contain trailing whitespace.                       | SQL Server Engine       | Search                                  | All      |

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2025 now](https://www.microsoft.com/en-us/download/details.aspx?id=108529)

> [!NOTE]
>
> - Microsoft Download Center always offers the latest SQL Server 2025 CU release.
> - If the download page doesn't appear, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support) to obtain the cumulative update package.

</details>

<details>
<summary><b>How to obtain or download this cumulative update package for Windows from Microsoft Update Catalog</b></summary>

The following update is available from the Microsoft Update Catalog:

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2025 CU1 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5074901)

> [!NOTE]
>
> - [Microsoft Update Catalog](https://www.catalog.update.microsoft.com/Search.aspx?q=sql%20server%202025) contains this SQL Server 2025 CU and previously released SQL Server 2025 CU releases.
> - This CU is also available through Windows Server Update Services (WSUS).
> - We recommend that you always install the latest cumulative update that is available.

</details>

<details>
<summary><b>How to obtain or download the latest cumulative update package for Linux</b></summary>

To update SQL Server 2025 on Linux to the latest CU, you must first have the [Cumulative Update repository configured](/sql/linux/sql-server-linux-setup#repositories). Then, update your SQL Server packages by using the appropriate platform-specific update command.

For installation instructions and direct links to the CU package downloads, see the [SQL Server 2025 Release Notes](/sql/linux/sql-server-linux-release-notes-2025).

</details>

## File information

<details>
<summary><b>File hash information</b></summary>

You can verify the download by computing the hash of the _SQLServer2025-KB5074901-x64.exe_ file through the following command:

`certutil -hashfile SQLServer2025-KB5074901-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2025-KB5074901-x64.exe | A25604D3733CFD0DAD9C7BDA5AFCC81755372FC4CA081ACF0D1076C4881D54D3 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5074901](https://download.microsoft.com/download/85e8b2cf-3981-4c62-b711-a812b4057503/KB5074901.csv).

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
    > If you enabled Always On together with the **SSISDB** catalog, see the [information about SSIS with Always On](https://techcommunity.microsoft.com/t5/sql-server-integration-services/ssis-with-alwayson/ba-p/388091) for information about how to apply an update in these environments.

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
