---
title: SLA modern flow is not valid for ExecuteWorkflow error
description: Provides a resolution for the Modern flow is not valid for ExecuteWorkflow error.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/07/2023
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

Here are the steps to turn off or turn on a flow:

1. Sign in to [Power Automate](https://make.powerautomate.com/) with a user who has the permissions to edit a flow.

2. Select the right environment from **Environments** in the upper-right corner.

    :::image type="content" source="media/sla-modern-flow-not-valid/environment.png" alt-text="The screenshot shows the environment selection." border="false":::

3. Select **Solutions** from the left menu.

    :::image type="content" source="media/sla-modern-flow-not-valid/solutions.png" alt-text="The screenshot shows the Solutions option in the left menu.":::

4. Select **Default Solution** from the solutions list.

    :::image type="content" source="media/sla-modern-flow-not-valid/default-solution.png" alt-text="The screenshot shows the Default Solution in the solutions list.":::

5. Select **Cloud flows** from the left menu.

    :::image type="content" source="media/sla-modern-flow-not-valid/cloud-flows.png" alt-text="The screenshot shows the Cloud flows option in the left menu." border="false":::

6. Select the respective flow and then select **Turn off** or **Turn on** from the top menu.
If you are not sure about the flow name, then click on any one of the listed flows and replace flow ID(you can get it from error message) in the URL from the browser address bar, and press enter key. Now select **Turn off** and then **Turn on** from top menu.

Sample URL where we need to replace flow ID immediately after **flows** in the address:
https://make.powerautomate.com/environments/Default-00000000-0000-0000-0000-000000000000/solutions/00000000-0000-0000-0000-000000000000/flows/[00000000-0000-0000-0000-000000000000]/details?utm_source=solution_explorer

    :::image type="content" source="media/sla-modern-flow-not-valid/turn-on-turn-off-cloud-flow.png" alt-text="The screenshot shows how to turn off or turn on a flow.":::

If this resolution doesn't work, raise an ICM to the flow team for assistance.