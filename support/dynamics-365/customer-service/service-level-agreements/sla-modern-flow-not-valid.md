---
title: SLA modern flow is not valid for ExecuteWorkflow error
description: Provides a resolution for the Modern flow is not valid for ExecuteWorkflow error.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/09/2023
---
# "Modern flow is not valid for ExecuteWorkflow" error

This article provides a resolution for the issue where you receive the "Modern flow is not valid for ExecuteWorkflow" error when running a service-level agreement (SLA) modern flow.

## Symptoms

An SLA modern flow fails with the following error:

> Modern Flow [flow ID] is not valid for ExecuteWorkflow.

## Cause

This issue occurs because the callback registrations are missing from the flow.

## Resolution

To solve this issue, turn off and then turn on the SLA modern flow.

Here are the steps to turn off or turn on a flow:

1. Sign in to [Power Automate](https://make.powerautomate.com/) as a user who has the permissions to edit a flow.

2. Select the right environment from **Environments** in the upper-right corner.

    :::image type="content" source="media/sla-modern-flow-not-valid/environment.png" alt-text="Screenshot shows the environment selection." border="false":::

3. Select **Solutions** from the left menu.

    :::image type="content" source="media/sla-modern-flow-not-valid/solutions.png" alt-text="Screenshot shows the Solutions option in the left menu.":::

4. Select **Default Solution** from the solutions list.

    :::image type="content" source="media/sla-modern-flow-not-valid/default-solution.png" alt-text="Screenshot shows the Default Solution in the solutions list.":::

5. Select **Cloud flows** from the left menu.

    :::image type="content" source="media/sla-modern-flow-not-valid/cloud-flows.png" alt-text="Screenshot shows the Cloud flows option in the left menu." border="false":::

6. To get the affected flow name, initiate an Open Data Protocol (OData) call using the affected flow ID from the error, and then search the flow name in Power Automate.

   (<organization_url>)/api/data/v9.1/workflows(<modern_flow_id_visible_in_error>)

    For example:

   `"name": "Set default CDS entity workstream rule",`

   :::image type="content" source="media/sla-modern-flow-not-valid/flow-name.png" alt-text="Screenshot shows how to identify the flow name through an OData call." border="false":::

7. Select the respective flow, and then select **Turn off** and then **Turn on** from the top menu.

    If you aren't sure about the flow name, select any one of the listed flows, replace the flow ID (you can get it from the error message) in the URL from the browser's address bar, and press <kbd>Enter</kbd>. Then, select **Turn off** and then **Turn on** from the top menu.

    Here's a sample URL where you need to replace the flow ID, which is immediately after "flows" in the address:

    `https://make.powerautomate.com/environments/Default-00000000-0000-0000-0000-000000000000/solutions/00000000-0000-0000-0000-000000000000/flows/[flow ID]/details?utm_source=solution_explorer`

    :::image type="content" source="media/sla-modern-flow-not-valid/turn-on-turn-off-cloud-flow.png" alt-text="Screenshot shows how to turn off or turn on a flow." border="false":::

If this resolution doesn't work, contact [Microsoft Support](https://dynamics.microsoft.com/support/) for further assistance.
