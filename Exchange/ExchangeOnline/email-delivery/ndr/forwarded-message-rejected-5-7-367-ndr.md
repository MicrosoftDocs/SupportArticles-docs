---
title:  5.7.367 Microsoft 365 relay pool issues in downstream gateways
description: "Fix Microsoft 365 relay errors: Learn how to resolve NDR 5.7.367 caused by SPF or DKIM authentication failures in forwarded or relayed email messages."
#customer intent: As an IT admin, I want to understand why forwarded or relayed email messages that are sent through Microsoft 365 are rejected by non-Microsoft gateways so that I can resolve delivery failures.
author: cloudwriter
ms.author: meerak
manager: dcscontentpm
ms.reviewer: arindamt, v-kccross
audience: ITPro
ms.date: 03/25/2026
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 10417
appliesto: Exchange Online
search.appverid: MET150
---

# Forwarded or relayed email messages from Microsoft 365 are rejected with error 5.7.367

## Summary

When Exchange Online forwards or relays email messages, you receive a nondelivery report (NDR) that mentions error code "5.7.367" and "Remote server returned not permitted to relay." This problem occurs more frequently in mail flows that include non-Microsoft gateways.

## Symptoms

You experience intermittent failures when you autoforward or relay email messages through Microsoft 365. When you forward an email message, you receive an NDR that includes an error message that resembles the following message:

>550 5.7.367 Remote server returned not permitted to relay -\> 554 5.7.1 Relaying denied

Additionally, you experience the following symptoms:

- The non-Microsoft receiving gateway (for example, Proofpoint or Barracuda) rejects forwarded or relayed email messages.

- The message trace shows the following information:

  - "550 5.7.367 Remote server returned not permitted to relay"

  - The value of the [`OutboundIpPoolName`](/defender-office-365/outbound-spam-high-risk-delivery-pool-about#find-out-which-outbound-pool-was-used) property is `RegularRelayOutboundPool` for failed messages.

- Non-Microsoft gateway logs show "relay denied" error messages.

- The result of the Sender Policy Framework (SPF) authentication check is `fail` or `softfail` when the message enters the Microsoft 365 environment. The result of other authentication methods, such as DomainKeys Identified Mail (DKIM) and Domain-based Message Authentication, Reporting, and Conformance (DMARC) is `pass` or `fail`, depending on the sender.

### Example 1 – SPF Softfail, No DKIM

> Authentication-Results: spf=softfail (sender IP is \<*IP address*\>)
>
> smtp.mailfrom=contoso.com; dkim=none (message not signed)
>
> header.d=none;dmarc=fail action=none header.from=contoso.com;

### Example 2 – SPF Softfail, DKIM Fail

> Authentication-Results: spf=softfail (sender IP is \<*IP address*\>)
>
> smtp.mailfrom=proseware.com ; dkim=fail (body hash did not verify)
>
> header.d=proseware.com ;dmarc=fail action=none header.from=proseware.com;

## Cause

When Microsoft 365 forwards or relays a message on behalf of an external sender, Exchange Online must decide which [**outbound delivery pool**](/defender-office-365/outbound-spam-high-risk-delivery-pool-about) to use.

To prevent abuse, such as spoofing, phishing, and other email attacks, Microsoft 365 might use a specific strategy. It might forward or relay messages from a relay pool IP address instead of from an IP address that's from the standard outbound IP address range. Exchange Online is more likely to send a message from a relay pool when [email authentication](/defender-office-365/email-authentication-about) fails at the time that the message enters the Microsoft 365 environment.

> [!NOTE]
> The relay pool isn't published because it can change often. Also, it's not part of the published SPF record for Microsoft 365. The relay pool isn't part of the Microsoft 365 outbound IP address ranges.

Destinations don't consider Microsoft 365 to be the sender of email messages that are sent from the relay pool. Downstream mail gateways often block or restrict these messages. This behavior causes relay-denied errors.

### Authentication requirements to avoid relay pool

To avoid being sent through the relay pool, the forwarded or relayed email message should meet at least one of the following criteria:

- The sender of the outbound message is in an [accepted domain](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains) of the tenant.

- SPF passes when the email message enters the Microsoft 365 environment.

- DKIM on the sender’s domain passes when the message arrives at Microsoft 365.

If none of these conditions are met, the message might be routed through the relay pool.

## Resolution

### Make sure that sender authentication passes

When an inbound email message is routed through a non-Microsoft gateway, such as Proofpoint or Barracuda, the SPF status is fail or softfail before the message reaches Microsoft 365. This condition occurs because Exchange Online evaluates SPF by using the gateway IP address instead of the original sender IP address.

If the MX record for your domain points to a non-Microsoft service or an on-premises email server, use [Enhanced Filtering for Connectors](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/enhanced-filtering-for-connectors). Enhanced Filtering makes sure that SPF validation is correct for inbound mail, and it avoids sending email messages through the relay pool.

### Use accepted domains if possible

If the sender of the forwarded email message belongs to a domain that you control, add the domain as an [accepted domain](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains) in Microsoft 365.

### Avoid multiple hops and autoforwarding if possible

Complex relay chains increase the likelihood of authentication failures and relay pool use.

[!INCLUDE [third-party-information-disclaimer](../../../../includes/third-party-information-disclaimer.md)]
