---
title: SQL Server upgrade fails and returns error 6528
description: Troubleshoots error 6528 that occurs when you install a cumulative update or service pack for SQL Server. The error occurs when database upgrade scripts are run.
ms.date: 08/11/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: v-sidong
author: prmadhes-msft
ms.author: prmadhes
---
# SQL Server upgrade fails and returns error 6528

This article helps you troubleshoot and solve error 6528 that occurs when you install a cumulative update (CU) or service pack (SP) for Microsoft SQL Server. The error occurs when database upgrade scripts are run.

## Symptoms

When you apply a CU or an SP for SQL Server, you notice that the Setup program reports one of the following error messages in the SQL Server error log:

```output
SQL server failed in 'Script level upgrade' with the following error:
Error: 50000, Severity: 16, State: 127.
Cannot drop the assembly 'ISSERVER', because it does not exist or you do not have permission.
Error: 50000, Severity: 16, State: 127.
Cannot drop the assembly 'ISSERVER', because it does not exist or you do not have permission.

Creating function internal.is_valid_name
Error: 6528, Severity: 16, State: 1.
Assembly 'ISSERVER' was not found in the SQL catalog of database 'SSISDB'.

Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'ISServer_upgrade.sql' encountered error 6528, state 1, severity 16. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous error log entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
SQL Server shutdown has been initiated.
```

## Cause

This issue may occur because the SQL Server instance where you try to apply a CU or an SP is missing assembly `ISSERVER`.

For more information about database upgrade scripts that run during a CU or an SP installation, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

Follow these steps to solve the issue:

1. Start SQL Server with [trace flag 902](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf902).
1. Check if the assembly `ISSERVER` is in the database `SSISDB` by using the following query:

    ```sql
    Use SSISDB
    GO
    SELECT * FROM sys.assemblies WHERE name = 'ISSERVER'
    ``````

    Or, you can check it by expanding **Databases** > **SSISDB** > **Programmability** > **Assemblies** > **ISSERVER** in SQL Server Management Studio (SSMS).

1. Check the location *C:\Program Files\Microsoft SQL Server\\\<VersionNumber>\DTS\Bin* to see if the assembly *Microsoft.SqlServer.IntegrationServices.Server.dll* is present in the SQL binary folder.
1. If the assembly is in that folder but missing as an entry in the [sys.assemblies](/sql/relational-databases/system-catalog-views/sys-assemblies-transact-sql) view, re-create it by using the following query:

    ```sql
    DECLARE @asm_bin varbinary(max);
    SELECT @asm_bin = BulkColumn
    FROM OPENROWSET (BULK N'C:\Program Files\Microsoft SQL Server\<VersionNumber>\DTS\Binn\Microsoft.SqlServer.IntegrationServices.Server.dll',SINGLE_BLOB) AS dll
    CREATE ASSEMBLY ISSERVER FROM  @asm_bin  WITH PERMISSION_SET = UNSAFE
    ALTER DATABASE SSISDB SET TRUSTWORTHY ON
    ```

    This time the assembly `ISSERVER` is present.

1. Remove trace flag 902 and start the services.

