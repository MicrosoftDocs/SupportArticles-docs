---
title: The result is false when you use the ISBLANK function
author: simonxjx
manager: willchen
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# The result is "FALSE" when you use the ISBLANK() function in an Excel spreadsheet

## Symptoms

When you use the **ISBLANK()** function in a Microsoft Excel spreadsheet, the result is "FALSE". This behavior occurs even though the cell appears to be empty. Additionally, this behavior occurs even though the formula bar may show that nothing is in the cell.

## Cause

This behavior may occur when the cell contains a zero-length string. A zero length string may be a result of the following conditions:

- A formula.   
- A copy and paste operation.   
- A cell that contains a zero-length string is imported from a database that supports zero-length strings and that contains zero-length strings.   

## Workaround

To work around this issue, clear the zero-length string from the cell. To do this, select the cell, click **Edit**, and then click **Clear All**.

## More information

To create a zero-length string in Microsoft Excel, use any of the following methods:

- Type a formula that evaluates the value **""** in a cell.
- Type a single apostrophe (') in a cell.

- Copy a cell that contains either of the earlier values, and then paste only the values in another cell.

- Import data from a database that supports and that contains zero-length strings.

If you use the third method or the fourth method in the bulleted listed to create a zero-length string, the formula bar is blank, but the cell is not.
