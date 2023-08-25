---
title: SQL Server upgrade fails if certificate-based principals own user objects
description: This article helps you resolve an issue in which a cumulative update or service pack for SQL Server reports errors caused by certificate-based principals that own user objects.
ms.date: 08/17/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: jopilov, v-jayaramanp
---

# SQL Server upgrade fails if certificate-based principals own user objects

This article helps you troubleshoot an issue in which a cumulative update (CU) or service pack (SP) for SQL Server reports error 574 when you run database upgrade scripts.

## Symptoms

When you apply a CU or SP for SQL Server, the Setup program returns the following error message:

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

Additionally, the following error entries might be logged in the SQL Server error log together with errors 912 and 3417:

- `15136 The database principal is set as the execution context of one or more procedures, functions, or event notifications and cannot be dropped.`
- `15138 The database principal owns a %S_MSG in the database, and cannot be dropped.`
- `15141 The server principal owns one or more %S_MSG(s) and cannot be dropped.`
- `15154 The database principal owns an %S_MSG and cannot be dropped.`
- `15155 The server principal owns a %S_MSG and cannot be dropped.`
- `15183 The database principal owns objects in the database and cannot be dropped.`
- `15184 The database principal owns data types in the database and cannot be dropped.`
- `15186 The server principal is set as the execution context of a trigger or event notification and cannot be dropped.`
- `15284 The database principal has granted or denied permissions to objects in the database and cannot be dropped.`
- `15421 The database principal owns a database role and cannot be dropped.`
- `27226 The database principal has granted or denied permissions to catalog objects in the database and cannot be dropped.`
- `33015 The database principal is referenced by a %S_MSG in the database, and cannot be dropped.`

```output
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'SSIS_hotfix_install.sql' encountered error 945, state 2, severity 25. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
SQL Server shutdown has been initiated
```

## Cause

Server principals that are enclosed within double hash marks (##) are created from certificates when SQL Server is installed. These principals are to be treated as system-created principals. They must not be mapped to database principals that own user objects in `msdb` or other databases. Any changes to this default configuration might cause failures when you try to upgrade SQL Server. This is because the upgrade scripts assume that these objects have only dependencies that are created by SQL Server.

## Resolution

1. Start SQL Server by using [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. To determine the mapping of server principals to database principals, run the following command:

   ```sql
   EXEC master.sys.sp_helplogins 
   ```

1. Change the ownership of the affected objects to a different user.
1. Restart SQL Server without trace flag `902` so that the upgrade script can finish running.

  > [!NOTE]  
  > Although a failure to run upgrade scripts is one of the common causes of the "Wait on Database Engine recovery handle failed" error, this issue can also occur for other reasons. The error means that the update installer couldn't start the service or bring it online after the update was installed. In either case, troubleshooting involves a review of error logs and Setup logs to determine the cause of the failure and take appropriate action.

## See also

[Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md)
