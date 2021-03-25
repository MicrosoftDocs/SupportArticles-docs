---
title: Remove duplicate rows from a table in SQL Server
description: This article lists the script that you can use to remove duplicate rows from a SQL Server table.
ms.date: 10/29/2020
ms.prod-support-area-path: Database Design and Development
ms.topic: how-to
ms.prod: sql
---
# Remove duplicate rows from a SQL Server table by using a script

This article provides a script that you can use to remove duplicate rows from a table in Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 70956

## Summary

You can use the following script to remove duplicate rows from a SQL Server table:

```sql
SELECT DISTINCT *
INTO duplicate_table
FROM original_table
GROUP BY key_value
HAVING COUNT(key_value) > 1

DELETE original_table
WHERE key_value
IN (SELECT key_value
FROM duplicate_table)

INSERT original_table
SELECT *
FROM duplicate_table

DROP TABLE duplicate_table
```

When this script runs, the program will take the following actions in the given order:

- Move one instance of any duplicate row in the original table to a duplicate table.
- Delete all rows from the original table that also reside in the duplicate table.
- Return the duplicate rows in the duplicate table to the original table.
- Drop the duplicate table.

## More information

This method is simple. However, it requires that you have sufficient available space in the database to temporarily build the duplicate table.
