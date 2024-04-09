---
title: Troubleshoot 801 errors in VMM console 
description: Describes an issue that causes a refresh of virtual machines in Virtual Machine Manager to fail and to trigger a 801 error that indicates VMM cannot find the Virtual hard disk object. Occurs because of orphaned object information in the database. A resolution is provided.
ms.date: 04/09/2024
ms.reviewer: wenca, jarrettr, brenth, DPM-VMM
---
# 801 Missing %ObjectType and VmmAdminUI has stopped working errors in VMM

This article discusses how to troubleshoot the **801 Missing %ObjectType** and **VmmAdminUI has stopped working** errors in the System Center Virtual Machine Manager (SCVMM) console.

> [!NOTE]
> **Home users**: This article is only intended for technical support agents and IT professionals. If you're looking for help with a problem, please [ask the Microsoft Community](https://answers.microsoft.com/en-us).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager, Microsoft System Center 2012 R2 Virtual Machine Manager, System Center 2016 Virtual Machine Manager  
_Original KB number:_ &nbsp; 2756886

## Symptoms

These 801 errors are triggered by communication issues, database corruption, deleted files, or concurrent changes in Hyper-V.

The following are common errors that are logged in the **Jobs** view in the Virtual Machine Manager (VMM) console:

- When there's an 801 missing object:

  |Error|Description|Recommended action|
  |---|---|---|
  |801|VMM cannot find %ObjectType; object %FriendlyName;.|Make sure that the library object is valid, and then try the operation again. |
  
  For example:

  > Error (801)  
  > VMM cannot find VM object _ObjectID_.  
  > Recommended Action  
  > Ensure the library object is valid, and then try the operation again.

  Additionally, the following error is logged in a SCVMM ETL trace:

  > *** Carmine error was: LibObjectNotFound (801)

- You receive the following error messages when a virtual machine (VM) refresh job fails:

  - VMM cannot find VM object:

    :::image type="content" source="media/fix-scvmm-801-errors/vmm-cannot-find-vm-object-error.png" alt-text="Details of the VMM cannot find VM object error." border="false":::

  - VMM cannot find ISO object:

    :::image type="content" source="media/fix-scvmm-801-errors/vmm-cannot-find-iso-object-error.png" alt-text="Details of the VMM cannot find ISO object error." border="false":::

  - VMM cannot find VirtualHardDisk object:

    :::image type="content" source="media/fix-scvmm-801-errors/vmm-cannot-find-virtualharddisk-object-error.png" alt-text="Details of the VMM cannot find VirtualHardDisk object error." border="false":::

- You receive the following error message when you try to open the properties of a VM that has an 801 issue:

  > VmmAdminUI has stopped working

   :::image type="content" source="media/fix-scvmm-801-errors/vmmadminui-has-stopped-working-error.png" alt-text="Details of the VmmAdminUI has stopped working error." border="false":::

  The following information is displayed when you view problem details for the error or when you view the Windows Error Reporting log in MSINFO32:

   :::image type="content" source="media/fix-scvmm-801-errors/event-clr20r3.png" alt-text="Details of Windows Error Reporting logging in MSINFO32.":::

  > [!NOTE]
  > When a virtual machine is in a failed state via an 801 error, you cannot delete it from the console.

- You may receive the following error message:

  > Error (20413)  
  > VMM encountered a critical exception and created an exception report at C:\ProgramData\VMMLogs\SCVMM.

## Cause

This issue may occur if VMM has orphaned records in the database that show objects that no longer exist.

## Resolution

To resolve this issue, delete the orphaned objects from the database by following these steps:

1. Determine whether the virtual machine is located on the host and if it's running or is stopped.

   - If the VM is located on the host but cannot be started, verify that the object identified in the error message exists. For example, if the error states that it cannot find the virtual hard disk, navigate to the location where the hard disk is supposed to be stored, and then go to step 2.
   - If you don't know where the VHDX file is located, and the virtual machine is in a running state, run `Get-SCVirtualMachine -VMMServer localhost -Name "<VMNAME>"` in PowerShell on the SCVMM server, and then view the VM's VHDX location in the **location** line.

     - If the VHDx file is not in that location, that's the problem.
     - If the VHDx is in that location, and the VM can be started in Hyper-V, go to step 2 to resolve the issue in the VMMAdminUI.

2. Run `get-scvirtualmachine <VMNAME> | Remove-scvirtualmachine -force` to remove the VM from the VMM console.

   > [!NOTE]
   > This does not delete the VM files.

   If the VM is removed from the SCVMM console, right-click the host, and then click **Refresh Virtual Machines**. Or, close and reopen the console.

   If the PowerShell command does not work, you must remove the VM from the SQL VirtualMachineDB database by running a script.

   > [!IMPORTANT]
   > Back up the VMM database before you do anything.

   To determine where the SCVMM database is being hosted from, go to **Settings**, and then click **General**. The database connection is shown as follows:

   :::image type="content" source="media/fix-scvmm-801-errors/database-connection.png" alt-text="Details of database connection information.":::

3. In SQL Server Management Studio on the SQL server that hosts the SCVMM database, open the SQL instance. In the Databases folder on the left, select **VirtualManagerDB** (or whatever the database was renamed as), and make sure that the name of the database is listed in the drop-down list on the toolbar. Select **New Query**, and then paste the following script into the query field:

    ```sql
    BEGIN TRANSACTION T1
    DECLARE custom_cursor CURSOR FOR
    SELECT ObjectId from
    dbo.tbl_WLC_VObject WHERE [Name] = 'VMName'
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

    The only modification that you have to make in this script is in the fourth line, where you'll change _VMNAME_ to the name of the VM you want to remove, still using single quotation marks. Then, you can run the script, and it will return a series of rows that are affected as follows.

    :::image type="content" source="media/fix-scvmm-801-errors/change-vmname.png" alt-text="Change the name of V M in Object Explorer.":::

    > [!NOTE]
    > This does not delete the VM files.

4. Return to the SCVMM UI. You may see two instances of the VM that you ran the SQL script against. Right-click the host, and then click **Refresh Virtual Machines**. Or, you may have to close and reopen the console to reread the database.

## More Information

This resolution can also be used for 801 errors that occur when you perform a physical to virtual conversion (P2V).
