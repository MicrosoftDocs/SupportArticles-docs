---
title: The microphone or speaker status of an MTR device is unhealthy
description: Fixes the issue that causes the microphone or speaker signal of a Microsoft Teams Rooms (MTR) device to appear as Unhealthy.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 9/23/2022
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
ms.custom: CI167310 
---
# The microphone or speaker status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), one or more of the following signals of a Microsoft Teams Rooms (MTR) device are shown as **Unhealthy**:

- Conference microphone
- Conference speaker
- Default speaker

Users experience one or more of the following issues:

- Remote participants can't hear in-room participants.
- In-room participants can't hear remote participants.
- In-room participants can't hear the ringtone for incoming calls.
- Audio from an HDMI ingest source, such as a laptop, can't be heard from room speakers.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. For example, the following event is logged:

> {"Description":"**Conference Microphone status : Unhealthy. Conference Speaker status : Unhealthy. Default Speaker status : Unhealthy.** Camera status : Healthy. Front of Room Display status : Healthy. Motion Sensor status : Healthy. HDMI Ingest status : Healthy. Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

## Resolution

Audio peripheral issues can occur for different reasons. To fix common issues, try the following options.

### Make sure the power supply is connected

Most audio peripherals require external power beyond what's available through the USB bus. In this situation, make sure that the power supply is connected and the peripheral is turned on.

### Check the USB cable connection

Issues can occur if the USB cable is unplugged, faulty, or inconsistent. In this situation, reseat the cable at both ends. If the issue persists, try to replace the cable.

### Check firmware issues

Try the following options:

- If the peripheral was updated recently, the firmware update might not be completed. This would cause the device to be in an unusable state. Try to reset the power for the device. Some devices may have a reset button.
- Verify with your peripheral manufacturer that the device is running the latest version of firmware. Or work with them to fix any known issues.

### Check issues in USB extenders

If possible avoid using USB extenders for audio and video equipment. If you must use a USB extender, use one that's supported by the peripheral device and meets its requirements, such as length and USB specification. For more information, contact your peripheral manufacturer.

## More information

These signals are handled differently in the MTR Pro Management portal and the Microsoft Teams admin center.

**Microsoft Teams admin center**: The portal reports the signal as **Unhealthy** in the following situations:

- The MTR app has a specific audio peripheral configured in **Settings** and the peripheral is no longer available.
- There is no audio peripheral available.

**MTR Pro Management portal**: If the configured audio peripheral isn't available, the next available microphone or speaker is automatically selected. The portal reports the signal as **Unhealthy** if the following conditions are met:

- The configured default peripheral is missing.
- There is no available certified integrated audio, such as the Lenovo Hub, Lenovo Hub 500, or HP Slice integrated audio.
