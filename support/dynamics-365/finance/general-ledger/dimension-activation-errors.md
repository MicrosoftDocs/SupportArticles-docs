---
title: Fix financial dimension activation errors in Dynamics 365
description: Resolve financial dimension activation errors in Dynamics 365 Finance. This guide covers name conflicts, CDC conflicts, change tracking, and data maintenance job interference.
ms.date: 04/02/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---
# Financial dimension activation errors

## Summary

This article helps you resolve errors and timeouts that occur when you activate financial dimensions in Microsoft Dynamics 365 Finance. Common causes include dimension name conflicts, entity extension problems, Change Data Capture (CDC) conflicts, data maintenance job interference, change tracking, and large data volumes.

## Activation fails

### Name conflict when creating or renaming a dimension

When you create a dimension or rename an existing one, you receive one of the following error messages:

> \<DimensionName> is currently being used as a Dimension or has some other conflict that prevents it from being used as a name. If a dimension was previously deleted or renamed, but those changes are not yet activated, please activate now before attempting to re-create the same dimension, or choose a different name.

> Dimension \<DimensionName> exists as an extension column on \<EntityName> (\<EntityTableName>) and \<EntityName> (\<EntityTableName>). You cannot change the name until this extension is removed.

> The financial dimension name \<DimensionName> exists as a translated name on financial dimension \<ExistingDimensionName>.

This error occurs because the name already exists as a column in the dimension tables from a previous dimension. That dimension is one that you deleted or renamed but didn't yet activate. The system blocks reuse until you activate those pending changes.

#### Solution

To clear the conflict, activate all pending dimension changes. For the steps to activate the changes, see [Activating dimensions](/dynamics365/finance/general-ledger/financial-dimensions#activating-dimensions). If the error mentions an extension column conflict, remove the package that contains the extension so that the rename process can proceed. If activation fails or the conflict persists, choose a different dimension name. For naming constraints, see [Financial dimension naming requirements](/dynamics365/finance/general-ledger/financial-dimensions#financial-dimension-naming-requirements).

### Stuck in maintenance mode because of entity extensions

The system is in maintenance mode and returns an error message when you try to leave. The message references `DimensionCombinationEntity` or `DimensionSetEntity`, and the system rolls back automatically.

A custom extension on `DimensionCombinationEntity` or `DimensionSetEntity` contains a hardcoded reference to a dimension name that no longer exists or has been renamed.

#### Solution

To resolve this issue, escape the deadlock, and then fix the underlying problem:

1. Restore the previous names of the deleted or renamed dimensions so that activation can succeed. Then, exit maintenance mode.
1. Remove the package that contains the hardcoded column references.
1. Re-enter maintenance mode, and activate dimensions again.
1. Create a replacement extension that uses name-based lookups instead of hardcoded dimension values. For the documented approach, see [Dimensions overview for developers](/dynamics365/fin-ops-core/dev-itpro/financial/dimensions-overview).

For general information about how to enter and exit maintenance mode, see [Maintenance mode](/dynamics365/fin-ops-core/dev-itpro/sysadmin/maintenance-mode).

### Change Data Capture (CDC) error

Activation fails and returns one of the following error messages:

> Column name 'SYSTEMGENERATEDATTRIBUTE\<DimensionAttribute>' in table 'cdc.dbo_DIMENSIONATTRIBUTEVALUECOMBINATION_CT' is specified more than once.

> Cannot drop the procedure 'cdc.sp_batchinsert_\<Number>' because it's being used for Change Data Capture

:::image type="content" source="media/dimension-activation-errors/dimension-activation-cdc-error.png" alt-text="Screenshot of the CDC sp_batchinsert error during dimension activation.":::

Change Data Capture (CDC) is enabled on the `DimensionAttributeValueCombination` or `DimensionAttributeValueSet` tables. This condition prevents the schema changes that dimension activation requires.

#### Solution

Disable CDC on the `DimensionAttributeValueCombination` and `DimensionAttributeValueSet` tables before activating dimensions. After activation completes, re-enable CDC if needed.

## Activation times out

### Data maintenance jobs interfere with activation

Data maintenance batch jobs can start prematurely during activation or upgrade. In this situation, the jobs can block dimension tables before the system is ready.

#### Solution

Pause data maintenance jobs before you retry activation:

1. Go to **System administration** > **Setup** > **Process automations** > **Background processes**.
1. Set a sleep period on both **Data maintenance job to find opportunities** and **Data maintenance job to run fixes**.
1. Cancel any currently running data maintenance batch jobs.
1. Retry the dimension activation.
1. After activation finishes, remove the sleep period so that data maintenance resumes normally.

For more information about how to access and manage data maintenance jobs, see [Data maintenance portal](/dynamics365/fin-ops-core/dev-itpro/sysadmin/datamaintenanceportal).

### Change tracking on dimension tables

Change tracking on dimension tables can cause performance problems and timeouts during activation.

#### Solution

Disable change tracking for dimension tables. For more information, see [Enable change tracking for entities](/dynamics365/fin-ops-core/dev-itpro/data-entities/entity-change-track).

### Highly variable dimensions that have large data volumes

Dimensions that have many unique values that are spread across many transactions can cause the activation to time out.

#### Solution

Review and address highly variable dimensions before you retry activation. For guidance, see [Highly variable dimensions](/dynamics365/finance/cost-accounting/high-var-dimensions).

## Related content

- [Source record not found for a financial dimension value](source-record-not-found.md)
- [Define financial dimensions](/dynamics365/finance/general-ledger/tasks/define-financial-dimensions)
- [Make backing tables consumable as financial dimensions](/dynamics365/fin-ops-core/dev-itpro/financial/dimensionable-entities)
