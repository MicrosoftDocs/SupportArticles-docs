---
title: Mail merge error when a data source is accessed by multiple users in Word
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Word for Office 365
- Word 2019
- Word 2013
- Word 2016
- Word 2010
---

# Mail merge error when a data source is accessed by multiple users in Word

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

Consider the following scenario: 

- You try to open a mail-merged document in Microsoft Word 2010, Word 2013, or Word 2016.   
- The data for this document is a Microsoft Excel worksheet (*.xlsx) that's stored in shared folder.   
- The document has already been opened.   

In this scenario, you receive the following error message:

**Error has occurred: External table is not in the expected format.**

![error message](./media/mail-merge-error-in-word/error.png)

## Cause

When you store an .xlsx file in a shared folder and use it as data source in a Word mail merge, Word opens the .xlsx file exclusively. If another user tries to open a Word file that uses the same data source simultaneously, only read-only permissions can be granted, and therefore the request fails.

## Workaround

To work around this issue, use a .csv or .xls file instead of an .xlsx file as the data source. For example, open your data source in Excel, and then save it as an **Excel 97-2003 Workbook (*.XLS)** or **CSV Comma Delimited (*.CSV)** file.