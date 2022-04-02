---
title: Troubleshoot common SQL Server Cumulative Update installation issues
description: This article helps you to troubleshoot common SQL Server update issues. 
ms.date: 03/28/2022
ms.custom: sap:Connection Issues
author: prmadhes-msft
ms.author: v-jayaramanp
ms.topic: troubleshooting
ms.prod: sql
---

# Troubleshoot common SQL Server Cumulative Update installation issues

This article provides general steps to troubleshoot issues that you may experience when you apply a cumulative update (CU) or service pack (SP) to your Microsoft SQL Server instance. It also provides details for solving the following error messages that are associated with updating:

- "Wait on Database Engine recovery handle failed" and errors [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) when you run upgrade scripts.
- Setup errors that occur because of missing MSI files or update files in the Windows Installer cache.
- "The Database Engine system data directory in the registry is not valid" or "the User Log directory in the registry is not valid."
- "Network path was not found" and other error messages that you receive if Remote Registry Service or admin shares are disabled on an Always On Failover Cluster instance (FCI) or Always On Availability Groups.

## Cumulative update and service pack installation information

This section provides information about CU and SP installations.

- For Microsoft SQL Server 2016 and earlier versions:
  - Before you install a CU, make sure that your SQL Server instance is at the right SP level for that CU. For example, you can't apply CU17 for SQL 2016 SP2 before you apply SP2 for the SQL Server 2016 instance.
  - You can always apply the latest CU for a given SP baseline without applying previous CUs for that service pack. For example, to apply CU17 for SQL Server 2016 SP2 instance, you can skip applying to CU14, CU15, and CU16 and go to CU17 directly.
- For Microsoft SQL Server 2017 and later versions, you can always apply the latest CU available (no service packs exist in SQL Server 2017 and later).
- Before you apply a CU or SP, make sure that the instance being updated meets the following requirement. The SQL Server program files and data files can't be installed on:
    - A removable disk drive
    - A file system that uses compression
    - A directory in which system files are located
    - Shared drives on a failover cluster instance
  
- If you add a new [database engine feature](/sql/database-engine/install-windows/install-sql-server-database-engine) after you apply a CU or an SP to an instance, you should update the new feature to the same level as the program instance before you apply any new CUs or SPs.

## General troubleshooting methodology

Isolate the error by following these steps:

   1. In the **Failure** screen of the setup process, select **Details**.
   1. In the *%programfiles%\Microsoft SQL Server\nnn\Setup Bootstrap\Log* folder, check *Summary.txt* and other default setup log files. For more information, see [View and Read SQL Server Setup Log Files](/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files?view=sql-server-ver15&preserve-view=true).

In the next few sections, check for a scenario that corresponds to your situation, and then follow the associated troubleshooting steps.
If there's no matching scenario, look for more pointers in the log files.

## "Wait on Database Engine recovery handle failed" and "912" and "3417" errors

Upgrade T-SQL scripts are shipped together with every SQL Server update. They are executed after the SQL Server binaries are upgraded. If these scripts don't run, for some reason, the Setup program reports a "Wait on Database Engine recovery handle failed" error in the error details section. It logs [912](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error) and [3417](/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error) errors in the latest SQL Server error log. Errors _912_ and _3417_ are generic errors that are associated with database script upgrade failures. The messages that precede the _912_ errors usually provide information about what exactly failed when these scripts were run.

To troubleshoot and fix these errors, follow these steps:

1. Review the SQL Server error logs for details about the failure.
1. Start SQL Server by using [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902) to bypass running the upgrade script.
1. Address the cause of the failure based on different scenarios.

