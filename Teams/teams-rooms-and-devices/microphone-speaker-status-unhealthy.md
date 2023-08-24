---
title: The microphone or speaker status of a Teams Rooms device is unhealthy
description: Fixes the issue that causes the microphone or speaker signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
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

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), one or more of the following signals of a Microsoft Teams Rooms device are shown as **Unhealthy**:

- Conferencing Microphone
- Conferencing Speaker
- Default Speaker

Users experience one or more of the following issues:

- Remote participants can't hear in-room participants.
- In-room participants can't hear remote participants.
- In-room participants can't hear the ringtone for incoming calls.
- Audio from an HDMI ingest source, such as a laptop, can't be heard from room speakers.

## Signal Logic

This alert is triggered when the system reports that no viable speaker or mic peripheral is in-use. If the configured default device is unavailable but another, viable, device is in use, this signal will not alert and instead a separate warning signal will alert.

> [!NOTE]
> Since Teams will fall back to any available speaker or microphone when the configured device is unavailable, the Pro Portal filters out "non-viable" devices such as on-board headphone connectors and small speakers found inside some certified consoles. If those are found in-use, the Pro Portal should still fire this alert since they would not allow for a viable meeting experience.
> If the Microsoft Teams Rooms application is explicitly configured to use the speakers inside of a Front of Room display (HDMI audio), this alert will be locked in a healthy state. Another warning "Misconfigured Conferencing/Default Speaker" will alert you in this scenario. HDMI audio becomes disconnected when the display sleeps and would otherwise cause critical alerts to open and close throughout the day.
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

These signals are handled differently in the Teams Rooms Pro Management portal and the Microsoft Teams admin center.

**Microsoft Teams admin center**: The portal reports the signal as **Unhealthy** in the following situations:

- The Teams Rooms app has a specific audio peripheral configured in **Settings** and the peripheral is no longer available.
- There is no audio peripheral available.

**Teams Rooms Pro Management portal**: If the configured audio peripheral isn't available, the next available microphone or speaker is automatically selected. The portal reports the signal as **Unhealthy** if the following conditions are met:

- There is no viable (see above) speaker or mic currently in use.


