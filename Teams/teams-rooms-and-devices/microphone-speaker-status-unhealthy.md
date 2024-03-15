---
title: The microphone or speaker status of a Teams Rooms device is unhealthy
description: Fixes the issue that causes the microphone or speaker signal of a Microsoft Teams Rooms device to appear as Unhealthy.
ms.reviewer: lamos
ms.topic: troubleshooting
ms.date: 10/30/2023
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
ms.custom: 
  - CI167310
---

# The microphone or speaker status is Unhealthy

## Symptoms

In the [Microsoft Teams Rooms Pro Management portal](https://portal.rooms.microsoft.com/), one or more of the following signals of a Microsoft Teams Rooms device are shown as **Unhealthy**:

- Conferencing Microphone
- Conferencing Speaker
- Configured Default Speaker
- Configured Conferencing Microphone
- Configured Conferencing Speaker

Users experience one or more of the following issues:

- Remote participants can't hear in-room participants.
- In-room participants can't hear remote participants.
- In-room participants can't hear the ringtone for incoming calls.
- Audio from an HDMI ingest source, such as a laptop, can't be heard from room speakers.

## Cause

The **Conferencing Speaker** and **Conferencing Microphone** signals send an alert if Teams Rooms reports that no speaker or microphone peripherals are available and in use. If the configured default device isn't available, but another viable device is in use, an alert isn't sent. However, in this case, a separate warning alert is sent.  

> [!NOTE]
> 
> - Because Teams falls back to any available speakers or microphones if the configured device isn't available, Teams Rooms Pro filters out non-viable devices, such as onboard headphone connectors and small speakers that are found inside some certified consoles. If the non-viable devices are found to be in use, these signals will still send an alert because the devices can't provide a viable conferencing experience.
> - If the Teams Rooms app is explicitly configured to use the speakers in a Front of Room display (HDMI audio), the **Conferencing Speaker** signal will remain **Healthy**. In this case, the **Conference misconfiguration/default speaker** signal sends an alert. HDMI audio is disconnected when the display sleeps. Otherwise, it would cause critical alerts to be turned on and off throughout the day.
    
The **Configured Default Speaker**, **Configured Conferencing Microphone**, and **Configured Conferencing Speaker** signals send an alert if Teams Rooms reports that the configured default device isn't available, but another viable device is in use.
 
## Resolution

Audio peripheral issues can occur for different reasons. To fix common issues, try the following methods.

### Make sure the power supply is connected

Most audio peripherals require external power beyond what's available through the USB bus. In this situation, make sure that the power supply is connected and the peripheral is turned on.

### Check the USB cable connection

Issues can occur if the USB cable is unplugged, faulty, or inconsistent. In this situation, reseat the cable at both ends. If the issue persists, try to replace the cable.

### Check firmware issues

Try the following methods:

- If the peripheral was updated recently, the firmware update might not be completed. In this situation, the device is in an unusable state. Try to reset the power for the device. Some devices might have a reset button.
- Contact your peripheral manufacturer to verify that the device is running the latest version of firmware. Or, work with the manufacturer to fix any known issues.

### Check issues in USB extenders

If possible, avoid using USB extenders for audio and video equipment. If you must use a USB extender, use one that's supported by the peripheral device and meets the device requirements, such as length and USB specification. For more information, contact your peripheral manufacturer.

## More information

These signals are handled differently in the Microsoft Teams admin center and the Teams Rooms Pro Management portal.

**Microsoft Teams admin center**: The portal reports the signal as **Unhealthy** in the following situations:

- The Teams Rooms app has a specific audio peripheral configured in **Settings** and the peripheral is no longer available.
- There is no audio peripheral available.

**Teams Rooms Pro Management portal**: If the configured audio peripheral isn't available, the next available microphone or speaker is automatically selected. The portal reports the signal as **Unhealthy** if no speaker or microphone is available.
