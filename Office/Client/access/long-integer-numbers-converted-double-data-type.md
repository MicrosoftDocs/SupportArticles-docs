---
title: Access exports long integer numbers as double data type with decimal places in dBase IV (.dbf) format
description: Describes a problem that occurs you export an Access table that contains long integer numbers to dBase IV (*.dbf) format. During export, the numbers are converted to double data type and will show decimal places.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: meerak
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
ms.reviewer: amyv
ms.date: 05/26/2025
---
# Access exports long integer numbers as double data type with decimal places in dBase IV (.dbf) format

_Original KB number:_ &nbsp; 891775

## Symptoms

When you create a Microsoft Office Access table that contains long integer numbers and then you export that table as type dBase IV (.dbf), the numbers are converted to double data type and will show decimal places.

For example, you may export the following table:

> UNITS  
23411  
111111111  
1121212  

When you then import and view the data in dBase IV, the data appears similar to the following:

> UNITS  
23411.00000  
111111111.00000  
1121212.00000

> [!NOTE]
> When you create a number field in a table in Access, you use the
 FieldSize property to control the amount of space that is allocated for a particular field. For number fields, you can choose one of the following numeric types from a list:

- Byte
- Integer
- Long Integer
- Single
- Double
- ReplicationID
- Decimal

By default, the setting for number fields is Long Integer. The Long Integer value stores whole numbers that range from about -2 billion to +2 billion. Or, you can choose the Double value to store numbers with decimals.

## Cause

This problem occurs because there's no Integer data type in dBase. dBase uses either Numeric or Float data types. Access maps Long Integers to the Numeric data type in dBase.

## Workaround

To work around this problem, use one of the following methods:

### Method 1: Modify the database file in dBase

Modify the design of the database file after it has been added to the dBase catalog. For example, set the Dec column to 0 (zero). For more information about designing database files in dBase, see the dBase documentation.

### Method 2: Use Microsoft Office Excel to format the data

Use Excel to format the data in the table that you exported. To do this, follow these steps:

1. In Excel, open the table that you exported as type dBase IV (*.dbf) from Access.
2. Format the cells that aren't correctly formatted. To do this, select the cells, and then click **Cells** on the
 **Format** menu.
3. After you have formatted the cells, export the spreadsheet as a dBase IV file. To do this, follow these steps:
   1. On the **File** menu, click **Save As**.
   2. In the **Save as type** box, click **DBF 4 (dbase IV) (*.dbf)**, and then click **Save**.

### Method 3: Use sample code to format the data

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

You can use the following code sample to automate the process of formatting the data. The sample will save a table as a text file. Then, it will automate Excel to open the text file and then save it in dBase IV format.

> [!NOTE]
> You must change the file names in this code sample to match your file names.

```vb
Sub exportFormat()

    Dim xlApp       As Excel.Application
    Dim xlBook      As Excel.Workbook

    Const SAVETEXT = "C:\testValues.txt"
    Const SAVEDBF = "C:\testDBF.dbf"

    ' Save the table as a text file.
    DoCmd.TransferText acExportDelim, , "Table1", SAVETEXT, TRUE

    ' Set a reference to the Application object.
    Set xlApp =        ' Set a reference to the Workbook object.
    Set xlBook = xlApp.Workbooks.Open(SAVETEXT, , ,        ' Save the file to dBase IV format.
    xlBook.SaveAs Filename:=SAVEDBF, FileFormat:=xlDBF4
    xlBook.Close savechanges:=False

    xlApp.Quit
    Set xlBook = Nothing
    Set xlApp = Nothing

End Sub
```
