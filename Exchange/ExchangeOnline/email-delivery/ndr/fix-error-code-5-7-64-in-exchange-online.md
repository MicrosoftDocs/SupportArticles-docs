---
title: Fix NDR error 5.7.64 in Exchange Online
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
description: Learn how to fix email issues for error code 5.7.64 in Exchange Online (TenantAttribution; Relay Access Denied).
---

# Fix NDR error "550 5.7.64" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 550 5.7.64 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|

## I got this bounce message. How do I fix it?

Only an email admin in your Microsoft 365 or Office 365 organization can fix this issue. Contact your email admin and refer them to this information so they can try to resolve the issue for you.

## I'm an email admin. How do I fix this?

This problem happens when you use an inbound connector to receive messages from your on-premises email environment, and something has changed in your on-premises environment that makes the inbound connector's configuration incorrect. For example:

- The host name that's specified in the certificate on the inbound connector no longer matches the source email server.

- IP address of the source email server no longer matches the source IP address on the inbound connector.

The **Diagnostic information for administrators** section in the bounce message will contain the original error message when Microsoft 365 or Office 365 tried to send the message to the external email server or service.

To fix this issue, see [this topic](/exchange/troubleshoot/connectors/relay-access-denied-smtp).

## Still need help with error code 550 5.7.64?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
