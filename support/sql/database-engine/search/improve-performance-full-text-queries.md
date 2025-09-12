---
title: Improve the performance of full-text queries
description: This article describes a method to improve the performance of queries that use full-text predicates in SQL Server.
ms.date: 05/06/2025
ms.custom: sap:Full-Text Search, Semantic Search
ms.topic: how-to
---
# Improve the performance of full-text queries in SQL Server

This article provides a method to improve the performance of queries that use full-text predicates in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2549443

## Summary

This article describes a method to improve the performance of Microsoft SQL Server queries that use full-text search predicates (such as `CONTAINS` and `CONTAINSTABLE`) and that also filter data. For example, this method improves the performance of the following query:

```sql
SELECT * FROM dbo.ftTest WHERE CONTAINS(TextData, '"keyword"') AND CDate > @date
```

This method lets you design the query, table schema, and full-text index in such a way that the full-text search engine filters out results before they're sent to the relational engine. Therefore, the relational engine doesn't have to filter a large dataset.

## More information

When you create a full-text search query, the principle factor that affects the performance of the query is the quantity of data that the full-text search engine must process before the remaining data is sent to the relational engine. In SQL Server, you can improve the performance of the query by filtering out rows early to reduce the number of rows that must be processed later.

The method that this article describes uses the Table-Valued Function (TVF) to filter out rows early and to reduce the number of rows that must be processed later.

For example, the following query plan returns 131051 rows that match a `CONTAINS` search string. Additionally, a join operator in the plan performs additional filtering by using an index seek.

```sql
Rows StmtText
-------------------- ----------------------------------------------------------------------------------------
1167 SELECT CDate, ID FROM dbo.fttest WHERE contains (c2, '"create"') AND CDate> '08/05/2019'

1167 |--Merge Join(Left Semi Join, MERGE:([FTSdb].[dbo].[fttest].[ID])=(FulltextMatch.[docid]), RESIDUA
5858 |--Sort(ORDER BY:([FTSdb].[dbo].[fttest].[ID] ASC))
5858 | |--Clustered Index Seek(OBJECT:([FTSdb].[dbo].[fttest].[clidx1]), SEEK:([FTSdb].[
131051 |--Table-valued function
```

However, if the query includes the full-text unique index key column as a predicate, the full-text search engine can use the predicate to filter results at the full-text level. In this situation, the TVF returns a much smaller amount of data before additional filtering must be applied. For example, the following query specifies five values that must match the c2 condition, and the TVF returns only those results that match the five values:

```sql
Rows StmtText
-------------------------------------------------------------------------------------------------------------------------------------------
5 SELECT CDate, ID FROM dbo.fttest WHERE contains (c2, '"create"') AND CDate > '08/05/2019' AND ID IN ( 654051, 644051, 649106, 465, 105)

5 |--Nested Loops(Left Semi Join, OUTER REFERENCES:([FTSdb].[dbo].[fttest].[ID]))
5 |--Index Seek(OBJECT:([FTSdb].[dbo].[fttest].[idx1]), SEEK:([FTSdb].[dbo].[fttest].[ID]=(105) OR ...
5 |--Table-valued function
```

The full-text search engine's ability to push down the values that are used by the unique index key is the basis of the following method.

If a predicate contains a `DateTime` data type column, you can include date information in the unique index key column so that only the rows that match this predicate are returned. To do this, you must logically incorporate the date information in the key column. However, you might also have to change the key column data type and applications that use the query.

To implement the method, change the data type of the full-text unique key `ID` to `BIGINT`. The first 4 bytes of the key ID capture the year, month, and date values from the date column, and the last 4 bytes remain the same. For example, the first byte of the key ID could refer to the year, the next byte could refer to the month, and the last 2 bytes could refer to the date. The application must accommodate this data type change.

Then, translate a range predicate to a predicate on the key ID. For example, the `x < CDate < y` range predicate can be translated to the `(x*2^32 < ID < y*2^32)` predicate. Because the translated predicate is a predicate on the full-text key, the predicate will be pushed down into the full-text Streaming Table-Valued Functions (STVF). This behavior effectively performs searches within the date range.
