---
title: Fix NDR error 5.7.23 in Exchange Online
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
description: Learn how to fix email issues for error code 5.7.23 in Exchange Online (The message was rejected because of Sender Policy Framework violation).
---

# Fix NDR error "550 5.7.23" in Exchange Online

This topic describes what you can do if you see error code 550 5.7.23 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|

## I got this bounce message. How do I fix it?

Only an email admin in your Microsoft 365 or Office 365 organization can fix this issue. Contact your email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this?

This bounce message most likely indicates a [Sender policy framework (SPF)](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing) configuration issue in your Microsoft 365 or Office 365 organization.

The **Diagnostic information for administrators** section in the bounce message will contain the original error message when Office 365 tried to send the message to the external email server or service.

To fix this issue, do the following steps:

- Verify the SPF DNS record for your domain. To do this, we recommend that you use a publicly available SPF or DNS record checker on the web.

- Provision all of the domains you own. We limit the number of emails with unprovisioned domains that a tenant can send.

- Add your on-premises IPs, if any, to the SPF record of any domains you send for. This would include any unprovisioned domains you might be relaying through Microsoft 365 or Office 365.

- Verify that the outbound message wasn't identified as spam by Microsoft 365 or Office 365 and routed through the [High Risk Delivery Pool](/microsoft-365/security/office-365-security/high-risk-delivery-pool-for-outbound-messages). Messages in the High Risk Delivery Pool won't pass SPF checks, and therefore won't be accepted by the destination email organization.

  To receive Bcc copies of outbound messages that are determined to be spam, see [Configure outbound spam policy notifications](/microsoft-365/security/office-365-security/configure-the-outbound-spam-policy).

  If you determine that the outbound message was incorrectly detected as spam by Microsoft 365 or Office 365, contact support.

## Still need help with error code 550 5.7.23?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
