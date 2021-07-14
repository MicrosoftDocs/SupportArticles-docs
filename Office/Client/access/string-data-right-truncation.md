---
title: Access error String data, right truncation (#0)
description: Describes an issue that results in the error String data, right truncation (#0).
author: Dennis Wilmar
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 152768
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-matham
appliesto:
- Access for Office 365
- Access 2019
- Access 2016
---

# Access error “String data, right truncation (#0)”

## Symptoms

When Microsoft Access tries to update the `varchar(max)` column from a textbox control on a form, or in the datasheet view of a table or query, the following error occurs:

> String data, right truncation (#0)

## Cause

The error occurs under the following conditions:

- The `varchar(max)` column is greater than 8,000 characters.

- The table being updated is linked to Microsoft SQL Server.

- The second- or third-generation SQL Server ODBC driver is in use.

We are aware of this issue and are investigating possible solutions. In the meantime, see the below workarounds.

## Workarounds

To work around this problem, try one of the following methods:

- Change the table columns to `nvarchar(max)`. SQL Server will return the `SQL_WVARCHAR` instead, which doesn’t have the character limit.

- Use the first-generation SQL Server ODBC driver found in the Windows Data Access Components. For more information about SQL Server ODBC drivers, see [Driver history for Microsoft SQL Server](/sql/connect/connect-history).

## References

- [Using Large Value Types in SQL Server Native Client](/sql/relational-databases/native-client/features/using-large-value-types)

- [Data Type Usage](/sql/relational-databases/native-client-odbc-results/data-type-usage)