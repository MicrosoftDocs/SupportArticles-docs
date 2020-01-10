---
title: Can't open an Excel workbook saved in Excel version 1805
description: You can't open an Excel workbook after it's saved in Excel version 1805 because there is external link data that contains an invalid sheet name.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: mmaxey, rtaylor, akeeler
search.appverid: 
- MET150
appliesto:
- Excel 2016
---

# "We found a problem with some content" error when trying to open a workbook

## Symptoms

When you try to open an XLSX/XLSM Excel workbook that was saved in Microsoft Excel version 1805, you may receive the following error message:

```adoc     
We found a problem with some content in 'WorkbookName.xlsx'. Do you want us to try to recover as much as we can? If you trust the source of this workbook, click Yes.     
```

Then, you click **Yes**.  

If the workbook is stored in a network location, you may see the following error message:

```adoc      
Sorry, we couldn't find <path of workbook>.xlsx. Is it possible it was moved, renamed or deleted?     
```

After you click **OK**, the workbook does not open.  

If the workbook is stored locally, you may see the following error message:    
```adoc
Excel was able to open the file by repairing or removing the unreadable content.
Removed Feature: External formula reference from <path>/externalLink*.xml part (Cached values from external formula reference)
Removed Records: Formula from <path>.xml part
Removed Records: Formula from <path> (Calculation properties)     
```

Then, after you click **Close**, the workbook opens in Excel. 

## Cause

The workbook contains corruption that was undetected before the Excel 1805 update. This issue occurs when there is external link data that contains an invalid sheet name that triggers the Repair feature. 

## Workaround

To work around this issue, use one of the following methods: 
 
### Method 1

Save the file after the repair completes. The Repair feature is working as expected and removes the corruption. 

### Method 2

Scan the XML parts under xl\externalLinks for sheet names that have a book name added to the string (for example, a sheet name is "[test.xls]something\somethingelse"), and then remove both the book name and any backslashes or colons from the name (for example, rename the sheet name as "something-somethingelse"). Sheet name tags should not have a book name, nor should they contain invalid characters (such as backslashes) that you cannot add through the UI.
