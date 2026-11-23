---
title: Saving Changes is not Permitted Error Message in SSMS
description: Learn how to work around the "Saving changes is not permitted" error when you save a table in SQL Server Management Studio (SSMS) by using T-SQL statements.
ms.date: 10/21/2026
ms.custom: sap:SQL Server Management, Query and Data Tools
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Saving changes is not permitted error message in SSMS

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956176

## Summary

This article helps you work around the "Saving changes is not permitted" error message that SQL Server Management Studio (SSMS) shows when you save changes in Table Designer. The error occurs when a change requires SSMS to drop and re-create the table, and the **Prevent saving changes that require table re-creation** option is enabled. To avoid this error and the table re-creation that causes it, use `ALTER TABLE` Transact-SQL (T-SQL) statements instead of Table Designer. This article also explains how to change the option and why turning it off can be risky, especially for tables that use Change Tracking.

## Symptoms: Error when you save table changes in Table Designer

When you try to save a table after making changes to the table by using [Table Designer](/ssms/visual-db-tools/design-tables-visual-database-tools) in SQL Server Management Studio, you might receive the following error message:

> Saving changes is not permitted. The changes that you have made require the following tables to be dropped and re-created. You have either made changes to a table that can't be re-created or enabled the option Prevent saving changes that require the table to be re-created.

This problem occurs when you make one or more of the following changes to the table:

- You change the **Allow Nulls** setting for a column.
- You reorder columns in the table.
- You change the column data type.
- You add a new column.
- You change the `filegroup` of a table or its `text/image` data.

## Cause: SSMS prevents changes that require re-creating the table

This problem occurs because the **Prevent saving changes that require table re-creation** option is enabled by default in SSMS.

When you change a table in a way that alters its metadata structure and then save the table, SSMS must re-create the table based on these changes. Re-creating a table might result in the loss of metadata and in a direct loss of data.

If the **Prevent saving changes that require table re-creation** option is enabled in the **Designers** section of the SSMS **Options** window, SSMS blocks the save and you receive the error message that's mentioned in the [Symptoms](#symptoms-error-when-you-save-table-changes-in-table-designer) section. For more information about this option, see [Options (Designers - Table and Database Designers page)](/ssms/menu-help/options-designers-table-and-database-designers-page).

## Workaround: Use ALTER TABLE instead of Table Designer

To work around this problem, use [ALTER TABLE](/sql/t-sql/statements/alter-table-transact-sql) T-SQL statements to make the changes to the metadata structure of a table. To run the statements, follow these steps:

1. In SQL Server Management Studio, connect to the instance, and then select the database that contains the table.
1. On the toolbar, select **New Query**.
1. Enter the T-SQL statement in the query window, and then select **Execute**.

You need the `ALTER` permission on the table to run `ALTER TABLE` statements.

For example, to change the *MyDate* column of type `datetime` in a table called *MyTable* to accept NULL values, use the following statement:

```sql
ALTER TABLE MyTable ALTER COLUMN MyDate datetime NULL;
```

To add a new column named *MyNewColumn* of type `int` that accepts NULL values to the same table, use the following statement:

```sql
ALTER TABLE MyTable ADD MyNewColumn int NULL;
```

> [!IMPORTANT]
> We strongly recommend that you don't work around this problem by turning off the **Prevent saving changes that require table re-creation** option. For more information about the risks of turning off this option, see [Risk of turning off the "Prevent saving changes that require table re-creation" option](#risk-of-turning-off-the-prevent-saving-changes-that-require-table-re-creation-option).

## How to change the "Prevent saving changes that require table re-creation" option

To select or clear the **Prevent saving changes that require table re-creation** option, follow these steps:

1. Open SQL Server Management Studio.
1. On the **Tools** menu, select **Options**.
1. In the navigation pane of the **Options** window, select **Designers**.
1. Select or clear the **Prevent saving changes that require table re-creation** check box, and then select **OK**.

> [!NOTE]
> If you disable this option, you aren't warned when you save the table that the changes you made have changed the metadata structure of the table. In this case, data loss might occur when you save the table.

## Risk of turning off the "Prevent saving changes that require table re-creation" option

Although turning off this option can help you avoid the error, it can also cause changes to be lost. When the **Prevent saving changes that require table re-creation** option is enabled, SSMS shows the error for every change that requires the table to be re-created, because re-creating a table can result in the loss of metadata or data in general. Change Tracking is one example of the metadata that can be lost.

For example, suppose that you enable the [Change Tracking](/sql/relational-databases/track-changes/about-change-tracking-sql-server) feature in SQL Server to track changes to the table. When you perform an operation that causes the table to be re-created, you receive the error message that's mentioned in the [Symptoms](#symptoms-error-when-you-save-table-changes-in-table-designer) section. However, if you turn off this option, the existing change tracking information is deleted when the table is re-created. Therefore, we recommend that you don't work around this problem by turning off the option.

## How to check whether Change Tracking is enabled for a table

To determine whether the Change Tracking feature is enabled for a table, follow these steps:

1. In SQL Server Management Studio, locate the table in Object Explorer.
1. Right-click the table, and then select **Properties**.
1. In the **Table Properties** dialog box, select **Change Tracking**. If the value of the **Change Tracking** item is **True**, Change Tracking is enabled for the table. If the value is **False**, it's disabled.

When the Change Tracking feature is enabled, use T-SQL statements to change the metadata structure of the table. For more information about enabling and disabling Change Tracking, see [Enable and disable Change Tracking](/sql/relational-databases/track-changes/enable-and-disable-change-tracking-sql-server).

## Steps to reproduce the problem

To reproduce the error, follow these steps:

1. In SQL Server Management Studio, create a table that contains a primary key in the Table Designer tool.
1. Right-click the database that contains this table, and then select **Properties**.
1. In the **Database Properties** dialog box, select **Change Tracking**.
1. Set the value of the **Change Tracking** item to **True**, and then select **OK**.
1. Right-click the table, and then select **Properties**.
1. In the **Table Properties** dialog box, select **Change Tracking**.
1. Set the value of the **Change Tracking** item to **True**, and then select **OK**.
1. On the **Tools** menu, select **Options**.
1. In the **Options** dialog box, select **Designers**.
1. Select the **Prevent saving changes that require table re-creation** check box, and then select **OK**.
1. In the Table Designer tool, change the **Allow Nulls** setting on an existing column.
1. Try to save the change to the table.

## Related content

- [Visual database tool designers](/ssms/visual-db-tools/visual-database-tool-designers)
- [Error when you try to modify a large table by using SQL Server Management Studio](error-modify-large-table-using-ssms.md)
