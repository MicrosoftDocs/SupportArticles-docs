---
title: Scheduled tasks use incorrect user profile paths
description: Discusses a problem in which scheduled tasks reference incorrect user profile paths in Windows Server 2012 and Windows 8. Provides a workaround.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, anwill
ms.custom:
- sap:system management components\task scheduler
- pcy:WinComm User Experience
---
# Scheduled tasks reference incorrect user profile paths

This article provides help to solve an issue where the output is written to an incorrect user profile path when you run a script under a user account by using Windows Task Scheduler.

_Original KB number:_ &nbsp; 2968540

> [!NOTE]
> This problem is fixed for Windows Server 2012 R2 and Windows 8.1 users. For these systems, apply the [KB 3133689](https://support.microsoft.com/help/3133689) hotfix.

## Symptoms

Assume that you configure a Windows PowerShell script to run under a specific user account by using Windows Task Scheduler in Windows Server 2012 or Windows 8. For example, you direct the script to **\<username>**. When the script is run, any output that is directed to the %USERPROFILE% path is written to `C:\Users\Default\*` instead of `C:\Users\<username>\*`.

## Cause

This problem occurs because of an architectural change to Task Scheduler in Windows 8. Because of this change, the user profile for the account configuration may not be fully loaded when the script references the %USERPROFILE% path.

## Workaround

To work around this problem, create a dummy process to run under the context of the desired user account one (1) minute before the scheduled script starts. This makes sure that the user profile is fully loaded when the script runs.
