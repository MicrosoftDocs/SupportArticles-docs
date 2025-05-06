---
title: SIP 503 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 503 error, and provides actions to resolve the errors.
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
  - CI173631
  - CI2383
  - CSSTroubleshoot
ms.reviewer: teddygyabaah
---

# SIP response code 503

This article provides troubleshooting information for various combinations of the SIP 503 error and Microsoft response codes.

## 10320 503 Bot is unreachable or unable to answer before timeout

- Microsoft response code: 10320
- SIP response code: 503
- Suggested actions:  
  - If the bot is provided by Microsoft, such as the built-in call recording, [contact Microsoft Support](https://support.microsoft.com/contactus).
  - If the bot is your own bot or from a third-party provider, work with the bot provider to verify that the bot is set up correctly.

## 540998 503 Service Unavailable - Service state: Inactive/DrainingTransactions

- Microsoft response code: **540998**
- SIP response code: **503**
- Suggested actions:  
  - This error is expected when Microsoft SIP endpoints are temporarily unavailable for maintenance. The Microsoft SIP Signaling FQDNs point to available endpoints far enough in advance for the SBC to resolve the FQDNs to new endpoints and send traffic to them. Therefore, this error shouldn't occur frequently under the usual circumstances, and no action is required.
  
    If this error occurs frequently, check the SBC configuration to make sure that the SBC resolves the DNS frequently to avoid sending SIP requests to inactive or unavailable Microsoft endpoints. Ideally, DNS resolution should occur every 15 minutes or more often.

## 560503 503 Service unavailable. SBC undergoing maintenance or temporarily overloaded

- Microsoft response code: **560503**
- SIP response code: **503**
- Suggested actions:  
  - Check the logs on the SBC to investigate why it returns the "503" SIP response.
  - Make sure that the SBC is correctly licensed to handle the number of concurrent sessions.
  - Determine whether the "503" error is related to a specific destination country/region or calling corridor.
