---
title: Can't Reduce Product Receipt Quantity Below Invoiced Quantity
description: Product receipt corrections in Supply Chain Management can't reduce the received quantity below the invoiced quantity. Learn why and get workarounds.
ms.reviewer: kamaybac, shubhamshr, gargvatsal
ms.search.form: VendPackingSlipJournal, PurchTable
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 08/18/2026
ai-usage: ai-assisted
---

# Can't reduce a product receipt quantity below the invoiced quantity

## Summary

Dynamics 365 Supply Chain Management blocks a product receipt correction that reduces the received quantity below the quantity already matched to a posted vendor invoice. This restriction is by design. To lower the received quantity, reverse or credit the vendor invoice first, or use a return order to send back the excess quantity.

## Symptoms

When you [correct a product receipt](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders#auto-posting-product-receipts) to reduce the received quantity, you receive an error message that resembles one of the following:

> The quantity can't be reduced because the quantity \<X\> is already matched to invoice \<InvoiceNumber\>.

> The corrected quantity \<X\> can't be less than the invoiced quantity \<Y\>.

The correction is blocked even though the received quantity on the product receipt appears to be incorrect.

## Cause

This behavior is by design. Dynamics 365 Supply Chain Management prevents you from reducing the received quantity on a product receipt below the quantity that has already been [matched to and posted on a vendor invoice](/dynamics365/finance/accounts-payable/accounts-payable-invoice-matching). This restriction protects financial integrity by ensuring that:

- An invoice can't reference more units than were received.
- Reducing the receipt quantity below the invoiced quantity would create an inconsistency in the [accrued liability](/dynamics365/finance/general-ledger/purchase-order-posting) and inventory valuation.

For example, if a product receipt was posted for quantity 10, and a vendor invoice has already been matched and posted for quantity 8, the minimum you can correct the receipt to is 8.

## Workarounds

Because this is by-design behavior, you can't directly reduce the product receipt quantity below the invoiced quantity. Use one of the following approaches, depending on your scenario.

### The invoice was posted in error

If the vendor invoice was matched and posted incorrectly, reverse or credit the invoice first, and then correct the product receipt.

1. Go to **Accounts payable** > **Invoices** > **Open vendor invoices**, or open the relevant posted vendor invoice from the **Invoice journal** page.
1. Locate the posted invoice, and then do one of the following:

    - If the entire invoice is wrong, use the **Reverse** action to reverse the invoice posting.
    - If only part of the invoiced quantity or amount is wrong, create a [vendor credit note](/dynamics365/supply-chain/procurement/tasks/create-purchase-return-order#create-a-new-return-po) for the difference.

1. After the invoiced quantity is reduced, correct the product receipt.

### The receipt quantity was posted in error, but the invoice is correct

If the product receipt quantity was posted in error and the invoice quantity is correct, no correction is needed. The received quantity should remain at or above the invoiced quantity. Review the original receipt and invoice documents to confirm the expected quantities.

### More units were received than invoiced

If you received more units than you were invoiced for and want to return the excess quantity, use a return order or post a new corrected product receipt for the returned quantity instead of reducing the already-invoiced lines.

1. Go to **Procurement and sourcing** > **Purchase orders** > **All purchase orders**.
1. On the Action Pane, select **New** > **Return order**.

Alternatively, contact the vendor to issue a credit note for the excess quantity.

> [!NOTE]
> The **Correct** action on a product receipt journal reduces the original receipt and creates a reversal entry. It can't reduce the quantity below the matched invoice quantity. The **Cancel** action cancels the entire product receipt line and is only available when no invoice is matched to that receipt line.

## More information

- [Product receipt against purchase orders](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
- [Vendor invoices overview](/dynamics365/finance/accounts-payable/vendor-invoices-overview)
- [Create a purchase return order](/dynamics365/supply-chain/procurement/tasks/create-purchase-return-order)
