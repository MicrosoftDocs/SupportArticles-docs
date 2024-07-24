---
title: Iterate through a result set by using Transact-SQL
description: This article describes various methods that you can use to iterate through a result set by using Transact-SQL in SQL Server.
ms.date: 07/24/2024
ms.custom: sap:Database or Client application Development
ms.topic: how-to
---

# Iterate through a result set by using Transact-SQL in SQL Server

This article describes various methods that you can use to iterate through a result set by using Transact-SQL in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 111401

## Summary

This article describes various methods that you can use to simulate a cursor-like `FETCH`-`NEXT` logic in a stored procedure, trigger, or Transact-SQL batch.

## Use Transact-SQL Statements to Iterate Through a Result Set

There are three methods you can use to iterate through a result set by using Transact-SQL statements.

One method is the use of temp tables. With this method, you create a snapshot of the initial `SELECT` statement and use it as a basis for cursoring. For example:

```SQL
/********** example 1 **********/
DECLARE @au_id char(11)

SELECT * INTO #mytemp FROM authors

SELECT TOP(1) @au_id = au_id FROM #mytemp

WHILE @au_id IS NOT NULL
BEGIN
    SELECT * FROM #mytemp WHERE au_id = @au_id

    DELETE FROM #mytemp WHERE au_id = @au_id

    SELECT TOP(1) @au_id = au_id FROM #mytemp
END
```

A second method is to use the `min` function to walk a table one row at a time. This method catches new rows that were added after the stored procedure begins execution, provided that the new row has a unique identifier greater than the current row that is being processed in the query. For example:

```SQL
/********** example 2 **********/
DECLARE @au_id char( 11 )

SELECT @au_id = min( au_id ) FROM authors
WHILE @au_id IS NOT NULL

BEGIN
SELECT * FROM authors WHERE au_id = @au_id
SELECT @au_id = min( au_id ) FROM authors WHERE au_id > @au_id
END
```

> [!NOTE]
> Both example 1 and 2 assume that a unique identifier exists for each row in the source table. In some cases, no unique identifier may exist. If that's the case, you can modify the temp table method to use a newly created key column. For example:

```SQL
/********** example 3 **********/
SELECT NULL AS mykey, * INTO #mytemp FROM authors

UPDATE TOP(1) #mytemp SET mykey = 1

WHILE EXISTS (SELECT 1 FROM #mytemp WHERE mykey = 1)
BEGIN
    SELECT * FROM #mytemp WHERE mykey = 1

    DELETE FROM #mytemp WHERE mykey = 1

    UPDATE TOP(1) #mytemp SET mykey = 1
END
```

## References

[ROW_NUMBER (Transact-SQL)](/sql/t-sql/functions/row-number-transact-sql)
