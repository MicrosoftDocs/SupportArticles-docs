---
title: SQL Server upgrade fails with error code 2714
description: This article provides a resolution to an issue where a Cumulative Update or Service Pack for SQL Server reports error 2714 when you run database upgrade scripts.
ms.reviewer: ramakoni, v-sidong, pijocoder
ms.date: 08/01/2023
ms.custom: sap:Installation, Patching and Upgrade
---

# SQL Server upgrade fails with error code 2714 when executing update database scripts

This article resolves an issue where a cumulative update (CU) or service pack (SP) reports error 2714 when you run database upgrade scripts.

## Symptoms

When you apply a CU or SP, the setup program might report the following error:

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

When you review the SQL Server error log, you might notice one of the following group of error messages:

```output
2021-07-27 14:08:44.31 spid6s      Error: 2714, Severity: 16, State: 6.
2021-07-27 14:08:44.31 spid6s      There is already an object named 'DatabaseMailUserRole' in the database.
2021-07-27 14:08:44.31 spid6s      Error: 2759, Severity: 16, State: 0.
2021-07-27 14:08:44.31 spid6s      CREATE SCHEMA failed due to previous errors.
2021-07-27 14:08:44.31 spid6s      Error: 912, Severity: 21, State: 2.
2021-07-27 14:08:44.31 spid6s      Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 2714, state 6, severity 25.
This is a serious error condition which might interfere with regular operation and the database will be taken offline.
If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting.
Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
2021-07-27 14:08:44.32 spid6s      Error: 3417, Severity: 21, State: 3.
Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
```

```output
2021-07-27 14:08:44.31 spid6s      Error: 2714, Severity: 16, State: 6.
2021-07-27 14:08:44.31 spid6s      There is already an object named 'TargetServersRole' in the database.
2021-07-27 14:08:44.31 spid6s      Error: 912, Severity: 21, State: 2.
2021-07-27 14:08:44.31 spid6s      Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 2714, state 6, severity 25.
This is a serious error condition which might interfere with regular operation and the database will be taken offline.
If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting.
Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
2021-07-27 14:08:44.32 spid6s      Error: 3417, Severity: 21, State: 3.
Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
```

## Resolve upgrade issue with the DatabaseMailUserRole schema

Review the following information to resolve the upgrade issue associated with the `DatabaseMailUserRole`.

### <a id="cause-database-mail-user-role"></a> Cause

This error occurs if a system schema, user or role is misconfigured in the `msdb` database.

It also occurs when the upgrade script fails to recreate the `DatabaseMailUserRole` schema in the `msdb` database. This issue can happen when the `DatabaseMailUserRole` schema isn't owned by the `DatabaseMailUserRole` role; for example, if the schema is owned by `dbo`.

For more information about database upgrade scripts that are executed during CU or SP installation, see [Troubleshooting upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

### <a id="resolution-database-mail-user-role"></a> Resolution

1. Stop and restart SQL Server by using [T902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902). For example, you can run this command from a command prompt:

   **For a default instance:**

   ```console
   NET START MSSQLSERVER /T902
   ```

   **For named instances:**

   ```console
   NET START MSSQL$INSTANCENAME  /T902
   ```

1. Back up your `msdb` database as a precaution.

   ```sql
   BACKUP DATABASE msdb TO disk = '<backup folder>'
   ```

1. Open SQL Server Management Studio, connect to the SQL Server instance, and back up of the `msdb` database.

1. Expand **Databases** > **System Databases** > `msdb` > **Security** > **Schemas** > **DatabaseMailuserRole**.

1. Delete the schema named `DatabaseMailUserRole`.

1. Stop SQL Server and restart it without the trace flag 902.

   After SQL Server starts without trace flag 902, the upgrade script is executed again, and the `DatabaseMailUserRole` schema is recreated.

    - If the SP or CU upgrade script completes successfully, check the SQL Server error log and bootstrap folder to verify.
    - If the upgrade script fails again, check the SQL Server error log for other errors and troubleshoot the new errors.

## Resolve upgrade issue with the TargetServersRole role

Review the following information to resolve the upgrade issue associated with the `TargetServersRole`.

### <a id="cause-targetserversrole"></a> Cause

This error occurs when the upgrade script fails to recreate the `TargetServersRole` security role in the `msdb` database. This role is used in multi-server environments. By default, the `TargetServersRole` security role is owned by the `dbo`, and the role owns the `TargetServersRole` schema. If you inadvertently change this association, and the update that you're installing includes changes to either of these roles, the upgrade might fail and return error `2714: There is already an object named 'TargetServersRole' in the database`. To resolve the error, follow these steps:

### <a id="resolution-targetserversrole"></a> Resolution

1. Stop and restart SQL Server by using [T902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).

   **For a default instance:**

   ```console
   NET START MSSQLSERVER /T902
   ```

   **For named instances:**

   ```console
   NET START MSSQL$INSTANCENAME /T902
   ```

1. Back up your `msdb` database as a precaution.

   ```sql
   BACKUP DATABASE msdb TO disk = '<backup folder>'
   ```

1. Make a list of users (if any) that are currently part of this role. You can list members of the role by running the following query:

   ```sql
   EXEC msdb.dbo.sp_helprolemember 'TargetServersRole'
   ```

1. Drop the `TargetServersRole` role by using the following statement:

    ```sql
    EXEC msdb.dbo.sp_droprole @rolename = N'TargetServersRole'
    ```

1. To check whether the issue is resolved, restart the SQL Server instance without using trace flag `902`.

1. Re-add the users from step 3 to `TargetServersRole`.
