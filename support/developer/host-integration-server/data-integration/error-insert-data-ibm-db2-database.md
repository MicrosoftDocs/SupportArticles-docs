---
title: Error when you insert data into IBM DB2 database
description: The following error occurs when using SQL Server Integration Services and the Microsoft OLE DB Provider for DB2 to insert NULL TimeStamp or Date values into IBM DB2 database when using FastLoad.
ms.date: 05/07/2024
ms.custom: sap:Data Integration (DB2, Host Files)
ms.reviewer: jeremyr
---
# Error message when using SQL Server Integration Services to insert data into IBM DB2 database

_Original product version:_ &nbsp; Host Integration Server  
_Original KB number:_ &nbsp; 2848234

## Symptoms

Consider the following scenario:

- You use SQL Server Integration Services (SSIS) and the OLE DB Provider for DB2 to insert data into an IBM DB2 database.

- The OLE DB Destination in the SSIS package is configured with `Accessmode = OpenRowset Using FastLoad`.

- The source SQL Server database includes some NULL values for columns defined as DateTime2 and Date data types that will be inserted into IBM DB2 columns defined as TimeStamp and Date data types, respectively.

During the SSIS process of inserting data into the IBM DB2 database, an error similar to the following error may occur:

> Error: SSIS Error Code DTS_E_OLEDBERROR. An OLE DB error has occurred. Error code: 0x80004005. An OLE DB record is available. Source: "Microsoft DB2 OLE DB Provider" Hresult: 0x80004005 Description: "Unspecified error".
>
> An OLE DB record is available. Source: "Microsoft DB2 OLE DB Provider" Hresult: 0x80040E14 Description: "The syntax of the string representation of a datetime value is incorrect. SQLSTATE: 22007, SQLCODE: -180".

## Resolution

There are two ways to resolve the problem.

- Change the OLE DB Destination in the SSIS package to use `AccessMode = OpenRowset` to disable the use of `FastLoad`. The disadvantage of this option is that the performance of the inserts into the DB2 database will be much slower as each row is inserted one at a time.

- Add the following parameter to the DB2 connection string used by SSIS to connect to the IBM DB2 system:

   `Use Early Metadata=true`
