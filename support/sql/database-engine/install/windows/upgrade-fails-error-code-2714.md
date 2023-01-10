---
title: SQL Server upgrade fails with error code 2714
description: Troubleshoots and solves an issue where a Cumulative Update (CU) or Service Pack (SP) for SQL Server reports error 2714 when you execute database upgrade scripts.
ms.date: 01/04/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
author: sevend2
ms.author: v-sidong
ms.prod: sql
---

# SQL Server upgrade fails with error code 2714 when executing update database scripts

This article helps you troubleshoot and solve an issue where a Cumulative Update (CU) or Service Pack (SP) for SQL Server reports error 2714 when you execute database upgrade scripts.

## Symptoms

When you apply a CU or SP, the setup program may report the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

When you review the SQL Server error log, you may notice the following error messages:

```Output
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

## Cause

This error occurs when the upgrade script fails to recreate the **DatabaseMailUserRole** schema in the MSDB database. This issue can happen when the **DatabaseMailUserRole** schema isn't owned by the **DatabaseMailUserRole** role. For example, the schema is owned by `dbo`.  

For more information about database upgrade scripts that are executed during CU or SP installation, see [Troubleshooting upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

Follow these steps to solve the issue:

1. Start SQL Server with [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902). For more information, see [Steps to start SQL Server with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

1. Open SQL Server Management Studio, connect to the SQL Server instance, and back up the `msdb` database.

1. Expand **Databases** > **System Databases** > **msdb** > **Security** > **Schemas** > **DatabaseMailuserRole**.  

1. Delete the schema named **DatabaseMailuserRole**.  

1. Remove trace flag 902 from the **Startup Parameters** item and restart SQL Server.

Once SQL Server starts without trace flag 902, the upgrade script will be executed again, and the **DatabaseMailUserRole** schema is recreated.

- If the SP/CU upgrade script completes successfully, you can check the SQL Server error log and bootstrap folder to verify.
- If the upgrade script fails again, check the SQL Server error log for other errors and troubleshoot the new errors.

## More information

For more information on how to solve the error 2714 `There is already an object named 'TargetServersRole' in the database`, see [TargetServersRole schema and security role](sqlserver-patching-issues.md#targetserversrole-schema-and-security-role).
