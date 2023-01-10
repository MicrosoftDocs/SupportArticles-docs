---
title: Can't export fields with data type single or double
description: Fixes an issue in which you may receive an error in Access 2002, in Access 2003, or in Access 2007 when you export fields with data type single or double to Oracle.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
  - Microsoft Office Access 2002
search.appverid: MET150
ms.date: 3/31/2022
---
# Access causes an error when you export fields with data type single or double to Oracle

_Original KB number:_ &nbsp; 301915

> [!NOTE]
> Requires basic macro, coding, and interoperability skills. This article applies to a Microsoft Access database (.mdb) and to a Microsoft Access project (.adp).

## Symptoms

When you use the Oracle ODBC driver to export an Access table that has fields of data type Single or Double, the driver fails to export those fields as follows.

The Microsoft Oracle driver displays the following error message:

> Microsoft Access was unable to append all the data to the table.
> The contents of fields in \<number> record(s) were deleted, and 0 record(s) were lost due to key violations.
> - If data was deleted, the data you pasted or imported doesn't match the field data types or the FieldSize property in the destination table.
> - If records were lost either the records you pasted contain primary key values that already exist in the destination table, or they violate referential integrity rules for a relationship defined between tables. Do you want to continue anyway?

The Oracle ODBC drivers up to and including version 8.1.6 display the following error message:

> ODBC - call failed
> [Oracle][ODBC][ORA] ORA-01401: Inserted value too large for column (#1401)

## Cause

In Microsoft Access 97, the export process converts the Single and Double data type fields to VarChar2(40). However, in Microsoft Access 2000 and later, the fields are converted to VarChar2(4), which it too small to hold the data.

## Resolution

To successfully export the data to Oracle, use a query based on the relevant tables. Use the
CStr()function to convert the data type to String.

For example, consider the following SQL syntax:

```sql
SELECT tblExample.pkeyDataID, tblExample.dblTest
FROM tblExample;
```

where dblTest is a field with a data type of Double. Convert dblTest to a String data type by making the following change to the SQL syntax:

```sql
SELECT tblExample.pkeyDataID, CStr([dblTest]) AS Expr1
FROM tblExample;

```

The query can now be successfully exported to Oracle.

This problem is resolved in Microsoft Jet 4.0 Database Engine Service Pack 8 (SP8).

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More Information

The third-party products that are discussed in this article are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, regarding the performance or reliability of these products.
