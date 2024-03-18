---
title: Wrap text not adjust row height
description: Describes a behavior in which the Wrap Text feature does not adjust row height in Excel. A workaround is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: clayj
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010Excel 2013
ms.date: 03/31/2022
---

# Wrap text does not adjust row height in Excel

## Symptoms

In Microsoft Excel, if you manually modify the height of a row and then format a cell in that row to wrap text, Excel does not change the height of the row to fit all the text in the cell. 

## Cause

This behavior occurs if you have manually modified the height of the row. 

## Workaround

To adjust the height of the row to fit all the text in a cell, follow these steps: 

1. Select the row you want to adjust the height.    
2. In Microsoft Office Excel 2003 and in earlier versions of Excel, point to **Row** on the **Format** menu, and then click **AutoFit**.

    In Microsoft Office Excel 2007 and later versions, click the **Home** tab, click **Format**in the **Cells** group, and then click **AutoFit Row Height**.   

If your Excel sheet contains merged cells, visit the following Microsoft website:

[You cannot use the AutoFit feature for rows or columns that contain merged cells in Excel](https://support.microsoft.com/help/212010) 

## Status

This behavior is by design.
