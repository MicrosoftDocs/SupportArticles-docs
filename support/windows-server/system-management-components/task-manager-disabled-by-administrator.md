---
title: Task Manager can't be opened
description: Provides help to resolve an error (Task Manager has been disabled by your administrator) that occurs when you try to use Task Manager.
ms.date: 09/23/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Task Manager 
ms.technology: SysManagementComponents 
---
# Error message: Task Manager has been disabled by your administrator

This article provides help to resolve an error (Task Manager has been disabled by your administrator) that occurs when you try to use Task Manager.

_Original product version:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 555480

## Symptoms

When you try to open Windows Task Manger, the following error may appear:

> Task Manager has been disabled by your administrator.

## Cause

1. You use account that was blocked via the Local Group Policy or Domain Group Policy.

2. Some registry settings block you from using Task Manager.

## Resolution

1. Verity that the Local Group Policy or Domain Group Policy doesn't block you from using Task Manager.

    - Local Group Policy

        1. Go to **Start** > **Run** > Write **Gpedit.msc** and press on **Enter** button.

        2. Navigate to **User Configuration** > **Administrative Templates** > **System** > **Ctrl+Alt+Del Options**.

        3. In the right side of the screen verity that **Remove Task Manager** option set to **Disable** or **Not Configured**.

        4. Close **Gpedit.msc** MMC.

        5. Go to **Start** > **Run**, write `gpupdate /force` and press on **Enter** button.

            > [!NOTE]
            > If you are using Windows 2000, follow KB q227302 instead stage e. Using SECEDIT to force a Group Policy refresh immediately.

    - Domain Group Policy

        1. Contact you local IT support team.

2. Verity correct registry settings:

    1. Go to **Start** > **Run**, write *regedit* and press on **Enter** button.

        > [!WARNING]
        > Modifying your registry can cause serious problems that may require you to reinstall your operating system. Always backup your files before doing this registry hack.

    2. Navigate to the following registry keys and verity that following settings set to default:

        Windows Registry Editor Version 5.00

        [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System]  
        DisableTaskMgr=dword:00000000

        [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Group Policy Objects\LocalUser\Software\Microsoft\Windows\CurrentVersion\Policies\System]  
        DisableTaskMgr=dword:00000000

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\system\]  
        DisableTaskMgr=dword:00000000

        [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]  
        DisableCAD=dword:00000000

    3. Reboot the computer.

### Community solutions content disclaimer

Microsoft corporation and/or its respective suppliers make no representations about the suitability, reliability, or accuracy of the information and related graphics contained herein. All such information and related graphics are provided as is without warranty of any kind. Microsoft and/or its respective suppliers hereby disclaim all warranties and conditions with regard to this information and related graphics, including all implied warranties and conditions of merchantability, fitness for a particular purpose, workmanlike effort, title, and non-infringement. You specifically agree that in no event shall Microsoft and/or its suppliers be liable for any direct, indirect, punitive, incidental, special, consequential damages or any damages whatsoever including, without limitation, damages for loss of use, data or profits, arising out of or in any way connected with the use of or inability to use the information and related graphics contained herein, whether based on contract, tort, negligence, strict liability or otherwise, even if Microsoft or any of its suppliers has been advised of the possibility of damages.
