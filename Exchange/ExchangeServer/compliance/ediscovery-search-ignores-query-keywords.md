---
title: eDiscovery search ignores some keywords in a query
description: Provides a workaround for an issue in which an eDiscovery search ignores some keywords in a query.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Messaging Policy and Compliance\Issues with eDiscovery, import/export of mailbox
  - CI 174132
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: svajda, lindabr, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---

# eDiscovery search ignores some keywords in a query

## Symptoms

You run an [In-Place eDiscovery search](/exchange/policy-and-compliance/ediscovery/create-searches) in a Microsoft Exchange Server 2019 environment. Your search uses a [keyword query language (KQL)](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference) query that contains multiple space-separated keywords, and you specify `hu-HU`, `sk-SK`, or `tr-TR` as the search locale. You expect your query to result in a Boolean AND search, but the search ignores all keywords except the first one.

For example, the following command creates an eDiscovery search that returns results for only the first keyword ("alma") and not for the combined keywords ("alma AND körte AND banán"):

```powershell
New-MailboxSearch -Name <search name> -SearchQuery 'alma körte banán' -Language "hu-HU" -SourceMailboxes <user mailbox> -TargetMailbox <destination mailbox>
```

> [!NOTE]
> KQL applies a [Boolean AND search to space-separated keywords](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference#constructing-free-text-queries-using-kql). A keyword is an individual word, or a phrase that's enclosed in double quotation marks.

The issue also occurs for eDiscovery searches that you create in the on-premises Exchange admin center (EAC).

**Note**: In the on-premises EAC, the URL of the EAC determines the search locale. For example, the following URL automatically sets the locale for EAC eDiscovery searches to `tr-TR`: `https://mail.contoso.com/ecp/?mkt=tr-TR`.

## Cause

This issue occurs because eDiscovery searches that use the `hu-HU`, `sk-SK`, and `tr-TR` locales might not correctly tokenize space-separated keywords.

## Workaround

To work around this issue, choose one of the following workarounds:

- Create your search by using a locale that isn't `hu-HU`, `sk-SK`, or `tr-TR`. For example, run the following command:

  ```powershell
  New-MailboxSearch -Name <search name> -SearchQuery 'alma körte banán' -Language "en-US" -SourceMailboxes <user mailbox> -TargetMailbox <destination mailbox>
  ```

  > [!NOTE]
  > This workaround isn't recommended for any search query that contains one or more keywords that are phrases. For example, the query `'confidential "internal only"'`.

- Modify your search query to explicitly specify a Boolean AND search. For example, run the following command:

  ```powershell
  New-MailboxSearch -Name <search name> -SearchQuery 'alma AND körte AND banán' -Language "hu-HU" -SourceMailboxes <user mailbox> -TargetMailbox <destination mailbox>
  ```

  For information about other Boolean operators that you can use in your query, see [KQL operators for complex queries](/sharepoint/dev/general-development/keyword-query-language-kql-syntax-reference#kql-operators-for-complex-queries).
