---
title: Fix choppy video in Teams
description: Resolves an issue in which the display for attendees lags and is choppy when you share a video or other content during a Teams call.
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
ms.date: 7/21/2023
---
# Fix choppy video in Teams

## Symptoms

During a Microsoft Teams call, when you share a video or other content that needs a higher frame rate for optimal viewing, the display for the other attendees lags and is choppy.

## Cause

Teams isn't detecting motion quickly.

The frame rate for screen sharing in Teams is set to the low motion option by default because the content commonly shared, such as an Excel worksheet or Word document, is static. The low setting ensures the highest possible resolution of the shared content.

Teams can detect when higher motion content such as a full-screen video is shared and automatically increase the frame rate. However, there are situations when that doesn't happen.

## Resolution

In Teams versions 1.6.00.12455 or higher, you can use a keyboard shortcut to enable high motion screen sharing. Use the following steps:

1. Start sharing your screen in Teams.

1. Select the Teams app, and then select <kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>SHIFT</kbd>+<kbd>T</kbd>.

> [!NOTE]
> The resolution of the shared content might drop to accommodate the higher frame rate depending on several factors that include machine capability and available bandwidth.

## More information

After you execute the keyboard shortcut, there's no visual indication that high motion has been enabled for you.

If you want to check the frame rate for the content being shared, use the following steps:

1. In the Teams meeting, select the **More** menu option.

1. In the drop-down menu, select **Settings**, and then select **Call health**.

1. Scroll to the **Screen Sharing** section to see the frame rate, resolution and other details about the screen sharing session.
