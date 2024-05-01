---
title: GUID of an Unknown Computer object used by a client computer being imaged
description: Describes an issue in which a client computer that's being imaged uses the GUID of an Unknown Computer object.
ms.date: 12/05/2023
ms.reviewer: kaushika, frankroj
ms.custom: sap:Operating Systems Deployment (OSD)\PXE
---
# A client computer can steal the Configuration Manager GUID of an Unknown Computer object during imaging

This article provides the information to solve the issue that the Configuration Manager Unique Identifier (GUID) of an Unknown Computer object is taken by a client computer that's being imaged.

_Original product version:_ &nbsp; Configuration Manager (current branch)  
_Original KB number:_ &nbsp; 4471061

## Symptoms

Configuration Manager current branch version 1702 included a new feature that lets you use the **Previous** button to retry a failed task sequence in the Task Sequence Wizard when it runs on Microsoft Windows Preinstallation Environment (Windows PE).

For more information about this feature, see [Return to previous page when a task sequence fails](/mem/configmgr/core/plan-design/changes/whats-new-in-version-1702#return-to-previous-page-when-a-task-sequence-fails).

This feature introduced the following issue:

When the **Previous** button is selected, the client PC that's being imaged can steal the Configuration Manager Unique Identifier (GUID) of the Unknown Computer object that's being used (either the **x64 Unknown Computer** or the **x86 Unknown Computer**).

This issue was fixed in [Update rollup for Configuration Manager current branch, version 1702](https://support.microsoft.com/help/4019926).

This issue is also fixed in all subsequent versions of Configuration Manager current branch.

However, starting in Configuration Manager current branch version 1702, unknown computers that are started from media or preboot execution environment (PXE) may not find task sequences that are targeted to them. In this scenario, the following error message is logged in the SMSTS.log:

> There are no task sequences available to this computer. Please ensure you have at least one task sequence advertised to this computer.
>
> Unspecified error (Error: 80004005; Source: Windows)

This issue may occur if the **Previous** button on the **Select a task sequence to run** page is selected on the unknown computer.

This issue is also fixed in all subsequent versions of Configuration Manager current branch.

Despite applying the update rollup in Configuration Manager current branch version 1702 or upgrading to a later version of Configuration Manager, the issue still occurs.

## Cause

This issue may continue to occur because the fix in the update rollup for Configuration Manager current branch version 1702 and later Configuration Manager current branch versions prevents the issue from occurring only going forward. It doesn't fix the issue if the issue currently exists in the environment.

Therefore, the issue can continue to occur in Configuration Manager current branch version 1702 or newer even after the version 1702 update rollup or a later version is applied. This is true unless the following steps are taken:

- Update the boot images on distribution points.
- Recreate the boot media by using the updated images.
- Correctly clean the client PC that stole the GUID.

## Resolution

> [!WARNING]
> Do not try to fix this issue by recreating the Unknown Computer objects. This doesn't correctly fix the issue, and it doesn't prevent the issue from reoccurring going forward. Additionally, there are known issues that occur in environments that have multiple Unknown Computer objects for a single site. If you have previously tried to resolve this issue by recreating the Unknown Computer objects, see [Remove duplicate Unknown Computer objects](#remove-duplicate-unknown-computer-objects).

To resolve this issue and prevent it from returning in the environment, follow these steps:

1. Update all boot images in the environment. To do this, right-click the images in the Configuration Manager console, and then select **Update Distribution Points**. This puts the updated Configuration Manager binaries that contain the fix into the boot image. For more information, see [Update distribution points with the boot image](/mem/configmgr/osd/get-started/manage-boot-images#update-distribution-points-with-the-boot-image).

2. If you use media in the environment, recreate all media in the environment after you update all boot images on the distribution points. This makes sure that the updated boot images that have the fix are in the media that's being used in the environment.

    To prevent media that has old boot images from being used, the certificates for those boot images can be blocked in the Configuration Manager console under the **Administration** > **Security** > **Certificates** node. To make sure that the issue doesn't recur, we recommend that you block all certificates for all media created before the boot images were updated in step 1. The date on which the media was created is displayed in the **Start Date** column.

    For more information about how to create media, see [Create task sequence media](/mem/configmgr/osd/deploy-use/create-task-sequence-media).

3. The client computer that stole the GUID must be cleaned correctly.

To correctly clean the client that stole the GUID, follow these steps:

1. Identify the computer that acquired the GUID. To do this, examine the properties of the Unknown Computer object (usually **x64 Unknown Computer**), note the value of **Configuration Manager Unique Identifier**, and then run a query in the Configuration Manager console to identify the computer object that has the same GUID. You can do all these steps from the console. You do not have to go into the SQL Server database to do this.

2. After you identify the computer that acquired the stolen GUID, remotely connect to that computer, and then completely clean the Configuration Manager client. This involves more than simply uninstalling the client. Instead, you must follow steps 3-7.

3. On the client computer, under `C:\Windows\CCMSetup`, run the `CCMSetup.exe /uninstall` command at an elevated command prompt.

4. Monitor **Task Manager** until CCMSetup finishes running. Double-check the ccmsetup.log file to make sure that the client was uninstalled correctly.

5. On the client computer, delete the following directories:

    - C:\Windows\CCM  
    - C:\Windows\CCMSetup

     > [!NOTE]
     > To fully delete these directories, you may have to restart the computer.

6. On the client computer, delete the following registry keys (if they exist):

    - `HKEY_LOCAL_MACHINE\Software\Microsoft\CCM`  
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\CCMSetup`  
    - `HKEY_LOCAL_MACHINE\Software\Microsoft\SMS`

7. On the client computer, delete the C:\Windows\SMSCFG.ini file.

8. On the client computer, delete all certificates under the **SMS** > **Certificates** node in the **Certificates** console for the **Computer account**. To do this, follow these steps:

    1. Run `MMC.exe` at an elevated command prompt.
    2. On the **File** menu, select **Add/Remove Snap-in**.
    3. Select **Certificates**, and then select **Add**.
    4. Select **Computer account** and then select **Next**.
    5. Select **Local computer** and then select **Finish**.
    6. Select **OK**.
    7. Navigate to **Certificates** > **SMS** > **Certificates**.
    8. In the results pane, right-click each certificate listed under the **Certificates** > **SMS** > **Certificates** node, and then select **Delete**. Repeat this step until all certificates are deleted.

    9. Close the **Certificates** console.

9. Delete the record of the offending computer from the Configuration Manager console. Again, you do not have to go into the SQL Server database to do this. You can delete the record from the Configuration Manager console. Make sure that you do this after you complete steps 1-8. Doing this first may cause the record to be recreated if the client reports are backed up before they are fully cleaned.

10. Reinstall the Configuration Manager client on the offending client computer.

## Remove duplicate Unknown Computer objects

If the Unknown Computer objects have been recreated at the site when you tried to fix the problem, the extra Unknown Computer objects should be deleted. To accomplish this, all of the current Unknown Computer objects should be deleted for the affected site followed by creating a brand new set of Unknown Computer objects for the site. Deleting Unknown Computer objects can be completed only from the SQL Server database. It cannot be done from the Configuration Manager console.

> [!NOTE]
> It's acceptable to have multiple Unknown Computer objects if there are multiple primary sites. However, each site should have only one Unknown Computer object per architecture. For example, there should be only one x64 object that's labeled **x64 Unknown Computer** and only one x86 object that's labeled **x86 Unknown Computer**.

To delete the extra Unknown Computer objects, follow these steps:

1. Make sure you have a current and valid backup of the Configuration Manager site by using the built-in Backup maintenance task.

2. Open the Configuration Manager console. If there are multiple primary sites, we recommend that you open a Configuration Manager console that's connected to the central administration site.

3. In the Configuration Manager console, go to **Assets and Compliance** > **Overview** > **Device Collections**.

4. Double-click the **All Unknown Computers** collection.

5. In the results pane, sort the objects in the **All Unknown Computers** collection by selecting the **Site Code** column.

6. Note whether there are multiple **x64 Unknown Computer** objects or **x86 Unknown Computer** objects for any individual site.

7. If there are multiple **x64 Unknown Computer** objects or **x86 Unknown Computer** objects for any individual site, right-click the columns in the results pane, and add **Resource ID** to the list of columns.

8. Determine the **Resource ID** value for each **x64 Unknown Computer** object and each **x86 Unknown Computer** object for any one site. Make sure to note the resource ID for all of the Unknown Computer objects even if only one of the Unknown Computer objects is duplicated.

9. After you determine the **Resource IDs** of the Unknown Computer objects for a site, the **x64 Unknown Computer** objects and the **x86 Unknown Computer** objects for the site can be deleted.

10. Open **SQL Server Management Studio**, and then connect to the database for the site that hosts the extra Unknown Computer objects.

11. Expand the **Databases** node, and select the Configuration Manager database (usually **CM_Site_Code**).

12. On the toolbar, select **New Query**.

13. Make sure that the correct database is selected in the drop-down menu to the left of the **Execute** button on the toolbar.

14. In the query pane, run the following SQL query:

    ```sql
    SELECT C.CollectionID, C.SiteID, C.CollectionName, CM.MachineID, CM.Name FROM Collections C JOIN CollectionMembers CM ON C.SiteID = CM.SiteID JOIN UnknownSystem_DISC USD ON USD.ItemKey = CM.MachineID
    ```

    This query displays all the collections that all the Unknown Computer objects belong to. Use this query to determine which collections the Unknown Computer objects are members of. Make a note of this information so that when the new set of Unknown Computer objects are created, they can be added back to the appropriate collections. The **Resource ID** is listed in the **MachineID** column.

15. In the query pane, run the following SQL query:

    ```sql
    SELECT * FROM UnknownSystem_DISC WHERE ItemKey IN ('Resource_ID_1','Resource_ID_2', 'Resource_ID_3')
    ```

    In this query, `Resource_ID_x` is the Resource ID of each of the Unknown Computer objects for the site, as determined in step 9. For example, if the Resource IDs are **2046820354** and **2046820355**, the query would be as follows:  

    ```sql
    SELECT * FROM UnknownSystem_DISC WHERE ItemKey IN ('2046820354','2046820355')
    ```

16. Verify that the records that are returned by the query in step 15 are correct. If they are, then run the following query to delete the records:

    ```sql
    DELETE FROM UnknownSystem_DISC WHERE ItemKey IN ('Resource_ID_1','Resource_ID_2', 'Resource_ID_3')
    ```

    In this query, `Resource_ID_x` is the Resource ID of each of the Unknown Computer objects for the site, as determined in step 9. For example, if the Resource IDs are **2046820354** and **2046820355**, the delete query would be as follows:

    ```sql
    DELETE FROM UnknownSystem_DISC WHERE ItemKey IN ('2046820354', '2046820355')
    ```
     > [!NOTE]
     > Remember to delete all of the Unknown Computer objects for the affected site, both x64 and x86, even if only one of them was duplicated.


17. Follow the section [Recreate Unknown Computer objects in case of accidental deletion](#recreate-unknown-computer-objects-in-case-of-accidental-deletion) to create new Unknown Computer objects for the affected site.

18. Return to the Configuration Manager console, and then go to **Assets and Compliance** > **Overview** > **Device Collections**.

19. Right-click the **All Unknown Computers** collection, and then select **Update Membership**.

20. Wait a few minutes, and then select **Refresh**. Verify that only one **x64 Unknown Computer** object or **x86 Unknown Computer** object exists for each site. If the objects do not display, wait a few more minutes and try again.

21. Once the new Unknown Computer objects appear, add them back to the appropriate collections as determined in step 14.

22. Repeat steps 10-21 for all additional primary sites, as necessary.

## Recreate Unknown Computer objects in case of accidental deletion

If, for whatever reason, all Unknown Computer objects are accidentally deleted for any one site that uses this process, they can be recreated by using the following steps. These steps should be taken only if there are no Unknown Computer objects for a site. If only one of the two Unknown Computer objects exists at a site, delete the one remaining Unknown Computer object by using the steps in the [Remove duplicate Unknown Computer objects](#remove-duplicate-unknown-computer-objects) section of this article, and then follow these steps:

1. Sign in to the primary site server that the Unknown Computer objects are missing from.

2. At an elevated command prompt, run the following command:

    ```console
    REG.exe ADD "HKLM\SOFTWARE\Microsoft\SMS\COMPONENTS\SMS_DISCOVERY_DATA_MANAGER" /v CreatedUnknownDDR /t REG_DWORD /d 0 /f
    ```

After this registry key value is updated, the Unknown Computer objects should be automatically recreated soon afterward. You can check the progress of the creation of the Unknown Computer objects in the DDM.log file on the primary site server.

To speed up the recreation of the Unknown Computer records, restart the `SMS_DISCOVERY_DATA_MANAGER` thread by following these steps:

1. Open the Configuration Manager console on the primary site from which the Unknown Computer objects are missing, and then go to **Monitoring** > **Overview** > **System Status** > **Component Status**.

2. On the toolbar, select **Start** > **Configuration Manager Service Manager**.

3. In **Configuration Manager Service Manager**, expand the node under the site code and then select **Components**.

4. In the results pane, right-click **SMS_DISCOVERY_DATA_MANAGER** and select **Query**. The thread should display as **Running**.

5. Right-click **SMS_DISCOVERY_DATA_MANAGER**, and then click **Stop**.
6. Right-click **SMS_DISCOVERY_DATA_MANAGER**, and then click **Query**.

    > [!NOTE]
    > The thread should display as **Stopped**.

7. Right-click **SMS_DISCOVERY_DATA_MANAGER**, and then click **Start**.
8. Right-click **SMS_DISCOVERY_DATA_MANAGER**, and then click **Query**.

    > [!NOTE]
    > The thread should display as **Running**.

9. Close the **Configuration Manager Service Manager** window.

The Unknown Computer objects should be automatically recreated soon. You can check the progress of this process in the DDM.log file on the primary site server.
