---
title: Incorrect balance in Item Stock Inquiry
description: Provides a solution to an issue where the Balance field on the top line of the Item Stock Inquiry window doesn't total across to equal the amount from the transaction.
ms.reviewer: theley, Beckyber, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Balance in Item Stock Inquiry is incorrect in Microsoft Dynamics GP

This article provides a solution to an issue where the Balance field on the top line of the Item Stock Inquiry window doesn't total across to equal the amount from the transaction.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2647425

## Symptoms

In Microsoft Dynamics GP, when you review an item's quantities in the Item Stock Inquiry window, the **Balance** field for the first transactional line doesn't equal the amount of that transaction. For example, the first transaction displayed is an increase adjustment for a quantity of 5, however the **Balance** field displays 3.

## Cause

There are many things that will make the Balance field in the Item Stock Inquiry window incorrect.

1. The **Total Stock** at the bottom of the window is incorrect. See [Resolution 1](#resolution-1).

2. The **Maintain History - Transaction** checkbox hasn't consistently been marked for the item in Item Maintenance Options. See Resolution 2.

3. Historical transactions were removed for this item using the Remove Inventory Transaction History window. See [Resolution 2](#resolution-2).

4. An interruption during posting caused the IV30300 to not be updated or updated incorrectly. See [Resolution 2](#resolution-2).

5. The Unit of Measure equivalent for this item has been changed. See [Resolution 3](#resolution-3).

6. It's a serialized or lot numbered item and quantities were overridden to sell goods that weren't in the inventory. For example, you sold 10 of an item when you had 0 on hand. See [Resolution 4](#resolution-4).

## Resolution 1

To correct the Total Stock at the bottom of the window run Inventory Reconcile. To run Inventory Reconcile on the Microsoft Dynamics GP window point to **Tools**, point to **Utilities**, point to **Inventory**, and then select **Reconcile**. Insert the item you're reviewing in the Inquiry window and select **Process**.

## Resolution 2

If historical transactions are missing or incomplete, the Item Stock Inquiry window will not be reliable for this item and you may need to discontinue use of it. If it isn't desirable, then you may wish to start over with the item. To do it, here are the recommended steps.

1. If there are any quantities not On Hand, enter and post Inventory Transfer transactions to move them to the On Hand quantity bucket.

1. > [!NOTE]
   > The current Quantity on Hand for the item, and then enter and post an inventory decrease transaction to bring that quantity to 0.

1. Use Remove Inventory Transaction History to remove all transactional history for this item.

1. At this point, the Item Stock Inquiry window will have 0 Total Stock and 0 quantity Balance. Verify that **Maintain History - Transaction** checkbox is marked in the Item Maintenance Options window to keep this information going forward.

1. Enter an increase inventory adjustment transaction to bring the quantity on hand back up to what it should be.

    The Item Stock Inquiry window will now be correct.

    > [!NOTE]
    > It may be possible to manipulate the data in the backend using SQL to correct this window.

    Customers:  
    For more information about data manipulation consulting services, contact your partner of record If you don't have a partner of record, visit [Microsoft Pinpoint](https://www.microsoft.com/solution-providers/home) to identify a partner.

    Partners:  
    For more information about data manipulation consulting services, contact Microsoft Advisory Services at 800-MPN-SOLVE.

## Resolution 3

If equivalent units of measure have been changed, then the Item Stock Inquiry window won't be reliable for this item and you may need to stop use of it. If it isn't desirable, then you may wish to start over with the item. See the steps under [Resolution 2](#resolution-2) for the recommended steps for doing it.

## Resolution 4

Keeping in mind that when you override a serialized or lot numbered item your Quantity on Hand doesn't go negative, the selling of those 10 left your on hand quantity at 0. When you brought quantity in (assume 10), that increased the Quantity on Hand rather than consuming the override. Now your quantity on hand is overstated by the 10 you overrode. To correct it and the Item Stock Inquiry window, do these steps:

1. Enter and post a decrease transaction to take those 10 out of your inventory so your Quantity on Hand is now correct. Typically it decrease wouldn't be posted to General Ledger.

1. Use Remove Transaction History to remove the transaction done in Step A from inventory history. In the Remove Inventory Transaction History window, choose Document Number in the Range and insert the document number of the transaction from Step A. Process.

The Item Stock Inquiry window and the Quantity on Hand will now be correct.

## More information

The Balance column in this window is calculated starting with the quantity in the Total Stock field at the bottom. It's calculated from the quantity fields in the IV00102 (Item Quantity Master) table. So if these quantities are incorrect, then the Total Stock will also be incorrect. That means that the Balance that is calculated will likely also be incorrect.

Once the Total Stock number is determined, then we ADD any transactions that decrease the quantity of the item, and SUBTRACT any transactions that increase the quantity working our way from the bottom of the window to the top to determine what is displayed in the Balance field. The transactions we're using are stored in the IV30300 (Inventory Transaction Amounts History) table.

To determine if there are missing or other transactions in the IV30300 table that are causing discrepancies for the item, compare the inflows in the IV30300 to the receipts in the IV10200 (InventoryPurchase Receipts Work) table. Also compare the decrease transactions in the IV30300 to the outflows in the IV10201 (Inventory Purchase Receipts Detail) table.
