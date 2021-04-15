---
title: Gateway or machine is offline if desktop flows fail with gateway error
description: Troubleshoot an unavailable gateway.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Gateway or machine should be online when desktop flows fail with a gateway error

This article provides steps to solve an unavailable gateway or machine issue.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4555596

## Symptoms

You are able to test your desktop flows locally, but they fail with a gateway error when trying to run it as part of a Flow.

## Verifying issue

Go to the run summary page of the flow, and look at the error for the **desktop flows** step.

**Unreachable gateway**, **The target gateway is not available**, and **Could not connect to UI flows running on your machine** are good candidates for this problem.

:::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/error-for-desktop-flows-step.png" alt-text="Failed run because of unavailable gateway":::

The next step is to determine which of the machine, the gateway, or the UI flow service is offline.

1. Head over to [https://flow.microsoft.com](https://flow.microsoft.com).
2. Select the target environment.
3. Go to data/Connections in the left menu. If you already know which gateway is failing, go to data/Gateways and select the target gateway. Go directly to step 6.
4. Filter for **UI flows** to find UI flows connections, and select the connections used in the failing flows.
5. Select the gateway name on the details page:

   :::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/gateway-details.png" alt-text="Gateway name location":::

6. You can check the status of the gateway here:

   :::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/gateway-status.png" alt-text="Gateway status location":::

## Solving steps

If the gateway appears offline, make sure that the host machine is turned on and that the On-Premises Data Gateway app is running.

:::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/search-for-gateway.png" alt-text="Search for the gateway application":::

:::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/gateway-in-good-state.png" alt-text="Gateway app in a good state":::

If the gateway appears online or if the above steps fail to solve the issue, make sure that the UI Flow service is started on the machine.

:::image type="content" source="media/troubleshoot-unavailable-gateway-when-desktop-flows-fail/check-uiflowservice.png" alt-text="Check if the uiflowservice is running":::
