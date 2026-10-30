---
title: Capacity limit exceeded on Teams Rooms on Windows device
description: Describes why a Teams Rooms on Windows device shows a capacity limit exceeded notification during a meeting and how to update or disable the room occupancy setting.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug
author: Cloud-Writer
ms.author: meerak
ms.date: 10/29/2026
---

# Capacity limit exceeded on Teams Rooms on Windows device

## Summary

This article explains how to resolve capacity limit notifications in Teams Rooms on Windows devices by updating the room capacity or occupancy notification settings.

## Symptoms

During a meeting on a Microsoft Teams Rooms on Windows device, you see a notification that the room exceeds its capacity limit. This notification can appear as a room occupancy or social distancing alert.

## Cause

A setting is configured in Microsoft Exchange to specify the capacity of the room resource account. When this capacity is exceeded, the device displays a notification by default.

## Resolution

Use one of the following methods to resolve the issue.

### Increase the room capacity setting

1. Connect to Exchange PowerShell.
1. Run the following command to increase the room capacity for the room resource account:

   ```powershell
   Set-Mailbox "Device 1" -ResourceCapacity 100
   ```

1. Replace `"Device 1"` with the room resource account name, and replace `100` with the capacity value that you want.
1. Confirm that the updated capacity is applied to the room resource account.

> [!NOTE]
> The updated capacity is reflected on the Exchange resource account immediately.

### Turn off the maximum room occupancy notification

1. Open the Teams Rooms configuration profile that applies to your devices.
1. Under **Meeting settings**, turn off **Maximum room occupancy notification**.
1. Assign the configuration profile to the Teams Rooms devices that you want to update.
