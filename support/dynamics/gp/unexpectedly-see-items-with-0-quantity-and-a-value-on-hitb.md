---
title: Items have 0 quantity but a value on HITB
description: One or more items that have 0 in the Quantity field but do have an amount in the Value field on the Historical Inventory Trial Balance in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Inventory
---
# You unexpectedly see items with 0 quantity and with a value on the Historical Inventory Trial Balance in Microsoft Dynamics GP

This article provides a resolution for the issue that you may have one or more items that have 0 in the Quantity field but do have an amount in the Value field on the Historical Inventory Trial Balance report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2019828

## Symptoms

When you print the Historical Inventory Trial Balance (HITB) report, you have one or more items that have 0 in the Quantity field but do have an amount in the Value field.

To print the HITB report, on the **Reports** menu point to **Inventory**, and then select **Activity**. From the Reports drop-down list, select **Historical IV Trial Balance**.

## Cause

An item can have 0 quantity but a remaining value if it's an item that is set up with an Average Perpetual valuation method. Using this method an item is brought into Inventory at the actual cost, however when it's sold it goes out of inventory at the average cost. If costs fluctuate, there's the potential that when you have sold all of your quantities that a value will still remain.

Here's an example of how this behavior would happen.

1. Create an item with an Average Perpetual valuation method.
2. Enter and post the following increase adjustments for the same item using the same date.

    5 @ $35 = total cost of $175  
    10 @ $20 = total cost of $200  
    22 @ $23 = total cost of $506

    At this point, the HITB report would show that you have Quantity of 37 and Value of $881.

3. The next day sell all 37 of the item. These would be sold at the average cost of $23.81 each for a total of $880.97.
When you print the HITB report, you'll see Quantity of 0 and Value of $0.03.

4. If you review the value of the inventory account in General Ledger, you'll see there's also a $0.03 value related to this item there as well. This is because step 2 debited Inventory for $881 and step 3 credited Inventory for $880.97.

## Resolution

This issue is an expected behavior since the function of the HITB report is to be used to tie out the value in the inventory module to the inventory account in GL.

It's the nature of the Average Perpetual valuation method to bring items in at one cost and sell them at another. This isn't something new that is happening, however, the HITB report provides more visibility to how it can happen.

To remove the remaining value from this report, you would need to use the Adjust Cost Utility and change the Unit Cost of every receipt layer to be the same cost. Doing so will revalue any outflow transactions that weren't posted at that new average cost and create cost adjustment transactions for General Ledger.
