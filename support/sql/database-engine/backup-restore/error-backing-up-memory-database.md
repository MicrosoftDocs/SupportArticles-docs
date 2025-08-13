---
title: Warning in the error log can be ignored
description: This article describes a warning that occurs when backing up an in-memory database.
ms.date: 09/15/2020
ms.custom: sap:Database Backup and Restore
ms.reviewer: yqsu, ericbu, daleche
---
# Warning message that contains HkHostBackupGetCheckpointFileInfoV2 and 1000016 is logged in the SQL Server error log

This article describes a warning that occurs when backing up an in-memory database.

_Original product version:_ &nbsp; SQL Server 2016 Enterprise, SQL Server 2016 Enterprise Core  
_Original KB number:_ &nbsp; 4316959

## Symptoms

Assume that you have an in-memory database in SQL Server. If you back up the in-memory database, you may notice that the following warning message is logged in the SQL Server error log:

> [WARNING] **HkHostBackupGetCheckpointFileInfoV2** (). Database ID: [21]. Not a valid checkpoint file name. FileName: ffffffdd-fffffb17-fffd.00000022-000004e8-0002.4b987b24-bf74-485d-b32e-e7ddfb496457.0-0. **1000016**. (d:\b\s3\sources\sql\ntdbms\hekaton\sqlhost\sqlmin\hkhostbackup.cpp : 2958)

## More information

The warning message starts with **HkHostBackupGetCheckpointFileInfoV2** and ends with **1000016** in the FileName. Warning messages that have exactly these values are harmless, and you can safely ignore them. At some point SQL Server will delete them automatically.

The file in the *$FSLOG* folder is used internally for Filestream transaction integrity. SQL Server incorrectly interprets the warning message as a valid checkpoint of the in-memory database. In this case, SQL Server logs the warning to the SQL Server error log.
