---
title: Embed and play back videos in Outlook and Loop
description: Provides an administrator overview of a new feature to embed and play back videos in Outlook email messages and Loop pages.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - Outlook for iOS and Android
  - CSSTroubleshoot
  - CI 185226
ms.reviewer: sbahrini, lusassl, meerak, v-trisshores
appliesto: 
  - Outlook on the web
  - New Outlook for Windows
  - Outlook for Android
  - Outlook for iOS
  - Loop
search.appverid: MET150
ms.date: 02/06/2024
---

# Embed and play back videos in Outlook and Loop

Enterprise users can now [embed videos](https://support.microsoft.com/office/how-to-insert-stream-videos-in-loop-1b123f5e-2607-4b17-a44a-c62cff6a728b) in Microsoft Outlook and Microsoft [Loop](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c). If a user inserts a video link into an email message or a Loop page, the link will transform into an embedded video player. Message recipients can watch the video within the embedded video player without leaving Outlook. Users who have access to the Loop page can watch the video within the embedded video player without leaving Loop.

> [!NOTE]
>
> - [Loop components](/microsoft-365/loop/loop-components-teams) are used by the desktop versions of Outlook and Outlook on the web to embed videos in email messages.
> - This feature is being rolled out gradually and might not yet be available in your organization.

## Who can use the new feature

Only enterprise users can use the new feature.

If an enterprise user embeds a video in an email message, recipients within the organization can watch the video in the video player that's embedded in the message. External recipients will see a link instead of the embedded video player.

If an enterprise user embeds a video in a Loop page, users within the organization can watch the video in the embedded video player. Loop doesn't currently support guest or external user access to Loop pages.

## Limiting who can use the feature

By default, all enterprise users can use the new feature. However, as an admin, you have the following options to limit who can use the feature:

- To restrict usage to only some enterprise users, configure [Microsoft 365 Groups for Cloud Policy](/microsoft-365/loop/loop-components-configuration#microsoft-365-groups-for-cloud-policy).

- To turn off the feature for all enterprise users, disable the following policy in the [Cloud Policy service for Microsoft 365](/deployoffice/admincenter/overview-cloud-policy): **Preview and playback a Stream video from within supported Microsoft 365 applications**.

> [!NOTE]
> When the policy is disabled, users won't be able to embed or play back videos in Outlook or Loop. The policy doesn't affect video playback in Microsoft Stream.

## Supported video files

The feature supports video files in Microsoft Stream, OneDrive for work or school, and SharePoint. Users can't embed videos from local storage without first uploading the videos to one of the supported locations.

There's no limit to the number of embedded videos that users can add to an email message in mobile versions of Outlook (Outlook for Android and Outlook for iOS) or to a Loop page.

Non-mobile versions of Outlook use Loop components to embed videos in email messages. The existing limit of five Loop components per email message applies. Video links that are added after the fifth video in an email message won't transform into embedded video players.

## Access permissions for embedded videos

The default permissions policy for your work or school organization applies to videos regardless of whether they're embedded.

To make sure that Outlook and Loop users can access an embedded video, email authors or Loop page creators can set access permissions directly on the source video file in Stream, OneDrive for work or school, or SharePoint.

Alternatively, email authors who use non-mobile versions of Outlook can set permissions in the email message by following these steps:

1. In the email message, select the video filename link at the top of the embedded video to open a context menu.

2. In the context menu, select **Manage access** to view the share settings for the video file. Adjust the share settings to grant access to email recipients. Updated share settings are saved on the video file.

Video file permissions remain in effect regardless of how many times an email message that has embedded video is forwarded.

If a user tries to send an email message that has an embedded video to a recipient who doesn't have permission to access the video, Outlook prompts the sender to manage access before sending the message. Recipients who don't have permission to access an embedded video will see an option in the message to request access.

When a user creates a video link in Stream, OneDrive for work or school, or SharePoint, and then adds the link to an email message or Loop page, the link share settings determine who can watch the video.

If the owner of an embedded video file later moves, deletes, or stops sharing the source video file, users who previously had access are informed that the item is no longer available.

## Embedded video appearance

By default, a video link in an email message or Loop page automatically transforms into an embedded video player.

Users of non-mobile versions of Outlook can configure how a video link appears in email messages that they compose. For example, email authors can revert any embedded video player to a video link. For more information, see "How can I change the appearance of the embedded video player to a link and vice versa?" in the "FAQ" section of [How to insert Stream videos in Loop and Outlook](https://support.microsoft.com/office/how-to-insert-stream-videos-in-loop-and-outlook-1b123f5e-2607-4b17-a44a-c62cff6a728b#ID0EFF).

## Email message size

Regardless of whether a user embeds a video in an email message or adds a video link, the video file remains in its original location and doesn't affect the size of the email message. Embedded video players link to video files and don't create copies of the files or add them as email attachments.

## Send feedback

To report issues or provide feedback about the new feature, select the applicable option for your product:

- In non-mobile versions of Outlook, select **Feedback** from the **Help** menu.
- In mobile versions of Outlook, see [Get in-app help for Outlook for iOS and Android](https://support.microsoft.com/office/get-in-app-help-for-outlook-for-ios-and-android-218a22d1-9fa5-4889-b689-de1c63493243).
- In Loop, see [Want to give feedback?](https://support.microsoft.com/office/get-started-with-microsoft-loop-9f4d8d4f-dfc6-4518-9ef6-069408c21f0c#ID0EDR)
