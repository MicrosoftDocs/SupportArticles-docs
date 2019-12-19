---
title: Excel may not automatically fit the worksheet to the page
description: Discusses a problem in which Excel 2000 and later versions of Excel may not automatically fit the worksheet to the page as earlier versions of Excel did after you set the "Fit to" option.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel 2007
- Excel 2003
- Excel 2002
- Excel 2000
---

# Excel may not automatically fit the worksheet to the page after you set the "Fit to" option

## Summary

Microsoft Excel 2000 and later versions of Excel may not automatically fit the worksheet to the page as earlier versions of Excel did. 

This issue occurs when you click **Page Setup** on the **File** menu, click to select the **Fit to** check box on the **Page** tab, and then type the number of pages wide that you want the worksheet to fit. For example, you type 1. 

## More information

In earlier versions of Excel, when you click to select the **Fit to** check box and then specify a setting in either the **page(s) wide by** or the **tall** boxes, Excel would clear the manual page breaks both vertically and horizontally to automatically make the worksheet fit the page wide by the page tall.

However, in Excel 2000 and in later versions of Excel, the **Fit to** option does not automatically clear all the manual page breaks in a worksheet. Excel clears the manual page breaks for only the width or height that you specify. For example: 

- When you specify a page width setting in the
**page(s) wide by** box, Excel clears all the manual vertical page breaks in the worksheet.   
- When you specify a page height in the **tall**box, Excel clears all the manual horizontal page breaks in the worksheet.   
- When you do not specify either a width or height by clearing both the **page(s) wide by** box and the
**tall** box, Excel retains both the vertical and horizontal manual page breaks in the worksheet.   

This is a design change in Excel 2000 and in later versions of Excel. This change gives you more flexibility when you fit a worksheet to a page.
