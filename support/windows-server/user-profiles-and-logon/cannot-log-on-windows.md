---
title: Can't log on to Windows
description: Describes an issue where you're prompted for user name and password repeatedly when logging on Windows.
ms.date: 10/09/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User Logon fails
ms.technology: UserProfilesAndLogon
---
# Windows logs on and logs off immediately

This article describes an issue where you can't sign in to the system and you're prompted for user name and password repeatedly.

_Original product version:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 555648

## Community solutions content disclaimer

> Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. all such information and related graphics are provided "as is" without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. you specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.

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
