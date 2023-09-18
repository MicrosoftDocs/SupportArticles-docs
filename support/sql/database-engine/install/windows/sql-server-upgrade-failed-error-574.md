---
title: SQL Server upgrade fails with error code 574
description: Troubleshoots and solves an issue where a Cumulative Update or Service Pack for SQL Server reports error 574 when executing database upgrade scripts.
ms.date: 01/11/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-sidong
---

# SQL Server upgrade fails with error code 574 when executing update database scripts

This article helps you troubleshoot and solve an issue where a Cumulative Update (CU) or Service Pack (SP) for SQL Server reports error 574 when executing database upgrade scripts.

## Symptoms

When you apply a CU or SP, the setup program may report the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

When you review the SQL Server error log, you may notice the following error messages:

```Output
Error: 574, Severity: 16, State: 0.
CONFIG statement cannot be used inside a user transaction.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'sqlagent100_msdb_upgrade.sql' encountered error 574, state 0, severity 16.
This is a serious error condition which might interfere with regular operation and the database will be taken offline.
If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting.
Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 15173, state 1, severity 16
```

## Cause

The update process may run some upgrade scripts within a transaction. These update scripts are designed with an assumption that users don't make changes to system objects and associated permissions. If you inadvertently make any changes to system objects or permissions, some of these scripts may fail, and the associated transaction may become orphaned and remain open. In this scenario, when the setup program later executes an upgrade script that uses `sp_configure` to set some configuration values, error 574 occurs. The actual cause of the setup failure should be determined by reviewing entries that are logged before error 574.

For example, a script like the following one can result in error 574:

```sql
BEGIN TRAN
USE MASTER;
GO
EXEC sp_configure 'recovery interval', '4';
RECONFIGURE WITH OVERRIDE;
COMMIT TRAN
```

## Resolution

To solve the issue, follow these steps:

1. Start SQL Server with [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902). For more information, see [Steps to start SQL Server with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).
1. Open the SQL Server error log and review the messages prior to error 574 to identify the failed transaction (see the following [example pattern](#example-pattern-issues-granting-permissions-to-system-role)).
1. Fix the failed transaction according to the information in the [Potential causes and solutions](#potential-causes-and-solutions) section.
1. Remove trace flag 902 from the **Startup Parameters** item and restart SQL Server.

   Once SQL Server starts without trace flag 902, the upgrade script will be executed again.

    - If the SP/CU upgrade script completes successfully, you can check the SQL Server error log and bootstrap folder to verify.
    - If the upgrade script fails again, check the SQL Server error log for other errors and troubleshoot the new errors.

### Example pattern: Issues granting permissions to system role

```Output
2020-08-17 09:38:12.09 spid11s Adding user 'hostname\svc_sqlagent' to SQLAgentUserRole msdb role...
2020-08-17 09:38:12.09 spid11s
2020-08-17 09:38:12.09 spid11s Granting login access'##MS_SSISServerCleanupJobLogin##' to msdb database...
2020-08-17 09:38:12.10 spid11s A problem was encountered granting access to MSDB database for login '(null)'. Make sure this login is provisioned with SQLServer and rerun sqlagent_msdb_upgrade.sql
2020-08-17 09:38:12.10 spid11s A problem was encountered granting access to MSDB database for login '(null)'. Make sure this login is provisioned with SQLServer and rerun sqlagent_msdb_upgrade.sql
2020-08-17 09:38:12.10 spid11s
2020-08-17 09:38:12.10 spid11s Adding user '##MS_SSISServerCleanupJobLogin##' to SQLAgentUserRole msdb role...
```

## Potential causes and solutions

- User options cause transactions to fail.

   **Solution**: Connect to SQL Server, use the [user options](/sql/database-engine/configure-windows/configure-the-user-options-server-configuration-option) server configuration option documentation to identify options that may cause the issue, and remove the conflicting setting.

   For example, Microsoft support has seen instances where the setting for [IMPLICIT_TRANSACTIONS](/sql/t-sql/statements/set-implicit-transactions-transact-sql) causes the setup to fail. Alternately, if you can't identify the conflicting user option, remove all the user options by using the following script in SQL Server Management Studio (SSMS):

   ```sql
   EXEC sp_configure 'user options', '0'
   GO
   RECONFIGURE WITH OVERRIDE;
   GO
   ```

- Orphaned users cause transactions to fail.

   **Solution**: Check for orphaned users by using a query like the following one:

   ```sql
   SELECT dp.type_desc, dp.SID, dp.name AS user_name
   FROM sys.database_principals AS dp
   LEFT JOIN sys.server_principals AS sp
       ON dp.SID = sp.SID
   WHERE sp.SID IS NULL
       AND authentication_type_desc = 'INSTANCE';
   ```

   For more information on how to resolve orphaned users, see [Troubleshoot orphaned users (SQL Server)](/sql/sql-server/failover-clusters/troubleshoot-orphaned-users-sql-server).

- Orphaned jobs cause transactions to fail.

   **Solution**: Check for orphaned jobs by using a query like the following one:

   ```sql
   SELECT sj.name AS Job_Name,
       sl.name AS Job_Owner
   FROM msdb.dbo.sysjobs_view sj
   LEFT JOIN master.dbo.syslogins sl ON sj.owner_sid = sl.sid
   WHERE sl.name <> 'sa'
   ORDER BY sj.name
   ```

   Any record showing a NULL value here indicates that the owner of the applicable Agent Job is orphaned. Edit the job and change the owner to a valid login.
