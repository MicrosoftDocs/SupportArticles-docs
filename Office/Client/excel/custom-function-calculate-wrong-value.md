---
title: Custom function may not calculate correct value
description: Describes an issue in which custom function may not calculate expected value in Excel when you calculate worksheet, and provides a workaround.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Extensibility\Macros
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 05/26/2025
---

# Custom function may not calculate expected value in Excel

## Symptoms

When you calculate your worksheet, some cells may appear to have calculated the wrong value.

## Cause

This problem occurs when the following conditions are true:

- A cell on the worksheet contains a custom function.

- The custom function contains one or more arguments that refer to a range of cells on the worksheet.

- The result of the custom function depends on more cells than it directly references.

This behavior is by design of Microsoft Excel. When Excel calculates the cell containing the custom function, it recalculates all cell ranges that are passed as arguments to your custom function. If the result of your function depends on cells that are not explicitly referred to by the function, then those cells may not be recalculated.

## Workaround

To work around this problem, use any of the following methods.

### Method 1: Modify your function so that all relevant cell ranges are passed

Modify your function to accept as arguments all of the cells necessary to calculate the result of the function.

### Method 2: Make your custom function volatile

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.If you make your custom function volatile, this problem will not occur. To make your custom function volatile, add the following line of code to the function.

```vb
Application.Volatile
```

> [!NOTE]
> If you make your custom function volatile, it will recalculate every time you make a change to a value or recalculate an open workbook. This could impact the performance of your worksheet model.

### Method 3: Force Excel to recalculate all open workbooks

Press CTRL+ALT+F9 to recalculate the values in all open workbooks. In Microsoft Office Excel 2007, press CTRL+ALT+SHIFT+F9 to recalculate the values in all open workbooks.

## More information

### Example of the problem

To illustrate this problem, follow these steps:

1. Close and save any open workbooks, and then open a new workbook.
2. Start the Visual Basic Editor (press ALT+F11).
3. On the **Insert** menu, click **Module**.
4. Type the following code into the module sheet:

    ```vb
    ' This function counts the number of blank cells by starting from the cell 
    ' referred to by the rngStartCell argument and moving up the column.
    
    Function FindTextUp(rngStartCell As Range) As Single
        Dim iIndex As Integer
    
    For iIndex = 0 To 100
            If rngStartCell.Value <> "" Then
                FindTextUp = iIndex
                Exit Function
            Else
                Set rngStartCell = rngStartCell.Offset(-1, 0)
            End If
        Next iIndex
    End Function
    ```

5. Press ALT+F11 to return to Excel.
6. Type Test, in cell A2, and then press ENTER.
7. Type the following formula in cell A10, and then press ENTER:

    ```excel
    =FindTextUp(A9)
    ```

    The formula returns a value of 7.

8. Type Another test in cell A5, and then press ENTER.

The formula still returns a value of 7, when a value of 4 is expected. In this example, the FindTextUp function explicitly refers to cell A9. However, the function may depend on cells A1:A8, depending on the data entered in the worksheet.

If you implement method 1 in the "Workaround" section of this article, the function will calculate the expected result. The following line of code illustrates how to modify the function in this example so that the expected result is calculated.

```vb
Function FindTextUp(rngStartCell As Range, rngOtherCells As Range) As Single
```

Now, if you replace the function call in step 7 with the following function call, the function will always return the expected result.

```excel
=FindTextUp(A9,A1:A8)
```
