---
title: Fix the Windows OS activation status on Teams Rooms for Windows
description: Learn how to identify and resolve Windows OS activation issues on Teams Rooms for Windows devices.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/24/2026
ms.custom:
  - sap:Teams Devices\Msft Teams Rooms Windows (MTRW)
  - CSSTroubleshoot
---

# Fix the Windows OS activation status on Teams Rooms for Windows

## Summary

This article explains how to identify and troubleshoot a Windows OS activation issue on a Microsoft Teams Rooms for Windows device.

## Symptoms

You see an alert that indicates the Windows operating system on the device isn't activated.

You might also notice one or both of these symptoms:

- Windows shows the **unlicensed** watermark on the Teams Rooms display.
- The device has issues with installing or receiving updates.

## Cause

Windows reports the OS activation state as not licensed. The alert that you see only identifies that Windows isn't activated. It doesn't activate Windows or automatically fix the licensing issue.

If your device uses an OEM image, the image should already be activated when it's delivered.

## Resolution

To fix the issue, follow these steps:

1. Sign in to the local admin desktop on the Teams Rooms for Windows device.
1. Open **Start**, search for **Activation settings**, and then review the activation status.
1. If Windows isn't activated, determine how the device was deployed:
   - If you're using an original equipment manufacturer (OEM) image that came with the device, contact the device manufacturer for help with Windows licensing and activation.
   - If you're using your own Windows image, troubleshoot the Windows activation issue by using the activation error code that Windows reports.
1. If you have an activation error code, run the following command on the device to get more details:

   ```cmd
   slui.exe 0x2a <activation error code>
   ```

1. Review the details in the Windows activation dialog, and then follow the recommended troubleshooting guidance.

For more information about troubleshooting Windows activation issues, see the following guidance:

- [Using the Windows Activation troubleshooter](https://support.microsoft.com/windows/activation/using-the-windows-activation-troubleshooter)
- [Get help with Windows activation errors](https://support.microsoft.com/windows/activation/get-help-with-windows-activation-errors)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
