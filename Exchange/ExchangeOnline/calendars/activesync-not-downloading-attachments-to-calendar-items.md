---
title: ActiveSync cannot download attachments to Calendar items
description: Provides a resolution to use Microsoft Exchange ActiveSync to synchronize attachments in a calendar item on mobile devices.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: wduff, mhaque, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Exchange ActiveSync doesn't download attachments to Calendar items on mobile devices

_Original KB number:_ &nbsp; 2503175

## Symptoms

Attachments on meetings or appointments are not available when you synchronize the Calendar with a Microsoft Exchange ActiveSync client.

## Cause

This problem occurs if one or both of the following conditions are true:

- The Exchange ActiveSync client doesn't support version 16 or a later version of the Exchange ActiveSync protocol.
- The mailbox is located on a version of Exchange that doesn't support version 16 or a later version of the Exchange ActiveSync protocol.

## Resolution

To synchronize attachments in a calendar item, follow these steps:

1. Move the mailbox to Exchange Online or to Exchange 2016.
2. Upgrade the device to a client that supports version 16 or later.

## More information

For more information about the Exchange ActiveSync protocols, see:

- [[MS-ASHTTP]: Exchange ActiveSync: HTTP Protocol](/openspecs/exchange_server_protocols/ms-ashttp/4cbf28dc-2876-41c6-9d87-ba9db86cd40d)
- [2.2.4 Exchange ActiveSync Protocols](/openspecs/exchange_server_protocols/ms-oxproto/8b83944d-0eed-4b2b-87dd-1982733ec089)
