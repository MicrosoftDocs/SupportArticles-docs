---
title: Obtain the latest Excel Viewer
description: Describes how to view Excel workbook files by using the Excel Viewer 2007, and explains that you do not have to install Excel. The Excel Viewer 2007 can be used to view workbooks that are created in versions of Excel from Excel 97 to Excel 2010.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: lauraho 
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft Office Excel 2003
- Microsoft Office Excel 2007
- Excel 2010
---

# How to obtain the latest Excel Viewer

## Notice

**Excel Viewer has been retired**
   
> [!IMPORTANT]
> The Microsoft Excel Viewer was retired in April, 2018. It is no longer available for download or receive security updates. To continue viewing Excel files for free, we recommend installing the Excel mobile app or storing documents in OneDrive or Dropbox, where Excel Online opens them in your browser. For the Excel mobile app, visit the store for your device: 
> - [Google Play](https://play.google.com/store/apps/details?id=com.microsoft.office.excel)    
> - [iTunes](https://itunes.apple.com/us/app/microsoft-excel/id586683407?mt=8)
> - [Microsoft Store](https://www.microsoft.com/store/p/excel-mobile/9wzdncrfjbh3)     

## Summary

The Microsoft Excel Viewer is a small, freely redistributable program that lets you view and print Microsoft Excel spreadsheets if you don’t have Excel installed. In addition, the Excel Viewer can open workbooks that were created in Microsoft Excel for the Macintosh.

The Excel Viewer can open the latest version of Excel workbooks, but it will not display newer features. 

## More Information

The Microsoft Excel Viewer is the latest version of the viewer. It can read the file formats of all versions of Excel, and it replaces the Microsoft Excel Viewer 2003.

**Other options for free viewing of Excel workbooks**

- Excel Online Excel Online is available through OneDrive or deployed as part of Microsoft SharePoint. Excel Online can view, edit and print Excel workbooks. For more information about Excel Online, see the [Office Online overview](https://office.microsoft.com/fx100996074.aspx).    
- Office 365 Trial Downloading the trial will give you access to the full capabilities of Microsoft Office 2013. For more information, see [Office 365 Home](https://office.microsoft.com/office365home).    
- Office Mobile applications Download the trial for mobile applications available on iPhone, Android phone, or Windows Phone. For more information, see [Office on mobile devices](https://office.microsoft.com/mobile).    
 
> [!NOTE]
> The Excel Viewer is available only as a 32-bit application. A 64-bit version of the Excel Viewer does not exist. The 32-bit version of the Excel Viewer can be used on 64-bit versions of Windows.
 
The file name of the Excel Viewer is xlview.exe. The default folder location for the Excel Viewer on a 32-bit operating system isc:\Program Files\Microsoft Office\Office12\. The default folder location for the Excel Viewer on a 64-bit operating system is c:\Program Files (x86)\Microsoft Office\Office12\. 

> [!NOTE]
> If you already have a full version of Microsoft Excel installed on your computer, do not install Microsoft Excel Viewer in the same directory. Doing this causes file conflicts.

### File formats supported

The Excel file formats supported are .xlsx, .xlsm, .xlsb, .xltx, .xltm, .xls, .xlt, .xlm, and .xlw. Macro-enabled files can be opened (.xlsm, .xltm, and .xlm), but the macros do not run. 

### Known issues with newer versions of Excel workbooks and the Excel Viewer

Even though the Excel Viewer can read the latest Excel workbooks, the following new features are not visible or are displayed differently in the Excel Viewer. 
 
- Sparklines are not shown in the Excel Viewer. The cells where they are located are blank.    
- PivotTables and PivotCharts are flattened. The data or chart will appear, but modifications cannot be made.    
- Macros do not run in the Excel Viewer.    
- Slicers do not display data in the Excel Viewer. Instead, a box is displayed in the location of the slicer and it contains the following text: "This shape represents a slicer. Slicers are supported in Excel 2010 or later. If the shape was modified in an earlier version of Excel, or if the workbook was saved in Excel 2003 or earlier, the slicer cannot be used."
 
   ![an image of the text contained in a slicer](./media/get-latest-excel-viewer/slicer-not-display-data.png)    

If you have to view or use these features, use Excel Online.
