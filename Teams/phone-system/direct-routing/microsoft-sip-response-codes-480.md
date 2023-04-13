---
title: SIP 480 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 480 error, and provides actions that you can take to resolve the error codes.
ms.date: 3/27/2023
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

This article lists combinations of SIP 480 and Microsoft response codes, the corresponding error messages, and actions that you can take.

## 10037 480 No callee endpoints were found

- Microsoft response code: **10037**
- SIP response code: **480**
- Error message: **No callee endpoints were found**
- Suggested actions:  
  - If the callee is a Teams user who hasn't logged in for a long time, this behavior is expected.
  - If the callee is currently logged into the Teams client, ask the callee to log out and log in again. If the issue persists, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10140 480 Call to bot is rejected due to null user settings or user app settings

- Microsoft response code: **10140**
- SIP response code: **480**
- Error message: **Call to bot is rejected due to null user settings or user app settings**
- Suggested actions:  
  Verify that you have correctly provisioned the bot you're trying to call. If the bot is correctly provisioned, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10191 480 Routing to voicemail is disabled in policy

- Microsoft response code: **10191**
- SIP response code: **480**
- Error message: **Routing to voicemail is disabled in policy**
- Suggested actions:  
  In the calling policy that's assigned to the affected user, check the [Voicemail is available for routing inbound calls](/MicrosoftTeams/teams-calling-policy#voicemail-is-available-for-routing-inbound-calls) setting. If the setting is set to **Not enabled**, set it to **Enabled** or **User controlled**.
