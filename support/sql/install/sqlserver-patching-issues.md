---
title: Troubleshoot common SQL Server patching issues
description: This article helps you to troubleshoot common SQL Server patching issues. 
ms.date: 12/01/2021
ms.prod-support-area-path: Installation, Patching and Upgrade
ms.author: jayaramanp
ms.prod: sql
---

# Troubleshoot common SQL Server patching issues

This article provides general troubleshooting procedures that you can use when you run into any issue applying a Service Pack (SP) or a Cumulative Update (CU) for your SQL Server instance. It also provides detailed procedures for solving the following failure messages associated with patching:

- [Wait on Database Engine recovery handle failed / 912 and 3417 errors](#wait-on-database-engine-recovery-handle-failed-912-and-3417-errors) error message when executing upgrade scripts.
- [Various setup errors that occur](#setup-errors-resulting-from-missing-installer-files-in-windows-cache) due to missing  MSI files or patch files in the Windows installer cache.
- [The Database Engine system data directory in the registry is not valid](#setup-failing-due-to-incorrect-data-or-log-location-in-registry) or the User Log directory in the registry is not valid.
- [Network path was not found](#setup-failing-due-to-incorrect-data-or-log-location-in-registry) and other errors that can occur when Remote Registry Service or Admin shares are disabled on your Always On Failover Cluster instance (FCI) or Always On Availability Groups (AG).

For a complete list of currently available updates for your SQL version and download locations, see the [Determine the version, edition, and update level - SQL Server](https://docs.microsoft.com/troubleshoot/sql/general/determine-version-edition-update-level) section.

For more information about supportability and servicing timelines for your SQL version, see the [Microsoft Product Lifecycle Page](https://docs.microsoft.com/lifecycle/products/?terms=sql) section.

For information on servicing models for different versions of SQL Server, see the [Incremental Servicing Model for SQL Server Updates](https://support.microsoft.com/topic/an-incremental-servicing-model-is-available-from-the-sql-server-team-to-deliver-hotfixes-for-reported-problems-6209f7b4-20a5-1a45-5042-5df411263e8b) and [Modern Servicing Model for SQL 2017 and later versions](https://docs.microsoft.com/archive/blogs/sqlreleaseservices/announcing-the-modern-servicing-model-for-sql-server) sections.

## CU and SP installation general info

This section provides information on the CU and SP installation prerequisites.

- For SQL Server 2016 and earlier versions:
  - Before you install a CU, ensure your SQL instance is at the right SP level for the CU.   For example, you cannot install CU17 for SQL 2016 SP2, before you apply SP2 for the SQL 2016 instance.
  - You can always apply the latest CU for a given SP baseline without applying previous CUs for that service pack. For example, to apply CU17 for SQL 2016 SP2 instance, you can  directly go to CU17 without applying any of the intermediate CUs.
- For SQL Server 2017 and later versions, you can always apply the latest CU available.
- The SQL Server's program files and data files cannot be installed on:
    - a removable disk drive,
    - a file system that uses compression,
    - a directory where system files are located, and
    - shared drives on a failover cluster instance.
- Before applying a CU or SP, make sure your instance that is being patched, is configured accordingly.
- If you have added a new [database engine feature](https://docs.microsoft.com//sql/database-engine/install-windows/install-sql-server-database-engine) after applying a SP or CU to your instance, you should patch the new feature to the same level as others before applying a new CU or SP.

## General troubleshooting methodology

1. Isolate the error by doing the following steps:
    1. Check **Details** in the **Failure** screen of the setup process.
    1. Check *Summary.txt* and other setup log files that are by default present in the *%programfiles%\Microsoft SQL Server\nnn\Setup Bootstrap\Log* folder. For more information, see the [View and Read SQL Server Setup Log Files](https://docs.microsoft.com/sql/database-engine/install-windows/view-and-read-sql-server-setup-log-files?view=sql-server-ver15&preserve-view=true) section.

1. Check for a matching scenario in the next few sections and follow associated troubleshooting procedures for the corresponding scenario.
1. If there is no matching scenario, look for additional pointers in the log files and also review the general information section above.

## Wait on Database Engine recovery handle failed, 912, and 3417 errors

Upgrade scripts are shipped with each SQL Server update and are executed after the binaries have been upgraded. When these scripts fail to execute, the setup program for update reports  *Wait on Database Engine recovery handle failed* error in the error details section and logs [912](https://docs.microsoft.com/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error?view=sql-server-ver15&preserve-view=true) and [3417](https://docs.microsoft.com/sql/relational-databases/errors-events/mssqlserver-3417-database-engine-error?view=sql-server-ver15&preserve-view=true) errors in the latest SQL Server Error log. The 912 and 3417 are generic errors associated with database script upgrade failures and the messages preceding 912 error usually provides information on what exactly failed during the execution of these scripts.

To troubleshoot and fix these errors, do the following steps:

1. Review the SQL Server Errorlogs for details on failure.
1. Start SQL Server with trace flag 902 to bypass upgrade script execution.
1. Address the cause of the failure (see different scenarios below).
1. Restart SQL Server without trace flag 902 to allow upgrade process to complete.

Following are some of the common causes of upgrade script failures and corresponding resolutions:

- **SSISDB part of Availability group**

  Remove SSIS Catalog database (SSISDB) from AG and after the upgrade completes, add SSISDB back to the availability group. For more information, see the [Upgrading SSISDB in an availability group](https://docs.microsoft.com/sql/integration-services/catalog/ssis-catalog?view=sql-server-ver15#Upgrade&preserve-view=true) section.

- **Misconfigured System User/Role in msdb database**

  This section provides steps to resolve misconfigured system user or role in the msdb database:
  - TargetServersRole Schema/Security role: These are generally used in multiserver environments and by default, the *TargetServersRole* security role is owned by dbo and the role owns TargetServersRole schema. If you inadvertently change this association, and the patch that you are installing includes updates to either of these, setup may fail with *Error 2714: There is already an object named 'TargetServersRole' in the database*. To resolve this error, after starting SQL Server TF902, use the following steps:
    1. Back up your msdb database.
    1. Make a list of users (if any) that are currently part of this role.
    1. Drop the TargetServersRole using the statement: ```EXECUTE msdb.dbo.sp_droprole @rolename = N'TargetServersRole'```.
    1. Restart the SQL Server without TF902 and see if the issue is resolved.
    1. Readd the users from step 2 to TargetServersRole.

  - Certificate-based SQL Server Logins owning user objects: Principals enclosed by double hash marks (##) are created from certificates when SQL Server is installed and is meant for internal use and should not own any objects in the msdb or other databases. If the error logs indicate a failure related to any of these logins, start SQL server with TF 902, change the ownership of the affected objects to a different user and then restart SQL Server without TF902 for the upgrade script to complete execution.

> [!NOTE]
> Though failure to execute upgrade scripts is one of the common causes for *Wait on Database Engine recovery handle failed" error message, the error can occur because of other reasons. The error means that the patch installer was unable to start the service or bring it online after the patch was installed. In either case the troubleshooting involves reviewing error logs and setup logs to determine the cause of failure and take appropriate action.

## Setup errors resulting from missing installer files in Windows cache

Applications like SQL Server that use Windows Installer technology for setup process, stores critical files in the Windows Installer Cache (default is C:\Windows\Installer). These files are required for uninstalling and updating applications and are unique to a computer. As such, if these files are either inadvertently deleted or otherwise compromised, subsequent updates will fail. To resolve this condition, review and implement the procedures described in the [Restore the missing Windows Installer cache files](https://docs.microsoft.com/troubleshoot/sql/install/restore-missing-windows-installer-cache-files) section.

## Setup failing due to incorrect data or log location in registry

The default location that you specify for database's data and log files during installation is saved in corresponding registry entries at HKLM\Software\Microsoft\MicrosoftSQL Server\MSSQL{nn}.MyInstance. When you install a CU or SP, these locations are validated by the setup process and if the validation fails you can run into errors similar to the following:

- *Error installing SQL Server Database Engine Services Instance Features. The Database Engine system data directory in the registry is not valid.*
- *The User Log directory in the registry is not valid. Verify DefaultLog key under the instance hive points to a valid directory.*

To fix this issue, connect to the SQL Server instance using SQL Server Management Studio (SSMS), open **Properties** for the instance and ensure the **Database Default locations** under **Database Settings** points to the right location and retry the CU or SP installation.

## Misconfigured Windows Server Failover Clustering (WSFC) nodes

For smooth functioning and maintenance of a SQL Server failover cluster you must always follow all the best practices noted in the [Before Installing Failover Clustering](https://docs.microsoft.com/sql/sql-server/failover-clusters/install/before-installing-failover-clustering?view=sql-server-ver15) and [Failover Cluster Instance administration & maintenance](https://docs.microsoft.com/sql/sql-server/failover-clusters/windows/failover-cluster-instance-administration-and-maintenance?view=sql-server-ver15#changing-service-accounts) sections. If you are running into errors applying a CU or a SP, check the following:

- The remote registry service is up and running on all the nodes of the WSFC cluster.
- If the service account for SQL Server is not an administrator in your cluster, ensure administrative shares (C$ etc.) are enabled on all the nodes. For more information, see the [Overview of problems that may occur when administrative shares are missing](https://docs.microsoft.com/troubleshoot/windows-server/networking/problems-administrative-shares-missing) section.
When these are not properly configured, you may notice one or more of the following symptoms when trying to install a CU or SP:
  - Patch taking a long time to run or does not respond. Setup logs do not reveal any progress.
  - Setup logs show messages like the following:
    - The network path was not found.
    - System.UnauthorizedAccessException: Attempted to perform an unauthorized operation.

## See Also

- For general information on updating SQL Server, see the [Install SQL Server Servicing Updates](https://docs.microsoft.com/sql/database-engine/install-windows/install-sql-server-servicing-updates?view=sql-server-ver15&preserve-view=true) section.
- For information on security updates for SQL Server and other products, see the [Security Update Guide](https://msrc.microsoft.com/update-guide) section.
- For information on standard terminology associated with Microsoft updates, see the [Description of the standard terminology that is used to describe Microsoft software updates](https://docs.microsoft.com/sql/database-engine/install-windows/latest-updates-for-microsoft-sql-server?view=sql-server-ver15&preserve-view=true) section.
- For resolving setup issues that may occur in highly secure environments, see the [SQL Server installation fails if the Setup account doesn't have certain user rights](https://docs.microsoft.com/troubleshoot/sql/install/installation-fails-if-remove-user-right) section.
