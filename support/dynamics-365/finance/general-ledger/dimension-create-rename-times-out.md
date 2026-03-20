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

Pause the data maintenance jobs before retrying activation. For steps on accessing and managing data maintenance jobs, see [Data maintenance portal](/dynamics365/fin-ops-core/dev-itpro/sysadmin/datamaintenanceportal). Specifically, set a sleep period on both **Data maintenance job to find opportunities** and **Data maintenance job to run fixes** through **System administration** > **Setup** > **Process automations** > **Background processes**, and cancel any currently running data maintenance batch jobs. After activation completes, remove the sleep period so data maintenance resumes normally.

## Potential Cause 2: Change tracking is enabled on dimension tables

**Description:** Change tracking enabled on dimension tables can cause performance issues and timeouts during activation.

**Resolution:** Disable change tracking for Dimension tables. For more information, see [Enable change tracking for entities](/dynamics365/fin-ops-core/dev-itpro/data-entities/entity-change-track).

## Potential Cause 3: Highly variable dimensions with large data volumes

**Description:** If your environment uses dimensions with a very large number of unique values spread across many transactions, activation may time out due to data volume.

**Resolution:** Contact Microsoft Support to identify and address highly variable dimensions before retrying activation.

Additional advice for dealing with highly variable data can be found on [highly variable dimensions](/dynamics365/finance/cost-accounting/high-var-dimensions).




