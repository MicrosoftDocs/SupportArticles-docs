A predicate in a query is considered SARGable (Search ARGument-able) when SQL Server engine can use an index seek to speed up the execution of the query. Many query designs prevent SARGability and lead to table or index scans and high-CPU usage. Consider the following query against the AdventureWorks database where every `ProductNumber` must be retrieved and the `SUBSTRING()` function applied to it, before it's compared to a string literal value. As you can see, you have to fetch all the rows of the table first, and then apply the function before you can make a comparison. Fetching all rows from the table means a table or index scan, which leads to higher CPU usage.

```sql
SELECT ProductID, Name, ProductNumber
FROM [Production].[Product]
WHERE SUBSTRING(ProductNumber, 0, 4) =  'HN-'
```

Applying any function or computation on the column(s) in the search predicate generally makes the query non-sargable and leads to higher CPU consumption. Solutions typically involve rewriting the queries in a creative way to make the SARGable. A possible solution to this example is this rewrite where the function is removed from the query predicate, another column is searched and the same results are achieved:

```sql
SELECT ProductID, Name, ProductNumber
FROM [Production].[Product]
WHERE Name LIKE  'Hex%'
```

Here's another example, where a sales manager may want to give 10% sales commission on large orders and wants to see which orders will have commission greater than $300. Here's the logical, but non-sargable way to do it.

```sql
SELECT DISTINCT SalesOrderID, UnitPrice, UnitPrice * 0.10 [10% Commission]
FROM [Sales].[SalesOrderDetail]
WHERE UnitPrice * 0.10 > 300
```

Here's a possible less-intuitive but SARGable rewrite of the query, in which the computation is moved to the other side of the predicate.

```sql
SELECT DISTINCT SalesOrderID, UnitPrice, UnitPrice * 0.10 [10% Commission]
FROM [Sales].[SalesOrderDetail]
WHERE UnitPrice > 300/0.10
```

SARGability applies not only to `WHERE` clauses, but also to `JOINs`, `HAVING`, `GROUP BY` and `ORDER BY` clauses. Frequent occurrences of SARGability prevention in queries involve `CONVERT()`, `CAST()`, `ISNULL()`, `COALESCE()` functions used in `WHERE` or `JOIN` clauses that lead to scan of columns. In the data-type conversion cases (`CONVERT` or `CAST`), the solution may be to ensure you're comparing the same data types. Here's an example where the `T1.ProdID` column is explicitly converted to the `INT` data type in a `JOIN`. The conversion defeats the use of an index on the join column. The same issue occurs with [implicit conversion](/sql/t-sql/data-types/data-type-conversion-database-engine#implicit-and-explicit-conversion) where the data types are different and SQL Server converts one of them to perform the join.

```sql
SELECT T1.ProdID, T1.ProdDesc
FROM T1 JOIN T2 
ON CONVERT(int, T1.ProdID) = T2.ProductID
WHERE t2.ProductID BETWEEN 200 AND 300
```

To avoid a scan of the `T1` table, you can change the underlying data type of the `ProdID` column after proper planning and design, and then join the two columns without using the convert function `ON T1.ProdID = T2.ProductID`.

Another solution is to create a computed column in `T1` that uses the same `CONVERT()` function and then create an index on it. This will allow the query optimizer to use that index without the need for you to change your query.

```sql
ALTER TABLE dbo.T1  ADD IntProdID AS CONVERT (INT, ProdID);
CREATE INDEX IndProdID_int ON dbo.T1 (IntProdID);
```

In some cases, queries can't be rewritten easily to allow for SARGability. In those cases, see if the computed column with an index on it can help, or else keep the query as it was with the awareness that it can lead to higher CPU scenarios.