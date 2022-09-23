---
title: The Camera status of an MTR device is unhealthy
description: Resolve the issue that the Camera signal of a Microsoft Teams Rooms (MTR) device is unhealthy.
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
ms.custom: CI167249
---
# The Camera status is unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **Camera** signal of a Microsoft Teams Rooms (MTR) device is **Unhealthy**. And end users experience the following issues during a Teams meeting:

- The camera icon on the room console is greyed out.
- The video of in-room participants isn't available to remote participants.
- The tile with a preview of the room's camera isn't presented in the front of room display.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. Below is an example:

> {"Description":"Conference Microphone status : Healthy. Conference Speaker status : Healthy. Default Speaker status : Healthy. **Camera status : Unhealthy.** Front of Room Display status : Healthy. Motion Sensor status : Healthy. HDMI Ingest status : Healthy. Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

> [!NOTE]
> The **Camera** signal reports the status of the default video camera that's configured in MTR app settings. It doesn't include the status of the [content camera](/microsoftteams/rooms/content-camera).

Camera issues can occur for different reasons. Try the following options to fix common issues with the camera.

## Make sure the camera is powered on and connected

- Verify that the camera and the MTR device are securely connected.
- If the camera requires an external power supply, make sure the power supply is connected.

## Check if the camera is mistakenly configured as a content camera

Content camera is used to stream a traditional whiteboard into meetings. In this case, set content camera to none in MTR app settings. 

## Check if the default camera instance is changed

The MTR app tracks the default camera using a specific camera instance ID, which is a combination of a specific camera (according to a serial number) on a specific USB port. The instance ID will change in either of the following situations:

- You replace the camera with another camera, even with the same brand and model.
- You change the connection from one USB port to another.

In this case, select the new camera instance as the default camera in MTR app setting.

> [!NOTE]
> In MTR app version 4.13.*, the default camera is automatically set in the following scenario:
>
> - The default camera hasn't been configured.
> - An administrator opens **Settings** > **Peripherals**, configures any other settings but the default camera, then save the settings and exit.
>
> In this scenario, the first available camera is automatically selected as the default video camera.

## If you use an all-in-one video bar, reset the bar

All-in-one video bars use only one USB cable to connect to the MTR device. In this case, reset the power of the device. Some bars may have a reset button to reset the devices.

If the issue persists, contact your peripheral manufacturer to troubleshoot any hardware or firmware issues.

## Check firmware issues

Try the following options:

- If the peripheral device has been updated recently, the firmware update might not be completed, so that the device is in an unusable state. Try to reset the power of the device. Some devices may have a reset button to reset the devices.
- Confirm with your peripheral manufacturer that the device is running the latest version of firmware. Or work with them to fix any known issues.

## Check issues with USB extenders if you use them

Avoid using USB extenders for audio and video equipment if possible. If you must, use a USB extender that's supported by the peripheral device and meets the requirements, such as length and USB specification. For more information, verify with your peripheral manufacturer.
