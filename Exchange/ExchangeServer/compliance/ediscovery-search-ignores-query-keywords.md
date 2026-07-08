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
  - CI 9823
  - CI 12201
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: svajda, lindabr, meerak, v-trisshores
appliesto:
  - Exchange Server 2019
search.appverid: MET150
ms.date: 07/07/2026
---

# eDiscovery search ignores some keywords in a query

## Summary

This article describes an issue in which eDiscovery searches in Exchange Server 2019 don't return the expected results when a keyword query contains multiple space-separated keywords and uses the `hu-HU`, `sk-SK`, or `tr-TR` search locale. The issue occurs because these locales can incorrectly process keyword tokenization, causing the search to ignore keywords after the first one. The article explains the cause of the behavior and provides workarounds that use a different locale or explicit Boolean operators to ensure that all search keywords are evaluated correctly.

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
