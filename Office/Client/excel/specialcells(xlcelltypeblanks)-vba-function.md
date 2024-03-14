---
title: The SpecialCells(xlCellTypeBlanks) VBA function doesn't work as expected
description: Explains that the SpecialCells(xlCellTypeBlanks) VBA function does not work as expected when you select more than 8,192 non-contiguous cells with your macro. You can use a looping structure to work around this problem.
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
  - Microsoft Excel
ms.date: 03/31/2022
---

# The SpecialCells(xlCellTypeBlanks) VBA function does not work as expected in Excel

## Symptoms

When you create a Microsoft Visual Basic for Applications (VBA) macro that selects multiple non-contiguous ranges in a Microsoft Excel workbook that uses a VBA expression that is similar to the following, actions that were only supposed to occur with non-contiguous cells occur to every cell in the original selection on the worksheet:

```vb
expression.SpecialCells(XlCellType).expression XlCellType
```

can be any one of the following:

- xlCellTypeAllFormatConditions
- xlCellTypeAllValidation
- xlCellTypeBlanks
- xlCellTypeComments
- xlCellTypeConstants
- xlCellTypeFormulas
- xlCellTypeSameFormatConditions
- xlCellTypeSameValidation
- xlCellTypeVisible

## Cause

This behavior occurs if you select more than 8,192 non-contiguous cells with your macro. Excel only supports a maximum of 8,192 non-contiguous cells through VBA macros.

Typically, if you try to manually select more than 8,192 non-contiguous cells, you receive the following error message:

**The selection is too large.**

However, when you use a VBA macro to make the same or a similar selection, no error message is raised and no error code is generated that can be captured through an error handler.

## Workaround

To work around this behavior, you may want to create a looping structure in your VBA macro that handles less than the maximum 8,192 cells.

## Status

This behavior is by design.