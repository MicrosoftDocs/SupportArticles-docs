---
title: Fix screen sharing video display lag issue in Teams
description: Resolves an issue in which the video display for attendees is of poor quality when screen sharing video during a Teams call.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Meetings\Meetings Other
  - CI 178527
  - CSSTroubleshoot
ms.reviewer: randyto, scapero
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 07/08/2024
---
# Fix screen sharing video display lag issue in Teams

## Symptoms

During a call in Microsoft Teams, when you share a video or other content that requires a higher frame rate for optimal viewing, the display for the other attendees appears to lag and frames are intermittently dropped.

## Cause

By default, the frame rate for screen sharing in Teams is set to a low frame rate. This is because commonly shared content, such as an Excel workbook or Word document, is static. The low frame rate makes sure that attendees see the highest possible resolution of the shared content.

However, the default setting can be problematic when a user shares a video. The video may appear to lag because of the low frame rate.

## Resolution

In Teams 1.6.00.12455 and later versions, you can use a keyboard shortcut to enable high-motion screen sharing. Follow these steps:

1. Start sharing your screen in Teams.

1. Select the Teams app, and then select **Ctrl+Alt+Shift+T**.

The resolution of the shared content might drop to accommodate the higher frame rate. This depends on several factors, such as device capability and available bandwidth.

> [!NOTE]
> The keyboard shortcut will be deprecated soon. There is a new presenter control toolbar that enables a user to optimize for video when screen sharing. For more information, see [Share content in Microsoft Teams meetings](https://support.microsoft.com/office/share-content-in-microsoft-teams-meetings-fcc2bf59-aecd-4481-8f99-ce55dd836ce8).

## More information

After you run the keyboard shortcut, you won't see any visual indication that high-motion viewing is enabled for you. The keyboard shortcut is a toggle. If you use it two times, the Teams app will return to the default behavior of not forcing high-motion screen sharing.

To check the frame rate for the content that's shared, follow these steps:

1. In the Teams meeting, select the **More** menu option.

1. On the **More** menu, select **Settings**, and then select **Call health**.

1. To see the frame rate, resolution, and other details about the screen-sharing session, scroll to the **Screen Sharing** section.
