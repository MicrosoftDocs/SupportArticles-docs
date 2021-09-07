---
title: Messages that have an SCL rating of 5 or higher are delivered to the Inbox instead of to the Junk Email folder in Outlook in Exchange Online
description: Describes expected behavior in Exchange Online in which messages that have an SCL of 5 or higher are delivered to the Inbox instead of to the Junk Email folder in Outlook.
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

# Messages that have an SCL rating of 5 or higher are delivered to the Inbox instead of to the Junk Email folder in Outlook in Exchange Online

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;3009297

## Problem

Email messages that have a spam confidence level (SCL) rating of 5 or higher and that you therefore expect to be delivered to the Junk Email folder in Microsoft Outlook are delivered to the Inbox folder instead in Microsoft Exchange Online.

## Cause

This behavior occurs if the affected mailbox is also used as the delivery location for undeliverable journal reports.

## More information

This behavior is by design. Mail that's sent to an address that's used for undeliverable journal reports won't be journaled. Transport rule settings and mailbox rule settings don't apply to these messages. We recommended that you create a dedicated mailbox for undeliverable journal reports.

For more information about how to examine the SCL and other properties of an email message in Microsoft Office 365, see the [Introducing Message Analyzer, an SMTP header analysis tool in Microsoft Remote Connectivity Analyzer](https://techcommunity.microsoft.com/t5/exchange-team-blog/introducing-message-analyzer-an-smtp-header-analysis-tool-in/ba-p/594345) blog post.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
