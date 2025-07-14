---
title: Optimize Access when using ODBC data sources
description: Describes some tips for improving performance when you access data from an ODBC data source in Access 2002, in Access 2003, and in Access 2007.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: chriswy
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# How to optimize Microsoft Access when using ODBC data sources

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies only to a Microsoft Access database (.mdb or .accdb).

## Summary

This article describes several tips for improving performance when you access data from an ODBC data source. 

## More information

Use the following tips to improve performance with ODBC data sources: 

- Restrict the amount of data that you request from the server. Do not ask for more data than you need. Use queries to select only the fields and rows that you need.    
- Use only the functionality that you need. Snapshots are less powerful than dynasets, and they are not updateable. However, snapshots may be faster, particularly for small recordsets without Memo or OLE Object fields.    
- Create linked (attached) tables to access server data. Avoid "direct" server access (that is, do not open remote databases and run queries against them). Instead, create attached tables or create pass-through queries.    
- Design list boxes and combo boxes wisely. On a form, each list box, combo box, subform, and control that contains a total requires a separate query. Against local data, performance may be adequate. Against remote data, however, long delays may occur when you open a form because each query must be sent to the server and a response must be returned before the form can be opened.    
- Avoid large combo boxes. Including a combo box with hundreds, or even thousands, of choices based on a local table may yield an acceptable response time, especially if you define an appropriate index on the local table. Against a remote table, however, such a combo box yields sluggish performance because it drains server and network resources as it fetches data to fill the list. It is best to limit the number of rows returned to the combo box when you are working with remote data. You can also break up the data into smaller combo boxes (bearing in mind the tip above).    
- Use the Find command only on smaller recordsets. The Microsoft Jet database engine optimizes the Find command to work well against local recordsets of almost any size and against remote recordsets of reasonable size. However, when you have large remote recordsets (thousands of records or more), you should instead create a filter or query and also be careful to use restrictions that your server can process.    
- Make sure queries are sent to the server for processing. The most important factor in query performance against remote data is ensuring that your server runs as much of the query as possible. The Microsoft Jet database engine attempts to send the entire query to your server, but evaluates locally any query clauses and expressions that are not generally supported by servers or by your particular server. Functionality not supported by servers in general includes the following: 

- Operations that cannot be expressed in a single SQL statement. This situation can occur when you use a query as an input to another query, or when your query's FROM clause contains a Totals query or DISTINCT query. Often, you can rearrange your queries to calculate totals after all other operations.   
   - Operations that are Microsoft Jet database engine-specific extensions to SQL, such as crosstab queries, TOP queries, and reports with multiple levels of grouping and totals. Note that simple crosstab queries can be sent to servers.   
   - Expressions that contain Microsoft Access-specific operators or functions. The Microsoft Access financial functions and statistical aggregates have no server equivalents.   
   - User-defined Visual Basic for Application functions that take remote columns as arguments. These functions do not exist on the server, but must process remote column data. However, if a user-defined function returns a single value and does not reference a remote column, the function is evaluated locally, and its value is sent to the server for processing.   
   - Mixing text and numeric data types in operators or UNION query outputs. Most servers lack the data-type leniency of Microsoft Access. Because of this, use explicit conversion functions where appropriate.   
   - Heterogeneous joins between local tables and remote tables, or between remote tables in different ODBC data sources. Joins between small local tables and large remote tables, where the join column is indexed, may result in a remote index join. In a remote index join, one query for each row in the local table is sent to the server, and only the joining rows are returned.   
   - Non-remoteable expressions, or expressions that cannot be sent remotely, because they cannot be evaluated by your server. Non-remoteable output expressions (those in the SELECT clause) do not force local evaluation of your query unless they occur in a Totals query, a DISTINCT query, or a UNION query. Non-remoteable expressions in other clauses (WHERE, ORDER BY, GROUP BY, HAVING, and so on) force at least part of your query to be evaluated locally.   
   
- Servers differ in some areas of supported functionality. When you attach a remote table, the Microsoft Jet database engine queries the ODBC driver for its capabilities. If the required functionality is supported by the driver and the server, the Microsoft Jet database engine sends the operation to the server for processing. If not, the Microsoft Jet database engine performs the operation locally. Areas of differing support include (but are not limited to) the following: 

   - Outer joins. Note that the Microsoft Jet database engine does not send multiple outer joins to a server, although many inner joins may accompany a single outer join.   
   - Numeric, string, and date/time functions -- such as Log(), Mid$(), DatePart(), and so on.   
   - Conversion functions -- such as CInt(), CStr(), CVDate(), and so on.   
   
