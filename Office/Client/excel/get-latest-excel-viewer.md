---
title: Download the latest online Excel Viewer
description: Describes how to view Excel workbook files by using the Excel Viewer 2007, and explains that you do not have to install Excel. The Excel Viewer 2007 can be used to view workbooks that are created in versions of Excel from Excel 97 to Excel 2010.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: lauraho
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010
ms.date: 03/31/2022
---

# Download the latest online Excel Viewer

## Notice

**Excel Viewer is retired**

> [!IMPORTANT]
> The Microsoft Excel Viewer was retired in April, 2018. It no longer is available for download or receives security updates. To continue viewing Excel files for free, we recommend that you install the Excel mobile app or store documents on OneDrive or Dropbox, from which Excel Online can open the files in your browser. For the Excel mobile app, go tothe appropriate store for your device: 
> - [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.office.excel)    
> - [iTunes](https://itunes.apple.com/us/app/microsoft-excel/id586683407?mt=8)
> - [Microsoft Store](https://www.microsoft.com/store/p/excel-mobile/9wzdncrfjbh3)     

## Summary

The Microsoft Excel Viewer is a small, freely redistributable program that lets you view and print Microsoft Excel spreadsheets if you don't have Excel installed. Additionally, the Excel Viewer can open workbooks that were created in Microsoft Excel for Macintosh.

The Excel Viewer can open the latest version of Excel workbooks. However, it will not display newer features. 

## More information

The latest version of Microsoft Excel Viewer can read the file formats of all versions of Excel. It replaces the Microsoft Excel Viewer 2003.

**Other options for free viewing of Excel workbooks**

- **Excel Online:** Excel Online is available through OneDrive or deployed as part of Microsoft SharePoint. Excel Online can view, edit and print Excel workbooks. For more information about Excel Online, see the [Office Online overview](https://office.microsoft.com/fx100996074.aspx).    
- **Microsoft 365 Trial:** Downloading the trial version gives you access to the full capabilities of Microsoft Office 2013. For more information, see [https://www.microsoft.com/microsoft-365/try](https://www.microsoft.com/microsoft-365/try).    
- **Office Mobile applications:** Download the trial for mobile applications that are available on iPhone, Android phone, or Windows Phone. For more information, see [Office on mobile devices](https://office.microsoft.com/mobile).    
 
> [!NOTE]
> The Excel Viewer is available only as a 32-bit application. A 64-bit version of the Excel Viewer does not exist. The 32-bit version of the Excel Viewer can be used on 64-bit versions of Windows.
 
The file name of the Excel Viewer is xlview.exe. The default folder location for the Excel Viewer on a 32-bit operating system isc:\Program Files\Microsoft Office\Office12\. The default folder location for the Excel Viewer on a 64-bit operating system is c:\Program Files (x86)\Microsoft Office\Office12\. 

> [!NOTE]
> If you already have a full version of Microsoft Excel installed on your computer, do not install Microsoft Excel Viewer in the same directory. Doing this causes file conflicts.

### File formats supported

The supported Excel file formats are .xlsx, .xlsm, .xlsb, .xltx, .xltm, .xls, .xlt, .xlm, and .xlw. Macro-enabled files can be opened (.xlsm, .xltm, and .xlm), but the macros do not run.

### Known issues in newer versions of Excel workbooks and the Excel Viewer

Even though the Excel Viewer can read the latest Excel workbooks, the following new features are not visible or are displayed differently in the Excel Viewer. 
 
- Sparklines are not shown in the Excel Viewer. The cells that contain them appear blank.
- PivotTables and PivotCharts are flattened. The data or chart appears, but you can't make modifications.
- Macros do not run in the Excel Viewer.
- Slicers do not display data in the Excel Viewer. Instead, a box is displayed in the location of the slicer. The box contains the following text: "This shape represents a slicer. Slicers are supported in Excel 2010 or later. If the shape was modified in an earlier version of Excel, or if the workbook was saved in Excel 2003 or earlier, the slicer cannot be used."

If you have to view or use these features, use Excel Online.
