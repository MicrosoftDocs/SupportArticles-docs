---
title: Rotate a table in SQL Server
description: This article describes how to rotate a table in SQL Server.
ms.date: 11/03/2020
ms.custom: sap:Database Design and Development
ms.topic: how-to
---

# Rotate a table in SQL Server

This article describes how to rotate a table in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 175574

## Summary

This article describes how to rotate a SQL Server table. Suppose you have a table that is named `QTRSALES`. The table has the columns `YEAR`, `QUARTER`, and `AMOUNT` with the data in the following format.

> [!NOTE]
> There is no row for the fourth quarter of 1996:

|Year|Quarter|Amount|
|-|-|-|
|1995| 1| 125,000.90|
|1995| 2| 136,000.75|
|1995| 3| 212,000.34|
|1995| 4| 328,000.82|
|1996| 3| 728,000.35|
|1996| 2| 422,000.13|
|1996| 1| 328,000.82|
  
Now, suppose you want to rotate the table so that you can see the data in the following format:

|YEAR |Q1| Q2 |Q3| Q4|
|-|-|-|-|-|
|1995 |125,000.90 |136,000.75| 212,000.34 |328,000.82|
|1996 |328,000.82 |422,000.13| 728,000.35 |0.00|

The query that you would use to rotate the table is in the next section of this article.

## Sample query to rotate the table

Here's the query that you would use to rotate the table:

```sql
SELECT YEAR,
Q1= ISNULL((SELECT AMOUNT FROM QTRSALES WHERE QUARTER = 1 AND YEAR =
Q.YEAR),0),
Q2= ISNULL((SELECT AMOUNT FROM QTRSALES WHERE QUARTER = 2 AND YEAR =
Q.YEAR),0),
Q3= ISNULL((SELECT AMOUNT FROM QTRSALES WHERE QUARTER = 3 AND YEAR =
Q.YEAR),0),
Q4= ISNULL((SELECT AMOUNT FROM QTRSALES WHERE QUARTER = 4 AND YEAR =
Q.YEAR),0)
FROM QTRSALES Q
GROUP BY YEAR
```

## Query for large tables

For large tables, this query will be faster:

```sql
SELECT YEAR,
SUM(CASE quarter WHEN 1 THEN amount ELSE 0 END) AS Q1,
SUM(CASE quarter WHEN 2 THEN amount ELSE 0 END) AS Q2,
SUM(CASE quarter WHEN 3 THEN amount ELSE 0 END) AS Q3,
SUM(CASE quarter WHEN 4 THEN amount ELSE 0 END) AS Q4
FROM qtrsales q
GROUP BY YEAR
```

## Reference

[FROM - Using PIVOT and UNPIVOT](/sql/t-sql/queries/from-using-pivot-and-unpivot)
