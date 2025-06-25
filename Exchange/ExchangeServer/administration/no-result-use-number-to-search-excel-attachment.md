---
title: Can't use a number to search for an Excel attachment
description: Provides a workaround for an issue that causes no result to be displayed in Outlook or Outlook on the web. This issue occurs when you use a number to search for an Excel attachment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Clients and Mobile\Unable to Search emails in Outlook, OWA, or Mobile
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: aruiz, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# No result when you use a number to search for an Excel attachment in Outlook or Outlook on the web

_Original KB number:_ &nbsp; 3166063

## Problem

When you use a number as a keyword to search for a Microsoft Excel attachment in an Exchange Server 2016 account, no result is displayed in Outlook or Outlook on the web.

## Cause

In Exchange Server 2016 on-premises, to optimize performance and improve the occurrences of a search instance, numbers in Excel attachments aren't indexed and parsed. This is the current design for Exchange Server 2016 on-premises.

## Workaround

### Outlook 2016

If you have Outlook 2016 and you're connected to an Exchange Server 2016 on-premises mailbox by using Cached Exchange Mode, Outlook is likely using Exchange FAST search to query the mailbox. To optimize performance, Exchange FAST search shows the same behavior that's described in the Cause section.

To work around this behavior, force Outlook 2016 to use the locally cached Windows Desktop Search (WDS) index. To force Outlook to fall back to WDS search, change the search scope to Subfolders, All Mailboxes, or All Outlook Items.

### Outlook 2013 and earlier versions

If you have Outlook 2013 or an earlier version, you might have Outlook configured to connect to the Exchange email account by using online mode. To work around this behavior, you can use Outlook in Cached Exchange Mode. For more information, see [Turn on or off Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c).

## More information

Exchange Online mailboxes are not affected by the limitation described in the Problem section.
