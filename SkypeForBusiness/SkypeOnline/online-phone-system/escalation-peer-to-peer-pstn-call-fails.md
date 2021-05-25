---
title: Escalation of peer to peer PSTN call fails
description: Describes an issue that triggers an An error occurred or  An error occurred while presenting when you try to escalate a conference call when you use Skype for Business Cloud Connector. Provides a workaround.
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
appliesto:
- Skype for Business Cloud Connector Edition
---

# Escalation of peer to peer PSTN call fails when you use Skype for Business Cloud Connector Edition

## Problem

Consider the following scenario. 

- Your Office 365 user account is configured to use Cloud PBX.   
- You have an active PSTN call through Skype for Business on Windows, where the voice for this call uses Skype for Business Cloud Connector Edition.   
- You try to escalate the call to a conference call by adding an additional participant to the call or by adding meeting content.   

In this scenario, the conference call fails, and the active call shows one of the following errors: 
- An error occurred   
- An error occurred while presenting   

## Workaround

To work around this issue, schedule or create an ad hoc Skype for Business Online Meeting, and invite the PSTN participants to the meeting. 

## More Information

This is a known issue in Skype for Business Cloud Connector Edition. Microsoft is working to resolve this issue. 

For more information, see the following Microsoft resources: 

- [Set up a Skype for Business meeting in Outlook](https://support.office.com/article/set-up-a-skype-for-business-meeting-in-outlook-b8305620-d16e-4667-989d-4a977aad6556)   
- [Start an impromptu Skype for Business meeting](https://support.office.com/article/start-an-impromptu-skype-for-business-meeting-0a31877f-f737-4b64-88ec-a2e1ddce2073)   


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).