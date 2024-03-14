---
title: Date format that's convert a CSV text file by using VBA is not correct
description: Fixes an issue in which the format of dates that are converted from a csv text file into your Excel workbook may not be correct.
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
  - Microsoft Excel
ms.date: 03/31/2022
---

# Date format is not correct when you convert a CSV text file in Excel by using a VBA macro

## Symptoms

When you use a Microsoft Visual Basic for Applications (VBA) macro to convert a Comma-Separated Values (CSV) text file into a Microsoft Office Excel workbook (*.xls), the format of dates that are converted into your Excel workbook may not be correct.

For example, in your CSV file, dates may be in the format of:

dd/mm/yyyy

When you run the following macro to convert your CSV text file into Excel,

```vb
Sub test()

Workbooks.OpenText Filename:="C:\Test1.csv", DataType:=xlDelimited, _
      TextQualifier:=xlTextQualifierNone, FieldInfo:=Array(1, 4)

End Sub
```

dates may be converted in the following format:

mm/dd/yyyy

## Resolution

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To resolve this problem, add the *local:=true* parameter to your VBA macro as in the following example:

```vb
Sub test()

Workbooks.OpenText Filename:="C:\Test1.csv", DataType:=xlDelimited, _
      TextQualifier:=xlTextQualifierNone, FieldInfo:=Array(1, 4), Local:=True

End Sub
```