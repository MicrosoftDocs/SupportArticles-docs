---
title: Upgrade a Dexterity-based application
description: Describes the supported method to upgrade Dexterity code by using Dexterity Source Code Control Service.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to upgrade a Dexterity-based application in Microsoft Dynamics GP by using the Dexterity Source Code Control Service

This article describes how to upgrade a Dexterity-based application by using the Dexterity Source Control Service.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 910527

## Summary

*To upgrade a Dexterity-based application in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you must use the Dexterity Source Code Control Service.*

The following steps upgrade an application from the old Dexterity version to your new Dexterity version.

## More information

The following steps assume that you have already installed Microsoft Visual SourceSafe 6.0 (VSS) and the Dexterity Source Code Control Service (DSCCS). The DSCCS can be installed from the `Tools\Dex\DSCCS` folder on Microsoft Great Plains CD 2.

## Step 1: Set up the DSCCS

1. Select **Start**, and then select **Control Panel**.

2. Select **Dexterity SCCS**.

3. In the **Provider** list, select **Microsoft Visual SourceSafe**.
4. Select **Browse**, and then locate and select the **SrcSafe.ini** initialization file. By default, the path is as follows:  
    `C:\Program Files\Microsoft Visual Studio\VSS\SrcSafe.ini`
5. Select **OK**.

## Step 2: Set up VSS

1. Select **Start**, point to **All Programs**, point to **Microsoft Visual SourceSafe**, and then select **Visual SourceSafe 6.0 Admin**.
2. Sign in as the Admin user.
3. Select **Users**, and then select **Add User**. The program creates a user for your user name without a password.
4. Select **Start**, point to **All Programs**, point to **Microsoft Visual SourceSafe**, and then select **Visual SourceSafe 6.0**.
5. Sign in as your user name.
6. Select the root node on the tree, and then select **Create Project** on the **File** menu.
7. Type the name of your development project. For example, type **Project**. The project can be the name of the dictionary or the name of the chunk file.

## Step 3: Create the development environment

1. Make sure that your development project is in a subfolder of your new Dexterity installation. The `C:\Dex800\Project` subfolder is used as an example in this procedure.
2. Copy the old development dictionary that contains your code to the subfolder. For example, copy the Proj_Dyn.dic dictionary file to the `C:\Dex800\Project` subfolder.

    > [!NOTE]
    > Make sure that you also copy the associated `*.dat` and `*.idx` tables so that you keep your references and worksets together.
3. Copy the Dexterity new Dex.ini file to this subfolder. For example, the copy operation will have the following path:  
    `C:\Dex800\Project\Dex.ini`

4. Create a shortcut for the Dexterity new Dex.exe file, and then move the shortcut to this subfolder.

5. Modify the shortcut for Dex.exe. Add the path of the dictionary and the path of the Dex.ini file to the target as parameters. For example, the path will appear as follows:  
    `C:\Dex800\Dex.exe C:\Dex800\Project\Proj_Dyn.dic C:\Dex800\Project\Dex.ini`

    Always use this shortcut when you're developing this project from now on. Each project must have its own Dex.ini file. The settings for the Dexterity Source Code Control Service are stored in the Dex.ini file.

## Step 4: Create a connection to VSS

1. Start Dexterity by using the shortcut. Your dictionary will be directly loaded.
2. On the **Edit** menu, select **Options**, and then select the **Source Control** tab.
3. Set the **Repository Name** field to the computer that is running the Dexterity Source Control Service. If you're using the local Dexterity Source Code Control Service, set the Repository Name field to **localhost**.
4. Type your user name.
5. Leave the password blank.
6. In the **Project Name** field, type **Project**.
7. Set the **Temp File Location** field to the local Temp folder.
8. Make sure that the **Original Dictionary** field is set to the old Dexterity original Dynamics.dic file without modifications. For example, the original dictionary is `C:\Dyn750\Dynamics.dic`.
9. Select all three check boxes.
10. Validate the connection.
11. Add **\750** to the name in the **Project Name** field. For example, the project name field will be **Project\750**.
12. Select **OK**.

You'll now have separate subprojects for each version. However, the validate feature doesn't understand subprojects.

## Step 5: Do the initial check-in of the old Dexterity code

1. In Dexterity, select **Source Control** on the **Explorer** menu, and then select **Update SCC State**.

2. For each item in the **Alternate Form** and **Report** lists, you must open the form or report to change the state from **Main Product**. Double-click the item to open the form definition or report definition window, and then select **OK**.

3. On the **Explorer** menu, select **Source Control**, and then select **Check In**.

4. Select **Insert All**, and then type a description. For example, type **Initial 7.50 Check-In**. Select **Check in**, and then close the window.

5. On the **Explorer** menu, select **Source Control**, and then select **Update Index File**.

## Step 6: Do the initial check-in of the old Dexterity code as the start of the new Dexterity project

1. On the **Edit** menu, select **Options**, and then select **Source Control**. In the **Project Name** field, change **\750** to **\850**.
2. Select **OK**.
3. In Dexterity, select **Source Control** on the **Explorer** menu, and then select **Update SCC State**.
4. For each item in the **Alternate Form** and **Report** lists, you must open the form or report to change the state from **Main Product**. Double-click the item to open the form definition or report definition window, and then select **OK**.
5. In the code, note any references that add palette items or toolbar menu items, and then delete the code to avoid errors later.
6. On the **Explorer** menu, select **Source Control**, and then select **Check In**.
7. Select **Insert All**, and then type a description. For example, type **Initial 8.00 Check In**. Select **Check In**, and then close the window.
8. On the **Explorer** menu, select **Source Control**, and then select **Update Index File**.

## Step 7: Prepare for the new Dexterity project

1. Make sure that you have a backup of the old Dexterity Development dictionary. Then, delete it. For example, delete `C:\Dex800\Project\Proj_Dyn.dic`.
2. Copy an unmodified new Dynamics.dic file from your Microsoft Dynamics GP installation into the folder, and then rename it Proj_Dyn.dic. This dictionary will become your new development dictionary.
3. On the **Edit** menu, select **Options**, and then select **Source Control**. In the **Original Dictionary** field, change the path of the new Dexterity dictionary. For example, change it to `C:\Dyn800\Dynamics.dic`.
4. Select **OK**.

## Step 8: Create a new Dexterity development dictionary

1. In Dexterity, select **Source Control** on the **Explorer** menu, and then select **Update SCC State**.
2. On the **Explorer** menu, select **Source Control**, and then select **Update**.
3. Select **Use Index File**. For more information, see [How to use an index file and the Microsoft Dynamics GP Dexterity source code control functionality to make sure that the resources that you create maintain the same resource ID in different builds and versions of your code](https://support.microsoft.com/help/894699).
4. Select **OK**.
5. Leave all the resources selected, and then select **OK** to start the update.
6. If your code contains references to palettes or toolbars, you may receive errors. If you do receive errors, go to step 9.

## Step 9: Fix the code

1. Check out any code that is failing. Make the appropriate changes for the new version of Dexterity and Microsoft Dynamics GP. For more information, see [Tips and references for upgrading your Great Plains Dexterity-based application to Great Plains 8.0 Dexterity](https://support.microsoft.com/help/894701).

2. After everything is working in test mode, select **Source Control** on the **Explorer** menu, and then select **Check In**. Check in all the changes.

3. On the **Explorer** menu, select **Source Control**, and then select **Update Index File**.

Now you're finished. You can create your chunk.
