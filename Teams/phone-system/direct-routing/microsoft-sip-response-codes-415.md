---
title: SIP 415 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 415 error, and provides actions to resolve the errors.
ms.date: 08/18/2025
author: Cloud-Writer
ms.author: meerak
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
  - CI 6328
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 415

This article provides troubleshooting information for the combination of the SIP 415 error and Microsoft response code 510415.

## 540415 415 Unsupported Media Type

- Microsoft response code: **540415**
- SIP response code: **415**
- Suggested actions:  
  - This error indicates that either the SBC offer is missing or it contains an unsupported media type. For example, the CONTENT-TYPE might be missing or the SBC offer has unsupported data such as information about the application, or pidf+xml. Check the SBC configuration to fix the problem.
