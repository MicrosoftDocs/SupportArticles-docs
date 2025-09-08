---
title: Error when you start Microsoft Dynamics GP
description: Fixes an issue that occurs after you update to Microsoft Dynamics GP. In this situation, you receive an error message when you try to start the application.
ms.topic: troubleshooting
ms.reviewer: theley, kyouells
ms.date: 04/17/2025
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Error message when you start Microsoft Dynamics GP: Database setup has not been completed for Microsoft Dynamics GP

This article help fixes an issue that occurs when you start Microsoft Dynamics GP after you update to Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915472

## Symptoms

When you start Microsoft Dynamics GP, you receive the following error message:

> Database setup has not been completed for Microsoft Dynamics GP. Use Microsoft Dynamics GP Utilities to complete the database setup before starting Microsoft Dynamics GP.

This problem occurs after you perform a new installation of Microsoft Dynamics GP, after you update to Microsoft Dynamics GP, or after you install a new client computer.

## Cause 1

This problem occurs because a subfeature was installed. However, Microsoft Dynamics GP Utilities must first be run to create the tables for this subfeature. To resolve this problem, see [Resolution 1](#resolution-1).

## Cause 2

This problem occurs because not all the subfeatures are updated. To resolve this problem, see [Resolution 2](#resolution-2).

## Cause 3

This problem occurs because not all the subfeatures that are installed on the new client computer are installed on the server. To resolve this problem, see [Resolution 3](#resolution-3).

## Cause 4

This problem occurs because the DynUtils.set file has been modified and does not contain all features shown in the Dynamics.set file or through Add or Remove programs. To resolve this problem, see [Resolution 4](#resolution-4).

## Resolution 1

On the server that is running Microsoft SQL Server, make sure that the subfeature is installed. Then, start Microsoft Dynamics GP Utilities to create the tables for the subfeature.

## Resolution 2

On the server that is running SQL Server, start Microsoft Dynamics GP Utilities. Then, update the subfeatures.

## Resolution 3

Compare the Dynamics.set files on the new client computer to the files on the server. Verify that any subfeatures that are installed on the client computer are also installed on the server. You can install subfeatures on the server or remove them from the client computer by using the **Add or Remove Programs or Programs and Features** item in Control Panel. To remove the subfeature, use the **Add or Remove Programs or Programs and Features** item on the client computer. This will remove the feature from the Dynamics.set files and from the Dynutil.set files. This will also remove the dictionary files from the Microsoft Dynamics GP installation folder and from any registry entries for the subfeatures.

> [!NOTE]
> If the module cannot be installed from Microsoft Dynamics GP CD 1, these steps may vary.

### Remove the subfeature from the client computer

1. Click **Start**, point to **Settings**, and then click **Control Panel**.
2. Double-click **Add or Remove Programs or Programs and Features**, click **Microsoft Dynamics GP**, and then click **Change**.
3. In the Program Maintenance window, click **Add/Remove Features**.
4. In the Select Features window, click the symbol next to the module that you want to remove, and then click **Do not install feature**.
5. Use the appropriate method:

    - In Microsoft Dynamics GP 2013, Microsoft Dynamics GP 2010 and in Microsoft Dynamics GP 10.0, confirm that the **Install Location** field is correct, and then click **Next**.
    - In Microsoft Dynamics GP 9.0, confirm that the **Install to** field is correct, and then click **Next**.

        > [!NOTE]
        > You must confirm that the field is correct because the folder in the field is the folder to which the changes will be made.
6. In the Install Program window, click **Install**.
7. When the Installation Complete window opens, click **Finish**.

    Microsoft Dynamics GP Utilities should start. If Microsoft Dynamics GP Utilities does not start, click **Start**, point to **Programs**, point to **Microsoft Dynamics**, and then click **GP Utilities**.
8. Log on as the sa user, and then click **Launch Microsoft Dynamics GP** in the Additional Tasks window.
9. When you are prompted to include new code, click **Yes**.

### Install the subfeature on the server

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Make sure that all users exit Microsoft Dynamics GP.
2. Back up the DYNAMICS database and the company database. To do this, follow these steps:

    1. Use the appropriate method:

        - In Microsoft Dynamics GP 2013, Microsoft Dynamics GP 2010 and in Microsoft Dynamics GP 10.0, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then click **Backup**.
        - In Microsoft Dynamics GP 9.0, click **Backup** on the **File** menu.

    2. In the Back Up Company window, enter the company that you want to back up in the **Company Name** field, enter the location and the file name in the **Select the backup file** field, and then click **OK**.

    3. Repeat these steps for each company database.
  
    4. Back up the system database. To do this, click **System Database** in the **Company Name** field, and then follow the same steps that you follow when you back up the company database.

3. Click **Start**, point to **Settings**, and then click **Control Panel**.
4. In Control Panel, double-click **Add or Remove Programs or Programs and Features**, click **Microsoft Dynamics GP**, and then click **Change**.
5. In the Program Maintenance window, click **Add/Remove Features**.
6. In the Select Features window, click the symbol next to the module that you want to install, and then click **Entire feature will be installed on local hard disk drive**.
7. Use the appropriate method:

    - In Microsoft Dynamics GP 2013, Microsoft Dynamics GP 2010 and in Microsoft Dynamics GP 10.0, confirm that the **Install Location** field is correct, and then click **Next**.
    - In Microsoft Dynamics GP 9.0, confirm that the **Install to** field is correct, and then click **Next**.

        > [!NOTE]
        > You must confirm that the field is correct because the folder in the field is the folder to which the changes will be made.
8. In the Install Program window, click **Install**.
9. When the Installation Complete window opens, click **Finish**.

    Microsoft Dynamics GP Utilities should start. If Microsoft Dynamics GP Utilities does not start, click **Start**, point to **Programs**, point to **Microsoft Dynamics**, and then click **GP Utilities**.
10. Have all the other users exit Microsoft Dynamics GP.

11. Log on as the sa user, and then click **Launch Microsoft Dynamics GP** in the Additional Tasks window.
12. When you are prompted to include new code, click **Yes**.
13. Click **Next** so that Microsoft Dynamics GP detects the earlier version.
14. Click **Next** to upgrade the Microsoft Dynamics GP system database.
15. Click **Next** to update the company databases.

## Resolution 4

Verify the DynUtils.set file contains all features required to create a new company or upgrade a company. Modules missing from this file will not be installed or updated when using Microsoft Dynamics GP Utilities.

1. Rename the DynUtils.set file to DynUtils.old.
2. Click **Start**, point to **Settings**, and then click **Control Panel**.
3. Double-click **Add or Remove Programs** or **Programs and Features**, click **Microsoft Dynamics GP**, and then click **Change**.
4. In the **Program Maintenance** window, click **Repair**.
5. In the Repair window, click Repair.
6. In the **Repair Complete** window, click **Exit**.
7. Log on as the sa user.
8. In the **Welcome to Microsoft Dynamics GP Utilities** window, click **Next**.
9. If you are prompted to include new code, click **Yes**.
10. Click **Next** so that Microsoft Dynamics GP detects the modules to add.
11. Click **Next** to upgrade the Microsoft Dynamics GP system database.
12. Click **Next** to update the company databases.

## References

For more information how to edit a Dynamics.set file, see [How to disable third-party products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-steps-to-disable-third-party-products-or-temporarily-disable-additional-products-in-the-dynamics-set-file-in-microsoft-dynamics-gp-a1fd71d3-7b9f-2827-718c-8c6d5df5f4c5).
