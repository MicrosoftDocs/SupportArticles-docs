---
title: Data is truncated to 255 characters in a linked table
description: Data in a linked table that's linked to an Excel spreadsheet is limited to 255 characters in an Access database. Import the Excel spreadsheet rather than linking to the spreadsheet in your database.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CI 162681
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
  - Access 2003
search.appverid: MET150
ms.date: 05/26/2025
---

# The data in a linked Excel spreadsheet column is truncated to 255 characters in an Access database

_Original KB number:_ &nbsp; 839785

> [!NOTE]
> This article applies to a Microsoft Access database (.mdb) file or to a Microsoft Access database (.accdb) file. Novice: Requires knowledge of the user interface on single-user computers.

## Symptoms

When you link to a Microsoft Office Excel spreadsheet from a Microsoft Office Access database, and the columns of the Excel spreadsheet contain more than 255 characters, you may notice that the data in the linked table appears truncated after the 255th character.

## Cause

In Access, when you link to an Excel spreadsheet that contains more than 255 characters, the column of the Excel spreadsheet is mapped to the formatted Memo data type. Because Access treats the formatted Memo field as a text field that has a 255-character limit, you can view only 255 characters. However, the data is not physically truncated in the linked table.

## Workaround

To work around this problem, you must import the Excel spreadsheet to an Access table when the columns of the Excel spreadsheet contain more than 255 characters.

## Status

This behavior is by design.

## More Information

In Access, you can set the **Format** property of the Text field and the Memo field to create custom formats. You can use the following special characters to set the **Format** property of the Text field and the Memo field:

|Special character|Description|
|---|---|
|@|Text character. Either a character or a space is required.|
|&|Text character is not required.|
|<|Force all characters to lowercase.|
|>|Force all characters to uppercase.|

When you link an Excel spreadsheet to an Access database, and the columns of the Excel spreadsheet contain more than 255 characters, the columns are mapped to Memo data types, and the **Format** property of the Memo field is set to @. Therefore, Access treats the Memo field as a text field, and you can view only 255 characters of data.

However, when you import an Excel spreadsheet that has columns that contain more than 255 characters, the columns are mapped to a Memo field with no specific format. Therefore, you can view the complete data in the field.

## References

For additional information about how to import or link data from a spreadsheet, visit the following Microsoft Web site:

[Import or link to data in an Excel workbook](https://support.microsoft.com/office/import-or-link-to-data-in-an-excel-workbook-a1952878-7c58-47b1-893d-e084913cc958)
