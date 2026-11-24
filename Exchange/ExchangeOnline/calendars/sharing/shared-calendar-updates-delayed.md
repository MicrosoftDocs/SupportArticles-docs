---
title: Modern shared calendar stops updating or has missing events
description: Distinguish client synchronization from mailbox-to-mailbox replication when modern shared calendar updates are delayed or events are missing.
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

# Modern shared calendar stops updating or has missing events

## Summary

This article helps you find where synchronization stops for a modern shared calendar. Modern sharing synchronizes data between mailboxes before the receiver's client displays it, so you compare the same event in the owner's calendar and in the receiver's shared copy. The article also lists the information to collect before you contact Microsoft Support.

## Symptoms

- A shared calendar is stale or stops updating.
- Events are visible to the owner but missing from the receiver's shared calendar.
- Updates appear eventually, but not near the time of the owner's change.

## Cause

Synchronization can stop soon after it is initiated, during mailbox-to-mailbox replication, or client synchronization. Periodic sharing synchronization and instant synchronization are separate processes. A recent successful periodic synchronization doesn't confirm that a specific event replicated instantly.

## Report the issue to Microsoft Support

Collect the following information, and then [contact Microsoft Support](/microsoft-365/admin/get-help-support). Support works with you to investigate where synchronization stops. These steps don't repair mailbox-to-mailbox replication.

1. Identify one owner, one receiver, the exact shared calendar, and one affected meeting. Confirm the sharing model by using [Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26).
1. Open the owner's calendar in Outlook on the web. Then have the receiver open the shared copy in Outlook on the web.
   - If both web views have the event but classic Outlook doesn't, see [Shared calendar events appear in Outlook but not Outlook on the web or vice versa](calendar-differs-between-clients.md).
   - If the owner's web view has the event but the receiver's web view doesn't, continue to the next steps to investigate mailbox-to-mailbox synchronization.
1. For older events, first [check the history window](shared-calendar-history-missing.md). Unequal item counts alone don't indicate data loss.
1. [Collect calendar diagnostic logs](../cdl/get-calendar-diagnostic-logs.md) for both mailboxes by using the same meeting ID:

   ```powershell
   .\Get-CalendarDiagnosticObjectsSummary.ps1 -Identity "owner@contoso.com","receiver@contoso.com" -MeetingId "CleanGlobalObjectId" -ExportToExcel
   ```

   Replace `CleanGlobalObjectId` with the clean global object ID of the affected meeting.
1. In the receiver's logs, clear the `LogRowType` filter so that `SyncOrReplication` rows appear. Correlate the meeting ID and `SharedFolderName` with the intended owner's calendar.
   - `CalendarReplication` indicates instant replication activity.
   - `CalendarSyncAssistant` indicates periodic synchronization activity.
   - Compare the timestamps of the owner's update and the corresponding receiver replication. Don't compare unrelated updates to the same meeting.
1. If replication is still missing or delayed, contact Microsoft Support, and provide both sets of logs and the time of the affected change. Missing log rows can also reflect incomplete collection or log retention. By themselves, they don't confirm a service failure.

> [!IMPORTANT]
> Don't remove and re-add calendar permissions or turn off shared calendar improvements to fix an established modern-sharing synchronization failure. Make advanced repairs or MFCMAPI changes only with guidance from Microsoft Support.
