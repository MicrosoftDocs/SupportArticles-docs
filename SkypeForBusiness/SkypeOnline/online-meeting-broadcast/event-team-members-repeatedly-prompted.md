---
title: Event Team members are repeatedly prompted for password 
description: Discusses an issue that blocks a user who's enabled for Modern Authentication from joining a Skype Meeting Broadcast. A workaround is provided.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
ms.reviewer: landerl, jasco, corbinm,kristinw, kristinw, dougl, lynnroe, cbland, rischwen, leonarwo, msp
appliesto:
- Skype for Business Online
---

# Event Team members are repeatedly prompted for a password when they try to join a Skype Meeting Broadcast

## Problem

Consider the following scenario. 

- You're enabled for Modern Authentication in Office 365.   
- You try to join a Skype Meeting Broadcast as an **Event Team** member.    

In this situation, you're repeatedly prompted for your Office 365 password. This behavior occurs after you've joined the **Event Team** meeting and while the producer controls are being loaded. For example, this occurs when a PowerPoint presentation is uploaded or when a video feed is started. 

## Solution

To work around this issue, use an account that isn't configured for Modern Authentication as a member of the Skype Meeting Broadcast **Event Team**, and then use the producer controls. 

## More Information

Currently, the producer controls aren't supported when you're configured for Modern Authentication. 

For more information about Skype Meeting Broadcast, go to the following Microsoft websites: 

- [What is a Skype Meeting Broadcast?](https://support.office.com/article/what-is-a-skype-meeting-broadcast-c472c76b-21f1-4e4b-ab58-329a6c33757d)   
- [Join a Skype Meeting Broadcast](https://support.office.com/article/join-a-skype-meeting-broadcast-14689da0-821d-48d4-9035-ea762de80ebe)   

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).