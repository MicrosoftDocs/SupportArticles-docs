---
title: System Error 126 when you start TrustedInstaller
description: Fixes the System Error 126 that occurs when you start the Windows Modules Installer service.
ms.date: 10/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Servicing
ms.technology: windows-client-deployment 
---
# System Error 126 when you start the Windows Modules Installer service (TrustedInstaller): The specific module could not be found

This article helps fix the System Error 126 that occurs when you start the Windows Modules Installer service.

_Original product version:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 959077

## Symptoms

When you start the Windows Modules Installer service, you receive the following error message:

![Error message dialog box](./media/system-error-126-start-windows-modules-installer/error-message-dialog.jpg)

You also receive an error message at the command prompt:

![Error message at the command prompt](./media/system-error-126-start-windows-modules-installer/error-in-command-prompt.jpg)

## Cause

This issue occurs if the following registry subkey is changed:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\Version`

## Resolution

To resolve this issue, you have to re-create the expandable string value of the registry subkey that is mentioned in the [Cause](#cause) section.

First, you have to check whether the registry subkey exists. To do this, start Registry Editor, and then browse to the subkey that is mentioned in the [Cause](#cause) section. If the subkey does not exist, you must create it. To do this, follow these steps:

1. Locate the `C:\Windows\Servicing\Version` directory, and note the name of the subfolder in this directory. It will be named something like *6.1.7600.16385*. This is your TrustedInstaller ID.

2. Copy the subfolder name to the clipboard, and then paste it into Notepad for safekeeping.

    ![Screenshot of the subfolder name](./media/system-error-126-start-windows-modules-installer/paste-subfolder-name-to-notepad.jpg)

    > [!NOTE]
    > In this example, the TrustedInstaller ID is 6.1.7601.17592.

3. In the `C:\Windows\WinSxS` directory, find a subfolder whose name begins with one of the following strings. (In the following subfolder names, the placeholder **TrustedInstaller ID** represents your TrustedInstaller ID.)

    For 32-bit Windows: x86_microsoft-windows-servicingstack_31bf3856ad364e35_ **TrustedInstaller ID** _none

    For 64-bit Windows: amd64_microsoft-windows-servicingstack_31bf3856ad364e35_ **TrustedInstaller ID** _none

4. Copy the subfolder name to the clipboard, and then paste it into Notepad for safekeeping.

    :::image type="content" source="./media/system-error-126-start-windows-modules-installer/copy-subfolder-name.jpg" alt-text="Screenshot of the subfolder name.":::

5. Create the registry subkey `HKLM\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\Version`.

    > [!NOTE]
    > To create this key, you have to be an owner of the **Component Based Servicing** key. Then, you have to then give yourself full access permissions.

6. On the **Version** key that you created in step 5, create an expandable string value (or edit it if it already exists). To do this, use the TrustedInstaller ID as your name, and use the full path of the folder that you identified in step 3 as the value.

    > [!NOTE]
    > In the full path, you must use `%SystemRoot%\WinSxS\folder_name` instead of `C:\Windows\WinSxS\folder_name`.

    ![Screnshot of editing registry value](./media/system-error-126-start-windows-modules-installer/create-registry-key.jpg)

7. Click **OK**, and then exit Registry Editor.

You can now start the Windows Modules Installer (TrustedInstaller) service as usual.
