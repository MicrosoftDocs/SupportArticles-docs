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

# Read receipt isn't sent from mail-enabled public folder but from public folder mailbox

## Symptoms

A mail-enabled public folder has the following settings:

- Set the `PerUserReadStateEnabled` parameter value to `False` to remove read or unread tracking on a per-user basis.
- Set the public folder to always send a read receipt:

    - In Outlook, select the **Always send a read receipt** option.
    - In Outlook on the web, select the **Always send a response** option.

When you send an email that requests a read receipt to the mail-enabled public folder, you don't receive the read receipt from the public folder. Instead, the read receipt is sent from the public folder mailbox.

For example, you send an email to a mail-enabled public folder (named **PF2**).

However, you receive the read receipt from the public folder mailbox (named **MSExchangepf2**).

## Status

This is a known issue of read receipts. Microsoft is researching this problem and will post more information in this article when the information becomes available.

## More information

For more information about how to request a read receipt for your message in Outlook and Outlook on the web, see the following articles:

- [Add and request read receipts and delivery notifications](https://support.microsoft.com/en-us/office/add-and-request-read-receipts-and-delivery-notifications-a34bf70a-4c2c-4461-b2a1-12e4a7a92141)
- [Read receipts in Outlook on the web](https://support.microsoft.com/en-us/office/read-receipts-in-outlook-on-the-web-e09af74d-3519-45fc-a680-37a538a92157)

To check the `PerUserReadStateEnabled` parameter value of the mail-enabled public folder, run the following cmdlet:

```powershell
Get-PublicFolder -Identity \<Public Folder Name> | FL *PerUserReadStateEnabled*
```
