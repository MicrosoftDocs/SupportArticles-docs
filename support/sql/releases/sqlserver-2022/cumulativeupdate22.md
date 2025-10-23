---
title: Cumulative update 22 for SQL Server 2022 (KB5068450)
description: This article contains the summary, known issues, improvements, fixes, and other information for SQL Server 2022 cumulative update 22 (KB5068450).
ms.date: 10/23/2025
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5068450
ms.reviewer: v-qianli2
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---

# KB5068450 - Cumulative Update 22 for SQL Server 2022

_Release Date:_ &nbsp; November 13, 2025  
_Version:_ &nbsp; 16.0.4225.1

## Summary

This article describes Cumulative Update package 22 (CU22) for Microsoft SQL Server 2022. This update contains 29 [fixes](#improvements-and-fixes-included-in-this-update) that were issued after the release of SQL Server 2022 Cumulative Update 21 and it updates components in the following builds:

- SQL Server - Product version: **16.0.4225.1**, file version: **2022.160.4225.1**
- Analysis Services - Product version: **16.0.43.252**, file version: **2022.160.43.252**

## Known issues in this update

### Incorrect behavior of SESSION_CONTEXT in parallel plans

[!INCLUDE [av-sesssion-context](../includes/av-sesssion-context.md)]

## Improvements and fixes included in this update

A downloadable Excel workbook that contains a summary list of builds, together with their current support lifecycle, is available. The Excel file also contains detailed fix lists for SQL Server 2022, SQL Server 2019, and SQL Server 2017. [Select to download this Excel file now](https://aka.ms/sqlserverbuilds).

> [!NOTE]
> Individual entries in the following table can be referenced directly through a bookmark. If you select any bug reference ID in the table, a bookmark tag is added to the URL by using the "#NNNNNNN" format. You can then share this URL with others so that they can jump directly to the desired fix in the table.

For more information about the bugs that are fixed and enhancements that are included in this cumulative update, see the following table:

| Bug reference | Description| Fix area| Component | Platform |
|-------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------|-------------------------------------------|----------|
|<a id=4433544>[4433544](#4433544) </a> | Fixes an issue in which running the `TRUNCATE TABLE WITH PARTITIONS` statement on a table with non-aligned partitions succeeds unexpectedly and causes corruption. | SQL Server Engine | DB Management | All|
|<a id=4145424>[4145424](#4145424) </a> | 	Fixes an assertion dump issue on the primary replica of an availability group related to the expression "!(uaeUnused != prev && trace->Elements[prev].ThreadId == trace->Elements[curr].ThreadId) \|\| (trace->Elements[prev].Value <= value)."| SQL Server Engine | High Availability and Disaster Recovery | All|
|<a id=4419880>[4419880](#4419880) </a> | 	Fixes a SQL injection vulnerability in a system stored procedure.| SQL Server Engine | High Availability and Disaster Recovery | All|
|<a id=4311157>[4311157](#4311157) </a> | Fixes a SQL Server on Linux termination issue that you might encounter when trying to send encrypted TLS/SSL data to a peer after receiving an alert such as `bad_record_mac` from the peer. | SQL Server Engine | Linux | Linux|
|<a id=4419716>[4419716](#4419716) </a> | 	Fixes a SQL injection vulnerability in a system stored procedure.| SQL Server Engine | Metadata| All|
|<a id=4229256>[4229256](#4229256) </a> | Fixes an issue in which DMVs are used in specific scenarios to inspect the text of statements that are running in other sessions and might contain sensitive data. | SQL Server Engine | Programmability | All|
|<a id=4268984>[4268984](#4268984) </a> | Fixes an access violation dump issue that you encounter in `ACCESS_VIOLATION_c0000005_sqllang.dll!CScaOp_Intrinsic::FConvertToText_Intrinsic` when executing queries that use the TRIM intrinsic.| SQL Server Engine | Programmability | All|
|<a id=4410919>[4410919](#4410919) </a> | Fixes an issue in which the `TRY_CONVERT` function might cause invalid results when the plan uses the **Clustered Index Seek** operator. | SQL Server Engine | Query Optimizer | All|
|<a id=4441901>[4441901](#4441901) </a> | Fixes an issue in which the change tracking auto cleanup process blocks the user triggered `ALTER TABLE` column-level DDL (`ADD/DROP/ALTER COLUMN`) operations.| SQL Server Engine | Replication | All|
|<a id=4524294>[4524294](#4524294) </a> | Fixes an issue in which adding a merge agent fails and throws out the following error when the subscription uses a non-default port: </br></br>Msg 2560, Level 16, State 9, Procedure distribution.sys.sp_MSadd_merge_agent, Line \<LineNumber> [Batch Start Line 3]</br>Parameter 2 is incorrect for this DBCC statement. | SQL Server Engine | Replication | Windows|
|<a id=4424573>[4424573](#4424573) </a> | 	Prevents logins with the `ALTER ANY LOGIN` permission from resetting the passwords of logins that have `ALTER ANY LOGIN` or `IMPERSONATE ANY LOGIN` permissions to avoid elevation of privilege. | SQL Server Engine | Security Infrastructure | All|
|<a id=4520174>[4520174](#4520174) </a> | Fixes an access violation that you encounter when running `sp_describe_first_result_set` on `sys.database_ledger_digest_locations`.| SQL Server Engine | Security Infrastructure | All|
|<a id=4437734>[4437734](#4437734) </a> | 	Prevents elevation of privilege by running SQL Agent job steps for built-in jobs with reduced permissions. | SQL Server Engine | SQL Agent | All|
|<a id=4285469>[4285469](#4285469) </a> | Fixes a vulnerability that lets users who have access to certain stored procedures perform SQL injection and run arbitrary code by using elevated privileges.| SQL Server Engine | SQL Server Engine | All|
|<a id=4448818>[4448818](#4448818) </a> | Fixes URLs in certain error messages (for example, error 14130 and error 14131). | SQL Server Engine | SQL Server Engine | All|
|<a id=2693201>[2693201](#2693201) </a> | Fixes an issue in which the log files shrink beyond the specified target size under certain operations when you run the `DBCC SHRINKFILE` command. | SQL Server Engine | Storage Management| All|

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

|File name|SHA256 hash|
|---------|---------|
|SQLServer2022-KB5068450-x64.exe| 1020E8C8EEBFDE14D5253ECC216FB9F49B08692E989155C0D9E007F31FF41CA8 |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

<!-- TODO: replace with ESRP link when available -->
Download [the list of files that are included in KB5068450](https://microsoft-my.sharepoint.com/:x:/p/v-shaywood/IQBm9PSP9edkQKJ6dd9dkvxqASh32wk4ogcqEiYmxUrq3Jc?e=VbsnZq).

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
