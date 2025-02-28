---
title: include file
description: include file
ms.topic: include
ms.date: 01/20/2025
ms.reviewer: erikje
ms.custom: include file
---
## Missing Start menu and taskbar when using iPad and the Remote Desktop app to access a Cloud PC

When non-local admin users sign in to a Cloud PC by using an iPad and the Microsoft Remote Desktop app, the Start menu and taskbar might be missing from the Windows 11 user interface.

### Solution

Make sure that you have the latest version of the Remote Desktop client, which can be found from [Remote Desktop clients for Remote Desktop Services and remote PCs](/windows-server/remote/remote-desktop-services/clients/remote-desktop-clients).

In addition, you can sign in to the Cloud PC by using [Windows 365](https://windows365.microsoft.com).

## Restore and automatic rolling credentials

Many devices registered with Active Directory might have a machine account password that is automatically updated. By default, these passwords are updated every 30 days. This automation applies to hybrid joined PCs but not Microsoft Entra Native PCs.

The machine account password is maintained on the Cloud PC. If the Cloud PC is restored to a point that has a previous password stored, the Cloud PC won't be able to sign in to the domain.

For more information, see [Machine Account Password Process](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/machine-account-password-process/ba-p/396026).

## Cursor's visible location is offset from the actual position

In a remote desktop session, when you select one position in a text file, the cursor in the Cloud PC has some offset with the actual position.

### Possible cause

In high DPI mode, both the server and Cloud PC browser scale the cursor. This conflict results in an offset between the visible cursor position and the actual cursor focus.

### Solution

Turn off high DPI mode.

## Outlook only downloads one month of mail<!--39845820-->

Outlook only downloads one month of previous mail, which can't be changed in Outlook settings.

### Solution

1. Open Registry Editor.
2. Remove the `syncwindowsetting` registry key under the path:

    `\HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Office\16.0\Outlook\Cached Mode`

3. Add the `syncwindowsetting` registry key with the value `1` under the path:

    `\HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode`

After you complete these steps, the default will be one month. However, the download period can be changed in Outlook settings.
