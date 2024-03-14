---
title: Mail merge error when a data source is accessed by multiple users in Word
description: Fixes an issue in which you receive an error when a data source is accessed by multiple users.
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
  - Word for Microsoft 365
  - Word 2019
  - Word 2013
  - Word 2016
  - Word 2010
ms.date: 03/31/2022
---

# Mail merge error when a data source is accessed by multiple users in Word

## Symptoms

Consider the following scenario: 

- You try to open a mail-merged document in Microsoft Word 2010, Word 2013, or Word 2016.
- The data for this document is a Microsoft Excel worksheet (*.xlsx) that's stored in shared folder.
- The document has already been opened.

In this scenario, you receive the following error message:

**Error has occurred: External table is not in the expected format.**

:::image type="content" source="media/mail-merge-error-in-word/error-message.png" alt-text="Screenshot of the error message, showing the external table is not in the expected format.":::

## Cause

When you store an .xlsx file in a shared folder and use it as data source in a Word mail merge, Word opens the .xlsx file exclusively. If another user tries to open a Word file that uses the same data source simultaneously, only read-only permissions can be granted, and therefore the request fails.

## Workaround

To work around this issue, use a .csv or .xls file instead of an .xlsx file as the data source. For example, open your data source in Excel, and then save it as an **Excel 97-2003 Workbook (*.XLS)** or **CSV Comma Delimited (*.CSV)** file.