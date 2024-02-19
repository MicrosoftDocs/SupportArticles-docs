---
title: The task XML is missing a required element or attribute error when you use the /z switch together with the Schtasks command in Windows Vista
description: Resolve an issue where you receive an error when you use the /z switch together with the Schtasks.exe command in Windows Vista.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:task-scheduler, csstroubleshoot
---
# Error when you use the /z switch together with the Schtasks command in Windows Vista: The task XML is missing a required element or attribute

This article helps resolve an issue where you receive an error when you use the **/z** switch together with the **Schtasks.exe** command in Windows Vista.

_Applies to:_ &nbsp; Windows Vista  
_Original KB number:_ &nbsp; 2004151

## Symptoms

When you use the **/z** switch together with the `Schtasks.exe` command in Windows Vista, you may receive the following error message:

> Error: The task XML is missing a required element or attribute.

The **/z** switch is used to delete a task after it's completed. For example, you can use the following command to start the Calc.exe process at a specified date and time:

```console
schtasks /create /tn "calculator" /tr c:\Windows\System32\calc.exe /sc once /sd 12/02/2010 /st 03:39:00 /z  
```

> [!Note]
> This issue affects only the Schtasks.exe tool. You should be able to use the Scheduled Tasks interface to auto-delete a task after it's completed.

## Cause

This issue occurs because of changes in the Task Scheduler service in Windows Vista.

## Resolution

To resolve this issue, use the **/V1** switch. The **/V1** switch creates a task that is compatible with pre-Windows Vista platforms. For example, use the following command to start the Calc.exe process at a specified date and time in a pre-Windows Vista environment:

```console
schtasks /create /tn "calculator" /tr c:\Windows\System32\calc.exe /sc once /sd 12/02/2010 /st 03:39:00 /V1 /Z
```

## More information

For more information about the **/V1** switch, visit the following MSDN website:

[Schtasks.exe](/windows/win32/taskschd/schtasks)
