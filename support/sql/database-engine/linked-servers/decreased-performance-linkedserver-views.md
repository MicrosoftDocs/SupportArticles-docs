---
title: Performance issue when querying views across linked servers
description: This article provides explanation and resolution on decreased performance for running linked servers against views compared to running them against tables.
ms.date: 09/21/2021
ms.custom: sap:Performance
ms.reviewer: ramakoni, jopilov
author: pijocoder
ms.author: jopilov
ms.topic: troubleshooting
---

# Performance issue when querying views across linked servers

_Applies to:_ &nbsp; SQL Server

## Symptoms

Executing a query against views on a [linked server](/sql/relational-databases/linked-servers/linked-servers-database-engine) remotely takes more time than executing the same query directly against a base table on the linked server.

## Cause

Executing a query against a view and a base table results in a different behavior because of the data [cardinality estimation](/sql/relational-databases/performance/cardinality-estimation-sql-server), which is used for calculating the expected number of rows returned. The number for querying views is set to a constant value of 10,000 while the number for querying base tables is derived from [statistical information](/sql/relational-databases/statistics/statistics).

### Cardinality estimation on a base table queried by linked servers

The Microsoft OLE DB Provider (SQLOLEDB) (no longer maintained) or [Microsoft&reg; OLE DB Driver 18 for SQL Server&reg;](/sql/connect/oledb/download-oledb-driver-for-sql-server) (MSOLEDBSQL) both support distribution statistics on base tables. SQL Server can utilize the statistics and histogram over linked servers in the same way as any regular query does. For example, if you create a linked server called *LS1* that has the `AdventureWorks2019` database with the `Sales.SalesOrderDetail` table, the following queries can utilize the statistical histogram:

```tsql
SELECT * FROM LS1.AdventureWorks2019.Sales.SalesOrderDetail;
SELECT * FROM LS1.AdventureWorks2019.Sales.SalesOrderDetail WHERE SalesOrderID=43659;
```

The following graphical query plans show the estimated number of rows returned on each remote query.

:::image type="content" source="media/decreased-performance-linkedserver-views/linked-server-query-table.png" alt-text="Screenshot of the query for table in linked server.":::

### Cardinality estimation on views queried by linked servers

Linked server queries against views don't utilize statistics-based cardinality estimation. The cardinality estimation against a view is a constant value of 10,000. The following test illustrates this:

1. Create a view named `dbo.View1` that references the `Sales.SalesOrderDetail` table from the `AdventureWorks2019` database of the linked server *LS1*.

    ```tsql
    USE AdventureWorks2019;
    GO
    CREATE VIEW [dbo].[view1]
    AS
    SELECT * FROM Sales.SalesOrderDetail;
    ```

1. Query the view remotely.

    ```tsql
    SELECT * FROM LS1.AdventureWorks2019.dbo.view1;
    ```

1. The cardinality estimation of the query shows exactly **10,000** rows.

    :::image type="content" source="media/decreased-performance-linkedserver-views/linked-server-query-view.png" alt-text="Screenshot of the query for view in linked server.":::

### Cardinality estimation on a view queried by linked servers with WHERE clause

If you execute a query with the `WHERE` clause against views on a linked server, the cardinality estimation against views is also a constant value. However, the value varies depending on the compatibility level of the database.

> [!NOTE]
> The cardinality estimation value won't be impacted by the compatibility level of database where the view is defined.

- For a database compatibility level of 120 or higher ([new version of cardinality estimator](/sql/relational-databases/performance/cardinality-estimation-sql-server#versions-of-the-ce)), the cardinality estimation is 100.
- For a database compatibility level of 110 or lower (legacy cardinality estimator), the cardinality estimation is 1,000.

See the following queries for an example:

```tsql
SELECT * FROM LS1.AdventureWorks2019.dbo.view1
WHERE SalesOrderID=43659 
    OPTION (USE HINT ('FORCE_DEFAULT_CARDINALITY_ESTIMATION'));
GO
SELECT * FROM LS1.AdventureWorks2019.dbo.view1 
WHERE SalesOrderID=43659
OPTION (USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'));
```

See the following cardinality estimation of the queries for an example.

:::image type="content" source="media/decreased-performance-linkedserver-views/linked-server-query-viewce.png" alt-text="Screenshot of the query for view CE in linked server.":::

## Resolution

In most cases, no action is needed because most application workloads won't be impacted by the cardinality estimation on views when queried from linked servers. If the workload is impacted, use one of the following methods:

- Update and change the view as an [indexed view](/sql/relational-databases/views/create-indexed-views). The indexed view has at least one index with corresponding statistics. See the following queries to create and query an indexed view.

    > [!NOTE]
    > This method will expose actual statistics that represent the underlying data.

    ```tsql
    --Set the options to support indexed views.
    SET NUMERIC_ROUNDABORT OFF;
    SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
       QUOTED_IDENTIFIER, ANSI_NULLS ON;
    GO
    IF OBJECT_ID ('Sales.vOrderDetails1', 'view') IS NOT NULL
       DROP VIEW Sales.vOrderDetails1;
    GO
    --Create view with schemabinding
    CREATE VIEW Sales.vOrderDetails1
       WITH SCHEMABINDING
       AS  
          SELECT SalesOrderID, 
           SalesOrderDetailID, 
           CarrierTrackingNumber, 
           OrderQty, 
           ProductID,
           UnitPrice,
           UnitPriceDiscount,
           LineTotal,
           ModifiedDate
          FROM Sales.SalesOrderDetail
    GO
    --Create an index on the view
    CREATE UNIQUE CLUSTERED INDEX IDX_V1
       ON Sales.vOrderDetails1 (SalesOrderID, ProductID);
    --Select from the materialized view
    SELECT * FROM LS1.adventureworks2019.Sales.vOrderDetails1;
    ```

    See the following cardinality estimation of the query for an example.

    :::image type="content" source="media/decreased-performance-linkedserver-views/linked-server-query-indexed-view.png" alt-text="Screenshot of the query for indexed view in linked server.":::

- If you execute a query with the `WHERE` clause, you can increase the cardinality estimation by using the `Query Hint OPTION` (`USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION')`). This approach may help in some cases especially when joining with large tables.

    > [!NOTE]
    > This method is appropriate for cases where the view exposes many rows.

- Execute the query directly against the base tables instead of views on the linked server if appropriate.

## See also

- [Cardinality Estimation (SQL Server)](/sql/relational-databases/performance/cardinality-estimation-sql-server)
- [Monitor and Tune for Performance](/sql/relational-databases/performance/monitor-and-tune-for-performance)
- [Query Hints](/sql/t-sql/queries/hints-transact-sql-query)
- [USE HINT Query Hints](/sql/t-sql/queries/hints-transact-sql-query#use_hint)
- [Query Processing Architecture Guide](/sql/relational-databases/query-processing-architecture-guide)
