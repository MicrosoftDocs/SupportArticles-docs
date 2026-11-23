---
title: Resolve cross-tenant free/busy fails with "The caller does not have access" error
description: Describes how to resolve the error by checking organization-relationship sharing settings and target calendar permissions when an EWS cross-tenant free/busy lookup reports that the caller has no access.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: meshel, shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
search.appverid: MET150
ms.date: 11/23/2026
ai-usage: ai-assisted
---

# Resolve cross-tenant free/busy fails with "The caller does not have access" error

## Summary

This article explains how to investigate and resolve a cross-tenant availability lookup that reports that the caller doesn't have access to free/busy data. It covers organization-relationship domain coverage, free/busy access settings, and the target calendar's permissions.

The guidance applies when both mailboxes are in Exchange Online and the lookup uses an existing Exchange Web Services (EWS) organization relationship. For Microsoft 365 Cross-Tenant Access Policy or Microsoft Graph requests, use the [current cross-tenant sharing guidance](/exchange/sharing/migrate-to-m365-xtap) instead. Opening a shared calendar and requesting availability in Scheduling Assistant are different operations.

## Symptoms

A user can't see an attendee's availability in another Exchange Online tenant. When you analyze an [HTTP Archive (HAR) network trace](collect-free-busy-browser-trace.md) of the failed lookup in Outlook on the web, the response contains:

```text
The caller does not have access to free/busy data.
```

The response might also contain `ErrorNoFreeBusyAccess` or `NoFreeBusyAccessException`. Record which user makes the request and which user's calendar is the target. Test the reverse direction separately if both directions fail.

## Cause

An organization relationship or the target calendar's permissions can restrict availability access. Examples include a missing requester domain, disabled sharing, an access level of `None`, or a sharing scope that excludes the target mailbox.

As described in [Organization relationships in Exchange Online](/exchange/sharing/organization-relationships/organization-relationships), both organizations configure their side of the relationship. Calendar permissions can further restrict the information available to external users. An intentional privacy restriction isn't a configuration error.

## Resolution

Coordinate with administrators in both tenants, and confirm the intended sharing policy before making a change.

1. In each tenant's own [Exchange Online PowerShell session](/powershell/exchange/connect-to-exchange-online-powershell), inspect the relevant relationship by using [Get-OrganizationRelationship](/powershell/module/exchangepowershell/get-organizationrelationship):

   ```powershell
   Get-OrganizationRelationship |
       Format-List Name,DomainNames,Enabled,FreeBusyAccessEnabled,FreeBusyAccessLevel,FreeBusyAccessScope
   ```

1. Identify the relationship for the other organization in each tenant. Check `DomainNames` against the domains involved in the failed lookup, not just the relationship's display name. Have the target administrator confirm that its relationship recognizes the requesting organization's domain.

1. Compare the relationship settings with the approved sharing configuration:

   - `Enabled` must allow the intended relationship to function.
   - `FreeBusyAccessEnabled` must allow the intended availability sharing.
   - `FreeBusyAccessLevel` must provide the intended access, such as `AvailabilityOnly`, rather than `None`.
   - If `FreeBusyAccessScope` is set, the target mailbox must be in the intended mail-enabled security group.

   For parameter definitions, see [Set-OrganizationRelationship](/powershell/module/exchangepowershell/set-organizationrelationship). Correct only confirmed discrepancies by following [Modify an organization relationship](/exchange/sharing/organization-relationships/modify-an-organization-relationship). Preserve unrelated domains, scopes, and features. Don't remove a sharing scope or grant subject and location details just to test access.

1. If relationship settings allow the intended access, have the target tenant's administrator inspect the calendar by using [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission):

   ```powershell
   Get-MailboxFolderPermission -Identity "target@fabrikam.com:\Calendar"
   ```

   Replace the mailbox address and, if necessary, the localized calendar folder name. Compare the effective permissions, including the `Default` entry, with the intended access. If a restrictive permission is unintentional, have the calendar owner or authorized administrator correct it by following [Manage calendar permissions](/exchange/collaboration-exo/shared-calendars/manage-calendar-permissions). Don't broaden an intentional restriction.

1. Repeat the lookup with the same requester, target, and meeting time range. Confirm that the access error is absent and that only the approved level of availability information is visible. If it succeeds, stop troubleshooting.

### If the issue persists

[Contact Microsoft Support](/microsoft-365/admin/get-help-support) and provide the requester and target information, the affected direction, the time range, the reproduction time with its time zone, the exact error, and the relevant relationship and calendar-permission output from both tenants. Don't broaden access further to troubleshoot the failed lookup. Share collected information only through the support request.
