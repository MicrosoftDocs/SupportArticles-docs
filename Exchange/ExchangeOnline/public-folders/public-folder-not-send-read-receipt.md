---
title: Read receipt is sent from public folder mailbox
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

# Read receipts are sent from a public folder mailbox instead of the public folder

When you send an email that requests a read receipt to a mail-enabled public folder in [Outlook](https://support.microsoft.com/office/add-and-request-read-receipts-and-delivery-notifications-a34bf70a-4c2c-4461-b2a1-12e4a7a92141) or [Outlook on the web](https://support.microsoft.com/office/read-receipts-in-outlook-on-the-web-e09af74d-3519-45fc-a680-37a538a92157), you don't receive the read receipt from the public folder. Instead, the read receipt is sent from the public folder mailbox.

This issue occurs when the `PerUserReadStateEnabled` parameter of the public folder is set to `False` to remove read or unread tracking on a per-user basis.

To check the `PerUserReadStateEnabled` parameter value of the public folder, run the following cmdlet:

```powershell
Get-PublicFolder -Identity \<Public Folder Name> | FL *PerUserReadStateEnabled*
```

For example, you send an email to a mail-enabled public folder (named **PF2**).

:::image type="content" source="media/public-folder-not-send-read-receipt/request-read-receipt.png" alt-text="Screenshot of an email to a mail-enabled public folder that requests a read receipt.":::

However, you receive the read receipt from the public folder mailbox (named **MSExchangepf2**).

:::image type="content" source="media/public-folder-not-send-read-receipt/read-receipt-from-mailbox.png" alt-text="Screenshot of a read receipt that comes from the public folder mailbox.":::

## Status

This is a known issue of read receipts. Microsoft is researching this problem and will post more information in this article when the information becomes available.
