---
title: Dashes ignored in search with SQL Full-Text
description: This article provides two workarounds for the problem that occurs when you perform a full-text search on SQL Server character data, or when you use a SQL distributed query with the Microsoft Index Server OLE DB provider (MSIDXS) and a prefix expansion search for a compound word that contains a hyphen (for example, XYZ-A*).
ms.date: 01/15/2021
ms.custom: sap:Administration and Management
ms.reviewer:  
---
# Dashes '-' ignored in search with SQL Full-Text and MSIDXS queries

This article helps you work around the problem that occurs when you perform a full-text search on SQL Server character data, or when you use a SQL distributed query with the Microsoft Index Server OLE DB provider (MSIDXS) and a prefix expansion search for a compound word that contains a hyphen (for example, XYZ-A*).

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 200043

## Symptoms

When performing a full-text search on SQL Server character data, or when using a SQL distributed query with the Microsoft Index Server OLE DB provider (MSIDXS) and a prefix expansion search for a compound word that contains a hyphen (for example, "XYZ-A*"), the results produced may not be as expected.

## Cause

A full-text search considers a word to be a string of characters without spaces or punctuation. The occurrence of a non-alphanumeric character can break a word during a search. Because the SQL Server full-text search is a word-based engine, punctuation generally is not considered and is ignored when searching the index. Therefore, a `CONTAINS` clause like `CONTAINS(testing, "computer-failure")` would match a row with the value, **The failure to find my computer would be expensive**.

## Workaround

To work around this problem, try one of the following methods:

- Only use alphanumeric characters when using the SQL Server full-text index facilities.

- Where non-alphanumeric character must be used in the search criteria (primarily the dash `-` character), use the Transact-SQL `LIKE` clause instead of the `FULLTEXT` or `CONTAINS` predicates.

## More information

Microsoft SQL Server version 7.0 provides the ability to perform a full-text query on character data stored in SQL Server tables. You can also use a SQL distributed query with the MSIDXS provider to search for file system data. Using the dash (`-`) in a proximity search is not supported and may give unexpected results.

## References

- For more information on SQL Server full-text search, see the SQL Server Books Online.

- For more information on the use of the CONTAINS clause with the Microsoft Index Server (MSIDXS) provider, see the Index Server documentation in the Windows NT 4.0 Option Pack documentation.
