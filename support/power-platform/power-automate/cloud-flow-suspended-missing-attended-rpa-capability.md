---
title: Cloud flow suspended due to missing the attended RPA capability
description: Provides a resolution for the issue where a cloud flow is suspended because its owner is missing the attended RPA capability.
ms.reviewer: 
ms.author: cvassallo
author: V-Camille
ms.date: 05/15/2023
ms.subservice: power-automate-desktop-flows
---
# A cloud flow is suspended because the owner is missing the attended RPA capability

This article provides a resolution for the issue where a cloud flow is suspended because its owner is missing the attended robotic process automation (RPA) capability.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Consider the following scenario:

- You create a cloud flow with a desktop flow card in **Attended** mode.

  :::image type="content" source="media/cloud-flow-suspended-missing-attended-rpa-permission/cloud-flow-canvas.png" alt-text="Screenshot that shows a cloud flow is created with an attended desktop flow card.":::

- After you save the cloud flow, the cloud flow can't be triggered, and the status is **Suspended**. The **Run** button on the top panel is also deactivated.

  :::image type="content" source="media/cloud-flow-suspended-missing-attended-rpa-permission/cloud-flow-suspended.png" alt-text="Screenshot that shows the cloud flow is in the Suspended status.":::

## Cause

This issue occurs when the cloud flow's owner doesn't have a per-user plan with attended RPA capability. You can confirm if this is the case by selecting the **Flow checker** button to view the error message details.

:::image type="content" source="media/cloud-flow-suspended-missing-attended-rpa-permission/flow-checker.png" alt-text="Screenshot that shows the error details in the flow checker message.":::

You can double-check your user capabilities by selecting **Settings** (the gear icon on the top right) > **View my Licenses**. 

:::image type="content" source="media/cloud-flow-suspended-missing-attended-rpa-permission/view-my-licenses.png" alt-text="Screenshot that shows the View my licenses panel.":::

## Resolution

There are two solutions to solve this licensing issue:

- The cloud flow's owner needs a [per user with attended RPA license](/power-platform/admin/power-automate-licensing/types) as described in the flow checker message. To do so, the flow checker offers three options: start a free 90-day trial, send a license request to the admin, or buy your own license.
- Assign a "Per-flow" plan to the cloud flow by selecting **Details** > **Edit**. 

  :::image type="content" source="media/cloud-flow-suspended-missing-attended-rpa-permission/assign-per-flow-plan.png" alt-text="Screenshot that shows how to assign a Per-flow plan in the Details settings.":::

  > [!NOTE]
  > If no "Per-flow" plan is available in the environment, contact your admin to get one allocated.
