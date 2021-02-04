---
title: Remove duplicate rows from table
description: This article lists the script that you can use to remove duplicate rows from a SQL Server table.
ms.date: 10/29/2020
ms.prod-support-area-path: Database Design and Development
ms.topic: how-to
ms.prod: sql
---
# Remove duplicate rows from a SQL Server table by using a script

This article lists the script that you can use to remove duplicate rows from a SQL Server table.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 70956

## Summary

You can use the following script to remove duplicate rows from a Microsoft SQL Server table:

```sql
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY key_value
              ORDER BY (SELECT NULL)
            )
FROM original_table
) AS T
WHERE DupRank > 1 
```

When this script is executed, it follows these steps:

1. Using the `ROW_NUMBER` function, it partitions the data based on the `key_value`, which may be one or more columns separated by commas.
2. It does NOT sort the partitioned data based on anything because of the `(SELECT NULL)` expression. If your duplicates deletion logic requires choosing which records to delete and which to retain based on sorting order of other column(s), you may use the ORDER BY expression accordingly.
3. It deletes all records that received a `DupRank` value higher than 1, which would indicate that they're duplicates.

## More information

This method is simple and effective:

- It does not require you to temporarily copy the duplicate records to another table.
- It does not require joining the original table with itself (for example, with a subquery returning all duplicate records using a combination of GROUP BY and HAVING).
- For best performance, you should have a corresponding index on the table with the `key_value` as the index key, and any sorting columns that you may have used in the ORDER BY expression.
- This method will not work on outdated versions of SQL server that do not support the ROW_NUMBER function.
- See more info on the [ROW_NUMBER function](https://docs.microsoft.com/sql/t-sql/functions/row-number-transact-sql).
