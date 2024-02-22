---
title: New-MailboxSearch creates a folder hierarchy in Exchange Server 2010
description: Fixes an issue in which the New-MailboxSearch cmdlet creates a folder hierarchy of all mailboxes that are searched in the target mailbox in an Exchange Server 2010 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: sidd, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# New-MailboxSearch creates a folder hierarchy of all mailboxes in Exchange Server 2010

_Original KB number:_ &nbsp;2846860

## Symptoms

Consider the following scenario:

- You use the `New-MailboxSearch` cmdlet to create a mailbox search in a Microsoft Exchange Server 2010 organization.
- You run the cmdlet with the *ExcludeDuplicateMessages* parameter.
- The *ExcludeDuplicateMessages* parameter is set to false.
- You do the search across all the mailboxes in the organization.

    > [!NOTE]
    > The searches are performed across all mailbox servers in the Exchange organization unless you specify the *SourceMailboxes* parameter.

In this scenario, the `New-MailboxSearch` cmdlet creates a folder hierarchy of all the mailboxes that match the search criteria in the target mailbox.

:::image type="content" source="media/new-mailboxsearch-creates-folder-hierarchy/folder-hierarchy.png" alt-text="Screenshot for the folder hierarchy of all the matched mailboxes.":::

## Cause

This behavior is by design.

## More information

If the *ExcludeDuplicateMessages*  parameter is set to False, the `New-MailboxSearch` cmdlet returns a list of all mailboxes that match the search criteria. To prevent a folder hierarchy of all the mailboxes that match the search criteria in the target mailbox from being created, set the *ExcludeDuplicateMessages* parameter to true. For example:

```powershell
New-MailboxSearch -Name "NewSearch" -SearchQuery '"Team meet"' -TargetMailbox "administrator" -ExcludeDuplicateMessages:$True -LogLevel:Full
```

> [!NOTE]
> The *SearchQuery* parameter specifies a search string or a query that's formatted by using Advance Query Syntax (AQS). If this parameter is empty, all messages from all mailboxes that are specified in the *SourceMailboxes* parameter are returned.

The *LogLevel* parameter is used to log the search results to CSV files. The CSV files will contain the list of mailboxes that match the search criteria. The CSV file will be created multiple times as the search is in progress, and each CSV file will be delivered in a separate email message.
