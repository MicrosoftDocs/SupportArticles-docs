---
title: Fix NDR error 550 5.0.350 in Exchange Online
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
- MOE150
- MET150
ms.assetid:
description: Learn how to fix email issues for error code 550 5.0.350 or 550 x-dg-ref header is too long.
---

# Fix NDR error "550 5.0.350" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 550 5.0.350 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

Use the information in the NDR to help you decide how to fix the problem.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|

## Why did I get this bounce message?

5.0.350 is a generic wrapper that's used by Exchange Online for a wide variety of non-specific errors that are typically returned by the recipient's email organization.

But, if the NDR also contains `x-dg-ref header is too long`, that's a specific problem with a specific solution. This issue occurs if you use Rich Text formatting in Outlook messages. The message likely contains at least one attachment, and one of the attachments is likely an email message that also contains at least one attached email message.

Or, if the NDR also contains `Requested action not taken: policy violation detected (AS345)`, that's another specific problem with a specific solution. This issue occurs if the message contains an attachment (for example, a Word file) with 20 or more embedded files (for example, Excel or Word files).

## I got this bounce message. How do I fix it?

If the NDR contains `x-dg-ref header is too long`, use **HTML** formatting for messages in Outlook instead of **Rich Text Format**. For more information, see [Change the message format to HTML, Rich Text Format, or plain text](https://support.microsoft.com/office/338a389d-11da-47fe-b693-cf41f792fefa).

If the NDR contains `Requested action not taken: policy violation detected (AS345)`, remove some embedded files from the attachment.

Otherwise, forward the NDR to your admin for help.

## I'm an email admin. How do I fix this?

### x-dg-ref header is too long

In Rich Text formatted messages, the attachment's binary large object (BLOB) becomes part of the header stream in the `X-MS-TNEF-Correlator` header field. If the attachment is too big, the line length of the header field is too long, so the receiving email server will reject the message.

In Exchange Online, you can control TNEF (also known as the Transport Neutral Encapsulation Format, Outlook Rich Text Format, or Exchange Rich Text Format) settings in remote domains, and in the properties of mail contacts or mail users. For more information, see [Message format and transmission in Exchange Online](/exchange/mail-flow-best-practices/message-format-and-transmission).

### Other 5.0.350 errors

Typically, there's nothing that support can do for you, since the problem lies with the recipient's email system.

The **Diagnostic information for administrators** section in the bounce message will contain the original error message when Microsoft 365 or Office 365 tried to send the message to the external email server or service. Use this information to help identify the issue, and to see if there's anything you can do to fix the problem.

## Still need help with error code 550 5.0.350?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
