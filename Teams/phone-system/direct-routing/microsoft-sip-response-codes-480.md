---
title: Microsoft and SIP response codes 480, 486 and 488
description: A combination of Microsoft and SIP response codes 480, 486 and 488 can help identify the cause of call failures and provide detailed descriptions of errors and actions that you can take.
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

# SIP response codes 480, 486 and 488

This article lists combinations of Microsoft and SIP response codes, the corresponding error messages, and actions that you can take.

## 10037 480 No callee endpoints were found

- Microsoft response code: **10037**
- SIP response code: **480**
- Error message: **No callee endpoints were found**
- Suggested actions:  
  - If the callee is a Teams user who hasn't logged in for a long time, this behavior is expected.
  - If the callee is currently logged into the Teams client, ask the callee to log out and login in again. If the issue persists, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10140 480 Call to bot is rejected due to null user settings or user app settings

- Microsoft response code: **10140**
- SIP response code: **480**
- Error message: **Call to bot is rejected due to null user settings or user app settings**
- Suggested actions:  
  Verify that you have correctly provisioned the bot you're trying to call. If the bot is correctly provisioned, [contact Microsoft Support](https://support.microsoft.com/contactus).

## 10191 480 Routing to voicemail is disabled in policy

- Microsoft response code: **10191**
- SIP response code: **480**
- Error message: **Routing to voicemail is disabled in policy**
- Suggested actions:  
  In the calling policy that's assigned to the affected user, check the [Voicemail is available for routing inbound calls](/MicrosoftTeams/teams-calling-policy#voicemail-is-available-for-routing-inbound-calls) setting. If the setting is set to **Not enabled**, set it to **Enabled** or **User controlled**.

## 10321 486 Bot rejects the incoming call because it is busy

- Microsoft response code: **10321**
- SIP response code: **486**
- Error message: **Bot rejects the incoming call because it is busy**
- Suggested actions:
  The impact of this error depends on the specific bot and the expectations for the given scenario. If this error is unexpected:

  - If the bot is provided by Microsoft, such as the built-in call recording, [contact Microsoft Support](https://support.microsoft.com/contactus).
  - If the bot is your own bot or from a third-party provider, work with the bot provider to verify that the bot is set up correctly.

## 531000 488 InternalDiagCode: CannotSupportAnyMedia, InternalErrorPhrase: Invalid SDP offer: no media acceptable

- Microsoft response code: **531000**
- SIP response code: **488**
- Error message: **InternalDiagCode: CannotSupportAnyMedia, InternalErrorPhrase: Invalid SDP offer: no media acceptable**
- Suggested actions:  
  Check the SBC configuration to determine why it offers unsupported media formats. For more information about supported codecs, see [Leg between SBC and Cloud Media Processor or Microsoft Teams client](/microsoftteams/direct-routing-plan#leg-between-sbc-and-cloud-media-processor-or-microsoft-teams-client).

## 531000 488 InternalDiagCode: SrtpEncryptionRequired, InternalErrorPhrase: Remote participant did not offer required SRTP support

- Microsoft response code: **531000**
- SIP response code: **488**
- Error message: **InternalDiagCode: SrtpEncryptionRequired, InternalErrorPhrase: Remote participant did not offer required SRTP support**
- Suggested actions:  
  [Enable Secure Real-time Transport Protocol (SRTP)](/microsoftteams/direct-routing-protocols-media#srtp-support-requirements) on the SBC.

## 531027 488 There are no ICE candidates in the SDP. Non-ice endpoints cannot use bypass

- Microsoft response code: **531027**
- SIP response code: **488**
- Error message: **There are no ICE candidates in the SDP. Non-ice endpoints cannot use bypass**
- Suggested actions:
  Media bypass won't work if the SBC doesn't provide any ICE candidates in its SDP offer. Make sure that you enable ICE Lite on the SBC. For more information about media bypass, see [About Media Bypass with Direct Routing](/microsoftteams/direct-routing-plan-media-bypass#about-media-bypass-with-direct-routing) and [Direct Routing - media protocols](/microsoftteams/direct-routing-protocols-media).
