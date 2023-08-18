---
title: SQL Server upgrade fails with error 4860 when running update database scripts
description: This article discusses error 4860 that causes a SQL Server upgrade to fail when it runs update database scripts.
ms.date: 01/11/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: ramakoni, v-jayaramanp
---

# SQL Server upgrade fails and returns error 4860

This article helps you troubleshoot error 4860 that occurs when you install a cumulative update (CU) or service pack (SP) for Microsoft SQL Server. The error occurs when database upgrade scripts are run.

## Symptoms

When you install a CU or SP for SQL Server, the Setup program reports the following error:

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.

When you check the SQL Server error log, you notice error messages like the following:

```output
Error: 4860, Severity: 16, State: 1.
Cannot bulk load. The file "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Install\SqlTraceCollect.dtsx"<Filename> does not exist.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'msdb110_upgrade.sql' encountered error 4860, state 1, severity 16. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it.For more information about how to rebuild the master database, see SQL Server Books Online.
```

## Cause

This error occurs if a bulk load operation fails when you apply a CU or SP. It  occurs because of missing support installation files. For more information about the database upgrade scripts that run during the CU or SP installation, see [Troubleshoot upgrade script failures when applying an update](troubleshoot-upgrade-script-failures-apply-update.md).

For example, if Setup can't find *SqlTraceCollect.dtsx*, it reports an error that resembles the following entry:

```output
Error: 4860, Severity: 16, State: 1.
Cannot bulk load. The file "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Install\SqlTraceCollect.dtsx"
```

## Resolution

To resolve the 4860 error, follow these steps:

1. Start SQL Server together with trace flag (TF) 902. For more information, see [Steps to start SQL with trace flag 902](/sql/relational-databases/errors-events/mssqlserver-912-database-engine-error#steps-to-start--with-trace-flag-902).

1. Repair the SQL Server installation per the procedure that's documented in [Repair a Failed SQL Server Installation](/sql/database-engine/install-windows/repair-a-failed-sql-server-installation). Alternatively, you can copy the missing file from a different system that has the same build as your SQL Server installation, and restore the file on the computer on which the installation is failing.

1. Remove TF 902 from startup parameters, and then restart SQL Server. After SQL Server starts without TF 902, the upgrade script will run again.

    - If the upgrade script finishes successfully, the SP or CU upgrade is complete. You can check the SQL Server error log and bootstrap folder to verify the completed installation.
    - If the upgrade script fails again, check the SQL Server error log for additional error entries, and then troubleshoot the new errors.
