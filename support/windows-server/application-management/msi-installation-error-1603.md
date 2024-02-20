---
title: MSI installation error 1603
description: Provides solutions to the error 1603 that occurs when you install a Windows Installer package.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:msi, csstroubleshoot
---
# Error 1603 when you try to install a Windows Installer package: A fatal error occurred during installation

This article helps fix the error 1603 that occurs when you install a Microsoft Windows Installer package.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 834484

## Symptoms

When you try to install a Windows Installer package, you may receive the following error message:

> Error 1603: A fatal error occurred during installation.

If you click **OK** in the message box, the installation rolls back.

## Cause

You may receive this error message if any one of the following conditions is true:

- Windows Installer is attempting to install an app that is already installed on your PC.
- The folder that you are trying to install the Windows Installer package to is encrypted.
- The drive that contains the folder that you are trying to install the Windows Installer package to is accessed as a substitute drive.
- The SYSTEM account does not have Full Control permissions on the folder that you are trying to install the Windows Installer package to. You notice the error message because the Windows Installer service uses the SYSTEM account to install software.

## Resolution

To resolve this problem, use any one of the following methods, depending on the cause of the problem:

- Check if the app is already installed on the PC. If so, uninstall and reinstall the app.

    If you previously had a desktop shortcut for an app, the shortcut may have been lost during the upgrade to Windows 10. In such cases, the app is likely still installed on the PC, resulting in this error when you attempt to reinstall the app. You can restore the shortcut by searching for the app, and if it's found, press and hold (or right-click) the app and select **Pin** to **Start**. Or you can resolve the issue by uninstalling and then reinstalling the app. To search for and uninstall apps in Windows 10:

    1. On the **Start** menu, select **Settings**.
    2. In **Settings**, select **System** > **Apps & features**.
    3. If the app is listed, then this is, select it and then select **Uninstall**.
    4. Follow the directions on the screen.

- Install the package to a folder that is not encrypted.

    Use this method if you receive the error message because you try to install the Windows Installer package to a folder that is encrypted.

- Install the package to a drive that is not accessed as a substitute drive.

    Use this method if you receive the error message because the drive that contains the folder that you try to install the Windows Installer package to is accessed as a substitute drive.

- Grant Full Control permissions to the SYSTEM account.

    Use this method if you receive the error message because the SYSTEM account does not have Full Control permissions on the folder you are installing the Windows Installer package to.

    To grant Full Control permissions to the SYSTEM account, follow these steps:

    1. Open File Explorer (or Windows Explorer), right-click the drive that you want to install the Windows Installer package to, and then click **Properties**.

    2. Click the **Security** tab. Verify that the **Group or user names** box contains the SYSTEM user account. If the SYSTEM user account doesn't appear in the box, follow these steps to add the SYSTEM account:

        1. Click **Edit**. If prompted, approve the User Account Control.
        2. Click **Add**. The **Select Users or Groups**  dialog box appears.
        3. In the **Enter the object names to select** field, type **SYSTEM**, and then click **Check names**.
        4. Click **OK**.

    3. To change permissions, click **Edit**. If prompted, approve the User Account Control.
    4. Select the **SYSTEM** user account, and verify in the **Permissions** section that Full Control is set to **Allow**. If not, select the **Allow** check box.
    5. Close the **Permissions** dialog and return to the **Properties** dialog. Click **Advanced**.
    6. Select **Change permissions**. If prompted, approve the User Account Control.
    7. In the **Permissions** tab, select the **SYSTEM** entry and click **Edit**.
    8. Click the **Applies to** dropdown and select **This folder**, subfolder, and files. Click **OK**.
    9. Wait for the operating system to apply the permissions that you have selected to all child folders.
    10. Run the Windows Installer package.
