---
title: Troubleshoot common SQL Server cumulative update (CU) installation issues
description: This article helps you troubleshoot common SQL Server cumulative update issues.
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: pijocoder
ms.date: 12/07/2022
ms.prod: sql
ms.topic: troubleshooting
ms.custom: sap:Connection Issues
---

# Troubleshoot common SQL Server cumulative update (CU) installation issues

This article provides general steps to troubleshoot issues that you may experience when you apply a cumulative update (CU) or service pack (SP) to your Microsoft SQL Server instance. It also provides details for solving the following error messages or conditions that are associated with updating:

- `Wait on Database Engine recovery handle failed` message and errors [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) when you run upgrade scripts.
- Setup errors that occur because of missing MSI or MSP (update) files in the Windows Installer cache.
- `The Database Engine system data directory in the registry is not valid` or `the User Log directory in the registry is not valid` messages.
- `Network path was not found` and other error messages that you receive if Remote Registry Service or admin shares are disabled on an Always On Failover Cluster instance (FCI) or Always On Availability Groups.

## Cumulative update and service pack installation information

This section provides information about CU and SP installations.

- For Microsoft SQL Server 2016 and earlier versions:
  - Before you install a CU, make sure that your SQL Server instance is at the right SP level for that CU. For example, you can't apply CU17 for SQL 2016 SP2 before you apply SP2 for the SQL Server 2016 instance.
  - You can always apply the latest CU for a given SP baseline without having to apply previous CUs for that service pack. For example, to apply CU17 for SQL Server 2016 SP2 instance, you can skip applying to CU14, CU15, and CU16, if they aren't installed, and apply CU17 directly.
- For Microsoft SQL Server 2017 and later versions, you can always apply the latest CU that's available. (No service packs exist for SQL Server 2017 and later versions.)
- Before you apply a CU or SP, make sure that the instance that you're updating is correctly installed. The SQL Server program files and data files can't be installed on:  
   - A removable disk drive
   - A file system that uses compression
   - A directory in which system files are located
   - Shared drives on a failover cluster instance

- If you add a [database engine feature](/sql/database-engine/install-windows/install-sql-server-database-engine) after you apply a CU or an SP to an instance, you should update the new feature to the same level as the program instance before you apply any new CUs or SPs.

## General troubleshooting methodology

Isolate the error by following these steps:

   1. On the **Failure** screen of the setup process, select **Details**.
   1. In the *%programfiles%\Microsoft SQL Server\nnn\Setup Bootstrap\Log* folder, check *Summary.txt* under the *Product features discovered* section to determine whether any of the listed features report a failure. If they do, you can focus on resolving issues that affect that feature.
   1. Go to the subfolder that's named *yyyyMMdd_HHmmss* (for example *20220618_174947*) that corresponds to the reported failure time that you're focusing on. The goal is to examine the feature-specific files, ERRORLOG files, and *Details.txt* file, as necessary.
   1. Go to the \MSSQLSERVER subfolder, and locate the log files that are specific to the feature that failed. For example, *sql_engine_core_inst_Cpu64_1.log*. For upgrade script failures, examine the *SQLServer_ERRORLOG_date_time.txt* files that correspond to the time of the upgrade failure.
   1. Open the *Details.txt* log file, and search on the keyword "Failed." Not every failure is considered critical.
   
For more information, see [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files?view=sql-server-ver15&preserve-view=true).

In the next few sections, check for a scenario that corresponds to your situation, and then follow the associated troubleshooting steps.
If there's no matching scenario, look for more pointers in the log files.

## Errors 912 and 3417 and "Wait on Database Engine recovery handle failed"

T-SQL upgrade scripts are shipped together with every SQL Server cumulative update. They're run after the SQL Server binaries are replaced with the latest versions. If these T-SQL scripts don't run for some reason, the Setup program reports a "Wait on Database Engine recovery handle failed" error in the error details section. Setup records errors [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) in the latest SQL Server error log. Errors 912 and 3417 are associated with database script upgrade failures and failure to recover the master database, respectively. The messages that precede error 912 usually provide information about the root cause of the failure that occurred when the upgrade scripts were run.

To troubleshoot and fix these errors, follow these steps:

