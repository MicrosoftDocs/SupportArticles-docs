---
title: SIP 422 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 422 error, and provides actions to resolve the errors.
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
ms.reviewer: mikebis
---

# SIP response code 422

This article provides troubleshooting information for the combination of the SIP 422 error and Microsoft response code 540422.

## 540422 422 Session Interval Too Small

- Microsoft response code: **540422**
- SIP response code: **422**
- Suggested actions:  
  - Check the SBC configuration to make sure that the SBC re-invites as per the RFC to avoid call failures when the session interval is too small.  
  - If you see many calls with this call end reason or a sub-reason, consider increasing either both the Session Timer and Minimum Session Timer or one of them in the SBC configuration.
