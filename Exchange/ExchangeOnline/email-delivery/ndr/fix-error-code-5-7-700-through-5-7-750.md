---
title: NDR error codes 550 5.7.703, 550 5.7.705, 550 5.7.708, and 550 5.7.750
description: Provides a fix for NDR error codes 550 5.7.703, 550 5.7.705, 550 5.7.708, and 550 5.7.750.
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

# NDR error codes 550 5.7.703, 550 5.7.705, 550 5.7.708, and 550 5.7.750

## 550 5.7.703

The complete NDR error message is as follows:

> 550 5.7.703 Your message can't be delivered because messages to \<recipient\> are blocked by your organization using Tenant Allow Block List.

This NDR is generated if a user in your organization sends mail to an email address or domain that is blocked in the [tenant allow/block list](/microsoft-365/security/office-365-security/tenant-allow-block-list-about#block-entries-in-the-tenant-allowblock-list). The tenant allow/block list specifies external senders that are blocked from emailing users in your organization, and vice versa. If even one recipient or domain in an email message is blocked, all other internal and external recipients in the message are blocked.

**How do I fix this?**

An email admin in your organization can fix this issue by modifying the tenant allow/block list.

## 550 5.7.705

The complete NDR error message is as follows:

> 550 5.7.705 Access denied, tenant has exceeded threshold.

Exchange Online blocks your outgoing mail, and this NDR is generated, if your organization sends too much spam or bulk mail.

Any of the following scenarios can cause spam or bulk mail to pass through your organization:

- A compromised on-premises server that routes mail to Exchange Online. This is a common scenario.

- A compromised admin account that's used to create connectors. This is a common scenario.

- Renewing an expired Exchange Online subscription. If your organization renews an expired Exchange Online subscription, it might be blocked from sending email while the subscription renews (typically, for no longer than one day). This is a rare scenario because most organizations don't let their subscription expire.

**How do I fix this?**

An email admin in your organization can fix this issue by using the following information to protect your organization from threats:

- [Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account)

- [Set up multifactor authentication for Microsoft 365](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication)

- [Configure your Microsoft 365 tenant for increased security](/microsoft-365/security/office-365-security/tenant-wide-setup-for-increased-security)

- [Microsoft Secure Score](/microsoft-365/security/defender/microsoft-secure-score)

After you address the underlying cause of the issue, contact Microsoft Support to have the block removed.

## 550 5.7.708

The complete NDR error message is as follows:

> 550 5.7.708 Service unavailable. Access denied, traffic not accepted from this IP.

This NDR is generated if you send an email message from an IP address that has a low reputation. The issue is more likely to affect new customers, such as those who have a Microsoft 365 trial subscription.

**How do I fix this?**

If you're an email admin, and you receive this error during a trial subscription, contact Microsoft Support to request an IP address exception until you assign Exchange Online licenses.

## 550 5.7.750

The complete NDR error message is as follows:

> 550 5.7.750 Client blocked from sending from unregistered domain

This NDR is typically generated if a large volume of email messages is sent from a domain that isn't added as an [accepted domain](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains) in Microsoft 365. Microsoft 365 allows only a certain number of email messages to be sent from an unregistered (unaccepted) domain.

A less common cause is having one or more incorrectly configured connectors.

**How do I fix this?**

An email admin in your organization can fix this issue by following these recommendations:

- [Add and validate all domains in Microsoft 365](/microsoft-365/admin/setup/add-domain) that you use to send email messages. This is the most common solution.

- Use a certificate-based outbound connector for which the certificate's domain is an accepted and validated domain in Microsoft 365 or Office 365. For more information, see [Configure mail flow using connectors in Exchange Online](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/use-connectors-to-configure-mail-flow).

- Look for unusual connectors and compromised accounts. Attackers create new inbound connectors in organizations to send spam. For more information, see [Validate connectors in Exchange Online](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/validate-connectors), and [Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).
