---
title: Error 1712 when upgrading SQL Server 2014 or 2016 to 2017  
description: This article discusses error 1712 that causes a SQL Server upgrade to fail when it runs update database scripts.
ms.date: 01/11/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-jayaramanp
---

# SQL Server upgrade from SQL Server 2014 or SQL Server 2016 to 2017 fails and returns error 1712

This article helps you troubleshoot and resolve the issue wherein upgrading either a SQL Server 2016 or SQL Server 2014 to SQL Server 2017 reports 1712 while executing database upgrade scripts.

## Symptoms

Upgrading to a SQL Server 2017 instance may fail while running the `ISServer_upgrade.sql` upgrade script with the following error:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

When you check the SQL Server error log, you notice one of the following error entries:

```output
2020-10-26 10:08:09.94 spid6s      Database 'master' is upgrading script 'ISServer_upgrade.sql' from level 0 to level 500. 
2020-10-26 10:08:09.94 spid6s      --------------------------------------------- 
2020-10-26 10:08:09.94 spid6s      Starting execution of ISServer_upgrade.SQL 
2020-10-26 10:08:09.94 spid6s      --------------------------------------------- 
2020-10-26 10:08:09.94 spid6s        
2020-10-26 10:08:09.94 spid6s      Taking SSISDB to single user mode 
2020-10-26 10:08:09.94 spid6s      Setting database option SINGLE_USER to ON for database 'SSISDB'. 
2020-10-26 10:08:10.47 spid6s      Error: 1712, Severity: 16, State: 1. 
2020-10-26 10:08:10.47 spid6s      Online index operations can only be performed in Enterprise edition of SQL Server. 
2020-10-26 10:08:10.47 spid6s      Error: 917, Severity: 15, State: 1. 
2020-10-26 10:08:10.47 spid6s      An upgrade script batch failed to execute for database 'master' due to compilation error. Check the previous error message for the line which caused compilation to fail. 
2020-10-26 10:08:10.47 spid6s      Error: 912, Severity: 21, State: 2. 
2020-10-26 10:08:10.47 spid6s      Script level upgrade for database 'master' failed because upgrade step 'ISServer_upgrade.sql' encountered error 917, state 1, severity 15. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion. 
2020-10-26 10:08:10.48 spid6s      Error: 3417, Severity: 21, State: 3. 
2020-10-26 10:08:10.48 spid6s      Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online. 
2020-10-26 10:08:10.48 spid6s      SQL Server shutdown has been initiated 
2020-10-26 10:08:10.48 spid6s      SQL Trace was stopped due to server shutdown. Trace ID = '1'. This is an informational message only; no user action is required. 
2020-10-26 10:08:10.50 spid15s     The SQL Server Network Interface library successfully deregistered the Service Principal Name (SPN) [ MSSQLSvc/SAFHSQL01.SAFEHAVEN.com ] for the SQL Server service. 
2020-10-26 10:08:10.50 spid15s     The SQL Server Network Interface library successfully deregistered the Service Principal Name (SPN) [ MSSQLSvc/SAFHSQL01.SAFEHAVEN.com:1433 ] for the SQL Server service.
```

## Cause

SQL Server 2017 release to manufacture (RTM) upgrade script includes a dynamic link library (DLL) that runs online index operations for all editions of SQL Server although only the Enterprise and Developer editions support this feature. For more information about database upgrade scripts, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

## Resolution

To resolve the 1712 error, follow these steps:

1. Start SQL Server together with trace flag (TF) 902. For more information, see [Steps to start SQL with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

   > [!NOTE]
   > As this error occurs after upgrading binaries, SQL Server database engine will already be at SQL Server 2017 RTM level and you can still start the instance with TF 902.

1. Install a build of SQL Server that is [SQL Server 2017 CU5](../../../releases/sqlserver-2017/build-versions.md) or higher.

1. Remove TF 902 from the startup parameters, and then restart SQL Server.

1. After SQL Server starts without TF 902, the upgrade script will run again.

   - If the upgrade script finishes successfully, the Service Pack (SP) or Cumulative Update (CU) upgrade is complete. You can check the SQL Server error log and bootstrap folder to verify the completed installation.

   - If the upgrade script fails again, check the SQL Server error log for additional error entries, and then troubleshoot the new errors.
