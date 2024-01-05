---
title: Cumulative update 11 for SQL Server 2022 (KB5032679)
description: This article contains the summary, known issues, improvements, fixes and other information for SQL Server 2022 cumulative update 11 (KB5032679).
ms.date: 01/11/2024
ms.custom: KB5032679
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
- Analysis Services - Product version: , file version:
## Known issues in this update

There are no known issues in this cumulative update.

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
| <a id=2744933>[2744933](#2744933) </a> | Fixes a non-yielding scheduler dump issue with `sqldk!SOS_Node::SpreadMultipleTasksAcrossNodes` that you encounter when running an instance on hardware that has more than 64 logical processors per NUMA node. After applying the fix, SQL Server detects servers that have more than 64 logical processors per NUMA node at startup.| SQL Server Engine| SQL OS| All|
| <a id=2782340>[2782340](#2782340) </a> | Fixes a "Stalled Resource Monitor" dump issue that you might encounter after out-of-memory (OOM) exceptions are raised, such as error 701.| SQL Server Engine| SQL OS| All|
| <a id=2724957>[2724957](#2724957) </a> | Fixes an issue in which the setup might fail to add the `SQL_SNAC_SDK` feature when you install SQL Server if the machine has a later version of the `SQL_SNAC_CORE` feature in *msoledbsql.msi* installed than that of the SQL Server installation media. After applying the fix, SQL Server Setup detects this condition, and it will block a new installation and prevent a failure during the installation. </br></br>**Note**: To work around this issue and unblock SQL Server Setup, go to **Uninstall or change a program** in the Control Panel, select **Microsoft OLE DB Driver for SQL Server**, and then select **Change** to install all features in **Microsoft OLE DB Driver for SQL Server Setup**. Rerun SQL Server Setup when it's finished. | SQL Setup| Deployment Platform | Windows|

## How to obtain or download this or the latest cumulative update package

<details>
<summary><b>How to obtain or download the latest cumulative update package for Windows (recommended)</b></summary>

The following update is available from the Microsoft Download Center:

:::image type="icon" source="../media/download-icon.png" border="false"::: [Download the latest cumulative update package for SQL Server 2022 now](https://www.microsoft.com/download/details.aspx?familyid=4fa9aa71-05f4-40ef-bc55-606ac00479b1)

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
|SQLServer2022-KB5032679-x64.exe| |

</details>

<details>
<summary><b>Cumulative Update package file information</b></summary>

The English version of this package has the file attributes (or later file attributes) that are listed in the following table. The dates and times for these files are listed in Coordinated Universal Time (UTC). When you view the file information, it's converted to local time. To find the difference between UTC and local time, use the **Time Zone** tab in the **Date and Time** item in Control Panel.

x64-based versions

SQL Server 2022 Analysis Services

SQL Server 2022 Database Services Common Core

SQL Server 2022 Data Quality Client

SQL Server 2022 Data Quality

SQL Server 2022 Database Services Core Instance

SQL Server 2022 Database Services Core Shared

SQL Server 2022 sql_extensibility

SQL Server 2022 Full-Text Engine

SQL Server 2022 Integration Services

SQL Server 2022 sql_polybase_core_inst

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

