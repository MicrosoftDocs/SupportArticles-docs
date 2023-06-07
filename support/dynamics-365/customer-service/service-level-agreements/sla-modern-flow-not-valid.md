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
Below are the steps to turn off or turn on a flow:
1. Connect to https://make.powerautomate.com/ with the user who is having permissions to edit a flow.

2. Select right environment from top right corner.
    :::image type="content" source="media/sla-modern-flow-not-valid/environment.png" alt-text="The screenshot shows the environment selection." border="false":::

3. Click on "Solutions" from left menu.
    :::image type="content" source="media/sla-modern-flow-not-valid/solutions.png" alt-text="The screenshot shows the solutions." border="false":::

4. Click on "Default Solution" from the solutions list.
    :::image type="content" source="media/sla-modern-flow-not-valid/defaultsolution.png" alt-text="The screenshot shows the default solution." border="false":::

5. Click on "Cloud flows" from left menu.
    :::image type="content" source="media/sla-modern-flow-not-valid/cloudflows.png" alt-text="The screenshot shows the cloud flows." border="false":::

6. Select the respective flow and click on "Turn off" or "Turn on" from top menu.
    :::image type="content" source="media/sla-modern-flow-not-valid/turnon-off.png" alt-text="The screenshot shows the how to turn off or turn on a flow." border="false":::

If this resolution doesn't work, raise an ICM to the flow team for assistance.