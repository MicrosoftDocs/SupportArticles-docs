---
title: Collect crash dump files on Microsoft Teams Rooms for Windows
description: Learn how to determine whether you need a crash dump file and how to collect one on a Microsoft Teams Rooms for Windows device.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/17/2026
---

# Collect crash dump files on Microsoft Teams Rooms for Windows

## Summary

This article explains how to determine whether a Microsoft Teams Rooms for Windows device crash might require a dump file, and how to collect that dump file.

## Symptoms

You might need to collect a dump file if a Microsoft Teams Rooms for Windows device shows one or more of these symptoms:

- The Teams Rooms app crashes.
- The Teams Rooms app freezes.
- The device stops responding during normal use.
- Windows Application event logs show crash-related events, such as Event ID 1000 or Event ID 1001.

## Cause

The Teams Rooms app or another component on the device crashes or stops responding. The specific root cause isn't identified by this article.

## Resolution

### Check whether a dump file is needed

1. Open the collected Microsoft Teams Rooms for Windows logs, and then go to the `Windows\EventLog` folder.
1. Open the `Application.evtx` file on a Windows PC.
1. Review the Application log for Event ID 1000 or Event ID 1001 around the time when the crash or freeze occurs.
1. Compare the event timestamps with the reported incident time, because Event Viewer shows times based on the local time of the PC that you use to open the log file.

### Option 1: Enable crash dumps from the Teams Rooms Pro management portal

> [!NOTE]
> This option enables crash dump collection for 24 hours.

1. Open the Teams Rooms Pro management portal.
1. Go to **Rooms**, select the room, and then select **Actions** > **Enable crash dumps** > **Run**.
1. Enter a reason for running the action, and then select **Run**.
1. Confirm that the action succeeds in the **Activity** tab.
1. Reproduce the issue, if needed, and wait for the next crash to occur.
1. Collect the dump file from `C:\Rigel\CrashDump`.
1. Collect the corresponding Microsoft Teams Rooms for Windows logs again so that you have both the crash dump and the related logs from the same timeframe.

### Option 2: Configure Windows Error Reporting manually

1. Use the Windows Error Reporting configuration described in the Microsoft documentation for collecting user-mode dumps.
2. Open Regedit and Navigate to HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps.   If the key for LocalDumps does not exist, create it.
1. Create and configure these recommended values:
   - Create a REG_EXPAND_SZ called `DumpFolder` value example 'c:\CrashDumps'
   - Create a REG_DWORD called `DumpCount` value `10`
   - Create a REG_DWORD called `DumpType` value `2` for a full dump.
1. Reproduce the issue, if needed, and wait for the next crash to occur.
1. Collect the dump file from the folder that you configured in `DumpFolder`, example 'c:\CrashDumps'.
1. Collect the corresponding Microsoft Teams Rooms for Windows logs again so that you have both the crash dump and the related logs from the same timeframe.

## More information

For more information about Windows Error Reporting dump collection, see the public Microsoft documentation for collecting user-mode dumps:
[/windows/win32/wer/collecting-user-mode-dumps](/windows/win32/wer/collecting-user-mode-dumps)

A dump file must be accompanied by the Teams Rooms Device logs from the same incident timeframe.
