---
title: Email messages redirected from one mailbox to another mailbox are marked as spam
description: Redirected messages are moved to the Junk folder or to a hosted quarantine.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: rrajan
appliesto: 
- Exchange Online
search.appverid: MET150
---

# Email messages redirected from one mailbox to another mailbox through an Inbox rule are marked as SPAM

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;4490155

## Symptoms

In Exchange Online, some email messages that are redirected from one mailbox to another mailbox through an Inbox rule are marked as SPAM. Then, these messages are either moved to the Junk folder or to a hosted quarantine.

Additionally, when you try to see a result through a message trace, you notice a status setting of **FilteredAsSpam**. Also, in the message header information, you may notice that Spam Filtering Verdict (SFV) indicates non-spam, but the Spam Confidence Level (SCL) is set to **9**.

## Cause

This issue occurs for one of the following reasons:

- The advanced spam filtering (ASF) option of **SPF record: hard fail** is enabled within the default policy that's applied to all the recipients.
- You have the **SPF record: hard fail** option enabled within the SPAM filter policy that's applied to the recipient.

> [!NOTE]
> If mail is redirected through an Inbox rule, the mail from SMTP address changes to the primary SMTP address of the user who has the redirect Inbox rule. Then, the SPF check is run against the mail from domain suffix. The IP address that's used for the check is the IP address of the original sender.

## Resolution

To resolve this issue, use one of the following options, as appropriate for your situation.

### Option 1

Disable **SPF record: hard fail** under the ASF options.

### Option 2

If all the email messages are redirected through an Inbox rule, you can disable this rule and enable forwarding at the mailbox level. To do this, run the following cmdlet:

`Set-Mailbox -identityUserA@domain.com-ForwardingAddress &#39UserB#39; -DeliverToMailboxAndForward $false`

### Option 3

You can create a new SPAM filter policy that has the same settings as those in the policy in which the ASF option of **SPF record: hard fail**  is enabled. To do this, you have to make sure that the ASF option of **SPF record: hard fail** is disabled in the new policy. Then, you can associate the policy to the user who is experiencing the issue.

1. In the Exchange admin center, locate **Protection** > **spam filter**.
2. Click the plus sign (+) icon to create a new policy, and then specify the details for the policy.
3. Make sure that the ASF option of **SPF record: hard fail** is left disabled.
4. In the **Applied To** section, add the recipient who is experiencing the issue.
