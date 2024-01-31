---
title: Monitor powers off when computer is locked
description: Describes a by-design behavior that computer monitor turns off after 1 minute when the computer is locked
ms.date: 09/09/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:lock-screen-or-screensaver, csstroubleshoot
ms.subservice: shell-experience
---
# Monitor powers off after 1 minute when PC is locked

This article describes a by-design behavior that computer monitor turns off after 1 minute when the computer is locked and provides a solution to solve this issue.

_Applies to:_ &nbsp; Windows 8, Windows 8.1, Windows 10, Windows 11  
_Original KB number:_ &nbsp; 2835052

## Symptoms

Consider the following scenario:

- You have a computer running Windows 8 or a later version of Windows.
- You lock the PC. For example, using the Windows Key+L keyboard shortcut or pressing Ctrl+Alt+Del and selecting "Lock".

In this scenario, you may observe that the PC monitor turns off after 1 minute. Changing the setting "Choose when to turn off the display" under Power Options in Control Panel does not change this behavior. This setting can be used to adjust the display timeout used when a user is logged in and idle but does not affect the timeout used when the PC is locked.

## Cause

This behavior is by design in Windows. By default, when the console is locked, Windows waits for 60 seconds of inactivity before powering off the display. This setting is not configurable using the Windows user interface by default.

## Resolution

Using the PowerCfg.exe utility, you can configure the display timeout used when the PC is in an unlocked state as well as when it is at a locked screen. From an administrative command prompt, the following commands can be used to control the display timeout:

- `powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE \<time in seconds>`

- `powercfg.exe /setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK \<time in seconds>`

- `powercfg.exe /setactive SCHEME_CURRENT`

The VIDEOIDLE timeout is used when the PC is unlocked and the VIDEOCONLOCK timeout is used when the PC is at a locked screen.

> [!NOTE]
> Using Powercfg commands to set the timeout only affects the current power scheme where the system is plugged in and using AC power. To set the timeouts used when on DC (battery) power, use the **/setdcvalueindex** switch instead of the **/setacvalueindex** switch.

## Resolution for Windows 10 and Windows 11

In Windows 10 and Windows 11, you can expose the **Console Lock Display Off Timeout** setting under **Change Plan Settings**. From an administrative command prompt, the following commands can be used to expose the control.

```console
powercfg.exe -attributes SUB_VIDEO 8EC4B3A5-6868-48c2-BE75-4F3044BE88A7 -ATTRIB_HIDE
```

To hide the option, run the following command:

```console
powercfg.exe -attributes SUB_VIDEO 8EC4B3A5-6868-48c2-BE75-4F3044BE88A7 +ATTRIB_HIDE`
```
