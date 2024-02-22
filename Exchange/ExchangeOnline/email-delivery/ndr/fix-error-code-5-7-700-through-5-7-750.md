---
title: Fix NDR error 5.7.700 through 5.7.750 in Exchange Online
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
description: Learn how to fix email issues for error code 5.7.700 through 5.7.750 in Exchange Online.
---

# Fix NDR error "550 5.7.700" through "550 5.7.750" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error codes 550 5.7.700 through 550 5.7.750 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

Use the information in the NDR to help you decide how to fix the problem.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. What can I do to fix this?](#im-an-email-admin-what-can-i-do-to-fix-this)|

## Why did I get this bounce message?

- **5.7.703 Your message can't be delivered because messages to XXX, YYY are blocked by your organization using Tenant Allow Block List**: This error occurs when someone in your organization sent mail to an email address or domain that's blocked in the [Tenant Allow/Block List](/microsoft-365/security/office-365-security/tenant-allow-block-list-about#block-entries-in-the-tenant-allowblock-list). The entire message is blocked for all internal and external recipients of the message, even if only one recipient email address or domain is defined in a block entry.

- **5.7.705 Access denied, tenant has exceeded threshold**: This error occurs when too much spam or bulk mail has been sent by your organization and we place a block on outgoing mail.

- **5.7.708 Access denied, traffic not accepted from this IP**: This error occurs when sending email from known, low reputation IP addresses that are typically used by new customers.

- **5.7.750 Client blocked from sending from unregistered domain**: The error occurs when a large volume of messages are sent from domains that aren't provisioned in Office 365 (added as accepted domains and validated).

## I got this bounce message. How do I fix it?

Only an email admin in your organization can fix the issue. Contact your email admin and refer them to this information so they can resolve the issue for you.

## I'm an email admin. What can I do to fix this?

The solutions for specific error codes are described in the following sections.

### 5.7.703 Your message can't be delivered because messages to XXX, YYY are blocked by your organization using Tenant Allow Block List

Although the [Tenant Allow/Block List](/microsoft-365/security/office-365-security/tenant-allow-block-list-about) is mostly about preventing outside users from sending email into your organization, users in the organization also can't send mail to those blocked senders or sender domains. The entire message is blocked for all internal and external recipients of the message, even if only one recipient email address or domain is defined in a block entry.

### 5.7.705 Access denied, tenant has exceeded threshold

Common causes are compromised on-premises servers or compromised admin accounts that have been used to create connectors. Either condition can allow spam to pass through your organization.

To remove this block, you need to understand and explain the cause to a support agent, as well as correct the underlying problem. Admins can use the following reports to investigate who or what is causing the issue:

- Mailflow status report (Outbound): [https://security.microsoft.com/mailflowStatusReport?viewid=type](https://security.microsoft.com/mailflowStatusReport?viewid=type)
- Threat protection status (spam only): [https://security.microsoft.com/reports/TPSAggregateReportATP](https://security.microsoft.com/reports/TPSAggregateReportATP)
- Top senders and recipients: [https://security.microsoft.com/reports/TopSenderRecipients](https://security.microsoft.com/reports/TopSenderRecipients)
- Outbound Connector report: [https://admin.exchange.microsoft.com/#/reports/outboundconnectordetails](https://admin.exchange.microsoft.com/#/reports/outboundconnectordetails)

To further investigate, you can use [message trace](/exchange/monitoring/trace-an-email-message/message-trace-modern-eac)

In rare cases, this issue could also happen if you renew your subscription after it has already expired. It takes time for the service to sync the new subscription information (typically, no more than one day), but your organization could be blocked from sending email in the meantime. The best way to prevent this issue is to make sure your subscription does not expire.

### 5.7.708 Access denied, traffic not accepted from this IP

This error can happen when you are trying out a Microsoft 365 trial tenant. If you receive this error before you can purchase licenses, contact support to request an exception for the low reputation IP address until you're able to purchase licenses.

### 5.7.750 Client blocked from sending from unregistered domain

In most cases, the connectors are set up correctly, but email is being sent from unregistered (also known as unprovisioned) domains. Office 365 allows a reasonable amount of email from unregistered domains, but you should configure every domain that you use to send email as an accepted domain.

To fix this error, you can:

- **Most common solution**: Add and validate all domains in Microsoft 365 or Office 365 that you use to send email messages. For more information, see [Add a domain](/microsoft-365/admin/setup/add-domain).

- Use a certificate-based outbound connector where the certificate's domain is an accepted and validated domain in Microsoft 365 or Office 365. For more information, see [Configure mail flow using connectors](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/use-connectors-to-configure-mail-flow).

- Look for unusual connectors and compromised accounts. Attackers will often create new inbound connectors in your Microsoft 365 or Office 365 organization to send spam. For more information, see [Validate connectors](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/validate-connectors), and [Responding to a compromised email account](/microsoft-365/security/office-365-security/responding-to-a-compromised-email-account).

## Still need help with error codes 5.7.700 through 5.7.750?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
