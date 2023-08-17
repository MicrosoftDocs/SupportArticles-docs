---
title: SLA KPI instance status is On-Hold (paused) but pausedon is set to null
description: Provides a resolution for an issue where the SLA KPI instance's pausedon property is set to null when the SLA instance's status is On-Hold (paused).
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 07/18/2023
---
# The value of pausedon is null when the SLA KPI instance’s status is On-Hold (paused) 

This article provides a resolution for an issue where the `pausedon` property of a service-level agreements (SLA) KPI instance is set to null when the SLA instance's status is **On-Hold** (paused).

## Symptoms

When you update a case, you receive the following error message:

> Exception Message: Exception occured in SLAInstance management custom action : System.InvalidOperationException: Nullable object must have a value.

## Cause

The `pausedon` property of the SLA KPI instance is updated to null through a custom logic or workflow when the status of the SLA KPI instance is **On-Hold** (paused). As a result, the value of the `pausedon` isn't populated.

## Resolution

To solve this issue, check if any custom logic or workflow is implemented for the SLA KPI instance status transition.

If a custom logic or workflow is implemented to update the SLA KPI instance's status, disable the custom logic or workflow and use the out-of-the-box functionality to pause and resume the SLA KPI instance's status.
