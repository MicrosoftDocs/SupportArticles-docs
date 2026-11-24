---
title: Diagnose free/busy unavailability issues in Exchange Online
description: When free/busy information is unavailable in Exchange Online, identify the affected mailboxes and error message. Then find the right troubleshooting guidance.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-gsitser
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - Exchange Hybrid
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
ms.date: 11/23/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Diagnose free/busy unavailability issues in Exchange Online

## Summary

This article points multiple free/busy issues in Exchange Online to the right troubleshooting guidance you can use to resolve them. If Scheduling Assistant doesn't show availability for an attendee or room, identify where the affected mailboxes are hosted, and then match the symptom or error message that you see to the appropriate instructions in the table.

The article applies if the issue occurs when you check attendee availability in a meeting. If the issue occurs when you open a shared or subscribed calendar, see [Calendar sharing in Exchange Online](/exchange/sharing/calendar-share-overview).

## Identify the affected mailboxes

Record the following information before you troubleshoot:

- The **requester**: The user who can't view availability.
- The **target**: The attendee or room whose availability is unavailable.
- The mailbox location and organization for both users.
- The client, the affected date range, and the reproduction time with its time zone.
- Whether the issue affects one target or multiple targets.
- The exact error message.

For availability between organizations, identify which direction fails. Test the reverse direction separately, if possible.

| Mailbox locations | Where to start |
| --- | --- |
| Both mailboxes are in the same Exchange Online tenant | Check the target calendar's permissions by using [Manage calendar permissions in Exchange Online](/exchange/collaboration-exo/shared-calendars/manage-calendar-permissions), and then use the error table in this article. |
| Both mailboxes are in Exchange Online, but in different tenants | See [Microsoft 365 Cross-Tenant Access Policy migration guidance](/exchange/sharing/migrate-to-m365-xtap). For an existing organization relationship, see [Organization relationships in Exchange Online](/exchange/sharing/organization-relationships/organization-relationships). |
| One mailbox is in Exchange Online and the other is in on-premises Exchange | See [Troubleshoot free/busy issues in Exchange hybrid](../../ExchangeHybrid/calendars/troubleshoot-freebusy-issues-in-exchange-hybrid.md). |
| One mailbox is in Exchange Online and the other uses a different calendar service, such as Google Workspace | Identify the failing direction and validate the deployed availability-sharing configuration with your interoperability provider. Don't apply the Microsoft 365-to-Microsoft 365 migration procedure to this scenario. |

For cross-tenant Exchange Online scenarios, check the current [migration guidance](/exchange/sharing/migrate-to-m365-xtap) and your tenant's Microsoft 365 Message center before changing configuration. Microsoft 365 Cross-Tenant Access Policy doesn't replace sharing configurations for on-premises Exchange organizations.

## Find the matching symptom or error

To find an availability service error, analyze an HTTP Archive (HAR) network trace of the failed lookup in Outlook on the web. Match the error details in the response to the following table.

| Symptom or error message | Troubleshooting guidance |
| --- | --- |
| `The result set contains too many calendar entries` | [Can't view another user's free/busy information in Exchange Online](cannot-view-another-user-calendar-free-busy-information.md). |
| `The caller does not have access to free/busy data` | Check the target calendar's permissions by using [Manage calendar permissions in Exchange Online](/exchange/collaboration-exo/shared-calendars/manage-calendar-permissions). For a hybrid lookup, also see [The caller does not have access to free/busy data](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#the-caller-does-not-have-access-to-freebusy-data). |
| `Work hours start time must be less than or equal to end time` when you query a room list | [Resolve invalid room working hours](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#work-hours-start-time-must-be-less-than-or-equal-to-end-time). |
| `Unable to save free/busy information`, `Unable to clean your local free/busy information`, or `Can't open this item. Unable to open the free/busy information` | [Errors when you configure free/busy or delegate information](/troubleshoot/outlook/calendaring/errors-when-configure-free-busy-or-delegate-information). Use that article only when its symptoms match. |
| Another free/busy error | Find the exact message in [Resolve free/busy errors in Outlook](/troubleshoot/outlook/calendaring/resolve-free-busy-errors). Check that the selected procedure applies to the mailbox locations in your scenario. |

## Collect evidence if the issue persists

Reproduce the issue in Outlook on the web with only the affected target as an attendee. Use the same date range that failed, and record the result and exact error message.

[Contact Microsoft Support](/microsoft-365/admin/get-help-support), and provide the requester and target, their mailbox locations, the failing direction, the affected date range, the reproduction time with its time zone, and the exact error.

If Microsoft Support requests a browser trace, follow [Collect a browser trace for free/busy lookups in Outlook on the web](/troubleshoot/exchange/calendars/collect-free-busy-browser-trace) to capture, inspect, and safely share a sanitized HAR file for the lookup.

> [!CAUTION]
> A HAR file can contain personal information in request and response data. Sanitized export excludes sensitive headers but doesn't replace a review of the file's contents. Don't post the trace publicly. Share only the information that is required for your support request.
