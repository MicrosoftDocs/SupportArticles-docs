---
title: SIP 412 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 412 error, and provides actions that you can take to resolve the error codes.
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

# SIP response code 412

This article lists combinations of SIP 412 and Microsoft response codes, the corresponding error messages, and actions that you can take.

## 510412 412 Get Flighting - wrong callee MRI

- Microsoft response code: **510412**
- SIP response code: **412**
- Error message: **Get Flighting - wrong callee MRI**
- Suggested actions:  
  Correct the malformed callee number in the inbound call to fix the number parsing error. This will enable the creation of a correct Messaging Resource Identifier (MRI) that's required for further processing of the call.
