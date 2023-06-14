---
title: Disabled users cannot access the system 
description: Provides a resolution for the issue where SLA flow run fails due to flow owner is disabled or having invalid license.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/14/2023
---
# "Disabled users cannot access the system" error

This article provides a resolution for the issue where SLA flow run fails due to flow owner is disabled or having invalid license.

## Symptoms

“Disabled users cannot access the system. Consider enabling this user. Also, users are disabled if they don’t have a license assigned to them” error while updating the status of SLAKPI instance during case update which is associated with SLA.

## Cause

This issue happens due to owner of SLA flow is disabled or don’t have a valid license assigned.

## Resolution

If owner of SLA flow disabled then please follow below steps to change owner of a flow:

1. Navigate to the SLA flow (SLAWarningAndExpiryMonitoringFlow) and SLA action flows which are associated with the case.
   (For explanation purpose taking example of SLAWarningAndExpiryMonitoringFlow for this TSG. Same steps can be followed for all the flows)

2. Click on Edit button as shown below on the flow.

   :::image type="content" source="media/sla-users-cannot-access-system/sla-flow-edit.png" alt-text="The screenshot shows editing a flow.":::

   This will open a flyout where new owner can be set. Remove the owner currently present in the owner field and add new owner. Please make sure the new owner has all required flow licenses.
   Refer below for flow licenses:
   https://docs.microsoft.com/power-platform/admin/power-automate-licensing/types
   https://go.microsoft.com/fwlink/?linkid=2085130

   :::image type="content" source="media/sla-users-cannot-access-system/sla-flow-owner.png" alt-text="The screenshot shows adding a new owner.":::

4. Turn off and turn on a flow.

    :::image type="content" source="media/sla-workflow-published-state-error/sla-action-flow-activate.png" alt-text="The screenshot shows how to activate a flow.":::

> [!NOTE]
> The flow must only be turned off and on by a user who has the SLA KPI privileges at a global level for prvReadSLAKPIInstance and prvWriteSLAKPIInstance as internally it changes connection owner. Otherwise at runtime it will fail due to not having privileges..