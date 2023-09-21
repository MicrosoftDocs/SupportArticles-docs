---
title: Troubleshoot common SQL Server cumulative update (CU) installation issues
description: This article helps you troubleshoot common SQL Server cumulative update issues.
ms.reviewer: jopilov, v-jayaramanp
ms.date: 07/28/2023
ms.custom: sap:Connection Issues
---

# Troubleshoot common SQL Server Cumulative Update installation issues

This article provides general steps to troubleshoot issues that you might experience when you apply a Cumulative Update (CU) or Service Pack (SP) to your Microsoft SQL Server instance. It also provides information on how to resolve the following error messages or conditions:

- `Wait on Database Engine recovery handle failed` message and errors [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) when you run upgrade scripts.
- Setup errors that occur because of missing MSI or MSP (update) files in the Windows Installer cache.
- `The Database Engine system data directory in the registry is not valid` or `the User Log directory in the registry is not valid` messages.
- `Network path was not found` and other error messages that you receive if Remote Registry Service or admin shares are disabled on an Always On Failover Cluster instance (FCI) or Always On Availability Groups.

## Cumulative update and service pack installation information

This section provides information about CU and SP installations.

- For Microsoft SQL Server 2016 and earlier versions:
  - Before you install a CU, make sure that your SQL Server instance is at the right SP level for that CU. For example, you can't apply CU17 for SQL 2016 SP2 before you apply SP2 for the SQL Server 2016 instance.
  - You can always apply the latest CU for a given SP baseline without having to apply previous CUs for that service pack. For example, to apply CU17 for SQL Server 2016 SP2 instance, you can skip applying previous updates to CU14, CU15, and CU16, if they aren't installed, and apply CU17 directly.
- For Microsoft SQL Server 2017 and later versions, you can always apply the latest CU that's available. (No service packs exist for SQL Server 2017 and later versions.)
- Before you apply a CU or SP, make sure that the instance that you're updating is correctly installed. The SQL Server program files and data files can't be installed on:  
  - A removable disk drive.
  - A file system that uses compression.
  - A directory in which system files are located.
  - Shared drives on a failover cluster instance.

- If you add a [database engine feature](/sql/database-engine/install-windows/install-sql-server-database-engine) after you apply a CU or an SP to an instance, you should update the new feature to the same level as the program instance before you apply any new CUs or SPs.

## General troubleshooting methodology

Isolate the error by following these steps:

   1. Select **Details** from the setup process's **Failure** screen.
   1. In the *%programfiles%\Microsoft SQL Server\nnn\Setup Bootstrap\Log* folder, check *Summary.txt* under the *Product features discovered* section to determine whether any of the listed features report a failure. If they do, you can focus on resolving problems that affect that feature.
   1. Go to the subfolder that's named *yyyyMMdd_HHmmss* (for example *20220618_174947*) that corresponds to the reported failure time that you are focusing on. The goal is to examine the feature-specific files, ERRORLOG files, and *Details.txt* file, if necessary.
   1. Go to the \MSSQLSERVER subfolder, and locate the log files that are specific to the feature that failed. For example, *sql_engine_core_inst_Cpu64_1.log*. For upgrade script failures, check the *SQLServer_ERRORLOG_date_time.txt* files that correspond to the time of the upgrade failure.
   1. Open the *Details.txt* log file, and search on the keyword "Failed." Not every failure is considered critical.

For more information, see [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files).

In the next few sections, check for a scenario that corresponds to your situation, and then follow the associated troubleshooting steps.
If there's no matching scenario, look for more pointers in the log files.

## Errors 912 and 3417 and "Wait on Database Engine recovery handle failed"

T-SQL upgrade scripts are shipped together with every SQL Server cumulative update. They're run after the SQL Server binaries are replaced with the latest versions. If these T-SQL scripts don't run for some reason, the Setup program reports a "Wait on Database Engine recovery handle failed" error. Setup records errors [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) in the latest SQL Server error log. Errors 912 and 3417 are associated with database script upgrade failures and failure to recover the `master` database, respectively. The messages that precede error 912 usually provide information about the root cause of the failure that occurred when the upgrade scripts were run.

There could be a variety of errors raised together with 912 and 3417. For more information about a summary of common scenarios and related solutions, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Setup errors caused by missing installer files in Windows cache

