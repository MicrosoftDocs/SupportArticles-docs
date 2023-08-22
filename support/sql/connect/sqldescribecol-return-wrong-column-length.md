---
title: SQLDescribeCol returns the wrong column length
description: This article provides resolutions for the problem that the SQLDescribeCol command returns the wrong column length and data type in a complex union query that has parameters.
ms.date: 09/25/2020
ms.custom: sap:MDAC and ADO
ms.reviewer: sunilbs, ramakoni
---
# SQLDescribeCol returns the wrong column length and data type in a complex union query that has parameters

This article helps you resolve the problem that the `SQLDescribeCol` command returns the wrong column length and data type in a complex union query that has parameters.

_Original product version:_ &nbsp; SQL Server 2008, Microsoft SQL Server 2005  
_Original KB number:_ &nbsp; 2900760

## Summary

Consider the following scenario:

- You use a version of Microsoft SQL Server Native Client that is earlier than Microsoft SQL Server Native Client 11.0.
- Your code makes a call to the `SQLDescribeCol` function for a complex union query that contains parameters and a WHERE clause.

In this scenario, `SQLDescribeCol` returns an incorrect column length and data type.

## Cause

This problem occurs because the driver truncates the query for the metadata on the UNION keyword. Therefore, SQL Server requests metadata for only the first query and ignores the second query. If you change the order of the queries, `SQLDescribeCol` returns correct data.

## Resolution

To resolve this problem, use SQL Server Native Client 11.0 or a later version in your application. To obtain SQL Server Native Client 11.0, or for more information, see [Microsoft SQL Server 2012 SP4 Feature Pack](https://www.microsoft.com/download/details.aspx?id=56041).

## Workaround

To work around this problem, take either of the following actions:

- Compile the query into a stored procedure that uses parameters.
- Reverse the order of the `SELECT` statements in the union query so that the constant field is in the last `SELECT` statement.

## Status

Microsoft has confirmed this is a known problem in earlier versions of SQL Server and SQL Server Native Client.

Microsoft has confirmed that this is a bug in the Microsoft products that are listed at the beginning of this article.

## Applies to

- v R2 Enterprise
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Standard
- SQL Server 2008 Enterprise
- SQL Server 2008 Standard
- Microsoft SQL Server 2005 Enterprise Edition
- Microsoft SQL Server 2005 Standard Edition
