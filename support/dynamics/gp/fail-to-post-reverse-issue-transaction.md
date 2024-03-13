---
title: Error when you post a reverse issue transaction
description: Describes a problem that may occur because there are pending quantities in various tables. A resolution is provided.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error message when you try to post a "reverse issue" transaction in the Component Transaction Entry window in Microsoft Dynamics GP: "Quantities of the items are insufficient for this transaction"

This article provides a solution to an error that occurs when you post a "reverse issue" transaction in the **Component Transaction Entry window** in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 952378

## Symptoms

When you try to post a "reverse issue" transaction in the **Component Transaction Entry** window in Microsoft Dynamics GP, you receive the following error message:

> Quantities of the items are insufficient for this transaction.

## Cause

This problem may occur because there are pending quantities in various tables. The pending quantities can come either from unposted pick documents or from incorrectly updated tables.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, determine whether there are pending quantities in various tables. If there are pending quantities, you must either post the pending pick documents, or you must update the incorrect values to correct the tables. The general steps for this procedure are as follows:

1. Verify that there are no pending quantities in the manufacturing tables.
2. Verify that there are no unposted pick documents that cause the pending quantities.
3. Verify that the inventory transactions have been posted for the problematic pick documents.
4. Remove the lines that are not valid from the pending manufacturing tables.
5. Verify that the "Work in Process" (WIP) quantity for the components is correct.
6. Verify that the quantity that is issued for the components is correct.
7. Try to complete the reverse issue again.

### Step 1: Verify that there are no pending quantities in the manufacturing tables

There are several tables that may contain pending quantities for a manufacturing order. Check the following tables for any pending quantities for a manufacturing order:

- The Manufacture Order Lot Issue table (MOP1020)
- The Manufacture Order Pending Bin table (MOP1025)
- The Manufacture Order Pending Bin Trx table (MOP1026)

The only exception in which you should have records in these tables is if you have "unposted saved pick" documents in the Component Transaction Entry window. If you have records in these tables, you must determine with which pick document or with which "manufacturing order" receipt the pending quantities are associated. To do this, follow these steps:

1. Depending on the version of Microsoft SQL Server that you use, start SQL Server Management Studio, or start SQL Query Analyzer. To do this, use one of the following steps:
   - If you are using SQL Server 2005, open SQL Server Management Studio. To do this, click **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
   - If you are using SQL Server 2000 or SQL Server 7.0, open SQL Query Analyzer. To do this, click **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then click **Query Analyzer**.

2. Use one of the following steps:
   - In SQL Server Management Studio, expand **Databases** in **Object Explorer**, and then click **Dynamics**. Click **New Query**, type the following select statement in the query pane, and then click **Execute**.

        ```sql
        SELECT * FROM MOP1020 WHERE MANUFACTUREORDER_I= '<XXX>' 
        SELECT * FROM MOP1025 WHERE MANUFACTUREORDER_I= '<XXX>'
        SELECT * FROM MOP1026 WHERE MANUFACTUREORDER_I= '<XXX>' 
        ```

   - In SQL Query Analyzer, type the following select statement in the **Query** pane, and then click **Execute**.

        ```sql
        SELECT * FROM MOP1020 WHERE MANUFACTUREORDER_I= '<XXX>' 
        SELECT * FROM MOP1025 WHERE MANUFACTUREORDER_I= '<XXX>'
        SELECT * FROM MOP1026 WHERE MANUFACTUREORDER_I= '<XXX>' 
        ```

    > [!NOTE]
    > Replace **\<XXX>** with the "manufacturing order receipt" number. To determine the "pick document" number or the "manufacturing order receipt" number that is associated with the pending quantities, refer to one of the following values:
    >
    > - The value in the **DOCNUMBR** column in table MOP1020
    > - The value in the **MOPDOCNUM** column in table MOP1025 or in table MOP1026

### Step 2: Verify that there are no unposted pick documents that cause the pending quantities

If there is a record in any of these tables, there may be a saved pending document in the Component Transaction Entry window. You must post this saved pending document, or you must remove the pending lines from the document. To do this, follow these steps:

