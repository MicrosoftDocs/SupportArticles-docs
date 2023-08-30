---
title: SLA workflow must be in Published state error
description: Provides a resolution for an issue where a case update fails with the Workflow must be in published state error.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/25/2023
---
# "Workflow must be in Published state" error

This article provides a resolution for the error “Workflow must be in Published state” that occurs when you update a case.

## Symptoms

When you update the status of an SLA KPI instance during a case update that’s associated with an SLA, you receive the following error message:

> Workflow must be in Published state.

## Cause

This issue occurs because the action flow on the SLA item is disabled during a case update that’s associated with an SLA.

## Resolution

To solve this issue, enable the SLA action flow associated with the case.

Here are the steps to enable the SLA action flow:

1. Open the SLA applied to the case.
2. Open the SLA item.
3. Select **Configure Actions**. It will open the respective action flow.
4. Turn on the action flow if it’s turned off.

    :::image type="content" source="media/sla-workflow-published-state-error/sla-action-flow-activate.png" alt-text="Screenshot that shows how to activate a flow." Border="false":::

> [!NOTE]
> Repeat steps 2 to 4 for all the SLA items if an SLA has multiple SLA items.
