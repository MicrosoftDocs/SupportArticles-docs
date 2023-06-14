---
title: SLA workflow must be in published state 
description: Provides a resolution for the issue where case updating fails with the error “workflow must be in published state”.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/14/2023
---
# "Workflow must be in Published state" error

This article provides a resolution for the issue where case updating fails with the error “workflow must be in published state”.

## Symptoms

“Workflow must be in published state” error while updating the status of SLAKPI instance during case update which is associated with SLA.

## Cause

This issue happens due to the action flow on the SLA item being disabled during case update which is associated with SLA.

## Resolution

To solve this issue, enable SLA action flow which is associated with the Case.

Here are the steps to to enable SLA action flow:

1. Open SLA which is applied to Case.

2. Open SLA item.

3. Click on “Configure Actions” button (It will open respective action flow).

4. Turn on action flow if it is turned off.

    :::image type="content" source="media/sla-workflow-published-state-error/sla-action-flow-activate.png" alt-text="The screenshot shows how to activate a flow.":::

> [!NOTE]
> Please repeat 2 to 4 steps for all SLA items if SLA has multiple SLA items.