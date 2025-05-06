---
title: SIP 412 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 412 error, and provides actions to resolve the errors.
ms.date: 10/30/2023
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Calling (PSTN)\Direct Routing
  - CI173631
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 412

This article provides troubleshooting information for the combination of the SIP 412 error and Microsoft response code 510412.

## 510412 412 Get Flighting - wrong callee MRI

- Microsoft response code: **510412**
- SIP response code: **412**
- Suggested actions:  
  - To fix the number parsing error, correct the malformed callee number in the inbound call. This will enable creating a correct Messaging Resource Identifier (MRI) that's required for further processing of the call.
