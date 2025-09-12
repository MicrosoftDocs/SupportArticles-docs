---
title: A transport rule doesn't match if user mailbox rules automatically forward messages
description: The transport rule doesn't honor the exclusions, and it rejects the messages. This article provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CI 116057
  - CSSTroubleshoot
ms.reviewer: arindamt, v-six
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 01/24/2024
---
# A transport rule doesn't match if user mailbox rules automatically forward messages

## Symptoms

You create an Exchange transport rule to control the behavior of messages that have been automatically forwarded by users in your organization. If users create a mailbox rule to automatically forward messages, the transport rule doesn't match when the forwarded messages are sent.

## Cause

The transport rule logic to evaluate the sender of an automatic forwarding message was recently changed. The Sender address for forwarded mail is now the original sender and no longer the forwarder.

This change to the logic was made because, under certain circumstances, the Exchange transport rule would match the sender address against the message envelope instead of the message's header. This change makes sure that transport rule matching is always applied correctly whether the sender's address is stored in the message header or in the message envelope.

## Resolution

To maintain the behavior of transport rules, change the **Match sender address in message** setting from **Header** to **Header or envelope**:

1. In the Exchange Admin Center, go to **Mail flow** > **Rules**.
2. Double-click the affected rule in the list, and then locate the **Match sender address in message** heading.
3. In the list under this heading, select **Header or envelope**.

   :::image type="content" source="media/autoforward-mail-exclusions-not-honored-transport-rule/transport-rule-error.png" alt-text="Screenshot of selecting Header or envelope.":::

> [!NOTE]
> 
> - Mail flow rules are used to match auto-forward messages based on their message class (`IPM.note.forward`). However, if the forwarding is set up through Outlook on the web (`ForwardingSmtpAddress`) or by admins on the properties of the mailbox (`ForwardingAddress`), the message class is normal (`IPM.Note`), and transport rules won't detect them. For more information about automatic forwarding, see [All you need to know about automatic email forwarding in Exchange Online](https://techcommunity.microsoft.com/t5/exchange-team-blog/all-you-need-to-know-about-automatic-email-forwarding-in/ba-p/2074888).
> - This change also affects the mailbox redirect rule, because the sender that's evaluated by the transport rule is now the original sender, and not the mailbox on which the rule is set. To maintain the behavior of this rule, set the exception in the transport rule based on the recipient instead of the sender. Alternatively, change this rule to an automatic forwarding rule.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
