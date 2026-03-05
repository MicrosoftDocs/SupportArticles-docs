---
title: Process automation background processes or scheduled series aren't running
description: Provides a resolution for an issue where process automation background processes or scheduled series aren't running in Microsoft Dynamics 365 Finance.
author: seth-arvila
ms.author: setharvila
ms.date: 03/05/2026
audience: IT Pro
ms.reviewer: twheeloc
ms.search.region: Global
ms.search.validFrom: 2020-09-10
ms.dyn365.ops.version: AX 7.0.0
---

# Process automation background processes or scheduled series aren't running

This article provides a resolution for an issue where process automation background processes or scheduled series aren't running in Microsoft Dynamics 365 Finance.

## Symptoms

Process automation background processes or scheduled series aren't running. This issue can affect the following processes:

- Batch transfer for subledger journals
- Data maintenance jobs
- Vendor invoice batch posting
- Ledger settlements

## Cause

The process automation system batch job may be in an unhealthy state. This job is a framework-level batch job that's responsible for scheduling all process automation tasks. It should run every minute without an end date. This job shouldn't be modified directly.

## Resolution

Reinitialize process automation to restore the system batch job to a healthy state.

1. Go to **System administration** > **Setup** > **Process automations**.
1. Select **Initialize process automation**.
1. Go to **System administration** > **Inquiries** > **Batch jobs**.
1. Find the batch job with a description that starts with "Process automation polling system job" or "Process automation background process system job".
1. Confirm the batch job has a status of **Waiting** or **Executing**.
1. Wait a few minutes, and then verify that the affected processes are running as expected.

> [!NOTE]
> If the issue persists after you reinitialize process automation, verify that the batch framework is working correctly by checking that other batch jobs are processing normally.
