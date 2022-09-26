---
title: The Display status of an MTR device is unhealthy
description: Resolve the issue that the Display signal of a Microsoft Teams Rooms (MTR) device is Unhealthy.
ms.reviewer: 
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
# The Display status is unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Display** signal of a Microsoft Teams Rooms (MTR) device is **Unhealthy**. And end users experience one or more of the following issues:

- One or more front of room displays show nothing or show "No Signal".
- The room console shows nothing or shows "No Signal".
- The room console shows a warning banner at the top indicating that a display has been disconnected.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. Below is an example:

> {"Description":"Conference Microphone status : Healthy. Conference Speaker status : Healthy. Default Speaker status : Healthy. Camera status : Healthy. **Front of Room Display status : Unhealthy.** Motion Sensor status : Healthy. HDMI Ingest status : Healthy. Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

> [!NOTE]
> Although the event log shows the signal as **Front of Room Display**, the room console status is also monitored. The count of available displays is checked against the expected count, which depends on whether dual monitor mode is enabled. If dual monitor mode is enabled, the expected count is three, one for the room console and two for the front of room displays. Otherwise, the expected count is two.
>
> This signal should remain healthy even when MTR allows the displays to *sleep* after the default value of 10 minutes of no activity.

Display issues can occur for different reasons, try the following options to fix common issues.

## Check HDMI cable connection

Issues can occur when HDMI cable is unplugged, faulty, or inconsistent. In this case, reseat the cable at both ends. If the issues persist, try replacing the cable.

## Make sure the display is powered on

For most displays, this won't affect the display's health status, but it depends on the display's power state.

Verify that the display is powered on. It's not recommended to leave the display remote control in the room. If your building uses smart green power management, the outlet the display is plugged into may be turned off outside of business hours.

## Check issues with HDMI extenders if you use them

- Verify that the HDMI extenders are suitable for enterprise or professional AV grade, and you aren't extending them beyond their rated length.
- Verify if the HDMI extender is working correctly. Replace each end as needed.

## Check video adapters

If possible, use the native HDMI output of your device. Otherwise, choose the most stable option for your specific compute and display combination. You may need to try various high-quality adapters to make a choice. Avoid using video adapters that don't meet industry standards.

## Check issues with EDID minders

If EDID control/emulator devices are used, they may be faulty or incorrectly configured. Some HDMI extenders also emulate EDID. Verify that the EDID device is working correctly. Bypass the device as a test if possible. If necessary, replace the EDID device.

## Check if the room console is disconnected

See the OEM documentation to find out how the room console is connected, such as using cables. Cable issues can cause a disconnect between the touchscreen console and the compute module. For example, some consoles use hybrid fiber/copper USB cables to connect to the compute module. As with all fiber optic cables, these cables can be damaged and cause intermittent connections. In this case, replace the cable.

Some consoles require external power. In this case, make sure the power supply is connected.

## Other display issues that don't affect signal health status

End users may report that the front of room displays remain off or in standby mode, while the room console wakes up when they enter the room or touch it. In most cases, this doesn't affect the display's health signal, as the HDMI cable is still connected from compute to the display.

In these situations, try the following options:

- Verify the display power settings are configured correctly.

  Investigate and test all power-related settings on the front of room displays. Each display, manufacture and model can be different, so field testing of various power settings may be needed. Therefore, it's recommended to standardize the display brand, model, and settings as much as possible. Many commercial displays allow configuration profiles to be imported and exported to a USB flash drive.
- Check if the display supports the "wake on signal" feature.

  Most consumer TVs, and even many commercial displays, don't automatically wake up when the MTR device wakes up and sends a video signal. In these cases, Consumer Electronics Control (CEC) must be supported on the display, and additional hardware may be required to send these CEC signals. A consumer TV used as a front of room display needs to support the Consumer Electronics Control (CEC) feature of HDMI. For more information, see [Front of Room display settings](/microsoftteams/rooms/rooms-operations#front-of-room-display-settings).
