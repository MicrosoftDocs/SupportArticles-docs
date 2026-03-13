---
title: Scheduled Task Can't Run an Exe File on a Share Folder
description: Provides a workaround to an issue in which scheduled task can't run an .exe file on a share folder in Windows.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:system management components\task scheduler
- pcy:WinComm User Experience
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Scheduled task can't run an .exe file on a share folder in Windows

## Summary

Consider the following scenario:

- You set up a share folder in a domain environment.
- You configure the share or New Technology File System (NTFS) level permission settings on the share folder.
- You set up a task schedule on a client computer. The task runs an .exe file on the share folder.
- Only the user account that is used to run the task has the access permission to the share folder.

In this scenario, the task can't run. You receive an access denied or a not found error.

## More Information

To work around this issue, use one of the following steps:

1. Assign the access permission for the share folder to the client computer.
2. Configure the task to run `cmd /c \\share\name.exe` instead of `\\share\name.exe`.

> [!NOTE]
> `\\share\name.exe` is the placeholder of the path of the share folder.
