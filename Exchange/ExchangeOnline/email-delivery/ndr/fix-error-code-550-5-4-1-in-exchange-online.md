---
title: Fix NDR error code 550 5.4.1 in Exchange Online
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
ms.assetid: 7dcf7a8b-e00e-49f8-bf8d-74aba79c5a6a
description: Learn how to fix email issues for error code 5.4.1 in Exchange Online (the destination email server doesn't accept email from the sender's domain).
---

# Fix NDR error "550 5.4.1" in Exchange Online

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 5.4.1 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

## Why did I get this bounce message?

The email server that's generating the error doesn't accept email from the sender's domain (for example, @fabrikam.com). This error is generally caused by email server or DNS misconfiguration.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this?](#im-an-email-admin-how-can-i-fix-this)|

## I got this bounce message. How do I fix it?

Here are some steps that you can try to fix the problem yourself.

If the steps in this section don't fix the problem for you, contact your email admin and refer them to the information in this topic so they can try to resolve the issue for you.

- **Just wait**: It might seem strange, but this error might go away on its own after a few days. If your email admin made changes to your organization's domain name system (DNS) records, the change can prevent you from sending and receiving email for a brief period, even if they did everything correctly (it can take up to 72 hours for DNS changes to propagate on the internet). If you'd like more details about DNS records, see [DNS basics](https://support.microsoft.com/office/854b6b2b-0255-4089-8019-b765cff70377).

- **Service outage**: A problem with the whole Microsoft 365 or Office 365 service could be causing the problem. Even your email admins can't do anything about service outages except wait for the problem to be resolved.

## I'm an email admin. How can I fix this?

The most common issues and fixes are described in the following sections.

### Incorrect MX record

If external senders receive this NDR when they send email to recipients in your domain, try the following fixes:

- **Fix your MX record**: For example, it might be pointing to an invalid mail server. Check with your domain registrar or DNS hosting service to verify the MX record for your domain is correct. The MX record for a domain that's enrolled in Exchange Online uses the syntax  _\<domain\>_.mail.protection.outlook.com.

- **Verify only one MX record is configured for your domain**: We don't support using more than one MX record for domains enrolled in Exchange Online.

- **Test your MX record**: Use the **Outbound SMTP EMail** test in the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

### Domain configuration issues

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com).

2. Click **Domains** and verify your domain appears in the list as **Active**.

3. Select the domain and click **Troubleshoot**. Follow the troubleshooting wizard steps.

If you control of the DNS records for your Microsoft 365 or Office 365 domain, you can also check the status of the domain in the Exchange admin center (EAC) by following these steps:

1. In the Microsoft 365 admin center, click **Admin** \> **Exchange**.

2. Click **Mail flow** \> **Accepted domains**.

3. Verify that your domain is listed, and verify the **Domain Type** value for the domain. Typically, the value should be **Authoritative**. However, if you have properly configured a shared domain, the value might be **Internal Relay**.

### Updated DNS records haven't propagated

You updated your domain's DNS records correctly for Microsoft 365 or Office 365, but the changes haven't propagated to all DNS servers on the internet. Changes to your domain's DNS records might take up to 72 hours to propagate to all DNS servers on the internet.

### Hybrid deployment configuration issues

If your domain is part of a hybrid deployment between on-premises Exchange and Exchange Online, check the following items:

- Verify the configuration of the Send connectors and Receive connectors in your on-premises Exchange organization that are used for hybrid. These connectors are configured automatically by the Hybrid Configuration Wizard, and the wizard might need to be run again by your Exchange administrator.

For more information, see [this topic](../../../ExchangeHybrid/hybrid-configuration-wizard-errors/relay-access-denied-attr36-ndr.md).

For more information about transport routing in hybrid deployments, see [Transport Routing in Exchange Hybrid Deployments](/exchange/transport-routing).

### Service issues in Exchange Online

A service issue in Microsoft 365 or Office 365 might be causing the problem. To check the status of Microsoft 365 or Office 365, do the following steps:

1. Open the [Microsoft 365 admin center](https://admin.microsoft.com).

2. Click **Service health** to see an overview of any issues.

3. Select **View all** to a get more details about all known issues.

## Details about this NDR

The Exchange Online non-delivery report (NDR) notification for this specific error might contain some or all of the following information:

- **User information section**

  - Relay Access Denied

  - The outbound connection attempt was not answered because either the remote system was busy or it was unable to take delivery of the message.

- **Diagnostic information for administrators section**

  - No answer from host.

  - `#550 5.4.1 Relay Access Denied ##`

## Still need help?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)

[Use Directory-Based Edge Blocking to reject messages sent to invalid recipients in Exchange Online](/exchange/mail-flow-best-practices/use-directory-based-edge-blocking)
