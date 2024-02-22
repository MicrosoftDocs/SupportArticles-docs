---
title: Fix error "sender's submission quota exceeded" in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: high
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
description: Learn how to fix email issues for the error, 'the sender's submission quota was exceeded' in Exchange Online.
---

# Fix NDR error "the sender's submission quota was exceeded" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see the error:

> The message can't be submitted because the sender's submission quota was exceeded.

in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

## Why did I get this bounce message?

You received this NDR because you have exceeded the recipient rate limit (10,000 recipients per day).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|

## I got this bounce message. How do I fix it?

If you knowingly sent 10,000 messages in the last 24 hours, you need to wait one day before you can send email from your mailbox.

If you didn't send the messages and you suspect your account has been compromised, reset your password and scan your devices for malware. However, the attacker might have configured other settings on your mailbox (for example, Inbox rules to forward messages or additional mailbox delegates). So, follow the steps in [How to determine whether your Office 365 account has been compromised](/office365/troubleshoot/sign-In/determine-account-is-compromised).

## I'm an email admin. How do I fix this?

More information about sending and receiving limits in Exchange Online is available at [Receiving and sending limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#receiving-and-sending-limits).

The sending account might be compromised. You'll need to:

- [Determine if the account is compromised](/office365/troubleshoot/sign-In/determine-account-is-compromised). If the account is compromised, follow the steps in [Responding to a Compromised Email Account in Exchange Online](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).

- To help prevent future account compromises, follow the recommendations in [Top 10 ways to secure Microsoft 365 for business plans](/microsoft-365/admin/security-and-compliance/secure-your-business-data).

## Still need help?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)
