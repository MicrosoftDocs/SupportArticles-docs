---
title: Fix 550 5.1.8 Access denied in Exchange Online
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
ms.assetid: 303238b8-658d-46b6-8f45-a789acd2173b
description: Learn how to fix email delivery for error code 5.1.8 (550 5.1.8 Access denied) in Exchange Online (the account has been blocked for sending too much spam), when mail is not delivered.
---

# Fix NDR error "550 5.1.8 Access denied" in Exchange Online

Getting an error message that means the mail you sent wasn't delivered is frustrating. This topic tells you what to do if you get error code 550 5.1.8 Access denied in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN), and mail isn't delivered.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this email delivery issue?](#im-an-email-admin-how-do-i-fix-this-email-delivery-issue)|

## What is 550 5.1.8 and why did I get this bounce message?

You received this NDR with error code 5.1.8 because your account has been blocked for sending too much spam. Typically, this problem occurs because your account has been compromised (hacked) by phishing or malware.

## I got this bounce message. How do I fix it?

First, you need to reset your password and scan your devices for malware. However, the hacker might have configured other settings on your mailbox (for example, created Inbox rules to auto-forward email messages or added additional mailbox delegates). So, follow the additional steps in [How to determine whether your account has been compromised](/office365/troubleshoot/sign-In/determine-account-is-compromised).

Then, you need to tell your email admin that you think your account has been compromised. Your admin will need to unblock your account before you can send email again.

## I'm an email admin. How do I fix this email delivery issue?

The sending account might be compromised. You'll need to:

- [Determine if the account is compromised](/office365/troubleshoot/sign-In/determine-account-is-compromised). If the account is compromised, follow the steps in [Responding to a Compromised Email Account in Exchange Online](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).

- Go to the **Restricted users** page in the Microsoft 365 Defender portal at [https://security.microsoft.com/restrictedusers](https://security.microsoft.com/restrictedusers) to unblock the account. After you unblock the account, the user should be able to resume sending messages *within a few hours*.

- To help prevent future account compromises, follow the recommendations in [Top 10 ways to secure Microsoft 365 for business plans](/microsoft-365/admin/security-and-compliance/secure-your-business-data).

## Still need help with error code 5.1.8?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
