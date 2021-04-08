---
title: Outlook client displays incorrect policy information
description: If an organization creates multiple retention policies for either Teams or Skype for Business in the Security & Compliance Center, Outlook client by default displays either the Teams or Skype for Business policy.
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: article
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: angelat
appliesto:
- Exchange Online
search.appverid: MET150
---
# Outlook client displays Teams or Skype for Business retention policies

_Original KB number:_ &nbsp; 4491013

## Symptoms

The Outlook desktop client uses the Teams or Skype for Business retention policy as the default policy that's applied to the mailbox when the properties of a folder are viewed. The expected behavior is to list the Exchange mailbox policy.

## Cause

If an organization creates multiple retention policies for either Teams or Skype for Business in the Security & Compliance Center, the Outlook client by default displays either the Teams or Skype for Business policy.

The Teams or Skype for Business policy that's displayed in Outlook doesn't apply to a user's mail folders. Therefore, the Outlook client displays the incorrect policy information for the mail folder.

## Status

Microsoft is aware of this issue and will post more information in this article when the information becomes available.
