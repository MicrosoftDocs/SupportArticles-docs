---
title: SIP 484 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 484 error, and provides actions to resolve the errors.
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

# SIP response code 484

This article provides troubleshooting information for the combination of the SIP 484 error and Microsoft response code 560484.

## 560484 484 Invalid number format. SBC rejected the call

- Microsoft response code: **560484**
- SIP response code: **484**
- Suggested actions:  
  - Review the tenant's call records that contain *CallEndSubReason = 560484*. Look for trends in the called numbers, including the called numbers distribution by country/region. You can identify patterns that suggest that you should either establish additional normalization rules for extension-based dialing or follow up about user education.  

    In some cases, these failures can be ignored because the user is dialing an invalid number. In other cases, the SBC could cause these failures because of a missing configuration in a call transfer scenario (CallType = ByotOutUserForwarding).
