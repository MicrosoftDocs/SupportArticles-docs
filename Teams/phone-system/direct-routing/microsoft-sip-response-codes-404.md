---
title: SIP 404 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 404 error, and provides actions to resolve the errors.
ms.date: 10/30/2023
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
  - CI173631
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 404

This article provides troubleshooting information for various combinations of the SIP 404 error and Microsoft response codes.

## 10202 404 Replacement call was not found

- Microsoft response code: **10202**
- SIP response code: **404**
- Suggested actions:  
  - In call merge and consultative transfer scenarios, the Session Border Controller (SBC) might retry the call if the first call attempt fails. Check whether your SBC is configured to try a replacement call after an initial failure.

## 511404 404 Getting user info by number from RuntimeAPI failed

- Microsoft response code: **511404**
- SIP response code: **404**
- Suggested actions:  
  - This error code indicates that the user can't be found during the reverse number lookup. To fix the error, make sure that the callee number format of your SBC or PSTN trunk provider matches the format that's assigned to the user or resource account. Usually, Microsoft expects calls to be in the E.164 normalized format, including country/region code, network destination code, and subscriber number. For more information about the format and example, see [Direct Routing - SIP protocol](/microsoftteams/direct-routing-protocols-sip).
