---
title: How to start fresh without losing setup files in Inventory
description: Discusses how to start over in Inventory with only the setup files in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# How to start fresh without losing the setup files in Inventory in Microsoft Dynamics GP

This article describes how to start fresh in Inventory in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains without losing the setup files for Microsoft Dynamics GP. To do this, use one of the following methods:

- Stock Count and Remove Transaction History
- Delete Data

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 844464

Before you use either method to start fresh in Inventory, follow these steps:

1. Select **Transactions**, point to **Inventory**, and then select **Batches**.
2. In the **Inventory Batch Entry** list, delete any batches that are still in the list.
3. Select **Transactions**, point to **Sales**, and then select **Invoicing Batches**.
4. In the **Invoice Batch Entry** list, delete any batches that are still in the list.

> [!NOTE]
> If you are using Sales Order Processing, Invoicing, or Purchase Order Processing, make sure that there are no unposted transactions. If there are unposted transactions, either post the transactions or delete them.

## Method 1 - Stock Count and Remove Transaction History

1. Select **Transactions**, point to **Inventory**, and then select **Stock Count Schedule**.
2. Enter all the items that you want to zero-out. If an item is in multiple sites, you will have to enter that item for each site on a per line item basis.
3. Start the stock count. To do this, follow these steps:

    1. Select **Transactions**, point to **Inventory**, and then select **Stock Count Entry**.
    2. Make sure that the **Counted Quantity** field is set to zero for all line items.
    3. Select the **Auto Post Stock Count Variances** check box so that the inventory will be updated automatically.
    4. Select the **Verified** check box for each line item.
    5. Select **Process**.

4. Remove the transaction history. To do this, follow these steps:

    1. Select **Tools**, point to **Utilities**, point to **Inventory**, and then select **Remove Transaction History**.
    2. Create a range restriction for item numbers.
    3. Select **Insert**.
    4. Select **Process**.

## Method 2 - Delete Data

1. Start a new Microsoft SQL Server query. To do this, follow the appropriate step:

   - In SQL Server 2000, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - In SQL Server 2005, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**. Then, select **New Query**.
   - In SQL Server 2005 Express Edition, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio Express**. Then, select **New Query**.
   - In Microsoft SQL Server Desktop Engine (MSDE), select **Start**, point to **Programs**, point to **Microsoft Support Administrator Console**, and then select **Support Administrator Console**.

    > [!NOTE]
    > The Support Administrator Console requires a separate installation. If you do not have the program installed, you can install it by using the Microsoft Dynamics GP installation CD.

2. Run the following queries against the company database to delete the data from the tables.

    ```SQL
    DELETE from IV10000 
    DELETE from IV10001 
    DELETE from IV10002 
    DELETE from IV10200 
    DELETE from IV30100 
    DELETE from IV30101 
    DELETE from IV30102 
    DELETE from IV30200 
    DELETE from IV30300 
    DELETE from IV30301 
    DELETE from IV30400 
    DELETE from IV30500 
    DELETE from IV30600 
    DELETE from IV00102 
    DELETE from IV00200 
    DELETE from IV00300 
    DELETE from IV00102 
    DELETE from IV10201
    ```

3. Run the Check Links method on the inventory series that you want to start fresh. To do this, use the appropriate step:
   - In Microsoft Dynamics GP 10.0: Select **Microsoft Dynamics GP**, point to **Maintenance**, and then select **Check Links**.
   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0: On the **File** menu, select **Maintenance**, and then select **Check Links**.

4. Select the **Transaction Work** check box, and then select **Insert**.
5. Select the **Transaction Purchase Receipts** check box, and then select **Insert**.
6. Select **OK**.
7. Run the Reconcile method by using the appropriate step for your version:

    - In Microsoft Dynamics GP 10.0: select **Microsoft Dynamics GP**, point to **Tools**, point to **Utilities**, select **Inventory**, and then select **Reconcile**.
    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0: On the **Tools** menu, point to **Utilities**, select **Inventory**, and then select **Reconcile**.

8. Select the inventory items in the Reconcile window, and then select **Process**.
