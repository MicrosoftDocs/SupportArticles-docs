---
title: NDR error code 550 5.1.8 (Access denied, bad outbound sender)
description: Provides a fix for NDR 550 5.1.8.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 189901
ms.reviewer: arindamt, lusassl, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 04/22/2024
---

# NDR error code "550 5.1.8 Access denied, bad outbound sender"

The complete NDR error message is as follows:

> Your message couldn't be delivered because you weren't recognized as a valid sender. The most common reason for this is that your email address is suspected of sending spam and it's no longer allowed to send email. Contact your email admin for assistance. Remote Server returned 550 5.1.8 Access denied, bad outbound sender.

This NDR is generated if a user tries to send an email message after their account exceeds the [sending limits in Exchange Online](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits).

## How do I fix this?

If you're a user, follow these steps:

1. [Determine whether your account is compromised](/microsoft-365/troubleshoot/sign-in/determine-account-is-compromised).

2. If your account is compromised, follow the steps in [Respond to a compromised email account in Exchange Online](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).

3. Ask your administrator to unblock your account so that you can send email.

If you're an email admin, you can unblock user accounts on the **Restricted entities** page in the [Microsoft 365 Defender portal](https://security.microsoft.com/restrictedusers). After you unblock a user account, all restrictions are usually removed within one hour.

For more information, see [Remove blocked users from the Restricted entities page](/microsoft-365/security/office-365-security/outbound-spam-restore-restricted-users). To help prevent future account compromises, follow the recommendations in [Top 10 ways to secure your business data](/microsoft-365/admin/security-and-compliance/secure-your-business-data#top-10-ways-to-secure-your-business-data).
