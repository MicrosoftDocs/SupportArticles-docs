---
title: Errors occur when using SoFS shares
description: Errors occur when you use Scale-Out File Server shares after you upgrade to System Center 2016 Virtual Machine Manager. Provides a resolution.
ms.date: 04/09/2024
ms.reviewer: wenca, kaushika, paulw, brenth
---
# Errors occur when using SoFS shares after upgrading to System Center 2016 Virtual Machine Manager

This article fixes an issue in which you receive error messages when you use Scale-Out File Server shares after you upgrade to System Center 2016 Virtual Machine Manager.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager  
_Original KB number:_ &nbsp; 4021611

## Symptoms

You use Scale-Out File Server (SoFS) shares in System Center 2012 R2 Virtual Machine Manager. After you upgrade to System Center 2016 Virtual Machine Manager, you may receive the following error messages.

- When you refresh a virtual machine, you receive one of the following error messages:

  > Error (802)  
  > The 'VirtualHardDisk' 'system' is already in use by another 'VirtualHardDisk'.
  >
  > Recommended Action  
  > Wait for the object to become available, and then try the operation again.

  > Error (801)  
  > VMM cannot find VirtualHardDisk object 00000000-0000-0000-0000-000000000000.
  >
  > Recommended Action  
  > Ensure the library object is valid, and then try the operation again.

- When you try to create a new virtual machine, you get this error:

  > VMM cannot find a required object.  
  > Ensure the object is valid, and then try the operation again.

- When you examine a System Center Virtual Machine Manager ETL trace log, you find the following exception:

  > System.Data.SqlClient.SqlException (0x80131904): The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_tbl_WLC_PhysicalObject_tbl_ADHC_HostVolume".
  >
  > The conflict occurred in database "VirtualManagerDB", table "dbo.tbl_ADHC_HostVolume", column 'VolumeID'.  The statement has been terminated.

>[!NOTE]
>
> - This issue can also cause you to be unable to get host ratings for any host that uses one of the affected SoFS shares.
> - This issue does not occur in a fresh (not upgraded) System Center 2016 Virtual Machine Manager environment.

## Cause

This issue occurs because the database is put into an inconsistent state in the following scenario:

1. You add a SoFS server and shares to System Center Virtual Machine Manager.
2. The SoFS shares are managed by System Center Virtual Machine Manager.
3. You assign the SoFS shares to one or more hosts.
4. You remove the **Storage Provider** entry that was created for the SoFS server but don't remove the individual shares before removing the entry. This may occur if you remove the SoFS server by using the user interface or you execute the `Remove-SCStorageProvider` PowerShell cmdlet.

When these steps are done in this listed order, the System Center Virtual Machine Manager database table `tbl_ST_StorageFileShare` doesn't have the `AssociatedVolumeID` column set to **NULL** for SoFS shares. In System Center 2012 R2, this issue did not have any effect. However, System Center 2016 Virtual Machine Manager is more dependent on this setting.

## Resolution

To resolve this issue, execute the following SQL statement against your System Center Virtual Machine Manager database to correctly update the `AssociatedVolumeID` values in the `tbl_ST_StorageFileShare` table:

```sql
update tbl_ST_StorageFileShare set AssociatedVolumeID = NULL where AssociatedVolumeID not in (select VolumeID from tbl_ADHC_HostVolume)
```
