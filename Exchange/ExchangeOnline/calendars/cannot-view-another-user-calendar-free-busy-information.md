---
title: Can't View Another User's free/busy information in Exchange Online
description: Resolve the "too many calendar entries" error if you can't view another user's free/busy information in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six, shanefe, v-gsitser
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/23/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Can't view another user's free/busy information in Exchange Online

*Original KB number:* 2962513

## Summary

This article explains how to resolve `The result set contains too many calendar entries` when you can't view another user's free/busy information in Exchange Online. It covers the affected time slot limit, how to reduce unwanted entries, and the evidence to collect if the error persists.

## Symptoms

In Outlook on the web or Outlook for Windows, availability for a particular user is unavailable. When you try to view the user's calendar, you might see `could not be updated` or a red triangle with an exclamation mark.

When you analyze an HTTP Archive (HAR) network trace of the failed lookup in Outlook on the web, the response contains the following error message:

```text
The result set contains too many calendar entries. The allowed size = 1000; the actual size = ...
```

The [Microsoft Graph getSchedule API](/graph/api/calendar-getschedule) returns response code `5006` with this message when the user's calendar has a time slot that contains more than 1,000 entries.

## Cause

This issue occurs if the user's calendar has a time slot that contains more than 1,000 entries. The limit applies to the affected time slot, not the total number of items in the calendar folder.

## Resolution

1. Identify the user whose availability can't be retrieved and the date range in which the error occurs.
1. Ask the calendar owner to review the affected period and [delete unwanted calendar entries](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#the-result-set-contains-too-many-calendar-entries) so that there are fewer than 1,000 entries in the affected time slot. Don't delete appointments that the user still needs.
1. Repeat the availability lookup for the same user and date range.
1. Verify that the user's free/busy information is displayed and that the request no longer returns `The result set contains too many calendar entries`. If it succeeds, stop troubleshooting.

### If the issue persists

[Contact Microsoft Support](/microsoft-365/admin/get-help-support) with the affected user, date range, client, reproduction time with its time zone, and exact error message. If Support requests a browser trace, follow [Collect a browser trace for free/busy lookups in Outlook on the web](/troubleshoot/exchange/calendars/collect-free-busy-browser-trace) to capture, inspect, and safely share a sanitized HAR file for the lookup. Review the trace for personal information before sharing it, and don't post it publicly.
