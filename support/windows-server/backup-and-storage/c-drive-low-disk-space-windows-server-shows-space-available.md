---
title: "C: drive warns for low disk space but Windows Server shows space available"
description: Discusses how to resolve an issue in which the C:\ drive on a Windows Server system displays a low disk space warning even when File Explorer shows available disk space.
ms.date: 03/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai-usage: ai-assisted
ms.custom:
- sap:backup, recovery, disk, and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# C: drive warns for low disk space but Windows Server shows space available

## Summary

The C:\ drive on a Windows Server system can display a low disk space warning even when File Explorer shows available disk space. Reviewing folder sizes in File Explorer doesn't reveal any unusually large folders. This situation typically occurs when one or more applications generate large temporary files in hidden or system-protected directories that standard folder size tools don't report accurately.

This article describes the symptoms, explains the most common cause, and provides steps to identify and remove the files that are consuming disk space.

## Symptoms

You might experience the following symptoms:

- The C:\ drive displays a low disk space warning in Windows Server.
- When you review the folder sizes in File Explorer, you don't see any unusually large folders.
- There aren't any recent configuration changes, installations, or updates (including Windows updates) that explain the sudden loss of free space.
- The problem persists for multiple days.

## Cause

This typical cause of this issue is one or more applications that generate and store large temporary files in particular directories on the C:\ drive. These temporary files aren't part of the Windows operating system, and they might be stored in hidden or system-protected locations. Because of this behavior, folder size metrics might not include these files. Over time, these files accumulate and consume available disk space.

## Resolution

To resolve the issue, follow these steps:

1. Look for large temporary files, especially hidden files. For example, at a Windows PowerShell command prompt, run a command that resembles the following command:

   ```powershell
   Get-ChildItem -Path "C:\" -Recurse -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object FullName, Length -First 20
   ```

   At a Windows Command Prompt, you can run commands that resemble the following example:

   ```cmd
   dir C:\ /s /a /o-s
   ```

   > [!NOTE]  
   > When you use these parameters, the `dir` command recurses subdirectories, includes hidden and system files, and sorts the results by size in descending order.

1. Back up the system, or the folders that contain the temporary files.
1. Determine which application generates the large temporary files. Focus on recently used applications and applications that run continuously.
1. Contact the application vendor to confirm whether the temporary files are required and to configure the application to manage the temporary files more effectively.
1. Remove temporary files that you don't need anymore.
1. To help detect future issues early, monitor folder growth. You can use monitoring tools, PowerShell scripts, or commands such as `dir /all` to track this information.

## Data collection

If you need assistance from Microsoft Support or your application vendor, collect the following information:

- Windows Server version and build details
  > [!NOTE]  
  > To see the exact version and build number, run `winver` at a command prompt on the affected computer.
- A list of installed applications and their versions.
- Directory size reports from tools such as WinDirStat or from PowerShell cmdlets.
- Timestamps and file paths of the largest files on the C:\ drive.
- Event data that covers the period when the disk space started decreasing. You can export this information from Event Viewer.
