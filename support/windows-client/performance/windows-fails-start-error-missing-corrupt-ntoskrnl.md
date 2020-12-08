---
title: Windows fails to start with error Missing or Corrupt ntoskrnl.exe when keys are pressed during startup
description: 
ms.date: 12/04/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Windows fails to start with error Missing or Corrupt ntoskrnl.exe when keys are pressed during startup

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 2022960

## Symptoms

When you press or hold down keys on the keyboard as you start your computer, you may see the following message and Windows will fail to start.
Windows could not start because the following file is missing or corrupt:
<Windows root>\system32\ntoskrnl.exe.
Please re-install a copy of the above file.
This problem does not occur if you do not press any keys during startup.
 **Note** This problem can occur on any Windows operating system prior to Windows 7, on both 32-bit and 64-bit platforms.

## Cause

This problem occurs because, during a very small time frame, key presses may cause a part of Windows initialization to fail.
This problem does not cause any corruption or data loss, and the ntoskrnl.exe file is not corrupt as the error message says.

## Resolution

To workaround this issue, do not press any keys during startup until the Windows startup screen is displayed.
