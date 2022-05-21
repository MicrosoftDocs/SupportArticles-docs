---
title: Determine the first or last member with data
description: This article describes how to determine the first or last member with data.
ms.date: 09/21/2020
ms.custom: sap:Analysis Services
ms.topic: how-to
ms.prod: sql
---
# Determine the first or last member with data

## Summary

In some applications, it is useful to find the first or last dimension member that has data associated with it. This article illustrates how to use the `HEAD()`, `TAIL()`, and `UNION()` functions to return the first and last members of a dimension that have data. The article also illustrates the use of the `NonEmptyCrossJoin()` function.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 301934

## More information

Assume that your task is to find the first and last members of the time dimension with data from the FoodMart 2000 sample. For many, the first thought for finding the first member with data would be to use the `FirstChild()` function as follows:

```sql
SELECT {[Time].FirstChild} ON COLUMNS
FROM SALES
```

Likewise, the first thought for finding the last member of the time dimension with data would be to use the `LastChild()` function as follows:

```sql
SELECT {[Time].[1998].[Q4].LastChild} ON COLUMNS
FROM SALES
```

The first multidimensional expression (MDX) query, however, returns the value associated with [1997].[Q1] and not the value associated with [1997], which is the first member with data. The second MDX query returns the value associated with [1997].[Q4].[12], which is the last member of the dimension, but not the last member with data.

As an alternative, the `HEAD()` function returns the first specified number of elements in a set, and can be used to return the first member of the dimension. Likewise, the `TAIL()` function returns a subset from the end of a set and can be used to return the last member of the dimension. The MDX query to return the first member of the time dimension would take the following form:

```sql
SELECT HEAD([Time].Members,1) ON COLUMNS
FROM SALES
```

This query does return 1997 as the first member of the dimension with data.

The MDX query to return the last member of the dimension would take the following form:

```sql
SELECT TAIL([Time].Members,1) ON COLUMNS
FROM SALES
```

This MDX query returns [1998].[Q4].[12] as the last member of the dimension. However, the member returned is not the last member of the dimension with data. In order to eliminate members with no data, the `NonEmptyCrossJoin()` function should be used to filters out all the members in the dimension that don't have data associated with them.

The MDX query to find the first member with data then takes the form

```sql
SELECT HEAD(NonEmptyCrossJoin([Time].Members,1),1) ON COLUMNS
FROM SALES
```

and the MDX query to find the last member with data then takes the form:

```sql
SELECT TAIL(NonEmptyCrossJoin([Time].Members,1),1) ON COLUMNS
FROM SALES
```

The `UNION()` function can then be used to combine the two MDX queries into a single query:

```sql
SELECT
UNION(HEAD(NonEmptyCrossJoin([Time].Members,1),1), TAIL(NonEmptyCrossJoin([Time].Members,1),1)) ON COLUMNS
FROM SALES
```
