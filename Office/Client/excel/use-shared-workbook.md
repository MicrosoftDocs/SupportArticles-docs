---
title: Use shared workbooks with different versions of Excel
description: Describes how to use shared workbooks with different versions of Excel.
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
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2002
ms.date: 03/31/2022
---

# Use shared workbooks with different versions of Excel

## Summary

This step-by-step article explains how to share a Microsoft Excel workbook with other users.

If you want several users to work in the same Excel workbook simultaneously, you can save the workbook as a shared workbook. Users can then enter data, insert rows and columns, add and change formulas, and change formatting.

> [!NOTE]
> It is not possible to open shared workbooks that are created in Microsoft Excel 95 in later versions of Excel and still maintain their shared status.

### Set up a shared workbook

To make changes to a shared workbook that was created in Microsoft Excel 97 or a later version of Excel, you must use Excel 97 or a later version of Excel. 

Specifically, even if a shared workbook that was created in Excel 97 or a later version of Excel is saved as an Excel 95 workbook, the workbook cannot be shared. If a workbook that was created in Excel 95 is shared, it is a read-only workbook when it is opened in Excel 97 or a later version of Excel.

To set up a shared workbook, follow these steps, as appropriate for the version of Excel that you are running.

#### Microsoft Office Excel 2007

1. Click the **Review** tab.   
2. Click **Share Workbook** in the **Changes** group.   
3. On the **Editing** tab, click to select the **Allow changes by more than one user at the same time. This also allows workbook merging** check box, and then click **OK**.   
4. In the **Save As** dialog box, save the shared workbook on a network location where other users can gain access to it.   

#### Microsoft Office Excel 2003 and earlier versions of Excel

1. On the Tools menu, click Share Workbook, and then click the Editing tab.
2. Click to select the **Allow changes by more than one user at the same time** check box, and then click OK.   
3. Save the workbook when you are prompted.   
4. On the File menu, click Save As, and then save the shared workbook on a network location where other users can gain access to it.
