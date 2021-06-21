---
title: Domains on Outlook Safe Senders list not recognized
description: Describes an issue in which messages that you receive in Exchange Online or Exchange Online Protection are blocked as junk or spam even though you enabled the Never Block Sender's Domain option in Outlook.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: chrisng
appliesto:
- Exchange Online
- Exchange Online Protection
search.appverid: MET150
---
# Domains on the Outlook Safe Senders list aren't recognized by Exchange Online or Exchange Online Protection

_Original KB number:_ &nbsp; 3019657

## Symptoms

Messages that you receive in Exchange Online or Exchange Online Protection are blocked as junk or spam even though you enabled the **Never Block Sender's Domain**  option in Microsoft Outlook.

## Cause

Currently, safe domains are not recognized by default in Exchange Online or in Exchange Online Protection. Blocked domains, blocked sender addresses, and safe sender addresses *are* recognized.

## Resolution

Use one of the following methods, as appropriate for your situation:

- For stand-alone Exchange Online Protection

  For safe sender and blocked sender lists to be respected, directory synchronization must be enabled. By default, safe domains are not synced through directory synchronization. You can modify the configuration to have safe domains synced to Exchange Online and recognized. For more information about how to do this, see [Configure content filtering to use safe domain data](/exchange/configure-content-filtering-to-use-safe-domain-data-exchange-2013-help).

- For Exchange Online

  By default, safe domains are not recognized in Exchange Online. This is by design. As a workaround, admins can create a domain-based safe sender by using Exchange transport rules.

> [!NOTE]
> Using either of these configurations may result in increased spam, as domains can easily be spoofed by spammers.

## More information

For more information, see:

- [Use Junk Email Filters to control which messages you see](https://support.microsoft.com/office/use-junk-email-filters-to-control-which-messages-you-see-274ae301-5db2-4aad-be21-25413cede077)
- [Overview of the Junk Email Filter](https://support.microsoft.com/office/overview-of-the-junk-email-filter-5ae3ea8e-cf41-4fa0-b02a-3b96e21de089)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/)
