---
title: Export failed with error type FailedToSearchMailboxes error when export eDiscovery search results.
description: Describes a problem that triggers an error message when you try to export eDiscovery search results to a PST file in the Exchange admin center in Exchange Online. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 03/31/2022
---

# "Export failed with error type FailedToSearchMailboxes" error when you try to export eDiscovery search results to a PST file in Exchange Online

_Original KB number:_&nbsp;2957583

## Problem

As an administrator who wants to export the results of an In-Place eDiscovery search to a PST file, you click **Export to a PST file** in the Exchange admin center in Exchange Online. However, you receive an error message that resembles the following:

> Failed exporting item id: from source id:mailbox@contoso.com with error: [FailedToSearchMailboxes] Export failed with error type: 'FailedToSearchMailboxes'. Message: The results are sorted but inconsistent with reference item. MailboxGuid:...', ReferenceItem:'001B 2013-10-04 T 09:29:32 .0000000000001D40002A8AD', Offending Item:'001B 2013-10-16 T 16:01:44 .0000000000001D400029FF1'

> [!NOTE]
> Make a note of the dates in the error message. These are shown in bold text in the preceding example.

## Cause

This issue may occur if one of the following conditions is true:

- The search results contain corrupted messages that can't be exported to a PST file.
- There are too many messages in the specified date range of the search for the PST exporter to process.

## Solution

To resolve this issue, follow these steps:

1. Check the mailbox that's specified in the error to see whether there are messages that fall within the date range that's listed in the error. If one or more messages fall within the date range of the search, back up the messages, delete them from the mailbox, and then perform the eDiscovery search again.

   Test to see whether the issue is resolved. If the issue persists, go to step 2.

2. Separate the eDiscovery export into batches that are sorted by date. For example:

   ```console
   StartDate '10/04/2013' -EndDate '10/17/2013'
   StartDate '02/16/2014' -EndDate '02/27/2014'
   ```

   Test to see whether the issue is resolved. If the issue persists, go to step 3.

3. Perform the eDiscovery search without specifying start and end dates, and then export to a PST file.

## More information

For more information, see [Export eDiscovery search results to a PST file](/exchange/security-and-compliance/in-place-ediscovery/export-search-results).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
