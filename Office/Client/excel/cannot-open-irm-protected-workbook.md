---
title: Cannot open an IRM protected workbook in Protected View
description: Works around an issue in which you receive an error message and you cannot open an IRM protected Excel 97-2003 workbook. This issue occurs when you try to open the workbook in Protected View in Excel 2013.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: anitao, jenl
search.appverid: 
  - MET150
appliesto: 
  - Excel 2013
ms.date: 03/31/2022
---

# You cannot open an IRM protected workbook in Protected View in Excel 2013

## Symptoms

When you try to open an Information Rights Management (IRM) protected Microsoft Excel 97-2003 workbook (.xls file) in Protected View in Excel 2013, the operation fails. Additionally, you receive the following error message:

> We found a problem with some content in \<file name>. Do you want us to try to recover as much as we can? If you trust the source of this workbook, click Yes.

## Workaround

To work around this issue, temporarily disable Protected View in Excel 2013, and then open the workbook again. To disable Protected View in Excel 2013, follow these steps:

1. In the **File** tab, click **Options**.
2. In the **Excel Options** dialog box, click **Trust Center**.
3. Click **Trust Center Settings**.
4. Click **Protect View**.
5. In the **Trust Center** dialog box, clear the following check boxes as appropriate for your situation:

   - Enable Protected View for files originating from the Internet
   - Enable Protected View for files located in potentially unsafe locations
   - Enable Protected View for Outlook attachments

## More Information

Protected View is a read-only mode in which most editing functions are disabled. Additionally, Protected View is enabled by default, and files that are located in potentially unsafe locations are opened in Protected View. For more information about Protected View, go to the following Microsoft website:

[What is Protected View](https://office.microsoft.com/excel-help/what-is-protected-view-ha010355931.aspx)

## Status

This is a known issue in Excel 2013.
