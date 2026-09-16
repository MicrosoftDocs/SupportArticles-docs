---
title: Intercompany purchase order confirmation fails because accounting distributions are over- or under-distributed
description: Provides a workaround for an intercompany purchase order confirmation error that occurs when budget control creates accounting distributions before the final intercompany price is synchronized.
author: Shubhs93
ms.date: 09/16/2026
ms.search.form: PurchTable, BudgetControlConfiguration
audience: Application User
ms.reviewer: shubhamshr
ms.search.region: Global
ms.author: shubhamshr
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Intercompany purchase order confirmation fails because accounting distributions are over- or under-distributed

This article provides a workaround for an accounting distribution error that can occur when you confirm an intercompany purchase order in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

When you confirm an intercompany purchase order, confirmation fails and you receive the following error message:

> One or more accounting distributions is either over-distributed or under-distributed.

This issue can occur when all the following conditions are met:

- Budget control is enabled for purchase orders in the purchasing legal entity.
- **Check at line entry** is enabled for purchase orders in the active budget control configuration.
- Intercompany price and discount search is enabled.
- The purchase line is initially created with a zero or blank price, and a nonzero price is synchronized later from the intercompany sales order.

## Cause

When the purchase line is created, budget control checks the line and creates its accounting distribution based on the initial zero or blank amount. Intercompany price synchronization then updates the purchase line with the final sales price. However, the accounting distribution isn't refreshed after the line amount changes.

During purchase order confirmation, the accounting distribution total no longer matches the current purchase line total. Therefore, distribution validation fails and displays the error.

## Workaround

> [!IMPORTANT]
> Disabling budget control for purchase orders changes financial-control enforcement for all affected users and transactions in the legal entity. Review and approve this temporary configuration change with your finance or budget-control administrator before you apply it.

To prevent the issue, temporarily exclude purchase orders from budget control before you create the intercompany order:

1. Switch to the purchasing legal entity.
1. Go to **Budgeting** > **Setup** > **Budget control** > **Budget control configuration**.
1. Select **Create draft** to create an editable version of the active configuration.
1. Select **Documents and journals**.
1. For **Purchase orders**, clear **Check at line entry**, and then clear **Include in budget control**.
1. Activate the draft budget control configuration.
1. Create the intercompany order again, and then confirm the intercompany purchase order.
1. After completing the affected transaction, restore and activate the organization's approved budget control configuration.

Disabling budget control after the affected purchase order line has already been created doesn't recalculate its existing accounting distribution. For an existing affected order, use one of the following options:

- Open **Accounting distributions** for the affected purchase order line so that the distribution is refreshed, and then confirm the purchase order again.
- Recreate the intercompany order after purchase orders have been temporarily excluded from budget control.

For non-intercompany scenarios or other causes of the same error, see [Accounting distributions are either over- or under-distributed](over-under-distribution.md).
