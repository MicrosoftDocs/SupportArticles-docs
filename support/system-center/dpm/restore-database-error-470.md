---
title: Error 470 when restoring a DPM database
description: Fixes an issue that triggers an Invalid object name error when you try to restore a Data Protection Manager database by using the DpmSync utility.
ms.date: 07/23/2020
---
# Error ID 470 when you run the DpmSync –RestoreDb command in Data Protection Manager

This article helps you fix an issue where you receive the **Invalid object name** error when you run the `DpmSync –RestoreDb` command to restore a Data Protection Manager (DPM) database.

_Original product version:_ &nbsp; System Center Data Protection Manager version 1801, System Center 2016 Data Protection Manager, System Center 2012 R2 Data Protection Manager, System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 2968666

## Symptoms

When you use the DpmSync utility to restore a Microsoft System Center Data Protection Manager database, the restore operation fails, and you receive the following error message:

> Error ID: 470  
> DPM database is not present in the instance of SQL Server. Check that the DPM database is present in the given instance of SQL Server.
>
> Detailed Error: Invalid object name 'dpmdb.dbo.sysfiles'.

## Cause

A new feature was introduced in Data Protection Manager 2012 that allows multiple DPM servers to share a single SQL Server instance. To allow that feature to work, the DPM database name is no longer hard-coded as DPMDB. However, the DpmSync utility is hard-coded to look for the DPMDB name when it runs a restore operation by using a .mdf file. So you may have to restore by using a .mdf file after you recover a DPM database from a disk, tape, or online-based recovery point that was created by a DPM server.

This error occurs only when the following conditions are true:

- The name of the DPM database that you're restoring isn't DPMDB.
- When you specify the `-DbLoc` parameter, you're restoring from a .mdf file, not from a .bak file.

For example, the following command fails:

`DpmSync –RestoreDb -DbLoc c:\restored\MSDPM2012$DPMDB_WINB_DPM.mdf -InstanceName (local) -dpmdbname DPMDB_WINB_DPM`

## Resolution

Before you use the DpmSync utility to restore the DPM database, rename **DPMDB_<machine_name>** as **DPMDB**:

1. Start SQL Server Management Studio, and then connect to the SQL Server instance that's used by this DPM server.
2. Under **Databases**, locate the DPM database that you want to restore.
3. Note the database name. (This is usually **DPMDB_<machine_name>**.) Right-click the database, and then rename it as **DPMDB**.
4. Restore the database by using the DpmSync utility and by specifying `-dpmdbname DPMDB`.
5. After the restore operation is complete, revert the DPMDB back to its original name, as noted in step 3.

> [!IMPORTANT]
> The DPM service can't be started until you revert the DPMDB back to its original name and then run the `DpmSync -Sync` command.

Alternatively, you can restore the database by using SQL Server Management Studio and then by running the `DpmSync -Sync` command.

## More information

The following example shows an attempt to restore the same database file after you rename the DPM database as DPMDB:

> C:\restored>dpmsync -restoredb -dbloc c:\restored\MSDPM2012$DPMDB_WINB_DPM.mdf -instancename (local) -dpmdbname DPMDB  
> DpmSync 2.0 - DPM database synchronization command-line tool  
> Copyright (c) 2013 Microsoft Corporation. All rights reserved.
>
> Copying file from 'c:\restored\msdpm2012$dpmdb_winb_dpm.mdf' to 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MSDPM2012$DPMDB_WINB_DPM.mdf.recovered'  
> Copying file from 'c:\restored\msdpm2012$dpmdb_winb_dpm_log.ldf' to 'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\MSDPM2012$DPMDB_WINB_DPM_log.ldf.recovered'  
> Files copied successfully.  
> Database detached successfully.  
> Renamed file 'MSDPM2012$DPMDB_WINB_DPM.mdf.recovered' to 'MSDPM2012$DPMDB_WINB_DPM.mdf'  
> Renamed file 'MSDPM2012$DPMDB_WINB_DPM_log.ldf.recovered' to 'MSDPM2012$DPMDB_WINB_DPM_log.ldf'  
> Database attached successfully.  
> Error ID: 453  
> The DPM service failed to start. Check the application and system event logs for information on the error.
>
> Detailed Error: Time out has expired and the operation has not been completed.

Now, rename the DPM database as its original name before you continue with `DpmSync -Sync` command.

> [!NOTE]
> The DPM role configuration of this server will also be rolled back during this operation.

> DPM Synchronization completed.  
> Your tape library status may have changed.  
> Recommendation: Go to the Library tab in the Management Task Area of the DPM Administration Console and choose the Inventory Library action.
