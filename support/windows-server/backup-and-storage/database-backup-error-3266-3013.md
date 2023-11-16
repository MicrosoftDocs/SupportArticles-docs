---
title: Database backup/restore error 3266/3013
description: Resolves error 3266 or 3013 that occurs when you perform a database backup to disk or tape or a database restore from disk or tape.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, JHALMANS
ms.custom: sap:configuring-and-using-backup-software, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Error 3266 or 3013 when you perform a database backup to disk or tape or a database restore from disk or tape

This article provides helps to solve error 3266 or 3013 that occurs when you perform a database backup to disk or tape or a database restore from disk or tape.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 290787

## Symptoms

When you perform a database backup to disk or tape, or a restore from disk or tape, the following error message may occur:

SQL Server 7.0 Server:

> Msg 3266, Level 16, State 1, Line 1  
The Microsoft Tape Format (MTF) soft filemark database on backup device 'devicename' cannot be read, inhibiting random access.  
Server: Msg 3013, Level 16, State 1, Line 1  
Backup or restore operation terminating abnormally.

SQL Server 2000 Server:

> Msg 3266, Level 16, State 1, Line 1  
The backup data in 'devicename' is incorrectly formatted. Backups cannot be appended, but existing backup sets may still be usable.  
Server: Msg 3013, Level 16, State 1, Line 1  
BACKUP DATABASE is terminating abnormally.

SQL Server 2005 Server:

> Msg 3013, Level 16, State 1, Line 1  
The backup data at the end of 'devicename' is incorrectly formatted. Backup sets on the media might be damaged and unusable. To determine the backup sets on the media, use RESTORE HEADERONLY. To determine the usability of the backup sets, run RESTORE VERIFYONLY. If all of the backup sets are incomplete, reformat the media using BACKUP WITH FORMAT, which destroys all the backup sets.  
Server: Msg 3013, Level 16, State 1, Line 1
>
> BACKUP DATABASE is terminating abnormally.

## Cause

A filemark in the backup device could not be read. There are many reasons why you may encounter a filemark error. Some of the reasons include the following:

- A media failure may occur on the device where the backup is located.
- A write failure may occur during the creation of the backup.

    For example, a loss of connectivity may occur during a network backup. Or, a failure of the IO path to flush the write to disk may occur after the write to disk was reported to SQL server as successful.

## Workaround

To allow SQL Server to perform new backups to the backup device, you must manually delete or erase the device by using the following command:

```sql
BACKUP DATABASE mydatabase TO DISK='C:\MyDatabase.bak' with FORMAT
```

If the error message occurs during a restore operation, it may be possible to retrieve other backup sets from the device by specifying the file number. For example, if three (3) backups were on one (1) backup device, backup sets 1 and 2 may be usable. To determine if multiple backup sets are on a device, run the following code from Query Analyzer:

```sql
RESTORE HEADERONLY FROM DISK='C:\MyDatabase.bak'
```

Each backup set has one entry in the output. To indicate a specific backup set, use this code:

```sql
RESTORE DATABASE mydatabase FROM DISK='C:\MyDatabase.bak' WITH FILE = FileNumber
```

> [!NOTE]
> FileNumber is the backup set number you want to restore.

## More information

The following list contains important notes regarding backups and SQL Server.

- After SQL Server detects a filemark error on a device, SQL Server does not write additional information to the device.

- SQL Server stores all backups in the Microsoft Tape Format, whether the backup is made to disk or to tape. The Microsoft Tape Format uses filemarks to hold information such as the block size and the number of blocks in a backup, in addition to other information about the backup. The Microsoft Tape Format also uses filemarks to delimit backups in a backup device. The fact that a filemark is missing or is damaged, suggests that at least one backup on the device is not valid.

- Although you may be able to restore some backup sets from the damaged device, you must verify the integrity of the restored database.

- SQL Server logs details of success or of failure during a backup operation or a restore operation in the SQL Server error log and in the backup history tables in the msdb system database.

- If you experience an error 3266 when you restore a transaction log or a database backup, investigate the following logs for more information:
  - SQL Server error log
  - Backup and restore history tables
  - Application event log
  - System event log

If there are no details of the failure in these logs, you may have experienced an unreported failure. You should contact Microsoft Product Support Services if you need help.
