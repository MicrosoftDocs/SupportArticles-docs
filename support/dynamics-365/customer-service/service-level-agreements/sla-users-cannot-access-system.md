---
title: Disabled users cannot access the system error
description: Provides a resolution for an issue where an SLA flow run fails due to the flow owner being disabled or having an invalid license.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/25/2023
---
# "Disabled users cannot access the system" error

This article provides a resolution for an issue where a service-level agreement (SLA) flow run fails due to the flow owner being disabled or not having a valid license assigned.

## Symptoms

You receive the following error message when running an SLA flow:

> Disabled users cannot access the system. Consider enabling this user.

Also, users are disabled if they don’t have a valid license assigned to them. You receive an error when updating the status of an SLA KPI instance during a case update that’s associated with the SLA.

## Cause

This issue occurs because the owner of an SLA flow is disabled or doesn’t have a valid license assigned.

## Resolution

If the owner of an SLA flow is disabled, follow these steps to change the owner of a flow:

1. Navigate to an SLA flow (for example, `SLAWarningAndExpiryMonitoringFlow`) and the SLA action flows that are associated with the case.

2. Select **Edit** on the flow.

   :::image type="content" source="media/sla-users-cannot-access-system/sla-flow-edit.png" alt-text="Screenshot that shows how to edit a flow.":::

Then, a flyout opens, and you can remove the owner currently present in the **Owner** field and add a new owner. Make sure that the new owner has all required flow licenses. For more information about the flow licenses, see:

- [Types of Power Automate licenses](/power-platform/admin/power-automate-licensing/types)
- [Power Platform Licensing Guide May 2023](https://go.microsoft.com/fwlink/?linkid=2085130)

   :::image type="content" source="media/sla-users-cannot-access-system/sla-flow-owner.png" alt-text="Screenshot that shows how to add a new owner by using the Edit button on a flow.":::

3. Turn off and turn on a flow.

    :::image type="content" source="media/sla-workflow-published-state-error/sla-action-flow-activate.png" alt-text="Screenshot that shows how to activate a flow." border="false":::

    > [!NOTE]
    > The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for `prvReadSLAKPIInstance` and `prvWriteSLAKPIInstance` as internally, it changes a connection owner. Otherwise, at runtime, it fails due to not having privileges.
