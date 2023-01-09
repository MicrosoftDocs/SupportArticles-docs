---
title: SQL Server upgrade fails with errors 598 and 1802
description: Troubleshoots and solves an issue where a Cumulative Update or Service Pack for SQL Server reports errors 598 and 1802 when you execute database upgrade scripts.
ms.date: 01/04/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
author: sevend2
ms.author: v-sidong
ms.prod: sql
---

# SQL Server upgrade fails with errors 598 and 1802 when executing update database scripts

This article helps you troubleshoot and solve an issue where a Cumulative update (CU) or Service Pack (SP) for SQL Server reports error 5133 when you execute database upgrade scripts.

## Symptoms

When you apply a CU or SP, the setup program may report the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

When you review the SQL Server error log, you may notice the following error messages:

```Output
Error: 5133, Severity: 16, State: 1
Directory lookup for the file "<path>\MSSQL10.<Instancename>\MSSQL\Data\temp_MS_AgentSigningCertificate_database.mdf" failed with the operating system error 3(The system cannot find the path specified.).
Error: 1802, Severity: 16, State: 1.
CREATE DATABASE failed. Some file names listed could not be created. Check related errors.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'sqlagent100_msdb_upgrade.sql' encountered error 598, state 1, severity 25.This is a serious error condition which might interfere with regular operation and the database will be taken offline.If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
```

## Cause

SQL Server reports error 598 when it runs into an error while executing [CREATE DATABASE](/sql/t-sql/statements/create-database-transact-sql) or [ALTER DATABASE](/sql/t-sql/statements/alter-database-transact-sql) statements.

> [!NOTE]
> From [Database Engine events and errors](/sql/relational-databases/errors-events/database-engine-events-and-errors), you can see `Error 598: An error occurred while executing CREATE/ALTER DB. Please look at the previous error for more information`.  
> Entries prior to error 598 can provide more information about the cause of the failure. For example, in this article, the preceding error is 1802, which occurs because the upgrade script is unable to create a temporary database in the default data path. The temporary database is used by the setup program for various operations it runs during the update process. For more information about database upgrade scripts that are executed during CU or SP installation, see see [Troubleshooting upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

1. Verify that the **Data Path** property is configured with a valid and correct value in SQL Server.

1. Open SQL Server Configuration Manager and select **SQL Server Services**.

1. Right-click the SQL Server instance and select **Properties**.

1. Select the **Advanced** tab and verify that the value of **Data Path** is correct and doesn't have any typos or extra characters. (To validate the value, you can copy it and try to access it with Windows Explorer.)

1. In the **Search** box on the taskbar, type *regedit* to open **Registry Editor**.

1. Navigate to the registry key for the default data path. Then, validate that the path is correct and has no extra spaces or characters. The registry key for the default data path is `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.<Instance Name>\Setup\SQLDataRoot`.

   If the registry key has the correct data path, and you continue to receive the error, follow these steps:

   1. Navigate to the registry key: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.<Instance Name>\MSSQLServer\Parameters`.

   1. Review and change the value of **Data Path** to match the value in `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.<Instance Name>\Setup\SQLDataRoot`.
