---
title: Inbox rule to redirect messages not working
description: Describes a scenario in which messages are delivered to the user and to a forwarding address but not to the redirecting address that's specified in an inbox rule.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Inbox rule to redirect messages doesn't work if forwarding is set up on a mailbox

_Original KB number:_ &nbsp; 3069075

## Symptoms

Consider the following scenario:

- You use the `Set-Mailbox` cmdlet together with the `DeliverToMailboxAndForward $True` parameter to specify that email messages that are sent to a particular user are delivered both to that user's mailbox and to another address.

    For example, you run the following command so that messages that are addressed to Sally are delivered to Sally's mailbox and are also forwarded to Manuel's mailbox.

    ```powershell
    Set-Mailbox sally@contoso.com -ForwardingSmtpAddress manuel@contoso.com -DeliverToMailboxAndForward $True
    ```

- The user creates an inbox rule in Microsoft Outlook to redirect messages that they receive. For example, Sally creates a rule in Outlook to redirect messages to another address.

In this scenario, when a message is sent to the first user, the message is delivered to that user and to the forwarding address. However, the message is not delivered to the redirecting address.

## Cause

This is expected behavior. Forwarding on a mailbox overrides an inbox redirection rule. To enable the redirection rule, remove forwarding on the mailbox.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
