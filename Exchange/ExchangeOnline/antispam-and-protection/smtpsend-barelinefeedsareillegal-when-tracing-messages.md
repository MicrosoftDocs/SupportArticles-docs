---
title: SMTPSEND BareLineFeedsAreIllegal when tracing a message
description: Describes a scenario in which Exchange Online users or Exchange Online Protection users receive an NDR that contains a SMTPSEND.BareLinefeedsAreIllegal error.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: delaja, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
search.appverid: MET150
ms.date: 01/24/2024
---
# SMTPSEND.BareLineFeedsAreIllegal NDR received by Exchange Online or EOP users in Office 365 Dedicated/ITAR

_Original KB number:_ &nbsp; 2998901

## Symptoms

Users of Exchange Online or Exchange Online Protection may not receive an expected email message. If you perform a trace on the message, you find that message delivery failed and that a nondelivery report (NDR) that contains the following error message was generated:

> SMTPSEND.BareLinefeedsAreIllegal; message contains bare linefeeds, which cannot be sent via DATA

Users may not have experienced this problem in the past when they used Forefront Online Protection for Exchange (FOPE).

## Cause

This issue occurs if the source message transfer agent (MTA) didn't append the expected CR-LF combination to the end of the message as documented in Request For Comments (RFC) 2822.

## Resolution

To resolve this issue, do one of the following, as appropriate for your situation:

- Request that the sender correct the message format. This error frequently occurs with automated mailers (for example, reports or invoices) and bulk senders.
- Enable Extended SMTP (ESMTP) on the receiving server so that the message can be sent by using `CHUNKING` or the `BDAT` command. Neither of these methods depends on the CR-LF combination to signal the end of the message. For more information, see [SMTP protocol extensions](/previous-versions/tn-archive/bb123786(v=exchg.65)).
- If the sender cannot correct the sent messages, or if the gap must be bridged until the message format is corrected, the recipient can create an inbound transport rule to append a disclaimer to the messages from the problematic sender. The disclaimer will append the expected CR-LF combination to the message so that it can be delivered. (This disclaimer may consist of a single character such as a period or a dash.)

## More information

For more information about how to perform a message trace, see [Trace an email message](/exchange/monitoring/trace-an-email-message/trace-an-email-message).

For more information about how to create disclaimers, see [Organization-wide disclaimers, signatures, footers, or headers](/Exchange/organization-wide-disclaimers-signatures-footers-or-headers-exchange-2013-help).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
