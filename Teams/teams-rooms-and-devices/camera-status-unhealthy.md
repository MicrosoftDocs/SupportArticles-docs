---
title: The Camera status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the Room Camera, Default Room Camera, or Content Camera signals of a Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
ms.topic: troubleshooting
ms.date: 10/30/2023
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: Admin
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:MTR Pro
  - CI167249
---

# The Camera status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), one or more of the following signals of a Microsoft Teams Rooms device are shown as **Unhealthy**:

- Room Camera
- Default Room Camera
- Content Camera

Users might also experience the following issues during a Teams meeting:

- The camera icon on the room console is unavailable.
- The video of in-room participants is unavailable to remote participants.
- The tile that shows a preview of the room's camera isn't presented in the Front of Room display.

## Cause

- The **Room Camera** signal sends an alert if Teams Rooms reports that no room camera is available. If the configured default room camera isn't available, but another camera is available, an alert isn't sent.

  > [!NOTE]
  > The **Room Camera** signal reports the status of the video camera for in-room participants. The report doesn't include the status of the [content camera](/microsoftteams/rooms/content-camera). If a connected camera is configured as a content camera, it can't be used as a room camera.
- The **Default Room Camera** signal sends an alert if the configured default room camera isn't available, but another camera is available. The incident severity value is shown as **Warning**.

  > [!IMPORTANT]
  > When you replace the default room camera, this signal will send an alert, even if you use the same make and model. Cameras are tracked by their hardware ID. The ID is unique to a specific camera when enumerated by Windows. In this case, reselect and save the default camera in the Teams Rooms app settings after you replace it.
- The **Content Camera** signal sends an alert if the configured content camera isn't available.

  > [!NOTE]
  > Some certified cameras can be used as room cameras or content cameras. Therefore, in order to act as a content camera and send alerts, the camera must be configured in the Teams Rooms app settings.

## Resolution

Camera issues can occur for different reasons. To fix common issues that affect the camera, try the following options.

### Make sure the camera is powered on and connected

- Verify that the camera and the Teams Rooms device are securely connected.
- If the camera requires an external power supply, make sure that the power supply is connected.

### Check the camera configuration

Check whether the camera is mistakenly configured as a content camera. A content camera is used to stream a traditional whiteboard into meetings. In this case, set content camera to none in Teams Rooms app settings.

### If you use an all-in-one video bar, reset the bar

All-in-one video bars use only one USB cable to connect to the Teams Rooms device. In this case, reset the power of the device. Some bars might have a reset button.

If the issue persists, contact your peripheral manufacturer to troubleshoot any hardware or firmware issues.

### Check firmware issues

Try the following methods:

- If the peripheral device was recently updated, the firmware update might not be completed. In this situation, the device is in an unusable state. Try to reset the power of the device. Some devices might have a reset button.
- Contact your peripheral manufacturer to verify that the device is running the latest firmware version. Or, work with the manufacturer to fix any known issues.

### Check for issues in USB extenders and USB cables

If possible, avoid using USB extenders for audio and video equipment. If you must use a USB extender, use one that's supported by the peripheral device and meets the device requirements, such as length and USB specification. For more information, contact your peripheral manufacturer.

If the camera doesn't use a USB extender, verify that the USB cable is securely connected and meets the specifications of the camera. Replace the cable if necessary.

### Check the power supply

Many cameras require external power supplies. In this case, make sure that the power supply is connected.
