---
title: How to minimize the size of an XML Spreadsheet file in Excel
description: Describes methods to minimize the XML Spreadsheet file size.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel 2007
- Excel 2003
---

# How to minimize the size of an XML Spreadsheet file in Excel

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary

When you save an Excel workbook as an XML Spreadsheet file (.xml), and the workbook contains large ranges of special formatting, the size of the file may be much larger than the original workbook (.xls) file size.

> [!NOTE]
> To save an Excel workbook as an XML Spreadsheet file, on the **File** menu, click **Save As**, and then change the **Save as type** box to **XML Spreadsheet (*.xml)**.

The purpose of this article is to describe how to minimize the XML Spreadsheet file size.

## More Information

To minimize the XML Spreadsheet file size, use the following methods.

### Method 1: Use Common Formatting

In an XML Spreadsheet file, Excel represents a formatted column as a style, and then designates every cell in that column to correspond to that particular style.

If the format of a cell or a range of cells in that column differs from the column common format, Excel stores special formatting information for those cells, overriding the common column formatting style. As a result, the additional format information that is stored in the worksheet causes the file size to grow. If you limit the amount of additional formatting in a column, then the resulting XML Spreadsheet file size will not grow dramatically.

1. To format a whole column with the common formatting that applies to all cells in that column, follow these steps:

   1. Click the column heading of the column you want to apply formatting.
   2. On the **Format** menu, click **Cells**.
   3. In the **Format Cells** dialog box, click the tab for the type of formatting you want to apply, make the changes to the formatting you want, and then click **OK**.

2. To apply different formatting to a small number of cells in the column that require extra formatting, follow these steps:

   1. Select the cells in the column that require additional formatting.
   2. On the **Format** menu, click **Cells**.
   3. In the **Format Cells** dialog box, click the tab for the type of formatting you want to apply, make the changes to the formatting you want, and then click **OK**.
   
### Method 2: Use Conditional Formatting

When you use conditional formatting, you can change font attributes (for example font size, bold, italic and color) to vary with a specified condition.

The format information for conditional formatting is not written on a per cell basis in the resulting XML Spreadsheet file, and as a result will not dramatically increase the XML Spreadsheet file size.