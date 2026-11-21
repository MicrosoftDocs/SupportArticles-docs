---
title: Free/busy information is unavailable between users in the same Exchange Online tenant
description: Diagnose calendar permissions, calendar-entry errors, and mailbox-specific failures when users in the same Exchange Online tenant can't see availability.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: shanefe
audience: ITPro
ms.topic: troubleshooting
ms.service: exchange-online
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid: MET150
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
ms.date: 11/20/2026
ai-usage: ai-assisted
---

# Free/busy information is unavailable between users in the same Exchange Online tenant

## Summary

Use this article when Scheduling Assistant (Free/busy) can't display an attendee's or room's availability and both mailboxes are hosted in the same Exchange Online tenant. Start with the affected mailbox pair, calendar permissions, and the exact error before you change configuration.

The "requester" is the user checking another mailbox's availability. The "target" is the attendee or room mailbox whose availability is being checked. Both mailboxes must be hosted in the same tenant for the procedures in this article.

An organization relationship or Microsoft 365 Cross-Tenant Access Policy isn't used for a Free/busy lookup between two mailboxes in the same tenant. This article doesn't cover opening a shared calendar or availability between separate organizations.

## Symptoms

You experience one or more of the following symptoms:

- Scheduling Assistant displays hash marks or no information for a user or room.
- One requester can't view a target's availability, although other requesters can.
- Availability fails for a particular target or date range.
- The lookup returns an access error or `The result set contains too many calendar entries`.
- Outlook displays an error about saving, opening, or activating free/busy information.

## Cause

Different failures can produce a similar unavailability in the calendar display:

- The target's calendar permissions don't grant the requester the intended availability access.
- The calendar contains too many entries in the period being queried.
- A mailbox property doesn't correctly reference the hidden free/busy information used by certain Outlook and delegate operations.

However, an unavailable display alone doesn't establish a permissions problem or justify resetting a mailbox's delegate configuration.

## Resolution

Use the following steps to diagnose the cause of your specific issue and then resolve it.

### Step 1: Identify the affected lookup

1. Record the requester, the target, the affected date range, the reproduction time and time zone, and the exact error.
1. Confirm that both mailboxes are hosted in the same Exchange Online tenant. If a target is represented only by a mail contact or mail user, confirm its actual mailbox location before you continue.
1. Reproduce the lookup in Outlook on the web. Create an event, open **Scheduling Assistant**, and add only the affected target. Don't send the invitation.
1. Compare the result with another target. If appropriate, have another authorized requester check the original target. Record which mailbox pairs fail rather than assuming that every user is affected.
1. Compare Outlook on the web with the affected Outlook client. If the lookup works on the web, record the client-specific difference before applying a mailbox-wide change.

If you need to identify the returned error, follow [Collect a browser trace for free/busy lookups in Outlook on the web](collect-free-busy-browser-trace.md). Inspect both the response and Scheduling Assistant: a successful HTTP status doesn't prove that the availability lookup succeeded.

### Step 2: Check the target's calendar permissions

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Use [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission) to inspect the target's calendar:

   ```powershell
   Get-MailboxFolderPermission -Identity "target@contoso.com:\Calendar" |
       Format-Table User,AccessRights
   ```

   Replace the example address with the target mailbox. Use the actual default calendar folder name if the mailbox uses a different language.

1. Review the `Default` entry and any entries that apply to the requester. `AvailabilityOnly` grants free/busy time; `LimitedDetails` also includes the subject and location. A `Default` entry of `None` doesn't grant availability to everyone in the organization.
1. Compare the permissions with the mailbox owner's sharing intent and your organization's policy. If access is intentionally restricted, don't broaden it merely to remove the unavailable display.
1. Correct a confirmed permission error. Use [Set-MailboxFolderPermission](/powershell/module/exchangepowershell/set-mailboxfolderpermission) to update an existing entry or [Add-MailboxFolderPermission](/powershell/module/exchangepowershell/add-mailboxfolderpermission) to add an approved entry. Grant only the access required, and preserve unrelated permissions and delegate settings.

Changing the `Default` entry affects users beyond the requester. Prefer a requester-specific correction when that matches the approved sharing requirement.

### Step 3: Follow the appropriate procedure for the returned error

| Error or symptom | Action |
| --- | --- |
| `The result set contains too many calendar entries` | Follow [Can't view another user's free/busy information](cannot-view-another-user-calendar-free-busy-information.md). Review the affected period and unintended duplicate items or recurring series before removing any calendar content. A total folder-item count alone doesn't establish the number of entries in the failed period. |
| `The caller does not have access to free/busy data` or another access error | Check the target's applicable calendar permissions. If they match the intended access, retain the exact error and reproduction details for Microsoft Support instead of repeatedly resetting permissions. |
| `Unable to save free/busy information`, `Unable to clean your local free/busy information`, or `Can't open this item. Unable to open the free/busy information` | Compare the complete symptoms with [Errors when you configure free/busy or delegate information](/troubleshoot/outlook/calendaring/errors-when-configure-free-busy-or-delegate-information). Apply that article only when its scenario matches. |
| A different error | Find the exact message in [Resolve free/busy errors in Outlook](/troubleshoot/outlook/calendaring/resolve-free-busy-errors), and confirm that the selected procedure applies to two mailboxes in the same tenant. Don't apply a cross-organization repair to a same-tenant lookup. |

Don't delete hidden mailbox properties, clear delegate collections, or remove calendar items as a general test. Those actions can change mailbox behavior or remove information unrelated to the lookup.

### Verify the resolution

1. Repeat the original lookup in Outlook on the web with the same requester, target, and date range.
1. Confirm that Scheduling Assistant returns the availability detail allowed by the target's permissions and that the original error no longer occurs.
1. Repeat the lookup in the originally affected client. If only that client still fails, record the difference rather than making further organization-wide changes.
1. Check that the correction hasn't exposed calendar details beyond the intended access level.

If the problem persists, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide information about the affected mailbox pair, date range, client comparison, reproduction time and time zone, exact error, and relevant permission results. Share a browser trace only through your support request if it's needed.

> [!CAUTION]
> An HTTP Archive (HAR) file records browser network requests and responses. It can contain identities, calendar information, and authentication data. Review it even after a sanitized export, and don't post the HAR file, raw request or response data publicly.

## More information

- [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission).
- [Collect a browser trace for free/busy lookups](collect-free-busy-browser-trace.md).
