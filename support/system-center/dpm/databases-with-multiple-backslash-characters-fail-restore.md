---
title: Error 30111 when restoring databases with multiple backslashes
description: Fixes an issue where you receive error ID 30111 when you try to restore a database that contains multiple backslash characters in Data Protection Manager
ms.date: 07/24/2020
---
# Databases with multiple backslash characters can be protected but fail during restore

This article helps you fix an issue where you receive error ID 30111 when you try to restore a database that contains multiple backslash characters in Data Protection Manager.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2550085

## Symptoms

When you create a new SQL Server database (or it's created automatically by an application), and there are multiple backslash (\\) characters defined in the database data or log file physical path (like C:\\\SQL\test.mdf), you will encounter the following error when you protect this database with System Center Data Protection Manager 2010 and try to recover it to an alternate SQL Server instance. After you start the recovery process, you see an error in DPM console:

> The VSS application writer or the VSS provider is in a bad state. Either it was already in a bad state or it entered a bad state during the current operation. (ID 30111)

Also on the target SQL Server, the database cannot be restored. A SQLWRITER 24583 error event is logged in the Application log with the following message:

> Sqllib error: OLEDB Error encountered calling ICommandText::Execute. hr = 0x80040e14. SQLSTATE: 42000, Native Error: 3013  
> Error state: 1, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: RESTORE DATABASE is terminating abnormally.  
> SQLSTATE: 42000, Native Error: 3119  
> Error state: 1, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: Problems were identified while planning for the RESTORE statement. Previous messages provide details.  
> SQLSTATE: 42000, Native Error: 3156  
> Error state: 4, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: File 'DPMBackup_log' cannot be restored to 'C:\\DPMBackup\DPMBackup_log.ldf'. Use WITH MOVE to identify a valid location for the file.  
> SQLSTATE: 42000, Native Error: 1834  
> Error state: 1, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: The file 'C:\\\DPMBackup\DPMBackup_log.ldf' cannot be overwritten. It is being used by database 'DPMBackup'.  
> SQLSTATE: 42000, Native Error: 3156  
> Error state: 4, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: File 'DPMBackup' cannot be restored to 'C:\\\DPMBackup\DPMBackup.mdf'. Use WITH MOVE to identify a valid location for the file.  
> SQLSTATE: 42000, Native Error: 1834  
> Error state: 1, Severity: 16  
> Source: Microsoft SQL Server Native Client 10.0  
> Error message: The file 'C:\\\DPMBackup\DPMBackup.mdf' cannot be overwritten. It is being used by database 'DPMBackup'.

Note that backup jobs will run without any issues, and when the database is added, SQL Server will accept the path with multiple backslash characters and create the database. Later when you check the physical path of the database files in SQL Server Management Studio, you see only one backslash character, as the GUI hides the others.

You can check the original physical path of the database files with the following query:

```sql
SELECT * FROM Sys.Database_files
```

As SQL VSS Writer returns with the path visible in the result of the above query, DPM also uses this path for recovery processes.

## Resolution

To avoid the above error, always add new databases with single backslash characters in the database file path, and also ensure application-generated databases also use only one backslash character.

The above error doesn't occur if you try to recover the database to the original SQL Server instance or to a network folder.

If you already protect a database that contains multiple backslashes in the physical path for the database files, you need to recover it to the original SQL Server instance. Or, if it's not available, then restore to a network folder and then attach the database files to a different SQL Server instance.

In the case you restore to the original instance, change the physical path for the database files after these are restored to not contain multiple backslash characters and then you will be able to recover further backups to an alternate SQL Server instance. You can quickly achieve this by detaching the database and attaching it with single backslashes in the path again.

## More information

If secondary protection is enabled, DPMMetadata.xml will be generated on the primary DPM server. Here you can also see the path used by DPM for SQL Server database protection.
