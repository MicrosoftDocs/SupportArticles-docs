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

In this page, we will demonstrate two common methods for deleting duplicate records from a Microsoft SQL Server table.

First, we'll start with creating a sample table and data, and then present the two methods to delete the duplicates.

### Create Sample Data

Let's create a sample table with some data:

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

### Method 1

You can use the following script to remove the duplicate rows:

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

When this script is executed, it follows these steps:

1. It moves one instance of any duplicate row in the original table to a duplicate table.
2. It deletes all rows from the original table that also reside in the duplicate table.
3. It moves the rows in the duplicate table back into the original table.
4. It drops the duplicate table.

This method is simple. However, it requires that you have sufficient space available in the database to temporarily build the duplicate table, and it also incurs overhead due to the data being moved.

Also, if your table has an [IDENTITY](https://docs.microsoft.com/sql/t-sql/statements/create-table-transact-sql-identity-property) column, you would have to use [SET IDENTITY_INSERT ON](https://docs.microsoft.com/sql/t-sql/statements/set-identity-insert-transact-sql) when inserting the data back into the original table.

### Method 2

Starting with SQL Server 2005, the [ROW_NUMBER function](https://docs.microsoft.com/sql/t-sql/functions/row-number-transact-sql) was introduced, which makes this operation much simpler:

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

Method 2 is simple and effective:

- It does not require you to temporarily copy the duplicate records to another table.
- It does not require joining the original table with itself (for example, with a subquery returning all duplicate records using a combination of GROUP BY and HAVING).
- For best performance, you should have a corresponding index on the table with the `key_value` as the index key, and any sorting columns that you may have used in the ORDER BY expression.

However, it will not work on outdated versions of SQL server that do not support the [ROW_NUMBER function](https://docs.microsoft.com/sql/t-sql/functions/row-number-transact-sql), in which case, method 1 or something similar to it will have to be used instead.
