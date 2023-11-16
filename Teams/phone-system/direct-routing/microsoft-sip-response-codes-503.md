---
title: SIP 503 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 503 error, and provides actions to resolve the errors.
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

# SIP response code 503

This article provides troubleshooting information for various combinations of the SIP 503 error and Microsoft response codes.

## 10320 503 Bot is unreachable or unable to answer before timeout

- Microsoft response code: 10320
- SIP response code: 503
- Suggested actions:  
  - If the bot is provided by Microsoft, such as the built-in call recording, [contact Microsoft Support](https://support.microsoft.com/contactus).
  - If the bot is your own bot or from a third-party provider, work with the bot provider to verify that the bot is set up correctly.

## 560503 503 Service unavailable. SBC undergoing maintenance or temporarily overloaded

- Microsoft response code: **560503**
- SIP response code: **503**
- Suggested actions:  
  - Check the logs on the SBC to investigate why it returns the "503" SIP response.
  - Make sure that the SBC is correctly licensed to handle the number of concurrent sessions.
  - Determine whether the "503" error is related to a specific destination country/region or calling corridor.
