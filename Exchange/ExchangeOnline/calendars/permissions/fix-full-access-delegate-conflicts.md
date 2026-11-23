---
title: Resolve Full Access and delegate conflicts in legacy Outlook calendars that use the MAPI sharing model in Exchange Online
description: Fix Outlook calendar errors when a user has Full Access and delegate permissions by moving the shared calendar to the modern sharing model.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
  - New Outlook for Windows
  - Outlook for Mac
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Resolve Full Access and delegate conflicts on legacy calendars

## Summary

Resolves Outlook calendar errors when a user has both Full Access and delegate permissions on a calendar that uses the legacy MAPI sharing model. Remove and re-add the shared calendar to move it to the modern sharing model and verify that the folder type includes `(REST)`.

## Symptoms

- A user has both Full Access to a mailbox and delegate access to its calendar.
- Outlook shows inconsistent calendar permissions, synchronization failures, or access errors.
- In classic Outlook, the shared calendar folder properties don't show `(REST)`.

## Cause

Full Access and Outlook delegate permissions can coexist when the calendar uses the modern shared-calendar model. The combination isn't supported on the legacy MAPI sharing model.

## Resolution

1. Confirm that both mailboxes are hosted in Exchange Online.
1. In classic Outlook, open the shared calendar folder properties and confirm whether the folder type includes `(REST)`.
1. If the calendar uses the legacy model, remove the old shared-calendar entry from Outlook.
1. Add the calendar again by using **Add Calendar** > **Open Shared Calendar**, or have the mailbox owner send a new calendar-sharing invitation.
1. Open the folder properties again and confirm that the folder type includes `(REST)`.

For information about the legacy conflict, see [Conflicting permission sets when working with shared or delegated folders in Outlook](https://techcommunity.microsoft.com/blog/outlookglobalcustomerservice/conflicting-permission-sets-when-working-with-shared-or-delegated-folders-in-out/388842). For information about the modern model and upgrade behavior, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/outlook/calendar-sharing-in-microsoft-365).

### Verify the resolution

Confirm that the user can open the mailbox through Full Access and manage the calendar as a delegate without synchronization or permission errors.

## More information

- [Restore private calendar access](fix-private-calendar-access.md)
- [Resolve hybrid delegate failures](fix-hybrid-delegate-failures.md)
