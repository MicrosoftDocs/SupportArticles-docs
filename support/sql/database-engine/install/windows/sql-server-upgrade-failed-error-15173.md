---
title: SQL Server upgrade fails with error 15173 when executing Update Database scripts
description: This article discusses error 15173 or 15559 that causes a SQL Server upgrade to fail when it runs update database scripts.
ms.date: 01/10/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-jayaramanp
---

# SQL Server upgrade fails and returns error 15173 or 15559

This article helps you troubleshoot error 15173 or 15559 that occur when you install a Cumulative Update (CU) or Service Pack (SP) for Microsoft SQL Server. The error occurs when database upgrade scripts are run.

## Symptoms

When you apply a CU or an SP for SQL Server, the Setup program reports the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

When you check the SQL Server error log, you notice one of the following error entries.

**Error message set 1:**

```output
Error: 15173, Severity: 16, State: 1.
Server principal '##MS_PolicyEventProcessingLogin##' has granted one or more permission(s). Revoke the permission(s) before dropping the server principal.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 15173, state 1, severity 16. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
EventID 3417
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
```

**Error message set 2:**

```output
Dropping existing Agent certificate ...
Error: 15559, Severity: 16, State: 1.
Cannot drop certificate '##MS_AgentSigningCertificate##' because there is a user mapped to it.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'sqlagent100_msdb_upgrade.sql' encountered error 15559, state 1, severity 16. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master'database, it will prevent the entire SQL Server instance from starting.Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.</br>
SQL Trace was stopped due to server shutdown. Trace ID = '1'. This is an informational message only; no user action is required.
```

## Cause

This problem occurs because an upgrade script stops running because it can't drop the server principal (either `##MS_PolicyEventProcessingLogin##` or `##MS_AgentSigningCertificate##`). This error occurs because a user is mapped to the server principal.

For more information about database upgrade scripts that run during the CU or SP installation, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

To resolve the 15173 or 15559 error, follow these steps:

1. Start SQL Server together with trace flag (TF) 902. For more information, see [Steps to start SQL with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

1. Connect to SQL Server, and run one of the following queries, depending on the server principal that's mentioned in the error message:

    ```sql
    SELECT a.name, b.permission_name  
    FROM sys.server_principals a 
    INNER JOIN sys.server_permissions b ON a.principal_id = b.grantee_principal_id 
    INNER JOIN sys.server_principals c ON b.grantor_principal_id = c.principal_id 
    WHERE c.name = '##MS_PolicyEventProcessingLogin##'
    ```

    ```sql
    SELECT a.name, b.permission_name  
    FROM sys.server_principals a 
    INNER JOIN sys.server_permissions b ON a.principal_id = b.grantee_principal_id 
    INNER JOIN sys.server_principals c ON b.grantor_principal_id = c.principal_id 
    WHERE c.name = '##MS_AgentSigningCertificate##'
    ```

1. For each of the logins that's displayed in the query results, run a statement such as the following to revoke those permissions.

    For example, if either of the queries returns the following results:

    > Name:  Permission name
    > NT SERVICE\MSSQL$TEST: CONTROL

    In this case, run either of the following statements:

    ```sql
    REVOKE CONTROL ON LOGIN::[##MS_PolicyEventProcessingLogin##] TO [NT SERVICE\MSSQL$TEST] AS [##MS_PolicyEventProcessingLogin##]
    ```

    ```sql
    REVOKE CONTROL ON LOGIN::[##MS_AgentSigningCertificate##] TO [NT SERVICE\MSSQL$TEST] AS [##MS_AgentSigningCertificate]
    ```

1. Remove TF 902 from the startup parameters, and then restart SQL Server. After SQL Server starts without TF 902, the upgrade script will run again.

   - If the upgrade script finishes successfully, the SP or CU upgrade is complete. You can check the SQL Server error log and bootstrap folder to verify the completed installation.

   - If the upgrade script fails again, check the SQL Server error log for additional error entries, and then troubleshoot the new errors.
