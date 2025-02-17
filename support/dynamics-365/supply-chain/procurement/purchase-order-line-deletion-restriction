---
title: Purchase Order Line Deletion Restriction
description : Provides a workaround for the restrictions on deleting purchase order lines under certain conditions in Dynamics 365 Supply Chain Management.
ms.reviewer: shubhamshr
ms.date: 02/17/2025
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orderss
---
# Can't delete a purchase order line after it's confirmed

This article provides a workaround for the restrictions on deleting purchase order lines, specifically after the design change introduced in [Dynamics 365 Supply Chain Management 10.0.33 (May 2023)](/dynamics365/supply-chain/get-started/whats-new-scm-10-0-33).

## Symptoms

You can't delete a purchase order line if the purchase order is currently or was previously confirmed and either of the following settings is applied:

- The purchase order is budget-controlled.
- Encumbrance accounting is enabled.

## Cause

A design change was introduced in Dynamics 365 Supply Chain Management version 10.0.33 to safeguard data integrity by preventing the deletion of purchase order lines.

## Workaround

If you need to remove a purchase order line, the recommended approach is to first [cancel](/dynamics365/supply-chain/procurement/purchase-order-approval-confirmation#canceling-purchase-orders) the line and then finalize it.

To cancel the whole quantity on a purchase order line, you should cancel the delivery remainder quantity on the line. The line will then be updated to **Canceled** status.
