---
title: Shared calendar events appear in Outlook but not in Outlook on the web
description: Compare owner and receiver web calendars with classic Outlook to identify client synchronization, view, or shared calendar access problems.
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
  - Outlook for Windows
  - Outlook on the web
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Shared calendar events appear in Outlook but not in Outlook on the web

## Summary

This article helps you troubleshoot a shared calendar event that appears in one Outlook client but not in another. Use Outlook on the web to check the mailbox data, and compare the owner's original calendar with the receiver's replicated copy of a modern shared calendar.

## Symptoms

- A meeting created in classic Outlook isn't visible in Outlook on the web.
- A meeting visible in Outlook on the web is missing from classic Outlook.
- A shared calendar opens in one client but not in another.

## Cause

The difference can occur due to any of the following reasons:

- The client is disconnected.
- A calendar view or filter hides the event.
- The clients show different calendars.
- Synchronization is incomplete.
- A permission problem prevents access to the calendar.

The owner's mailbox and the receiver's modern shared-calendar copy can also differ if mailbox-to-mailbox synchronization isn't complete.

## Resolution

1. Identify the event and the exact calendar selected in each client. Check the owner and the calendar name, not just the event subject.
1. Open the owner's original calendar in Outlook on the web.
1. Have the receiver open the shared calendar separately in Outlook on the web.
1. Compare the results:
   - If the event appears in both web views, go to the next step.
   - If the event appears only in the owner's web view, see [Modern shared calendar stops updating or has missing events](shared-calendar-updates-delayed.md).
   - If the event appears only in classic Outlook, check whether the change was uploaded or was created in a local or different calendar.
1. In classic Outlook, confirm that the client is connected to Exchange Online, and check the **Sync Issues** folder.
1. Select the intended calendar, and remove any view filter that hides the event.
1. Check the same event again. If it appears in all three views, the issue is resolved. Otherwise, continue.

### If the issue persists

1. If the calendar doesn't open in Outlook on the web, see [calendar permission troubleshooting](../permissions/troubleshoot-calendar-delegate-permissions.md) for a confirmed permission error. Also check that the intended calendar was added in that client. Then reopen the calendar, and compare the same event in both web views and in the connected desktop client. If the views agree, the issue is resolved.
1. If the difference persists or the event exists in only one mailbox, [collect calendar diagnostic logs](../cdl/get-calendar-diagnostic-logs.md). [Contact Microsoft Support](/microsoft-365/admin/get-help-support), and provide the owner and receiver identities, client build, calendar identity, exact error, and reproduction time with time zone. These comparisons don't correct a failed upload or replication.
