---
title: ICS file import fails
description: Investigate issues due to the 10 MB Internet Calendar file limit, invalid ICS files, and unsupported import into shared or delegated calendars in Outlook on the web.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
  - Outlook on the web
ms.date: 11/25/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# ICS file import fails

## Summary

This article helps you troubleshoot issues that you experience when you try to import an ICS file by using Outlook on the web, or a subscription that reports an oversized feed. The article describes how to check the file size, the file contents, and the destination calendar to resolve the issue.

## Symptoms

You experience one or more of the following symptoms:

- Import fails with an error about calendar file size.
- Subscription diagnostics contain the `SubscriptionOverSizeLimit_NoInnerException_1` error.
- You can't import an ICS file into a shared mailbox calendar or a calendar that a delegate manages.
- A downloaded ICS file fails to import even into your own calendar.

## Cause

- File-size errors or the `SubscriptionOverSizeLimit_NoInnerException_1` error occur when the service limits calendar files for import and subscription to 10 MB. A file over this limit fails to import.
- Importing an ICS file into a shared or delegated calendar isn't a supported scenario. Also, you can't import into either a shared mailbox, or a shared or delegated calendar.
- Importing a small ICS file even into your own calendar can fail when the file is invalid. For example, an HTML response that is saved as an ICS file is invalid.

## Resolution

Use the resolution that's appropriate for the cause of your issue.

### File exceeds 10 MB

1. Download the file from the current publishing URL, and then check its size.
1. If the file exceeds 10 MB, ask the publisher to reduce the published date range or to provide smaller calendar feeds.
1. For a one-time import into your own calendar, get valid, smaller ICS exports from the source application. Don't split an ICS file as plain text, because recurring events and calendar boundaries must remain valid.
1. Import the smaller files into a supported destination, or retry retrieval of the smaller subscription feed.
1. Confirm that the expected events appear after the import is complete.

A one-time import doesn't create ongoing synchronization with the source.

### Destination is a shared or delegated calendar

The import workflow isn't supported for destinations such as shared and delegated calendars, and shared mailboxes. Don't grant broader permissions or enable anonymous publishing to enable an import.

If importing a personal calendar is a business requirement, import the file into your own calendar. Then confirm that the expected events appear.

If the import fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support) to discuss supported alternatives.

### A small file fails in a supported destination

1. Confirm that the exported file is a valid ICS file and not a sign-in page or an error page. If there are errors in the file, ask the publisher to correct the invalid calendar data.
1. Import the corrected export file into the supported destination.
1. Confirm that the expected events appear.

#### If the corrected file fails to import

Import a small ICS export file that is valid. This test helps to identify whether the issue is caused by the source file or the destination.

Then [contact Microsoft Support](/microsoft-365/admin/get-help-support) and provide the following information:

- The exact error
- The file size
- The source application
- The destination calendar type
- The affected user
- The test time, including the time zone
- The results of both imports

Provide a nonsensitive sample file through the support request, not in a public post.
