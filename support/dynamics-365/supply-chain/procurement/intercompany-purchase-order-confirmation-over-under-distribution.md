---
title: Intercompany Purchase Order Accounting Distribution Error
description: Intercompany purchase order confirmation can fail after price synchronization. Learn how to work around stale accounting distributions.
ms.date: 09/21/2026
ms.search.form: PurchTable, BudgetControlConfiguration
audience: Application User
ms.reviewer: shubhamshr, maupadhyaya, sununna
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---

# Intercompany purchase order confirmation fails because accounting distributions are over- or under-distributed

## Summary

When you confirm an intercompany purchase order in Microsoft Dynamics 365 Supply Chain Management, posting can fail with an error that states that one or more accounting distributions is either over-distributed or under-distributed. This error can occur when budget control creates the accounting distribution as the purchase line is entered, and intercompany price synchronization then updates the line with a sales price from a trade agreement. Because the accounting distribution isn't refreshed after the line amount changes, the distribution total no longer matches the purchase line total. To prevent the error on new orders, disable budget control for purchase orders before you create or recreate the intercompany order. To correct an order that already fails, reset its accounting distributions, and then confirm the order again.

## Symptoms

When you confirm an intercompany purchase order, posting fails and you receive the following error message:

> Posting
>
> Purchase order: 000041 One or more accounting distributions is either over-distributed, under-distributed. You must update the accounting distributions before you can journalize the source document.

This issue can occur when all the following conditions are met:

- [Budget control](/dynamics365/finance/budgeting/budget-control-overview-configuration) is enabled for purchase orders in the purchasing legal entity.
- **Check at line entry** is enabled for purchase orders on the **Documents and journals** tab of the active budget control configuration. With this setting, the system runs the budget check and creates an accounting distribution for a line as the line is entered.
- Intercompany price and discount search is enabled, so prices and discounts are [synchronized between the intercompany sales order and the intercompany purchase order](/dynamics365/supply-chain/sales-marketing/intercompany-sync-prices-discounts).
- An active sales price [trade agreement](/dynamics365/supply-chain/sales-marketing/tasks/create-new-trade-agreement) applies to the item and the intercompany customer or customer price group in the selling legal entity.

For example, you can reproduce the issue by using an active sales price trade agreement in USMF for item D0001 and customer price group 09, with a sales price of 10.00 USD per each.

## Cause

The sales price trade agreement supplies the price when the intercompany price search runs. The trade agreement itself isn't invalid and doesn't cause the accounting distribution error.

When you create the purchase line, budget control checks the line and creates its accounting distribution. Intercompany price synchronization then updates the purchase line with the sales price from the trade agreement. However, the accounting distribution isn't refreshed after the line amount changes.

During purchase order confirmation, the accounting distribution total no longer matches the current purchase line total. Therefore, distribution validation fails and displays the error.

## Workaround

> [!IMPORTANT]
> Disabling budget control for purchase orders changes financial-control enforcement for all affected users and transactions in the legal entity. Review the change with the team that owns your budget control configuration before you apply it.

For new intercompany purchase orders - Disable budget control for purchase orders before you create or recreate the intercompany order.

For an existing affected purchase order, follow these steps:

1. Open the affected purchase order.
1. Select **Financials** > **Maintain accounting distributions**.
1. Select **Reset** > **Reset all distributions**.
1. Confirm the purchase order again.

For non-intercompany scenarios or other causes of the same error, see [Accounting distributions are either over- or under-distributed](over-under-distribution.md).

## Related content

- [Workflow approval fails with the "Accounting distribution validation failed" error](po-workflow-accounting-distribution.md)
- [You can only complete a purchase order action for fully distributed line numbers](action-requires-full-distribution.md)
- [Set up intercompany trade](/dynamics365/supply-chain/sales-marketing/intercompany-trade-set-up)
- [Create a purchase order that is governed by a budget](/dynamics365/supply-chain/procurement/tasks/create-purchase-order-governed-by-budget)
- [Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation)

