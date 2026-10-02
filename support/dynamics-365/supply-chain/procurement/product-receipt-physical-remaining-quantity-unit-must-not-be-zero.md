---
title: Physical Remaining Quantity Error SYS19590 on Product Receipt
description: Resolve error SYS19590 when you post a product receipt and a small deliver remainder in the purchase unit rounds to zero in the inventory unit.
ms.reviewer: kamaybac, sugaur, maupadhyaya
ms.search.form: VendPackingSlipJournal, PurchTable
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 10/02/2026
ai-usage: ai-assisted
---

# Error SYS19590: Physical remaining quantity in the inventory unit can't be zero when you post a product receipt

Error code: SYS19590

## Summary

In Microsoft Dynamics 365 Supply Chain Management, posting a product receipt for a partially received purchase order can fail with error SYS19590. The error occurs when a small deliver remainder in the purchase unit rounds to zero in the inventory unit. This rounding happens when the unit conversion factor is large and the inventory unit has a coarse decimal precision. This article explains the cause and shows how to clear the deliver remainder, receive quantities that convert cleanly, or increase the decimal precision of the inventory unit.

## Symptoms

When you post a product receipt for a purchase order that you receive partially, the posting fails and the system shows the following error message:

> Physical remaining quantity in the inventory unit <Value\> must be other than zero.

In the message, *%1* is the item's inventory unit. The receipt can't be posted, even though the purchase order line and the received quantity appear to be correct.

This issue typically occurs when both of the following conditions are true:

- The item is purchased in a unit that's much smaller than its inventory unit. That is, the unit conversion has a large factor, such as many purchase units per inventory unit.
- A partial receipt leaves a small **Deliver remainder** in the purchase unit that converts to less than the smallest quantity that the inventory unit can represent at its decimal precision.

## Cause

When it posts a product receipt, the system evaluates the deliver remainder in both the purchase (order) unit and the inventory unit, and it requires both remainders to reach zero at the same time.

If the item is purchased in a much smaller unit than it's stocked in, and the inventory unit has a coarse decimal precision, a small remainder in the purchase unit can convert to a value that rounds to zero in the inventory unit. The remainder is then non-zero in the purchase unit but zero in the inventory unit, so the two remainders can't reach zero together, and the receipt is blocked.

For example, suppose that an item's inventory unit is *Roll* with a decimal precision of two decimal places, the item is purchased in *Meter*, and the unit conversion is 1 Roll = 2,087 Meter. If you receive all but 7 Meter of the ordered quantity, the deliver remainder is 7 Meter. Converted to the inventory unit, 7 ÷ 2,087 = 0.00335 Roll, which rounds to 0.00 Roll at two decimal places. The purchase-unit remainder is 7 (non-zero), but the inventory-unit remainder is 0, which triggers the error.

This behavior is a unit-of-measure and decimal-precision interaction. It doesn't indicate damaged or inconsistent data on the purchase order.

> [!NOTE]
> A related validation occurs on the outbound side, during packing slip generation for a load. For that scenario, see [Physical remaining quantity in the unit must not be zero](../warehousing/physical-remaining-quantity-unit-must-other-than-zero.md).

## Solution

Use one of the following approaches, depending on your scenario.

### Clear the deliver remainder when the residual quantity isn't needed

If you don't intend to receive the small residual quantity, close it so that both remainders reach zero:

1. Go to **Procurement and sourcing** > **Purchase orders** > **All purchase orders**, and then open the affected purchase order.
1. On the **Purchase order lines** FastTab, select the line, and then select **Update line** > **Deliver remainder**.
1. Set the **Deliver remainder** to **0** for the line.
1. Post the product receipt again.

### Receive in quantities that convert cleanly

Receive quantities that are whole multiples of the unit conversion factor, so that the purchase-unit remainder maps to a whole inventory unit and no sub-unit remainder is left behind. Review the receipt quantity before you post to make sure that it converts to the inventory unit without a rounding remainder.

### Increase the decimal precision of the inventory unit

Increase the decimal precision of the inventory unit so that the converted remainder can be represented as a non-zero value:

1. Go to **Organization administration** > **Units** > **Units**.
1. Select the item's inventory unit.
1. Increase the value of the **Decimal precision** field as required.

This change applies to future processing. Review the effect of the increased precision on rounding across the item's existing transactions before you change it.

## Related content

- [Product receipt against purchase orders](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
