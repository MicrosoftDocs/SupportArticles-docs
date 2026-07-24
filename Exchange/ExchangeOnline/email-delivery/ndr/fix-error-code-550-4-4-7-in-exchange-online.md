---
title: Fix NDR error 550 4.4.7 in Exchange Online
ms.date: 07/24/2026
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
search.appverid:
- BCS160
- MOE150
- ZOL120
- ZOL140
- ZOL150
- ZOL160
- MET150
description: Learn how to fix email issues for error code 550 4.4.7 in Exchange Online (the destination email server won't or can't accept the message).
ai-usage: ai-assisted
---

# Fix NDR error "550 4.4.7" in Exchange Online

## Summary

This article explains how to troubleshoot Exchange Online NDR 550 4.4.7, a persistent transient failure that occurs when Exchange Online can't deliver a message after repeated attempts and the message eventually expires in the queue. Common causes include destination mail servers that are unavailable or rejecting connections, DNS or MX record misconfigurations, network connectivity problems, Sender Policy Framework (SPF) configuration issues, hybrid mail flow problems, or temporary directory inconsistencies that prevent recipient resolution. The article provides guidance for both users and administrators to identify whether the issue originates in the destination domain or the sending environment and outlines steps to verify mail flow, DNS configuration, and hybrid deployment settings.

## Why did I get this bounce message?

For more information, see the [Causes for error code 4.4.7](#causes-for-error-code-447) section later in this article.

Use the information in the NDR to help you decide how to fix the problem.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How do I fix this?](#im-an-email-admin-how-do-i-fix-this)|:::image type="icon" source="media/help-icon.png":::|[Causes for error code 4.4.7](#causes-for-error-code-447)|

## I got this bounce message. How do I fix it?

This section contains the steps that you can try to fix the problem yourself.

If the steps in this section don't fix the problem, contact your email admin and refer them to this article so they can try to resolve the issue.

If you get this error only for messages that you sent to a specific domain (for example, only recipients in the @fabrikam.com domain), the problem is likely with that destination domain. For example:

- Temporary network or internet connection issues in the destination domain.
  
- Incorrect DNS record of the destination domain. For example, the MX record of the domain might be missing or incorrect.
  
- Aggressive anti-spam settings in the destination domain that block legitimate senders (for example, all senders from any domain in Exchange Online).

If you suspect a problem with the destination domain, notify the recipient (by phone, in person, and so on) with the following information in the NDR so they can notify their email admins:

- The name of the email mail server in the destination domain, and the error message that's returned by the email server
  
- Copy of the NDR received.

The email admins in the destination domain need to investigate the issue. Possible solutions might include:

- Stop blocking messages from Exchange Online or specifically allow messages from senders in your domain.
  
- Check the MX and other DNS records are configured properly. Administrator of the destination domain can test the MX record by using the **Outbound SMTP Email** test in the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

## I'm an email admin. How do I fix this?

If the admins in the destination domain determine the problem isn't on their end, the solution might be related to the configuration of your Exchange Online organization (or also your on-premises Exchange organization if you're in a hybrid deployment).

Try these steps:

- **Solution 1**: Test your organization's ability to send mail by using the **Outbound SMTP Email** test in the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

- **Solution 2**: The Sender Policy Framework (SPF) record for your domain might be incomplete, and might not include all email sources for your domain. For more information, see [Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing).

- **Solution 3**: Your domain might have expired due to non-payment. Verify with your domain registrar that your domain is active and not expired.

- **Solution 4**: If the recipient is in your on-premises Exchange organization in a hybrid deployment, there might be a problem with your hybrid configuration. Give the information in the NDR to your on-premises Exchange administrators. They might need to rerun the Hybrid Configuration Wizard due to changes in their on-premises IP addresses or firewall rules.

For more information about message routing in hybrid deployments, see [Transport routing in Exchange hybrid deployments](/exchange/transport-routing).

## Causes for error code 4.4.7

When Exchange Online attempts to deliver a message, the destination email might be unable or unwilling to accept the message. This condition can result in a temporary 4_.x.x_ error code from the destination email server (instead of a permanent 5._x.x_ error code that indicates the message was rejected). Exchange Online repeatedly tries to deliver the message over 24 hours. Only after 24 hours of unsuccessful delivery attempts does a recipient receive this NDR.

The possible causes of this error are:

- The destination email server is offline or unreachable.

- The server won't accept delivery of the message.

- A network problem is causing message delivery to time out.

- Incorrect DNS record of the destination domain. For example, the MX record of the domain might be missing or incorrect.

If you receive 4.4.7 NDR with "Transient Failure during recipients lookup **AmbiguousRecipientTransientException**" error, it indicates Exchange Online couldn't uniquely resolve the recipient object. Exchange found multiple possible directory objects matching the same recipient, and the ambiguity is treated as a transient condition.

Common causes include:
- Duplicate mail-enabled objects in Entra ID / Exchange Online:

  - Mailbox and MailUser sharing the same SMTP address.
  - Mailbox and Mail Contact with the same proxy address.
  - Duplicate MailUsers or guest user created during migration.

- Hybrid directory synchronization issues:
  
    - Object exists in both on-premises and Exchange Online with overlapping proxy addresses.

- Duplicate or conflicting proxy addresses:

  - Same SMTP address present on multiple recipients.
  - X500, SIP, or other proxy address conflicts in some scenarios.

- Temporary directory inconsistency:
  - Recent recipient changes aren't fully propagated through the service.


## Details for error code 4.4.7

The NDR from Exchange Online for this specific error might contain some or all of the following information:

- **User information section**

  - The server tries to deliver this message but can't. It stops trying. Try sending this message again. If the problem continues, contact your help desk.

- **Diagnostic information for administrators section**

  - `#550 4.4.7 QUEUE.Expired; message expired ##`

  - The rejecting system considers the message too old, either because it remained on that host too long or because the time-to-live value specified by the sender of the message was exceeded.

  - `450 4.7.0 Proxy session setup failed on Frontend with '451 4.4.0 Primary target IP address responded with ...` Be sure to record the error that follows this string and the last end point attempted.

## Still need help with error code 4.4.7?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
