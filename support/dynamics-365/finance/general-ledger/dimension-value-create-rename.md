---
# required metadata
title: Troubleshoot errors when renaming a financial dimension value
description: Describes resolutions for errors that occur when renaming a financial dimension value in Dynamics 365 Finance.
author: ethanrimes
ms.date: 03/10/2026
---

# I am blocked from renaming a financial dimension value

This article helps you resolve issues that occur when renaming a financial dimension value is slow or times out in Dynamics 365 Finance.

## Rename of dimension value is slow or times out

**Symptom:** When you rename a financial dimension value, the operation takes an unusually long time or fails with a timeout error.

**Cause:** Renaming a dimension value triggers a background process that updates all related transaction records. If this process stalls or encounters an error, the rename may appear incomplete or unresponsive.

**Resolution:**

1. Go to **System administration** > **Periodic tasks** > **Data maintenance**.
2. Select the **Misc** tab.
3. Locate the **Dimension value rename and modify chart of accounts delimiter process** job.
4. Check the job status for any errors.
5. If no errors are present and the problem persists, select the blue **Run now** button to re-run the job.

> [!NOTE]
> If the job shows errors, re-running it will not succeed. Address the specified errors before attempting the rename again.
