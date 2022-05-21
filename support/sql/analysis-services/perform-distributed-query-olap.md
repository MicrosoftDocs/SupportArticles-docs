---
title: Perform a distributed query with OLAP Server
description: This article describes how to perform a SQL Server distributed query with OLAP Server.
ms.date: 09/21/2020
ms.custom: sap:Analysis Services
ms.topic: how-to
ms.prod: sql
---
# How to perform a SQL Server distributed query with OLAP Server  

This article describes how to perform a SQL Server distributed query with OLAP Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 218592

## Summary

This article describes how to perform a SQL Server distributed query to retrieve data from an OLAP Services (or Analysis Services) cube. With Microsoft SQL Server, you can perform queries against OLE DB providers. To do this, you can use one of the following:

- Use the `OPENQUERY` or the `OPENROWSET` Transact-SQL functions.
- Use a query with four-part names, including a linked-server name.

For example:

```sql
sp_addlinkedserver 'mylinkedserver', 'product_name', 'myoledbprovider', 'data_source','location', 'provider_string', 'catalog'
SELECT *
FROM OPENQUERY(mylinkedserver, 'select * from table1')
```

You can use the `OPENROWSET` or the `OPENQUERY` function in a SQL Server `SELECT` statement to pass queries to the linked OLAP server. The query is limited to the abbreviated `SELECT` syntax that is supported by OLAP Services; however, the query can include Multidimensional Expressions (MDX) syntax. A query that includes MDX returns **flattened rowsets** as described in the OLE DB documentation. For more information about the `SELECT` syntax supported by SQL Server OLAP Services, see the **Supported SQL SELECT Syntax** topic in OLAP Services Books Online.

To query a local or a remote OLAP server database from SQL Server, you have to install the MSOLAP OLE DB provider on the computer that is running SQL Server. The MSOLAP OLE DB provider is installed when you install the OLAP client components from the SQL Server.

## OPENROWSET and OPENQUERY example

The following Transact-SQL code example demonstrates how to set up and use distributed queries with an OLAP server with the `OPENQUERY` and the `OpenRowset` functions. You must change the data source names and catalog name as appropriate.

```sql
------------------------------------------
--OPENROWSET for OLAP Server
------------------------------------------

SELECT a.*
FROM OpenRowset('MSOLAP','DATASOURCE=myOlapServer; Initial Catalog=FoodMart;',
'SELECT Measures.members ON ROWS,
[Product Category].members ON COLUMNS
FROM [Sales]') as a
go

-- Example of MDX with slicing --

SELECT a.*
FROM OpenRowset('MSOLAP','DATASOURCE=myOlapServer; Initial Catalog=FoodMart;',
'SELECT
 { Time.Year.[1997] } ON COLUMNS,
NON EMPTY Store.MEMBERS ON ROWS
FROM Sales
WHERE ( Product.[Product Category].[Dairy] )') as a

--------------------------------------------------
-- Linked Server Examples with OPENQUERY
--------------------------------------------------

EXEC sp_addlinkedserver
    @server='olap_server',
    @srvproduct='',
    @provider='MSOLAP',
    @datasrc='server',
    @catalog='foodmart'

go

-- MDX in OPENQUERY --

SELECT *
FROM OPENQUERY(olap_server,
'SELECT
{ Time.Year.[1997] } ON COLUMNS,
NON EMPTY Store.MEMBERS ON ROWS
FROM Sales
WHERE ( Product.[Product Category].[Dairy])' )
```

> [!NOTE]
> The **Passing Queries from SQL Server to a Linked OLAP Server** topic, in OLAP Services Books Online, has a documentation bug in the code example:

```sql
SELECT *
FROM OPENQUERY(olap_server, 'SELECT [customer], [quantity] FROM sales')
```

Only a limited form of SQL is supported, and only level or measure names can be specified. When you run the query, you receive this error message:

> Server: Msg 7399, Level 16, State 1, Line 1 OLE DB provider 'MSOLAP' reported an error. [OLE/DB provider returned message`:` Column name 'customer' is invalid. Only level or measure names can be specified.]

One way to fix the query is to use the following:

```sql
SELECT *
FROM OPENQUERY(olap_server, 'SELECT [unit sales] FROM sales')
```

However, passing SQL statements in that form to OLAP Server might be slow, and you may receive a timeout error on some computers:

> OLE DB provider 'MSOLAP' reported an error. [OLE/DB provider returned message: Cannot open database 'foodmart'] [OLE/DB provider returned message: OLAP server error: The operation requested failed due to timeout.]

## Linked server examples with four-part names

The Transact-SQL code example in this section demonstrates the use of a linked server with a four-part name to query an OLAP cube. In the code, the linked server named `Olap_server` was created in the previous example:

```sql
Select [Store:Store Name]
from Olap_server.FoodMart..[sales]
WHERE [Store:Store State]='WA'
go
Select [Product:Product Category], count ([Store:Store Name])
from Olap_server.FoodMart..[sales]
WHERE [Store:Store State]='WA'
GROUP BY [Product:Product Category]
```

Although linked server examples with a four-part name work fine, they may take a long time to return a result to the client. The four-part name syntax is a SQL Server concept; it is used in a Transact-SQL command to refer to a table in a linked server, and it has limited syntax for OLAP queries. SQL Server might determine that it must read the whole fact table from OLAP Server and perform the `GROUP BY` itself, which might take significant resources and time.

Microsoft recommends that you send an MDX statement through an `OPENROWSET` or an `OPENQUERY` function, as shown in the earlier examples. This method lets SQL Server send the command directly to the linked OLAP provider, without trying to parse it. The command can be MDX or the subset of SQL that the OLAP provider supports. You can use the rowset returned from the `OPENQUERY` function in other SQL operators. For basic MDX queries and `GROUP BY` queries that return a relatively small amount of data (like a screenful), the result set must always be created in less than 10 seconds, generally in 5 seconds, irrespective of the size of the cube. If queries take longer, you can build more aggregations by using the usage-based analysis wizard.

### Performance tips

Here are some performance tips:

- SQL Server opens two connections to the OLAP provider for every query. One of those is reused for later queries; therefore, if you run the command again, the second query might run faster.
- To increase speed, group by another dimension (because you are getting less data).
- A worst-case scenario would be when the cube is stored through relational OLAP (ROLAP) and there is no aggregation. Then, the OLAP server opens a connection back to SQL Server to obtain the fact table rows. Do not use a SQL Server distributed query in this case.
- If you just need a result set from an OLAP server or a cube file, try running the SQL Server or the Multidimensional query directly against OLAP server, or any cube file, by using an OLE DB C++ application or an ADO(ADO*MD) application.
- SQL Server installs some OLE DB providers and configures those to load in-process. Because the MSOLAP provider is not installed by SQL Server, it is configured to load out-of-process. Microsoft highly recommends that you change the options for the OLAP provider to load as in-process, because this configuration improves the performance of your OLAP queries. To make the change, follow these steps:

    1. In the Security folder, right-click **Linked Servers**, and then click **New Linked Server**.
    2. For the Provider Name, click to select **OLE DB Provider for OLAP Services**.
    3. Click **Options**.
    4. Click to select **Allow InProcess**.
    5. Click **OK**.

## References

- For a detailed description of the `sp_addlinkedserver` stored procedure parameters, see SQL Server Books Online.

- For more details about setting up and using distributed queries, search on `sp_addlinkedserver` , `OPENQUERY`, `OPENROWSET`, and related topics, in SQL Server Books Online.

- To learn more about OLAP technology and MDX syntax, see OLAP Services Books Online.
