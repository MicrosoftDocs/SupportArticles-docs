---
title: The Room Camera status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Room Camera signal of a Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
ms.topic: troubleshooting
ms.date: 8/29/2023
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
ms.custom: CI167249
---

# The Room Camera status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Room Camera** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**. Users also experience the following issues during a Teams meeting:

- The camera icon on the room console is unavailable.
- The video of in-room participants is unavailable to remote participants.
- The tile that shows a preview of the room's camera isn't presented in the Front of Room display.

## Cause

This issue occurs when Teams Rooms reports that no room camera is detected. If the configured default room camera isn't available, but another camera is available, this signal won't alert. Instead, the **Default Room Camera** signal is shown as **Unhealthy**, and the incident severity value is shown as **Warning**.

> [!NOTE]
> The **Room Camera** signal reports the status of the video camera for in-room participants. The report doesn't include the status of the [content camera](/microsoftteams/rooms/content-camera).

## Resolution

Camera issues can occur for different reasons. To fix common issues that affect the camera, try the following options.

### Make sure the camera is powered on and connected

- Verify that the camera and the Teams Rooms device are securely connected.
- If the camera requires an external power supply, make sure that the power supply is connected.

### Check the camera configuration

Check whether the camera is mistakenly configured as a content camera. A content camera is used to stream a traditional whiteboard into meetings. In this case, set content camera to none in Teams Rooms app settings.

### If you use an all-in-one video bar, reset the bar

All-in-one video bars use only one USB cable to connect to the Teams Rooms device. In this case, reset the power of the device. Some bars may have a reset button to reset the devices.

If the issue persists, contact your peripheral manufacturer to troubleshoot any hardware or firmware issues.

### Check firmware issues

Try the following options:

- If the peripheral device was recently updated, the firmware update might not be completed. In this situation, the device is in an unusable state. Try to reset the power of the device. Some devices may have a reset button to reset the devices.
- Verify with your peripheral manufacturer that the device is running the latest firmware version. Or, work with the manufacturer to fix any known issues.

### Check for issues in USB extenders and USB cables

If possible, avoid using USB extenders for audio and video equipment. If you must use a USB extender, use one that's supported by the peripheral device and meets the requirements, such as length and USB specification. For more information, contact your peripheral manufacturer.

If the camera doesn't use a USB extender, verify that the USB cable is securely connected and meets the specifications of the camera. Replace the cable if needed.

### Check the power supply

Many cameras require external power supplies. In this case, make sure that the power supply is connected.
