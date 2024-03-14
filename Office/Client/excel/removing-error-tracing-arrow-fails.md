---
title: You cannot remove error tracing arrow in Excel
description: Describes that you cannot remove error tracing arrow in Excel.
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
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2002
ms.date: 03/31/2022
---

# You cannot remove error tracing arrow in Excel

## Symptoms

When you correct an error found by the **Formulas referring to empty cells** rule in Microsoft Excel, the Trace Empty Cell arrow changes into a Trace Precedents arrow instead of disappearing as expected.

## Cause

For an example of this behavior, follow these steps:

1. On the Tools menu, click Options.

   > [!NOTE]
   > If you use Microsoft Office Excel 2007, click the **Microsoft Office Button**, click **Excel Options**, and then click **Formulas**.

2. On the Error Checking tab or in the **Error Checking rules** area, ensure that the **Formulas referring to empty cells** check box is selected.
3. Click OK.
4. In a new workbook, type =B1 in cell A1.
5. Select cell A1 and click the Error Checking button.
6. Click Trace Empty Cell.
7. Notice that a red Trace Empty Cell arrow appears.
8. Type 1 into cell B1.
9. Notice the Trace Empty Cell arrow becomes a blue Trace Precedents arrow.

## Resolution

To resolve this issue, follow these steps:

- If you use Excel 2007, follow these steps:
  1. Select the cell to which the arrow is pointing.
  2. On the **Formulas** tab, click **Remove All Arrows** in **Formula Auditing** group, and then click **Remove Precedent Arrows**.

- If you use Microsoft Office Excel 2003 or Microsoft Excel 2002 , follow these steps:
  1. Select the cell to which the arrow is pointing.
  2. On the **Tools** menu, point to **Formula Auditing**, and then click **Show Formula Auditing Toolbar**.
  3. On the **Formula Auditing** toolbar, click **Remove Precedent Arrows**.

## Workaround

To work around this issue and make the arrows disappear, recalculate the cell with the error after you correct the error, as in the following example:

1. In cell A1 of a new worksheet, type the formula =A2.

   An error indicator appears in cell A1.

2. Select cell A1.

   An Error Checking button appears to the right of cell A1.

3. Click the Error Checking button next to A1.
4. Click Trace Empty Cell.

   A red Trace Empty Cell arrow appears, pointing to cell B2.

5. Type 1 in cell B2.

   The error indicator disappears from cell A1 and the arrow turns into a blue Trace Precedents arrow.

6. Click cell A1.
7. Press F2.
8. Press ENTER to recalculate.

   The arrow disappears.