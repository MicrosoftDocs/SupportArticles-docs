---
title: Reset AutoNumber value in Access
description: Provides step-by-step methods to reset an AutoNumber field value in Access. This includes reseting an AutoNumber field in a single table or in a table with referenced tables.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 114797
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Access for Microsoft 365
  - Access 2019
  - Access 2016
  - Access 2013
  - Access 2010
  - Microsoft Office Access 2007
  - Microsoft Office Access 2003
search.appverid: MET150
ms.date: 06/06/2024
---
# How to reset an AutoNumber field value in Access

_Original KB number:_ &nbsp; 812718

## Summary

This step-by-step article describes how to reset an **AutoNumber** field value in Access. The **AutoNumber** field value in Access does not automatically reset when you delete some rows or all rows in a table. To reset the **AutoNumber** field value and to refresh the **AutoNumber** value in the referenced table, you must manually perform some tasks.

> [!NOTE]
> You must back up your database before you perform the steps that follow.

## Reset an AutoNumber field in a single table

If your table has no relationships to other tables, use either Method 1 or Method 2 to reset an AutoNumber field value.

### Method 1: Move the data to a new table using a Make-Table query

You can reset an AutoNumber field value by using a Make-Table query to create a new table that has the same data and then adding a new AutoNumber field.

Access 2003 and earlier versions

To do this in Access 2003 or in an earlier version, follow these steps:

1. Delete the **AutoNumber** field from the main table, and note the **AutoNumber** field name.
2. Click **Queries** on the left pane, and then double-click **Create query in Design view** on right pane.
3. In the **Show Table** dialog box, select the main table, click **Add**, and then click **Close**.
4. Double-click the required fields in the table view of the main table to select the fields.
5. Select the required **Sort** order.
6. On the **Query** menu, click **Make-Table Query**, type the new table name in the **Table Name** text box, and then click **OK**.
7. On the **Query** menu, click **Run**.
8. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
9. On the **File** menu, click **Close**, and then click **No** to close the **Make-Table Query** window.
10. Click **Tables** on the left pane, right-click the new table, and then click **Design View**.
11. In the **Design** view for the table, add an **AutoNumber** field that has the same field name that you deleted in step 1, add this **AutoNumber** field to the new table, and then save the table.
12. Close the **Design** view window.
13. Rename the main table, and then rename the new table to match the main table name.

Access 2007 and later versions

To do this in Microsoft Office Access 2007 or in a later version, follow these steps:

1. Delete the **AutoNumber** field from the main table, and note the **AutoNumber** field name.
2. Click the **Create** tab, and then click **Query Design** in the **Other** group.
3. In the **Show Table** dialog box, select the main table. Click **Add**, and then click **Close**.
4. Double-click the required fields in the table view of the main table to select the fields.
5. Select the required **Sort** order.
6. On the **Design** tab, click **Make Table** in the **Query Type** group.
7. Type the new table name in the **Table Name** box, and then click **OK**.
8. On the **Design** tab, click **Run** in the **Results** group.
9. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
10. Close the query.
11. Right-click the new table, and then click **Design View**.
12. In the Design view for the table, add an **AutoNumber** field that has the same field name that you deleted in step 1. Add this **AutoNumber** field to the new table, and then save the table.
13. Close the Design view window.
14. Rename the main table, and then rename the new table to match the main table name.

### Method 2: Create a new table and move the data to it using an append query

You can copy the structure of your existing table as a new table. You can then append the data into the new table and add a new AutoNumber field.

Access 2003 and earlier versions

To do this in Microsoft Office Access 2003 and in earlier versions, follow these steps:

1. Delete the **AutoNumber** field from the main table.

   Make note of the **AutoNumber** field name.
2. Copy the structure of the main table and then create a new table.
3. Click **Queries** on the left pane. Click **Create query in Design view** on right pane.
4. In the **Show Table** dialog box, select the main table. Click **Add** and then click **Close**.
5. To select the fields, double-click the required fields. Do this for all the fields except for the **AutoNumber** field in the **Table** view of the main table.
6. On the **Query** menu, click **Append Query**.
   > [!NOTE]
   > This changes the query type.
