---
title: Resolve Load and Container Weight Errors
description: Learn how to resolve load weight mismatches, positive load weight errors, and container gross weight errors in Dynamics 365 Supply Chain Management.
ms.date: 10/30/2026
ai-usage: ai-assisted
ms.search.form: WHSShipmentDetails_WHSShipConfirm, WHSContainerCloseDiag_canClose
audience: Application User
ms.reviewer: kamaybac, mirzaab
ms.search.region: Global
ms.search.validFrom: 2021-05-15
ms.dyn365.ops.version: 10.0.18
ms.custom: sap:Warehouse management
---

# Troubleshoot load and container weight errors

## Summary

This article helps you resolve load and container weight errors in Dynamics 365 Supply Chain Management. It covers mismatches between load and load-line weights, load weight errors when open work exists, and weight errors when you close a container.

The load-related solutions use **Warehouse load weight consistency check** to recalculate weights. The container solution explains how to enter a positive **Gross weight** and select a unit, or use **Get system weight** to calculate the value. Select the section that matches your error message.

- [Load line and load weight mismatch](#load-line-and-load-weight-mismatch)
- [Load weight must be positive](#load-weight-must-be-positive)
- [Container weight must be positive](#container-weight-must-be-positive)

## Load line and load weight mismatch

Error code: `WHSLoadWeightOnLinesDoNotMatchLoadWarning`

### Symptoms

The system shows the following error message:

> The weight fields on load lines do not match the weight fields on load %1. Run the Warehouse load weight consistency check to recalculate the weight fields.

### Cause

The **Net weight** and **Tara weight** fields on the load line are set to **0** (zero), but the product's weight measurements aren't zero. With these load-line weights at zero, correcting the load-line quantity might cause an incorrect load weight calculation.

This mismatch might occur if the product weights changed after the load line was created.

### Solution

By default, the system copies the product's weight values when it creates a load line. If the load-line weight is zero, run **Warehouse load weight consistency check** to recalculate the weights.

1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
2. In the **Consistency check** dialog box, set the **Module** field to **Warehouse management**.
3. Set the **Check/Fix** field to **Fix error**.
4. In the checkbox list, select the **Warehouse load weight consistency check** checkbox, and make sure that only the row for this checkbox is highlighted.
5. At the top of the checkbox list, select the ellipsis (**...**), and then select **Dialog**.
6. In the **Warehouse load weight consistency check** dialog box, set the following fields:

   - **Load ID**. Enter a load ID. Leave this field blank to check all load IDs.
   - **Item number**. Enter an item number. Leave this field blank to check all items.
   - **Always recalculate weight on loads**. Set this option to **Yes**.
   - **Allow overwrite of weight on load lines**. Set this option to **Yes**.

7. Select **OK** to close the **Warehouse load weight consistency check** dialog box.
8. Select the ellipsis (**...**), and then select **Execute**.

The system recalculates the weights for the loads and items that match your filters. Select **Message details** to view the consistency-check results.

## Load weight must be positive

### Symptoms

If there's open work when you process work from packing locations to staging locations, or from staging to docking locations, you might receive the following error message:

> Field 'Load weight'(=-%1) can only contain positive numbers. Update has been canceled.

### Solution

Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**. Follow the [consistency-check procedure](#solution) to run **Warehouse load weight consistency check**. Use its **Load ID** and **Item number** filters to limit the scope.

## Container weight must be positive

Error code: `WeightMustBePositive`

### Symptoms

When you [close a container](/dynamics365/supply-chain/warehousing/packing-containers), you might receive the following error message:

> Weight must be positive.

### Cause

The **Gross weight** field is set to zero or a negative value.

### Solution

Enter a positive value in the **Gross weight** field, and select a unit. Alternatively, select **Get system weight** to calculate the value.

## Related content

- [Plan loads and shipments by using the outbound load planning workbench](/dynamics365/supply-chain/transportation/use-load-planning-workbench-plan-loads-shipments)
