---
title: Iterate through a SQL Server result set in T-SQL without a cursor
description: This article describes methods to iterate through a SQL Server result set in Transact-SQL without a cursor.
ms.date: 03/11/2025
ms.custom: sap:Database or Client application Development
ms.reviewer: jopilov
ms.topic: how-to
---

# Iterate through a SQL Server result set in T-SQL without using a cursor 

This article describes methods that you can use to iterate through a result set by using Transact-SQL in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 111401

## Summary

This article describes methods that you can use to simulate a cursor-like `FETCH`-`NEXT` logic in a stored procedure, trigger, or Transact-SQL batch.

## Use Transact-SQL Statements to Iterate Through a Result Set

Here are three methods you can use to iterate through a result set by using Transact-SQL statements. The examples below use the Production.Product table from the [AdventureWorks sample database](/sql/samples/adventureworks-install-configure)

One method is the use of temp tables. With this method, you create a snapshot of the initial `SELECT` statement and use it as a basis for cursoring. For example:

```SQL
/********** example 1 **********/
SET NOCOUNT ON
DROP TABLE IF EXISTS #MYTEMP 
DECLARE @ProductID int

SELECT * INTO #MYTEMP FROM Production.Product

SELECT TOP(1) @ProductID = ProductID FROM #MYTEMP

WHILE @@ROWCOUNT <> 0
BEGIN
    SELECT * FROM #MYTEMP WHERE ProductID = @ProductID
    DELETE FROM #MYTEMP WHERE ProductID = @ProductID
    SELECT TOP(1) @ProductID = ProductID FROM #MYTEMP
END
```

A second method is to use the `min` function to walk a table one row at a time. This method catches new rows that were added after the stored procedure begins execution, provided that the new row has a unique identifier greater than the current row that is being processed in the query. For example:

```SQL
/********** example 2 **********/
SET NOCOUNT ON
DROP TABLE IF EXISTS #MYTEMP 
DECLARE @ProductID int

SELECT @ProductID = min( ProductID ) FROM Production.Product
WHILE @ProductID IS NOT NULL

BEGIN
    SELECT * FROM Production.Product WHERE ProductID = @ProductID
    SELECT @ProductID = min( ProductID ) FROM Production.Product WHERE ProductID > @ProductID
END
```

> [!NOTE]
> Both example 1 and 2 assume that a unique identifier exists for each row in the source table. In some cases, no unique identifier may exist. If that's the case, you can modify the temp table method to use a newly created key column. For example:

```SQL
/********** example 3 **********/
SET NOCOUNT ON
DROP TABLE IF EXISTS #MYTEMP 

SELECT NULL AS mykey, * INTO #MYTEMP FROM Production.Product

UPDATE TOP(1) #MYTEMP SET mykey = 1

WHILE @@ROWCOUNT > 0
BEGIN
    SELECT * FROM #MYTEMP WHERE mykey = 1
    DELETE FROM #MYTEMP WHERE mykey = 1
    UPDATE TOP(1) #MYTEMP SET mykey = 1
END
```

## References

[ROW_NUMBER (Transact-SQL)](/sql/t-sql/functions/row-number-transact-sql)
