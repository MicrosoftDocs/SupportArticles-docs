---
title: Manage Microsoft 365 Groups calendar
description: Complete common Microsoft 365 Groups calendar administrative tasks. Find solutions for visibility, access, and notification settings to enhance user experience.
author: cloud-writer
ms.author: meerak
ms.topic: how-to
ms.custom:
  - sap:Microsoft 365 Groups
  - Exchange Online
  - CSSTroubleshoot
  - CI 9487
ms.reviewer: batre
appliesto:
  - Exchange Online
ms.date: 03/04/2026
---

# Manage the Microsoft 365 Groups calendar

## Summary

This article provides essential information and steps for administrators who want to perform common management tasks for the Microsoft 365 Groups calendar. Use the information as guidance to create, configure, and maintain the Microsoft 365 Groups calendar.

## Make a group calendar read-only for members

Administrators can make a group calendar read-only for all members. However, you can't make it read-only for selected members. Group owners can still make changes to the group calendar.

To make a group calendar read-only for all members, follow these steps:

1. Using a work or school account that has the [Groups Administrator](/microsoft-365/solutions/manage-creation-of-groups) role, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the [Set-UnifiedGroup](/powershell/module/exchangepowershell/set-unifiedgroup) PowerShell cmdlet by using the following parameters:

```powershell
   Set-UnifiedGroup "<group name>" -CalendarMemberReadOnly:\$true
```

   Ignore the warning message that appears after the command runs that states that the setting wasn't modified.

1. Optionally, to verify the read-only status of the group calendar, run the [Get-UnifiedGroup](/powershell/module/exchangepowershell/get-unifiedgroup) cmdlet by using the following parameters:

```powershell
   Get-UnifiedGroup "<group name>" -IncludeAllProperties \| fl CalendarMemberReadOnly 
```

## Make a group calendar visible in Outlook or Outlook on the web

Make sure that the Microsoft 365 group isn't hidden from Exchange clients and the address list. In order for the group calendar of a Microsoft 365 group to be visible, the group itself must be visible. If the group is hidden, run the following Exchange Online PowerShell commands to unhide the group:

```powershell
Set-UnifiedGroup -Identity "<group name>" -HiddenFromAddressListsEnabled:\$false

Set-UnifiedGroup -Identity "<group name>" -HiddenFromExchangeClientsEnabled:\$false
```

To use Microsoft 365 Groups in classic Outlook on Windows, you must use [Outlook in Cached Exchange Mode](https://support.microsoft.com/office/get-started-with-microsoft-365-groups-in-outlook-b86c141b-39cf-49d9-a4db-124c3d786204). For more information, see [Turn on Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c).

Group members that are either guests or users from outside the organization can receive email messages and calendar events but can’t see or browse the group in Outlook or Outlook on the web.

## Share a Microsoft 365 Groups calendar

You must [add a user as a member](/microsoft-365/admin/create-groups/add-or-remove-members-from-groups) of the Microsoft 365 Group for them to access group resources like Calendar.

Users from outside the organization and guests can receive and respond to group calendar events but can't access the group calendar.

## Disable Microsoft 365 Groups calendar notifications

To disable calendar notifications for events in a Microsoft 365 group, follow these steps:

1. Using a work or school account that has the [Groups Administrator](/microsoft-365/solutions/manage-creation-of-groups) role, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. Run the [Set-UnifiedGroup](/powershell/module/exchangepowershell/set-unifiedgroup) PowerShell cmdlet by having the `AlwaysSubscribeMembersToCalendarEvents` parameter set to **false**. This parameter controls the default subscription settings for new members that are added to a Microsoft 365 group. You can make changes to this setting without affecting existing group members.

```powershell
   Set-UnifiedGroup "<group name>" -AlwaysSubscribeMembersToCalendarEvents:\$false
```

## Identify who added an event on the calendar

To identify the user that added or modified an event on a group calendar, follow these steps:

1. Using a work or school account that has the [Groups Administrator](/microsoft-365/solutions/manage-creation-of-groups) role, [connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

1. To collect a range of calendar logs, run the [Get-CalendarDiagnosticObjects](/powershell/module/exchange/get-calendardiagnosticobjects) PowerShell cmdlet. The logs track all events that are related to calendar entries for each mailbox. For example, to get a list of all events that are related to a calendar entry for the "Marketing Group" that has "Team Meeting" as the subject, run the following command:

```powershell
   Get-CalendarDiagnosticObjects -Identity "Marketing Group" -Subject "Team Meeting"
```

The output of this command lists the users who are associated with each event.
