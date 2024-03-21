---
title: Resolve Model database corruption in SQLLocalDB
description: This article describes how to resolve a known issue in SQLLocalDB that can prevent the ADSync service from starting because of a corrupted "Model" database.
ms.date: 07/21/2022
ms.reviewer: nualex, v-leedennis
editor: v-jsitser
ms.service: entra-id
ms.subservice: users
keywords:
#Customer intent: As a Microsoft Entra user, I want to resolve Model database corruption in SQLLocalDB so that I can start and run the ADSync service.
---
# Resolve Model database corruption in SQLLocalDB

This article describes a known issue in the [SQLLocalDB utility](/sql/tools/sqllocaldb-utility) that can prevent the ADSync service from starting because of a corrupted `Model` database. This issue mainly affects Microsoft Entra Connect&nbsp;2._x_ servers that run on a Microsoft SQL Server 2019 LocalDB.

The issue is caused by a bug in the SQL Server backup logic that creates an inconsistent state in the SQL Server `Model` database start page. After a backup occurs, the `Model` database is set to `FULL` recovery mode (`dbi_status` == 0x40010000), and the `dbi_dbbackupLSN` (the log sequence number (LSN) for the database backup) is set to a value that points to a log file. However, the actual recovery mode that is governed by the `Master` database is `SIMPLE`.

In `SIMPLE` recovery mode, database logs are truncated automatically. In `FULL` recovery mode, logs are truncated only after a backup. When SQLLocalDB is restarted after the log file is truncated, it detects a backup LSN that's earlier than the earliest log file. Therefore, it won't start the service.

Review the guidance in the next sections to learn how to do the following tasks:

- Correctly identify whether the Microsoft Entra Connect service (ADSync) doesn't start because of `Model` database corruption.

- Mitigate the issue by recovering the `Model` database from a corrupted state.

- Apply a permanent fix to make sure that this `Model` database corruption doesn't occur again.

## Symptoms

You can verify that the issue is based on the following events in the Microsoft Entra Connect server:

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

- SQLLocalDB _error.log_ file in *\<ADSync service profile path>\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\ADSync2019*

  ```output
  <yyyy-MM-dd HH:mm:ss.##> spid14s     The resource database build version is 15.00.4138. This is an informational message only. No user action is required.
  <yyyy-MM-dd HH:mm:ss.##> spid8s      Starting up database 'msdb'.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     Starting up database 'model'.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     Error: 9003, Severity: 20, State: 1.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     The log scan number (41:488:1) passed to log scan in database 'model' is not valid. This error may indicate data corruption or that the log file (.ldf) does not match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup.
  <yyyy-MM-dd HH:mm:ss.##> spid14s     SQL Trace was stopped due to server shutdown. Trace ID = '1'. This is an informational message only; no user action is required.
  ```

## Mitigation

> [!IMPORTANT]
> Only apply the mitigation steps that are described here if all of these conditions occur:
>
> - The version of Microsoft Entra Connect is 2.0.*x.x*.
>
> - Microsoft Entra Connect is installed with SQL LocalDB.
>
> - *All* of the conditions that are listed in [Symptoms](#symptoms) are present.

To recover the `Model` database from a corrupted state, follow these steps:

1. Go to one of the following ADSync Service profile locations, depending on the service account that's running (such as a domain account, virtual service account, or managed service account):

    - *C:\\Users\\\<service account>\\*
    - *C:\\Users\\ADSyncMSAxxxx$\\*
    - *C:\\Windows\\ServiceProfiles\ADSync\\*

1. Open the _error.log_ file from the ADSync2019 instance folder in the following directory path:

   *\<service profile path>\\AppData\\Local\\Microsoft\\Microsoft SQL Server Local DB\\Instances\\ADSync2019\\*

1. Find the following error entry in the log to verify that the `Model` database is corrupted:

    ```output
    <yyyy-MM-dd HH:mm:ss.##> spid14s     Error: 9003, Severity: 20, State: 1.
    <yyyy-MM-dd HH:mm:ss.##> spid14s     The log scan number (41:488:1) passed to log scan in database 'model' is not valid. This error may indicate data corruption or that the log file (.ldf) does not match the data file (.mdf). If this error occurred during replication, re-create the publication. Otherwise, restore from backup if the problem results in a failure during startup.   
    ```

1. If error "9003" exists in this entry, rename the _model.mdf_ and _modellog.ldf_ files in this folder to _old_model.mdf_ and _old_modellog.ldf_, respectively.

1. Open the _SQL Templates_ folder at *C:\\Program Files\\Microsoft SQL Server\\150\\LocalDB\\Binn\\Templates*.

1. Copy the _model.mdf_ and _modellog.ldf_ files to the ADSync2019 instance folder from step 2.

1. Start the ADSync service.

## Solution

Microsoft has introduced a fix for this issue in Microsoft Entra Connect version 2.1.1.0. If the sync service (ADSync) can't be started, you need to apply the steps in the [Mitigation](#mitigation) section before you can upgrade Microsoft Entra Connect.

To prevent the corruption issues in the SQLLocalDB `Model` database, install the latest Microsoft Entra Connect build, which is available at [Microsoft Entra Connect: Version release history](/azure/active-directory/hybrid/reference-connect-version-history).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
