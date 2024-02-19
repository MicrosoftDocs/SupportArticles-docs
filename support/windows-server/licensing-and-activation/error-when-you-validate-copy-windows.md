---
title: Error when you validate a copy of Windows
description: Provides a solution to an error that occurs when you try to validate a copy of Windows.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca
ms.custom: sap:windows-volume-activation, csstroubleshoot
---
# Error message when you try to validate a copy of Windows: The cryptographic operation failed because of a local security option setting

This article provides a solution to an error that occurs when you try to validate a copy of Windows.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2715304

## Symptoms

When you try to validate a copy of Windows, you may receive an error message that resembles the following:

> Update installation failed. Error information: 0x80092026

When you try to validate Windows, Windows downloads an update [971033](https://support.microsoft.com/help/971033). However, when Windows tries to install the update, the update shows an error message that is mentioned above. Additionally, if you try to download the update KB971033 on your machine and run it manually, you may receive following error message:

> Installer encountered an error: 0x80092026  
The cryptographic operation failed due to a local security option setting.

## Cause

This error occurs when the **State** value of the following registry subkey is incorrectly set. This value corresponds to the Internet Explorer security setting **Check for publisher's certificate Revocation** and **Check for signatures on downloaded programs**.

`HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing`

You can find a key with the name **State**. By default the value is set to **23c00**.

## Resolution

To resolve this problem, change the registry key to a valid setting, for example:

- **State** = **0x00023e00** - **Check for publisher's certificate Revocation** Unchecked
- **State** = **0x00023c00** - **Check for publisher's certificate Revocation** Checked

Use one of the following methods:

### Method 1: Edit the registry

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.

1. Start Registry Editor (Regedit.exe).
2. Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing`.
3. On the left side pane, look for State key and double-click to open it.
4. Change the **Value data** to **23c00** or **23e00** (Hexadecimal).
5. Quit Registry Editor.

### Method 2: Create a reg file

1. Start Notepad.
2. In Notepad, paste the following information.

    ```registry
    Windows Registry Editor Version 5.00
    [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing
    "State"=dword:00023c00
    ```

3. Save the file as a .reg file.
4. Double-click the .reg file that you saved in step 3.

Above registry changes don't require any reboot. You can try to install the update manually.

You would be able to validate your Windows successfully.

## More information

In some cases, you might be required to update the **State** value for following two registries as well.

- `HKEY_USERS\S-1-5-18\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing`
- `HKEY_USERS\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing`

> [!NOTE]
> Ensure whatever value is updated for `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing`, should be exact for above two registry.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
