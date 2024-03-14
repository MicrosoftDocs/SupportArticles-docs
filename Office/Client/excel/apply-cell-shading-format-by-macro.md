---
title: Use macro to apply cell shading format to every other row in a selected range
description: Describes how to use a macro to apply cell shading format to every other row in a selected range in Excel.
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

# Use a macro to apply cell shading format to every other row in a selected range in Excel

## Summary

Microsoft Excel automatically formats new data that you type at the end of a list to match the previous rows. You can also format a list programmatically. This article contains a sample Microsoft Visual Basic for Applications procedure to shade every other row in a selection.

## More information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To see the patterns available in Microsoft Office Excel 2003 and in earlier versions, click Cells on the **Format** menu, and then click the **Patterns** tab.

To see the patterns available in Microsoft Office Excel 2007, follow these steps:

1. On the **Home** tab, click **Format** in the **Cells** group. Then, click **Format Cells.**.   
2. In the **Format Cells** dialog box, click the **Fill** tab.   

The **Pattern** drop-down list displays the available patterns. The pattern that is used in the following macro, referred to by its constant name, xlGray16, is the fifth one from the right in the first row.

The following macro sets the pattern in every other row of the current selection to xlGray16.

### Sample Visual Basic Procedure

```vb
Sub ShadeEveryOtherRow()
    Dim Counter As Integer

   'For every row in the current selection...
    For Counter = 1 To Selection.Rows.Count
        'If the row is an odd number (within the selection)...
        If Counter Mod 2 = 1 Then
            'Set the pattern to xlGray16.
            Selection.Rows(Counter).Interior.Pattern = xlGray16
        End If
    Next

End Sub
```

> [!NOTE]
> This macro runs only on the rows of the selected range. If you add any new rows of data after you run the macro, you must run the macro again with all the new rows of data selected.

This process can also be done manually by using conditional formatting. 

For more information about how to format every other row by using conditional formatting, see [Apply shading to alternate rows in a worksheet](https://support.microsoft.com/help/268568).

You can also format a list by using the **Auto-Format** menu command. In Excel 2003 and in Microsoft Excel 2002, the **Auto-Format** menu command is on the **Format** menu. In Excel 2007, you have to add the **Auto-Format** menu command to the Quick Access Toolbar. To do this, follow these steps:

1. Click **Microsoft Office Button**, and then click **Excel Options**.    
2. Click **Design customization**.   
3. Click to select the **All Commands** under the **Choose commands from**.   
4. Click **Auto-Format**, click **Add**, and then click **OK**.   
