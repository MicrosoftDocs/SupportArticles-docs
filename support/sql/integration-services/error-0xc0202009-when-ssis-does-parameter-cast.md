---
title: Error 0xC0202009 occurs when SSIS converts parameter
description: This article provides resolutions for the error 0xC0202009 that occurs when SSIS does a parameter cast in SQL Server.
ms.date: 09/02/2020
ms.custom: sap:Integration Services
ms.reviewer: ramakoni, daleche
---
# Error 0xC0202009 occurs when SSIS does a parameter cast in SQL Server

This article helps you resolve the error 0xC0202009 that occurs when Microsoft SQL Server Integration Services (SSIS) does a parameter cast in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3001293

## Symptoms

When you run an SSIS package, the execution fails because of a parameter cast error, and you receive the following error message:

> Code: 0xC0202009  
Source: Data Flow Task  
Description: SSIS Error Code DTS_E_OLEDBERROR. An OLE DB error has occurred. Error code: 0x80040E21.  
An OLE DB record is available. Source: "Microsoft SQL Server Native Client 11.0"  
Hresult: 0x80040E21 Description: "Invalid character value for cast specification".

For an OLE DB Source component, when you have a data flow task that contains a parameterized query, you may experience this issue. For example, you have the following query:

```sql
SELECT mydate
FROM dbo.myTable
WHERE mydate >= convert (char, dateadd(year,-1,cast( ? as datetime)))
```

> [!NOTE]
> This issue only occurs if you try to use an OLE DB Source component together with parameters in the query string. A parameter marker `?` is mapped to an SSIS user variable parameter1 that is defined as SSIS String `20080122`.

## Cause

The issue occurs because of the behavior change in how OLE DB handles parameters. In Microsoft SQL Server 2012, the new stored procedure of `sp_describe_undeclared_parameters` , replacement of set `fmtonly` returns a different result for the parameter type. This change is by design.

In the example query in the [Symptoms](#symptoms) section, the original behavior is to describe `?` to be `char(8)`. However, the new sp_describe_undeclared_parameters says that `?` should be `datetime`. Therefore, the internal cast from string to `datetime` that is handled by OLE DB provider returns the error message.

## Resolution

To resolve this problem, rewrite the query to add an additional explicit cast to the original data type. Then, `sp_describe_undeclared_parameters` returns the correct, expected type. To resolve this issue in the example query that is described in the [Symptoms](#symptoms) section, update the query as follows:

```sql
SELECT mydate
FROM dbo.myTable
WHERE mydate >= convert(char ,dateadd(year,-1, cast( cast( ? as char(8)) as datetime)))
```
