---
title: Camera status in Event ID 3001 is incorrect after you replace a Teams Rooms camera
description: Learn why Microsoft Teams Rooms for Windows can show an incorrect camera status in Windows Event ID 3001 after you replace the room camera, and how to update the selected camera.
ms.topic: troubleshooting
audience: Admin
ai-usage: ai-assisted
applies to: Microsoft Teams Rooms for Windows
author: Cloud-Writer
ms.author: meerak
ms.reviewer: shupadh, joshj, iztoth, taherr, gurug, migferreira
ms.date: 11/12/2026
---

# Camera status in Event ID 3001 is incorrect after you replace a Teams Rooms camera

## Summary

This article describes an issue in which Microsoft Teams Rooms for Windows reports an incorrect camera status in Windows Event Viewer for **SRS-App, Event ID 3001** after you replace the room camera. It also provides steps to update the room's selected camera.

## Symptoms

You see the following behavior on a Microsoft Teams Rooms for Windows device:

- In the Teams admin center, the **Room Camera** status appears as **Healthy**.
- In Windows Event Viewer, **SRS-App, Event ID 3001** shows the camera status as **Unhealthy**.
- The issue starts after you replace the original room camera with a different camera.
- In Device Manager, you might still see the previous camera listed together with the current camera, even though the previous camera is no longer physically connected.
- If you remove the previous camera from Device Manager, it might reappear after you restart the device.

## Cause

The room is still configured to use the previous camera instead of the replacement camera. Although the replacement camera is connected and available, Microsoft Teams Rooms for Windows doesn't update the preferred camera selection automatically in this scenario.

## Resolution

Update the selected camera in the Microsoft Teams Rooms device settings.

1. On the Microsoft Teams Rooms device, open **Settings**.
1. Go to **Peripherals** > **Cameras**.
1. Select **None**, and then save your changes.
1. Return to **Cameras**, select the currently connected camera that you want the room to use, and then save your changes.

## More information

The Teams admin center shows the room camera as healthy because it detects that a working camera is connected. However, Windows Event Viewer can still reflect the previously configured camera selection until you manually update the preferred camera on the device.

If the issue continues after you update the camera selection, check whether the previous camera still appears in Device Manager and confirm that the correct camera remains selected in the Microsoft Teams Rooms device settings.
