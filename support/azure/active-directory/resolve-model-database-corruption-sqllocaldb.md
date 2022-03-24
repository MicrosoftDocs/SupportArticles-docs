---
title: Resolve Model database corruption in SQLLocalDB
description: This article describes how to resolve a known issue in SQLLocalDB that can prevent the ADSync service from starting because of a corrupted "Model" database.
ms.date: 03/21/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: nualex
editor: v-jsitser
ms.service: active-directory
ms.subservice: enterprise-users
keywords:
#Customer intent: As an Azure Active Directory user, I want to resolve Model database corruption in SQLLocalDB so that I can start and run the ADSync service.
---
# Resolve Model database corruption in SQLLocalDB

This article describes a known issue in the [SQLLocalDB utility](/sql/tools/sqllocaldb-utility) that can prevent the ADSync service from starting because of a corrupted `Model` database. This issue mainly affects Azure Active Directory (Azure AD) Connect&nbsp;2._x_ servers that run on a Microsoft SQL Server 2019 LocalDB.

The issue is caused by a bug in the SQL Server backup logic that creates an inconsistent state in the SQL Server `Model` database start page. After a backup occurs, the `Model` database is set to `FULL` recovery mode (`dbi_status` == 0x40010000), and the `dbi_dbbackupLSN` (the log sequence number (LSN) for the database backup) is set to a value that points to a log file. However, the actual recovery mode that is governed by the `Master` database is `SIMPLE`.

In `SIMPLE` recovery mode, database logs are truncated automatically. In `FULL` recovery mode, logs are truncated only after a backup. When SQLLocalDB is restarted after the log file is truncated, it detects a backup LSN that's earlier than the earliest log file. Therefore, it won't start the service.

Review the guidance in the next sections to learn how to do the following tasks:

- Correctly identify whether the Azure AD Connect service (ADSync) doesn't start because of `Model` database corruption.

- Mitigate the issue by recovering the `Model` database from a corrupted state.

- Apply a permanent fix to make sure that this `Model` database corruption doesn't occur again.

## Symptoms

You can verify that the issue is based on the following events in the Azure AD Connect server:

- Event Viewer: Application, EventID 528, Source: SQLLocalDB 15.0

  ```output
  WaitForMultipleObjects
  575
  {Application Error}
  The application was unable to start correctly (0x%lx). Click OK to close the application.
  3714
  ```

- Event Viewer: Application, EventIDs 2005 and 6226, Source: ADSync

  ```output
  0x8023044a
  OriginalError=0x80004005 OLEDB Provider error(s):
  Description  = 'Login timeout expired'
  Failure Code = 0x80004005 
  ```

- SQLLocalDB *error.log* file in *\<ADSync service profile path>\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ADSync2019*

  ```output
  <yyyy-MM-dd HH:mm:ss.##> spid14s     The resource database build version is 15.00.4138. This is an informational message only. No user action is required.
  <yyyy-MM-dd HH:mm:ss.##> spid8s      Starting up database 'msdb'.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     Starting up database 'model'.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     Error: 9003, Severity: 20, State: 1.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     The log scan number (41:488:1) passed to log scan in database 'model' is not valid. This error may indicate data corruption or that the log file (.ldf) does not match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     SQL Trace was stopped due to server shutdown. Trace ID = '1'. This is an informational message only; no user action is required.
  ```

## Mitigation

To recover the `Model` database from a corrupted state, follow these steps:

1. Go to one of the following ADSync Service profile locations, depending on the service account that's running (such as a domain account, virtual service account, or managed service account):

    - *C:\\Users\\\<service account>\\*
    - *C:\\Users\\ADSyncMSAxxxx$\\*
    - *C:\\Windows\\ServiceProfiles\ADSync\\*

1. Open the *error.log* file from the ADSync2019 instance folder in the following directory path:

   *\<service profile path>\\AppData\\Local\\Microsoft\\Microsoft SQL Server Local DB\\Instances\\ADSync2019\\*

