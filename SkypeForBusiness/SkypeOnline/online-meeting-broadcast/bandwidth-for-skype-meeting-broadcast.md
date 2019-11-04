---
title: Bandwidth requirements for Skype Meeting Broadcast
description: Contains information about the bandwidth requirements for Skype Meeting Broadcast.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: jasco, landerl, corbinm, dougl
appliesto:
- Skype for Business Online
---

# Bandwidth requirements for Skype Meeting Broadcast

## Introduction

This article contains information about the bandwidth requirements for Skype Meeting Broadcast.

## More Information

The bandwidth requirements for the Skype Meeting Broadcast producer are the same as those for a regular Skype for Business meeting and depend on the number of participants in the inner meeting (that is, the meeting that the event team members join for a Skype Meeting Broadcast) and the presentation options that are used. 

The producer and presenters are connecting to a meeting that is hosted in the Skype for Business Online infrastructure. Therefore, they're moving out of the internal network and crossing into the public Internet. Be aware that any on-premises pools aren't used.

Viewers of the broadcast will connect to the geographically closest Azure Content Delivery Network location to stream the broadcast. Be aware that if all users are attending from the same location, you'll see a unique stream to the Internet for each user. 

Skype Meeting Broadcast automatically adjusts the resolution based on available client bandwidth. Broadcast viewers use their desktop or mobile browsers. Their devices will use one of the following resolutions.

|Resolution|Maximum bandwidth|
|----|---|
|720p|1.7 Mbps (megabits per second)|
|540p|850 Kbps (kilobits per second)|
|360p|500 Kbps|

> [!NOTE]
> This is the maximum amount of bandwidth that can be consumed. The amount of bandwidth that Skype Meeting Broadcast consumes is directly related to the type of media (for example, PPT, audio, video) that is being used and how frequently the page loads. For example, a PowerPoint presentation that is just being displayed and for which slides aren't being advanced consumes far less bandwidth than a video in which the presenter is moving and the background is constantly changing.
