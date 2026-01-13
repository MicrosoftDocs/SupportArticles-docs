---
title: Cumulative Update 23 for SQL Server 2022 (KB5074819)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 Cumulative Update 23 (KB5074819).
ms.date: 01/15/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5074819
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5074819 - Cumulative Update 23 for SQL Server 2022

_Release Date:_ &nbsp; January 15, 2026  
_Version:_ &nbsp; 16.0.4235.2

## Summary

This article describes Cumulative Update package 23 (CU23) for Microsoft SQL Server 2022. This update contains 15 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 22. It updates components in the following builds:

- SQL Server - Product version: **16.0.4235.2**, file version: **2022.160.4235.2**
- Analysis Services - Product version: **16.0.43.252**, file version: **2022.160.43.252**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug reference                         | Description                                                                                                                                                                                                                   | Fix Area                         | Component                               | Platform |
| :------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------- | :-------------------------------------- | :------- |
| <a id=4676249>[4676249](#4676249)</a> | Fixes an issue in which backup log operations fail and return an error that indicates that `BACKUP LOG` is not allowed while the recovery model is `SIMPLE`.                                                                  | SQL Server Engine                | Backup Restore                          | Windows  |
| <a id=4710575>[4710575](#4710575)</a> | Fixes an AV assertion issue in `DbMgrPartner` that's related to new log readiness notifications.                                                                                                                              | SQL Server Engine                | High Availability and Disaster Recovery | All      |
| <a id=4769216>[4769216](#4769216)</a> | Fixes an issue in which non-yielding scheduler dump files are generated when SSL connections are closed under high CPU load.                                                                                                  | Conectivity                      | Protocols                               | All      |
| <a id=4783675>[4783675](#4783675)</a> | Fixes an issue in which upgrading from SQL Server 2019 to SQL Server 2022 might cause the upgrade process to stop responding during the model database upgrade phase.                                                         | SQL Server Engine                | Programmability                         | All      |
| <a id=4783748>[4783748](#4783748)</a> | Changes the behavior of the program to return error 19544 instead of returning an assert when you create an availability group that has a name that's longer than 64 characters by using `cluster_type = NONE` or `EXTERNAL`. | SQL Server Engine                | High Availability and Disaster Recovery | All      |
| <a id=4796333>[4796333](#4796333)</a> | Fixes an issue that causes crashes when an invalid ID type is returned from the Domain Controller in LookupAccountSid.                                                                                                        | SQL Server Engine                | Linux                                   | Linux    |
| <a id=4796376>[4796376](#4796376)</a> | Fixes an issue that prevents Active Directory logins from working if the keytab file is updated too long after the privileged user password is rotated.                                                                       | SQL Server Engine                | Linux                                   | Linux    |
| <a id=4798276>[4798276](#4798276)</a> | Fixes an issue in which Distributed Availability Group seeding fails if the local Availability Group is offline.                                                                                                              | SQL Server Engine                | High Availability and Disaster Recovery | Windows  |
| <a id=4807292>[4807292](#4807292)</a> | Fixes a failure to configure multiple concurrent auditing to write to the Security Event log during updates.                                                                                                                  | SQL Server Engine                | Security Infrastructure                 | All      |
| <a id=4811256>[4811256](#4811256)</a> | Fixes a crash that's caused by a missing partition in a common table expression (CTE).                                                                                                                                        | SQL Server Engine                | Programmability                         | All      |
| <a id=4818763>[4818763](#4818763)</a> | Fixes a bug that causes memory allocation failure during VDI restore operations if memory is limited through `cgroupsv2` on Linux.                                                                                            | SQL Server Engine                | Linux                                   | Linux    |
| <a id=4837925>[4837925](#4837925)</a> | Fixes an issue in which SSCM fails when it imports certain certificates, including self-signed certificates that are password protected and certificates exported from Azure AKV that are not password protected.             | SQL Server Configuration Manager | Certificate Import                      | Windows  |
| <a id=4838959>[4838959](#4838959)</a> | Restricts privileges for dbcc stackdump so that only the sysadmin can invoke the dump file.                                                                                                                                   | SQL Server Engine                | Security Infrastructure                 | All      |
| <a id=4849635>[4849635](#4849635)</a> | Fixes an issue in which AppDomains in a DOOMED state are not unloaded correctly.                                                                                                                                              | SQL Server Engine                | Query Execution                         | All      |
| <a id=4866387>[4866387](#4866387)</a> | Allows using the `sys.fn_xe_file_target_read_file()` function to read `system_health` event session data in Azure SQL Managed Instance.                                                                                       | SQL Server Engine                | SQL OS                                  | Windows  |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU23 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5074819)

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

You can verify the download by computing the hash of the _SQLServer2022-KB5074819-x64.exe_ file through the following command:

`certutil -hashfile SQLServer2022-KB5074819-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2022-KB5074819-x64.exe | 6DD251B27E916C80231B0278A799CA8AF7479461038A53254F7C906408425591 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5074819](https://download.microsoft.com/download/6c92fcb2-4e38-40c8-8fac-179e0b8914e6/KB5074819.csv).

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
