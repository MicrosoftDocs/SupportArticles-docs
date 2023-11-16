---
title: Exception when you execute a query
description: This article provides workarounds for the problem that occurs when you use SQL Server Management Studio (SSMS) to run a SQL query that returns a large amount of data.
ms.date: 10/29/2020
ms.custom: sap:Management Studio
---
# Exception when you execute a query in SQL Server Management Studio

This article helps you resolve the problem that occurs when you use SQL Server Management Studio (SSMS) to run a SQL query that returns a large amount of data.

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2874903

## Symptoms

When you use SSMS to run a SQL query that returns a large amount of data, you receive an error message that resembles the following:

> An error occurred while executing batch. Error message is: Exception of type 'System.OutOfMemoryException' was thrown

## Cause

This issue occurs because SSMS has insufficient memory to allocate for large results.

> [!NOTE]
> SSMS is a 32-bit process. Therefore, it is limited to 2 GB of memory. SSMS imposes an artificial limit on how much text that can be displayed per database field in the results window. This limit is 64 KB in "Grid" mode and 8 KB in Text mode. If the result set is too large, the memory that is required to display the query results may surpass the 2 GB limit of the SSMS process. Therefore, a large result set can cause the error that is mentioned in the [Symptoms](#symptoms) section.

## Workaround

To work around this issue, try one of the following methods.

## Method 1: Output the results as text

Configure the query window to output the query results as text. A text output uses less memory than the grid, and it may be sufficient to display the query results. To make this change, follow these steps:

1. Right-click the query window.
2. Click **Results to**.
3. Click **Results to Text**.

## Method 2: Output the results to a file

Configure the query window to output the query results to a file. A file output uses a minimal amount of memory. This reserves more memory for storing the results set. To make this change, follow these steps:

1. Right-click the query window.
2. Click **Results to**.
3. Click **Results To File**.
4. Run the query, and then select the location in which to save the results file.

## Method 3: Use sqlcmd

Use [sqlcmd Utility](/sql/tools/sqlcmd-utility?redirectedfrom=MSDN&view=sql-server-ver15&preserve-view=true)  instead of SSMS to run the SQL queries. This method enables queries to be run without the resources that are required by the SSMS UI. Additionally, you can use the 64-bit version of Sqlcmd.exe to avoid the memory restriction that affects the 32-bit SSMS process.

## Applies to

- SQL Server 2012 Express
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Express
- SQL Server 2008 Standard
- SQL Server 2008 Web
- SQL Server 2008 Workgroup
- SQL Server 2005 Developer Edition
- SQL Server 2005 Enterprise Edition
- SQL Server 2005 Evaluation Edition
- SQL Server 2005 Express Edition
- SQL Server 2005 Standard Edition
- SQL Server 2005 Workgroup Edition
