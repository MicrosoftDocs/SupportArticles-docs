---
title: SIP 488 and Microsoft response codes
description: Lists combinations of Microsoft response code and the SIP 488 error, and provides actions to resolve the errors.
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

# SIP response code 488

This article provides troubleshooting information for various combinations of the SIP 488 error and Microsoft response codes.

## 531000 488 InternalDiagCode: CannotSupportAnyMedia, InternalErrorPhrase: Invalid SDP offer: no media acceptable

- Microsoft response code: **531000**
- SIP response code: **488**
- Suggested actions:  
  - Check the SBC configuration to determine why it offers unsupported media formats. For more information about supported codecs, see [Leg between SBC and Cloud Media Processor or Microsoft Teams client](/microsoftteams/direct-routing-plan#leg-between-sbc-and-cloud-media-processor-or-microsoft-teams-client).

## 531000 488 InternalDiagCode: SrtpEncryptionRequired, InternalErrorPhrase: Remote participant did not offer required SRTP support

- Microsoft response code: **531000**
- SIP response code: **488**
- Suggested actions:  
  - [Enable Secure Real-time Transport Protocol (SRTP)](/microsoftteams/direct-routing-protocols-media#srtp-support-requirements) on the SBC.

## 531027 488 There are no ICE candidates in the SDP. Non-ice endpoints cannot use bypass

- Microsoft response code: **531027**
- SIP response code: **488**
- Suggested actions:  
  - Media bypass won't work if the SBC doesn't provide any ICE candidates in its SDP offer. Make sure that you enable ICE Lite on the SBC. For more information about media bypass, see [About Media Bypass with Direct Routing](/microsoftteams/direct-routing-plan-media-bypass#about-media-bypass-with-direct-routing) and [Direct Routing - media protocols](/microsoftteams/direct-routing-protocols-media).
