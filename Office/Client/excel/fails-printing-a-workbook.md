---
title: Margins do not fit page size when printing an Excel workbook
description: Describes why you may receive an error message when you print an Excel workbook or when you use the print preview feature. A workaround is provided.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# "Margins do not fit page size" error when you print an Excel workbook

## Symptoms

In a Microsoft Office Excel workbook, you select the **Fit to** option in the **Page Setup** dialog box. However, when you print this workbook or when you use the print preview feature to view the workbook, you receive the following error message:

**Margins do not fit page size.**

Additionally, many pages that have a scale of 10 percent may be printed.

## Cause

This issue may occur if the printer driver uses the XML Paper Specification (XPS) PageScaling feature. When the driver uses this feature, Excel cannot determine the scale of the workbook.

## Workaround

To work around this issue, use one of the following methods.

Method 1

Use a printer driver that does not use the XPS PageScaling feature.

Method 2

Manually set the scale instead of using the **Fit to** option. To do this, follow these steps:

1. Open the Excel workbook.
2. Click the **Page Layout** tab.
3. In the **Page Setup** group, click **Page Setup** to open the **Page Setup** dialog box.
4. In the **Page Setup** dialog box, click to select the **Adjust to** option, enter a number for the scale, and then click **OK**.