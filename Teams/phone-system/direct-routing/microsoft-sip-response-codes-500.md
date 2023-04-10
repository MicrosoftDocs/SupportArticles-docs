---
title: Microsoft and SIP response codes
description: A combination of Microsoft and SIP response codes can help identify the cause of call failures and provide detailed descriptions of errors and actions that you can take.
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
ms.custom: CI166247,CSSTroubleshoot
ms.reviewer: rishire
---

# Microsoft and SIP response codes

This article lists combinations of Microsoft and SIP response codes, the corresponding error messages, and actions that you can take.

## 510482 500 Loop detected

- Microsoft response code: **510482**
- SIP response code: **500**
- Error message: **Loop detected**
- Suggested actions:  
  Make sure that there is no infinite call forwarding.

## 510544 500 Get Outbound Direct routing - no trunk config found

- Microsoft response code: **510544**
- SIP response code: **500**
- Error message: **Get Outbound Direct routing - no trunk config found**
- Suggested actions:  
  Verify the trunk (gateway) configuration for the specific tenant and ensure that it's set up correctly. For more information about call routing configuration, see [Configure call routing for Direct Routing](/microsoftteams/direct-routing-voice-routing).

## 510544 500 Get Outbound routing - failed getting direct routing gateways for emergency user

- Microsoft response code: **510544**
- SIP response code: **500**
- Error message: **Get Outbound routing - failed getting direct routing gateways for emergency user**
- Suggested actions:  
  Review your [emergency call routing policies](/microsoftteams/manage-emergency-call-routing-policies) and fix any misconfiguration.

## 10320 503 Bot is unreachable or unable to answer before timeout

- Microsoft response code: 10320
- SIP response code: 503
- Error message: **Bot is unreachable or unable to answer before timeout**
- Suggested actions:  
  - If the bot is provided by Microsoft, such as the built-in call recording, [contact Microsoft Support](https://support.microsoft.com/contactus).
  - If the bot is your own bot or from a third-party provider, work with the bot provider to verify that the bot is set up correctly.
