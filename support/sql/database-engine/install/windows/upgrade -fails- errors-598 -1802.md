---
title: SQL Server upgrade fails with errors 598 and 1802
description: Troubleshoots and solves an issue where a Cumulative Update (CU) or Service Pack (SP) for SQL Server reports errors 598 and 1802 when you execute database upgrade scripts.
ms.date: 01/04/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni
author: sevend2
ms.author: v-sidong
ms.prod: sql
---

# SQL Server upgrade fails with errors 598 and 1802 when executing update database scripts

This article helps you troubleshoot and resolve an  issue where a Cumulative update (CU) or Service Pack (SP) for SQL Server reports 5133 while executing database upgrade scripts.

## Symptoms

When applying a CU or a SP, the setup program may report the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

When you review SQL Server error log, you may notice errors like the following one:

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

SQL Server reports error 598 when it runs into an error when executing CREATE/ALTERDB statements. From Database Engine events and errors - SQL Server | Microsoft Learn

598 - An error occurred while executing CREATE/ALTER DB. Please look at the previous error for more information.

Reviewing entries prior to 598 error provides more information on the cause of failure. For example, in this scenario the preceding error is 1802, which in turn occurredThis problem occurs  because the upgrade script ian upgrade script starts after the SQL Server instance has been restarted and it is unable to create temporary database a database in the default data path.  The temporary database is used by setup for various operations it runs during the update process. For more information regarding Database upgrade scripts that get executed during CU or SP installation process, review <link to the landing page>

## Resolution

1. Verify that the configured data path is valid and correct in SQL Server.

1. Open SQL Server Configuration Manager, select **SQL Server Services**.

1. Right click the SQL Server instance and select **Properties**.

1. Select the **Advanced** tab and verify that the **Data Path** listed is correct and does not have any typo's or extra characters. To validate, you can copy out the data path and try to access it with Windows Explorer.

1. In Windows search type in 'regedit' to open the Windows Registry

1. Navigate to the registry key for the default data path and validate that the path is correct with no extra spaces/characters.  The registry Key for the Default Data Path is `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.<Instance Name>\Setup\SQLDataRoot`.
