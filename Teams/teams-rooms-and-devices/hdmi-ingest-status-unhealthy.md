---
title: The HDMI ingest status of a Teams Rooms device is Unhealthy
description: Resolve the issue that causes the HDMI ingest signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: joolive
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
  - CI167102
---
# The HDMI ingest status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), the **HDMI ingest** signal of a Microsoft Teams Rooms device is shown as **Unhealthy**, and you experience one or more of the following issues:

- You can't present content from an external source, such as a laptop, in the room display or meeting through an HDMI input signal (HDMI ingest by using HDMI or USB-C cables).
- You can't complete the initial setup of a new Teams Rooms system, and the Setup wizard returns the following error message:  
  > Connect the room console to the dock.
- The Teams Rooms device isn't listed in the Microsoft Teams admin center.

Additionally, Event ID 3001 is logged under **Applications and Services Logs** > **Skype Room System** in **Event Viewer**. For example, the following event is logged:

> {"Description":"Conference Microphone status : Healthy. Conference Speaker status : Healthy. Default Speaker status : Healthy. Camera status : Healthy. Front of Room Display status : Unhealthy. Motion Sensor status : Healthy. **HDMI Ingest status : Unhealthy.** Content Camera status : Healthy. ","ResourceState":"Unhealthy","OperationName":"HardwareCheckEngine","OperationResult":"Fail","OS":"Windows 10","OSVersion":"10.0.19044.1889","Alias":"lab@contoso.com ","DisplayName":"Lenovo Hub 500 - Rally Plus - 2FoR","AppVersion":"4.13.132.0","IPv4Address":"1.2.3.4","IPv6Address":""}

## Cause

The Microsoft Teams Room app checks whether one of the HDMI ingest modules that's included in the certified Teams Rooms system is detected. It does this by using a set of corresponding device peripheral VID/PID (Vendor ID + Product ID) as a reference.

These issues can occur for the following reasons:

- The HDMI input (ingest) for most Teams Rooms devices is located on the touchscreen console. The console is connected to the compute module by using a cable. Cable issues can cause a disconnection between the touchscreen console and the compute module.
- A small set of Teams Rooms device models have HDMI video input and ingest functions that are supported directly from the compute module or by an additional hardware module that isn't part of the touchscreen console. If this HDMI ingest module is disconnected, you'll experience the issues that are listed in the [Symptoms](#symptoms) section.
- Issues that are caused by older versions of software or firmware.

## Resolution

To fix the issue, follow these steps:

1. Find the OEM and model of the affected Teams Rooms device in the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/). To do this, locate and select the affected device, select the **Settings** tab, and then select the **Device** submenu.
2. Refer to the OEM documentation to verify that a distinct module is used for HDMI video input (ingest). If it is, go to step 4. Otherwise, go to step 3.
3. Check whether the touchscreen console is working correctly. For example, check whether the Teams Rooms app content is displayed correctly and the touchscreen responds to user input as expected. If both conditions are true, go to step 5. Otherwise, refer to the OEM documentation for further troubleshooting, such as the following steps:

   - Some consoles require external power. In this case, make sure that the power supply is connected.
   - Some consoles use hybrid fiber or copper USB cables to connect to the compute module. As for all fiber optic cables, these cables can be damaged and cause intermittent disconnections. In this situation, replace the cable.

   If the issue persists, go to step 5.

4. Refer to the OEM documentation to verify that the HDMI ingest module is in place and configured correctly. Also, try the following options:

   - If cables are used to connect the HDMI ingest module, make sure that all cables that are used are the original cables that came together with the hardware module.
   - Power off the compute unit, reseat the HDMI ingest module or the cables that connect to it, and then power on the system.
   - For some Teams Rooms device models, the HDMI ingest module is integrated within the compute module. If the **HDMI ingest** status is unhealthy, this might be caused by a faulty module or a firmware issue. In this case, contact your OEM for further troubleshooting.

   If the issue persists, go to step 5.

5. Sign in to the Teams Rooms device as an administrator, open the **Windows Update** setting, and then check for updates. Install the latest updates, if any are available. If the issue persists, go to step 6.
6. Verify with your OEM that your Teams Rooms system has the recommended firmware version installed.

## More information

You can also experience these issues if the HDMI ingest cable that's connected to the external video source is unplugged, faulty, or inconsistent, but the **HDMI ingest** status isn't reported as **Unhealthy**. In this case, reseat the cable at both ends, including the external device that's acting as a video source. and the HDMI video input port. If the issues persist, try to replace the cable.
