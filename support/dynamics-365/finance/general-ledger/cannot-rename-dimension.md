---
# required metadata
title: Renaming a dimension value doesn't succeed
description: Describes resolutions for an issue where renaming a dimension value takes a long time or does not complete in Dynamics 365 Finance.
author: ethanrimes
ms.date: 02/18/2026
---
# Renaming a dimension value doesn't succeed

When you rename a dimension value in Dynamics 365 Finance, the process runs as a batch job and may take time to complete. If the rename appears stuck or doesn't finish, the following resolutions can help.

## Symptoms

After renaming a dimension value, the change doesn't appear to take effect or the process does not complete in a reasonable amount of time.

## Resolution
 - Rename the dimension value to a temporary name (for example, "Redmond-01"), and then rename it back to the original name (for example, "Redmond"). Make sure the second rename is started only after the first rename has fully completed.

To check the status of a rename, go to **System administration** > **Periodic tasks** > **Data maintenance**, and look for the job named **Dimension value rename and modify chart of accounts delimiter process** under the **Misc** tab.

 - If the resolution above doesn't resolve the issue, run the **Dimension value rename and modify chart of accounts delimiter process - manual override** data maintenance action. This bypasses the batch job and forces the process to run to completion.

>[NOTE!]
> The **Dimension value rename and modify chart of accounts delimiter process - manual override** data maintenance action may run for an extended period and could cause temporary performance degradation.

