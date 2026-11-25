---
title: The Publish calendar option is missing or calendar publishing is disabled
description: Check the mailbox sharing policy and calendar publishing settings when users can't publish a calendar or generate a published calendar URL.
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

# The Publish calendar option is missing or calendar publishing is disabled

## Summary

This article explains how to check the owner's assigned sharing policy and the calendar's publishing settings when the publishing option is unavailable or no published calendar URL exists.

## Symptoms

You experience one or more of the following symptoms:

- The calendar publishing controls aren't visible in Outlook on the web.
- The calendar owner can't publish the calendar.
- A previously published calendar is no longer available to subscribers.

## Cause

Calendar publishing can be unavailable if the owner's assigned sharing policy doesn't permit the required `Anonymous` calendar access or if publishing is disabled on the calendar itself.

Publishing differs from sharing an internal calendar with a named user. Anonymous publishing might also be unavailable because of your organization's cloud environment or compliance requirements.

## Resolution

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and then inspect the sharing policy that's assigned to the owner's mailbox by using [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) and [Get-SharingPolicy](/powershell/module/exchangepowershell/get-sharingpolicy):

   ```powershell
   Get-Mailbox -Identity "owner@contoso.com" | Format-List SharingPolicy
   Get-SharingPolicy | Format-List Name,Enabled,Domains
   ```

1. Check whether the assigned policy permits the required anonymous sharing level.
1. Inspect the calendar by using [Get-MailboxCalendarFolder](/powershell/module/exchangepowershell/get-mailboxcalendarfolder). Replace the calendar path with the path of the affected calendar.

   ```powershell
   Get-MailboxCalendarFolder -Identity "owner@contoso.com:\Calendar" |
       Format-List PublishEnabled,DetailLevel,PublishDateRangeFrom,PublishDateRangeTo,PublishedCalendarUrl,PublishedICalUrl
   ```

   Treat published URLs as sensitive. Anyone who has an anonymous URL might be able to read the published data.

1. If publishing is intended and permitted, make the approved change by using [Set-SharingPolicy](/powershell/module/exchangepowershell/set-sharingpolicy) or [Set-MailboxCalendarFolder](/powershell/module/exchangepowershell/set-mailboxcalendarfolder). Don't overwrite all domain entries to add one setting. Don't enable anonymous access to bypass an organizational restriction.

1. Confirm that the expected publishing controls and URLs are available. Also confirm that the anonymous view exposes only the approved detail level and date range. If these checks succeed, stop troubleshooting.

   Don't post the published URL in a public support post.

1. If you need only internal access, use named-user calendar sharing instead of publishing.

### If the issue persists

If publishing is still unavailable after an approved change, [contact Microsoft Support](/microsoft-365/admin/get-help-support) and provide the following information:

- The owner identity
- The calendar path
- The assigned policy and the publishing output
- The exact error
- The test time, including the time zone

Provide sensitive publishing URLs only within the support request.
