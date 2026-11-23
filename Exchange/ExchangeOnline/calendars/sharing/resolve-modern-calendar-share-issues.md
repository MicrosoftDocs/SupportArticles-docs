---
title: Resolve issues with modern calendar sharing
description: Describes how to Verify calendar permissions and synchronized folders, compare Outlook clients, and troubleshoot common modern shared-calendar symptoms.
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

# Resolve issues with modern calendar sharing

## Summary

Modern calendar sharing in Exchange Online gives a recipient a synchronized copy of a shared calendar. Use the checks in this article to verify calendar permissions, confirm that the shared calendar exists, and separate issues with a Microsoft Outlook client from mailbox-side issues.

These steps are intended for tenant administrators. Before you begin, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

> [!TIP]
> You can use the [Modern Sharing Relationship TSG Script](https://github.com/microsoft/CSS-Exchange/releases/latest/download/Check-SharingStatus.ps1) from CSS-Exchange to run most of these cmdlets.

## Symptoms

You experience one or more of the following symptoms:

- The sharing invitation has no **Accept** button.
- The shared calendar is blank or missing events.
- A recipient with edit permissions can view but not edit the calendar.
- Outlook and Outlook on the web show different results.

## Cause

The cause depends on the symptom. Calendar permissions determine whether a recipient can view or edit the calendar. A shared calendar can appear empty before its initial synchronization is complete. A disclaimer transport rule that wraps a sharing invitation can remove the **Accept** button. Client configuration and synchronization behavior can also affect the results shown in Outlook.

For supporting guidance, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/outlook/calendar-sharing-in-microsoft-365), [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/outlook/how-to-enable-and-disable-the-outlook-calendar-sharing-updates), and [Accept button is missing on a calendar from a sharing invitation](../../outlook-on-the-web-issues/cannot-open-calendar-from-sharing-invitation.md).

## Resolution

Use the following checks to identify the affected sharing relationship and resolve the associated symptom.

### Identify the affected sharing relationship

Collect the following information:

- The calendar owner's primary SMTP address.
- The recipient's primary SMTP address.
- The name of the shared calendar.
- The affected Outlook client and version.
- Whether the problem also occurs in Outlook on the web.
- For a missing or delayed event, the subject and the approximate creation or modification time.

Use Outlook on the web to determine whether the issue is limited to a desktop client. If the event appears in Outlook on the web but not in Outlook for Windows, review the Outlook client configuration and synchronization state. If the event is missing in both clients, continue with the mailbox checks below.

### Verify calendar permissions

Run the [`Get-MailboxFolderPermission`](/powershell/module/exchangepowershell/get-mailboxfolderpermission) cmdlet to confirm that the recipient has the expected permission on the owner's calendar:

```powershell
Get-MailboxFolderPermission -Identity "owner@contoso.com:\Calendar"
```

In the output, verify that:

- The recipient is listed.
- `AccessRights` matches the access that the owner intended to grant.
- Delegate-related flags, when applicable, match the intended delegate configuration.

If the recipient is missing or has the wrong access, correct the permission by using the documented Exchange Online calendar-permission cmdlets or have the owner share the calendar again from Outlook.

### Verify that the recipient has a shared-calendar folder

Run the [`Get-MailboxFolderStatistics`](/powershell/module/exchangepowershell/get-mailboxfolderstatistics) cmdlet to list calendar folders in the recipient's mailbox:

```powershell
Get-MailboxFolderStatistics -Identity "recipient@contoso.com" -FolderScope Calendar |
    Format-Table Name, FolderPath, FolderType, ItemsInFolder, FolderSize
```

Confirm that a folder corresponding to the shared calendar appears in the results. The folder name can differ from the owner's SMTP address, especially when the owner shares a secondary calendar.

If the shared calendar is absent, ask the recipient to add it again from Outlook by using **Add Calendar** > **Open Shared Calendar**.

### Inspect the shared-calendar folder

Run the [`Get-MailboxCalendarFolder`](/powershell/module/exchangepowershell/get-mailboxcalendarfolder) cmdlet to retrieve information about the recipient's shared-calendar folder:

```powershell
$path = "recipient@contoso.com:\Calendar\Owner"
Get-MailboxCalendarFolder -Identity $path | Format-List
```

