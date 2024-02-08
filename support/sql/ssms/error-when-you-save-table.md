---
title: Saving changes is not permitted error message
description:  This article provides workarounds for the problem in which you receive an error message when you try to save a table in SQL Server Management Studio.
ms.date: 09/25/2020
ms.custom: sap:Management Studio
---
# Saving changes is not permitted error message in SSMS

This article helps you work around the problem in which you receive an error message when you try to save a table in SQL Server Management Studio (SSMS).

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956176

## Symptoms

When you try to save a table after making changes to the table using Designer in SQL Server management Studio, you may receive the following error message:

> Saving changes is not permitted. The changes that you have made require the following tables to be dropped and re-created. You have either made changes to a table that can't be re-created or enabled the option Prevent saving changes that require the table to be re-created.

This problem occurs when you make one or more of the following changes to the table:

- You change the Allow Nulls setting for a column.
- You reorder columns in the table.
- You change the column data type.
- You add a new column.
- You change the `filegroup` of a table or its `text/image` data.

## Cause

This problem occurs because the **Prevent saving changes that require the table re-creation**  option is enabled by default in SQL Server Management Studio.

When you change a table so that you alter the metadata structure of the table, and then you save the table, the table must be re-created based on these changes. This may result in the loss of metadata and in a direct loss of data during the re-creation of the table. If you enable the **Prevent saving changes that require the table re-creation** option in the **Designer** section of the **SQL Server Management Studio (SSMS) Options** window, you receive the error message that is mentioned in the 'Symptoms' section.

## Workaround

To work around this problem, use `ALTER TABLE` Transact-SQL statements to make the changes to the metadata structure of a table.

For example, to change *MyDate* column of type datetime in at table called *MyTable* to accept NULL values you can use:

```sql
alter table MyTable alter column MyDate7 datetime NULL
```

> [!IMPORTANT]
> We strongly recommend that you do not work around this problem by turning off the Prevent saving changes that require table re-creation option. For more information about the risks of turning off this option, see the 'More information' section.

## More information

To change the **Prevent saving changes that require the table re-creation** option, follow these steps:

1. Open SQL Server Management Studio.

2. On the **Tools** menu, click **Options**.

3. In the navigation pane of the **Options** window, click **Designers**.

4. Select or clear the **Prevent saving changes that require the table re-creation** check box, and then click **OK**.

> [!NOTE]
> If you disable this option, you are not warned when you save the table that the changes that you made have changed the metadata structure of the table. In this case, data loss may occur when you save the table.

### Risk of turning off the "Prevent saving changes that require table re-creation" option

Although turning off this option can help you avoid re-creating a table, it can also lead to changes being lost. For example, suppose that you enable the Change Tracking feature in SQL Server to track changes to the table. When you perform an operation that causes the table to be re-created, you receive the error message that is mentioned in the [Symptoms](#symptoms) section. However, if you turn off this option, the existing change tracking information is deleted when the table is re-created. Therefore, we recommend that you do not work around this problem by turning off the option.

To determine whether the Change Tracking feature is enabled for a table, follow these steps:

1. In SQL Server Management Studio, locate the table in Object Explorer.
2. Right-click the table, and then click Properties.
3. In the Table Properties dialog box, click Change Tracking. If the value of the Change Tracking item is True, this option is enabled for the table. If the value is False, this option is disabled.

When the `Change Tracking` feature is enabled, use Transact-SQL statements to change the metadata structure of the table.

### Steps to reproduce the problem

1. In SQL Server Management Studio, create a table that contains a primary key in the Table Designer tool.
2. Right-click the database that contains this table, and then click **Properties**.
3. In the **Database Properties** dialog box, click **Change Tracking**.
4. Set the value of the **Change Tracking** item to **True**, and then click **OK**.
5. Right-click the table, and then click **Properties**.
6. In the **Table Properties** dialog box, click **Change Tracking**.
7. Set the value of the **Change Tracking** item to **True**, and then click **OK**.
8. On the **Tools** menu, click **Options**.
9. In the **Options** dialog box, click **Designers**.
10. Click to select the **Prevent saving changes that require table re-creation** check box, and then click **OK.**  
11. In the Table Designer tool, change the **Allow Nulls** setting on an existing column.
12. Try to save the change to the table.
