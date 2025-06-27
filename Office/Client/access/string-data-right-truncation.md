---
title: Access error String data, right truncation (#0)
description: Describes an issue that causes the Access error String data, right truncation (#0).
author: helenclu
ms.reviewer: denniwil
manager: dcscontentpm
ms.custom: 
  - CI 152768
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
ms.date: 05/26/2025
---

# Access error: "String data, right truncation (#0)"

## Symptoms

When Microsoft Access tries to update the `varchar(max)` data type in a textbox control on a form or in the datasheet view of a table or query, you receive the following error message:

> String data, right truncation (#0)

## Cause

This error occurs under the following conditions:

- The `varchar(max)` data type contains more than 8,000 characters.

- The table being updated is linked to Microsoft SQL Server.

- The second-generation or third-generation SQL Server ODBC driver is in use.

Microsoft is aware of this issue and is investigating possible solutions. In the meantime, we recommend that you use the workarounds in the next section.

## Workarounds

To work around this issue, try either of the following methods.

**Method 1**: Change the data type to `nvarchar(max)`. SQL Server will return the `SQL_WVARCHAR` value instead. This value doesn't have any character limit.

**Method 2**: Use the first-generation SQL Server ODBC driver that's included in the Windows Data Access Components. For more information about SQL Server ODBC drivers, see [Driver history for Microsoft SQL Server](/sql/connect/connect-history).

## References

- [Using Large Value Types in SQL Server Native Client](/sql/relational-databases/native-client/features/using-large-value-types)

- [Data Type Usage](/sql/relational-databases/native-client-odbc-results/data-type-usage)
