---
title: SIP 402 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 402 error, and provides actions to resolve the errors.
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
  - CI2386
  - CSSTroubleshoot
ms.reviewer: mikebis
---

# SIP response code 402

This article provides troubleshooting information for the combination of the SIP 402 error and Microsoft response code 560402.

## 560402 402 Payment required

- Microsoft response code: **560402**
- SIP response code: **402**
- Suggested actions:  
  - Review the tenant's call records that include *CallEndSubReason = 560402*. Look for trends in the called numbers, or a distribution of the failures by destination country or region. Patterns can be identified that would suggest a problem in a downstream PSTN carrier.

    **Note**: This error might be represented by a slightly different phrase that's associated with the response code.
