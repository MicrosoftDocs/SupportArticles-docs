---
title: How column widths are determined in Excel
description: Provides information about the factors that determine the column widths in Excel.
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
  - Excel 2000
ms.date: 03/31/2022
---

# Description of how column widths are determined in Excel

## Summary

The standard column width in Microsoft Excel 2000 is 8.43 characters; however, the actual width that you see on the screen varies, depending on the width of the font defined for the Normal style of your workbook. Changing the default font also changes the column width. This behavior occurs because of the way that Excel stores the column width information for individual fonts. This article discusses how column widths are determined. 

## More information

Excel begins with a default width of 8 characters and translates this into a given number of pixels, depending on the Normal style font. It then rounds this number up to the nearest multiple of 8 pixels, so that scrolling across columns and rows is faster. The pixel width is stored internally in Excel for positioning data on the screen. The number that you see in the Column Width dialog box is the pixel width retranslated into character units (based on the Normal font) for display. 

A column width of 8.43 means that 8.43 of the default font's characters fit into a cell. The default font for the worksheet is the font that is assigned to the Normal style. Excel 2000 uses a factory default font of Arial 10. 

> [!NOTE]
> Changing Printer DPI can affect the font metrics and can adjust the column widths. Microsoft Office Excel 2007 uses a default theme that is named Office. This default theme has Cambria as the default heading font and Calibri 11 as the default body font.

To determine the default font on your worksheet, follow these steps: 

1. On the Format menu, click Style.   
2. Read the font listed next to the Font check box.   

To change the default font, follow these steps: 

1. On the Format menu, click Style.   
2. Click Modify.   
3. On the Font tab, select the font, style, and size that you want.   
4. Click OK.   

To change the default font in Excel 2007, follow these steps:

1. On the **Page Layout** tab, in the **Themes** group, click **Fonts**.   
2. Click **Create New Theme Fonts**.   
3. In the **Heading Font** and the **Body Font** boxes select the fonts that you want. to use.   
4. In the **Named** box, type **Office** to replace the default template.   
5. Click **Save**.   

If the default font is a non-proportional (fixed width) font, such as Courier, 8.43 characters of any type (numbers or letters) fit into a cell with a column width of 8.43 because all Courier characters are the same width. If the font is a proportional font, such as Arial, 8.43 integers (numbers such as 0, 1, 2, and so on) fit into a cell with column width of 8.43. This is because numbers are fixed-spaced with most proportional fonts. However, because letters are not fixed-spaced with proportional fonts, more "i" characters fit and fewer "w" characters fit. 

When you change the width of a column to a fractional number, the column width may be set to a different number depending on the font used in the Normal style. For example, with a Normal style font of Arial, if you attempt to change the width of a column to 8.5, the column is set to 8.57 or 65 pixels. This behavior occurs because of the translation of font characters to pixel units. Fractional pixel units cannot be displayed; therefore, the column width rounds to the nearest number that results in a whole pixel unit. 

### Example of Column Width Behavior

1. In a new Excel workbook, select cell A1.   
2. On the Format menu, point to Column, and then click Width.   
3. In the **Column width** box, type 10 (75 pixels wide), and then click OK.   
4. On the Format menu, click Style, and then verify that the default font is correctly set to Arial 10.   
5. In cell A1, type 1234567890.

    > [!NOTE]
    > The letters fit perfectly into the cell and the column width is still 10 (75 pixels wide).   
6. On the Format menu, click Style.   
7. Click Modify.   
8. On the Font tab, change the font to Courier New, and then click OK twice. Note that the Column Width box automatically updates to accommodate the new font and that the number in the cell still fits, even though the column width is still 10 but has increased to 85 pixels wide.   

#### Column Width behavior in Excel 2007

To set the column width in Excel 2007, follow these steps:

1. On the first column click **A** to select the column, and then right click and select **Column Width**.    
2. Type the width that you want for your column.   
3. Click **OK**.   

The behavior of the column width in Excel 2007 is the same as noted above. If you change fonts after having set the width it will adjust for the new fonts pixel width.
