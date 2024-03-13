---
title: Error when you select a purchase order in the Purchasing Invoice Entry window in Microsoft Dynamics GP 
description: Provides a solution to an error that occurs if you try to select a purchase order in the Purchasing Invoice Entry window in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error if you try to select a purchase order in the Purchasing Invoice Entry window in Microsoft Dynamics GP: "You cannot receive against unauthorized purchase orders"

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855877

## SYMPTOMS

If you try to select a purchase order in the Purchasing Invoice Entry window in Microsoft Dynamics GP, you receive the following error message:

> You cannot receive against unauthorized purchase orders.

Additionally, you cannot mass approve the purchase orders that are in the Purchase Order Enhancements Entry window.

This problem occurs if one of the following scenarios is true:

- When you activate a purchase order, you deactivate a purchase order, and then you reactivate a purchase order, the activation process does not correctly update the approval status of the purchase orders. For you to successfully enter or match invoices, purchase orders must have a status of **Approved**.

- Canceled purchase orders or some canceled line items in purchase orders remain in the CPO10110 table. Canceled line items must not appear in this table.

## Resolution

To resolve this problem, try [Method 1](#method-1). If Method 1 does not resolve the problem, try [Method 2](#method-1).

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Method 1

Make sure that purchase orders have a status of **Approved** in the POA40003 table. To do this, run the following statements against the company database in Microsoft SQL Query Analyzer. To start SQL Query Analyzer, click **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

1. Run the following **SELECT** statement to locate the purchase order and the DEX_ROW_ID value for the record.

    > [!NOTE]
    > Replace xxx with the purchase order number.

    ```sql
    SELECT DEX_ROW_ID, * FROM POA40003 where PONUMBER =xxx
    ```

2. Run the following **UPDATE** statement to set the purchase order status to **Approved** by using the DEX_ROW_ID value for the record as the condition.

    ```sql
    UPDATE POA40003 SET POA_PO_APPROVAL_STATUS = 2 where DEX_ROW_ID = '<yyy>'
    ```

    > [!NOTE]
    >
    > - In this statement, replace yyy with the actual DEX_ROW_ID value of the record.
    > - The value of 2 is represents a status of **Approved**.

### Method 2

Update purchase order line items that have a status of **Canceled**. Change the status to **Change Order**, and then change the status back to **Canceled** to remove the line items from the CPO10110 table. To do this, follow these steps:

1. Click **Transactions**, point to **Purchasing**, and then click **Edit Purchase Orders**.
2. Click the **Lookup** button next to **PO Number**. Then open the purchase order that you want to update.
3. Locate the specific line items that have a status of **Canceled**. Then click **Change Order** in the **Status** list for those items.
4. Click **Process**.
5. Run the following SQL statement, and notice the ORD value for the Change Order line items.

    ```sql
    SELECT ORD, * FROM POP10110 where PONUMBER = <xxx>
    ```

    > [!NOTE]
    >
    > - In this statement, replace xxx with the actual purchase order number.
    > - By default, the ORD value for the first line item is always 16384. The ORD value always increments by 16384. Therefore, the value for the second line item is 32768, and the value for the third line item is 49152, and so on.

6. Click **Transactions**, point to **Purchasing**, and then click **Edit Purchase Orders**.
7. Click the **Lookup** button next to **PO Number**. Then open the purchase order that you want to update.
8. Locate the specific line items that have a status of **Change Order**. Then click **Canceled** in the **Status** list for those items.
9. Click **Process**.
10. Verify that the purchase order line item is not in the CPO10110 table. To do this, insert the ORD value from step e in the following SQL statement, and then run the statement in SQL Query Analyzer.

    ```sql
    SELECT * FROM CPO10110 where PONUMBER = <xxx> and ORD = <zzz>
    ```

    > [!NOTE]
    >
    > - In this statement, replace xxx with the actual purchase order number.
    > - In this statement, replace zzz with the actual order of the line item number.
    > - This statement should not return any record because canceled line items or canceled purchase orders do not appear in this table.

11. Reconcile the purchase order. To do this, on the Microsoft Dynamics GP menu, click **Tools**, point to **Utilities**, point to **Purchasing**, and then click **Reconcile Purchasing Documents**.
12. In the **Reconcile Purchasing Documents** window, click **Reconcile and Print Report**, and then click **Process**.
13. Make sure that all users are logged out of Microsoft Dynamics GP.
14. On the Microsoft Dynamics GP menu, click **File**, point to **Maintenance**, and then click **Purchase Order Enhancements**.
15. Click to select the **Reconcile** check box to reconcile the Purchase Order Enhancements tables and records. Then click **Process**.
