---
title: Shared calendar is missing old events or shows only one year of history
description: Check the modern shared calendar synchronization window before treating missing historical events or unequal calendar item counts as data loss.
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

# Shared calendar is missing old events or shows only one year of history

## Summary

This article explains how to check the synchronization window when the owner sees older events that don't appear in a receiver's modern shared-calendar copy. It also describes how to review the history boundary and when to contact Microsoft Support.

## Symptoms

- The receiver can see recent events but only one year of history.
- The owner has more calendar items than the receiver.
- A newly created shared-calendar copy hasn't populated all expected historical events.

## Cause

Modern shared calendars synchronize a bounded history window, approximately one year by default. Initial synchronization can also populate recent data before older data. Different item counts alone don't indicate a missing event.

The server-side shared-calendar history window is separate from a classic Outlook cache or synchronization filter.

## Resolution

1. Confirm that the older event exists in the owner's calendar in Outlook on the web.
1. Compare it with the receiver's shared calendar in Outlook on the web, not only the receiver's desktop cache.
1. As an Exchange administrator, inspect the receiver-side folder by using the [Get-MailboxCalendarFolder](/powershell/module/exchangepowershell/get-mailboxcalendarfolder) cmdlet:

   ```powershell
   Get-MailboxCalendarFolder -Identity "receiver@contoso.com:\Calendar\Owner" |
       Format-List CalendarSharingOwnerSmtpAddress,SharedCalendarSyncStartDate
   ```

   Replace the example path with the actual folder path. Calendar root names can be localized, and similarly named folders can belong to different sharing relationships.

1. Compare the date of the missing event with the `SharedCalendarSyncStartDate` value. A missing or unparseable value doesn't confirm a healthy synchronization boundary.
1. If you need more history, review the `SharedCalendarSyncStartDate` parameter of the [Set-MailboxCalendarFolder](/powershell/module/exchangepowershell/set-mailboxcalendarfolder#-sharedcalendarsyncstartdate) cmdlet. Use the shared-calendar folder in the receiver's mailbox, not the owner's original calendar. The parameter requires a supported upgraded calendar and FullDetails, Editor, or Delegate access.

   > [!IMPORTANT]
   > Changing the history boundary can briefly remove events from view while the calendar resynchronizes. The value controls initialization. The service processes later new, updated, and deleted items regardless of that date. Confirm the target folder and the expected effect before you make a change.

1. After resynchronization, check whether the expected history is present by looking for the same event in the owner's and receiver's web calendars.

### If the issue persists

1. If an event inside the expected window is still missing after synchronization, see [Modern shared calendar stops updating or has missing events](shared-calendar-updates-delayed.md). Then [contact Microsoft Support](/microsoft-365/admin/get-help-support), and provide the owner and receiver identities, folder path, history boundary, affected meeting, and observation time with time zone.
1. If the server copy is complete but classic Outlook isn't, see [Shared calendar events appear in Outlook but not Outlook on the web or vice versa](calendar-differs-between-clients.md).
