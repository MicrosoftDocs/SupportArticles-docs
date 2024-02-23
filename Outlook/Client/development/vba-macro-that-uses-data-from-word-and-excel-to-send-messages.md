---
title: VBA macro that uses data from Word and Excel to send messages
description: This article describes a Visual Basic for Applications macro that uses data from a Microsoft Word document and a Microsoft Excel workbook to send messages from Microsoft Outlook.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook
search.appverid: MET150
ms.reviewer: v-six
author: cloud-writer
ms.author: meerak
ms.date: 10/30/2023
---
# VBA macro that uses data from a Word document and an Excel workbook to send messages from Outlook

## Summary

This article describes a Visual Basic for Applications macro that uses data from a Microsoft Word document and a Microsoft Excel workbook to send messages from Microsoft Outlook.

## More information

> [!IMPORTANT]
> Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

The following example assumes that there are two defined names in the worksheet:

- The first defined name, _subjectcell_, refers to a cell that contains the message subject line (for example, "This is a test message.").
- The second defined name, _tolist_, refers to the first cell in the horizontal list that contains a list of recipients (for example, "John Doe", "Jane Doe", and so forth).

You must also have a Microsoft Word document. The text of this document is used by the macro as the message body of your mail message.

```vb
Sub SendOutlookMessages()'Dimension variables.
    Dim OL As Object, MailSendItem As Object
    Dim W As Object
    Dim MsgTxt As String, SendFile As String
    Dim ToRangeCounter As Variant
    
    'Identifies Word file to send
    SendFile = Application.GetOpenFilename(Title:="Select MS Word " & _
    "file to mail, then click 'Open'", buttontext:="Send", _
    MultiSelect:=False)'Starts Word session
    Set W = GetObject(SendFile)'Pulls text from file for message body
    MsgTxt = W.Range(Start:=W.Paragraphs(1).Range.Start, _
    End:=W.Paragraphs(W.Paragraphs.Count).Range.End)'Ends Word session
    Set W = Nothing
    
    'Starts Outlook session
    Set OL = CreateObject("Outlook.Application")
    Set MailSendItem = OL.CreateItem(olMailItem)
    
    ToRangeCounter = 0
    
    'Identifies number of recipients for To list.
    For Each xCell In ActiveSheet.Range(Range("tolist"), _
    Range("tolist").End(xlToRight))
    ToRangeCounter = ToRangeCounter + 1
    Next xCell
    
    If ToRangeCounter = 256 Then ToRangeCounter = 1
    
    'Creates message
    With MailSendItem
    .Subject = ActiveSheet.Range("subjectcell").Text
    .Body = MsgTxt
    
    'Creates "To" list
    For Each xRecipient In Range("tolist").Resize(1, ToRangeCounter)
    RecipientList = RecipientList & ";" & xRecipient
    Next xRecipient
    
    .To = RecipientList
    .Send
    End With
    
    'Ends Outlook session
    Set OL = Nothing
    
End Sub
```