Applications such as SQL Server that use Windows Installer technology for the setup process will store critical files in the Windows Installer cache. The default installer cache location is *C:\Windows\Installer*. These files are required for uninstalling and updating applications. They're unique to that computer. Updates to applications that depend on these files won't work if they're accidentally deleted or otherwise compromised. To resolve this condition, use one of the following methods that are described in [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md):

- Repair the SQL Server installation.
- Use the [FixMissingMSI tool](https://github.com/suyouquan/SQLSetupTools/releases/).
- Use the [FindSQLInstalls.vbs script](https://raw.githubusercontent.com/suyouquan/SQLSetupTools/master/FixMissingMSI/FindSQLInstalls.vbs).
- Manually restore the files.
- Restore files from the system state backups.
- Review and implement the procedures that are described in [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md).

## Setup fails because of incorrect data or log location in registry

When you install a CU or SP, if the default data and log folders are invalid, you may receive errors that resemble the following messages:

> "The User Data directory in the registry is not valid. Verify DefaultData key under the instance hive points to a valid directory."

> "The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory."

> "Error installing SQL Server Database Engine Services Instance Features. The Database Engine system data directory in the registry is not valid."

To fix this issue, follow these steps:

1. Connect to the SQL Server instance by using SQL Server Management Studio (SSMS).
1. Right-click the SQL Server instance in the **Object Explorer** and select **Properties** > **Database Settings**.
1. Under **Database Default locations**, make sure that the folders in **Data** and **Log** are correct.
1. In the SQL Server Configuration Manager, select **SQL Server Services**, double-click the affected SQL Server Service, select the **Advanced** tab, and make sure the value of **Data Path** is correct. The value is grayed out and can't be modified. However, if you want to correct it, follow **Method 2** in [Error that Data or Log directory in the registry is not valid when installing SQL Server Cumulative Update or a Service Pack](user-data-log-directory-invalid.md#method-2-use-registry-editor) to modify the **SQLDataRoot** registry entry.
1. Retry the CU or SP installation.

## Misconfigured Windows Server Failover Clustering (WSFC) nodes

For smooth functioning and maintenance of a SQL Server Failover Cluster Instance (FCI), follow the best practices described in [Before Installing Failover Clustering](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering) and [Failover Cluster Instance administration & maintenance](/sql/sql-server/failover-clusters/windows/failover-cluster-instance-administration-and-maintenance). If you experience errors when you apply a CU or an SP, check the following conditions:

- Make sure that the **Remote Registry** service is active and running on all nodes of the WSFC cluster.
- If the service account for SQL Server isn't an administrator in your Windows cluster, make sure that administrative shares (C$ and so on) are enabled on all of the nodes. For more information, see [Overview of problems that may occur when administrative shares are missing](../../../../windows-server/networking/problems-administrative-shares-missing.md). If these shares aren't configured correctly, you might notice one or more of the following symptoms when you try to install a CU or SP:
  - The update takes a long time to run or doesn't respond. Setup logs don't reveal any progress.
  - Setup logs contain messages such as the following:  
     > `The network path was not found.`
     > `System.UnauthorizedAccessException: Attempted to perform an unauthorized operation.`

## Additional information

- For a complete list of currently available updates for your SQL Server version and download locations, see [Determine the version, edition, and update level - SQL Server](../../../releases/download-and-install-latest-updates.md).
- For more information about supportability and servicing timelines for your SQL Server version, see [Microsoft Product Lifecycle Page](/lifecycle/products/?terms=sql).
- For information about servicing models for different versions of SQL Server, see [Incremental Servicing Model for SQL Server Updates](https://support.microsoft.com/topic/an-incremental-servicing-model-is-available-from-the-sql-server-team-to-deliver-hotfixes-for-reported-problems-6209f7b4-20a5-1a45-5042-5df411263e8b) and [Modern Servicing Model for SQL 2017 and later versions](/archive/blogs/sqlreleaseservices/announcing-the-modern-servicing-model-for-sql-server).
- For general information about how to update SQL Server, see [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates).
- For information about security updates for SQL Server and other products, see [Security Update Guide](https://msrc.microsoft.com/update-guide).
- For information about the standard terminology that's associated with Microsoft updates, see [Description of the standard terminology that is used to describe Microsoft software updates](/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server).
- To resolve setup issues that might occur in highly secure environments, see [SQL Server installation fails if the Setup account doesn't have certain user rights](installation-fails-if-remove-user-right.md).