1. Review the SQL Server error logs (ERRORLOG) for details about the failure.
1. To bypass running the upgrade script, start SQL Server by using [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. Address the cause of the failure based on different scenarios.

The following scenarios list some of the common causes of upgrade script failures and their corresponding resolutions.

### `SSISDB` catalog database part of an availability group (AG)

If your SQL Server Integration Services catalog database (SSISDB) was added to an Always ON availability group (AG), script upgrade can fail. For more information, see the [Upgrading SSISDB in an availability group](/sql/integration-services/catalog/ssis-catalog#Upgrade) section. To resolve this problem:

1. Remove `SSISDB` from the AG.
1. Run the CU upgrade.
1. After the upgrade finishes, restore `SSISDB` to the Always On availability group.

### Misconfigured System user/role in `msdb` database

This section provides steps to resolve a misconfigured system user or role in the `msdb` database.

#### `TargetServersRole` schema and security role

These are used in multi-server environments. By default, the *TargetServersRole* security role is owned by the *dbo*, and the role owns the *TargetServersRole* schema. If you inadvertently change this association, and the update that you're installing includes changes to either of these roles, the upgrade might fail and return error ID 2714: `There is already an object named 'TargetServersRole' in the database.` To resolve this error, follow these steps after you start SQL Server trace flag `902`:

1. Stop and restart SQL Server by using [T902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).

   **For a default instance:**

   ```console
   NET START MSSQLSERVER /T902 
   ```

   **For named instances:**

   ```console
   NET START MSSQL$INSTANCENAME  /T902
   ```

1. Back up your `msdb` database.

   ```sql
   BACKUP DATABASE msdb to disk = '<backup folder>'
   ```

1. Make a list of users (if any) that are currently part of this role.
1. Drop the *TargetServersRole* role by using the following statement:

      ```sql
      EXECUTE msdb.dbo.sp_droprole @rolename = N'TargetServersRole'
      ```

1. To check whether the issue is resolved, restart the SQL Server instance without using trace flag `902`.
1. Restore the users from step 2 to *TargetServersRole*.

#### Certificate-based principals that own user objects

Principals that are enclosed by double hash marks (##) are created from certificates when SQL Server is installed. These are to be treated as system-created principals. They mustn't be mapped to database principals who own user objects in `msdb` or other databases. If the error logs indicate a failure that's related to any of these logins, follow these steps:

1. Start SQL Server by using [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. Change the ownership of the affected objects to a different user.
1. Restart SQL Server without trace flag `902` so that the upgrade script can finish running.

  > [!NOTE]  
  > Although a failure to run upgrade scripts is one of the common causes of the "Wait on Database Engine recovery handle failed" error, this error can also occur for other reasons. The error means that the update installer couldn't start the service or bring it online after the update was installed. In either case, troubleshooting involves a review of error logs and Setup logs to determine the cause of the failure and take appropriate action.

## Setup errors caused by missing installer files in Windows cache

Applications such as SQL Server that use Windows Installer technology for the setup process will store critical files in the Windows Installer cache. The default installer cache location is *C:\Windows\Installer*. These files are required for uninstalling and updating applications. They're unique to that computer. If these files are either inadvertently deleted or otherwise compromised, application updates that require these files will fail. To resolve this condition, use one of the following methods that are detailed in [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md):

- Repair the SQL Server installation.
- Use the [FixMissingMSI tool](https://github.com/suyouquan/SQLSetupTools/releases/).
- Use the [FindSQLInstalls.vbs script](https://raw.githubusercontent.com/suyouquan/SQLSetupTools/master/FixMissingMSI/FindSQLInstalls.vbs).
- Manually restore the files.
- Restore files from system state backups.
- Review and implement the procedures that are described in [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md).

## Setup fails because of incorrect data or log location in registry

The default database and log file paths that you specify during installation are saved in the registry at *HKEY_LOCAL_MACHINE\HKLM\Software\Microsoft\MicrosoftSQL Server\MSSQL{nn}.MyInstance*. When you install a CU or SP, these locations are validated by the Setup process. If the validation fails, you might receive errors that resemble the following messages:

- `Error installing SQL Server Database Engine Services Instance Features. The Database Engine system data directory in the registry is not valid.`
- `The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory.`

To fix this issue, follow these steps:

1. Connect to the SQL Server instance by using SQL Server Management Studio (SSMS).
1. Right-click on SQL Server instance in the Object Browser and choose **Properties**, and select **Database Settings** page on the left side.
1. Under **Database Default locations**, make sure that `Data` and `Log` are the correct folders.
1. Retry the CU or SP installation.

## Misconfigured Windows Server Failover Clustering (WSFC) nodes

For smooth functioning and maintenance of a SQL Server Failover Cluster Instance (FCI), follow the best practices that are described in [Before Installing Failover Clustering](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering?view=sql-server-ver15&preserve-view=true) and [Failover Cluster Instance administration & maintenance](/sql/sql-server/failover-clusters/windows/failover-cluster-instance-administration-and-maintenance?view=sql-server-ver15&preserve-view=true). If you experience errors when you apply a CU or an SP, check the following conditions:

1. Make sure that the **Remote Registry** service is active and running on all nodes of the WSFC cluster.
1. If the service account for SQL Server isn't an administrator in your Windows cluster, make sure that administrative shares (C$ and so on) are enabled on all the nodes. For more information, see [Overview of problems that may occur when administrative shares are missing](../../windows-server/networking/problems-administrative-shares-missing.md). If these shares aren't configured correctly, you might notice one or more of the following symptoms when you try to install a CU or SP:
   - The update takes a long time to run or doesn't respond. Setup logs don't reveal any progress.
   - Setup logs contain messages such as the following:  
      - `The network path was not found.`
      - `System.UnauthorizedAccessException: Attempted to perform an unauthorized operation.`

## Additional information

- For a complete list of currently available updates for your SQL Server version and download locations, see [Determine the version, edition, and update level - SQL Server](../releases/download-and-install-latest-updates.md).
- For more information about supportability and servicing timelines for your SQL Server version, see [Microsoft Product Lifecycle Page](/lifecycle/products/?terms=sql).
- For information about servicing models for different versions of SQL Server, see [Incremental Servicing Model for SQL Server Updates](https://support.microsoft.com/topic/an-incremental-servicing-model-is-available-from-the-sql-server-team-to-deliver-hotfixes-for-reported-problems-6209f7b4-20a5-1a45-5042-5df411263e8b) and [Modern Servicing Model for SQL 2017 and later versions](/archive/blogs/sqlreleaseservices/announcing-the-modern-servicing-model-for-sql-server).
- For general information about how to update SQL Server, see [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates?view=sql-server-ver15&preserve-view=true).
- For information about security updates for SQL Server and other products, see the [Security Update Guide](https://msrc.microsoft.com/update-guide).
- For information about the standard terminology that's associated with Microsoft updates, see [Description of the standard terminology that is used to describe Microsoft software updates](/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server?view=sql-server-ver15&preserve-view=true).
- To resolve setup issues that might occur in highly secure environments, see [SQL Server installation fails if the Setup account doesn't have certain user rights](installation-fails-if-remove-user-right.md).
