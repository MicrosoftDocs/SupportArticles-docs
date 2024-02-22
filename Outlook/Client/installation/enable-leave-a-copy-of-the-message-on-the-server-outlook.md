---
title: Leave a copy of the message on the server is missing in Outlook
description: How to enable the Leave a Copy of the Message on the Server options in Outlook 2010 and later versions.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: v-kimhal
appliesto: 
  - Microsoft Outlook 2010
  - Outlook 2010 with Business Contact Manager
  - Outlook 2013
  - Outlook 2016
  - Outlook for Microsoft 365
  - Outlook 2019
search.appverid: MET150
ms.date: 10/30/2023
---
# Leave a copy of the message on the server is missing in Outlook

_Original KB number:_ &nbsp;2671941

## Summary

If the option **Leave a copy of the message on the server** is missing in Microsoft Outlook, it may be because of the type of email account you use. Of the most common types of email accounts, only POP3 accounts download the email to your computer.

If you have an IMAP, or HTTP (such as Gmail or `Outlook.com`) account, mail isn't stored on your computer. All email remains on the mail server until you delete it.

## Steps to enable the option

To enable (or disable) the **Leave a copy of the message on the server** option, follow these steps:

1. Open **Outlook**.
1. Click the **File** tab > **Account settings** > **Account settings**.
1. Highlight your current POP3 account and click **Change**.
    > [!NOTE]
    > The window that opens will tell you what type of email account you have. (Look under **Type**.)
1. Choose **More settings** and click **Advanced**.
1. You should see a check box titled: **Leave a copy of messages on the server**.
1. Check the box to enable **Leave a copy of the message on the server**.
    > [!NOTE]
    > Enabling **Leave a copy of the message on the server** will allow you to access your email from multiple computers.
