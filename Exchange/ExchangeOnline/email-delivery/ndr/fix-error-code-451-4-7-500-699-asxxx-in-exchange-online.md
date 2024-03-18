---
title: Fix NDR error 451 4.7.500-699 (ASxxx) in Exchange Online
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
- MED150
- MBS150
- MET150
ms.assetid: 51356082-9fef-4639-a18a-fc7c5beae0c8
description: Learn how to fix email issues for error code 451 4.7.500-699 (ASxxx) in Exchange Online (IP throttling).
---

# Fix NDR error code "451 4.7.500-699 (ASxxx)" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 451 4.7.500-699 (ASxxx) in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

## Why did I get this bounce message?

You received this NDR because the source email server (the connecting IP address) changed its previous email sending patterns by sending a much higher volume of messages than in the past.

This error code is part of anti-spam filtering in Microsoft 365 or Office 365. You'll get this error when the source IP address that's sending you email changes **significantly** from its previously-established patterns. This part of a filtering technique known as _graylisting_: when new senders appear, they're treated more suspiciously than senders with a previously-established history of sending email messages (think of it as a probation period).

This error response is called _IP throttling_, and it can help reduce the amount of spam that you receive.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-do-i-fix-this)|
|fix-this)|

## I got this bounce message. How do I fix it?

If you received this NDR in response to a message that you sent, try the following steps:

1. If your organization uses Exchange Online Protection (EOP) as part of Microsoft 365 or Office 365 or standalone EOP subscription, an email admin can use the steps in the next section to fix the problem.

2. If your organization does not use EOP (for example, if you provide a third-party service), the error will resolve itself as you establish an email sending history with Microsoft 365 or Office 365 over a period of a few days.

If the problem continues, send the bounce message to your email admin for assistance and refer them to the information in this topic.

## I'm an email admin. How do I fix this?

To remove throttling for these messages, you need to configure a connector:

1. If you're trying to relay outbound email from your on-premises email server through Microsoft 365 or Office 365, you need to configure a connector from your email server to Microsoft 365 or Office 365. For more information, see [Set up connectors to route mail between Microsoft 365 or Office 365 and your own email servers](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-to-route-mail).

2. If inbound email to your Microsoft 365 or Office 365 organization is first routed through a third-party service, appliance, or device, you need to [set up a connector to apply security restrictions](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/set-up-connectors-for-secure-mail-flow-with-a-partner).

After you have set up a connector, you can monitor if IP throttling has stopped.

> [!NOTE]
> We don't recommend sending more than test messages from your initial onmicrosoft.com domain. Email from onmicrosoft.com domains is limited and filtered to prevent spam. In typical production environments, you need to [add a custom domain](/microsoft-365/admin/setup/add-domain) and then send your regular volume of email messages. For more information on domains, check out this [Domains FAQ](/microsoft-365/admin/setup/domains-faq).

## Still need help with error code 451 4.7.500-699 (ASxxx)?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
