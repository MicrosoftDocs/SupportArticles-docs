---
title: Record videos in Outlook and Loop
description: Provides an overview of a new feature to record videos in Outlook email messages and Loop pages.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - Outlook for iOS and Android
  - CSSTroubleshoot
  - CI 185299
ms.reviewer: sbahrini, lusassl, meerak, v-trisshores
appliesto: 
  - Outlook on the web
  - New Outlook for Windows
  - Outlook for Android
  - Loop
search.appverid: MET150
ms.date: 02/13/2024
---

# Record videos in Outlook and Loop

Enterprise users can now [record videos](https://support.microsoft.com/office/how-to-create-stream-video-recordings-in-loop-f21e7422-fc05-417a-ae4d-3be19bbc2580) in Microsoft Outlook and [Microsoft Loop](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c). If a user records a video in an email message or a Loop page, the recording will transform into an [embedded](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop) video player.

> [!NOTE]
> This feature is being rolled out gradually and might not yet be available in your organization.

## Who can use the new feature

Only enterprise users can use the new feature.

If an enterprise user records a video in an email message, recipients within the organization can watch the video in the video player that's embedded in the message. External recipients will see a link instead of the embedded video player.

If an enterprise user records a video in a Loop page, users within the organization can watch the video in the embedded video player. Loop doesn't currently support guest or external user access to Loop pages.

## Limiting who can use the feature

By default, all enterprise users can use the new feature. However, as an admin, you have the following options to limit who can use the feature:

- To restrict usage to only some enterprise users, configure [Microsoft 365 Groups for Cloud Policy](/microsoft-365/loop/loop-components-configuration#microsoft-365-groups-for-cloud-policy).

  > [!NOTE]
  > You can't restrict video recording in Outlook for Android.

- To turn off the feature for all enterprise users, disable the following policy in the [Cloud Policy service for Microsoft 365](/deployoffice/admincenter/overview-cloud-policy): **Record a Stream video from within supported Microsoft 365 applications**.

  > [!NOTE]
  > When the policy is disabled, users won't be able to record videos in Loop or most Outlook versions. You can't disable video recording in Outlook for Android or [Microsoft Stream](https://support.microsoft.com/office/learn-more-about-stream-on-sharepoint-cf4c10c8-5ed3-4229-9e2a-60d31b31575d).

## Location of recorded videos

Outlook and Loop store recorded videos in the user folder in OneDrive for work or school. The folder path is **My files** \> **Recordings** \> **Video Clips**.

## Access to recorded videos

The default permissions policy for your work or school organization applies to videos that are recorded in Outlook or Loop. For more information about access permissions, see [Access to embedded videos](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop#access-permissions-for-embedded-videos).

## Duration of recorded videos

Videos that are recorded in Outlook or Loop have a maximum duration of five minutes. Users can record longer videos in Stream or [Microsoft Clipchamp](https://support.microsoft.com/topic/what-is-clipchamp-750e8940-cd76-4abf-9767-b34d3d3285d7).

Users can embed an unlimited number of recorded videos in a Loop page or an email message in Outlook for Android.

Other versions of Outlook use Loop components to embed recorded videos in email messages. The existing limit of five Loop components per email message applies. Recorded videos that are added after the fifth video in an email message won't transform into embedded video players.

## Deleting a video recording

If a user records a video in an email message or Loop page, but later removes the embedded player from the message or page, the source video file isn't deleted. To delete the recording, the user should delete the source video file.

## Email message size

When a user records a video in an email message, the video file is automatically saved to the user's OneDrive folder and doesn't affect the size of the email message. Embedded video players link to video files and don't create copies of the files or add them as email attachments.

## Send feedback

To report issues or provide feedback about the new feature, select the applicable option for your product:

- In Outlook versions except Outlook for Android, select **Feedback** from the **Help** menu.

- In Outlook for Android, see [Get in-app help for Outlook for iOS and Android](https://support.microsoft.com/office/get-in-app-help-for-outlook-for-ios-and-android-218a22d1-9fa5-4889-b689-de1c63493243).

- In Loop, see [Want to give feedback?](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c#ID0EDR)

## More information

For information about how you can insert video links that transform into embedded video players, see [Embed and play back videos in Outlook and Loop](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop).
