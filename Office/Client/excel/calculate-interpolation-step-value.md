---
title: Method to calculate interpolation step value in Excel
description: Introduces a method to calculate interpolation step value in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
ms.reviewer: sloanc, briance
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2007
  - Excel 2010
  - Excel 2013
  - Excel 2016
ms.date: 03/31/2022
---

# Method to calculate interpolation step value in Excel

## Summary

The following Microsoft Excel formula performs linear interpolation by calculating the interpolation step value:

**=(end-start)/(ROW(end)-ROW(start))**

where **end** is the cell address of the larger number, and **start** is the cell address of the smaller number.

Interpolation is a method used to determine a present or future value factor when the exact factor does not appear in either a present or future value table. Interpolation assumes that the change between two values is linear and that the margin of error is insignificant.

## More Information

To create a sample linear interpolation formula, follow these steps:

1. Type the following values in a worksheet:

   ```excel
   A1: 9        B1: =(A7-A1)/(ROW(A7)-ROW(A1))
   A2: =A1+$B$1
   A3:
   A4:
   A5:
   A6:
   A7: 11
   ```
2. Select cells A2:A6. On the Edit menu, point to Fill, and then click Down. The formula is filled down, and the following values are displayed in cells A2:A6:

    ```excel
    A2: 9.33333
    A3: 9.66667
    A4: 10.
    A5: 10.33333
    A6: 10.66667
    ```

> [!NOTE]
> You must type the reference to the step value in cell B1 as an absolute reference (with dollar signs).
