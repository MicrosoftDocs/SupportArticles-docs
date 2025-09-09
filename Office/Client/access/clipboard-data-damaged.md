---
title: Unable to copy and paste from Excel into Access
description: Fixes an issue in which you can't perform a copy/paste operation from Excel into Access.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
search.appverid: MET150
ms.date: 05/26/2025
---
# Access Error: Data on the Clipboard is damaged, so Microsoft Access can't paste it

_Original KB number:_ &nbsp; 2221635

## Symptoms

When performing a copy/paste operation from Microsoft Excel into Microsoft Access, you receive the following error message:

> The data on the Clipboard is damaged, so Microsoft Access can't paste it. There may be an error in the Clipboard, or there may not be enough free memory. Try the operation again.

## Cause

There are multiple scenarios which may lead to this error. Microsoft is aware of this problem in recent versions of Microsoft Access.

**Scenario 1**

This issue occurs when the following two conditions are true:

- One of the values in the first row of data contains a decimal point
- You copy more than one row of data

**Scenario 2**

The Excel sheet name contains a single quote character, or an apostrophe character.

## Workaround

Use one of the following workarounds:

**Method 1**

In Microsoft Access, select the dropdown arrow on the **Paste** icon, and then select **Paste Special**. Then, select either Text or CSV.

**Method 2**

Ensure there are no decimal points in the first row of the Excel data that you copy.

**Method 3**

Copy and paste a single row at a time.

## More information

The problem does not occur in Microsoft Access 2003.

Steps to Reproduce

1. In Access, create a new blank database.
2. Create a new table in table Design View.
3. Add the following field:

   Name: Field1

   Data Type: Number

   Field Size: Double

4. Save the table as Table1.
5. Open Table1 in Datasheet View.
6. In Microsoft Excel, create a new spreadsheet.
7. Add these values to the following cells:

   A1: 83.9

   A2: 3020
8. In Excel, select A1 and A2, and then click the Copy icon.
9. In Access, select Field1, and then click the Paste icon.

Result

You receive the one of these versions of the error:

- The data on the Clipboard is damaged, so Microsoft Office Access can't paste it. There may be an error in the Clipboard, or there may not be enough free memory. Try the operation again.
- The data on the Clipboard is damaged, so Microsoft Access can't paste it. There may be an error in the Clipboard, or there may not be enough free memory. Try the operation again.

> [!NOTE]
> This is a "FAST PUBLISH" article created directly from within the Microsoft support organization. The information contained here is provided as-is in response to emerging issues. As a result of the speed in making it available, the materials may include typographical errors and may be revised at any time without notice. See [Terms of Use](https://go.microsoft.com/fwlink/?LinkId=151500) for other considerations.
