---
title: Error when you modify large table
description: This article provides resolutions for the problem that occurs when you try to modify a large table by using the table designer in SQL Server Management Studio.
ms.date: 11/19/2020
ms.custom: sap:Management Studio
---
# Error when you try to modify a large table by using SQL Server Management Studio

This article helps you resolve the problem that occurs when you try to modify a large table by using the table designer in SQL Server Management Studio.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 915849

## Symptoms

When you try to modify a large table by using the table designer in Microsoft SQL Server Management Studio, you may receive an error message that is similar to the following:

> Unable to modify table.  
Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.

## Cause

This behavior occurs because of the transaction time-out setting for the table designer and for the database designer in SQL Server Management Studio. You can specify this setting in the **Transaction time-out after** box. By default, this setting is 30 seconds.

> [!NOTE]
> This setting differs from the setting in the **Execution time-out** box in SQL Server Management Studio. By default, the setting in the **Execution time-out** box for Query Editor in SQL Server Management Studio is **zero**. By default, the setting in the **Query time-out (seconds)** box for Query Editor in SQL Server 2000 SQL Query Analyzer is also **zero**. Therefore, Query Editor waits infinitely for the query to finish and never times out.

## Resolution

To resolve this behavior, use one of the following methods:

- Click to clear the **Override connection string time-out value for table designer updates** check box for the table designer and for the database designer in SQL Server Management Studio.

- Specify a high setting in the **Transaction time-out after** box for the table designer and for the database designer in SQL Server Management Studio.

- Modify the large table by using Transact-SQL statements in Query Editor in SQL Server Management Studio.

For more information about these settings, see [Options (Designers - Table and Database Designers Page)](/sql/ssms/menu-help/options-designers-table-and-database-designers-page).

## Status

This behavior is by design.

## More Information

The modification of a large table may be time-consuming. This is because SQL Server must perform the following actions when you try to modify the table schema:

1. Create a temporary table with the same table schema.
2. Copy all the data from the actual table to the temporary table.
3. Drop the actual table.
4. Rename the temporary table to the name of the actual table.
