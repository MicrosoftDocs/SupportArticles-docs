---
title: Legacy MAPI shared calendar updates or permission changes are delayed in Outlook
description: Investigate stale legacy shared calendars, delayed permission changes, and missing items, and determine whether modern sharing is appropriate.
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
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Legacy MAPI shared calendar updates or permission changes are delayed in Outlook

## Summary

This article describes how to check client synchronization and permissions when a legacy MAPI shared calendar is stale or doesn't reflect permission changes. It covers refreshing a legacy entry, checking view filters, and identifying an eligible calendar upgrade. Don't apply these steps to a confirmed modern-sharing replication failure.

## Symptoms

- Calendar updates appear only after a synchronization cycle, by selecting **Update Folder**, or by reopening the view.
- Permissions are correct, but classic Outlook still won't open the calendar.
- Classic Outlook and Outlook on the web show different data.
- Old items are missing from a cached view.

## Cause

Legacy MAPI access connects the client directly to the owner's mailbox instead of using a modern shared-calendar copy in the receiver's mailbox. Updates depend on client activity and connectivity. Cached permissions, synchronization filters, or client problems can also cause stale or missing data.

## Resolution

1. Confirm the sharing model. In classic Outlook, right-click the shared calendar and select **Properties**.
   A legacy folder type doesn't include `(REST)`. Also check the account mode and the sharing relationship before concluding that the calendar is legacy.
1. If the calendar is stale, confirm that Outlook is connected and select **Update Folder**. Check the owner's calendar in Outlook on the web to verify that the expected data exists.

   Compare the same event in the receiver's view. If it matches the owner's calendar now, stop troubleshooting that discrepancy. If updates require repeated manual refreshes, continue with the next steps.

1. If a recent permission change isn't reflected, verify the intended permission with [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission):

   ```powershell
   Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar"
   ```

   Replace the identity with the owner's calendar path. Restart classic Outlook to refresh the client session. If necessary for a confirmed legacy entry, remove only the shared-calendar entry from the receiver's navigation pane and open it again. Don't delete the owner's calendar or remove its permissions.

   For a user with both Full Access and delegate permissions, see [Resolve Full Access and delegate conflicts on legacy calendars](../permissions/fix-full-access-delegate-conflicts.md).

   Reopen the calendar and confirm that the intended permission takes effect. If access works, no further entry recreation is needed.

1. For missing older items, check the client view and cache filters. If a filter hides the affected event, remove that filter and compare the same event with the web calendar. If the views agree, stop troubleshooting that discrepancy.
1. If both mailboxes are in Exchange Online and the relationship is eligible, follow the documented [shared calendar upgrade guidance](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26) rather than expecting instant updates from legacy access.

   After the upgrade, confirm `(REST)` in classic Outlook and check that a new test change appears without a manual refresh. If it does, no further action is needed.

### If the issue persists

If access or synchronization still fails, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the owner and receiver identities, calendar path, Outlook build, account mode, exact error, and test time with time zone. Include information about which checks changed the behavior.
