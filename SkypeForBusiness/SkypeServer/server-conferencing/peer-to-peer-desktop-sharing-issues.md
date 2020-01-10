---
title: Peer-to-Peer desktop sharing issues for Skype for Business for iOS users
description: Describes problems that are encountered by Skype for Business for iOS users when a desktop sharing session is started for them in a P2P conversation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: skype-for-business-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: landerl, corbinm, rischwen
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business for iOS
---

# Peer-to-Peer desktop sharing issues for Skype for Business for iOS users

## Symptoms

When you try to start a desktop sharing session in a Peer-to-Peer (P2P) instant message (IM) or in a P2P audio conversation with a Microsoft Skype for Business for iOS user, you experience the following symptoms: 

- Skype for Business for iOS users receive the following notification:

   "UserA tried to start a screen presentation, but this version of the app only supports that in conference calls and Skype Meetings."   
- Skype for Business Desktop users receive the following notification:

  "The invitation you sent to UserB expired."

When you try to start a desktop sharing session in a P2P video conversation with a Skype for Business for iOS user, you experience the following symptoms:
- Skype for Business for iOS users are not notified that the desktop user tried to start a desktop sharing session.   
- Skype for Business Desktop users receive the following notification:The invitation you sent to UserB expired.

## Cause

This issue occurs because desktop sharing is currently supported for Skype for Business iOS users only in a Skype for Business conference. This is the same behavior that occurs in Microsoft Lync 2013 for iOS.

## Status

This feature will be available in a future Skype for Business for iOS update.
