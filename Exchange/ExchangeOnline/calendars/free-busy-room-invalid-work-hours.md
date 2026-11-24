---
title: Room-list free/busy lookup fails with an invalid work hours error
description: Resolve a room-list free/busy lookup failure caused by invalid working hours or a missing working-hours time zone in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: shanefe, v-gsitser
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
  - ai-usage:ai-assisted
search.appverid: MET150
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
ms.date: 11/23/2026
---
# Room list free/busy lookup fails with an invalid work hours error

## Summary

This article explains how to resolve a room list free/busy lookup failure in Exchange Online that returns an error message about the work hours not being valid. Find the room mailbox that has invalid working-hours settings, and then correct the settings to restore availability lookups.

## Symptoms

When you look up availability for a room list, the lookup fails. When you analyze an [HTTP Archive (HAR) network trace](collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [working-hours error message](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#work-hours-start-time-must-be-less-than-or-equal-to-end-time):

> Work hours start time must be less than or equal to end time.

The exception might also include `Microsoft.Exchange.InfoWorker.Common.InvalidParameterException` or `AttendeeWorkHours.Validate`.

## Cause

A room mailbox in the room list has invalid `WorkingHoursStartTime`, `WorkingHoursEndTime`, or `WorkingHoursTimeZone` settings. The start time must be less than or equal to the end time, and the working-hours time zone must be set.

## Resolution

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Check every room mailbox in the affected room list:

   ```powershell
   Get-DistributionGroupMember -Identity "Room list name" |
       Get-MailboxCalendarConfiguration |
       Format-List Identity,WorkingHoursStartTime,WorkingHoursEndTime,WorkingHoursTimeZone
   ```

   Replace `Room list name` with the affected room list. For the command references, see [Get-DistributionGroupMember](/powershell/module/exchangepowershell/get-distributiongroupmember) and [Get-MailboxCalendarConfiguration](/powershell/module/exchangepowershell/get-mailboxcalendarconfiguration).

1. Correct only the room mailbox that has invalid settings. Use [Set-MailboxCalendarConfiguration](/powershell/module/exchangepowershell/set-mailboxcalendarconfiguration) to set valid start and end times and a valid time-zone identifier. For example:

   ```powershell
   Set-MailboxCalendarConfiguration -Identity "room@contoso.com" `
       -WorkingHoursStartTime "08:00:00" `
       -WorkingHoursEndTime "17:00:00" `
       -WorkingHoursTimeZone "Pacific Standard Time"
   ```

   These values are examples, not required settings. Use the actual working hours and time zone for the room.

   Run the configuration check again, and then repeat the room-list lookup for the same time range. Confirm that availability is returned and that the invalid work hours error no longer occurs. If it succeeds, stop troubleshooting.

### If the issue persists

If the lookup still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester, room list, affected room identities, resulting working-hours configuration, lookup range, exact error, and reproduction time with time zone. Don't change valid settings on other rooms.
