---
title: Fix video display lag issue in Teams
description: Resolves an issue in which the video display for attendees is of poor quality when sharing video during a Teams call.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 178527
  - CSSTroubleshoot
ms.reviewer: randyto, scapero
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Fix video display lag issue in Teams

## Symptoms

During a call in Microsoft Teams, when you share a video or other content that needs a higher frame rate for optimal viewing, the display for the other attendees appears to lag and frames are intermittently dropped.

## Cause

Teams isn't detecting motion quickly enough.

By default, the frame rate for screen sharing in Teams is set to the low motion option. This is because commonly shared content, such as an Excel worksheet or Word document, is static. The low motion setting ensures that attendees see the highest possible resolution of the shared content.

Typically, Teams detects when higher motion content, such as a full-screen video, is shared, and it automatically increases the frame rate. However, there are situations in which this doesn't occur.

## Resolution

In Teams 1.6.00.12455 and later versions, you can use a keyboard shortcut to enable high motion screen sharing. Follow these steps:

1. Start sharing your screen in Teams.

1. Select the Teams app, and then select **Ctrl+Alt+Shift+T**.

**Note**: The resolution of the shared content might drop to accommodate the higher frame rate depending on several factors, such as device capability and available bandwidth.

## More information

After you run the keyboard shortcut, there's no visual indication that high motion viewing is enabled for you. The keyboard shortcut is a toggle. If you use it twice, the Teams app will return to the default behavior of not forcing high motion screen sharing.

To check the frame rate for the content that's shared, follow these steps:

1. In the Teams meeting, select the **More** menu option.

1. On the **More** menu, select **Settings**, and then select **Call health**.

1. To see the frame rate, resolution, and other details about the screen sharing session, scroll to the **Screen Sharing** section.
