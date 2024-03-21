---
title: Change the perpetual valuation method
description: Describes how to change the perpetual valuation method and the periodic valuation method if Manufacturing is installed in Microsoft Dynamics GP.
ms.reviewer: ttorgers, lmuelle, theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Manufacturing Series
---
# How to change the perpetual valuation method and the periodic valuation method when Manufacturing in Microsoft Dynamics GP is installed

This article describes how to change the perpetual valuation method to the periodic valuation method when Manufacturing in Microsoft Dynamics GP is installed. This article also describes how to change the periodic valuation method to the perpetual valuation method when Manufacturing is installed.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 940837

> [!IMPORTANT]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## How to change the perpetual valuation method to the periodic valuation method when Manufacturing is installed

1. On the **Reports** menu, point to **Inventory**, and then select **Inventory**.
2. Print the Stock Status report for the items you're changing.

    > [!NOTE]
    > The Stock Status report displays a record of the on-hand inventory value.
3. On the **Cards** menu, point to **Inventory**, and then select **Quantities/Sites**.
4. In the **Item Quantities Maintenance** window, make sure that the items you're changing have no allocated quantities.

    > [!NOTE]
    > If you change the perpetual valuation method to the periodic valuation method, the items that you're changing cannot have any allocated quantities.
5. Process the documents of the unposted transactions or of the outstanding transactions. These transactions are as follows:

    - Sales orders or sales invoices
    - Purchase orders or purchase receipts
    - Inventory transactions or inventory stock counts

    > [!NOTE]
    >
    > - To process these documents, you can delete or void them. Or you can remove the line item in question from the documents.
    > - The items that you're changing can't exist on any unposted transactions or any outstanding transactions.

6. If quantities of the items you're changing were issued to the work-in-process (WIP) account, post reverse-issue transactions. Do this to remove these quantities from the WIP account. These items must not exist in the WIP account for manufacturing orders.

    > [!TIP]
    >
    > - To view the WIP account information, use the SmartList object.
    > - After the perpetual valuation method is changed, you can post issue transactions to return the appropriate quantities to the WIP account.

   - On the **Cards** menu, point to **Inventory**, and then select **Quantities/Sites** and note the quantity on hand (or print the Stock Status report or look at SmartList to find the quantity on hand). You'll need to do a decrease adjustment in inventory to bring all quantities down to zero by pointing to **Transactions** > **Inventory** > **Transaction Entry**.

     > [!NOTE]
     > This is needed because all layers in the IV10200 need to be consumed before the change, or there will be issues with posting after the change. This is because Microsoft Dynamics GP isn't coded to change any valuation method in the IV10200. It just changes any new layers coming into the system, and you don't want layers in both valuation methods to be consumed after the change, or it will cause issues with posting and/or cost.

7. Have all users exit the transaction windows for the following modules before you use the Change Valuation Method tool:

   - Inventory
   - Sales Order Processing
   - Purchase Order Processing

8. Use the **Change Valuation Method** window to change the perpetual valuation method to the periodic valuation method. To do this, follow the appropriate step:

   - If you're using Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, then point to **Utilities**, then point to **Inventory**, and then select **Change Valuation**.
   - If you're using Microsoft Dynamics GP 9.0, point to **Utilities** on the **Tools** menu, then point to **Inventory**, and then select **Change Valuation**.

    > [!NOTE]
    > This updates the valuation method (VCTNMTHD) field in the IV00101 table and the CT00102 table.

9. Use the value in the **Standard Cost** field in the **Item Maintenance** window to populate the ICIV0323 table and the CT00003 table. To do this, follow the appropriate step:

   - If you're using SQL Server Desktop Engine (also known as MSDE 2000), start Support Administrator Console. To do this, select **Start**, point to **All Programs**, then point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.
   - If you're using Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, then point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you're using Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, then point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

10. Run the following scripts against the company database.

    ```sql
    update CT00003 set COST_I=b.STNDCOST from CT00003 a, IV00101 b
     where a.ITEMNMBR=b.ITEMNMBR and a.COST_I<>b.STNDCOST
    update ICIV0323 set MATCOSTI_1=b.STNDCOST, 
    TOTALCOSTI_1=b.STNDCOST from ICIV0323 a, IV00101 b 
    where a.ITEMNMBR=b.ITEMNMBR and a.MATCOSTI_1<>b.STNDCOST
    ```

    > [!NOTE]
    > The ICIV0323 table and the CT00003 table are standard cost tables.

11. On the **Cards** menu, point to **Inventory**, select **Item**, and then verify that the records that were created have a standard cost.
12. Print the Stock Status report for the items that you changed. The Stock Status report displays the value of the inventory at periodic costs. These periodic costs are standard costs.

    > [!TIP]
    > To match the new value of the inventory to the value in the inventory accounts, post the journal entry in the general ledger.

13. Enter and then revalue the standard costs. To do this, use one of the following methods.

#### Method 1

