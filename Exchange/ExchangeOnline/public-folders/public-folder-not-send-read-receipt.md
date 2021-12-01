---
title: Read receipt isn't sent from mail-enabled public folder
description: Describes a known issue in which a read receipt isn't sent from the public folder, but from the public folder mailbox that hosts the public folder.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
localization_priority: Normal
ms.custom:
- CI 146406
- Exchange Online
- CSSTroubleshoot
ms.reviewer: meerak; haembab; batre
editor: v-jesits
appliesto: 
- Exchange Online
search.appverid: MET150
---

# Read receipt isn't sent from mail-enabled public folder

## Symptoms

When you send an email that requests a read receipt to a mail-enabled public folder, you don't receive a read receipt from the public folder, but from the public folder mailbox that is hosting the public folder.

This issue occurs if you set the `PerUserReadStateEnabled` parameter value to `False` for the public folder to remove read or unread tracking on a per-user basis. To check the parameter value, run the following cmdlet:

```powershell
Get-PublicFolder -Identity \MyPublicFolder | FL *PerUserReadStateEnabled*
```

## Status

This is a known issue of read receipts. Microsoft is researching this problem and will post more information in this article when the information becomes available.
