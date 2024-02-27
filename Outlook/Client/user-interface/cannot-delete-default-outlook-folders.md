---
title: Cannot delete default Outlook folders
description: Provides more information about an issue that you can't delete default Outlook folders.
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
  - Outlook
search.appverid: MET150
ms.date: 01/30/2024
---
# Cannot delete default Outlook folders

_Original KB number:_ &nbsp; 306253

## Summary

In Outlook, all of the default folders must be available; therefore, Outlook does not allow you to delete default folders. You can use a Microsoft Exchange utility or the older Microsoft Exchange Client program to delete these folders; however, Outlook recreates these folders when Outlook starts.

## More information

As an administrator, if you do not want end users to use one of the Outlook modules, such as the Journal or Tasks folder, you cannot delete the folder to remove this functionality. However, in Outlook 2000 or later, you can create a Component Object Model (COM) add-in that prevents users from switching to the folder. You can implement the `FolderSwitch` event, and then cancel the event if the user tries to switch to a specific folder.

> [!NOTE]
> Outlook 97 and Outlook 98 do not support COM add-ins; therefore, you cannot create a custom solution to implement this functionality in Outlook 97 and Outlook 98.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs.

For more information about the support options that are available and about how to contact Microsoft, see [Microsoft Support](https://support.microsoft.com/?scid=fh;en-us;cntactms). The following Outlook Microsoft Visual Basic for Applications (VBA) code illustrates how you can prevent users from switching to a folder. Implement this code as an Outlook COM add-in so that the code can be deployed.

The following is the Outlook VBA code:

```vb
Dim WithEvents oExp As Outlook.Explorer
Dim oJournalFolder As Outlook.MAPIFolder

Private Sub Application_Startup()
    Set oExp = ActiveExplorer
    Set oJournalFolder = Session.GetDefaultFolder(olFolderJournal)
End Sub

Private Sub Application_Quit()
    Set oExp = Nothing
    Set oJournalFolder = Nothing
End Sub

Private Sub oExp_BeforeFolderSwitch(ByVal NewFolder As Object, Cancel As Boolean)
    If NewFolder = oJournalFolder Then
    MsgBox "The Journal folder is disabled."
    Cancel = True
    End If
End Sub
```

The user can still move or copy items to the folder, so you may want to implement the `ItemAdd` event on the folder that you disabled. The `ItemAdd` event allows you to warn the user and move the items to another folder programmatically.
