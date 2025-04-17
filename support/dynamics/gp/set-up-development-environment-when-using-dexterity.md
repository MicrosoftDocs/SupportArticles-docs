---
title: Set up development environment when you use Dexterity in Microsoft Dynamics GP
description: Describes how to set up the development environment for multiple versions of Dexterity.
ms.topic: how-to
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to set up the development environment when you use Dexterity in Microsoft Dynamics GP

This article describes how to set up the development environment when you use Dexterity.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949622

## Summary

This article describes how to set up the development environment when you use Dexterity in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. Additionally, this article describes some best practices that make the development process easier and more productive. Customizations of Dexterity must be upgraded at some stage. Therefore, it is very common for you to use multiple versions of Dexterity.

## Prerequisites

To follow the steps in this article, you must be able to see the file name extensions in Windows Explorer. Therefore, we recommend that you change the folder options in Windows Explorer. To do this, follow these steps:

1. On the **Tools** menu, click **Folder Options**.
2. In the **Folder Options** dialog box, click the **View** tab, and then click to clear the **Hide extensions for known file types** check box.

The steps in this article assume that you already have a product ID for the project that you develop. For more information about product IDs for Dexterity, see [Description of product IDs for Dexterity in Microsoft Dynamics GP](https://support.microsoft.com/help/914899).

For more information about how to request a product ID for Dexterity, see [How to request a new Dexterity product ID for my product](https://support.microsoft.com/help/867102).

## How to set up the development environment

To set up the development environment, follow these steps:

1. Install Dexterity.

    > [!NOTE]
    >
    > - Install Dexterity in a folder on the hard disk drive. When you create the folder, include the version of Dexterity in the name of the folder. For example, install Dexterity in one of the following locations:
    >   - C:\\DEX800
    >   - C:\\DEX900
    >   - C:\\DEX1000
    > - When you create the program group for the shortcuts, add the version of Dexterity to the end of the default name. For example, name the program group "Microsoft Dexterity 10.00."
    > - When you use these best practices, you can access the development folders quickly without having to examine multiple levels in the "Program Files" folder.

2. Create the project folder.

    > [!NOTE]
    >
    > - When you create the project folder, use a name that you can also use for the dictionary names.
    > - The name should not exceed eight characters. For example, use the name Project.
    > - Create the project folder in the installation folder of the appropriate version of Dexterity. For example, create the project folder in the location: C:\\DEX1000\\Project.

3. Create the development dictionary file. To do this, follow these steps:
  
    1. In the application folder of the same version of Microsoft Dynamics GP, copy the Dynamics.dic file.
    2. In the project folder, paste the copy of the Dynamics.dic file.

        > [!NOTE]
        > Make sure that you paste a copy of the Dynamics.dic file and that you do not move the Dynamics.dic file.
    3. Rename the copy of the Dynamics.dic file to show that it is the development dictionary for the project and that it is based on the Dynamics.dic file. For example, use a four-character abbreviation of the original eight-character name as follows: C:\\DEX1000\\Project\\Proj_Dyn.dic

4. Create the Dex.ini file for the project. To do this, follow these steps:

    1. In the application folder of the same version of Microsoft Dynamics GP, copy the Dex.ini file.

        > [!NOTE]
        > In Microsoft Dynamics GP 10.0, the Dex.ini file is in the Data folder.

    2. In the project folder, paste the copy of the Dex.ini file.

        > [!NOTE]
        > Make sure that you paste a copy of the Dex.ini file and that you do not move the Dex.ini file.

    3. To fix the reference to the Dexterity Help files, open the copy of the Dex.ini file in Notepad, and then locate the DexHelpPath setting.

    4. Change the value of the DexHelpPath setting to the path of the installation folder of the appropriate version of Dexterity. Or, add a semicolon to the beginning of the line of code to comment the line of code.

    > [!NOTE]
    > When the Dex.ini file is specific to a project, the source control settings are also specific to a project. If you use a shared Dex.ini file, you must change the source control settings every time that you work on a different project.

5. Create shortcuts to Dexterity and to the Dexterity Utilities. To do this, follow these steps:

   1. Follow one of these steps:
      - Copy the shortcuts on the **Start** menu to the project folder.
      - In the installation folder of the appropriate version of Dexterity, right-click the Dex.exe file or the DexUtils.exe file, drag the file to the project folder, and then click **Create Shortcuts Here**.
   2. Rename the shortcuts as the "_Dexterity **XX.XX**" file and as the "_Dexterity Utilities **XX.XX**" file.

        > [!NOTE]
        >
        > - The underscore character (_) makes the shortcuts appear as the first files in the folder.
        > - *XX.XX* is a placeholder for the version of Dexterity. The version helps you avoid working with the incorrect version when multiple versions of a project are available on a system.

6. Edit the parameters of the shortcut to Dexterity. To do this, follow these steps:

    1. Right-click the shortcut to Dexterity, and then click **Properties**.

    2. In the **Target** field, add the path of the development dictionary and the path of the Dex.ini file. For example, add the following paths:
        - C:\\Dex1000\\Dex.exe
        - C:\\Dex1000\\Project\\Proj_Dyn.dic
        - C:\\Dex1000\\Project\\Dex.ini

7. Set up the Dexterity options. To do this, follow these steps:

    1. Use the shortcut to Dexterity to start Dexterity. Dexterity automatically loads the development dictionary and automatically uses the Dex.ini file.
    2. On the **Edit** menu, click **Options**.
    3. On the **sanScript** tab, click to select both of the **Apply to** check boxes.
    4. On the **Reference** tab, click to select all the check boxes except the **Strings** check box.

8. Set up the Dexterity source control functionality.

    > [!NOTE]
    >
    > - This step is optional. But, we recommend that you follow this step.
    > - This step assumes that Microsoft Visual SourceSafe (VSS) and the Dexterity Source Control Service (DSCCS) are installed and are running on the local computer or on a server.

    To do this, follow these steps:

    1. On the **Edit** menu, click **Options**, and then click the **Source Control** tab.
    2. If the DSCCS is running on a server, type the repository name as the server.

        If the DSCCS is running on the local computer, type *localhost*.
    3. Type the user name and the password that are used for the VSS credentials.
    4. Enter the project name. You can nest the project name and the version as follows:

        Project\\1000

    5. Do not change the default temporary file location.
    6. Enter the original dictionary as the dictionary in the application folder.

        If you use nested VSS projects, you receive the following error message when you click **Validate Connection**:

        > Project not found

    7. To update the source control state of the resources in the dictionary, click **Source Control** on the **Explorer** menu, and then click **Update SCC State**.

    8. If you use the Dexterity source control functionality, create an index file to control the resource ID between builds. For more information about how to use an index file and the Dexterity source control functionality, see [How to use an index file and the Great Plains Dexterity source code control functionality to make sure that the resources that you create maintain the same resource ID in different builds and versions of your code](https://support.microsoft.com/help/894699).

9. Create a macro of the chunking process.

    > [!NOTE]
    >
    > - If you record a macro of the chunking process, you can repeat the chunking process accurately and quickly.
    > - You can edit the macro in Notepad to change the build numbers. You do not have to record the macro again.

    To do this, follow these steps:

    1. Use the shortcut to the Dexterity Utilities to start the Dexterity Utilities.
    2. On the **Macro** menu, click **Record**.
    3. Save the macro, and then name the macro based on the project name. For example, save the macro in the following location:

        C:\\Dex1000\\Project\\Project.mac
    4. Before you start the chunking process, reset the state of the Dexterity Utilities.
    5. On the **File** menu, click **Close Source Dictionary**, and then click **Close Editable Dictionary**.
    6. Close the destination dictionary.
    7. Create a chunk file.

        For more information about how to create a chunk file in Dexterity, see [How to create a chunk file in Great Plains 8.0 Dexterity](https://support.microsoft.com/help/894700).

        Use the following naming conventions:
          - Extracted dictionary: C:\\Dex1000\\Project\\Project.dic
          - Forms dictionary: C:\\Dex1000\\Project\\Proj_FRM.dic or C:\\Dex1000\\Project\\Pro**XXXX**F.dic

            > [!NOTE]
            > *XXXX* is a placeholder for the product ID.

          - Reports dictionary:

            C:\\Dex1000\\Project\\Proj_RPT.dic or C:\\Dex1000\\Project\\Pro**XXXX**R.dic

            > [!NOTE]
            > *XXXX* is a placeholder for the product ID.
          - Chunk dictionary: C:\\Dex1000\\Project\\Project.cnk
          - Dictionary to create: C:\\Dex1000\\Project\\Project.dic

            > [!NOTE]
            > This is the dictionary name that is created when Dexterity extracts the chunk file.

10. Edit the parameters of the shortcut to the Dexterity Utilities. To do this, follow these steps:
    1. Right-click the shortcut to the Dexterity Utilities, and then click **Properties**.
    2. In the **Target** field, add the path of the macro of the chunking process that you created in step 9. For example, add the following paths:
        - C:\\Dex1000\\DexUtils.exe
        - C:\\Dex1000\\Project\\Project.mac
    3. Use the shortcut to the Dexterity Utilities to start the Dexterity Utilities, and then create the chunk file.
    4. Click **OK**, and then exit the Dexterity Utilities.

11. Edit the macro so that the macro exits the Dexterity Utilities automatically after the chunk file is created.

    > [!NOTE]
    > This step is optional.

    To do this, follow these steps:

    1. In Notepad, open the macro file.
    2. Under the "# DEXVERSION=" line of code, add the following line of code.

        `Logging file none`

    3. As the last line of the macro, add the following line of code.

        `MenuSelect title File entry Exit`

        > [!NOTE]
        > Make sure that a blank line is at the end of the macro.
    4. To test that the macro exits the Dexterity Utilities automatically after the chunk file is created, use the shortcut to the Dexterity Utilities.

12. Back up the development environment.

    > [!NOTE]
    >
    > - We recommend that you back up the whole folder so that you can restore the development environment.
    > - This backup is in addition to the backup of the VSS repository.
