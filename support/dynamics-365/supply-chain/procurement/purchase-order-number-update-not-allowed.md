---
title: '"Updates Not Allowed for PurchaseOrderNumber" PO Import Error'
description: 'Learn how to fix the "Updates not allowed for PurchaseOrderNumber" error when you import Purchase order lines V2 data in Supply Chain Management.'
ms.date: 08/24/2026
ms.search.form: DMFDefinitionGroup, DMFDefinitionGroupExecution, PurchTable
ms.reviewer: kamaybac, sugaur, sununna
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase order creation
ai-usage: ai-assisted
---
# "Updates not allowed for PurchaseOrderNumber" error when you import purchase order lines

## Summary

An import through the **Purchase order lines V2** data entity fails with an "Updates not allowed for PurchaseOrderNumber" error when a row tries to change the purchase order number on an existing purchase order line in Microsoft Dynamics 365 Supply Chain Management. Correct the source key in the import file. If the source key is already correct, run the purchase order consistency check to remove corrupted purchase order lines that have a blank inventory transaction ID.

## Symptoms

An import in the **Data management** workspace fails with the following error message:

> Updates not allowed for field 'PurchPurchaseOrderLineV2Entity.PurchaseOrderNumber'.

## Cause

**Purchase order number** and **Line number** identify a record in the **Purchase order lines V2** entity. You can specify the purchase order number when you create a line, but you can't change it on an existing line. Changing it would move the line to a different purchase order and break related records.

This error can occur when either of the following conditions is true:

- The import row matches an existing line but supplies a different purchase order number. This mismatch is the most common cause, and it usually indicates a source key problem in the file or the upstream integration.
- Existing purchase line data is inconsistent, which causes the import to match an unintended record. In this case, the import file is correct, but a corrupted purchase order line interferes with record matching.

## Correct the source key in the import file

Try this resolution first, as it addresses the most common cause.

1. Open the failed execution in the **Data management** workspace and then review the staging data for the failed row.
1. Confirm whether the row is intended to create a new line or update an existing line.
1. Verify that the **Purchase order number** and **Line number** values identify the intended record.
1. If the row is updating an existing line, don't change its purchase order number. Correct the source key and import the row again.

## Run the purchase order consistency check

Use this resolution only when the source key is correct and the error persists. In that situation, the failure is typically caused by corrupted purchase order lines that have a blank inventory transaction ID.

In version 10.0.50 and later, use the standard purchase order consistency check to detect and remove these lines:

1. Go to **System administration** > **Periodic tasks** > **Database** > **Consistency check**.
1. Expand **Purchase order**, and then select **Purchase order, line and parameter**.
1. Run the consistency check and then review the results under **Purchase order lines with blank inventory transaction ID**. The check reports the number of affected purchase order lines.
1. Confirm that the detected records are the corrupted lines that are associated with this import failure.
1. Run the same consistency check again by using **Fix error**.
1. Verify that the result reports that the affected purchase order lines were removed and then import the row again.

> [!WARNING]
> Fix mode removes all purchase order lines in the current legal entity that have both a blank inventory transaction ID and no source document line reference. Always run the consistency check in detection mode first, and review the results, before you use **Fix error**.

## Contact Microsoft Support

If you're on a version earlier than 10.0.50, or the error persists after you run the consistency check, stop retrying the import and [contact Microsoft Support](/power-platform/admin/get-help-support). The affected purchase line and its related records require supported data-consistency analysis.

> [!CAUTION]
> Don't directly update or delete purchase line records in the application database, and don't directly set or clear the inventory transaction ID. These changes can leave related purchase order, inventory, warehouse, and accounting records inconsistent.

## Related content

- [Purchase order line number errors when you import Purchase order lines V2 data](line-number-increments.md)
- [Purchase orders overview](/dynamics365/supply-chain/procurement/purchase-order-overview)
- [Data management overview](/dynamics365/fin-ops-core/dev-itpro/data-entities/data-entities-data-packages)
- [PurchPurchaseOrderLineV2Entity reference](/common-data-model/schema/core/operationscommon/entities/supplychain/procurementandsourcing/purchpurchaseorderlinev2entity)
