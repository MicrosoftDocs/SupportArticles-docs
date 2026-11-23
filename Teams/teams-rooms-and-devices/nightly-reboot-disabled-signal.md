---
title: NightlyReboot task disabled signal
description: Learn why the NightlyReboot task disabled signal appears for a Teams Rooms on Windows device, and follow the steps to re-enable the task.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/20/2026
ms.custom: 
  - sap:Teams Devices/MTR Pro
  - CSSTroubleshoot
---

# Nightly reboot disabled signal

## Summary

This article explains why the nightly reboot disabled signal appears in the Teams Rooms Pro Management portal for a Microsoft Teams Rooms on Windows device, and how to restore the **NightlyReboot** scheduled task.

## Symptoms

You see a nightly reboot disabled signal for a device in the Teams Rooms Pro Management portal. The portal might also open an incident for the device.

You might also notice one or more of the following conditions:

- The device runs continuously for more than two days.
- Daily maintenance operations don't run during the expected maintenance window.
- Updates or remediations don't run as expected.

## Cause

The signal appears when both of the following conditions are true:

- The Windows scheduled task named **NightlyReboot** is disabled.
- Device uptime indicates that the device didn't restart for an extended period.

The task might be disabled for one of the following reasons:

- The device temporarily disables the task while it installs an operating system upgrade, and the task isn't re-enabled after maintenance finishes.
- An administrator disables, renames, or deletes the task.
- A management policy, such as a Microsoft Intune policy or Group Policy setting, repeatedly disables the task.

> [!NOTE]
> Disabling the **NightlyReboot** task isn't supported. Teams Rooms on Windows devices run overnight maintenance operations that can require an operating system restart.

## Resolution

1. Check whether the device runs a supported Windows version. If it runs a version earlier than 19044, update the device to a supported version.
1. If the device is stuck on an older version, use the Microsoft Teams Rooms Pro Provisioning Tool to help upgrade it to the latest supported Windows 10 build.
1. After the operating system update finishes and the device returns to normal operation, sign in to the device with an administrator account.
1. Open **Task Scheduler**.
1. Go to **Task Scheduler Library** > **Microsoft** > **Skype**.
1. Locate the **NightlyReboot** task, and enable it if it's disabled.
1. Monitor the device, and verify that the signal clears after the device reports its updated status.

### If the signal returns

1. Review the Microsoft Intune policies, Group Policy settings, and other device management configurations that apply to the device.
1. Check whether any policy disables scheduled tasks or specifically disables the **NightlyReboot** task.
1. Update the policy so that the task remains enabled.

If the **NightlyReboot** task was renamed or deleted, reimage the device. There's no supported method to re-create the task configuration manually.

## More information

The nightly reboot disabled signal uses two inputs:

- The state of the **NightlyReboot** task.
- Device uptime.

Check device uptime in Windows PowerShell by running the following command:

```powershell
(gcim Win32_OperatingSystem).LastBootUpTime
```

Check the scheduled task status by running the following command:

```powershell
Get-ScheduledTask -TaskName "NightlyReboot" -ErrorAction Stop
```

If an operating system upgrade fails, the task is expected to be re-enabled at the end of the maintenance window. If that condition isn't met, the signal remains active until you correct the task state or restore the device.
