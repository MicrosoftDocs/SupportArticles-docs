---
title: SIP 486 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 486 error, and provides actions that you can take to resolve the error codes.
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

# SIP response code 486

This article provides troubleshooting information for various combinations of SIP 486 and Microsoft response codes.

## 10321 486 Bot rejects the incoming call because it is busy

- Microsoft response code: **10321**
- SIP response code: **486**
- Suggested actions:  
  The impact of this error depends on the specific bot and the expectations for the given scenario. If this error is unexpected:

  - If the bot is provided by Microsoft, such as the built-in call recording, [contact Microsoft Support](https://support.microsoft.com/contactus).
  - If the bot is your own bot or from a third-party provider, work with the bot provider to verify that the bot is set up correctly.
