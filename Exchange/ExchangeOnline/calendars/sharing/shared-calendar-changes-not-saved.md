---
title: Shared calendar changes disappear or an editor can't save meeting changes
description: Investigate failed shared calendar saves and cancellations when changes revert, events reappear, or the owner doesn't see a delegate's newly created meeting.
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
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Shared calendar changes disappear or an editor can't save meeting changes

## Summary

This article helps you determine whether a shared calendar change reached the owner's mailbox when edits disappear, a canceled event reappears, or an event that a delegate created isn't visible to the owner. It also lists the evidence to collect before you contact Microsoft Support.

## Symptoms

- A user with Editor access can't create or modify shared events.
- Changes appear locally and then revert.
- A canceled meeting reappears, and no cancellation appears in Sent Items.
- The owner doesn't see a meeting that a delegate or editor created.
- Client diagnostics report a server failure, such as HTTP 500 or `E_FAIL`.

## Cause

A change that appears locally isn't necessarily saved to the owner's calendar. If the server rejects a modern-sharing write, the receiver's local copy can revert to the server version. A meeting can also appear to be missing if it was created in a different calendar or if a client hasn't synchronized.

## Report the issue to Microsoft Support

Collect the following information, and then [contact Microsoft Support](/microsoft-365/admin/get-help-support). Support works with you to investigate the failed operation. These steps don't repair the calendar.

1. Record the meeting subject, the creator and owner SMTP addresses, the meeting creation time with the time zone, the meeting start time, and the client or device that you used.
1. Confirm where the event was created: the creator's calendar, the owner's calendar, or the receiver's shared copy.
1. Verify the user's intended [calendar permissions](../permissions/troubleshoot-calendar-delegate-permissions.md). Don't repeatedly remove valid permissions to troubleshoot a failed server write.
1. Open the owner's calendar in Outlook on the web, and check whether the event or change exists there.
1. In classic Outlook, check the **Sync Issues** folder for the affected operation. Record any request ID, HTTP status, and final HRESULT. An empty **Sync Issues** folder doesn't rule out a modern-sharing failure.
1. [Collect calendar diagnostic logs](../cdl/get-calendar-diagnostic-logs.md) for the owner and the receiver by using the same meeting ID. If an organizer's event is missing, include the organizer and the relevant participants.
1. Contact Microsoft Support, and provide the logs, the exact error, the request identifiers, and the reproduction time of the issue. Support might ask for a client trace of the failed save or cancellation.

Don't resend a meeting or cancellation repeatedly without checking the server state. Recipients might already have received an earlier successful operation.