The following errors are some of the common causes of upgrade script failures and their corresponding resolutions:

  - **SSISDB part of availability group**

    Remove the SQL Server Integration Services (SSIS) and Catalog database (SSISDB) from the availability group. After the upgrade finishes, restore SSISDB to the availability group. For more information, see the [Upgrading SSISDB in an availability group](/sql/integration-services/catalog/ssis-catalog?view=sql-server-ver15&preserve-view=true) section.

  - **Misconfigured System user/role in msdb database**

    This section provides steps to resolve a misconfigured system user or role in the **msdb** database:
    - **TargetServersRole Schema/Security role**: These are used in multi-server environments. By default, the *TargetServersRole* security role is owned by the *dbo*, and the role owns the *TargetServersRole* schema. If you inadvertently change this association, and the update that you're installing includes updates to either of these, setup may fail and return error ID 2714: "There is already an object named 'TargetServersRole' in the database." To resolve this error, follow these steps after you start SQL Server trace flag `902`:
          
      1. Back up your **msdb** database.
      1. Make a list of users (if any) who are currently part of this role.
      1. Drop the *TargetServersRole* role by using the following statement:
         `EXECUTE msdb.dbo.sp_droprole @rolename = N'TargetServersRole'`
      1. Restart the SQL Server instance without using trace flag `902` to check whether the issue is resolved.
      1. Restore the users from step 2 to *TargetServersRole*.

     - **Certificate-based SQL Server logins that own user objects**: Principals that are enclosed by double hash marks (##) are created from certificates when SQL Server is installed. These are intended for internal use. They shouldn't own any objects in **msdb** or other databases. If the error logs indicate a failure that is related to any of these logins, start SQL Server by using trace flag `902`, change the ownership of the affected objects to a different user, and then restart SQL Server without trace flag `902` so that the upgrade script can finish running.

      >[!NOTE]
      >Although a failure to run upgrade scripts is one of the common causes of the "Wait on Database Engine recovery handle failed" error, this error can also occur for other reasons. The error means that the update installer could not start the service or bring it online after the update was installed. In either case, troubleshooting involves a review of error logs and Setup logs to determine the cause of the failure and take appropriate action.
  
   To let the upgrade process finish, restart the SQL Server without trace flag `902`.

## Setup errors caused by missing installer files in Windows cache

Applications such as SQL Server that use Windows Installer technology for the setup process will store critical files in the Windows Installer cache. The default installer cache location is *C:\Windows\Installer*. These files are required for uninstalling and updating applications. They're unique to that computer. If these files are either inadvertently deleted or otherwise compromised, application updates that require these files will fail. To resolve this condition:

- Repair the SQL Server installation
- Use the [FixMissingMSI tool](https://github.com/suyouquan/SQLSetupTools/releases/)
- Use the [FindSQLInstalls.vbs script](https://raw.githubusercontent.com/suyouquan/SQLSetupTools/master/FixMissingMSI/FindSQLInstalls.vbs).
- Manually restore the files
- Restore files from system state backups
review and implement the procedures that are described in [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md).

For detailed instructions, see [Restore the missing Windows Installer cache files](restore-missing-windows-installer-cache-files.md).

## Setup fails because of incorrect data or log location in registry

The default location that you specify during installation for database data and log files is saved in the registry at *HKLM\Software\Microsoft\MicrosoftSQL Server\MSSQL{nn}.MyInstance*. When you install a CU or SP, these locations are validated by the Setup process. If the validation fails, you might receive errors messages that resemble the following messages:

- "Error installing SQL Server Database Engine Services Instance Features. The Database Engine system data directory in the registry is not valid."
- "The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory."

To fix this issue, connect to the SQL Server instance by using SQL Server Management Studio (SSMS), open **Properties** for the instance, select **Database Settings**, and ensure that the **Database Default locations** for Data and Log point to the correct folders. Then, retry the CU or SP installation.

## Misconfigured Windows Server Failover Clustering (WSFC) nodes

For smooth functioning and maintenance of a SQL Server Failover Cluster Instance (FCI), you must always follow the best practices that are described in [Before Installing Failover Clustering](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering?view=sql-server-ver15&preserve-view=true) and [Failover Cluster Instance administration & maintenance](/sql/sql-server/failover-clusters/windows/failover-cluster-instance-administration-and-maintenance?view=sql-server-ver15&preserve-view=true). If you're experiencing errors when you apply a CU or an SP, check the following conditions:

- Ensure that the **Remote Registry** service is active and running on all nodes of the WSFC cluster.
- If the service account for SQL Server isn't an administrator in your Windows cluster, make sure that administrative shares (C$ and so on) are enabled on all the nodes. For more information, see [Overview of problems that may occur when administrative shares are missing](../../windows-server/networking/problems-administrative-shares-missing.md).
If these shares aren't configured correctly, you might notice one or more of the following symptoms when you try to install a CU or SP:
  - The update takes a long time to run or doesn't respond. Setup logs don't reveal any progress.
  - Setup logs contain messages such as the following:
    - "The network path was not found."
    - "System.UnauthorizedAccessException: Attempted to perform an unauthorized operation."

## Additional resources: available updates, SQL Server servicing model, security updates

- For a complete list of currently available updates for your SQL Server version and download locations, see [Determine the version, edition, and update level - SQL Server](../general/determine-version-edition-update-level.md).
- For more information about supportability and servicing timelines for your SQL Server version, see [Microsoft Product Lifecycle Page](/lifecycle/products/?terms=sql).
- For information about servicing models for different versions of SQL Server, see [Incremental Servicing Model for SQL Server Updates](https://support.microsoft.com/topic/an-incremental-servicing-model-is-available-from-the-sql-server-team-to-deliver-hotfixes-for-reported-problems-6209f7b4-20a5-1a45-5042-5df411263e8b) and [Modern Servicing Model for SQL 2017 and later versions](/archive/blogs/sqlreleaseservices/announcing-the-modern-servicing-model-for-sql-server).
- For general information about how to update SQL Server, see [Install SQL Server Servicing Updates](/sql/database-engine/install-windows/install-sql-server-servicing-updates?view=sql-server-ver15&preserve-view=true).
- For information about security updates for SQL Server and other products, see the [Security Update Guide](https://msrc.microsoft.com/update-guide).
- For information about the standard terminology that's associated with Microsoft updates, see [Description of the standard terminology that is used to describe Microsoft software updates](/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server?view=sql-server-ver15&preserve-view=true).
- To resolve setup issues that might occur in highly secure environments, see [SQL Server installation fails if the Setup account doesn't have certain user rights](installation-fails-if-remove-user-right.md).
