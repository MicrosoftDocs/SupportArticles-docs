---
title: Blank icons on the desktop, Start menu, and taskbar
description: Fixes an issue in which application shortcuts on the desktop, Start menu, and taskbar show blank icons in Windows.
ms.date: 11/22/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, rafern, warrenw, v-lianna
ms.custom: sap:Windows Desktop and Shell Experience\Desktop (Shell, Explorer.exe init, themes, colors, icons, recycle bin), csstroubleshoot
---
# Application shortcuts on the desktop, Start menu, and taskbar show blank icons

This article provides basic guidelines to troubleshoot issues where the application shortcuts on the desktop, Start menu, and taskbar show blank icons.

Application shortcuts on the desktop, Start menu, and taskbar show blank icons. This issue can affect both built-in (inbox) and third-party applications. However, double-clicking the blank icon can still open the application.

The issue is related to problems with the icon cache and the `IconHandler` subkey. Here are the steps to resolve this issue.

## Step 1: Clear the icon cache

To clear the icon cache in Windows, follow these steps:

> [!NOTE]
> Save any open work before you begin, as you need to restart Windows Explorer.

1. Open Task Manager by using the <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Esc</kbd> shortcut, or by right-clicking the taskbar and selecting Task Manager.

2. In the **Processes** tab, look for **Windows Explorer**.

3. Right-click **Windows Explorer** and then select **End task**.

4. In Task Manager, go to **File** > **Run new task**.

5. Type *cmd.exe* and create a task with administrative privileges.

6. In the command prompt window, type the following commands and press <kbd>Enter</kbd> after each one:

    ```cmd
    CD /d %userprofile%\AppData\Local
    DEL IconCache.db /a
    ```

7. In Task Manager, go to **File** > **Run new task** again.

8. Type *explorer.exe* and then press <kbd>Enter</kbd> to restart Windows Explorer.

This process clears the icon cache and restores the display of your taskbar icons.

## Step 2: Register Shell Experience Host

To register the `ShellExperienceHost` object for all users, follow these steps:

1. Open Windows PowerShell as an administrator.

2. Run the following cmdlet to re-register the `ShellExperienceHost` object for all users:

    ```powershell
    Get-AppXPackage -AllUsers | Where-Object {$_.InstallLocation -like "*ShellExperienceHost*"} | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    ```

3. Restart the system to ensure the changes take effect.

## Step 3: Check IconHandler

To check and verify the value of the `IconHandler` subkey and its associated Class Identifier (CLSID) in the Windows registry, follow these steps:

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

1. Select **Start**, type *regedit* and then press <kbd>Enter</kbd> to open the Registry Editor.

2. Navigate to `HKEY_CLASSES_ROOT\lnkfile\shellex\IconHandler`, and then check the `(Default)` value.

    In the following example, the value is `{00021401-0000-0000-C000-000000000046}`.

    :::image type="content" source="media/application-shortcuts-show-blank-icons/iconhandler-value.png" alt-text="Screenshot that shows the default value of IconHandler.":::

3. Navigate to `HKEY_CLASSES_ROOT\CLSID\{00021401-0000-0000-C000-000000000046}`

    > [!NOTE]
    > The hexadecimal (hex) value is the one you found in the preceding step.

    Make sure that the `(Default)` value in this key is `Shortcut`.

    :::image type="content" source="media/application-shortcuts-show-blank-icons/clsid-value.png" alt-text="Screenshot that shows the default value is Shortcut.":::

4. Navigate to the `HKEY_CLASSES_ROOT\CLSID\{00021401-0000-0000-C000-000000000046}\InProcServer32` subkey.

    Make sure that the `(Default)` value in this key is `C:\Windows\System32\windows.storage.dll`.

    :::image type="content" source="media/application-shortcuts-show-blank-icons/inprocserver32-value.png" alt-text="Screenshot that shows the default value of InProcServer32.":::

## Scenario: Network or internet icon is missing from the taskbar

If the network or internet icon is missing from the taskbar, check if this policy setting is in place: **User Configuration**\\**Administrative Templates**\\**Start Menu and Taskbar**\\**Hide the notification area**.

To check local policies, see [How to disable user or computer policy settings in a Local Group Policy Object](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789197(v=ws.11)#how-to-disable-user-or-computer-policy-settings-in-a-local-group-policy-object).

To look for Group Policy Objects in a domain, see [Edit an existing GPO](/windows-server/identity/ad-ds/manage/group-policy/group-policy-management-console#edit-an-existing-gpo).
