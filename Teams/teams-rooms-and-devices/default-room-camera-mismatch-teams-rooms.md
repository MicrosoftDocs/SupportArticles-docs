---
title: Default room camera mismatch in Teams Rooms
description: Learn how to fix the default room camera mismatch in Teams Rooms for Windows. Reselect the camera or reset it to None to clear the warning.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/20/2026
ms.custom:
  - sap:Teams Devices\Msft Teams Rooms Windows (MTRW)
  - CSSTroubleshoot
---

# Default room camera mismatch in Teams Rooms

## Summary

This article explains how to fix the default room camera mismatch warning in Microsoft Teams Rooms for Windows. Learn why the warning appears and how to update the camera selection so the configured camera matches the camera the device uses.

## Symptoms

You see a warning that states that the default room camera doesn't match the camera configured in Teams Rooms settings.

The room usually remains usable because a camera is still available. This warning indicates a settings mismatch, not necessarily a camera failure. If no camera is detected at all, you see a different camera health issue instead.

## Cause

This mismatch can occur if you move the camera to a different USB port after you save the original setting, or if a different camera is now connected.

## Resolution

To fix the issue, follow these steps:

1. Open the Microsoft Teams Rooms settings on the room console or by using a supported remote access method.
1. Go to the camera settings.
1. Reselect the intended camera, and then apply the settings.
1. Check whether the warning clears.
1. If the warning remains, select **None** for the camera, apply the settings, then select the correct camera again, and apply the settings.

> [!NOTE]
> You can't change the room camera selection from the Teams admin portal. You must update the setting directly on the device or through remote access to the device.

## More information

Teams Rooms compares the configured camera instance ID with the camera instance ID that Windows currently reports as active. The values must match exactly for the warning to clear.

If the camera display name looks correct but the warning still appears, the saved instance ID might still differ from the active device instance ID. Reselecting the camera updates the saved value.

If no room camera is detected, this warning isn't the expected result. In that case, investigate the room camera availability issue instead.
