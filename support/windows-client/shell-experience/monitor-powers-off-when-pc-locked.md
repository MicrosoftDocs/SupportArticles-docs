---
title: Monitor powers off when computer is locked
description: Describes a by-design behavior that computer monitor turns off after 1 minute when the computer is locked
ms.date: 09/09/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Lock Screen or Screensaver
ms.technology: windows-client-shell-experience
---
# Monitor powers off after 1 minute when PC is locked

This article describes a by-design behavior that computer monitor turns off after 1 minute when the computer is locked and provides a solution to solve this issue.

_Original product version:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 2835052

## Symptoms

Consider the following scenario:

- You have a PC running Windows 8.
- You lock the PC. For example, using the Windows Key+L keyboard shortcut or pressing Ctrl+Alt+Del and selecting "Lock".

In this scenario, you may observe that the PC monitor turns off after 1 minute. Changing the setting "Choose when to turn off the display" under Power Options in Control Panel does not change this behavior. This setting can be used to adjust the display timeout used when a user is logged in and idle but does not affect the timeout used when the PC is locked.

## Cause

This behavior is by design in Windows 8. By default, when the console is locked, Windows waits for 60 seconds of inactivity before powering off the display. This setting is not configurable using the Windows user interface.

## Resolution

Using the PowerCfg.exe utility, you can configure the display timeout used when the PC is in an unlocked state as well as when it is at a locked screen. From an administrative command prompt, the following commands can be used to control the display timeout:

- `powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE \<time in seconds>`

- `powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK \<time in seconds>`

- `powercfg.exe /setactive SCHEME_CURRENT`

The VIDEOIDLE timeout is used when the PC is unlocked and the VIDEOCONLOCK timeout is used when the PC is at a locked screen.

> [!NOTE]
> These commands set the timeout used when the system is plugged in and using AC power. To set the timeouts used when on DC (battery) power, use the /setdcvalueindex switch instead of /setacvalueindex.
