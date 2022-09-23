---
title: The microphone or speaker status of an MTR device is unhealthy
description: Resolve the issue that the microphone or speaker signal of a Microsoft Teams Rooms (MTR) device is unhealthy.
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
# The microphone or speaker status is unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), one or more of the following signals of a Microsoft Teams Rooms (MTR) device are **Unhealthy**:

- Conference microphone
- Conference speaker
- Default speaker

End users experience one or more of the following issues:

- Remote participants can't hear in-room participants.
- In-room participants can't hear remote participants.
- In-room participants can't hear the ringtone for incoming calls.
- Audio from an HDMI ingest source, such as a laptop, can't be heard from room speakers.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. Below is an example:

> {"Description":"**Conference Microphone status : Unhealthy. Conference Speaker status : Unhealthy. Default Speaker status : Unhealthy.** Camera status : Healthy. Front of Room Display status : Healthy. Motion Sensor status : Healthy. HDMI Ingest status : Healthy. Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

Audio peripheral issues can occur for different reasons. Try the following options to fix common issues.

## Make sure the power supply is connected

Most audio peripherals require external power beyond what's available through the USB bus. In this case, make sure the power supply is connected and the peripheral is turned on.

## Check the USB cable connection

Issues can occur when the USB cable is unplugged, faulty, or inconsistent. In this case, reseat the cable at both ends. If the issue persists, try replacing the cable.

## Check firmware issues

Try the following options:

- If the peripheral has been updated recently, the firmware update might not be completed, so that the device is in an unusable state. Try to reset the power of the device. Some devices may have a reset button to reset the devices.
- Confirm with your peripheral manufacturer that the device is running the latest version of firmware. Or work with them to fix any known issues.

## Check issues with USB extenders if you use them

Avoid using USB extenders for audio and video equipment if possible. If you must, use a USB extender that's supported by the peripheral device and meets the requirements, such as length and USB specification. For more information, verify with your peripheral manufacturer.

## More information

These signals are handled differently in the MTR Pro Management portal and the Microsoft Teams admin center.

**Microsoft Teams admin center**: The portal reports the signal as unhealthy in the following situations:

- The MTR app has a specific audio peripheral configured in **Settings** and the peripheral is no longer available.
- There is no audio peripheral available.

**MTR Pro Management portal**: If the configured audio peripheral isn't available, the next available microphone or speaker is automatically selected. The portal reports the signal as unhealthy if the following conditions are met:

- The configured default peripheral is missing.
- There is no certified integrated audio available, such as the Lenovo Hub, Lenovo Hub 500, or HP Slice integrated audio.