1. In the **Standard Item Material Costs** window, point to **Manufacturing** on the **Cards** menu, then point to **Inventory**, and then select **Std Item Mat Costs**.
2. Use the **Roll Up and Revalue Inventory** window to revalue the standard cost. To do this, follow the appropriate step:

   - If you're using Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, then point to **Routines**, then point to **Manufacturing**, and then select **Rollup and Revalue**.
   - If you're using Microsoft Dynamics GP 9.0, point to **Routines** on the **Tools** menu,then point to **Manufacturing**, and then select **Rollup and Revalue**.

#### Method 2

1. In the **Standard Cost Maintenance** window, point to **Inventory** on the **Cards** menu, then point to **Manufacturing**, and then select **Std Cost Maintenance**.
2. Use the **Roll Up and Revalue Inventory** window to revalue the standard cost. To do this, follow the appropriate step:

     - If you're using Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, then point to **Routines**, then point to **Manufacturing**, and then select **Rollup and Revalue**.
     - If you're using Microsoft Dynamics GP 9.0, point to **Routines** on the **Tools** menu, then point to **Manufacturing**, and then select **Rollup and Revalue**.

#### Method 3

1. On the **Cards** menu, point to **Manufacturing**, then point to **Inventory**, and then select **Standard Costs Changes**.
2. Enter the standard costs in the **Standard Costs Changes** window, select **Rollup**, and then select **Replace Costs**.

## How to change the periodic valuation method to the perpetual valuation method when Manufacturing is installed

1. On the **Cards** menu, point to **Inventory**, and then select **Quantities/Sites**.
2. In the **Item Quantities Maintenance** window, make sure that the items you're changing have no allocated quantities.

    > [!NOTE]
    > To change the periodic valuation method to the perpetual valuation method, the items you're changing cannot have any allocated quantities.

3. Process the documents of the unposted transactions or of the outstanding transactions. These transactions are as follows:

    - Sales orders or sales invoices
    - Purchase orders or purchase receipts
    - Inventory transactions or inventory stock counts

    > [!NOTE]
    >
    > - To process these documents, you can delete or void them. Or you can remove the line item in question from the documents.
    > - The items you're changing cannot exist on any unposted transactions or any outstanding transactions.

4. If quantities of the items you're changing were issued to the WIP account, post reverse-issue transactions. Do this to remove these quantities from the WIP account. These items must not exist in the WIP account for manufacturing orders.

    > [!TIP]
    >
    > - To view the WIP account information, use the SmartList object.
    > - After the perpetual valuation method is changed, you can post issue transactions to return the appropriate quantities to the WIP account.

5. Determine the cost buckets that are used to track the costs for the item in question.

    > [!TIP]
    > To view the standard cost for each cost bucket, use the **Standard Cost Changes** window. To open the **Standard Cost Changes** window, point to **Manufacturing** on the **Cards** menu, then point to **Inventory**, and then select **Standard Cost Changes**.

6. View the account that's used to track the following costs:

   - Labor cost
   - Machine cost
   - Overhead cost

    > [!NOTE]
    >
    > - If you were tracking these costs for the finished items, these costs are no longer broken out.
    > - Perpetual (actual) cost items track the full cost of the item by using a single cost bucket.

7. If the accounts used for the cost buckets don't include the main inventory account, post a general ledger journal entry. Do this to move the appropriate costs to the main inventory account for the item.

    > [!NOTE]
    > For example, an item has a material cost of $10 and a labor cost of $5. So the total standard cost is $15. If the labor account differs from the main inventory account for the item, post an entry to move the labor cost of $5 for the on-hand items from the labor account to the main inventory account.

   - On the **Cards** menu, point to **Inventory**, and then select **Quantities/Sites** and note the quantity on hand (or print the Stock Status report or look at SmartList to find the quantity on hand). You'll need to do a decrease adjustment in inventory to bring all quantities down to zero. To do this, point to **Transactions** > **Inventory** > **Transaction Entry**.

      > [!NOTE]
      > This is needed because all layers in the IV10200 need to be consumed before the change, or there will be issues with posting after the change. This is because Microsoft Dynamics GP isn't coded to change any valuation method in the IV10200. It just changes any new layers coming into the system, and you don't want layers in both valuation methods to be consumed after the change, or it will cause issues with posting and/or cost.

8. Have all users exit the transaction windows in the following modules before you use the Change Valuation Method tool:

   - Inventory
   - Sales Order Processing
   - Purchase Order Processing

9. Use the **Change Valuation Method** window to revalue the standard costs for the item. To do this, follow the appropriate step:

   - If you're using Microsoft Dynamics GP 10.0, point to **Tools** on the **Microsoft Dynamics GP** menu, then point to **Utilities**, then point to **Inventory**, and then select **Change Valuation**.
   - If you're using Microsoft Dynamics GP 9.0, point to **Utilities** on the **Tools**, then point to **Inventory**, and then select **Change Valuation**.
