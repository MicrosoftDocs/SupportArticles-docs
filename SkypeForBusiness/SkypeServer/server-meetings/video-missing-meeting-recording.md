---
title: Video is missing in a Skype for Business 2015 meeting recording
description: Discusses a problem in which the video track is missing from a Skype for Business 2015 meeting recording after the December 2015 security update 3114351 is installed.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business 2015
ms.date: 03/31/2022
---

# Video is missing in a Skype for Business 2015 meeting recording after the latest update is installed

## Symptoms

When you play back a meeting recording that you made in Microsoft Lync 2013 (Microsoft Skype for Business), the video track is missing although the audio track remains intact. Additionally, you receive the following message:

**At this point in the meeting, no one was presenting or sharing video.**

This issue occurs in certain situations after the latest update is installed. The recordings do not capture desktop sharing or application sharing. The recordings do capture PowerPoint presentations, white boards, and polling content.

However, no any failure or warning message about the missing video are displayed during the recording process.

## Resolution

To fix this issue, install the [January 12, 2016 update (KB3114502)](https://support.microsoft.com/help/3114502) for Lync 2013 (Skype for Business).

> [!NOTE]
> Lync 2013 was upgraded to Skype for Business in April 2015.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
