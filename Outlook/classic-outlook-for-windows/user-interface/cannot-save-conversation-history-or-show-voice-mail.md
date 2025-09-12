---
title: Cannot save conversation history or show voice mail
description: In Microsoft Skype for Business, a user may experience can't save conversation history or can't see any voice mail.
ms.author: meerak
author: cloud-writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:User Interface features and Configuration\Conversation view
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: alinastr
appliesto: 
  - Skype for Business
search.appverid: MET150
ms.date: 01/30/2024
---
# Skype for Business can't save conversation history or show voice mail

_Original KB number:_ &nbsp; 4099000

## Symptoms

In Microsoft Skype for Business, you experience one of the following issues:

- Conversation history of the Skype for Business client can' t be saved in the Outlook client.
- You can't see the option for voice mails in the Skype for Business client.

Additionally, you may receive the following error message:

> The Exchange server won't let us connect.  We're working on fixing the connection.  Your history, voice mail and Outlook features might be unavailable.

## Cause

This behavior occurs because the size of the item that is being read from the Deleted Items folder exceeds the quota of 1048576 (0x100000) bytes.

## Resolution

Navigate to **Outlook Client** > **Deleted Items** to check if there are subfolders under Deleted Items. If there are, remove them and try again.
