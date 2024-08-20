---
title: Read receipt is sent from public folder mailbox
description: Describes a known issue in which a read receipt is sent not from a public folder but from a public folder mailbox that hosts the folder.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 146406
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: meerak, haembab, batre, v-chazhang
editor: v-jesits
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Read receipts are sent from a public folder mailbox instead of from a public folder

When you send a message to a mail-enabled public folder, you can request that a read receipt be sent to you after the message is marked as **Read**. In your email client, such as [Microsoft Outlook](https://support.microsoft.com/office/add-and-request-read-receipts-and-delivery-notifications-a34bf70a-4c2c-4461-b2a1-12e4a7a92141) or [Outlook on the web](https://support.microsoft.com/office/read-receipts-in-outlook-on-the-web-e09af74d-3519-45fc-a680-37a538a92157), you can select the option to request a read receipt before you send the message. Also make sure that you enable the following setting in your email client for any message received that includes a read receipt request:

- In Outlook, select **Always send a read receipt**.
- In Outlook on the web, select **Always send a response**.

For the public folder to comply with your read receipt request, the value of the `PerUserReadStateEnabled` parameter on the public folder must be set to **False**. This value indicates that data should not be maintained about which messages are read and unread by each user who has permissions to the public folder.

To check the current value of the `PerUserReadStateEnabled` parameter on the public folder, run the following cmdlet:

```powershell
Get-PublicFolder \<Public Folder Name> | FL Identity,PerUserReadStateEnabled
```

The output of the cmdlet will resemble the following screenshot.

:::image type="content" source="media/public-folder-not-send-read-receipt/get-publicfolder-cmdlet.png" alt-text="Screenshot of the Get-PublicFolder cmdlet that checks the value of the PerUserReadStateEnabled parameter.":::

However, you see that even though both these conditions are met, the read receipt you receive is not sent by the public folder but by the public folder mailbox that hosts the public folder. This issue is shown in the following example:

Message sent from user John to the mail-enabled public folder PF2:

:::image type="content" source="media/public-folder-not-send-read-receipt/request-read-receipt.png" alt-text="Screenshot of an email to a mail-enabled public folder that requests a read receipt.":::

Read receipt received from the public folder mailbox **MSExchangepf2** instead of from PF2:

:::image type="content" source="media/public-folder-not-send-read-receipt/read-receipt-from-mailbox.png" alt-text="Screenshot of a read receipt that comes from the public folder mailbox.":::

## Status

This is a known issue that affects read receipts from public folders. Microsoft is researching this problem and will post more information in this article when the information becomes available.
