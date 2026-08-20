---
title: Product Receipt Posting Fails with Draft State Error
description: Fix product receipt posting errors that fail with a draft state error when change management is active on a purchase order. Learn the cause and resolution.
ms.date: 08/18/2026
ms.search.form: PurchTable, PurchParameters
ms.reviewer: kamaybac, gargvatsal, shubhamshr
ms.search.region: Global
ms.search.validFrom: 2026-02-25
ms.dyn365.ops.version: 10.0.46
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---
# Product receipt posting fails with the "only allowed in state draft" error

## Summary

When change management is active on a purchase order, posting a product receipt can fail with a draft state error because the system recalculates totals, tax, or accounting distributions during posting. This article explains why the validation fails in Microsoft Dynamics 365 Supply Chain Management and how to recalculate the totals in *Draft* status so that the product receipt posts successfully.

## Symptoms

When you try to post a [product receipt](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders) for a confirmed purchase order, the following error occurs:

> Posting changes to the document are only allowed in state draft because change management is active.

## Cause

During product receipt posting, if the system detects a change in totals, tax, or accounting distributions, it attempts to update the purchase order. This recalculation triggers a document change on the purchase order. When [change management](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#changing-purchase-orders) is active, any document change requires the purchase order to be in *Draft* status. Since the purchase order is in *Confirmed* status during product receipt posting, the validation fails with a draft-state error.

## Solution

To resolve the issue for purchase orders that are currently failing, follow these steps:

1. Open the affected purchase order.
1. Select **Request change** to move the purchase order to draft state.
1. Go to **Purchase order** tab > **View** section, and select **Totals** to recalculate and update the tax and accounting distributions while the purchase order is in draft state.
1. Submit the purchase order to the workflow and approve it.
1. Confirm the purchase order.
1. Post the product receipt.

By recalculating totals while the purchase order is in *Draft* status, the system no longer needs to trigger a recalculation during product receipt posting, and the draft-state validation error is avoided.

## Related content

- [Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation)
- [Record the receipt of goods (product receipt against purchase orders)](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
- [Accounting distributions](/dynamics365/finance/accounts-payable/accounting-distributions)
- [Workflow approval fails with the Accounting distribution validation failed error](po-workflow-accounting-distribution.md)
