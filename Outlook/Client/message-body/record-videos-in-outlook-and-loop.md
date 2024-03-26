---
title: Record videos in Loop
description: Provides an overview of a new feature to record videos in Loop pages.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 185299
ms.reviewer: sbahrini, ommehen, lusassl, meerak, v-trisshores
appliesto: 
  - Loop
search.appverid: MET150
ms.date: 03/26/2024
---

# Record videos in Loop

Enterprise users can now record videos in [Microsoft Loop](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c). If a user records a video in a Loop page, the recording will transform into an [embedded video player](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop).

> [!NOTE]
> This feature is being rolled out gradually and might not yet be available in your organization.

## Who can use the new feature

Only enterprise users can use the new feature.

If an enterprise user records a video in a Loop page, users within the organization can watch the video in the embedded video player. Loop doesn't currently support guest or external user access to Loop pages.

## Limiting who can use the feature

By default, all enterprise users can use the new feature. However, as an admin, you have the following options to limit who can use the feature:

- To restrict usage to only some enterprise users, configure [Microsoft 365 Groups for Cloud Policy](/microsoft-365/loop/loop-components-configuration#microsoft-365-groups-for-cloud-policy).

- To turn off the feature for all enterprise users, disable the following policy in the [Cloud Policy service for Microsoft 365](/deployoffice/admincenter/overview-cloud-policy): **Record a Stream video from within supported Microsoft 365 applications**.

  > [!NOTE]
  > When the policy is disabled, users won't be able to record videos in Loop. You can't disable video recording in [Microsoft Stream](https://support.microsoft.com/office/learn-more-about-stream-on-sharepoint-cf4c10c8-5ed3-4229-9e2a-60d31b31575d).

## Location of recorded videos

Loop stores recorded videos in the user folder in OneDrive for work or school. The folder path is **My files** \> **Recordings** \> **Video Clips**.

## Access to recorded videos

The default permissions policy for your work or school organization applies to videos that are recorded in Loop. For more information about access permissions, see [Access to embedded videos](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop#access-to-embedded-videos).

## Duration of recorded videos

Videos that are recorded in Loop have a maximum duration of five minutes. Users can record longer videos in Stream or [Microsoft Clipchamp](https://support.microsoft.com/topic/what-is-clipchamp-750e8940-cd76-4abf-9767-b34d3d3285d7).

Users can embed an unlimited number of recorded videos in a Loop page.

## Deleting a video recording

If a user records a video in a Loop page, but later removes the embedded player from the page, the source video file isn't deleted. To delete the recording, the user should delete the source video file.

## Send feedback

To report issues or provide feedback about the new feature, see [Want to give feedback?](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c#ID0EDR)

## More information

For information about how you can insert video links that transform into embedded video players, see [Embed and play back videos in Outlook and Loop](/outlook/troubleshoot/message-body/embed-playback-videos-in-outlook-and-loop).
