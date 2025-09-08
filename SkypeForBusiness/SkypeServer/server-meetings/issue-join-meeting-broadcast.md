---
title: An error occurred during the Skype Meeting when join a Skype Meeting Broadcast
description: Describes an issue that triggers an error occurred during the Skype Meeting error when you try to join a Skype Meeting Broadcast event as an event team member. A resolution is provided.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
appliesto: 
  - Skype for Business Online
  - Skype for Business Server 2015
ms.date: 03/31/2022
---

# "An error occurred during the Skype Meeting" when you try to join a Skype Meeting Broadcast as an event team member

## Symptoms

When you try to join a Skype Meeting Broadcast event as an event team member, the client opens, and the Skype for Business client tries to join the meeting. However, the client receives the following error message: 

**An error occurred during the Skype Meeting**

When you use the Snooper tool to analyze the logs, this shows the client trying to join the meeting and responses of "SIP/2.0 403 Forbidden" and "ms-diagnostics error code of 1002." The stated reason for these errors is "From URI not authorized to communicate with federated partners."

## Cause

Skype Meeting Broadcast uses regional dedicated conferencing pools. In order to join Skype Meeting Broadcast meetings, event team members must be validated against the Microsoft 365 tenant or the on-premises Skype for Business Server infrastructure. If the tenant or on-premises infrastructure restricts access to a list of authorized domains, the validation process fails, and you can't join the inner meeting.

## Resolution

To fix this issue, see the following articles to configure your environment for Skype Meeting Broadcast:

- If you have a Microsoft 365 tenant and no on-premises infrastructure, see [Set up Skype for Business Online for Skype Meeting Broadcast](https://support.office.com/article/set-up-skype-for-business-online-for-skype-meeting-broadcast-dfa736b9-4920-4f48-b8c0-b5487ec6086f).   
- For hybrid customers, follow the appropriate steps in [Configure your on-premises deployment for Skype Meeting Broadcast](/skypeforbusiness/deploy/configure-skype-meeting-broadcast).   

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
