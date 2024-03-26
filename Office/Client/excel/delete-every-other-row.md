---
title: Delete every other row on a worksheet
description: Provides a sample VBA macro that you can use to remove every other row in a selected range on an Excel worksheet. If you have a list of data that contains multiple columns, select only the first column of data when you run the macro.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: clarkmc
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010
  - Excel 2013
ms.date: 03/31/2022
---

# How to delete every other row on an Excel worksheet

## Summary

This article contains a sample Microsoft Visual Basic for Applications macro that you can use to delete every other row in a selected range on a Microsoft Excel worksheet. 

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To use the following macro, set up an Excel workbook as follows: 

1. Create a new Microsoft Excel workbook.    
2. In a new worksheet, in the range A1:A9, type the numbers 1 to 5, skipping rows, as in the following example: 

    ```excel
    A1: 1
    A2:
    A3: 2
    A4:
    A5: 3
    A6:
    A7: 4
    A8:
    A9: 5
    ```
3. On the Tools menu, point to Macro, and then click Visual Basic Editor. 

   **Note** In Microsoft Office Excel 2007 and later versions, click **Visual Basic** in the **Code** group on the **Developer** tab.   
4. On the Insert menu, click Module.    
5. In the new module, type the following macro: 

```vb
Sub Delete_Every_Other_Row()

' Dimension variables.
   Y = False              ' Change this to True if you want to
                          ' delete rows 1, 3, 5, and so on.
   I = 1
   Set xRng = Selection

' Loop once for every row in the selection.
   For xCounter = 1 To xRng.Rows.Count

' If Y is True, then...
       If Y = True Then

' ...delete an entire row of cells.
           xRng.Cells(I).EntireRow.Delete

' Otherwise...
       Else

' ...increment I by one so we can cycle through range.
           I = I + 1

End If

' If Y is True, make it False; if Y is False, make it True.
       Y = Not Y

Next xCounter

End Sub
```

6. Switch to the worksheet that contains the data, and then select the range A1:A9.    
7. To run the macro, point to Macro on the Tools menu, and then click Macros. 

   > [!NOTE]
   > - In Excel 2007 and later versions, click **Macros** in the **Code** group on the **Developer** tab.
   >- To display the **Developer** tab in the Ribbon, click the **Microsoft Office Button**, click **Excel Options**, click the **Popular category**, click to select the **Show Developer tab in the Ribbon** check box, and then click **OK**.   
8. Select the **Delete_Every_Other_Row** macro, and then click **Run**.    
 
This macro will delete every other row, starting with the second row of the selection. 

> [!NOTE]
> If you have a list of data that contains multiple columns, select only the first column of data, and then run the macro.
