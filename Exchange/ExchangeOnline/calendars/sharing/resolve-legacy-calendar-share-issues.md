---
title: Resolve issues with calendar sharing in classic Outlook for Windows
description: Identify legacy MAPI calendar sharing, verify calendar permissions, resolve delayed or stale updates, and move users to modern calendar sharing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.reviewer: shanefe
ms.custom:
  - sap: Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid: MET150
appliesto:
  - Exchange Online
  - Outlook for Microsoft 365
  - Outlook on the web
ms.service: exchange-online
ms.topic: troubleshooting
ms.date: 10/28/2026
ai-usage: ai-assisted
---

# Resolve issues with calendar sharing in classic Outlook for Windows

## Summary

Calendar sharing in classic Outlook for Windows uses the legacy direct-MAPI model. In this model, Outlook connects to the calendar owner's mailbox and reads the shared calendar directly. It doesn't create a synchronized calendar folder in the recipient's mailbox.

Use this article to identify that the legacy model is in use, check permissions, resolve common client issues, and move a shared calendar to the modern sharing model.

## Symptoms

You experience one or more of the following symptoms when using a legacy shared calendar:

- Calendar updates are delayed or items appear stale.
- Permission changes aren't reflected in the recipient's access.
- The calendar works in classic Outlook but not in Outlook on the web, or vice versa.

## Cause

The legacy calendar sharing model relies on the Outlook client's connection to the calendar owner's mailbox instead of a synchronized folder in the recipient's mailbox. Calendar permissions control access, and the client connection and caching configuration can affect the calendar data shown in Outlook.

For the model and synchronization differences between legacy and modern calendar sharing, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/outlook/calendar-sharing-in-microsoft-365).

## Resolution

Identify the sharing model, and then follow the checks for the affected symptom.

### Identify the model used to share a calendar

The following characteristics indicate the the legacy sharing model was used:

- In classic Outlook, the shared calendar's folder type doesn't include `(REST)`.
- Exchange mailbox folder statistics for the recipient don't show a synchronized folder for the shared calendar.
- The client reads the calendar directly from the owner's mailbox instead of a locally synchronized calendar folder.

Run the [Get-MailboxFolderStatistics](/powershell/module/exchangepowershell/get-mailboxfolderstatistics) cmdlet to review calendar folders in the recipient's mailbox:

```powershell
Get-MailboxFolderStatistics recipient@contoso.com -FolderScope Calendar |
    Format-Table Name,FolderPath,FolderType
```

To review permissions on the owner's calendar, run the following cmdlet:

```powershell
Get-MailboxFolderPermission owner@contoso.com:\Calendar
```

For details about how to check the type of calendar folder in classic Outlook, see [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/outlook/how-to-enable-and-disable-the-outlook-calendar-sharing-updates).

### Fix delayed or stale updates

The legacy sharing model relies on the Outlook client's connection to the owner's mailbox. If changes are delayed or items appear stale:

1. Confirm that the recipient can connect to Exchange and open their own mailbox normally.
1. Select the shared calendar and refresh the folder in classic Outlook.
1. Restart Outlook.
1. Remove the shared calendar from the recipient's calendar list, and then add it again.
1. If the problem affects other folders or accounts in the same Outlook profile, test with a new Outlook profile.
1. Review Cached Exchange Mode settings if older items are missing.

For expected synchronization behavior, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/outlook/calendar-sharing-in-microsoft-365). If the issue involves many cached folders in a secondary mailbox, see [Performance and synchronization problems when you work with folders in a secondary mailbox](/troubleshoot/outlook/performance/performance-synchronization-problems-when-work-with-folders-secondary-mailbox). That guidance applies to the secondary-mailbox scenario, not to all shared-calendar issues.

### Resolve permission changes that aren't reflected

1. Run the `Get-MailboxFolderPermission` cmdlet against the owner's calendar and confirm that the recipient has the intended access.
1. Correct the calendar permission if necessary.
1. Restart Outlook after the permission change.
1. Remove and add the shared calendar again so the client establishes a new connection.

Use the least-privileged calendar permission that meets the recipient's needs.

For checking the assigned permissions, see [Get-MailboxFolderPermission](/powershell/module/exchangepowershell/get-mailboxfolderpermission). For the differences between view, edit, and delegate access, see [Share and access a calendar with edit or delegate permissions in Outlook](https://support.microsoft.com/outlook/sharing/share-and-access-a-calendar-with-edit-or-delegate-permissions-in-outlook).

### Compare classic Outlook and Outlook on the web

Classic Outlook and Outlook on the web establish their own connections to the owner's calendar. If the calendar works in one client but not the other:

1. Confirm the folder permission on the owner's calendar.
1. Remove and add the calendar in the affected client.
1. Confirm that the recipient is opening the correct owner's calendar.
1. If the calendar opens in Outlook on the web but not in classic Outlook, test the Outlook profile and client connectivity.
1. If the calendar doesn't open in either client, correct the mailbox folder permission before troubleshooting the client.

### Move to modern calendar sharing

For better synchronization behavior, remove the legacy calendar entry and add the calendar again through a supported Outlook sharing workflow:

1. Confirm that the owner has granted the recipient the intended calendar permission.
1. In the recipient's client, remove the old shared calendar entry.
1. Add the calendar again by using **Add calendar** > **Open shared calendar**, or accept a new sharing invitation from the owner.
1. In classic Outlook, open the calendar properties and confirm that the folder type includes `(REST)`.
1. Test reading and, when permitted, updating the calendar.

Don't remove the owner's folder permission unless the sharing relationship itself should be revoked. Removing a calendar from the recipient's view and removing the owner's permission are separate actions.

For supported user steps to share and add calendars, see [Share an Outlook calendar as view-only with others](https://support.microsoft.com/outlook/sharing/share-an-outlook-calendar-as-view-only-with-others).

For prerequisites, model verification, and the steps to remove and add a calendar that hasn't yet been upgraded, see [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/outlook/how-to-enable-and-disable-the-outlook-calendar-sharing-updates).

### Verify the resolution

1. Open the shared calendar in the affected client and confirm that the expected events appear.
1. Confirm that the recipient's ability to view or edit events matches the calendar permission.
1. If you moved the calendar to modern sharing, confirm that its folder type includes **(REST)** and compare the events in classic Outlook and Outlook on the web.
