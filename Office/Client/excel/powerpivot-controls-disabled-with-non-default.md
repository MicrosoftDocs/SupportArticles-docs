---
title: PowerPivot controls disabled with non-default Excel file format
description: Documenting Excel issue exposed by an OffCAT rule
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: gregmans
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# PowerPivot controls disabled with non-default Excel file format

## Symptoms

In Microsoft Excel, when attempting to use controls on the PowerPivot ribbon, you find that the controls are grayed out, as in the following figure.

:::image type="content" source="media/powerpivot-controls-disabled-with-non-default/excel-controls.png" alt-text="Screenshot shows the Excel controls are grayed out on the PowerPivot ribbon.":::

The behavior may appear to be inconsistent between existing files; however, it occurs in any new file you attempt to create in Excel.

## Cause

This behavior can occur if the Save files in this format option is set to a file format other than the default Excel Workbook, as in the figure below.

:::image type="content" source="media/powerpivot-controls-disabled-with-non-default/excel-options.png" alt-text="Screenshot shows the Save files in this format option in the Excel Options window.":::

Here are some of the formats which may result in this behavior:

- XML Spreadsheet 2003   
- Strict Open XML Spreadsheet   
- OpenDocument Spreadsheet   

The availability of PowerPivot controls is specific to the file type of the active document, depending on whether that file type supports the PowerPivot features.

New, unsaved documents will enable or disable the PowerPivot controls based on the current Save files in this format option setting. If the file is later saved as a file type that supports PowerPivot, the controls on the PowerPivot ribbon will then be enabled.

## Resolution

To allow the use of the PowerPivot ribbon controls in new documents, configure the Save files in this format option to the default setting of Excel Workbook, using the steps below.


1. From the File tab in Excel, select Options.   
2. In the Excel Options dialog, select Save.   
3. In the Save Workbooks section, select Excel Workbook from the Save files in this format dropdown.   

If you are currently working in a file that is not the default format, you may need to Save As an Excel Workbook, or open a new workbook before the PowerPivot ribbon controls become available.

## More Information

The setting for the default Save format is stored in the Windows Registry under the following registry data:

Key: HKEY_CURRENT_USER\Software\Microsoft\Excel\15.0\Options

DWORD: DefaultFormat

Example values:

33 (51) = Excel Workbook (Excel standard default)

2e (46) = XML Spreadsheet 2003

3d (61) = Strict open XML spreadsheet

3c (60) = OpenDocument spreadsheet
