---
title: OpenSharedItem holds file handle on signed .msg files
description: The OpenSharedItem method does not release the file handle of an .msg file until Outlook obtains some idle time. This happens only if the .msg file is signed or encrypted (SMIME-based messages).
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
  - Microsoft Office Outlook 2007
search.appverid: MET150
ms.date: 01/30/2024
---
# The OpenSharedItem method for Outlook holds a file handle on signed .msg files

_Original KB number:_ &nbsp; 2633737

## Symptoms

The `OpenSharedItem` method in the object model for Microsoft Outlook does not release the file handle of an .msg file until Outlook obtains some idle time.

## Cause

This behavior occurs if the .msg file is signed or encrypted (SMIME-based messages). It is a limitation of how Outlook internally manages the processing and file handles of SMIME-based .msg files. Outlook does a background verification of the signature on the message and releases the file handle to the .msg file when Outlook obtains some idle time. The .msg file can only be deleted when Outlook has finished all the required processing and has released the file handle.

You can delay the attempt to delete the file, although there is no direct way to determine when Outlook will release the file lock.

## Resolution

There are no plans to change this behavior.

## More information

Office Outlook 2007 and Outlook 2010 provide the `OpenSharedItem` method to open iCalendar (.ics) appointment files, vCard (.vcf) files, and Outlook message (.msg) files. The kind of object that is returned by this method depends on the kind of shared item that is opened.

In the Microsoft Visual Basic for Applications (VBA) Outlook example that follows, the code opens a SignedMessage.msg file by using the `OpenSharedItem` method. The code then tries to delete the .msg file after it closes the mail item. If the .msg file is signed or encrypted, the code causes a **Permission Denied** error. However, if an unsigned or nonencrypted .msg file is opened, the code deletes the .msg file as expected.

```vb
Public Sub TestOpenSharedItem()
    Dim oNamespace As Outlook.NameSpace
    Dim oSharedItem As Outlook.MailItem
    Dim oFolder As Outlook.Folder
    On Error GoTo ErrRoutine

    ' Get a reference to a NameSpace object.
    Set oNamespace = Application.GetNamespace("MAPI")'Open the Signed Message (.msg) file containing the shared item.
    Set oSharedItem = oNamespace.OpenSharedItem("C:\Temp\SignedMessage.msg")'Open the Regular Message (.msg) file containing the shared item.
    'Set oSharedItem = oNamespace.OpenSharedItem("C:\Temp\RegularMessage.msg")

    oSharedItem.Close (olDiscard)
    Set oSharedItem = Nothing

    'Add a reference to Microsoft Scripting Runtime
    Dim oFSO As New FileSystemObject

    ' Try to delete the Signed Message
    oFSO.DeleteFile ("C:\Temp\SignedMessage.msg")'Try to delete the Regular Message
    'oFSO.DeleteFile ("C:\Temp\RegularMessage.msg")

EndRoutine:
    On Error GoTo 0
    Set oSharedItem = Nothing
    Set oFSO = Nothing
    Set oNamespace = Nothing
Exit Sub
ErrRoutine:
Select Case Err.Number
    Case -2147024894 ' &H80070002
        ' Occurs if the specified file or URL could not
        ' be found, or the file or URL cannot be
        ' processed by the OpenSharedItem method.
        MsgBox Err.Description, _
        vbOKOnly, _
        Err.Number & " - " & Err.Source
    Case Else
        ' Any other error that may occur.
        MsgBox Err.Description, _
        vbOKOnly, _
        Err.Number & " - " & Err.Source
End Select
GoTo EndRoutine
End Sub
```
