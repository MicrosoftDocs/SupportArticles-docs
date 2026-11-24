---
title: Same-tenant free/busy fails with "The caller does not have access" error
description: Troubleshoot a same-organization free/busy access error caused by calendar permissions in Exchange Online.
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
# Same-tenant free/busy fails with "The caller does not have access" error

## Summary

This article explains how to resolve a free/busy lookup that fails with "The caller does not have access to free/busy data" error when an Exchange Online user views another user's availability in the same organization. It shows how to check and correct the target mailbox's calendar permissions.

## Symptoms

Scheduling Assistant doesn't display the target user's availability. When you analyze an [HTTP Archive (HAR) network trace](collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains the following [free/busy access error message](/troubleshoot/outlook/calendaring/resolve-free-busy-errors#the-caller-does-not-have-access-to-freebusy-data):

> The caller does not have access to free/busy data.

The response might also include `ErrorNoFreeBusyAccess` or `NoFreeBusyAccessException`.

## Cause

The target user's calendar permissions don't allow the requester to view free/busy information. For example, the calendar's `Default` permission can be set to `None`.

This article covers the same-organization calendar-permission case. The error alone doesn't establish the cause of an access failure between organizations or to on-premises Exchange.

For mailboxes in different organizations, use the [cross-tenant access policy migration guidance](/exchange/sharing/migrate-to-m365-xtap) or [organization relationship guidance](/exchange/sharing/organization-relationships/organization-relationships) for the actual sharing model.

## Resolution

1. Verify that both mailboxes are in the same Exchange Online organization and that the operation is an availability lookup in Scheduling Assistant, not opening a shared calendar.
1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), and inspect the target user's calendar permissions:

   ```powershell
   Get-MailboxFolderPermission -Identity "user@contoso.com:\Calendar"
   ```

   Replace the mailbox address. If the calendar folder name is localized, replace `Calendar` with the localized name. See [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission).

1. Check the permission entries that apply to the requester, including the `Default` entry. If the effective permission doesn't allow availability access, have the calendar owner or an authorized administrator grant the intended access by following [Manage calendar permissions](/exchange/collaboration-exo/shared-calendars/manage-calendar-permissions).

   Don't grant editor or full calendar-detail access when availability-only access is intended. Don't broaden access if the restriction is intentional.

   After an approved permission change, repeat the lookup with the same requester, target user, and time range. Verify that only the intended availability information is visible and that the access error no longer occurs. If it succeeds, stop troubleshooting.

### If the issue persists

If the error continues, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Include the requester and target identities, time range, exact error, reproduction time with time zone, and relevant calendar-permission output. Don't broaden permissions further to troubleshoot the failed lookup.
