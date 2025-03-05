---
title: Released quantity cannot be negative for item error
description: Solves the released quantity cannot be negative error that occurs when updating or deleting a load line in Dynamics 365 Supply Chain.
author: Mirzaab
ms.date: 03/05/2025
ms.search.form: WHSLoadPlanningListPage_WHSLoadLineUnShipQty,WHSLoadTable_WHSLoadLineUnShipQty,WHSLoadPlanningWorkbench_WHSLoadLineUnShipQty,WHSShipmentDetails_WHSLoadLineUnShipQty,WHSLoadPlanningListPage_DeleteButtonLoadLine,WHSLoadTable_DeleteButtonLoadLine,WHSLoadPlanningWorkbench_DeleteButtonLoadLine,WHSShipmentDetails_DeleteButtonShipment
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: mirzaab
ms.search.validFrom: 2021-06-30
ms.dyn365.ops.version: 10.0.21
ms.custom: sap:Warehouse management
---
# Can't update or delete a load line because the released quantity would be negative

Error code: @WAX:ReleasedQtyCannotBeNegative

## Symptoms

When you try to update or delete a load line, you receive the following error message:

> Released quantity cannot be negative for item \<Item ID>, lot \<Lot ID>.

## Cause

After you update or delete a load line, the system updates the released quantity of the related sales line (*whsSalesLine.ReleaseQty*). If the system finds that the released quantity would become negative after the update, it prevents you from making the change. This validation occurs whenever you try to update either the load line quantity or the [unit of measure](/dynamics365/supply-chain/pim/tasks/manage-unit-measure) through various actions, such as deleting a load line, deleting a shipment, changing the quantity of a load line, reducing the picked quantity, and short picking.

The most common reason for this issue is a change in the [unit conversion](/dynamics365/supply-chain/pim/tasks/manage-unit-measure#define-unit-conversion-rules) used for open load lines. For example, the unit conversion is *50 Ea = 1 PL* when a sales order is released. However, if the unit conversion is changed to *100 Ea = 1 PL* before the related load shipment is finalized, it can cause this problem.

## Resolution

To resolve this issue, take the following steps to revert the unit conversion changes, update or delete the load line, and then re-implement the conversion.

> [!IMPORTANT]
> You must prevent other loads that include the item that caused the issue from being processed until the issue is fixed. Otherwise, the new conversions might be used for other loads that are already open.

1. [Check the unit conversion that was used for the load line](#check-the-unit-conversion-that-was-used-for-the-load-line).
2. [Check the current unit conversion for the item and make adjustments that will enable the load line to be updated or deleted](#check-the-current-unit-conversion-for-the-item-and-make-adjustments).
3. [Update or delete the load line and revert the unit conversion adjustments](#update-or-delete-the-load-line-and-revert-the-unit-conversion-adjustments).

### Check the unit conversion that was used for the load line

Follow these steps to review your load lines and make a note of the unit conversion that was used for the load line:

1. Go to **Warehouse management** > **Loads** > **All loads**.
1. Select the load that includes the load line that can't be deleted or updated.
1. On the Action Pane, on the **Loads** tab, in the **Related information** group, select **Work**.
1. In the upper grid, select the relevant work ID.
1. On the **General** tab at the bottom of the page, calculate the conversion rate between the **Inventory work quantity** value and the **Work quantity** value. Make a note of the rate.
1. Repeat this procedure for all relevant work IDs to make sure that the same conversion was used.

### Check the current unit conversion for the item and make adjustments

Follow these steps to review your product's unit conversion and make adjustments to ensure that the unit conversion is aligned with the load line:

1. Go to **Product information management** > **Products** > **Released products**.
1. Open the relevant product to go to its **Released product details** page.
1. On the Action Pane, on the **Product** tab, in the **Set up** group, select **Unit conversions**.
1. Select the conversion between the units, and make adjustments by using the conversion that you found in the previous section.

### Update or delete the load line and revert the unit conversion adjustments

Follow these steps to process the load line as required and revert the unit conversions:

1. Go to **Warehouse management** > **Loads** > **All loads**.
1. Open the load that includes the load line that can't be deleted or updated.
1. On the **Load lines** FastTab, select the load line and proceed with the necessary actions (for example, delete the load line or change its quantity).
1. Go to **Product information management** > **Products** > **Released products**.
1. Open the relevant product to go to its **Released product details** page.
1. On the Action Pane, on the **Product** tab, in the **Set up** group, select **Unit conversions**.
1. Select the conversion between the units, and revert the adjustments that you made in the previous section.

## Alternative resolution

If reverting unit conversions isn't feasible, follow these steps to manually update *WHSSalesLine.ReleasedQty* (the sales line released quantity) and *WHSSalesLine.QtyLeftToLoad* (the sales line quantity that isn't on a load yet):

1. Go to **Account receivable** > **Orders** > **All sales orders**.
1. Open the sales order that contains the sales line related to the load where the line can't be deleted or updated.
1. On the upper-right side of the **Sales order lines** grid, select the three dots and select **Insert columns** from the dropdown menu.
1. Search for the **Released quantity** and **Quantity left to load** fields, select both, and then select **Update**.

The fields will appear in the **Sales order lines** grid and can be modified to reflect the quantities on the load lines.

## More information

[Sales Line Additional Fields in WorksheetLine(WHSSalesLine)](/common-data-model/schema/core/operationscommon/tables/supplychain/inventory/worksheetline/whssalesline)
