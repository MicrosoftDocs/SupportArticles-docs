---
title: Programmatically save an excel file to a network drive
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Microsoft Excel
---

# Save a file to a network drive programmatically in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

In Microsoft Excel, you can save a file to any drive to which you have write and delete privileges. In addition, you can use a Microsoft Visual Basic for Applications macro to save the active workbook and use a variable for the file name. You can use variables from the ActiveWorkbook.Nameproperty, from input box data, or from a cell reference.

> [!NOTE]
> If you use the full path for the file name, Microsoft Excel will know exactly where to save the file. If the path is not given, Microsoft Excel will save the file to the currently active directory or folder.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

### Sample Macro 1

Save the active workbook with a variable to a specified path. To do this, use the following macro:

```vb
   Sub SaveWithVariable()
       Dim MyFile As String

       MyFile = ActiveWorkbook.Name
       ' Do not display the message about overwriting the existing file.
       Application.DisplayAlerts = False
       ' Save the active workbook with the name of the
       ' active workbook. Save it on the E drive to a folder called
       ' "User" with a subfolder called "JoeDoe."
       ActiveWorkbook.SaveAs Filename:="E:\User\JoeDoe\" & MyFile
       ' Close the workbook by using the following.
       ActiveWorkbook.Close
   End Sub
```

### Sample Macro 2

Use a file name stored in a cell and save the file to the network server. To do this, use the following macro:

```vb
   Sub SaveWithVariableFromCell()
       Dim SaveName As String
       SaveName = ActiveSheet.Range("A1").Text
       ActiveWorkbook.SaveAs Filename:="E:\User\JoeDoe\" & _
           SaveName & ".xls"
   End Sub
```
