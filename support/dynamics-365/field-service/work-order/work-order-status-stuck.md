---
title: Work order is stuck in a specific status and can't be updated
description: Resolves issues where work orders cannot transition to the next status in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/19/2026
ms.custom: sap:Work Order Management
---

# Work order is stuck in a specific status and can't be updated

This article helps you resolve issues where a work order can't transition to the next status (for example, from **Open** to **Completed**) in Microsoft Dynamics 365 Field Service.

## Symptoms

When you try to change the work order system status or sub-status, you experience one of the following issues:

- The status field dropdown doesn't include the expected status options.
- After changing the status and saving, the status reverts to the previous value.
- The following error appears when changing the status:

  > The status transition is not valid. Please check the entity's status transition rules.

- The work order shows as **Completed** but associated bookings remain in an **In Progress** status.

## Cause

### Cause 1: Status transition rules restrict the change

Custom status reason transitions are configured on the Work Order entity, and the desired transition isn't allowed by the defined rules.

### Cause 2: Open bookings or sub-records block completion

Field Service business logic prevents completing a work order when associated bookings, work order products, or work order services are still in an open or in-progress state.

### Cause 3: Custom plug-in reverts the status

A synchronous plug-in on the work order **Update** message reverts the status change based on custom business logic.

## Solution

### Solution for Cause 1: Review status transition rules

1. Go to [make.powerapps.com](https://make.powerapps.com), sign in, and select your environment from the environment picker in the top-right corner.
2. In the left navigation, select **Tables**, search for and open the **Work Order** table, and then select **Columns**.
3. Open the **System Status** (`msdyn_systemstatus`) column.
3. Check if **Status reason transitions** are enabled. If yes, review the allowed transitions.
4. Add the missing transition or disable status transitions if the business process doesn't require them.

### Solution for Cause 2: Close open sub-records

1. In the Dynamics 365 Field Service app, open the work order record and select the **Bookings** tab.
2. Verify all associated bookings have a **Completed** booking status.
3. On the same work order, go to the **Products and Services** tab and verify all items are in a **Used** or **Estimated** status (not **Open**).
4. Once all sub-records are in a terminal state, change the work order status to **Completed**.

> [!NOTE]
> If you need to complete a work order without completing all sub-records, consider using a Power Automate flow that first updates sub-record statuses and then updates the work order status.

### Solution for Cause 3: Identify and fix custom plug-ins

1. To check plug-in registrations, go to [make.powerapps.com](https://make.powerapps.com), select your environment, go to **Tables** > **Work Order** > **Plug-in steps**, and look for plug-ins registered on the **Pre-Operation** or **Post-Operation** step of the **Update** message.
2. Enable Plug-in Trace Log to capture execution details: in the Dynamics 365 Field Service app, select the **Settings** (gear icon) > **Advanced Settings**. In the advanced settings area, go to **System** > **Administration** tab and select **Customization**, and then set **Enable logging to plug-in trace log** to **All**.
3. Reproduce the issue and review the trace log for any plug-in that modifies the `msdyn_systemstatus` field.
4. Update the plug-in logic to allow the intended status transition.

## Related content

- [Work order lifecycle and system statuses](/dynamics365/field-service/work-order-status-booking-status)
- [Set up booking statuses](/dynamics365/field-service/set-up-booking-statuses)
