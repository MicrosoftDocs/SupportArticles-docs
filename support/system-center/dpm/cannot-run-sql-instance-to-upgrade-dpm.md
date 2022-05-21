---
title: Can't upgrade to DPM 2012
description: Discusses that an upgrade to System Center Data Protection Manager 2012 fails if you use a manually installed instance of SQL Server 2008 R2. Provides a resolution.
ms.date: 07/27/2020
ms.reviewer: mjacquet
---
# Upgrade to DPM 2012 fails if you use a manually installed instance of SQL Server 2008 R2

This article helps you fix an issue in which you can't upgrade to Microsoft System Center 2012 Data Protection Manager (DPM 2012) if you use a manually installed instance of SQL Server 2008 R2.

_Original product version:_ &nbsp; System Center 2012 Data Protection Manager  
_Original KB number:_ &nbsp; 2795977

## Symptoms

You cannot select the **Use the dedicated instance of SQL Server** option when you upgrade to System Center 2012 Data Protection Manager because the option is unavailable. When you point the installer to an existing local installation of DPM, you receive the following error message:

> You cannot choose the instance "instance name" on the local machine ID 4324. Specify a different instance.

## Cause

This problem occurs because the current instance of a local Microsoft SQL Server 2008 R2 installation is named **MSDPM2012**. You cannot run an instance of SQL Server that's named **MSDM2012** during an upgrade from System Center Data Protection Manager 2010 to DPM 2012.

## Resolution

To resolve this problem and complete the upgrade process, follow these steps.

> [!IMPORTANT]
> Make sure that you have the DPM 2010 installation media and license key (if applicable) before you proceed.

### Step 1: Update and replace the DPM 2010 installation

1. Download and install [hotfix 2751231](https://support.microsoft.com/help/2751231) that contains DPM agent version 3.0.8180, if you are not already running this version. You will also reinstall this hotfix in a later step.

2. Cancel all scheduled jobs for the next two hours so that they don't interfere with the upgrade. Wait for all currently running jobs to finish.
3. Make a backup of the current DPMDB database in the C:\Temp folder by running the following command:

    ```console
    dpmbackup -db -instancename (LOCAL) -targetlocation c:\temp
    ```  

4. Make sure that the Dpmdb.bak file exists. Then, rename it to Dpmdb8195.bak. To do this, run the following command in the C:\Users\Administrator.SCSDPM folder:

    ```console
    ren c:\temp\dpmdb.bak dpmdb8195.bak
    ```  

5. In the **Programs and Features** item in Control Panel, uninstall System Center Data Protection Manager 2010. When you're prompted to retain or delete the protected data, select **Retain**.
6. After DPM 2010 is removed, reinstall the program. When you're prompted by the SQL Server selection screen, select the first option to let DPM install its own SQL Server instance that's named **MSDPM2010**.

    > [!NOTE]
    > If you receive an error message that states that the database already exists, start SQL Server Management Studio, and then connect the local instance and delete the DPMDB database. This deletes the database files from the `C:\Program Files\Microsoft DPM\DPM\DPMDB` folder.

7. Complete the DPM 2010 installation process.
8. Open the DPM 2010 console to make sure that it works correctly, and then close it.
9. Install the hotfix 2751231 file that you downloaded in step 1.

    > [!IMPORTANT]
    > You must perform this step to update the database schema to version 3.0.8195.

10. Restart the DPM server.
11. Restore the 3.0.8195 DPM database from the C:\Dpm8195.bak file by running the following commands at an administrative command prompt:

    ```console
    Dpmsync -restoredb -dbloc c:\temp\dpmdb8195.bak
    ```

    > [!NOTE]
    > The DPM role configuration of this server will also be rolled back during this operation.

12. Run the following command to synchronize the database:

    ```console
    dpmsync -sync
    ```

    Notes

    - This command confirms the status of the mount points and shadow copies.
    - All recovery points will be retained.
    - After you run this command, you receive the following message:

        > DPM Synchronization completed.  
        > Your tape library status may have changed.  
        > Recommendation: Go to the Library tab in the Management Task Area of the DPM Administration Console and choose the Inventory Library action.

After you complete these steps, you should be able to open the DPM 2010 console to verify that all your protection groups are listed. All protected data sources will be labeled as **Inconsistent**. This is expected behavior.

### Step 2: Upgrade to DPM 2012

1. Start SQL Server Management Studio, and then connect to the MSDPM2012 instance.
2. Delete the DPM database so that the upgrade process can re-create it.
3. Start the DPM upgrade process. Make sure that you resolve any prerequisite checks, such as for the accounts that are used in the DPM 2012 instance. (During this check, use same accounts that are used in the DPM 2010 instance.)
4. Open the DPM console, upgrade the agents, and then run the consistency checks until all the data sources are displayed as green.

### Step 3: Repair the DPM database and SQL Server log file

A small regression was introduced in [Update Rollup 3 for System Center 2012](https://support.microsoft.com/help/2756127) in which Windows SharePoint catalog jobs caused the DPM database and SQL Server log file to become bloated. To repair the database and log file, follow these steps:

1. Back up the DPM database again by running the following command:

    ```console
    dpmbackup -db -instancename (LOCAL) -targetlocation c:\temp
    ```  

2. Start SQL Server Enterprise Manager, and then connect to the MSDPM2012 instance.
3. Run the following SQL Server query to update the DPM stored procedure that's causing the problem.

    ```sql
    USE [DPMDB] GO /****** Object: StoredProcedure [dbo].[prc_PRM_SharePointRecoverableObject_Update] Script Date: 11/03/2012 01:36:08 ******/ SET ANSI_NULLS ON GO SET QUOTED_IDENTIFIER ON GO ALTER PROCEDURE [dbo].[prc_PRM_SharePointRecoverableObject_Update] ( @Caption nvarchar(40), @ComponentType nvarchar(16), @RecoverableObjectId BIGINT ) AS DECLARE @error INT, @rowCount INT SET @error = 0 SET NOCOUNT ON -- UPDATE tbl_RM_SharePointRecoverableObject SET Caption = @Caption UPDATE tbl_RM_SharePointRecoverableObject SET Caption = @Caption, ComponentType = @ComponentType WHERE RecoverableObjectId = @RecoverableObjectId SELECT @error = dbo.udf_DPS_CheckRowCount(1) SET NOCOUNT OFF RETURN @error
    ```

## References

For information about issues that are fixed in [Update Rollup 3 for System Center 2012](https://support.microsoft.com/help/2756127).