7. From the **Table Name** list, select the new table that you created in step 2. Click **OK**.
8. On the **Query** menu, click **Run**.
9. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
10. On the **File** menu, click **Close**. Click **No** to close the **AppendQuery** window.
11. Click **Tables** on the left pane. Right-click the new table and then click **Design View**.
12. In the **Design** view for the table, add an **AutoNumber** field with the same field name that you deleted in step 1. Add this **AutoNumber** field to the new table, and then save the table.
13. Close the **Design** view window.
14. Rename the main table, and then rename the new table to match the main table name.

Access 2007 and later versions

To do this in Microsoft Office Access 2007 or in a later version, follow these steps:

1. Delete the **AutoNumber** field from the main table.

   Make note of the **AutoNumber** field name.
2. Copy the structure of the main table, and then create a new table.
3. Click the **Create** tab, and then click **Query Design** in the **Other** group.
4. In the **Show Table** dialog box, select the main table. Click **Add**, and then click **Close**.
5. To select the fields, double-click the required fields. Do this for all the fields except for the **AutoNumber** field in the Table view of the main table.
6. On the **Design** tab, click **Append** in the **Query Type** group.
   > [!NOTE]
   > This changes the query type.
7. I the **Table Name** list, select the new table that you created in step 2, and then click **OK**.
8. On the **Design** tab, click **Run** in the **Results** group.
9. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
10. Close the query.
11. Right-click the new table, and then click **Design View**.
12. In the Design view for the table, add an **AutoNumber** field that has the same field name that you deleted in step 1. Add this **AutoNumber** field to the new table, and then save the table.
13. Close the Design view window.
14. Rename the main table, and then rename the new table to match the main table name.

## Reset an AutoNumber field in a table with referenced tables

A table with referenced tables has a relationship with one or more tables. The steps that follow describe how to reset the **AutoNumber** field for a table that has one referenced table. If you have more than one referenced table, you must follow these steps for each referenced table.

1. Remove the relationship between the tables.
2. Set the **AutoNumber** field of the main table to a Number data type, and then remove the primary key.
3. Create a new field of **AutoNumber** data type in the main table, and then save the table.
4. Create a new field of Number data type in the referenced table, and then save the table.
5. To create an update query that updates the new field in the referenced table to the new **AutoNumber** field of the main table, follow these steps.

   Access 2003 and earlier versions

   1. Click **Queries** in the left pane, and then click **Create query in Design view** in right pane.
      > [!NOTE]
      > This creates your new query.
   2. In the **Show Table** dialog box, select the main table and the referenced table, click **Add** to add the main table and the referenced table, and then click **Close**.
   3. Click the field in the main table that was previously linked to the referenced table, and then drag the field to the previously linked field of the referenced table.
      > [!NOTE]
      > This creates the join between the tables that is based on the original linking fields.
   4. On the **Query** menu, click **Update Query**.
   5. Double-click the new field from the referenced table to add it to the field list.
   6. In the **Update To** field, type *[Main TableName].[New AutoNumber field]* to update the new field values in the referenced table.
   7. On the **Query** menu, click **Run**.
   8. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
   9. On the **File** menu, click **Close**, and then click **No** to close the **Update Query** window.

   Access 2007 and later versions

   1. Click the **Create** tab, and then click **Query Design** in the **Other** group. This creates the new query.
   2. In the **Show Table** dialog box, select the main table and the referenced table. Click **Add** to add the main table and the referenced table. Click **Close**.
   3. Click the field in the main table that was previously linked to the referenced table, and then drag the field to the previously linked field of the referenced table.
      > [!NOTE]
      > This creates the join between the tables that is based on the original linking fields.
   4. On the **Design** tab, click **Update** in the **Query Type** group.
      > [!NOTE]
      > This changes the query type.
   5. Double-click the new field from the referenced table to add it to the field list.
   6. In the **Update To** field, type *[Main TableName].[New AutoNumber field]* to update the new field values in the referenced table.
   7. On the **Design** tab, click **Run** in the **Results** group.
   8. When you are prompted by the "You are about to paste # row(s) into a new table" message, click **Yes** to insert the rows.
   9. Close the query.
6. Delete the original linking field from the main table and the referenced table.
7. Revert the name of the new **AutoNumber** field to the original name.
8. Re-create the primary key and the relationship between the tables.This procedure resets your **AutoNumber** field and updates the referenced table by using the correct key values.
