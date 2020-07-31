---
title: Cannot move the items error when you move items from Outlook 2013 to an EAS store
description: Provides a workaround for an issue in which you can't use Outlook 2013 to move emails or calendar items from a .pst file, IMAP store, Exchange mailbox, or EAS store to another EAS store.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: aruiz, gbratton
appliesto:
- Outlook 2013
search.appverid: MET150
---
# Error when you move items from an Outlook 2013 client to an EAS store: Cannot move the items

_Original KB number:_ &nbsp;2781261

## Symptoms

When you use Microsoft Outlook 2013 to move email message items from an Outlook data file (.pst file), an Internet Message Access Protocol (IMAP) store, an Exchange mailbox, or an Exchange ActiveSync (EAS) store to another EAS store, you can't move the email message items. Additionally, you receive the following error message:

> Cannot move the items. The folders you are trying to change do not support this operation. Sorry, Exchange ActiveSync doesn't support what you're trying to do.

## Cause

This issue occurs because the EAS 14.0 protocol that's used by the EAS store doesn't support moving email message items to an EAS store.

> [!NOTE]
> Because of this limitation of the EAS 14.0 protocol, content in the Drafts folder of an `Outlook.com` account can't be synced to an Outlook 2013 client.

## Workaround

To work around this issue, configure the Outlook Hotmail Connector in Outlook 2007 or in Outlook 2010 to move email message items to an EAS store.

## More information

Outlook 2013 uses EAS 14.0 to connect to `Outlook.com` accounts (@hotmail.com, @msn.com, @live.com, and @outlook.com).
