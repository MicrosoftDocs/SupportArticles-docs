---
title: Can't delete default Outlook folders
description: Provides information about an issue in which you can't delete default Outlook folders.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Developer Issues\Macros
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 03/25/2025
---

# Can't delete default Outlook folders

_Original KB number:_ &nbsp; 306253

In Outlook, all of the default folders must be available; therefore, Outlook doesn't allow you to delete default folders. You can use a Microsoft Exchange utility or the older Microsoft Exchange Client program to delete these folders; however, Outlook recreates these folders when Outlook starts.

## Limiting access to default Outlook folders

As an administrator, if you don't want end users to use one of the Outlook modules, such as the Journal or Tasks folder, you can't delete the folder to remove this functionality. However, you can create a Component Object Model (COM) add-in that prevents users from switching to the folder. You can implement the `FolderSwitch` event, and then cancel the event if the user tries to switch to a specific folder.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you're familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they won't modify these examples to provide added functionality or construct procedures to meet your specific needs.

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

The user can still move or copy items to the folder, so you might want to implement the `ItemAdd` event on the folder that you disabled. The `ItemAdd` event allows you to warn the user and move the items to another folder programmatically.
