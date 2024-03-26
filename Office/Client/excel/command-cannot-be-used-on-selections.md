---
title: That command cannot be used on multiple selections
description: Describes an issue that occurs when you try to copy nonadjacent cell or range selections.
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
  - Excel 2000
ms.date: 03/31/2022
---

# Error Message: That command cannot be used on multiple selections

## Symptoms

When you attempt to copy nonadjacent cell or range selections, you may receive the following error message:

**That command cannot be used on multiple selections.**

## Cause

These error messages may occur when your cell or range selections are in different columns or different rows. You can, however, copy and paste nonadjacent ranges without getting an error message if your selection contains any of the following:

- Multiple rows within the same column, for example, A1, A3, A5.

- Multiple columns within the same row, for example, A2, C2, E2.

- Multiple rows and columns within the same columns and rows, for example, A1, C1, A3, C3, A5, C5.

## More information

When you make a nonadjacent selection and then click Copy on the Edit menu, Excel tries to identify an outline type of the selection. Because Excel "slides" the ranges together and pastes them as a single rectangle, a contiguous rectangle must remain if the rows and columns in between the selected cells are collapsed or set to a size of 0.

For example if you wanted to perform an operation on the following sample data:

```asciidoc
A1: 1 B1:   C1: 2

A2:   B2:   C2:

A3: 3 B3:   C3: 4
```

Because a contiguous rectangle remains if you were to collapse row 2 and column B, you can individually select cells A1, C1, A3, C3 and copy them without error. (To make a nonadjacent selection, hold down the CTRL key while selecting additional cells or ranges.)

This selection will be pasted as a single rectangle:

```asciidoc
A5: 1 B5: 2

A6: 3 B6: 4
```

However, you cannot add cell B2 to this nonadjacent selection, because Microsoft Excel cannot determine which direction you want the cells to slide. For example, B2 could slide between A1 and A3, C1 and C3, A1 and C1 or A3 and C3. This would result in rectangles of varying shapes and sizes. Because you cannot designate how you want the rectangle arranged, Excel returns the error message. In this case, the cell range must be a single selection, or the cells must be copied individually.
