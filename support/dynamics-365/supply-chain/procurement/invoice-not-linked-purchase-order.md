---
title: Troubleshoot Vendor Invoice Not Linked to Purchase Order
description: Vendor invoice not linked to purchase order in Dynamics 365? Learn why service-item POs stay in Open Order status and how to fix the missing PO reference issue.
ms.reviewer: Shubhs93
ms.date: 05/28/2026
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
---

# Vendor invoice not linked to purchase order

## Summary

This article explains why a vendor invoice might not link to a purchase order (PO) for service-type items in Dynamics 365, leaving the PO in *Open order* status after posting. It describes the correct invoicing method to follow in order to keep the PO link and update status to *Invoiced*.

## Symptoms

After posting a vendor invoice for a purchase order (PO) that contains a **Service** item, the PO stays in *Open Order* status instead of updating to *Invoiced*. The system creates the invoice journal successfully, but it doesn't update the PO to show the *Invoiced* state.

This problem occurs specifically when:

- The PO contains an item of type **Service** (for example, item `S0001`).
- The user skips the **Product Receipt** step (which is valid - service items don't require inventory transactions).
- The user manually adds a line by using **+ Add line** on the Vendor Invoice form instead of using the **Default from** option.

Service-type items are specifically impacted because they bypass the standard product receipt and registration flow. Other item types typically have inventory transactions that help reconcile PO status even in some edge cases.

## Steps to reproduce

1. Create a new purchase order.
1. Add a line with a service-type item (for example, `S0001`, Item type = **Service**).
1. Confirm the purchase order.
1. Go to **Generate** > **Invoice** (skip **Product Receipt**).
1. On the Vendor Invoice form, the Lines grid appears **empty**.
1. Select **+ Add line** and manually enter the same item number and quantity as the purchase order line.
1. Select **Update match status**, and then select **Post**.

**Observed result:** An invoice journal is created, but the purchase order remains in *Open Order* status.  
**Expected result:** The purchase order status updates to *Invoiced*.

## Cause

When you select **+ Add line** on the Vendor Invoice form, you create the new line without a reference to the originating purchase order line (`PurchLine.RecId` / `PurchId`). Because the invoice line has no purchase order link, the system can't update the purchase order's document status after posting. The purchase order's invoiced quantity isn't incremented, so it stays in *Open Order* status.

## Correct procedure

To ensure the invoice links properly to the PO, use the **Default from** option instead of manually adding lines. For background on purchase order creation, see [Create purchase orders](/dynamics365/supply-chain/procurement/purchase-order-creation).

1. Create a new purchase order with an item of type **Service** (for example, `S0001`).
1. Confirm the PO.
1. Go to **Generate** > **Invoice**.
1. On the Vendor Invoice form, select the **Default from:** dropdown in the action bar.
1. Select **Ordered quantity** (or the appropriate default). The invoice lines automatically populate from the PO lines, preserving the PO reference.

      > Other available options: *Receive now quantity*, *Registered quantity*, *Product receipt quantity*, *Registered quantity and services*.
      
1. Select **Update match status**.
1. Select **Post**.

**Result:** The system creates the invoice journal and updates the PO status to *Invoiced*.

## Key difference

| Action | PO Reference Preserved | PO Status Updated |
|---|---|---|
| **+ Add line** (manual) | No | No - stays Open Order |
| **Default from: Ordered quantity** | Yes | Yes - updates to Invoiced |

## Workaround

If you already posted an invoice by using a manually added line (no PO reference), the PO stays in *Open Order* status. To work around the problem:

1. Cancel or reverse the incorrectly posted invoice journal (if your organization's policy allows it).
1. Re-create the invoice by using the **Default from: Ordered quantity** method described earlier.

> [!IMPORTANT]
> Consult your system administrator before canceling posted invoices, as this action might have accounting implications.

## Related content

- [Purchase order overview](/dynamics365/supply-chain/procurement/purchase-order-overview)
- [Vendor invoices overview](/dynamics365/finance/accounts-payable/vendor-invoices-overview)
