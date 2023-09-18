---
title: Cloud flow suspended due to missing the unattended RPA capability
description: Provides a resolution for the issue where a cloud flow is suspended because it is missing the unattended RPA capability.
ms.reviewer: 
ms.author: cvassallo
author: V-Camille
ms.date: 05/23/2023
ms.subservice: power-automate-desktop-flows
---
# A cloud flow is suspended because it is missing the unattended RPA capability

This article provides a resolution for the issue where a cloud flow is suspended because it is missing the unattended robotic process automation (RPA) capability.

_Applies to:_ &nbsp; Power Automate

## Symptoms

Consider the following scenario:

- You create a cloud flow with a desktop flow card in **Unattended** mode.

  :::image type="content" source="media/cloud-flow-suspended-missing-unattended-rpa-permission/cloud-flow-canvas.png" alt-text="Screenshot that shows a cloud flow is created with an unattended desktop flow card.":::

- After you save the cloud flow, the cloud flow can't be triggered, and the status is **Suspended**. The **Run** button on the top panel is also deactivated.

  :::image type="content" source="media/cloud-flow-suspended-missing-unattended-rpa-permission/cloud-flow-suspended.png" alt-text="Screenshot that shows the cloud flow is in the Suspended status.":::

## Cause

This issue occurs when the environment doesn't have an [unattended add-on](/power-platform/admin/power-automate-licensing/add-ons#unattended-add-on) assigned from [Power Platform admin center]( https://admin.powerplatform.microsoft.com/). You can confirm if this is the case by selecting the **Flow checker** button to view the error message details.

:::image type="content" source="media/cloud-flow-suspended-missing-unattended-rpa-permission/flow-checker.png" alt-text="Screenshot that shows the error details in the flow checker message.":::

You can double-check your environment capabilities by selecting **Settings** (the gear icon on the top right) > **View my Licenses**. If you have an unattended add-on assigned to the environment, it will show up under the **Environment capacities** section.

:::image type="content" source="media/cloud-flow-suspended-missing-unattended-rpa-permission/view-my-licenses.png" alt-text="Screenshot that shows the View my licenses panel.":::

## Resolution

To solve this licensing issue, you need to assign an [unattended add-on](/power-platform/admin/power-automate-licensing/add-ons#unattended-add-on) to the environment as described in the flow checker message.

To do so, the flow checker offers two options:

- Send an add-on request to the admin.
- Buy your own add-on.