1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **Component Trx Entry**.
2. In the **Manufacturing Pick Number** field, enter all the pick documents that are returned from the scripts in the [Step 1: Verify that there are no pending quantities in the manufacturing tables](#step-1-verify-that-there-are-no-pending-quantities-in-the-manufacturing-tables) section. Then, use one of the following steps:
   - If the **Post** button is unavailable, go to the [Step 3: Verify that the inventory transactions have been posted for the problematic pick documents](#step-3-verify-that-the-inventory-transactions-have-been-posted-for-the-problematic-pick-documents) section.
   - If the **Post** button is available, either post the pick document or remove the lines from the pick document. To remove the lines from the pick document, click each line, and then click **Delete Row** on the **Edit** menu.

### Step 3: Verify that the inventory transactions have been posted for the problematic pick documents

If the **Post** button is unavailable, the pick document has been posted. However, it is not cleared from the tables. You must verify that the inventory transactions that are associated with this pick document are posted in Inventory in Microsoft Dynamics GP. To do this, follow these steps:

1. On the **Inquiry** menu, point to **Inventory**, and then click **Item Transaction**.
2. In the Item Transaction window, enter the item number in the **Item Number** field, and then enter the date range in the **Document Date Range** section.
3. In the results, double-click the transaction to see the detailed information.
4. On the **Inquiry** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MO Activity**.
5. In the **MO Number** field, enter the manufacturing order number.
6. Locate the document number of the document about which you want more information, and then double-click the document.
7. If the document has been posted correctly, you will see the components in the Inventory Transaction Inquiry window. If you do not see the components, contact Technical Support for Microsoft Dynamics.  

### Step 4: Remove the lines that are not valid from the pending manufacturing tables

If there are no "unposted saved pick" documents in the Component Transaction Entry window, and you posted the inventory transactions, you must remove all the records that are related to this manufacturing order from table MOP1020, from table MOP1025, and from table MOP1026. To do this, run the following statement in SQL Server Management Studio or in SQL Query Analyzer.

```sql
DELETE MOP1020 WHERE MANUFACTUREORDER_I= '<XXX>' 
DELETE MOP1025 WHERE MANUFACTUREORDER_I='<XXX>'
DELETE MOP1026 WHERE MANUFACTUREORDER_I='<XXX>'
```

> [!NOTE]
> Replace **\<XXX>** with the manufacturing order number.

### Step 5: Verify that the WIP quantity for the components is correct

After you remove the pending quantities, you must make sure that these pending quantities do not affect quantities in "Work in Process" (WIP). To do this, run SmartList, or use a script in SQL Server. To do this, use one of the following methods.

#### Method 1: Use the "Work in Process" SmartList

1. Locate the "Work in Process" SmartList. To do this, use the appropriate step:

    - In Microsoft Dynamics GP 10.0, click **SmartList** on the **Microsoft Dynamics GP** menu, and then click **Work in Process**.
    - In Microsoft Dynamics GP 9.0, click **SmartList** on the **View** menu, and then click **Work in Process**.

2. Verify the value in the **WIP QTY IN** column. This value is the total quantity that is issued for the components.

#### Method 2: Use scripts in SQL Server

The sum of all the issue transactions minus the sum of all the "reverse issue" transactions should match the value in the **QTYRECVD** column in table MOP1000. The value in the **QTYSOLD** column should be the sum of all the quantities that are consumed in finished good receipts. To verify the **QTYRECVD** column in table MOP1000, and to verify the **QTYSOLD** column in table MOP1210, follow these steps:

1. Run the following script in SQL Server Management Studio or in SQL Query Analyzer.

    ```sql
    SELECT QTYRECVD,* FROM MOP1000 WHERE MANUFACTUREORDER_I='<XXX>'
    ```

    > [!NOTE]
    > Replace **\<XXX>** with the manufacturing order number.

    The value in the **QTYRECVD** column in table MOP1000 should be the sum of all the issue transactions minus the sum of all the "reverse issue" transactions.

2. Run the following script in SQL Server Management Studio or in SQL Query Analyzer.

    ```sql
    SELECT TRX_TYPE, TRXQTY, * FROM MOP1210 WHERE MANUFACTUREORDER_I='<XXX>'
    ```

    You must add the value in the **TRXQTY** column for each TRX_TYPE type. The total is the received quantity.

    > [!NOTE]
    > The following values are used for **TRX_TYPE**:
    >
    > - **1**: issue transaction
    > - **2**: reverse issue transaction

    The value in the **QTYSOLD** column should be the sum of all the quantities that are consumed in the finished good receipts.

### Step 6: Verify that the quantity that is issued for the components is correct

You must verify that the quantities that are issued in table PK010033, in table MOP1400, and in table MOP1210 are correct. To do this, follow these steps:

1. To make sure that the value in the **QTY_ISSUED_I** column is correct, check table PK010033 and table MOP1400. Sometimes, part of the "reverse issue" transactions update table PK010033 and table MOP1400. However, no other tables are affected. To verify that the value in the **QTY_ISSUED_I** column in these tables is correct, follow these steps:

    1. On the **Inquiry** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MO Activity**.

    2. In the Manufacturing Order Activity window, enter the manufacturing order number in the **MO Number** field.

    3. Double-click the document about which you want more information. If the document was posted correctly, you should see the components in the Inventory Transaction Inquiry window.

    4. Verify that the value is correct in the **QTY_ISSUED_I** column in table MOP1400 and in table PK010033. To do this, run the following script in SQL Server Management Studio or in SQL Query Analyzer.

        ```sql
        SELECT QTY_ISSUED_I, * FROM MOP1400 WHERE MANUFACTUREORDER_I='<XXX>'
        SELECT QTY_ISSUED_I, * FROM PK010033 WHERE MANUFACTUREORDER_I='<XXX>'
        ```

        > [!NOTE]
        > Replace **\<XXX>** with the manufacturing order number.

    5. If the value in the **QTY_ISSUED_I** column is incorrect, update it by using a script in SQL Server. To do this, run the following script in SQL Server Management Studio or in SQL Query Analyzer.

        ```sql
        Update PK010033 set QTY_ISSUED_I = '<XX>' WHERE DEX_ROW_ID = '<YYYY>'
        Update MOP1400 set QTY_ISSUED_I = '<XX>' WHERE DEX_ROW_ID = '<YYYY>'
        ```

        > [!NOTE]
        > Replace **\<XX>** with the correct number of items that were issued. Replace **\<YYYY>** with the value in the **DEX_ROW_ID** column that was returned in step 1d earlier in this section.

2. Verify that the correct numbers have been issued and reverse-issued in table MOP1200 and in table MOP1210. To do this, follow these steps:

    1. If the "reverse issue" transaction is not completely processed, remove it from table MOP1210, or update it by using the correct value. If the "reverse issue" transaction is not completely processed, you will receive the following error message when you transact the related items:

        > Quantities are insufficient for this transaction.

        - To remove the reverse issue transaction in table MOP1210, run the following script in SQL Server Management Studio or in SQL Query Analyzer.

            ```sql
            DELETE MOP1210 WHERE WHERE MANUFACTUREORDER_I='<XXX>'and DEX_ROW_ID ='<YYYY>'
            ```

            > [!NOTE]
            > Replace **\<XXX>** with the manufacturing order number. Replace **\<YYYY>** with the DEX_ROW_ID value that you have to remove from an item.

        - If the quantity of a component was partly transacted, you must update the record in table MOP1210. To do this, run the following script in SQL Server Management Studio or in SQL Query Analyzer.

            ```sql
            UPDATE MOP1210 SET TRXQTY ='<X>' WHERE WHERE MANUFACTUREORDER_I='<YYY>'and DEX_ROW_ID ='<ZZZZ>'
            ```

            > [!NOTE]
            > Replace **\<X>** with the correct quantity. Replace **\<YYY>** with the manufacturing order number. Replace **\<ZZZZ>** with the DEX_ROW_ID value that you have to update.

    2. Perform the Inventory Reconcile process for these items. To do this, use the appropriate step:

        - In Microsoft Dynamics GP 10.0, point to **Utilities** on the **Microsoft Dynamics GP** menu, point to **Inventory**, and then click **Reconcile**.
        - In Microsoft Dynamics GP 9.0, point to **Utilities** on the **Tools** menu, point to **Inventory**, and then click **Reconcile**.

After you complete these steps, you can successfully process a "reverse issue" transaction for the manufacturing orders or for the items that cause this problem. To do this, follow these steps:

1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **Component Trx Entry**.
2. Enter the range of the manufacturing order numbers in the **Ranges** section, and then click **Reverse Issue** in the **Transaction Type** list.
3. Click the item that you want to reverse-issue, and then click **Add to Pick Doc**.
4. Click **Post**.
