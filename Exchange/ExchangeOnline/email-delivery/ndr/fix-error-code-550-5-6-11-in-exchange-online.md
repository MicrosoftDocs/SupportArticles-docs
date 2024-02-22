---
title: Fix NDR error 550 5.6.11 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: medium
f1.keywords:
- CSH
ms.custom: 
- Exchange Online
- CSSTroubleshoot
- CI 167832
search.appverid: 
- BCS160
- MET150
ms.assetid: 81dafee7-26af-4d79-b174-8f78980dfafb
description: Learn how to fix email issues for error code 5.6.11 in Exchange Online (the destination email server rejects messages with bare line feeds).
---

# Fix NDR error "550 5.6.11" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 5.6.11 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-can-i-fix-this)|

## Why did I get this bounce message?

You received this bounce message with error code 5.6.11 because your message contain bare line feeds, and the destination email server doesn't support messages with bare line feeds.

A _bare line feed_ is a line feed (LF) character that's not immediately preceded by a carriage return (CR) character. In other words, instead of a line of text ending with CR LF, it ends with only LF.

Typically, each line in an email message ends with a carriage return followed by a line feed (CR LF).

If a message contains bare line feeds, the SMTP Chunking feature is required to transmit the message between email servers. Chunking uses the SMTP BDAT command as defined in [RFC 3030](https://tools.ietf.org/html/rfc3030). If the destination email server doesn't support BDAT, then it can't accept messages that contain bare line feeds.

Microsoft 365 and Office 365 used to remove bare line feeds from messages to enable delivery to older email servers that didn't support SMTP Chunking and the BDAT command. In an effort to better support security standards (for example, DomainKeys Identified Mail or DKIM), Office 365 no longer removes bare line feeds from messages.

## I got this bounce message. How do I fix it?

If you received this NDR as a result of a message that you sent, you can try the following steps fix the problem:

1. Send the message using a different email program that doesn't add bare line feeds to messages, such as [Outlook on the web](https://support.microsoft.com/office/a096dc77-d053-4e04-864d-c278e5712ef9) (formerly known as Outlook Web App).

2. If the original message contained an attachment, try sending the message without the attachment.

If these steps don't fix the problem for you, contact your email admin and refer them to the information in this topic so they can try to resolve the issue for you.

## I'm an email admin. How can I fix this?

If the steps in the previous section didn't fix the problem, the **recipient's** email admin can fix the problem by using one solutions described in this section.

### Solution 1: Disable bare line feed rejection (allow messages that contain bare line feeds) in the destination email server

Some email servers support the ability to disable bare line feed rejection. For example, Receive connectors in Exchange Server support the _BareLinefeedRejectionEnabled_ setting. If the recipient's email server is Exchange, the admin could configure the setting `-BareLinefeedRejectionEnabled $false` on the server's Receive connector for internet mail. For more information, see [Set-ReceiveConnector](/powershell/module/exchange/Set-ReceiveConnector).

### Solution 2: Upgrade the destination email server to a newer version (or different email server software) that supports the SMTP BDAT command

Email servers that supports the SMTP BDAT command can accept messages with bare line feeds. Most modern email servers support BDAT; however, some free and older email servers don't support BDAT.

## What's a bare line feed?

A _bare line feed_ is a single line feed character (LF or ASCII 10) that isn't immediately preceded by the carriage return character (CR or ASCII 13). The line separator in an email message is supposed to be CRLF, not LF.

## Still need help?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)

[RFC 6376 DomainKeys Identified Mail (DKIM) Signatures](https://tools.ietf.org/html/rfc6376)

[RFC 3030 SMTP Service Extensions for Transmission of Large and Binary Mime Messages (BDAT Support)](https://tools.ietf.org/html/rfc3030)
