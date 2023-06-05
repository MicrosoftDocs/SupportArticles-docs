---
title: SLA modern flow is not valid for ExecuteWorkflow error
description: Provides a resolution for the Modern flow is not valid for ExecuteWorkflow error.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# "Modern flow is not valid for ExecuteWorkflow" error

This article provides a resolution for the issue where you receive the "Modern flow is not valid for ExecuteWorkflow" error when running a service-level agreement (SLA) modern flow.

## Symptoms

An SLA modern flow fails with the following error:

> Modern Flow [Flow Guid] is not valid for ExecuteWorkflow.

## Cause

This issue occurs because the callback registrations are missing from the flow.

## Resolution

To solve this issue, turn off and then turn on the SLA modern flow.

If this resolution doesn't work, raise an ICM to the flow team for assistance.