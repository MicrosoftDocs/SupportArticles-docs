---
title: Item count from Get-MailboxStatistics shows more items
description: Describes a problem that triggers a mismatch between the mailbox item count that's returned by the Get-MailboxFolderStatistics cmdlet versus the Get-MailboxStatistics cmdlet in Exchange Online. This behavior is by design.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: benwinz, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Item count from Get-MailboxStatistics shows more items than Get-MailboxFolderStatistics

_Original KB number:_ &nbsp; 3098973

## Symptoms

Consider the following scenario.

- When you run the `Get-MailboxFolderStatistics` cmdlet on a mailbox, the number of items in each returned folder may not equal the total item count that's returned by the `Get-MailboxStatistics` cmdlet. The `Get-MailboxStatistics` cmdlet shows more items than the number that's returned by the `Get-MailboxFolderStatistics` cmdlet.
- When you run an eDiscovery search on a mailbox, the item count that's returned by the estimate option or the export option may not match the item count that's returned by the `Get-MailboxStatistics` cmdlet.

## Cause

There are some folders in a mailbox that are marked with a special Internal Access flag. These folders are reserved for Microsoft internal use and aren't visible to users or administrators in your organization. Although the folders aren't visible, the item counts of the folders are returned by the `Get-MailboxStatistics` cmdlet. This behavior is by design.

## More information

The `Get-MailboxFolderStatistics` cmdlet returns the aggregate count of folders that are visible to clients. Use the item counts in these folders to represent the total number of items that are visible to clients and to eDiscovery searches.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
