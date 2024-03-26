---
title: Not a valid Teradata SQL token error when you run outer join queries
description: Fixes an issue when executing outer join queries that utilize linked tables with the Teradata ODBC driver 15.10 or later
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
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
ms.date: 03/31/2022
---

# "Not a valid Teradata SQL token" error when you run outer join queries

## Symptoms

When you use the Teradata ODBC driver 15.10 or a later version to run outer join queries in Microsoft Access, you receive the following error message:
```adoc
('7B'X) is not a valid Teradata SQL token. (#-3704).
```

## Cause

This issue occurs because Teradata created a new SQL parser that more closely aligns to the SQL-92 standard and does not support extended SQL (escape clauses).

Access does not use the SQL-92 standard for queries that are created within the Query Editor. This causes queries that use outer joins to fail because they use the {oj} escape clause.

## Resolution

To fix the issue, use one of the following methods:

### Method 1

When you use the Teradata ODBC driver (15.10 or a later version), you can use the **EnableLegacyParser** option to continue using the previous SQL parser.

> [!NOTE]
> Teradata plans to remove the **EnableLegacyParser** option beginning in driver version 18.

### Method 2

Prevent Access from using outer joins in queries, or run outer joins within pass-through queries. For more information, see the following Knowledge Base and Office articles:

- [How to create an SQL pass-through query in Access](https://support.microsoft.com/help/303968)

- [Process SQL on a database server by using a pass-through query](https://support.office.com/article/Process-SQL-on-a-database-server-by-using-a-pass-through-query-B775AC23-8A6B-49B2-82E2-6DAC62532A42)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
