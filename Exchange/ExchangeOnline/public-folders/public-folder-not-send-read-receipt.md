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

# Read receipts are sent from a public folder mailbox instead of a public folder

When you send a message to a mail-enabled public folder, you can request a read receipt to be sent to you after the message is marked as read. In your email client such as [Outlook](https://support.microsoft.com/office/add-and-request-read-receipts-and-delivery-notifications-a34bf70a-4c2c-4461-b2a1-12e4a7a92141) or [Outlook on the web](https://support.microsoft.com/office/read-receipts-in-outlook-on-the-web-e09af74d-3519-45fc-a680-37a538a92157), select the option to request a read receipt before you send the message.

For the public folder to comply with your read receipt request, the value of the `PerUserReadStateEnabled` parameter on the public folder must be set to **False**. This value indicates not to maintain data about the messages read and unread by each user who has permissions to the public folder.

To check the current value of the `PerUserReadStateEnabled` parameter on the public folder, run the following cmdlet:

```powershell
Get-PublicFolder \<Public Folder Name> | FL Identity,PerUserReadStateEnabled
```

The output of the cmdlet will be similar to the following screenshot:

:::image type="content" source="media/public-folder-not-send-read-receipt/get-publicfolder-cmdlet.png" alt-text="The screenshot of the Get-PublicFolder cmdlet that checks the value of the PerUserReadStateEnabled parameter.":::

However, you see that even though both these conditions are met, the read receipt you receive is not sent by the public folder but by the public folder mailbox which hosts the public folder. This issue is shown in the following example:

Message sent from user John to the mail-enabled public folder PF2:

:::image type="content" source="media/public-folder-not-send-read-receipt/request-read-receipt.png" alt-text="Screenshot of an email to a mail-enabled public folder that requests a read receipt.":::

Read receipt received from the public folder mailbox **MSExchangepf2** instead of PF2:

:::image type="content" source="media/public-folder-not-send-read-receipt/read-receipt-from-mailbox.png" alt-text="Screenshot of a read receipt that comes from the public folder mailbox.":::

## Status

This is a known issue with read receipts from public folders. Microsoft is researching this problem and will post more information in this article when the information becomes available.
