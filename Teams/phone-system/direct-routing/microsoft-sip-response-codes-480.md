---
title: SIP 480 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 480 error, and provides actions to resolve the errors.
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - CI173631
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 480

This article provides troubleshooting information for various combinations of the SIP 480 error and Microsoft response codes.

## 10037 480 No callee endpoints were found

- Microsoft response code: **10037**
- SIP response code: **480**
- Suggested actions:  
  - If the callee is a Teams user who hasn't logged in for a long time, this behavior is expected.
  - If the callee is currently logged in to the Teams client, ask the callee to log out and log in again. If the issue persists, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10140 480 Call to bot is rejected due to null user settings or user app settings

- Microsoft response code: **10140**
- SIP response code: **480**
- Suggested actions:  
  - Verify that you have correctly provisioned the bot that you're trying to call. If the bot is correctly provisioned, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10191 480 Routing to voicemail is disabled in policy

- Microsoft response code: **10191**
- SIP response code: **480**
- Suggested actions:  
  - In the calling policy that's assigned to the affected user, check the [Voicemail is available for routing inbound calls](/MicrosoftTeams/teams-calling-policy#voicemail-is-available-for-routing-inbound-calls) setting. If the setting is set to **Not enabled**, set it to **Enabled** or **User controlled**.
