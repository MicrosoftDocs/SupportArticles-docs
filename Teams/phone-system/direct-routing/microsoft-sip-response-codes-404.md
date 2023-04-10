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

## 10202 404 Replacement call was not found

- Microsoft response code: **10202**
- SIP response code: **404**
- Error message: **Replacement call was not found**
- Suggested actions:  
  Check whether your SBC is configured to try a replacement call after an initial failure. (Lu: It's not very clear what the user should check in the worksheet, is this understanding correct?)

## 511404 404 Getting user info by number from RuntimeAPI failed

- Microsoft response code: **511404**
- SIP response code: **404**
- Error message: **Getting user info by number from RuntimeAPI failed**
- Suggested actions:  
  This error indicates that the user can't be found during the reverse number lookup. To fix the error, make sure that the callee number format of your Session Border Controller (SBC) and/or PSTN trunk provider matches the format that's assigned to the user or resource account. Usually, Microsoft expects calls to be in E.164 normalized format, including country code, network destination code and subscriber number. For more information about the format and example, see [Direct Routing - SIP protocol](/microsoftteams/direct-routing-protocols-sip).
