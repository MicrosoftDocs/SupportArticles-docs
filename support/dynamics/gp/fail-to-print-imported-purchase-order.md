---
title: Error when you print imported purchase order in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you print an imported purchase order in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.reviewer: theley
ms.custom: sap:Distribution - Purchase Order Processing
---
# Error message when you try to print an imported purchase order in Microsoft Dynamics GP: "A Get/Change Next Operation on table POP_PO_Line failed"

This article provides a solution to an error that occurs when you print an imported purchase order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 926390

## Symptoms

When you try to print an imported purchase order in Microsoft Dynamics GP, you receive the following error message:

> A Get/Change Next Operation on table POP_PO_Line failed. A Record was already locked.

## Cause

This problem occurs if one of the following conditions is true:

- A user session is unresponsive or is inactive. See resolution 1.
- The purchase order is missing a field. See resolution 2.

## Resolution 1: Delete any unresponsive records

1. Back up the Microsoft Dynamics GP company database.

2. Back up the Dynamics database.
3. Have all users log out of Microsoft Dynamics GP.
4. Stop and then start the Microsoft SQL Server to clear out the temporary tables.
5. In SQL Query Analyzer, select the Dynamics database. Then, use the following statements to delete all the records from the ACTIVITY, SY00800, and SY00801 tables:

    - **delete ACTIVITY**
    - **delete SY00800**
    - **delete SY00801**
6. Log back on to Microsoft Dynamics GP as a user who has the system administrator role.
7. On the **File** menu, point to **Maintenance**, and then click **Check Links**.
8. In the Check Links window, click **Purchasing** in the **Series** list.
9. In the **Logical Tables** list, click **Purchasing Transactions**, click **Insert**, and then click **OK**.
10. Select a destination for the report, and then click **OK**.
11. On the **Tools** menu, point to **Utilities**, point to **Purchasing**, and then click **Reconcile Purchasing Documents**.
12. Click **Reconcile and Print Report**, and then click **Process**.

## Resolution 2: Make sure that the purchase order fields are populated in the POP10110 table

1. Back up the Microsoft Dynamics GP company database.
2. Back up the Dynamics database.
3. On the **Cards** menu, point to **Inventory**, and then click **Vendors**.
4. In the Item Vendors Maintenance window, verify that the **Vendor ID** field is populated for the item numbers on the purchase order.
5. If the **Vendor ID** field is not populated, type the vendor ID in the field.
6. Start SQL Query Analyzer. To do this, click **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.
7. In the database list, click your company database.
8. Copy the `SELECT * FROM POP10110 where PONUMBER ='xxx'` SQL statement to the Query window.

    > [!NOTE]
    > The xxx placeholder represents the purchase order number.
9. On the **Query** menu, click **Execute**.
10. Note the DEX_ROW_ID value of the record.
11. Verify that there is a value under the **VNDITNUM** column.
12. Update the **VNDITNUM** column in the POP10110 table to reflect the value in the **Vendor Item** field in the Item Vendors Maintenance window in Microsoft Dynamics GP. To do this, follow these steps:

    1. Start SQL Query Analyzer.
    2. In the database list, click the company database.
    3. Copy the `UPDATE POP10110 SET VNDITNUM = 'xxx' WHERE DEX_ROW_ID = 'yyy'` SQL statement to the Query window.

        > [!NOTE]
        > The xxx placeholder represents the value in the **Vendor Item** field in the Item Vendors Maintenance window. The yyy placeholder represents the DEX_ROW_ID value of the record that you are updating.
    4. On the **Query** menu, click **Execute**.
    5. Exit SQL Query Analyzer.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
