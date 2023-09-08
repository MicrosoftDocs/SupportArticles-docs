---
title: Backup operation in the backupset history table
description: This article describes a "by design" behavior that occurs when you use VSS to back up files on a volume.
ms.date: 09/25/2020
ms.custom: sap:Administration and Management
ms.reviewer: kfarlee
---
# SQL Server records a backup operation in the backupset history table when you use VSS to back up files on a volume

This article describes a "by design" behavior that occurs when you use VSS to back up files on a volume.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 951288

## Symptoms

When you use a Volume Shadow Copy Service (VSS) application to backup files on a volume that includes SQL Server database files, SQL Server records a backup operation in the `backupset` history table. This behavior occurs even if you did not actually back up the database files of SQL Server.

## Cause

This behavior occurs because VSS application calls the SQLWriter service on the system during backup operation. For more information on how VSS applications interact with SQL Writer, review SQL Server Back up Applications - Volume Shadow Copy Service (VSS) and SQL Writer.

## Precautions to take if you use the entries in the backupset history table for data recovery

If you want to use entries in the `backupset` history table for data recovery, you must verify that the entries represent actual database backup operations.

## Verify that an entry represents a native database backup operation (as opposed to a VSS snapshot backup)

To do this, run the following statement:

```sql
USE msdb
GO

SELECT server_name, database_name, backup_start_date, is_snapshot, database_backup_lsn
FROM backupset
```

In the result, notice the `database_backup_lsn` column and the `is_snapshot` column. An entry that represents a native database backup operation has the following characteristics:

- The value of the `database_backup_lsn` column is not **0**.
- The value of the `is_snapshot` column is **0**.

## Verify that the backup set has no errors

To do this, run the following statement:

```sql
WITH backupInfo AS( SELECT database_name AS [DatabaseName],
name AS [BackupName], is_damaged AS [BackupStatus],
backup_start_date AS [backupDate],
ROW_NUMBER() OVER(PARTITION BY database_name
ORDER BY backup_start_date DESC) AS BackupIDForDB
FROM msdb..backupset) SELECT DatabaseName
FROM backupinfo WHERE BackupIDForDB = 1 and BackupStatus=1
```

If this query returns any results, it means that you do not have good database backups after the reported date. We strongly recommend that you perform a full database backup as soon as possible and verify that the full database backup is clean.

## The is_damaged property

The `backupset` table in the msdb database contains a row for each backup set. The `is_damaged` property in the `backupset` table indicates whether damage to the database was detected when the backup was created. Therefore, the backup may be damaged and not restorable.

