---
# required metadata
title: Troubleshoot errors when creating or renaming a financial dimension or dimension value
description: Describes resolutions for errors that occur when creating or renaming a financial dimension or dimension value in Dynamics 365 Finance.
author: ethanrimes
ms.date: 03/10/2026
---

# Financial dimension creation or rename is slow and/or times out

## Potential Cause 1: Data maintenance jobs are interfering

**Description:** The data maintenance batch jobs can start prematurely during activation or upgrade, blocking dimension tables before the system is ready.

**Resolution:**

1. Go to **System administration** > **Setup** > **Process automations** and select the **Background processes** tab.
2. Select **Data maintenance job to find opportunities** and select **Edit**. Set a sleep period to prevent it from running during activation.

   ![Process automation sleep configuration for data maintenance job](./media/dimension-activation-process-automation.png)

3. Repeat for **Data maintenance job to run fixes**.
4. Go to **System administration** > **Inquiries** > **Batch jobs** and cancel any currently running data maintenance jobs.
5. Retry activation or upgrade.
6. After activation completes, remove the sleep period so data maintenance resumes normally.

## Potential Cause 2: Change tracking is enabled on dimension tables

**Description:** Change tracking enabled on dimension tables can cause performance issues and timeouts during activation.

**Resolution:** Disable change tracking for Dimension tables. For more information, see [Enable change tracking for entities](/dynamics365/fin-ops-core/dev-itpro/data-entities/entity-change-track).

## Potential Cause 3: Highly variable dimensions with large data volumes

**Description:** If your environment uses dimensions with a very large number of unique values spread across many transactions, activation may time out due to data volume.

**Resolution:** Contact Microsoft Support to identify and address highly variable dimensions before retrying activation.

Additional advice for dealing with highly variable data can be found on [highly variable dimensions](/dynamics365/finance/cost-accounting/high-var-dimensions).




