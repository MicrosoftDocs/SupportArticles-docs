---
title: 80020009 error when you retrieve data
description: This article provides resolutions for 80020009 error when you retrieve data from SQL Server.
ms.date: 09/25/2020
ms.custom: sap:MDAC and ADO 
---
# 80020009 error when you retrieve data from SQL

This article helps you resolve the 80020009 error when you retrieve data from SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 175239

## Symptoms

The following error occurs when accessing a recordset in an Active Server Pages (ASP) file that contains `Text` or `Blob` type data from a SQL table:

> Microsoft OLE DB Provider for ODBC Drivers error '80020009'

## Cause

The following condition may cause the error to occur:

Text/Blob fields are selected in an order preceding other types of fields.

## Resolution

When dealing with BLOB fields from Microsoft SQL Server, you must put them to the right of non-BLOB columns in the resultset. To be safe, you should also read the columns in left-to-right order, so if you have two BLOB columns as the last two columns in your resultset, read the first one and then the second. Do not read them in the reverse order.

To demonstrate the correct order of field selection create a new ASP page in a Visual InterDev Project and paste the following code in the blank ASP page. Modify the connection string to connect to your SQL Server:

> [!NOTE]
> You must change Username=\<username> and PWD=\<strong password> to the correct values before you run this code. Make sure that User ID has the appropriate permissions to perform this operation on the database.

```vbscript
 <%@ Language=VBScript %>
 <HTML>
     <BODY bgcolor=white>
         <%
             Set cn = Server.CreateObject("ADODB.Connection")
             Set rs = Server.CreateObject("ADODB.Recordset")'Open the connection.
             cn.Open "dsn=yoursystemdsn;Username=<username>;PWD=<strong password>;database=pubs;"
    
            'Open the recordset.

            'Notice that the Blob field, pr_info, is last in the field order.

            rs.Open "select pub_id, pr_info from pub_info", cn

            While Not rs.EOF

            Response.Write "<P>PR Info:<P>" & rs("pr_info")
             Response.Write "<P>That was the PR Info for PubID " & 
             rs("pub_id")
             rs.MoveNext
             Wend
         %>
     </BODY>
 </HTML>
```

## Status

This behavior is by design. However, it does not occur when using Mdac 2.1 sp2 or later with the 3.7 driver or later for SQL Server.

## More information

SQL Server is sending back the data on the wire and the client is essentially receiving a stream of bits read sequentially on the network wire. With bound columns (that is, the values can be copied into local memory buffers and cached there), the driver transfers data in those columns to memory buffers. Once the data is in local buffers, you may read the data in any order. Therefore, you can read result columns in any order when all the columns are bound (not BLOBs).

When you include BLOB columns, the length of the column can be approximately 2 gigabytes and data access libraries typically do not bind those columns since the driver often cannot determine exactly how large the BLOB is until retrieved. Also, data access libraries typically avoid caching BLOB data since this may consume large amounts of memory and caching it both in the data access library and your application is inefficient. If the data access driver is requested to return the contents of a BLOB column, it typically discards non-bound columns that precede the requested BLOB column, since it must retrieve the sequential data stream before it can read the requested column. Therefore, it is more efficient to read your resultset from left-to-right since that matches the way the data is retrieved.

> [!NOTE]
> This describes the behavior of SQL Server. Oracle and other client/server DBMSs may do the same thing, but it is not required.

Perhaps a better alternative is to avoid using a Text column. Because SQL Server allocates space in 2K chunks, using Text columns may result in inefficient use of storage if the text length is small. Backup time is also affected because it takes longer to dump the transaction log. It is often better to create another table that has the PK of your existing table, a chunk number column, and a `varchar (255)` column. Divide the text into as many 255 character chunks needed and insert as many rows in the new table as there are chunks. It is usually worth the additional coding time since you make more efficient use of storage and Backups go much faster.
