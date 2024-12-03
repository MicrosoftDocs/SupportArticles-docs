---
title: The Front of Room status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Front of Room signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
ms.topic: troubleshooting
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI167102
---

# The Front of Room status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Display - Front of Room** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and users experience one or more of the following issues:

- One or more Front of Room displays show nothing or show a "No Signal" message.
- The room console shows a warning banner at the top that indicates that a display is disconnected.

## Cause

This signal sends an alert if one or more Front of Room displays are no longer detected. The count of available displays is checked against the dual display configuration in the Microsoft Teams Rooms app. Although the consoles are displays, this signal filters out the certified consoles and counts the remaining consoles as Front of Room displays. If you use a non-certified console, this signal won't send an alert correctly.

> [!NOTE]
> 
> This signal should remain as **Healthy** even if Teams Rooms allows the displays to *sleep* after 10 minutes (default value) of no activity.

## Resolution

Display issues can occur for different reasons. To fix common issues, try the following methods.

### Check HDMI cable connections

Issues can occur if an HDMI cable is unplugged, faulty, or inconsistent. In this situation, reseat the cable at both ends. If the issues persist, try to replace the cable.

### Make sure the display is powered on

For most displays, this condition won't affect the display's health status. Whether it does depends on the display's power state.

Verify that the display is powered on. We recommend that you do not leave the display remote control in the room. If your building uses smart green power management, the outlet that the display is plugged into might be turned off outside business hours.

### Check for issues in HDMI extenders

- Verify that the HDMI extenders are AV grade and suitable for enterprise or professional use, and that you aren't extending them beyond their rated length.
- Verify that the HDMI extender is working correctly. Replace each end as necessary.

### Check video adapters

If possible, use the native HDMI output of your device. Otherwise, choose the most stable option for your specific compute-and-display combination. You might have to try various high-quality adapters to make the right choice. Avoid using video adapters that don't meet industry standards.

### Check for issues in EDID minders

If an EDID control or emulator device is used, it might be faulty or configured incorrectly. Some HDMI extenders also emulate EDID. Verify that the EDID device is working correctly. If possible, bypass the device as a test. If necessary, replace the EDID device.

## Other display issues that don't affect signal health status

Users might report that the Front of Room displays remain off or in standby mode when the room console wakes up as they enter the room or touch the console. In most cases, this doesn't affect the display's health signal because the HDMI cable is still connected from the compute module to the display.

In these situations, try the following methods:

- Verify that the display power settings are configured correctly.

  Investigate and test all power-related settings on the Front of Room displays. Each display, manufacturer, and model can be different. Therefore, it might be necessary to field test various power settings. We recommend that you standardize the display brand, model, and settings as much as possible. Many commercial displays allow configuration profiles to be imported and exported through a USB flash drive.
- Check whether the display supports the "wake on signal" feature.
- Most consumer TV sets, and even many commercial displays, don't automatically wake up when the Teams Rooms device wakes up and sends a video signal. In these cases, Consumer Electronics Control (CEC) must be supported on the display, and additional hardware might be required to send these CEC signals. Some PCs that are certified for use in Microsoft Teams Rooms include integrated CEC support. For more information, contact your PC's OEM, and also see [Front of Room display settings](/microsoftteams/rooms/rooms-operations#front-of-room-display-settings).
