---
title: Teams is slow during video meetings on laptops docked to 4K/UHD monitors
description: This article provides resolutions when Microsoft Teams is slow during video meetings on laptops docked to 4K/UHD monitors.
author: helenclu
ms.author: sgorantl
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 107235
- CSSTroubleshoot
ms.reviewer: SfB_Triage
appliesto:
- Microsoft Teams
---

# Teams is slow during video meetings on laptops docked to 4K/UHD monitors

## Summary

Overall Teams performance on laptops may be affected during meetings that use video. This can occur if a laptop is docked to an external 4K or ultra-high-definition (also known as ultra HD or UHD) display.

## Workaround

Reduce the resource requirements for your laptop to improve the Teams experience during the meeting. To do this, try one or more of the following: 

- Please “Check for updates” to make sure you’re on the latest version of Teams. If an update is available, please update the client, then restart Teams. For more information on Teams client updates, please visit: [Check whether Teams is updated successfully](https://docs.microsoft.com/en-us/microsoftteams/troubleshoot-installation#check-whether-teams-is-updated-successfully). The latest performance fixes were released in June 2021, and are available in version 1.4.00.16575 or greater (under **About > Version**)
- Restart your Teams client. To do this, right click the Teams icon in the taskbar and select "Quit".
- Close any applications or browser tabs that you aren't using
- Turn off video in the meeting. You can turn off your own video by selecting **Turn camera off** in the meeting controls. To turn off incoming video, select **More actions** > **Turn off incoming video** in the meeting controls.
- Uncheck the “Disable GPU acceleration” setting. To do this, look under **Settings > General > Application**. If the setting is checked, uncheck it and restart the Teams application. 
- Disconnect your monitor from the port replicator or docking station, and directly connect it to the video port on the laptop, if available. 
- Change the resolution of your 4K or UHD monitor to 1920 x 1080. Instructions for doing this on Windows are located at [Change desktop icon size or screen resolution](https://support.microsoft.com/help/4026956/windows-10-change-screen-resolution).
- When connecting to external monitors, use DVI/HDMI, instead of USB-C, when possible.  
- Avoid running Teams with the window maximized on the external 4k monitor. Instead, run Teams in “window mode” (non-maximized mode) 
- Restart your laptop.

## Resolution

Microsoft is continuing to improve the experience when using video in a meeting, while screen sharing, and when using a 4K monitor. These fixes will become available in upcoming client releases. 
