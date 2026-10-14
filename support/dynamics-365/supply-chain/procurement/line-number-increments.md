---
title: Purchase Order Line Number Errors During Data Import
description: Purchase order line numbers ignore the system increment, or a renumbering error blocks your Purchase order lines V2 import. Learn how to fix both issues.
ms.date: 08/24/2026
ms.search.form: PurchTable, PurchTablePart, PurchParameters
audience: Application User
ms.reviewer: kamaybac, sugaur, sununna
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ai-usage: ai-assisted
---
# Purchase order line number errors when you import Purchase order lines V2 data

## Summary

This article helps you fix purchase order line number problems that occur when you import lines through the **Purchase order lines V2** data entity in Microsoft Dynamics 365 Supply Chain Management. It covers two symptoms: line numbers that ignore the increment defined in system parameters, and an import that fails with a "Renumbering of lines is not allowed" error. Both symptoms occur when the import file doesn't supply line numbers, so the [data management framework](/dynamics365/fin-ops-core/dev-itpro/data-entities/data-entities-data-packages) (DMF) assigns or renumbers them. Assigning explicit, unique line numbers in the import file usually fixes both symptoms and keeps purchase order line references stable for Dataverse synchronization and other integrations.

## Imported purchase orders show incorrect line numbers

Use this section when the import succeeds but the resulting purchase order lines are numbered 1, 2, 3 instead of the increment that you configured.

### Symptoms

By default, automatically generated line numbers for purchase order lines that are imported through the **Purchase order lines V2** data entity don't use the system line number increment that is specified in system parameters. If you manually create a purchase order and add lines through the user interface (UI), the line numbers increment correctly. However, if you use the data management framework (DMF), the line numbers don't increment correctly. You might also see this behavior described as line numbers being reset, overwritten, or "always incrementing by 1" after a [data import job](/dynamics365/fin-ops-core/fin-ops/data-entities/data-import-export-job).

### Cause

This issue occurs because, when you import lines via DMF, if the import file doesn't include line numbers, the system uses DMF's method for assigning them. That method always increments line numbers by one.

### Workaround

Ensure that the desired line numbers are already in the data entity line number fields when you import the purchase order lines. In this case, DMF won't overwrite the line numbers.

1. In the source file, populate the **Line number** field for every purchase order line row.
1. Use the increment that your organization expects.
1. Confirm that line numbers are unique within each purchase order.
1. Run the import again, and then verify the line numbers on the resulting purchase order.

## "Renumbering of lines is not allowed" error

Use this section when the import fails and the error appears in the execution log.

### Symptoms

When you import purchase order lines through the **Purchase order lines V2** data entity, the import fails. The execution log or job history shows the following error message:

> Renumbering of lines is not allowed.

### Cause

This error occurs when the **Disallow renumbering of lines** option is set to **Yes** on the **Procurement and sourcing parameters** page, but the import process tries to renumber purchase order lines. This option prevents line renumbering because renumbering can create inconsistent line references when [Dataverse synchronization](/dynamics365/fin-ops-core/dev-itpro/data-entities/dual-write/dual-write-home-page) is enabled. Systems that store a purchase order line reference, such as [Intelligent Order Management](/dynamics365/intelligent-order-management/integrate-procurement) or a custom integration, can lose the link to the line if the line number changes.

### Solution

Use one of the following solutions, depending on your integration design.

#### Specify line numbers in the import file

Use this approach when integrations depend on stable purchase order line references.

1. Assign the desired, unique **Line number** value to every row in the import file.
1. Verify that the file doesn't contain duplicate line numbers for the same purchase order.
1. Import the file again.

When line numbers are included in the imported entity, Data management doesn't replace them with automatically generated values.

#### Allow line renumbering

Allow renumbering only if Dataverse synchronization and other integrations don't depend on stable purchase order line references.

1. Go to **Procurement and sourcing** > **Setup** > **Procurement and sourcing parameters**.
1. Set **Disallow renumbering of lines** to **No**.
1. Import the file again.

> [!IMPORTANT]
> Don't set **Disallow renumbering of lines** to **No** when Dataverse synchronization or another integration requires stable purchase order line references. Instead, specify the intended line numbers in the import file.

## Related content

- ["Updates not allowed for PurchaseOrderNumber" error when you import purchase order lines](purchase-order-number-update-not-allowed.md)
- [Purchase order line data discrepancies](purchase-order-line-data-issues.md)
- [Purchase orders overview](/dynamics365/supply-chain/procurement/purchase-order-overview)
- [Data management overview](/dynamics365/fin-ops-core/dev-itpro/data-entities/data-entities-data-packages)
- [PurchPurchaseOrderLineV2Entity reference](/common-data-model/schema/core/operationscommon/entities/supplychain/procurementandsourcing/purchpurchaseorderlinev2entity)
