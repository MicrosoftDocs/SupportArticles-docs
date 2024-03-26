---
title: PO was received but wasn't in Dynamics GP
description: Provides a solution to an issue where purchase order was received but shouldn't have been in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Issue where purchase order was received but shouldn't have been in Microsoft Dynamics GP

This article provides a solution to an issue where purchase order was received but shouldn't have been in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871923

## Symptom

You entered a receipt for a purchase order but it shouldn't have been received. You need to be able to return the quantities but you don't want to use Purchase Order Returns in Microsoft Dynamics GP.

## Resolution

**Return a shipment ("Return" transaction type in Purchase Order Returns)**  
To return a shipment manually, you must enter a negative adjustment in inventory. However, a negative adjustment always pulls the unit cost based on the valuation method of the item. So you may have to do the Adjust Costs procedure before you can enter the negative adjustment. The following steps assume that you'll be returning the whole receipt line.

1. Create a batch and validate the current unit cost for the negative adjustment. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Inventory**, and then select **Batches**.
    1. In the **Batch ID** box, type the Batch ID that you want to use.
    1. From the **Origin** list, select **Transaction Entry**.
    1. Select the **Post to General Ledger** check box, and then select **Transactions**.
    1. In the **Item Number** box, type the item number that you must return.
    1. In the **Quantity** box, type the number of parts that you must return as a negative number.
        > [!NOTE]
        > The **Unit Cost** box will display a default value that is based on your valuation method. If the unit cost is the same value as the unit cost of the purchase receipt, go to step 3d.
    1. Select **Delete**. When you're prompted to delete the transaction, select **Delete** again.
    1. Close the **Item Transaction Entry** window.

2. Adjust the cost of the current inventory layer to reflect the unit cost of the purchase receipt that you must return. To make this adjustment, follow these steps:

    1. In Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Inventory**, and then select **Adjust Costs**.

        In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Utilities** on the **Tools** menu, point to **Inventory**, and then select **Adjust Costs**.
    1. In the **Item Number** box, type the item number that you must return.
    1. In the **Site ID** box, type the site that you'll be returning the item from.
    1. Locate the next available layer based on your valuation method.
    1. Note the current values of the **Unit Cost** box and of the **Quantity Sold** box.
    1. Change the **Unit Cost** box for that layer to the unit cost that was used on the original purchase receipt.
    1. Select **Process**.

3. Enter the negative adjustment. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Inventory**, and then select **Transaction Entry**.
    1. In the **Batch ID** box, type the Batch ID that you created in step 2.
    1. In the **Item Number** box, type the item number that you must return.
    1. In the **Quantity** box, type the number of parts that you must return as a negative number.
    1. Select **Distributions**. Change the **Inventory Offset** box to apply to your accrued purchases account, and then select **OK**.
    1. Select **Save**, and then close the **Item Transaction Entry** dialog box.
    1. On the **Transactions** menu, point to **Inventory**, and then select **Series Post**.
    1. Select the check box for the batch that you created in step 1, and then select **Post**.
    1. If you adjusted costs in step 2, go to step 4. Otherwise, the return of the inventory is completed.

4. Adjust costs again to guarantee that your inventory account matches your purchase receipts reports. To do it, follow these steps:

    1. In Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Inventory**, and then select **Adjust Costs**.
        In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Utilities** on the **Tools** menu, point to **Inventory**, and then select **Adjust Costs**.
    1. In the **Item Number** box, type the item number that you returned.
    1. In the **Site ID** box, type the site that you returned the item from.
    1. Locate the layer on which you adjusted costs in step 2. If the value in the **Quantity Sold** box isn't zero, return the value in the **Unit Cost** box to its original amount from before you adjusted costs in step 2.
    1. Change the value in the **Unit Cost** box for the receipt that you returned. Return the value to match the original value of the **Unit Cost** box of the layer that you adjusted in step 2.

**Return a shipment/invoice ("Return w/Credit" transaction type in Purchase Order Returns)**  
The shipment part of the receipt can be backed out as outlined in the "Returning a shipment (Return)" section. To back out the invoice, you must issue a return in Payables Management.

1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.
2. From the **Document Type** list, select **Return**.
3. In the **Vendor ID** box, type the vendor ID to which you're returning the items.
4. In the **Document Number** box, type the return number that you received from the vendor.
5. In the **Returns** box, type the credit that you're receiving from your vendor for the returned inventory.
6. Select **Distributions**.
7. Change the **PURCH** type account to your inventory account, and then select **OK**.
8. Select **Apply**.
9. Select the check box for the original invoice of the item, and then select **OK**.
10. Select **Post**.

**Close the purchase order.**  

After you've returned the items, you can close the purchase order and move the purchase order to history. To do it, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Edit Purchase Orders**.
2. In the **PO Number** box, type the purchase order number that you want to close.
3. On the **Purchase Order Status** drop-down list, select **Closed**, and then select **Process**.
4. In Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Purchasing**, and then select **Remove Completed Purchase Orders**.

    In Microsoft Dynamics GP 9.0 and in earlier versions, point to **Utilities** on the **Tools** menu, point to **Routines**, point to **Purchasing**, and then select **Remove Completed Purchase Orders**.
5. In the **From** and **To** boxes, type the purchase order number that you want to move to history, and then select **Insert**.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
