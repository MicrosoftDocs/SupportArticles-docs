---
title: SLA KPI instance Status is on-hold(paused), but SLA KPI instance's PausedOn is set to null.
description: Provides a resolution for the issue where SLA instance PausedOn is set to null when SLA instance Status is on-hold(paused).
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 07/12/2023
---
#  SLA KPI instance PausedOn is null when Status is on-hold(paused) 

This article provides a resolution for the issue where SLA KPI instance's PausedOn is set to null when SLA instance status is on-hold(paused).

## Symptoms

Throws below exception when updating a case:
Exception Message: Exception occured in SLAInstance management custom action : System.InvalidOperationException: Nullable object must have a value.

## Cause

The SLA KPI instance's PausedOn is updated to null when SLA instnace Status is on-hold(paused) through a custom logic or workflow and hence PausedOn value was not populated.

## Resolution

To solve this issue, take the following step:

Check if any custom logic or workflow implemented for slakpiinstance state transition.
If custom logic or workflow implemented to update slakpiinstance state then disable that custom logic or workflow, and use OOB functionality for pause and resume the slakpiinstance state.