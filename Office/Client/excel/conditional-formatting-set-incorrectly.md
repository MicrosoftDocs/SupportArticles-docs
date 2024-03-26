---
title: The conditional formatting is set incorrectly when using VBA in Excel
description: Discusses a workaround  for a problem that occurs in Excel in which conditional formatting may be set incorrectly when you use a VBA macro.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2002
  - Excel 2000
ms.date: 03/31/2022
---

# The conditional formatting may be set incorrectly when you use VBA in Excel

## Symptoms

Consider the following scenario.

- You select a cell in a worksheet in Microsoft Excel 2000 or in a later version of Excel.
- You use Microsoft Visual Basic for Applications (VBA) to create a formula-based conditional formatting program.
- You use relative cell references in the VBA conditional formatting program.
- You apply the conditional formatting to a cell other than the selected cell.

When you apply the conditional formatting, you notice that the conditional formatting is not set correctly.

For example, you experience this problem when you use a program that includes VBA code in an Excel worksheet that is similar to the following code:

```vb
Sub Example()
ThisWorkbook.Worksheets(1).Range("A1").Select
With ThisWorkbook.Worksheets(1).Range("B1")
.FormatConditions.Delete
.FormatConditions.Add Type:=xlExpression, _
Formula1:="=A1=1"
.FormatConditions(1).Interior.ColorIndex = 46
End With
End Sub
```

This code automatically applies the conditional formatting to cell B1 when you enter "1" in cell A1. When you enter "1" in cell A1, you expect the color of cell B1 to change to red. However, the color of the cell does not change. The color of cell B1 changes to red only if you enter "1" in cell B1.

Additionally, the **Conditional Formatting** dialog box displays the formula as =B1=1 instead of =A1=1.

## Workaround

To work around this issue, use one of the following methods.

### Method 1: Use absolute cell references

You can use absolute cell references to refer to the cell that contains the formula instead of to refer to relative cell references.

For example, you can modify the Formula1:="=A1=1" text entry in the VBA code that is described in the "Symptoms" section as Formula1:="=$A$1=1" to make the code use absolute cell references. This modified version of the VBA code is as follows:

```vb
Sub Example()

ThisWorkbook.Worksheets(1).Range("A1").Select

With ThisWorkbook.Worksheets(1).Range("B1")
     .FormatConditions.Delete
     .FormatConditions.Add Type:=xlExpression, Formula1:="=$A$1=1"
     .FormatConditions(1).Interior.ColorIndex = 46
End With

End Sub
```

### Method 2: Select the cell that you want to use for conditional formatting before you apply the formula

When you want to apply conditional formatting to a cell, first select the cell that you want to use for the conditional formatting. Then, select the cell that you want to use for the formula. After you select this cell, modify the formula to suit your requirements.

To do this, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007

1. Start Excel, and then open a new Excel worksheet.
2. In the Excel worksheet, select cell B1.
3. Click the **Home** tab.
4. Click **Conditional Formatting** in the **Styles** group, and then click **New Rule**.
5. Click **Use a formula to determine which cells to format** under **Select a Rule Type**.
6. Click inside the **Format values where this formula is true** box. Then, select the cell that you want to use for the conditional formatting.
7. Modify the value in step 6 to be **=$A$1=1**.
8. Click **Format**.
9. In the **Format Cells** dialog box, click the **Fill** tab.
10. Click the color "red," and then click **OK**.
11. In the **New Formatting Rule** dialog box, click **OK**.
12. In cell A1, type **1**, and then press ENTER.
13. Verify that the color of the cell B1 changed to red.
14. Close the Excel worksheet.

#### Microsoft Office Excel 2003 and earlier versions of Excel

1. Start Excel, and then open a new Excel worksheet.
2. In the Excel worksheet, select cell B1.
3. On the **Format** menu, click **Conditional Formatting**.
4. Under **Condition 1**, click **Formula Is** in the list.
5. Click inside the data entry box. Then, select the cell that you want to use for the conditional formatting.
6. Modify the value in the data entry box to be **=$A$1=1**, and then click **OK**.
7. Click **Format**.
8. In the **Format Cells** dialog box, click the **Patterns** tab.
9. Select the color "red," and then click **OK**.
10. In the **Conditional Formatting** dialog box, click **OK**.
11. In cell A1, type **1**, and then press ENTER.
12. Verify that the color of the cell B1 changed to red.
13. Close the Excel worksheet.