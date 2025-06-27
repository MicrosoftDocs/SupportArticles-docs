---
title: SIP 400 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 400 error, and provides actions to resolve the errors.
ms.date: 11/22/2024
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
  - CI2385
  - CSSTroubleshoot
ms.reviewer: mikebis
---

# SIP response code 400

This article provides troubleshooting information for the combination of the SIP 400 error and Microsoft response code 540400.

## 540400 400 Bad Request

- Microsoft response code: **540400**
- SIP response code: **400**
- Suggested actions:  
  - Check the SBC configuration to determine why it sends an invalid or unsupported SIP message format to Microsoft and fix any misconfiguration.
