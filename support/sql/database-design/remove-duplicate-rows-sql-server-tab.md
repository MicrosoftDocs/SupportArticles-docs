---
title: Remove duplicate rows from table
description: This article provides a script that you can use to remove duplicate rows from a SQL Server table.
ms.date: 10/29/2020
ms.prod-support-area-path: Database Design and Development
ms.topic: how-to
ms.prod: sql
---
# Remove duplicate rows from a SQL Server table by using a script

This article contains a script that you can use to remove duplicate rows from a table in Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 70956

## Summary

There are two common methods that you can use to delete duplicate records from a SQL Server table. For demonstration, start by creating a sample table and data:

```sql
create table original_table (key_value int )

insert into original_table values (1)
insert into original_table values (1)
insert into original_table values (1)

insert into original_table values (2)
insert into original_table values (2)
insert into original_table values (2)
insert into original_table values (2)
```

Then, try the following methods to remove the duplicate rows from the table.

### Method 1

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

This method is simple. However, it requires you to have sufficient space available in the database to temporarily build the duplicate table. This method also incurs overhead because you are moving the data.

Also, if your table has an [IDENTITY](https://docs.microsoft.com/sql/t-sql/statements/create-table-transact-sql-identity-property) column, you would have to use [SET IDENTITY_INSERT ON](https://docs.microsoft.com/sql/t-sql/statements/set-identity-insert-transact-sql) when you restore the data to the original table.

### Method 2

The [ROW_NUMBER function](https://docs.microsoft.com/sql/t-sql/functions/row-number-transact-sql) that was introduced in Microsoft SQL Server 2005 makes this operation much simpler:

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

- Uses the `ROW_NUMBER` function to partition the data based on the `key_value`. The result will be one or more columns of values separated by commas.
- Deletes all records that received a `DupRank` value that is greater than 1. This value indicates that the records are duplicates.

Because of the `(SELECT NULL)` expression, the script does not sort the partitioned data based on any condition. If your logic to delete duplicates requires choosing which records to delete and which to keep based on the sorting order of other columns, you could use the ORDER BY expression to do this.

## More information

Method 2 is simple and effective for these reasons:

- It does not require you to temporarily copy the duplicate records to another table.
- It does not require you to join the original table with itself (for example, by using a subquery that returns all duplicate records by using a combination of GROUP BY and HAVING).
- For best performance, you should have a corresponding index on the table that uses the `key_value` as the index key and includes any sorting columns that you might have used in the ORDER BY expression.

However, this method does not work in outdated versions of SQL Server that do not support the [ROW_NUMBER function](https://docs.microsoft.com/sql/t-sql/functions/row-number-transact-sql). In this situation, you should use Method 1 or some similar method instead.
