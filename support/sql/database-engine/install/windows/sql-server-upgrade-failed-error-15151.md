---
title: SQL Server upgrade fails with error 15151 when executing Update Database scripts
description: This article describes error 15151 that stops a SQL Server upgrade when update database scripts are run.
ms.date: 08/17/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: jopilov, v-jayaramanp
---

# SQL Server upgrade fails and returns error 15151

This article helps you troubleshoot error 15151 that occurs when you install a cumulative update (CU) or service pack (SP) for Microsoft SQL Server. The error occurs when database upgrade scripts are run.

## Symptoms

When you apply a CU or SP, the Setup program returns the following error message:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

Additionally, the following error entry might be logged in the SQL Server error log:

```output
**Error message :**
Error: 15151, Severity: 16, State: 1.
Cannot find the login '##MS_SSISServerCleanupJobLogin##', because it does not exist or you do not have permission.
```

## Cause

This issue occurs because either the login (server principal) was dropped manually or these [instructions](/sql/integration-services/catalog/ssis-catalog#backup) aren't followed.

For more information about database upgrade scripts that run during the CU or SP installation, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

To resolve the issue, follow these steps:

1. Start SQL Server with [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. Re-create the login on the server:

   ```sql
   CREATE LOGIN [##MS_SSISServerCleanupJobLogin##]
   WITH PASSWORD = N'<password>',
   DEFAULT_DATABASE = [master],
   DEFAULT_LANGUAGE = [us_english],
   CHECK_EXPIRATION = OFF,
   CHECK_POLICY = OFF;
   ```

1. Switch to the `SSISDB` database, and map the existing user to the newly created login:

    ```sql
    USE SSISDB
    GO
    ALTER USER [##MS_SSISServerCleanupJobUser##] WITH LOGIN =[##MS_SSISServerCleanupJobLogin##]
    ```

1. In some cases, the database user information might also be missing. In this case, re-create the user in the `SSISDB` database, and then rerun the previous step to map the user to the login:

   ```sql
   USE [SSISDB]
   GO
   DROP USER [##MS_SSISServerCleanupJobLogin##]
   GO

   CREATE USER [##MS_SSISServerCleanupJobUser##] FOR LOGIN [##MS_SSISServerCleanupJobLogin##]
   GO
   
   ALTER USER [##MS_SSISServerCleanupJobUser##] WITH DEFAULT_SCHEMA=[dbo]
   GO

   GRANT EXECUTE ON [internal].[cleanup_server_project_version] TO [##MS_SSISServerCleanupJobUser##]
   GO
   GRANT EXECUTE ON [internal].[cleanup_server_retention_window] TO [##MS_SSISServerCleanupJobUser##]
   GO
   ```
