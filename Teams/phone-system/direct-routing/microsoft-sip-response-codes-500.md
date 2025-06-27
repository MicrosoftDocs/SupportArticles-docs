---
title: SIP 500 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 500 error, and provides actions to resolve the errors.
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

# SIP response code 500

This article provides troubleshooting information for various combinations of the SIP 500 error and Microsoft response codes.

## 510482 500 Loop detected

- Microsoft response code: **510482**
- SIP response code: **500**
- Suggested actions:  
  - Make sure that there's no infinite call forwarding.

## 510544 500 Get Outbound Direct routing - no trunk config found

- Microsoft response code: **510544**
- SIP response code: **500**
- Suggested actions:  
  - Verify the trunk (gateway) configuration for the specific tenant, and make sure that it's set up correctly. For more information about call routing configuration, see [Configure call routing for Direct Routing](/microsoftteams/direct-routing-voice-routing).

## 510544 500 Get Outbound routing - failed getting direct routing gateways for emergency user

- Microsoft response code: **510544**
- SIP response code: **500**
- Suggested actions:  
  - Review the [emergency call routing policies](/microsoftteams/manage-emergency-call-routing-policies) and fix any misconfiguration.
