---
title: Remove a virtual machine with the missing status
description: Explains how to remove a virtual machine that has a status of Missing from the Virtual Machine Manager console.
ms.date: 04/09/2024
ms.reviewer: wenca
---
# How to remove a missing virtual machine from the Virtual Machine Manager console

This article describes how to remove a virtual machine that has a status of **Missing** from the Virtual Machine Manager console by using a Microsoft SQL Server script.

_Original product version:_ &nbsp; System Center 2016 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager, System Center Virtual Machine Manager, version 1801, System Center Virtual Machine Manager, version 1807  
_Original KB number:_ &nbsp; 3102955

## Summary

Occasionally, after a cluster failover, duplicate virtual machines may appear in the Microsoft System Center Virtual Machine Manager (VMM) Administrator Console. One of these virtual machines has a status of **Missing**, and the other has a different status. The missing virtual machine can be difficult to remove. This article contains a SQL Server script that removes missing virtual machines.  

> [!NOTE]
> The script removes all virtual machines that have a status of **Missing** from the VMM database. The script doesn't delete any virtual machines from any host computer. This includes all Hyper-V, Virtual Server, and VMware-based hosts.

## Prepare your system

To prepare your system and run the script, follow these steps:

1. Close the VMM Administrator Console.
2. Stop the Windows service that is named **VMMService** on the VMM server.
3. Make a full backup of the VMM database.
4. Install Microsoft SQL Server Management Studio on the same computer on which the VMM database is stored.

   > [!TIP]
   > SQL Server Management Studio is a free download from Microsoft that you can get from [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms).

5. Open SQL Server Management Studio, select the VMM database, and then run the [SQL Server script](#sql-server-script). This should delete all missing virtual machines from the VMM database. If the script is successful, you see the following output:

   > Command(s) completed successfully.

6. After the SQL Server script has run, restart **VMMService**, and then open the VMM Administrator Console to verify that the missing virtual machines are deleted.

## SQL Server script

```sql
BEGIN TRANSACTION T1

DECLARE custom_cursor CURSOR FOR

SELECT ObjectId from

dbo.tbl_WLC_VObject WHERE [ObjectState] = 220

DECLARE @ObjectId uniqueidentifier

OPEN custom_cursor

FETCH NEXT FROM custom_cursor INTO @ObjectId

WHILE(@@fetch_status = 0)

 BEGIN

 DECLARE vdrive_cursor CURSOR FOR

 SELECT VDriveId, VHDId, ISOId from

 dbo.tbl_WLC_VDrive WHERE ParentId = @ObjectId

 DECLARE @VDriveId uniqueidentifier

 DECLARE @VHDId uniqueidentifier

 DECLARE @ISOId uniqueidentifier

 OPEN vdrive_cursor

 FETCH NEXT FROM vdrive_cursor INTO @VDriveId, @VHDId, @ISOId

 WHILE(@@fetch_status = 0)

 BEGIN

  DELETE FROM dbo.tbl_WLC_VDrive

         WHERE VDriveId = @VDriveId

  if(@VHDId is NOT NULL)

  BEGIN

   DELETE FROM dbo.tbl_WLC_VHD

   WHERE VHDId = @VHDId

   DELETE FROM dbo.tbl_WLC_PhysicalObject

   WHERE PhysicalObjectId = @VHDId

  END

  if(@ISOId is NOT NULL)

  BEGIN

   DELETE FROM dbo.tbl_WLC_ISO

          WHERE ISOId = @ISOId

   DELETE FROM dbo.tbl_WLC_PhysicalObject

   WHERE PhysicalObjectId = @ISOId

  END

     FETCH NEXT FROM vdrive_cursor INTO @VDriveId, @VHDId, @ISOId

   END

 CLOSE vdrive_cursor

 DEALLOCATE vdrive_cursor

-----------------

 DECLARE floppy_cursor CURSOR FOR

 SELECT VFDId, vFloppyId from

 dbo.tbl_WLC_VFloppy WHERE HWProfileId = @ObjectId

 DECLARE @vFloppyId uniqueidentifier

 DECLARE @vfdId uniqueidentifier

 OPEN floppy_cursor

 FETCH NEXT FROM floppy_cursor INTO @vfdId, @vFloppyId

 WHILE(@@fetch_status = 0)

 BEGIN

      DELETE FROM dbo.tbl_WLC_VFloppy

  WHERE VFloppyId = @vFloppyId

  if(@vfdid is NOT NULL)

  BEGIN

   DELETE FROM dbo.tbl_WLC_VFD

   WHERE VFDId = @vfdId

   DELETE FROM dbo.tbl_WLC_PhysicalObject

   WHERE PhysicalObjectId = @vfdId

  END

     FETCH NEXT FROM floppy_cursor INTO @vfdId, @vFloppyId

   END

 CLOSE floppy_cursor

 DEALLOCATE floppy_cursor

----------------

 DECLARE checkpoint_cursor CURSOR FOR

 SELECT VMCheckpointId from

 dbo.tbl_WLC_VMCheckpoint WHERE VMId = @ObjectId

 DECLARE @vmCheckpointId uniqueidentifier

 OPEN checkpoint_cursor

 FETCH NEXT FROM checkpoint_cursor INTO @vmCheckpointId

 WHILE(@@fetch_status = 0)

 BEGIN

      DELETE FROM dbo.tbl_WLC_VMCheckpointRelation

  WHERE VMCheckpointId = @vmCheckpointId

     FETCH NEXT FROM checkpoint_cursor INTO @vmCheckpointId

   END

 CLOSE checkpoint_cursor

 DEALLOCATE checkpoint_cursor

-------------------------

---------Clean checkpoint

 DELETE FROM dbo.tbl_WLC_VMCheckpoint

 WHERE VMId = @ObjectID

        exec [dbo].[prc_VMMigration_Delete_VMInfoAndLUNMappings] @ObjectId

        DECLARE @RefreshId uniqueidentifier

        exec [dbo].[prc_RR_Refresher_Delete] @ObjectId, @RefreshId

        DELETE FROM dbo.tbl_WLC_VAdapter

 WHERE HWProfileId = @ObjectId

        DELETE FROM dbo.tbl_WLC_VNetworkAdapter

 WHERE HWProfileId = @ObjectId

        DELETE FROM dbo.tbl_WLC_VCOMPort

 WHERE HWProfileId = @ObjectId

        DELETE FROM dbo.tbl_WLC_HWProfile

        WHERE HWProfileId = @ObjectId

        DELETE FROM dbo.tbl_WLC_VMInstance

        WHERE VMInstanceId = @ObjectId

 DELETE FROM dbo.tbl_WLC_VObject

 WHERE ObjectId = @ObjectId

    FETCH NEXT FROM custom_cursor INTO @ObjectId

  END

CLOSE custom_cursor

DEALLOCATE custom_cursor

COMMIT TRANSACTION T1
```
