---
title: Known issues when using the object model
description: Discusses known issues in Outlook 2010 when you use the object model.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Known issues in Outlook 2010 when you use the object model

_Original KB number:_ &nbsp; 2265515

## Summary

This article describes the known issues that may occur when you use the Microsoft Outlook 2010 object model.

## Cannot create `Outlook.Application` object from an elevated process

You cannot automate Outlook by using a process that is running with elevated permissions in Windows Vista, in Windows 7, or in any other operating system that allows for running processes with elevated permissions. This is an underlying limitation of the COM. Both Outlook and custom programs that automate Outlook must be running at the same integrity level.

## The BeforeItemMove and BeforeFolderMove events don't occur

There are multiple scenarios where the `BeforeItemMove` and `BeforeFolderMove` events don't occur. Known scenarios include deleting appointments from the To-Do bar, deleting meetings from the calendar and To-Do bar, implementing the events on nondefault folders, and deleting items by using the Ignore Conversation command. These problems were fixed in the December 2010 Cumulative Update for Outlook 2010.

## GetProperty method fails in online mode  

If you use Microsoft Exchange 2010 in online mode, and you use the `GetProperty` method to retrieve a property from an unsaved item, the method may fail. This is because of a change in the way that Exchange 2010 handles named properties. Outlook 2007 is also affected. The current workarounds include the following:

- Use Outlook in cached mode.
- Make sure that the item is in a saved state before you call the `GetProperty` method.

## Inspector window may not close correctly  

If you implement the `GetVisibleCallback` function in Microsoft Visual Studio Tools for Microsoft Office (VSTO), the user may be unable to close an inspector window correctly. This issue was fixed in the February 2011 Cumulative Update for Outlook 2010.

## BeforeCheckNames event occurs at a different time than it occurs in Outlook 2007

In Outlook 2010, the BeforeCheckNames event occurs after recipients are resolved instead of before they are resolved. This means that canceling the event has no effect. This problem was corrected in the Outlook 2010 February 2011 Cumulative Update.

## Views object model may not correspond to actual view in the user interface

There are scenarios in which, if you programmatically change views or retrieve view settings, the settings in the object model may not correspond to the actual view settings that Outlook displays in the user interface. Improvements were made in the Outlook 2010 February 2011 Cumulative Update to resolve this problem.

## Attachments are not maintained correctly when you use the Insert Item window

If you use the Outlook object model to add and remove attachments, you may have an extra attachment if a user inserts an item attachment by using the Insert Item command. This is because of a bug in the way that the dialog box treats all attachments as suspect even if they are not suspect. Therefore, extra attachments are saved together with the message. This issue was fixed in the February 2010 Cumulative Update for Outlook 2010.

## Cannot insert item attachments by using a POP/IMAP account

If you use the `Attachments.Add` method to add Outlook item attachments by using a POP/IMAP account, the call fails. This issue was fixed in the December 2010 Cumulative Update for Outlook 2010.

## `MailItem.Recipients.ResolveAll` function removes recipients from the To field

If the user adds an unresolved recipient to a message in compose mode, and then the `Recipients.ResolveAll` method is called for that item, the recipients are removed. There are no plans to change this behavior.

## The `GetAssociatedAppointment` method fails for a meeting request in the Sent Items folder

If you try to retrieve an appointment from a meeting request in the Sent Items folder, the call fails. This issue was fixed in the February 2011 Cumulative Update for Outlook 2010.

## Appointment data may not be updated if an inspector window is open

Because of internal changes in the way that Outlook 2010 handles and caches appointments, the object model may not provide up-to-date information about exceptions to appointments if the corresponding appointment is open in an inspector window. This behavior occurs even if you de-reference and re-retrieve the item from the store. To work around this problem, make sure that the appointment window is closed. There are no plans to change this behavior.

## `NavigationFolder.Folder` generates error on shared folder

If you try to get the Folder object from a `NavigationFolder` object, you may receive an "Operation failed" error message. This problem occurs with shared calendar folder features that are new in Outlook 2010. Retrieving the `NavigationFolder.Folder` object before Outlook has initialized it causes this problem to occur. This initialization doesn't take place by default. To work around this problem, first reference the default calendar folder and call the `GetExplorer` method. This indirectly causes Outlook to initialize the shared calendars. The following Outlook VBA code example illustrates this issue and the workaround:

```vb
Sub GetCalendars()
  ' Work around
  Set oCalFolder = Session.GetDefaultFolder(olFolderCalendar)
  Set oCalExp = oCalFolder.GetExplorer

  Dim oModules As Outlook.CalendarModule
  Dim oMyCalendarGroup As Outlook.NavigationGroup
  Dim oPeopleNavGroup As Outlook.NavigationGroup
  Set oModules = ActiveExplorer.NavigationPane.Modules.GetNavigationModule(OlNavigationModuleType.olModuleCalendar)
  Set oMyCalendarGroup = oModules.NavigationGroups.GetDefaultNavigationGroup(OlGroupType.olMyFoldersGroup)
  Set oPeopleNavGroup = oModules.NavigationGroups.GetDefaultNavigationGroup(OlGroupType.olPeopleFoldersGroup)
  GetNavFolders oMyCalendarGroup
  GetNavFolders oPeopleNavGroup
End Sub

Private Sub GetNavFolders(ByVal obj As Outlook.NavigationGroup)
  Set oNavFolders = obj.NavigationFolders
  Dim oNavFolder As Outlook.NavigationFolder
  For Each oNavFolder In oNavFolders
    Debug.Print oNavFolder.DisplayName & "==>" & oNavFolder.Folder ' <-- this errors
  Next
End Sub
```