1. Find the following error entry in the log to verify that the `Model` database is corrupted:

    ```output
    <yyyy-MM-dd HH:mm:ss.##> spid14s     Error: 9003, Severity: 20, State: 1.
    <yyyy-MM-dd HH:mm:ss.##> spid14s     The log scan number (41:488:1) passed to log scan in database 'model' is not valid. This error may indicate data corruption or that the log file (.ldf) does not match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup.   
    ```

1. If error "9003" exists in this entry, rename the *model.mdf* and *modellog.ldf* files in this folder to *old_model.mdf* and *old_modellog.ldf*, respectively.

1. Open the *SQL Templates* folder at *C:\\Program Files\\Microsoft SQL Server\\150\\LocalDB\\Binn\\Templates*.

1. Copy the *model.mdf* and *modellog.ldf* files to the ADSync2019 instance folder from step 2.

1. Start the ADSync service.

## Solution

To apply the solution, SQLLocalDB service must be in a running state. Before you continue to use this solution, you must apply the steps from the [Mitigation](#mitigation) section if the SQLLocalDB service can't start because of a corrupted `Model` database.

1. Open an administrative Command Prompt window.

1. Run the following SQLLocalDB command:

    ```cmd
    SQLLocalDB.exe I .\ADSync2019
    ```

1. Copy the instance pipe name from the SQLLocalDB command output (for example, `np:\\.\pipe\LOCALDB#<database id>\tsql\query`).

1. Run the following [sqlcmd](/sql/tools/sqlcmd-utility) command by using the instance pipe name that you copied from the previous step:

    ```cmd
    SQLCMD.exe -S <instance pipe name>
    ```

    You should now be connected to an ADSync2019 SQL LocalDB instance, and you should see a SQL Server command prompt (`#>`).

1. Run the following Transact-SQL statements:

    ```tsql
    SELECT recovery_model_desc 
    FROM sys.databases
    WHERE name = 'model';
    GO
   ```

    The output should verify that the value of `recovery_model_desc` is `SIMPLE`:

    ```output
    recovery_model_desc
    ------------------------------------------------------------
    SIMPLE
    ```

1. If the SQL Server recovery mode is `SIMPLE`, run the following set of Transact-SQL commands:

    ```tsql
    DROP TABLE IF EXISTS #modeldbinfo
    CREATE TABLE #modeldbinfo (
        [ParentObject] nvarchar(100),
        [Object] nvarchar(200),
        [Field] nvarchar(200),
        [VALUE] nvarchar(1000)
    )
    INSERT INTO #modeldbinfo ([ParentObject], [Object], [Field], [Value])
    EXEC ('dbcc dbinfo(model) WITH tableresults')
    SELECT [Field], [VALUE]
    FROM #modeldbinfo
    WHERE [Field]
    IN ('dbi_status', 'dbi_dbbackupLSN', 'dbi_LogBackupChainOrigin', 'dbi_LastLogBackupTime')
    ORDER BY [Field]
    GO
    ```

1. Analyze the output from the previous step to verify that the `dbi_status` value is **0x40010000**:

    ```output
    dbi_status
                 0x40010000
    ```

   This value proves that the `Model` database is corrupted. If this value is something different, the issue is resolved, and you don't have to do anything else.

1. To permanently fix the `Model` database recovery model on your SQLLocalDB service, run the following commands to flip the recovery mode to `FULL` and then revert it to `SIMPLE`:

    ```tsql
    ALTER DATABASE [model] SET RECOVERY FULL ;
    ALTER DATABASE [model] SET RECOVERY SIMPLE ;
    GO
    ````

1. Repeat step 6 to verify that the recovery mode is fixed. The `dbi_status` should show the correct value of **0x40010008**.

    ```output
    dbi_status
                 0x40010008
    ```

After you apply this solution, `dbi_dbbackupLSN` will remain null after a new backup is run. Then, the ADSync service will be able to start, and the `Model` database will no longer be inconsistent.
