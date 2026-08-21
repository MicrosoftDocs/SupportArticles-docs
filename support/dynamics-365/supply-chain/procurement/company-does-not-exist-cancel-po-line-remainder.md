---
title: '"The Company Does Not Exist" Canceling a Purchase Order Line'
description: Fix the "The company does not exist" error when you cancel a purchase order line remainder in Supply Chain Management. Learn how to disconnect the intercompany link.
ms.date: 08/20/2026
ms.search.form: PurchTable, IntercompanyBreakLink
ms.reviewer: kamaybac, sugaur
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.30
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---
# "The company does not exist" error when canceling a purchase order line remainder

## Summary

When you cancel the delivery remainder on a purchase order line in Microsoft Dynamics 365 Supply Chain Management, the operation can fail with the error "The company does not exist." The purchase order still holds an intercompany relationship but the company reference is incomplete, so you can't synchronize the change to the linked intercompany sales order. This article explains how to confirm that the incomplete intercompany link is the cause and how to use the **Disconnect intercompany orders** periodic task to remove it so the cancellation succeeds.

## Symptoms

When you try to cancel the delivery remainder on a purchase order line, the operation fails with the following error message:

> The company does not exist.

## Cause

The purchase order retains an intercompany relationship, but the intercompany company reference is incomplete. When you cancel the delivery remainder, Supply Chain Management attempts to synchronize the line change to the linked intercompany sales order through that relationship. The synchronization fails because the company context can't be resolved, and the message "The company does not exist" is surfaced.

This condition doesn't mean that the legal entity itself is missing. For background on how linked intercompany orders are created and kept in sync, see [Intercompany orders and return orders](/dynamics365/supply-chain/sales-marketing/intercompany-orders-and-return-orders) and [Change intercompany orders](/dynamics365/supply-chain/sales-marketing/intercompany-change-orders).

## Solution

Before you make any change, verify the following conditions:

- The purchase order was created as part of an intercompany order chain, and a linked intercompany sales order exists in the other legal entity.
- The error occurs specifically when you cancel a line's delivery remainder.

If those conditions don't apply, don't use this solution. Instead, [contact Microsoft Support](/power-platform/admin/get-help-support) to investigate the generic error.

If the conditions apply, and the intercompany relationship is no longer operationally required, use the supported intercompany disconnection process to remove the incomplete link. Disconnecting removes the intercompany synchronization link between the selected purchase order and its linked intercompany sales order. Review the following points before you continue:

- Neither order is deleted. Both the purchase order and the linked sales order remain in the system, and each one becomes an independent, standard order.
- Changes that you make afterward don't synchronize through that relationship unless a valid link is established again.
- Review both orders and any downstream integration or reporting that depends on the intercompany link before you disconnect them.

Follow these steps to disconnect:

1. Go to **Procurement and sourcing** > **Periodic tasks** > **Disconnect intercompany orders**.
1. Enter the affected purchase order number.
1. Select **Disconnect**.
1. Return to the purchase order and cancel the delivery remainder again.

> [!IMPORTANT]
> If the intercompany relationship is still required, or the page doesn't allow the order to be disconnected in its current state, stop and [contact Microsoft Support](/power-platform/admin/get-help-support). Don't update intercompany fields directly in the database.

## Related content

- [Intercompany orders and return orders](/dynamics365/supply-chain/sales-marketing/intercompany-orders-and-return-orders)
- [Creating intercompany purchase and sales orders in several companies](/dynamics365/supply-chain/sales-marketing/intercompany-orders-in-several-companies)
- [Approve and confirm purchase orders](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation)
