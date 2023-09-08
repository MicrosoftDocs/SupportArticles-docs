---
title: Task Manager can't be opened
description: Provides help to resolve an error (Task Manager has been disabled by your administrator) that occurs when you try to use Task Manager.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:task-manager, csstroubleshoot
ms.technology: windows-server-system-management-components
---
# Error message: Task Manager has been disabled by your administrator

This article resolves an error "Task Manager has been disabled by your administrator" that occurs when you try to use Task Manager.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 555480

## Symptoms

When you try to open Windows Task Manger, the following error may appear:

> Task Manager has been disabled by your administrator.

## Cause

1. You use an account that was blocked via the Local Group Policy or Domain Group Policy.

2. Some registry settings block you from using Task Manager.

## Resolution

1. Verify that the Local Group Policy or Domain Group Policy doesn't block you from using Task Manager.

    - Local Group Policy

        1. Go to **Start** > **Run**, type *`Gpedit.msc`*, and then press Enter.

        2. Navigate to **User Configuration** > **Administrative Templates** > **System** > **Ctrl+Alt+Del Options**.

        3. In the right side of the screen, verify that **Remove Task Manager** option set to **Disable** or **Not Configured**.

        4. Close **Gpedit.msc** MMC.

        5. Go to **Start** > **Run**, type *`gpupdate /force`*, and then press Enter.

            > [!NOTE]
            > If you're using Windows 2000, follow KB 227302 instead stage e. Using `SECEDIT` to force a Group Policy refresh immediately.

    - Domain Group Policy

        Contact you local IT support team.

2. Verify correct registry settings:

    1. Go to **Start** > **Run**, type *`regedit`*, and then press Enter.

        > [!WARNING]
        > Modifying your registry can cause serious problems that may require you to reinstall your operating system. Always back up your files before doing this registry hack.

    2. Navigate to the following registry keys and verify that following settings set to default:

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

[!INCLUDE [Community Solutions Content Disclaimer](../../includes/community-solutions-content-disclaimer.md)]
