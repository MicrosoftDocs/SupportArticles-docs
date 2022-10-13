---
title: The Display status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Display signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
ms.topic: troubleshooting
ms.date: 9/26/2022
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: CI167102
---
# The Display status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Display** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and users experience one or more of the following issues:

- One or more Front of Room displays show nothing or show "No Signal".
- The room console shows nothing or shows "No Signal".
- The room console shows a warning banner at the top that indicates that a display was disconnected.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. For example, the following event is logged:

> {"Description":"Conference Microphone status : Healthy. Conference Speaker status : Healthy. Default Speaker status : Healthy. Camera status : Healthy. **Front of Room Display status : Unhealthy.** Motion Sensor status : Healthy. HDMI Ingest status : Healthy. Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

> [!NOTE]
> Although the event log shows the signal as **Front of Room Display**, the room console status is also monitored. The count of available displays is checked against the expected count. This value depends on whether dual monitor mode is enabled. If dual monitor mode is enabled, the expected count is three: one for the room console and two for the Front of Room displays. Otherwise, the expected count is two.
>
> This signal should remain as **Healthy** even when Teams Rooms allows the displays to *sleep* after 10 minutes (default value) of no activity.

## Resolution

Display issues can occur for different reasons. To fix common issues, try the following options.

### Check HDMI cable connections

Issues can occur if an HDMI cable is unplugged, faulty, or inconsistent. In this situation, reseat the cable at both ends. If the issues persist, try to replace the cable.

### Make sure the display is powered on

For most displays, this won't affect the display's health status. This depends on the display's power state.

Verify that the display is powered on. We recommend that you do not leave the display remote control in the room. If your building uses smart green power management, the outlet that the display is plugged into might be turned off outside business hours.

### Check for issues in HDMI extenders

- Verify that the HDMI extenders are suitable for enterprise or professional AV grade, and that you aren't extending them beyond their rated length.
- Verify that the HDMI extender is working correctly. Replace each end as necessary.

### Check video adapters

If possible, use the native HDMI output of your device. Otherwise, choose the most stable option for your specific compute-and-display combination. You may have to try various high-quality adapters to make the right choice. Avoid using video adapters that don't meet industry standards.

### Check for issues in EDID minders

If EDID control or emulator devices are used, they may be faulty or configured incorrectly. Some HDMI extenders also emulate EDID. Verify that the EDID device is working correctly. If possible, bypass the device as a test. If necessary, replace the EDID device.

### Check whether the room console is disconnected

See the OEM documentation to learn how the room console is connected, such as by using cables. Cable issues can cause a disconnection between the touchscreen console and the compute module. For example, some consoles use hybrid fiber or copper USB cables to connect to the compute module. As for all fiber optic cables, these cables can be damaged and cause intermittent disconnections. In this situation, replace the cable.

Some consoles require external power. In this case, make sure that the power supply is connected.

## Other display issues that don't affect signal health status

Users might report that the Front of Room displays remain off or in standby mode when the room console wakes up as they enter the room or touch the console. In most cases, this doesn't affect the display's health signal because the HDMI cable is still connected from the compute module to the display.

In these situations, try the following options:

- Verify that the display power settings are configured correctly.

  Investigate and test all power-related settings on the Front of Room displays. Each display, manufacturer, and model can be different. Therefore, field testing of various power settings might be necessary. We recommend that you standardize the display brand, model, and settings as much as possible. Many commercial displays allow configuration profiles to be imported and exported through a USB flash drive.
- Check whether the display supports the "wake on signal" feature.

  Most consumer TVs, and even many commercial displays, don't automatically wake up when the Teams Rooms device wakes up and sends a video signal. In these cases, Consumer Electronics Control (CEC) must be supported on the display, and additional hardware might be required to send these CEC signals. For more information, see [Front of Room display settings](/microsoftteams/rooms/rooms-operations#front-of-room-display-settings).
