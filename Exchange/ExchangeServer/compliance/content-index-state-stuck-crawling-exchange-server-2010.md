---
title: Content index state is stuck in crawling in an Exchange Server 2010 database
description: Describes an issue in which the Content index state counter in an Exchange Server 2010 database never progresses beyond crawling. And, event IDs 102 and 5617 are logged in the Application log.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need help with Content Indexing (Search issues)
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: davidspo, v-six
appliesto: 
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# Content index state remains stuck in crawling in an Exchange Server 2010 database

_Original KB number:_ &nbsp;2820817

## Symptoms

On a Microsoft Exchange Server 2010 database, the Content Index state is displayed as "crawling," and it never appears to reach a state of "healthy." Additionally, even though the **Number of Documents Successfully Indexed** performance counter shows a progressive increase in the number of indexed documents, the value in the **Number of Mailboxes Left to Crawl** counter doesn't decrease as expected.

In this situation, the following events are logged in the Application log:

```console
Time:
ID: 102
Level: Error
Source: MSExchange Search Indexer
Machine: Mailboxserver.contoso.com
Message: Exchange Search Indexer has failed to crawl the mailbox (8832ee80-47b8-4b0e-a98f-c4a239794707) in database (Database1) due to error: (Microsoft.Exchange.Search.MailboxCrawlFailedException: Failed to logon to mailbox). This mailbox will be retried later.
```

```console
Time:
ID: 5617
Level: Error
Source: CI Troubleshooter
Machine: Mailboxserver.contoso.com
Message: CI troubleshooter exchange search service restart attempt 81.
```

## Cause

This issue occurs when System Center Operations Manager is running the Toubleshoot-CI.ps1 script. This causes the Exchange Search service to restart before it completes the indexing process.

## Resolution

To resolve this issue, prevent the System Center Operations Manager server from running the Troubleshoot-CI.ps1 script as follows:

1. Open System Center Operations Manager.
1. Click **Management Pack Objects** > **Monitor**.
1. In the **Look for** box, type *troubleshoot*, and then click **Find Now**.
1. Locate the item that corresponds to Troubleshoot-CI.ps1 script, right-click it, and then click **Properties**.
1. On the **Override** tab, click **Override**.
1. Select the **Enabled** check box, set the **Override value** option to **False**, and then click **OK**.

## More information

Typically, System Center Operations Manager runs the Troubleshoot-CI.ps1 script every two hours. However, if the Troubleshoot-CI.ps1 script detects one of the following symptoms, it triggers a restart of the Exchange search service:

- Deadlock: Exchange Search deadlocks while waiting on threads from MSSearch.
- Corruption: One or more search indices are corrupted.
- Stall: Resembles a deadlock in that the indices aren't updated.
- Backlog: The Search catalog is backlogged, so scheduled index searches don't run as expected.

Here is an example of an event that's logged when the Troubleshoot-CI.ps1 script runs:

```console
Time:
ID: 5611
Level: Error
Source: CI Troubleshooter
Machine: Mailboxserver.contoso.com
Message: Indexing backlog reached a critical limit of 48 hours or the number of items in the retry queue is greater than 10000 for one or more databases: Database1 (0, 12572, 0)Database1 (0, 31859, 0)
```

If the databases have large mailboxes or mailboxes with a high item count, it generally takes longer than two hours to complete the indexing process. And when the Exchange search service restarts, the mailboxes are put back into the list for reindexing. In this situation, the crawling process may never get the chance to finish.
