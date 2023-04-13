---
title: SIP 410 and Microsoft response codes
description: Lists combinations of Microsoft response code and SIP 410 error, and provides actions that you can take to resolve the error codes.
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

# SIP response code 410

This article lists combinations of SIP 410 and Microsoft response codes, the corresponding error messages, and actions that you can take.

## 531000 410 SdpParsingFailure

- Microsoft response code: **531000**
- SIP response code: **410**
- Error message: **SdpParsingFailure**
- Suggested actions:  
  This error indicates that the Session Description Protocol (SDP) offers and answers might be malformed or unsupported. Work with your SBC vendor to verify that SDP offers and answers that are sent from the SBC comply with [RFC standards](/microsoftteams/direct-routing-protocols#rfc-standards).

## 531004 410 IceConnectivityChecksFailed

- Microsoft response code: **531004**
- SIP response code: **410**
- Error message: **IceConnectivityChecksFailed**
- Suggested actions:  
  This error indicates that the media path can't be established. It's usually caused by incorrect network configurations. Verify your network configuration to make sure that [required IP addresses and ports](/microsoftteams/direct-routing-plan#media-traffic-port-ranges) aren't blocked.

## 531005 410 MediaConnectivityFailure

- Microsoft response code: **531005**
- SIP response code: **410**
- Error message: **MediaConnectivityFailure**
- Suggested actions:  
  This error indicates that the media path is broken. It's usually caused by incorrect network configurations. Verify your network configuration.

## 510412 412 Get Flighting - wrong callee MRI

- Microsoft response code: **510412**
- SIP response code: **412**
- Error message: **Get Flighting - wrong callee MRI**
- Suggested actions:  
  Correct the malformed callee number in the inbound call to fix the number parsing error. This will enable the creation of a correct Messaging Resource Identifier (MRI) that's required for further processing of the call.
