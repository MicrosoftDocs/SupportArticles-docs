---
title: Remove Duplicate Rows from a SQL Server Table
description: Learn how to find and remove duplicate rows from a SQL Server table by using a T-SQL script, either by using a separate table or the ROW_NUMBER function.
ms.date: 10/15/2026
ms.custom: sap:Database or Client application Development
ms.topic: how-to
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Remove duplicate rows from a SQL Server table by using a script

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 70956

## Summary

This article shows how to remove duplicate rows from a table in Microsoft SQL Server by using a Transact-SQL (T-SQL) script. It describes two common methods: copying one instance of each duplicate row to a separate table, and using the `ROW_NUMBER` function to delete the extra rows in place. Use this article if a table contains repeated records, for example because it has no unique constraint or primary key. Method 2 is simpler because it works in place.

## Create a sample table that contains duplicate rows

To demonstrate both methods, create a sample table named `original_table` that has one column, `key_value`, and add duplicate data:

```sql
CREATE TABLE original_table (key_value int )

INSERT INTO original_table values (1)
INSERT INTO original_table values (1)
INSERT INTO original_table values (1)

INSERT INTO original_table values (2)
INSERT INTO original_table values (2)
INSERT INTO original_table values (2)
INSERT INTO original_table values (2)
```

Then, use one of the following methods to remove the duplicate rows from the table.

> [!NOTE]
> These scripts permanently delete data. Back up the table or database before running them against production data.

## Method 1: Move duplicate rows to a separate table and reinsert one copy

Method 1 uses two tables: `original_table` and a second table, `duplicate_table`, that the script creates and then drops. To apply the script to another table, replace `original_table` with the table name. This method requires rewriting the `GROUP BY` and `COUNT` logic if a duplicate is defined by more than one column.

Run the following script:

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

This script takes the following actions in the given order:

- Moves one instance of any duplicate row in the original table to a duplicate table.
- Deletes all rows from the original table that are also located in the duplicate table.
- Moves the rows in the duplicate table back into the original table.
- Drops the duplicate table.

This method is simple. However, it requires you to have sufficient space available in the database to temporarily build the duplicate table. This method also incurs overhead because you're moving the data.

Also, if your table has an [IDENTITY](/sql/t-sql/statements/create-table-transact-sql-identity-property) column, you must use [SET IDENTITY_INSERT ON](/sql/t-sql/statements/set-identity-insert-transact-sql) when you restore the data to the original table.

## Method 2: Use the ROW_NUMBER function to delete duplicate rows

The [ROW_NUMBER](/sql/t-sql/functions/row-number-transact-sql) function, which was introduced in Microsoft SQL Server 2005, makes this operation much simpler. Replace `key_value` with the column or columns that define a duplicate.

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

This script takes the following actions in the given order:

- Uses the `ROW_NUMBER` function to partition the data based on the `key_value` which can be one or more columns separated by commas.
- Deletes all records that received a `DupRank` value that is greater than 1. This value indicates that the records are duplicates.

Because of the `(SELECT NULL)` expression, the script doesn't sort the partitioned data based on any condition. If your logic to delete duplicates requires choosing which records to delete and which to keep based on the sorting order of other columns, you could use the `ORDER BY` expression to do this.

### Keep the most recent row when you remove duplicates

To keep the row with the latest value, sort in descending order by that column. For example, consider a hypothetical `employee_table` that has more than one row for the same employee. The following script keeps only the row that has the most recent `updated_date` value:

```sql
DELETE T
FROM
(
SELECT *
, DupRank = ROW_NUMBER() OVER (
              PARTITION BY employee_name
              ORDER BY updated_date DESC
            )
FROM employee_table
) AS T
WHERE DupRank > 1
```

The row that has the most recent `updated_date` value receives a `DupRank` of 1, so the script keeps it and deletes the older rows.

## Why is Method 2 recommended?

[Method 2](#method-2-use-the-row_number-function-to-delete-duplicate-rows) is simple and effective for these reasons:

- It doesn't require you to temporarily copy the duplicate records to another table.
- It doesn't require you to join the original table with itself (for example, by using a subquery that returns all duplicate records by using a combination of `GROUP BY` and `HAVING`).
- For best performance, you should have a corresponding index on the table that uses the `key_value` as the index key and includes any sorting columns that you might have used in the `ORDER BY` expression.

The `ROW_NUMBER` function is available in SQL Server 2005 and later versions. If you use a version of SQL Server that doesn't support the [ROW_NUMBER function](/sql/t-sql/functions/row-number-transact-sql), use [Method 1](#method-1-move-duplicate-rows-to-a-separate-table-and-reinsert-one-copy) or a similar method instead.

## How can I prevent duplicate rows in a table?

After you remove the duplicates, you can help prevent new duplicate rows by defining a [unique constraint](/sql/relational-databases/tables/create-unique-constraints) or a [unique index](/sql/relational-databases/indexes/create-unique-indexes) on the column or columns that identify a row.

## Related content

- [DELETE (Transact-SQL)](/sql/t-sql/statements/delete-transact-sql)
- [OVER clause (Transact-SQL)](/sql/t-sql/queries/select-over-clause-transact-sql)
- [WITH common_table_expression (Transact-SQL)](/sql/t-sql/queries/with-common-table-expression-transact-sql)
