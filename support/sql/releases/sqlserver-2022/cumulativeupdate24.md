---
title: Cumulative Update 24 for SQL Server 2022 (KB5080999)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 Cumulative Update 24 (KB5080999).
ms.date: 04/10/2026
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5080999
ms.reviewer: v-shaywood
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5080999 - Cumulative Update 24 for SQL Server 2022

_Release Date:_ &nbsp; March 12, 2026  
_Version:_ &nbsp; 16.0.4245.2  

## Summary

This article describes Cumulative Update package 24 (CU24) for Microsoft SQL Server 2022. This update contains 14 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 23. It updates components in the following builds:

- SQL Server - Product version: **16.0.4245.2**, file version: **2022.160.4245.2**
- Analysis Services - Product version: **16.0.43.252**, file version: **2022.160.43.252**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-session-context](../includes/av-sesssion-context.md)]

### Availability group listener record error 10013 in error log

If you have a SQL Server availability group configured with a listener, when the SQL Server service starts or an availability group failover occurs, you might see errors in the SQL Server error log that indicate a problem with the listener object. The following example shows what these errors look like:

```output
The Service Broker endpoint is in disabled or stopped state.
Error: 26075, Severity: 16, State: 1.
Failed to start a listener for virtual network name '<YourAGListener>'. Error: 10013.
The Service Broker endpoint is in disabled or stopped state.
Stopped listening on listener network name '<YourAGListener>' (VNN or DISTRIBUTED_NETWORK_NAME). No user action is required.
The Service Broker endpoint is in disabled or stopped state.
Error: 10800, Severity: 16, State: 1.
The listener for the WSFC resource '<YourWSFCguid>' failed to start, and returned error code 10013, 'An attempt was made to access a socket in a way forbidden by its access permissions. '. For more information about this error code, see "System Error Codes" in the Windows Development Documentation.
Error: 19452, Severity: 16, State: 1.
The availability group listener (network name) with Windows Server Failover Clustering resource ID '<YourWSFCguid>', DNS name '<YourAGListener>', port 1433 failed to start with a permanent error: 10013. Verify port numbers, DNS names and other related network configuration, then retry the operation.
```

Additionally, after you apply this update, if you create a new listener, you might see an error that resembles the following example:

```output
Msg 19486, Level 16, State 1, Line 3
The configuration changes to the availability group listener were completed, but the TCP provider of the instance of SQL Server failed to listen on the specified port [<YourAGListener>]. This TCP port is already in use. Reconfigure the availability group listener, specifying an available TCP port. For information about altering an availability group listener, see the "ALTER AVAILABILITY GROUP (Transact-SQL)" topic in SQL Server Books Online.
```

When SQL Server starts or a listener is created, a change in this update causes an attempt to open a TCP port that's already open. This attempt causes the errors to be logged but has no other known effect. Listener connections continue to work.

Microsoft is aware of this issue and is investigating a fix.

## Improvements and fixes included in this update

A downloadable Microsoft Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table.

| Bug reference                         | Description                                                                                                                                                                                                                                          | Fix Area          | Component                               | Platform |
| :------------------------------------ | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------- | :-------------------------------------- | :------- |
| <a id=4868211>[4868211](#4868211)</a> | Adds a new optional parameter, `@multi_subnet_failover`, to `sp_adddistributor`.                                                                                                                                                                     | SQL Server Engine | Replication                             | All      |
| <a id=4874339>[4874339](#4874339)</a> | Fixes an issue that occurs when creating or restoring a database on a contained availability group connection.                                                                                                                                       | SQL Server Engine | High Availability and Disaster Recovery | All      |
| <a id=4911747>[4911747](#4911747)</a> | Fixes an issue in the in-memory sort buffer calculation that causes an infinite loop when the required page count exceeds supported limits.                                                                                                          | SQL Server Engine | Backup Restore                          | All      |
| <a id=4917971>[4917971](#4917971)</a> | Fixes a floating point exception that occurs when switching from a Hekaton to a non-Hekaton stack. This action causes query execution to break.                                                                                                      | Hekaton           | Query Processing                        | All      |
| <a id=4931278>[4931278](#4931278)</a> | Fixes an issue in which a sort operation on a rowset that's larger than four billion rows fails and generates an assertion error.                                                                                                                    | SQL Server Engine | Access Methods                          | All      |
| <a id=4931830>[4931830](#4931830)</a> | Fixes an issue in which the distributor is part of an availability group (AG) and uses case-sensitive (_CS) collation. The distribution agent incorrectly uses the AG primary replica name instead of the AG listener name.                          | SQL Server Engine | Replication                             | All      |
| <a id=4953763>[4953763](#4953763)</a> | Fixes an issue in which the configure-only replica of a Contained Availability Group cannot be connected after a restart because of a startup failure.                                                                                               | SQL Server Engine | High Availability and Disaster Recovery | All      |
| <a id=4955136>[4955136](#4955136)</a> | Fixes an issue that occurs when using a local monitor server for Log Shipping and Contained Availability Group after failover.                                                                                                                       | SQL Server Engine | High Availability and Disaster Recovery | All      |
| <a id=4955493>[4955493](#4955493)</a> | Fixes a typo in `sys.dm_os_linux_disk_stats` by correcting `ios_in_progess` to `ios_in_progress`.                                                                                                                                                    | SQL Connectivity  | Linux                                   | Linux    |
| <a id=4976761>[4976761](#4976761)</a> | Fixes an issue in which altering a disabled DDL trigger causes a memory access violation.                                                                                                                                                            | SQL Server Engine | Programmability                         | All      |
| <a id=4984502>[4984502](#4984502)</a> | Adds a configurable full-text search batch timeout by using `sp_fulltext_service 'batch_timeout'`. Specify a value between one minute and one hour, in milliseconds. By default, batches time out after 10 minutes if there are no progress updates. | SQL Server Engine | Search                                  | All      |
| <a id=5005885>[5005885](#5005885)</a> | Addresses contention on security-related metadata tables by adding `sysowners` to frequently accessed metadata tables check.                                                                                                                         | SQL Server Engine | Security Infrastructure                 | All      |
| <a id=5011606>[5011606](#5011606)</a> | Adds support for symbolic links in the `getattribute` API.                                                                                                                                                                                           | SQL Server Engine | Linux                                   | Linux    |
| <a id=5011720>[5011720](#5011720)</a> | Adds a configuration option to add `Bulkadmin` operations to the allowlist.                                                                                                                                                                          | SQL Server Engine | Linux                                   | Linux    |

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

- :::image type="icon" source="../media/download-icon.png" border="false"::: [Download the cumulative update package for SQL Server 2022 CU24 now](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5080999)

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

You can verify the download by computing the hash of the _SQLServer2022-KB5080999-x64.exe_ file through the following command:

`certutil -hashfile SQLServer2022-KB5080999-x64.exe SHA256`

| File name                       | SHA256 hash                                                      |
| ------------------------------- | ---------------------------------------------------------------- |
| SQLServer2022-KB5080999-x64.exe | 57FC522E34FA4654F5EE8DBC9768EFE3265971C8D6854F32118022B2610D40E2 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

Download [the list of files that are included in KB5080999](https://download.microsoft.com/download/52480071-5ee7-427e-8e9e-4c5a440dfc53/KB5080999.csv).

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
