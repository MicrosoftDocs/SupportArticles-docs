---
title: SIP 500 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 500 error, and provides actions to resolve the errors.
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
  - CI 173631
  - CI 6328
  - CSSTroubleshoot
ms.reviewer: teddygyabaah; mikebis
---

# SIP response code 500

This article provides troubleshooting information for various combinations of the SIP 500 error and various Microsoft response codes.

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

## 540500 500 Internal Server Error - Transfer call without draft call data

- Microsoft response code: **540500**
- SIP response code: **500**
- Suggested actions:  
  - This error often occurs in transfer scenarios when a customer’s SBC sends duplicate INVITEs in response to Microsoft REFER after the initial INVITE request is rejected. The SBC shouldn't send an INVITE again in response to the rejected request but should send the NOTIFY that contains the reason for the rejection. Then Microsoft will either send a new REFER, or indicate that the transfer failed in the Teams client.

## 540500 500 Internal Server Error - Duplicate CreateCallAsync request

- Microsoft response code: **510544**
- SIP response code: **500**
- Suggested actions:  
  - The customer's SBC sends duplicate INVITE requests to Microsoft, and Microsoft declines the latest one. The SBC shouldn't send multiple duplicate requests.
