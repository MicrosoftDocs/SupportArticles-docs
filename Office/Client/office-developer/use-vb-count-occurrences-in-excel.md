---
title: Use Visual Basic for Applications to count character occurrences in Excel
description: This article describes the use of a Visual Basic for Applications macro to count the number of occurrences of a specific character in a selected range.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Office Excel 2007
---

# How to use Visual Basic for Applications to count the occurrences of a character in a selection in Excel

## Summary

In Microsoft Excel, you can use a macro to count the occurrences of a specific character in a cell or range of cells. This article contains a sample macro to count the occurrences of a specific character in a cell or range of cells.

You can also use a formula to accomplish the task. If you prefer not to use a macro, click the following article numbers to view the articles in the Microsoft Knowledge Base:

[187667](https://support.microsoft.com/help/187667) Formulas to count the occurrences of text, characters, or words in Excel for Mac

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Sample Visual Basic procedure

The following Visual Basic procedure prompts you for a character (or characters), then searches through the currently selected cell, or range of cells, and displays a message box showing the total number of occurrences of that character or character string. This works for all alphanumeric characters.

```vb
Dim Count As Integer
Dim Target As String
Dim Cell As Object
Dim N As Integer

Sub Target_Count()
   Count = 0
   Target = InputBox("character(s) to find?")
   If Target = "" Then GoTo Done
      For Each Cell In Selection
         N = InStr(1, cell.Value, target)
         While N <> 0
            Count = count + 1
            N = InStr(n + 1, cell.Value, target)
         Wend
      Next Cell
   MsgBox count & " Occurrences of " & target
Done:
End Sub

```