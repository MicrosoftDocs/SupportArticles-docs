---
title: Blank lines are truncated when moved to PST files
description: If blank lines are truncated when a message is moved from online mode to a PST file, change Outlook to Cache mode.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: michxu, rschaffr, v-six
appliesto: 
  - Exchange Online
  - Exchange Server
search.appverid: MET150
ms.date: 01/24/2024
---
# Blank lines are truncated when a message is moved from online mode to a PST file

_Original KB number:_ &nbsp; 4013805

## Symptoms

When Outlook is configured in Online mode, if an autoforwarded message contains blank lines or multiple nonbreaking spaces, the lines or spaces are truncated when the message is moved from the mailbox to local PST files.

This issue also happens to email messages in online archive mailboxes.

## Workaround

To work around this issue, change Outlook to Cache mode. To do this, refer to [Turn on Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c).
