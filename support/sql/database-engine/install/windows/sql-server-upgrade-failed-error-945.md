---
title: SQL Server upgrade fails with error code 945 if SSISDB is configured with AG
description: This article resolves an issue in which a cumulative update or service pack for SQL Server reports error 945 when you run database upgrade scripts.
ms.date: 08/17/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: jopilov, v-jayaramanp
---

# Error 945 and SQL Server upgrade fails if SSISDB is configured with AG

This article helps you troubleshoot an issue that occurs if a cumulative update (CU) or service pack (SP) for Microsoft SQL Server reports error code 945 when you run database upgrade scripts.

## Symptoms

When you apply a CU or SP, the Setup program returns the following error message:  

> Wait on the Database Engine recovery handle failed. Check the SQL Server error log for potential causes.  

Additionally, the following error entry might be logged in the SQL Server error log:

```output
Database 'master' is upgrading script 'SSIS_hotfix_install.sql' from level 201331031 to level 201331592.
Error: 945, Severity: 14, State: 2.
Database 'SSISDB' cannot be opened due to inaccessible files or insufficient memory or disk space. See the SQL Server errorlog for details.
Error: 912, Severity: 21, State: 2.
Script level upgrade for database 'master' failed because upgrade step 'SSIS_hotfix_install.sql' encountered error 945, state 2, severity 25. This is a serious error condition which might interfere with regular operation and the database will be taken offline. If the error happened during upgrade of the 'master' database, it will prevent the entire SQL Server instance from starting. Examine the previous errorlog entries for errors, take the appropriate corrective actions and re-start the database so that the script upgrade steps run to completion.
Error: 3417, Severity: 21, State: 3.
Cannot recover the master database. SQL Server is unable to run. Restore master from a full backup, repair it, or rebuild it. For more information about how to rebuild the master database, see SQL Server Books Online.
SQL Server shutdown has been initiated
```

## Cause

If your SQL Server Integration Services catalog database (SSISDB) is added to an Always On Availability Group (AG), the script upgrade can fail. The upgrade process runs in the single-user mode. However, an availability database must be a multi-user database. Therefore, during the upgrade installation, all availability databases, including SSISDB, are taken offline and aren't upgraded.

For more information, see the [Upgrading SSISDB in an availability group](/sql/integration-services/catalog/ssis-catalog#Upgrade).

## Resolution

To resolve the issue, follow these steps:

1. Remove SSISDB from the AG.
1. Run the CU upgrade on each node.
1. After the upgrade finishes, restore SSISDB to the AG.
