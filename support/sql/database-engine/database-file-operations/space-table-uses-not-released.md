---
title: Space used by a table isn't released
description: This article provides workaround for the problem that a table uses can't be released after you use a DELETE statement to delete all data from the table.
ms.date: 11/04/2022
ms.custom: sap:File, Filegroup, Database Operations or Corruption
ms.reviewer: georgel, haiwxu, willchen
---
# Space that a table uses isn't completely released after you use a DELETE statement to delete data from the table in SQL Server

This article helps you work around the problem that a table uses can't be released after you use a DELETE statement to delete all data from the table.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 913399

## Symptoms

After you use a DELETE statement in Microsoft SQL Server to delete data from a table, you may notice that the space that the table uses isn't completely released. When you then try to insert data in the database, you may receive the following error message:

> Could not allocate space for object '**TableName**' in database '**DatabaseName**' because the 'PRIMARY' filegroup is full.

> [!NOTE]
> **TableName** represents the name of the table. **DatabaseName** represents the name of the database that contains the table.

## Cause

This problem occurs because SQL Server only releases all the pages that a heap table uses when the following conditions are true:

- A deletion on this table occurs.
- A table-level lock is being held.

> [!NOTE]
> A heap table is any table that is not associated with a clustered index.

If pages aren't deallocated, other objects in the database can't reuse the pages.

However, when you enable a row `versioning-based` isolation level in a SQL Server database, pages can't be released even if a table-level lock is being held. For more information about row `versioning-based` isolation levels, see [Isolation levels in the SQL Server Database Engine](/sql/relational-databases/sql-server-transaction-locking-and-row-versioning-guide#isolation-levels-in-the-).

## Workaround

To work around this problem, use one of the following methods:

- Include a TABLOCK hint in the DELETE statement if a row versioning-based isolation level isn't enabled. For example, use a statement that is similar to the following:

    ```sql
    DELETE FROM <TableName> WITH (TABLOCK)
    ```

    > [!NOTE]
    > **\<TableName>** represents the name of the table.

- Use the TRUNCATE TABLE statement if you want to delete all the records in the table. For example, use a statement that is similar to the following:

    ```sql
    TRUNCATE TABLE <TableName>
    ```

- Create a clustered index on a column of the table. For more information about how to create a clustered index on a table, see [Create Clustered Indexes](/sql/relational-databases/indexes/create-clustered-indexes).
