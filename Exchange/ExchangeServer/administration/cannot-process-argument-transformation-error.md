---
title: Cannot process argument transformation error
description: You may get the Cannot process argument transformation error when you run some cmdlets in Exchange Server 2013 that has Cumulative Update 11 installed.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: batre, genli
appliesto:
- Exchange Server 2013 Enterprise 
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Cannot process argument transformation error for cmdlets in Exchange Server 2013 with CU11

_Original KB number:_ &nbsp; 3140833

## Symptoms

When you use various cmdlets, scripts such as *RedistributeActiveDatabases.ps1*, or the [Queue Viewer](/exchange/queue-viewer-exchange-2013-help) from the Exchange Toolbox in an Exchange Server 2013 environment that has [Cumulative Update 11](https://support.microsoft.com/help/3099522) installed, you receive one of these error messages:

> Cannot process argument transformation on parameter 'BookmarkObject'. Cannot convert the "Microsoft.Exchange.Data.QueueViewer.PropertyBagBasedQueueInfo" value of type "System.String" to type "Microsoft.Exchange.Data.QueueViewer.ExtensibleQueueInfo".

> Cannot process argument transformation on parameter 'Identity'. Cannot convert value "\<database name>" to type "Microsoft.Exchange.Configuration.Tasks.DatabaseCopyIdParameter". Error: "Cannot convert hashtable to an object of the following type: Microsoft.Exchange.Configuration.Tasks.DatabaseCopyIdParameter. Hashtable-to-Object conversion is not supported in restricted language mode or a Data section."

Additionally, when you use from Exchange Management Shell to run the [Get-Queue](/exchange/use-the-exchange-management-shell-to-manage-queues-exchange-2013-help) cmdlet, the cmdlet may not automatically pull back the queue for the local server that the cmdlet is running on. However, when you run the `Get-Queue -Server "<Server Name>"` cmdlet, it works as expected.

## Cause

This issue occurs if you don't have a mailbox associated with your account, or if the mailbox or arbitration mailboxes are hosted on an earlier version of Exchange Server. For more information about the changes to anchor mailbox functionality, see [Exchange Management Shell and Mailbox Anchoring](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-management-shell-and-mailbox-anchoring/ba-p/604653).

## Workaround

To work around this issue, use one of the following methods:

- Associate a mailbox with the account that's trying to use the Queue Viewer on an Exchange server, and the version of the Exchange server is the same as the one that you're trying to manage.
- Move the arbitration mailbox to the version of Exchange that you're trying to manage.

> [!NOTE]
> This issue has been fixed in Cumulative Update 12 for Exchange Server 2013.
