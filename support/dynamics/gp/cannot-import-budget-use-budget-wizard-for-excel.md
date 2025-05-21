---
title: Error when you use the Budget Wizard for Excel in Microsoft Dynamics GP to try to import a budget
description: Describes a problem that occurs if fiscal periods are set up in a date format. Provides a resolution.
ms.reviewer: theley, cwaswick, lmuelle
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# "The number of periods for the budget does not match the number of columns in Excel" error when you use the "Budget Wizard for Excel" in Microsoft Dynamics GP to try to import a budget

This article describes a problem that occurs if fiscal periods are set up in a date format.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927700

## Symptoms

When you use the Budget Wizard for Excel in Microsoft Dynamics GP to try to import a budget from Microsoft Office Excel, you receive the following error message:
> The number of periods for the budget does not match the number of columns in Excel. Import will not be able to complete.

## Cause

This problem occurs if the fiscal periods are set up in a date format. Additionally, the Excel worksheet is created by using period headers in a date format. For instance, a "January - 2012' text change to a date datatype in Excel would be 'Jan -12'. The interpreted column header no longer matches GP and the import fails.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1

Go to the Fiscal Periods Setup window to see how the names for the periods are listed. If they are in date format, change them to Period 1, Period 2, and so on. To do it, click **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company** and click **Fiscal Periods**. Then enter the new matching fiscal period names such as Period 1, Period 2, and so on, on the import file. Save and retest the import.

### Method 2

Change the period headers in the Excel worksheet to a text format. To do it, follow these steps:

1. In the Excel worksheet, highlight all the column headers for the periods.
2. On the **Format** menu, click **Cells**.
3. On the **Number** tab, click **Text** in the **Category** list.
4. Click **OK**.
5. If the cells are changed to numbers, reenter the period headers to match the fiscal period setup.

    > [!NOTE]
    > Or put a single apostrophe before each column header name to force it to be text.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. It's scheduled to be fixed in the next version of Microsoft Dynamics GP.
