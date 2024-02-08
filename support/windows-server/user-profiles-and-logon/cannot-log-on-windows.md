---
title: Can't log on to Windows
description: Describes an issue where you're prompted for user name and password repeatedly when logging on Windows.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
ms.subservice: user-profiles
---
# Windows logs on and logs off immediately

This article describes an issue where you can't sign in to the system and you're prompted for user name and password repeatedly.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555648

## Symptoms

Windows logs on and logs off immediately when you try logging on to Windows. When you type the user name and password, you're again presented with User name and Password dialogue box. You try hard to get in but to no avail.

## Cause

You can't log on to system using either Normal Mode or Safe Mode. This occurs only when Winlogon service tries to load the Windows default shell (explorer.exe) and user shell (userinit.exe) from registry. This service searches for Explorer.exe and Userinit.exe in the following path of registry:

`HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon`

## Resolution

Edit these values and type the correct path of shell:

Shell = explorer.exe  
Userinit=X:\windows\system32\userinit.exe

> [!NOTE]
> These files may also be deleted by spywares. You may need to extract them using Windows CD.

### Steps for rectifying this problem

- Log on to a networked computer.
- Run `Regedit.exe`.
- Point your cursor to `HKEY_LOCAL_MACHINE`.
- Select **File** > **Connect Remote Registry**.
- Type the computer name (infected computer).
- Navigate to the following location in registry of destination or infected computer:

    `HKLM\Software\Microsoft\Windows NT\CurrentVersion\Winlogon`
- Edit these two values in right pane:

     Shell  
     Userinit

- Change these two values to

    Shell=explorer.exe  
    Userinit = x:\windows\system32\userinit.exe
- Exit from Registry.
- Restart the infected computer.
- You should be able to log on to the computer.

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
