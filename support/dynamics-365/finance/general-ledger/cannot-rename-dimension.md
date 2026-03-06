---
# required metadata
title: Troubleshoot errors when creating or renaming a financial dimension or dimension value
description: Describes resolutions for errors that occur when creating or renaming a financial dimension or dimension value in Dynamics 365 Finance.
author: ethanrimes
ms.date: 02/18/2026
---
# Troubleshoot errors when creating or renaming a financial dimension or dimension value

This article helps you resolve errors that occur when you create a new financial dimension, rename an existing one, or rename a dimension value.

## Name conflict when creating or renaming a dimension

When you create a new dimension or rename an existing one, you receive one of the following error messages:

- `%1 is currently being used as a Dimension or has some other conflict that prevents it from being used as a name. If a dimension was previously deleted or renamed, but those changes are not yet activated, please activate now before attempting to recreate the same dimension, or choose a different name.`
- `Dimension %1 exists as an extension column on %2 (%3) and %4 (%5). You cannot change the name until this extension is removed.`
- `The financial dimension name exists on another financial dimension.`

**Cause:** The name you're trying to use already exists as a column in the dimension tables from a previous dimension that was deleted or renamed but not yet activated. The system blocks reuse until those pending changes are activated.

**Resolution:**

1. Enter maintenance mode.
1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Select **Activate all** to process all pending dimension changes.
1. After activation completes, retry creating or renaming the dimension.

If activation fails or the conflict persists, choose a different dimension name. See [financial dimensions](/dynamics365/finance/general-ledger/financial-dimensions#create-financial-dimensions) to learn more about naming constraints. Refrain from using the chart of accounts delimiter in a dimension name.

> [!NOTE]
> Dimension names can't contain special characters or reserved system field names such as **RecId**. If the error mentions an extension column conflict, the package containing that extension must be removed before the rename can proceed.

## Invalid characters in dimension name

You receive the following error message:

> The financial dimension name... contains invalid characters.

[Financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) names must follow specific naming conventions:

- Must start with an underscore or a letter (either lowercase or uppercase).
- Can contain only underscores, letters, or digits after the first character.
- Can't contain system field names such as `RecId`.

To fix this problem, follow these steps:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimensions**.
1. Review the dimension name and make sure it follows the naming conventions.
1. Rename the dimension if necessary, avoiding system field names and invalid characters.

## Rename of a dimension value doesn't complete

After renaming a dimension value, the change doesn't appear to take effect, or the process doesn't complete in a reasonable amount of time.

**Resolution:** Rename the dimension value to a temporary name (for example, "Redmond-01"), and then rename it back to the original name (for example, "Redmond"). Make sure the second rename is started only after the first rename has fully completed.

To check the status of a rename, go to **System administration** > **Periodic tasks** > **Data maintenance**, and look for the job named **Dimension value rename and modify chart of accounts delimiter process** under the **Misc** tab.

If the resolution above doesn't resolve the issue, run the **Dimension value rename and modify chart of accounts delimiter process - manual override** data maintenance action. This bypasses the batch job and forces the process to run to completion.

> [!NOTE]
> The **Dimension value rename and modify chart of accounts delimiter process - manual override** data maintenance action may run for an extended period and could cause temporary performance degradation.
