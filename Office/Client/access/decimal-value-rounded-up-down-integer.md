---
title: Decimal value is rounded up/down to integer value
description: Describes a problem that occurs when you enter a decimal value in a column in Access 2007. The decimal value is rounded up or down to an integer value.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: jchishol, acc12b
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Access 2007
ms.date: 05/26/2025
---

# A decimal value in a column is rounded up or down to an integer value in Access

## Symptoms

When you enter a decimal value in a column in Microsoft Access, the decimal value is rounded up or down to an integer value.

This problem occurs when all the following conditions are true.

- The table is created in DataSheet view.   
- The first value that you enter in the first row of the column is an integer value.   

## Cause

When the first value that you enter in the first row of the column is an integer value, Access automatically sets the data type of the column to Number. Additionally, the Field Size property of the column is set to Long Integer. Therefore, the decimal value that you enter in the column is rounded up or down to the integer value.

## Workaround

To work around this problem, manually set the Field Size property of the column to Double or to Decimal. 

1. Click the **DataSheet** tab. In the **Views** group, click the arrow under **View**, and then click **Design View**.

   **Note** If the table has not already been saved, you will be prompted to save the table with a table name that you provide.   
2. Locate the column that you want to change, and then set the Field Size property of the column to **Double** or to **Decimal**.

   **Note** If you set the Field Size property of the column to Decimal, you must also set the Scale property of the column. When you set the Scale property, you specify the maximum number of digits that can be stored to the right of the decimal separator.   
3. Save the table.   

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More Information

If the first value that you enter in the first row of the column is a decimal value, Access automatically sets the Field Size property of this column to Double. Therefore, you do not encounter the problem that this article describes.
