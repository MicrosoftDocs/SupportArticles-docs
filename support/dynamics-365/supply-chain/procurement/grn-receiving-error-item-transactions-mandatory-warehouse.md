---
title: Mandatory Warehouse Error When You Post a Product Receipt
description: Fix the mandatory warehouse error that blocks a product receipt in Dynamics 365 Supply Chain Management by correcting the warehouse on the purchase order line.
ms.reviewer: kamaybac, gargvatsal, shubhamshr
ms.search.form: PurchTable, PurchEditLines, InventItemOrderSetup, EcoResStorageDimensionGroup
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 08/18/2026
ai-usage: ai-assisted
---

# "Enter the mandatory warehouse" error when you post a product receipt (GRN)

## Summary

When you post a product receipt, also known as a goods receipt note (GRN), against a purchase order (PO) in Dynamics 365 Supply Chain Management, the posting can fail with an error that names a mandatory warehouse. The error occurs when the warehouse on the PO line differs from the warehouse that the item's storage dimension group or default order settings require. This article shows how to find the required warehouse, correct the PO line so that the receipt posts, and check whether the item setup also needs to change.

## Symptoms

When you post a [product receipt (GRN)](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders) for a purchase order (PO), you receive an error message that resembles the following:

> Item transactions for item \<ItemNumber\> must be for warehouse \<Warehouse\>. Enter the mandatory warehouse.

The error blocks the product receipt from posting. The warehouse named in the error message is the warehouse that the item's configuration requires. It isn't the warehouse that's currently on the PO line.

## Cause

The item is configured with a mandatory warehouse in either its storage dimension group or its default order settings. When a warehouse is mandatory for an item, every inventory transaction, including product receipts, must use that warehouse. The PO line specifies a different warehouse than the one that's configured as mandatory, which causes the validation to fail.

The mismatch typically occurs because:

- The PO was created manually or copied from another order with a warehouse that doesn't match the item's mandatory warehouse.
- The item's default order settings or storage dimension group was updated after the PO was created.
- The receiving warehouse on the PO line was manually changed to a warehouse that isn't the mandatory warehouse for the item.

## Update the warehouse on the purchase order line

The quickest resolution is to update the warehouse on the PO line to match the mandatory warehouse before posting the product receipt.

1. Go to **Procurement and sourcing** \> **Purchase orders** \> **All purchase orders**.
1. Open the affected purchase order.
1. On the **Purchase order lines** FastTab, select the line that has the error.
1. On the **Line details** FastTab, select the **Product** tab.
1. In the **Warehouse** field, enter the warehouse that the error message specifies.
1. Save the change, and then post the product receipt.

> [!NOTE]
> If the PO line is already partially received, or if it has a confirmed receipt date, you might not be able to change the warehouse directly. In that case, review the item's mandatory warehouse configuration.

## Review the item's mandatory warehouse configuration

If the mandatory warehouse configuration on the item is incorrect or needs to be updated, review the item's default order settings and storage dimension group.

### Check the default order settings

1. Go to **Product information management** \> **Products** \> **Released products**.
1. Open the affected item.
1. On the Action Pane, on the **Manage inventory** tab, in the **Order settings** group, select **Default order settings**.
1. On the **Purchase order** FastTab, check the **Warehouse** field. This field is the default warehouse for purchase transactions.
1. Select **Site-specific order settings** to review any site-specific warehouse overrides.
1. If the warehouse shown doesn't match your receiving warehouse, update it to reflect the correct warehouse for the item's procurement process.

### Check the storage dimension group

1. On the released product page, on the **Product** FastTab, note the value in the **Storage dimension group** field.
1. Go to **Product information management** \> **Setup** \> **Dimension and variant groups** \> **Storage dimension groups**.
1. Open the storage dimension group for the item.
1. On the **Storage dimensions** FastTab, select the **Warehouse** row, and then review these options:

   - **Active**. When you select this option, the system tracks the warehouse for the items in the group.
   - **Blank receipt allowed** and **Blank issue allowed**. When you clear these options, the system requires a warehouse value to receive or issue the item.

1. If the warehouse is required and you need to change that setup, work with your system administrator.

> [!IMPORTANT]
> A storage dimension group applies to every item that you assign to it. Changing it affects inventory tracking, costing, and warehouse management for all of those items.

## Related content

- [Product receipt against purchase orders](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
- [Default order settings for dimensions and product variants](/dynamics365/supply-chain/production-control/default-order-settings)
