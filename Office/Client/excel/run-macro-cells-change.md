---
title: Run a macro when certain cells change in Excel
description: Describes how to run a macro when certain cells change in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
  - Excel 2000
ms.date: 03/31/2022
---

# How to run a macro when certain cells change in Excel

## Summary

In Microsoft Excel, you can create a macro that is called only when a value is entered into a cell in a particular sheet or in any sheet that is currently open.

Note, however, that you should not call macros unnecessarily because they slow down the performance of Excel.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. In many instances, a macro should run only when a certain number of cells have values entered into them (referred to as the "key cells" in this document). In order to prevent a large macro from running every time a value is entered into a cell of a sheet, you must check to see if the
ActiveCell is one of the key cells. To accomplish this, use the Intersect method on the ActiveCell and the range containing the key cells to verify the ActiveCell is one of the key cells. If the ActiveCell is in the range containing the key cells, you can call the macro.

To create the Visual Basic macro:

1. Right-click the Sheet1 tab and then click View Code.

   The module sheet behind Sheet1 is opened.

1. Type the following code into the module sheet:
    ```
    Private Sub Worksheet_Change(ByVal Target As Range)
        Dim KeyCells As Range
    
    ' The variable KeyCells contains the cells that will
        ' cause an alert when they are changed.
        Set KeyCells = Range("A1:C10")
    
    If Not Application.Intersect(KeyCells, Range(Target.Address)) _
               Is Nothing Then
    
    ' Display a message when one of the designated cells has been 
            ' changed.
            ' Place your code here.
            MsgBox "Cell " & Target.Address & " has changed."
    
    End If
    End Sub
    ```

3. Click **Close and Return to Microsoft Excel** on the File menu.

When you type an entry in cells A1:C10 on Sheet1, a message box is displayed.