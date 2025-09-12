---
title: Wrong Unit Cost if 2 invoices are matched to 1 shipment
description: The Unit Cost of the receipt layer is not correct when two invoices are matched to one shipment in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# The Unit Cost of the receipt layer is not what you would expect when two invoices are matched to one shipment

This article provides a resolution to solve the unit cost issue that occurs when two invoices are matched to one shipment in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2021869

## Symptoms

When you invoice match more than one invoice to a single shipment transaction in Microsoft Dynamics GP, the cost from that second (last) invoice may update the Unit Cost on the shipment receipt. This will always occur when a purchase order is not involved. This will also occur when the last unit cost used is different from the Unit Cost on the PO.

## Cause

Costs are recorded by receipt with typically one record for each receipt in the Inventory Purchase Receipts Work (IV10200) table. Since only one receipt record exists, only one cost can exist for each receipt. Because a single cost exists, that cost will be updated when a new cost becomes available. A new cost becomes available when a second invoice is matched to the shipment. See the More Information section for an example.

Another way a new cost can become available is if the Adjust Cost Utility is used to change the cost on the receipt prior to the invoice being matched.

## Resolution

This functionality is working as designed. As a rule the unit cost used for the last invoice will update the whole receipt layer affecting all of the quantities. The exception to this is if the unit cost of the first invoice was different from the PO, but the unit cost on the second invoice was the same as the PO. Then the whole receipt layer will stay with the unit cost that was used for the first invoice. This is because there was not a cost variance between the shipment (PO) cost and the second invoice's cost.

Entering multiple invoices will never be able to record costs of $250.00and$0.00, only $250.00or$0.00. If you would like to see each of the invoice's costs used, then multiple shipments would need to be entered so that each invoice can be matched to its own shipment.

If it is a situation where you are not being invoiced for the remaining quantity, then use the Edit Purchase Order Status window to change the status of the purchase order (PO) to **Closed** rather than invoicing the remaining quantity. This will allow the receipt layer to be revalued based on what you did invoice. To navigate to the Edit Purchase Order Status window on the **Transactions** menu, point to **Purchasing**, and then select **Edit Purchase Orders**.

## More information

Here is an example of how entering more than 1 invoice to a single shipment can occur and what you would see in the application from a cost perspective when it does occur.

1. On the **Transactions** menu, point to **Purchasing**, and then select **Purchase Order Entry** to enter a PO for quantity 100 at $250 unit cost.

2. On the **Transactions** menu, point to **Purchasing**, and then select **Receivings Transaction Entry**. Enter a shipment receipt for a quantity of 100 and a $250 unit cost. Post to create a receipt line with a unit cost of $250.

3. On the **Transactions** menu, point to **Purchasing**, and then select **Enter/Match Invoices**. Enter an invoice to match to the shipment for a partial quantity of 70 at a unit cost of $280. Post.

4. At this point the unit cost value of that receipt line with quantity of 100 is $280.  To review this information, open the Purchase Receipts Inquiry. To do this, on the **Inquiry** menu, point to **Inventory**, and then select **Receipts**.

5. Due to an arrangement with your vendor, you will not be invoiced for the remaining 30 items so you decide to enter in another invoice for $0. On the **Transactions** menu point to **Purchasing**, and then select **Enter/Match Invoices**. Enter an invoice to match to the shipment for the remaining quantity of 30 at a unit cost of $0. Post.

    > [!NOTE]
    > Starting on Microsoft Dynamics GP 2010 SP3, you will receive the following message when you tab off the Unit Cost field and it differs from the cost used for the PO's shipment. This is to alert you of what will be happening to the full receipt quantity. (This warning does not apply to items with an Average Perpetual valuation method.)  
    > **The cost of the invoice does not match the purchase receipt cost. Posting updates the total quantity of the purchase receipt with this cost and your inventory and general ledger will not balance. Do you want to continue?**

6. The cost of the receipt line with quantity of 100 is now $0.

> [!NOTE]
> The value of this item in the inventory module and on the Historical Inventory Trial Balance (HITB) report is $0. However the inventory account in General Ledger will have the $19,600 (70 x $280) balance from the first shipment. A journal entry in General Ledger can be posted to credit the balance in the inventory account in order to tie General Ledger to Inventory. Or, if you want the unit cost to be $196 ($19,600 \ 100), then use the Adjust Cost Utility to change the cost on that receipt from $0 to $196 and do not post the automatic adjustment that is created through General Ledger.
