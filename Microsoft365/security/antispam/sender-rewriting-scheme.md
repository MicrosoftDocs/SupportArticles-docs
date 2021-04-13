---
title: Sender Rewriting Scheme (SRS) in Office 365
description: Describes Sender Rewriting Scheme (SRS) in Office 365.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Exchange Online
search.appverid: MET150
---

# Sender Rewriting Scheme (SRS) in Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;4490129

## Summary

Sender Rewriting Scheme (SRS) functionality was added to Office 365 to resolve a problem in which autoforwarding is incompatible with SPF. The SRS feature rewrites the **P1 From** address (also known as the Envelope From address) for all applicable messages that are sent externally from Office 365. It is important to note that the **From** header (also known as the Display From address or P2 From address) that is displayed by email clients remains unchanged.

This SRS change improves deliverability of applicable messages that pass Sender Policy Framework (SPF) checks when they arrive from the original sender but that then fail SPF at the final external destination after they are forwarded.

SRS rewrites the **P1 From** address in the following scenario:

- Messages that are autoforwarded (or redirected) in Office 365 by using any of the following methods to forward a message to an external recipient:
  - SMTP forwarding*
  - Mailbox Rule (or Inbox rule) redirection
  - Transport Rule redirection
  - Groups or DLs that have external members
  - Mail Contact forwarding
  - Mail User forwarding
- Messages that are autoforwarded (or redirected) from our customer's on-premises environments and relayed through Office 365.

*Some messages forwarded with SMTP Forwarding will not be rewritten with SRS as they have already been rewritten.

> [!NOTE]
> SRS rewriting does not fix the issue of DMARC passing for forwarded messages. Although an SPF check will now pass by using a rewritten **P1 From** address, DMARC also requires an alignment check for the message to pass. For forwarded messages, DKIM always fails because the signed DKIM domain does not match the **From** header domain. If an original sender sets their DMARC policy to reject forwarded messages, the forwarded messages are rejected by Message Transfer Agents (MTAs) that honor DMARC policies.  

This change causes Non-Delivery Reports (NDRs) to return to Office 365 instead of the original sender, as they would do if SRS were not used. Therefore, part of the SRS implementation is to reroute returning NDRs to the original sender if a message cannot be delivered.  

> [!NOTE]
> SRS rewriting is used to prevent spoofing of unverified domains. Customers are advised to send messages only from domains that they own and for which they have verified their ownership through the Accepted Domains list. For more information about Accepted Domains in Office 365, see the following TechNet topic:
>  
> [Manage accepted domains in Exchange Online](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains)

## More information

### Autoforwarding emails for an Office 365-hosted mailbox

A message that is autoforwarded for a hosted mailbox by mechanisms such as SMTP forwarding or Mailbox Rule redirection or Transport Rule redirection have the **P1 From** address rewritten before the message leaves Office 365. The address is rewritten by using the following pattern:

```powershell
<Forwarding Mailbox Username>+SRS=<Hash>=<Timestamp>=<Original Sender Domain>=<Original Sender Username>@<Forwarding Mailbox Domain>
```

Example:

A message is sent from Bob (bob@fabrikam.com) to John's mailbox in Office 365 (john.work@contoso.com). John has set up autoforwarding to his home email address (john.home@example.com).

||Original message|Autoforwarded message|
|---|---|---|
| **Recipient**|john.work@contoso.com|john.home@example.com |
| **P1 From**|bob@fabrikam.com|john.work+SRS=44ldt=IX=fabrikam.com=bob@contoso.com|
| **From header**|bob@fabrikam.com|bob@fabrikam.com|

> [!NOTE]
> SRS rewriting causes the username part of an email address increasing in length. However, the email address has a limit of 64 characters. If the email address involves the SRS rewriting and exceeds 64 characters, the rewritten SRS address will take the form of "bounces" below.

### Relaying from a customer's on-premises server

A message that is relayed from a customer's on-premises server or application through Office 365 from a non-verified domain has the **P1 From** address rewritten before it leaves Office 365. The address is rewritten by using the following pattern:

```powershell
bounces+SRS=<Hash>=<Timestamp>@<Default Accepted Domain>
```

> [!IMPORTANT]
> In order to receive NDRs for relayed messages that are rewritten by SRS, a mailbox (either hosted or on-premises) must be created by using the username of "bounces" and by having the domain be set as the default Accepted Domain of the customer.

Example

A message is sent from Bob (bob@fabrikam.com) to John's mailbox (john.onprem@contoso.com) on his company's own server that is running Exchange Server. John has set up autoforwarding to his home email address (john.home@example.com).

|Type|Original message|Relayed message received by Office 365|Relayed message sent from Office 365|
|---|---|---|---|
|Recipient|john.onprem@contoso.com|john.home@example.com|john.home@example.com|
|P1 From|bob@fabrikam.com|bob@fabrikam.com|bounces+SRS=44ldt=IX@contoso.com|
|From header|bob@fabrikam.com|bob@fabrikam.com|bob@fabrikam.com|


Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.