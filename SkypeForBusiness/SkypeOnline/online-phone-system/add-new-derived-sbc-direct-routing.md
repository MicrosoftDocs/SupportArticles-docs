---
title: Can't add a new derived SBC for Direct Routing
description: Provides a resolution to an issue in which you are not able to add a new derived SBC for Direct Routing.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 122287
ms.author: v-six
ms.reviewer: scapero
appliesto: 
  - Skype for Business Online
ms.date: 3/31/2022
---

# Error when adding a new derived SBC for Direct Routing: Cannot find specified Gateway 

## Symptoms

When adding a new derived Session Border Controller (SBC) for Direct Routing using New-CSOnlineVoiceRoute cmdlet, you receive this error message:

> "Cannot find specified Gateway" 

## Cause

New domains must have at least one user enabled for Enterprise Voice to create a voice route for a derived SBC.

## Resolution

Enable at least one user for Enterprise Voice in the newly verified domain. See the detailed steps [here](/microsoftteams/direct-routing-enable-users#configure-the-phone-number-and-enable-enterprise-voice-and-voicemail).