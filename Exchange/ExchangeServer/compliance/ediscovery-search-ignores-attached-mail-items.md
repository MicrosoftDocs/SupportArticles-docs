---
title: In-Place eDiscovery search doesn't search the file names of attached mail items
description: Provides a workaround for an issue in which an eDiscovery search doesn't search the file names of attached mail items.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 175754
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: svajda, batre, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# In-Place eDiscovery search doesn't search the file names of attached mail items

## Symptoms

You run an [In-Place eDiscovery search](/exchange/policy-and-compliance/ediscovery/create-searches) in a Microsoft Exchange Server 2019 environment. Your search uses a [keyword query language (KQL)](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference) query that specifies the [attachment](/exchange/policy-and-compliance/ediscovery/message-properties-and-search-operators#searchable-properties-in-exchange) property to filter messages by the file name of attachments. However, your search doesn't find messages that have an attached mail item for which the attachment name matches the search criteria.

For example, you run the following command to create an eDiscovery search to find attachments that have a name that contains the word "marketing":

```powershell
   New-MailboxSearch -Name <search name> -SearchQuery 'attachment:marketing' -SourceMailboxes <user mailbox> -TargetMailbox <destination mailbox>
```

When you run the search, it returns messages that have non-mail item attachments that are named, for example, *Marketing plan.pdf* or *Marketing plan.docx,* but not messages that have mail item attachments that are named, for example, *Marketing plan.*

> [!NOTE]
> Mail items include messages, contacts, calendar items, tasks, and notes.

The issue also occurs for eDiscovery searches that you create in the on-premises Exchange admin center (EAC).

## Cause

In Exchange Server 2019, an eDiscovery attachment search compares the `attachment` property value in a query to the `PR_ATTACH_LONG_FILENAME` MAPI property value of attached files. However, for mail item attachments, the `PR_ATTACH_LONG_FILENAME` property value is empty.

## Workaround

To work around this issue, don't specify the `attachment` property in your search query. Instead, use a [KQL free-text query](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference#elements-of-a-kql-query) to search for keywords in messages and attachments, including the name of mail item attachments. For example, run the following command to create your eDiscovery search:

```powershell
   New-MailboxSearch -Name <search name> -SearchQuery 'marketing' -SourceMailboxes <user mailbox> -TargetMailbox <destination mailbox>
```
