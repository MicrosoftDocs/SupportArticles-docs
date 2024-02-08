---
title: Task scheduler runs tasks as background processes
description: Provides solutions to an issue where task scheduler runs tasks as background processes after you use sysprep to create the master image.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:task-scheduler, csstroubleshoot
ms.subservice: system-mgmgt-components
---
# Task scheduler task only runs in the background after you use sysprep to create master image

This article provides solutions to an issue where task scheduler runs tasks as background processes after you use sysprep to create the master image.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 253942

## Symptoms

Task scheduler runs tasks as background processes after sysprep-ing the master computer.

After running mini-setup, in end-user mode, any scheduled task that is started through the Windows Task Scheduler never shows up as a window on the desktop.

The Windows Task Manager shows the task as a process but not as an application. For example, if Calc.exe is scheduled by Task Scheduler at 3 P.M., Calc.exe runs at exactly 3 P.M. but does not appear on the desktop. Instead, Calc.exe acts like a background process.

This behavior occurs only if you used SYSPREP to create the master image, and is language independent.

## Cause

After running sysprep on the machine, the following registry entry will contain the path to Explorer.exe and a comma at the end of the value: "C:\Winnt\Explorer.exe,"
`HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ Shell:REG_SZ:C:\Winnt\Explorer.exe,`  

The full path to Explorer.exe, including the command, results in this behavior.

## Resolution

The options to resolve this problem are:

Modify the following registry value removing the path to explorer and the trailing comma at the end of explorer as described in the Cause section above. The value should read exactly as shown here: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Winlogon\ Shell:REG_SZ:Explorer.exe`  

-or-

If you are not using SP1 yet, then you should use Sysprep version 1.1 with the -CLEAN switch. To accomplish that task, follow these steps:  

1. Add the following to your Sysprep.inf file:

   ```inf
   [Unattended]  
   InstallFilesPath="%systemdrive%\sysprep\i386"  
   ```

   Create the \i386\$OEM$ directory structure below the sysprep directory (for example, c:\sysprep\i386\$OEM$)

   or

   drive:\distribution\$OEM$\$1\sysprep\i386\$OEM$ (for a distribution share that already contains Sysprep).

2. Create a Cmdlines.txt file in %systemdrive%\sysprep\i386\$OEM$ (or drive:\distribution\$OEM$\$1\sysprep\i386\$OEM$), which contains the following:

   ```inf
   [Commands]  
   "%systemdrive%\sysprep\sysprep.exe -clean"  
   ```

> [!NOTE]
> Running sysprep from the audit mode or the [GUIRunOnce] section of the Unattend.txt file is still required. This method ensures that sysprep -CLEAN runs separately during the mini-setup.

## Status

Microsoft has confirmed this to be a problem in the Microsoft products listed at the beginning of this article.

## More information

### Steps to Reproduce Behavior

1. Perform a retail install (can be an unattended installation) of Microsoft Windows 2000.
2. Create the C:\Sysprep folder.
3. Copy the Setupcl.exe, Sysprep.exe, and Sysprep.inf files into the C:\Sysprep folder.
4. Run SYSPREP without any switches.
5. Reboot the system.
6. Follow through the mini-setup wizard.
7. Run Task Scheduler in end user mode and go through the Task Scheduler Wizard.
8. Select an application to schedule (for example, Calc.exe or CDplayer.exe).
9. Select the "One time only" option and specify the date and time for the application to run.
10. Input a user name and password or use the default administrator account.
11. Wait until the specified time.
