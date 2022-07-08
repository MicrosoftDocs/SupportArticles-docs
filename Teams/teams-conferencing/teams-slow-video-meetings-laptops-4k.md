---
title: Teams is slow during video meetings on laptops docked to 4K/UHD monitors
description: This article provides resolutions when Microsoft Teams is slow during video meetings on laptops docked to 4K/UHD monitors.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 107235
  - CSSTroubleshoot
ms.reviewer: SfB_Triage
appliesto: 
  - Microsoft Teams
ms.date: 3/31/2022
---

# Teams is slow during video meetings on laptops docked to 4K/UHD monitors

## Summary

Overall Microsoft Teams performance on laptops may be affected during meetings that use video. This issue can occur if a laptop is docked to an external 4K or ultra-high-definition (also known as ultra HD or UHD) display.

## Workaround

Reduce the resource requirements for your laptop to improve the Teams experience during the meeting and try:

- Close any applications or browser tabs that you aren't using.
- Turn off video in the meeting:
  - To turn off your own video, select **Turn camera off** in the meeting controls.
  - To turn off incoming video, select **More actions** > **Turn off incoming video** in the meeting controls.
- Disable GPU hardware acceleration in Teams. To disable this function, select the **Settings and more** menu next to your profile picture at the top right of Teams, and then select the **Disable GPU hardware acceleration** option.
- Disconnect your monitor from the port replicator or docking station, and directly connect it to the video port on the laptop, if available.
- Restart Teams.
- Change the resolution of your 4K or UHD monitor to 1920 x 1080. For more information, see [Change desktop icon size or screen resolution](https://support.microsoft.com/help/4026956).
- Use DVI or HDMI instead USB-C to connect your monitor, if possible.
- Disable full screen mode in the meeting by selecting **More actions** > **Full screen**.
- [Update Teams](https://support.microsoft.com/office/535a8e4b-45f0-4f6c-8b3d-91bca7a51db1) and [make sure that the latest update is installed](/microsoftteams/troubleshoot-installation#check-whether-teams-is-updated-successfully). The latest performance fixes were released in June 2021, which are available in version 1.4.00.16575 or later.

## Status

Microsoft is continuing to improve meeting experience by optimizing Audio, Video, and Screen sharing when using a 4K monitor. These updates will become available in upcoming client releases.
