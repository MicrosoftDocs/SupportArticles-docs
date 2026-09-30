---
title: Intercompany purchase invoice has a cross-currency rounding variance
description: Explains why cross-currency intercompany orders can produce an inventory value variance and how to reduce unit-price rounding.
ms.date: 09/30/2026
ms.search.form: PurchTable, SalesTable
ms.reviewer: Shubhs93
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---

# Intercompany purchase invoice has a cross-currency rounding variance

## Summary

When linked intercompany sales and purchase orders use different currencies, the converted unit price is rounded in the purchase order currency. The rounding difference can accumulate across the invoiced quantity and cause the inventory financial value to differ from the vendor invoice liability. This article explains how to identify this expected rounding mechanism, distinguish it from a vendor-to-ledger reconciliation issue, and reduce the variance on future transactions.

## Symptoms

You might observe the following behavior in an intercompany order chain:

- The intercompany sales order and purchase order use different currencies.
- The purchase order contains a converted and rounded unit price.
- The vendor invoice liability differs slightly from the original inventory value.
- The voucher contains a **Purchase expenditure for product** amount that balances the inventory value to the vendor liability.
- The difference becomes larger when the order has a large quantity or several lines.

The vendor-to-ledger reconciliation report might also show a difference for the same voucher. However, that result isn't explained by the inventory rounding variance. For more information, see the [Separate vendor-to-ledger differences](#separate-vendor-to-ledger-differences) section.

## Cause

During intercompany line synchronization, the source unit price is converted to the target order currency. The converted price is then rounded to the currency precision that applies to the target order. The price unit is transferred with the price.

When the price unit is `1`, rounding occurs at the individual unit-price level. The small difference between the calculated price and the stored rounded price is multiplied by the invoiced quantity. If the invoice amount is converted back to the accounting currency, the accumulated difference appears as a variance between the inventory value and the vendor liability.

This result doesn't require different exchange rates. It can occur when both calculations use the same rate because the target unit price is rounded as an intermediate value.

### Example

Consider an intercompany line with the following values:

- Source unit price: `80.0809 CNY`
- Exchange rate: `1 CNY = 0.1468235 USD`
- Target currency precision: Two decimals
- Price unit: `1`

The converted unit price is calculated as follows:

`80.0809 CNY x 0.1468235 = 11.757758 USD`

The target order stores the price as `11.76 USD`. The difference is only about `0.002242 USD` for each unit, but it accumulates as the quantity increases. For a quantity of `1,000`, the difference is about `2.242 USD` before any conversion back to the accounting currency.

An apparent exchange rate that you calculate by dividing the final accounting-currency inventory value by the invoice currency amount can therefore differ from the configured exchange rate. That ratio includes the accumulated unit-price rounding and isn't evidence of a second exchange rate by itself.

## Diagnose the variance

Follow these steps to confirm that unit-price rounding explains the variance:

1. Open the linked intercompany sales order and purchase order.
1. Record the currency, unit price, price unit, quantity, and line amount for each linked line.
1. Identify the exchange rate that was effective when the intercompany line price was synchronized.
1. Calculate the unrounded target-currency price, and compare it with the price stored on the linked order line.
1. Multiply the unit-price difference by the invoiced quantity. Convert the result to the accounting currency if necessary.
1. Compare the calculated difference with the inventory financial value, vendor liability, and **Purchase expenditure for product** posting on the voucher.

If the calculated difference matches the voucher variance, the result is caused by intermediate unit-price rounding.

## Reduce rounding on future transactions

Use a larger price unit to preserve more precision when the business price has more decimal places than the target currency supports. For example, instead of representing the price as `80.0809 CNY` per `1`, represent the same economic price as `80,080.90 CNY` per `1,000`. The converted target price can then retain more precision when it's divided by the price unit.

Before you post the transaction:

1. Set an appropriate price unit on the originating order, trade agreement, or other price source.
1. Allow the price and price unit to synchronize to the linked intercompany order.
1. Verify the effective unit price and line amount on both orders.
1. Confirm that the price unit is valid for the item unit and your organization's pricing policy.

The appropriate price unit depends on the required precision and transaction volume. Test the setup in a nonproduction environment before you apply it to live transactions.

## Handle an existing posted transaction

If the voucher is balanced and the difference matches the calculated unit-price rounding, review the variance with your accounting team. You can retain the posting if the amount is acceptable under your accounting policy.

If the transaction must be corrected, reverse or credit the posted document by using the supported application process, adjust the price unit or price, and then post it again. Don't update intercompany, inventory, vendor, or ledger tables directly in the database.

## Separate vendor-to-ledger differences

The inventory variance and a vendor-to-ledger reconciliation difference are separate conditions:

- An inventory variance can be balanced in the general ledger by a **Purchase expenditure for product** posting.
- A vendor-to-ledger difference occurs when the accounting-currency amount on the vendor transaction doesn't match the vendor balance posting in the general ledger.

Changing the price unit or running inventory closing doesn't correct an existing vendor-to-ledger difference. If the vendor-to-ledger reconciliation report shows a nonzero difference, collect the legal entity, voucher, invoice, accounting date, currencies, exchange rate, line prices, price units, vendor transaction amount, and vendor balance ledger amount. Then [contact Microsoft Support](/power-platform/admin/get-help-support) for a supported investigation and correction plan.

## Related content

- [Intercompany orders and return orders](/dynamics365/supply-chain/sales-marketing/intercompany-orders-and-return-orders)
- [Create intercompany purchase and sales orders in several companies](/dynamics365/supply-chain/sales-marketing/intercompany-orders-in-several-companies)
- [Vendor invoices overview](/dynamics365/finance/accounts-payable/vendor-invoices-overview)
