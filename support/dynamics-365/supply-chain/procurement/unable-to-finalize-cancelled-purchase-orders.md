---
title: Canceled Purchase Orders Can't Be Finalized
description: Learn why canceled purchase orders can't be finalized when the source document header stays "In process", and follow the steps to fix the error.
ms.date: 08/18/2026
ms.search.form: PurchTable, SourceDocumentHeader
ms.reviewer: kamaybac, gargvatsal, shubhamshr
ms.search.region: Global
ms.search.validFrom: 2026-05-07
ms.dyn365.ops.version: 10.0.46
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---
# Canceled purchase orders can't be finalized when the source document header is "In process"

## Summary

Finalizing a canceled purchase order fails when the source document header stays in the **In process** status instead of moving to **Completed**. This article explains why the source document header status gets stuck in Microsoft Dynamics 365 Supply Chain Management, and how to reprocess the accounting distributions so that the purchase order finalizes.

## Symptoms

When you try to finalize a purchase order that has a status of **Canceled** and an approval status of **Confirmed**, the following error occurs:

> Purchase order \<OrderNumber\> was not finalized. Source document header has status In process.

When you review the [accounting distributions](/dynamics365/finance/accounts-payable/accounting-distributions) for the purchase order, the source document status is **In process** instead of **Completed**.

## Cause

When you cancel a purchase order, the source document header can fail to transition to a final state and remains stuck in an **In process** status. This behavior creates a data inconsistency: the purchase order is canceled, but the underlying source document isn't in a completed state. Because finalization requires a completed source document header, the operation fails.

## Solution

To resolve the issue for affected purchase orders, follow these steps:

1. Open the affected purchase order.
1. On the **Purchase order** tab, select **Request change** to move the purchase order back to draft state.
1. Submit the purchase order to the workflow and get it approved.
1. Select **Confirm** to [confirm the purchase order](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#confirming-purchase-orders).
1. Select **Finalize** to finalize the purchase order.

These steps cause the system to reprocess the accounting distributions and update the source document header to a completed state, which lets finalization complete.

> [!NOTE]
> If the purchase order workflow requires specific approvers, ensure that the required approvers are available or that you're a member of the required approver groups before submitting the workflow.

## Related content

- [Source document lines cannot be finalized until the status is Confirmed](source-document-lines-cannot-be-finalized.md)
- [Canceled purchase orders appear in the draft list in the workspace](canceled-po-in-draft-list.md)
- [Workflow approval fails with the Accounting distribution validation failed error](po-workflow-accounting-distribution.md)
- [Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation)
