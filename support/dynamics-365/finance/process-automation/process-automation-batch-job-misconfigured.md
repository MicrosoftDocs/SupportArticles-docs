---
title: Process automation scheduled occurrences aren't processed on time
description: Provides a resolution for an issue where process automation scheduled occurrences and background processes aren't processed on time in Microsoft Dynamics 365 Finance.
author: seth-arvila
ms.author: setharvila
ms.date: 03/05/2026
audience: IT Pro
ms.reviewer: twheeloc
ms.search.region: Global
ms.search.validFrom: 2020-09-10
ms.dyn365.ops.version: AX 7.0.0
---

# Process automation scheduled occurrences aren't processed on time

This article provides a resolution for an issue where process automation scheduled occurrences and background processes aren't processed on time in Microsoft Dynamics 365 Finance.

## Symptoms

Process automation scheduled occurrences or background processes aren't processed on time.

## Cause

The process automation system batch job has an incorrect recurrence interval or scheduling priority setting.

## Resolution

Follow these steps to verify and correct the batch job configuration.

### Step 1: Verify the batch job recurrence and priority settings

1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Filter the **Job description** field by using the phrase "process automation" to find the system job.
1. Select the batch job, and then select **View tasks** on the Action Pane. Confirm that the batch job contains a task that uses the **ProcessAutomationPollingEngine** class. This class identifies the correct system batch job that drives process automation scheduling. Other batch jobs might have similar names but serve different purposes.
1. Verify the following settings:

   - **Recurrence** is set to **1 minute**.
   - **Effective Scheduling Priority** is set to **Critical** or **Reserved Capacity**.

If either setting is incorrect, continue with the following steps to correct the configuration.

### Step 2: Set the recurrence to one minute

For the process automation system job, set the recurrence to **1 minute**.

### Step 3: Set the scheduling priority to Reserved Capacity

For the process automation system job, enable the **Scheduling priority is overridden** option, and then set **Job scheduling priority** to **Reserved Capacity**.

After both settings are correctly configured, the system job runs every minute, and scheduled occurrences and background processes are processed on time.
