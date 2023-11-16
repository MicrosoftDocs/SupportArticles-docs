---
title: SIP 410 and Microsoft response codes
description: Lists combinations of Microsoft response codes and the SIP 410 error, and provides actions to resolve the errors.
ms.date: 10/30/2023
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

This article provides troubleshooting information for various combinations of the SIP 410 error and Microsoft response codes.

## 531000 410 SdpParsingFailure

- Microsoft response code: **531000**
- SIP response code: **410**
- Suggested actions:  
  - This error indicates that the Session Description Protocol (SDP) offers and answers might be malformed or unsupported. Work with your SBC vendor to verify that SDP offers and answers that are sent from the SBC comply with [RFC standards](/microsoftteams/direct-routing-protocols#rfc-standards).

## 531004 410 IceConnectivityChecksFailed

- Microsoft response code: **531004**
- SIP response code: **410**
- Suggested actions:  
  - This error indicates that the media path can't be established. It's usually caused by incorrect network configurations. Verify your network configuration to make sure that [required IP addresses and ports](/microsoftteams/direct-routing-plan#media-traffic-port-ranges) aren't blocked.

## 531005 410 MediaConnectivityFailure

- Microsoft response code: **531005**
- SIP response code: **410**
- Suggested actions:  
  - This error indicates that the media path is broken. The error is usually caused by incorrect network configurations. Verify your network configuration.
