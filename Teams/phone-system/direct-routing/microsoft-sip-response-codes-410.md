---
title: Microsoft and SIP response codes 410 and 412
description: A combination of Microsoft and SIP response codes 410 and 412 can help identify the cause of call failures and provide detailed descriptions of errors and actions that you can take.
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
ms.custom: CI166247,CSSTroubleshoot
ms.reviewer: rishire
---

# SIP response codes 410 and 412

This article lists combinations of Microsoft and SIP response codes, the corresponding error messages, and actions that you can take.

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

- Microsoft response code: **531004**
- SIP response code: **410**
- Error message: **MediaConnectivityFailure**
- Suggested actions:  
  This error indicates that the media path is broken. It's usually caused by incorrect network configurations. Verify your network configuration. (Lu: Is there a complete list of network requirements for media traffic?)

## 510412 412 Get Flighting - wrong callee MRI

- Microsoft response code: **510412**
- SIP response code: **412**
- Error message: **Get Flighting - wrong callee MRI**
- Suggested actions:
  Correct the malformed callee number in the inbound call to fix the number parsing error. This will enable the creation of a correct Messaging Resource Identifier (MRI) that's required for further processing of the call.
