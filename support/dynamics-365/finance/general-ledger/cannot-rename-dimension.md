---
# required metadata
title: Troubleshoot errors when creating or renaming a financial dimension or dimension value
description: Describes resolutions for errors that occur when creating or renaming a financial dimension or dimension value in Dynamics 365 Finance.
author: ethanrimes
ms.date: 02/18/2026
---
# I am blocked from creating or renaming a financial dimension

This article helps you resolve errors that occur when you create a new financial dimension, rename an existing one, or rename a dimension value.

## Name conflict when creating or renaming a dimension

When you create a new dimension or rename an existing one, you receive one of the following error messages:

> `[DIMENSION NAME] is currently being used as a Dimension or has some other conflict that prevents it from being used as a name. If a dimension was previously deleted or renamed, but those changes are not yet activated, please activate now before attempting to recreate the same dimension, or choose a different name.`
> `Dimension [DIMENSION NAME] exists as an extension column on [ENTITY NAME] ([ENTITY TABLE NAME]) and [ENTITY NAME] ([ENTITY TABLE NAME]). You cannot change the name until this extension is removed.`
> `The financial dimension name [DIMENSION NAME] exists as a translated name on financial dimension [EXISTING DIMENSION NAME].`

**Cause:** The name you're trying to use already exists as a column in the dimension tables from a previous dimension that was deleted or renamed but not yet activated. The system blocks reuse until those pending changes are activated.

**Resolution:**

Activate all pending dimension changes to clear the conflict. For steps, see [Activating dimensions](/dynamics365/finance/general-ledger/financial-dimensions#activating-dimensions). If the error mentions an extension column conflict, the package containing that extension must be removed before the rename can proceed. If activation fails or the conflict persists, choose a different dimension name. See [Financial dimension naming requirements](/dynamics365/finance/general-ledger/financial-dimensions#financial-dimension-naming-requirements) for naming constraints.

## Invalid characters in dimension name

You receive the following error message:

> The financial dimension name [DIMENSION NAME] contains invalid characters.

**Resolution:** Review the dimension name and correct it to comply with the [Financial dimension naming requirements](/dynamics365/finance/general-ledger/financial-dimensions#financial-dimension-naming-requirements).


## Stuck in maintenance mode due to entity extensions

**Symptom:** You're in maintenance mode and receive errors when trying to leave. The error references **DimensionCombinationEntity** or **DimensionSetEntity**, and the system rolls back automatically.

**Cause:** A custom extension on **DimensionCombinationEntity** or **DimensionSetEntity** contains a hardcoded reference to a dimension name that no longer exists or has been renamed.

**Resolution:**

This resolution has a two-part solution: first escape the deadlock, then fix the actual problem. For general information about entering and exiting maintenance mode, see [Maintenance mode](/dynamics365/fin-ops-core/dev-itpro/sysadmin/maintenance-mode).

1. If you're stuck in maintenance mode, restore the deleted or renamed dimensions to their previous names so activation can succeed, then exit maintenance mode.
2. Remove the package containing the hardcoded column references.
3. Re-enter maintenance mode and activate dimensions again.
4. Create a replacement extension using the correct approach. For more information, see [Dimensions overview for developers](/dynamics365/fin-ops-core/dev-itpro/financial/dimensions-overview).

> [!NOTE]
> Using a hardcoded dimension name in an entity extension is a legacy pattern. The current approach looks up the dimension by name dynamically, so it remains valid even after renames.

## Activation fails with a change data capture (CDC) error

**Symptom:** Activation fails with one of the following errors:

- `Cannot drop the procedure 'cdc.sp_batchinsert_{number}' because it's being used for Change Data Capture`
- `Column name 'SYSTEMGENERATEDATTRIBUTE[DIMENSION ATTRIBUTE]' in table 'cdc.dbo_DIMENSIONATTRIBUTEVALUECOMBINATION_CT' is specified more than once.`

![Screenshot of the CDC sp_batchinsert error during dimension activation](./media/dimension-activation-cdc-error.png)

**Cause:** Change Data Capture (CDC) is enabled on the **DimensionAttributeValueCombination** or **DimensionAttributeValueSet** tables. CDC prevents the schema changes that dimension activation requires.

**Resolution:** Disable CDC on the **DimensionAttributeValueCombination** and **DimensionAttributeValueSet** tables before activating dimensions. After activation completes, you can re-enable CDC if needed.