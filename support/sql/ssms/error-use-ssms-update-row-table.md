---
title: Error when you update a row of a table
description: This article provides a workaround for the problem that occurs when you try to update a table by using SQL Server Management Studio in SQL Server.
ms.date: 11/19/2020
ms.custom: sap:Management Studio
---
# You may receive an error message when you try to use SQL Server Management Studio to update a row of a table in SQL Server

This article helps you resolve the problem that occurs when you try to update a table by using SQL Server Management Studio in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 925719

## Symptoms

Consider the following scenario. You try to use SQL Server Management Studio to update a table in Microsoft SQL Server. In Object Explorer, you right-click the name of the table, and then you click **Open Table**. You update a row of the table. In this scenario, you may receive one of the following error messages unexpectedly in the **Microsoft SQL Server Management Studio** dialog box:

- Error message 1

    > Data has changed since the Results pane was last retrieved. Do you want to save your changes now?
    >
    > (Optimistic Concurrency Control Error)
    >
    > Click Yes to commit your changes to database anyway.
    >
    > Click No to discard your change and retrieve the current data for this row.
    >
    > Click Cancel to continue editing.

    > [!NOTE]
    > If you click **Yes** in this error message dialog box, the row is updated correctly.

- Error message 2

    > No row was updated.
    >
    > The data in row **X** was not committed.
    >
    > Error Source: Microsoft.VisualStudio.DataTools.
    >
    > Error Message: The row value(s) updated or deleted either do not make the row unique or they alter multiple rows(**N** rows).
    >
    > Correct the errors and retry or press ESC to cancel the change(s).

    > [!NOTE]
    > If you receive this message dialog box, you cannot update the row.

This issue occurs if the following conditions are true:

- The table contains one or more columns of the text or ntext data type.
- The value of one of these columns contains the following characters:

  - Percent sign (%)
  - Underscore (_)
  - Left bracket ([)

- The table does not contain a primary key.

> [!NOTE]
> This issue also occurs when you try to use Table Designer in Microsoft Visual Studio to update a table that is in a SQL Server database.

## Cause

This issue occurs because SQL Server Management Studio generates an incorrect SQL statement for the update operation. When the table does not contain a primary key, the values of all columns are used to identify the row to update. When SQL Server Management Studio constructs this statement, the incorrect comparison operator (=) is used to compare columns of the text, ntext, or image data types.

## Workaround

To work around this issue, create a new query window in SQL Server Management Studio. Then, run a SQL `UPDATE` statement to update the row in the table.

> [!NOTE]
> If you receive the first error message that is mentioned in the [Symptoms](#symptoms) section, you can click **Yes** to update the row.

## References

[UPDATE (Transact-SQL)](/sql/t-sql/queries/update-transact-sql)