Replace `Owner` with the folder name returned by the `Get-MailboxFolderStatistics` cmdlet. Compare the result with the intended owner and sharing configuration. If the folder can't be found, confirm the exact folder path before changing permissions or asking the recipient to add the calendar again.

### Check classic Outlook for Windows

For classic Outlook for Windows:

1. Confirm that Microsoft 365 Apps and Outlook are up to date.
1. In Outlook account settings, verify that **Turn on shared calendar improvements** is enabled.
1. Restart Outlook after changing the setting.
1. Open the calendar module and confirm that the calendar appears under **Shared Calendars**.

For more information, see [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26).

> [!IMPORTANT]
> Don't disable shared calendar improvements as a general troubleshooting step. The improvements are enabled by default in current Microsoft 365 Apps versions.

### Remove and add the shared calendar in Outlook

If permissions are correct but the shared calendar is missing from Outlook, add it again:

1. In the Outlook calendar module, select **Add Calendar**.
1. Select **Open Shared Calendar**.
1. Enter the name of the person who shared the calendar.
1. Select **OK**.
1. Confirm that the calendar appears under **Shared Calendars**.

Follow the instructions in [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26) before removing mailbox permissions. Removing and recreating permissions can change delegate behavior and should not be used as an initial diagnostic step.

### The sharing invitation has no Accept button

Confirm that the owner shared the calendar by using Outlook's calendar-sharing workflow rather than forwarding an ordinary email message. If mail flow rules add disclaimers or otherwise modify calendar-sharing messages, test with the relevant rule disabled in a controlled manner and review the rule configuration.

For the disclaimer-rule scenario, see [Accept button is missing on a calendar from a sharing invitation](../../outlook-on-the-web-issues/cannot-open-calendar-from-sharing-invitation.md). If the button is missing only in an Outlook application, try accepting the invitation in Outlook on the web, as described in [Manage someone else's calendar in Outlook on the web](https://support.microsoft.com/outlook/manage-someone-else-s-calendar-in-outlook-on-the-web).

### The shared calendar is blank or missing events

1. Verify the owner's permissions with `Get-MailboxFolderPermission`.
1. Verify that the recipient's shared-calendar folder exists with `Get-MailboxFolderStatistics`.
1. Compare the calendar in Outlook on the web and Outlook for Windows.
1. Confirm that Outlook shared calendar improvements are enabled.
1. Remove and add the shared calendar in Outlook if it is missing from the calendar list.

For a single missing event, record the event subject, organizer, start time, last known modification time, and the clients used by the owner and recipient. Avoid making broad permission changes while investigating one event.

For initial synchronization delays after adding a calendar, see [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26). For documented product issues, see [Known issues with classic Outlook Desktop Shared Calendar Improvements](https://support.microsoft.com/support/known-issues/known-issues-with-classic-outlook-desktop-shared-calendar-improvements).

### A recipient can view but cannot edit the calendar

Run `Get-MailboxFolderPermission` and confirm that the recipient has an access right that permits edits. The recipient can't edit the calendar when the assigned permission only allows viewing. After a permission change, retest in Outlook on the web before troubleshooting the desktop client.

For the required permission levels, see [Share and access a calendar with edit or delegate permissions in Outlook](https://support.microsoft.com/outlook/sharing/share-and-access-a-calendar-with-edit-or-delegate-permissions-in-outlook).

### Outlook and Outlook on the web show different results

Treat Outlook on the web as the mailbox-side comparison point:

- If Outlook on the web is correct, update and restart Outlook for Windows, verify shared calendar improvements, and add the calendar again if necessary.
- If both clients show the same missing or incorrect data, recheck the mailbox permission and shared-folder path before making any configuration change.

For expected synchronization behavior across Outlook clients and sharing configurations, see [Calendar sharing in Microsoft 365](https://support.microsoft.com/outlook/calendar-sharing-in-microsoft-365).

### Verify the resolution

1. Open the shared calendar in Outlook on the web and in the affected Outlook client.
1. Confirm that the recipient can see the expected events.
1. If the recipient has edit permissions, confirm that they can update an event and that the change appears in the owner's calendar.
1. If the issue involved a sharing invitation, send a new invitation and confirm that the recipient can accept it.
