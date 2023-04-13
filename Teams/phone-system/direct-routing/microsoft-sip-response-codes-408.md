---
title: SIP 408 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 408 error, and provides actions that you can take to resolve the error codes.
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

# SIP response code 408

This article lists combinations of SIP 408 and Microsoft response codes, the corresponding error messages, and actions that you can take.

## 1106 408 An acknowledgement was not received for the call acceptance in the allotted time

- Microsoft response code: **1106**
- SIP response code: **408**
- Error message: **An acknowledgement was not received for the call acceptance in the allotted time**
- Suggested actions:  
  This error indicates that the callee answered the call, but the SBC didn't acknowledge the SIP 200 OK (answer message) from Microsoft. Work with your SBC vendor to verify that the SIP stack and the underlying TCP/TLS connections are correctly established with [Microsoft connection points](/microsoftteams/direct-routing-plan#sip-signaling-fqdns).

## 500001 408 Gateway (SBC) failover timer expired

- Microsoft response code: **500001**
- SIP response code: **408**
- Error message: **Gateway (SBC) failover timer expired**
- Suggested actions:  
  Investigate why the SBC didn't send a response to the invitation within the configured time-out value as defined by [FailoverTimeSeconds](/powershell/module/skype/set-csonlinepstngateway?view=skype-ps&preserve-view=true). The default value is 10 seconds.

  This error usually occurs in regions that have long PSTN setup times. Consider changing the failover timer to 20 seconds in these regions or on all Direct Routing trunks.

## 560408 408 SBC indicated that the user did not respond (request timeout)

- Microsoft response code: **560408**
- SIP response code: **408**
- Error message: **SBC indicated that the user did not respond (request timeout)**
- Suggested actions:  
  Review the tenant's call records with *CallEndSubReason = 560408*. Look for trends in the called numbers, or a distribution of the failures by destination country. Patterns can be identified that would suggest a problem that affects a downstream component.

## 0 408 Establishment timeout

- Microsoft response code: **0**
- SIP response code: **408**
- Error message: **Establishment timeout**
- Suggested actions:  
  This code indicates a client error. Check the network connection between the client and the Teams service.
