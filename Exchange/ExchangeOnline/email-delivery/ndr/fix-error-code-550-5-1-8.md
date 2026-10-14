---
title: Fix NDR error 550 5.1.8 in Exchange Online
ms.date: 10/02/2026
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: arindamt
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
  - CI 12713
  - CI 13055
search.appverid:
- BCS160
- MOE150
- MET150
description: Learn how to fix email issues for error code 550 5.1.8 Access denied, bad outbound sender.
---

# Fix NDR error "550 5.1.8" in Exchange Online

## Summary

This article describes what you can do if you see error code 550 5.1.8 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). This automated notification displays when a user tries to send an email message after their account exceeds the sending limit in Exchange Online.

## Why did I get this bounce message?

The complete NDR error message is as follows:

> Your message couldn't be delivered because you weren't recognized as a valid sender. The most common reason for this is that your email address is suspected of sending spam and it's no longer allowed to send email. Contact your email admin for assistance. Remote Server returned 550 5.1.8 Access denied, bad outbound sender.

This NDR is generated if a user tries to send an email message after their account exceeds the [sending limits in Exchange Online](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits).

## How do I fix this?

If you're a user, [determine whether your account is compromised](/microsoft-365/troubleshoot/sign-in/determine-account-is-compromised) and then notify your administrator.

If you're an email administrator, follow these steps:

1. [Secure a compromised email account in Exchange Online](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).
2. Unblock the user account on the **Restricted entities** page in the [Microsoft 365 Defender portal](https://security.microsoft.com/restrictedusers). After you unblock the user account, all restrictions are usually removed within one hour so that the user can send email.

For more information, see [Remove blocked users from the Restricted entities page](/microsoft-365/security/office-365-security/outbound-spam-restore-restricted-users). To help prevent future account compromises, follow the recommendations in [Top 10 ways to secure your business data](/microsoft-365/admin/security-and-compliance/secure-your-business-data#top-10-ways-to-secure-your-business-data).
