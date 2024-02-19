---
title: Windows fails to start with error missing or corrupt ntoskrnl.exe when keys are pressed during startup
description: Provides a workaround for the issue Windows fails to start with error missing or corrupt ntoskrnl.exe when keys are pressed during startup.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Windows fails to start with error missing or corrupt ntoskrnl.exe when keys are pressed during startup

This article provides a workaround for the issue Windows fails to start with error missing or corrupt ntoskrnl.exe when keys are pressed during startup.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2022960

## Symptoms

When you press or hold down keys on the keyboard as you start your computer, you may see the following message and Windows will fail to start.

> Windows could not start because the following file is missing or corrupt:  
\<Windows root>\\system32\\ntoskrnl.exe.  
Please re-install a copy of the above file.

This problem does not occur if you do not press any keys during startup.
> [!Note]
> This problem can occur on any Windows operating system prior to Windows 7, on both 32-bit and 64-bit platforms.

## Cause

This problem occurs because during a small time frame, key presses may cause a part of Windows initialization to fail.

This problem does not cause any corruption or data loss, and the ntoskrnl.exe file is not corrupt as the error message says.

## Workaround

To work around this issue, do not press any keys during startup until the Windows startup screen is displayed.
