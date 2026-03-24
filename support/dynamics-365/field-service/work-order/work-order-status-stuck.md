---
title: Troubleshoot a work order that doesn't transition to the next status
description: Troubleshoot issues where a work order can't transition to the next status in Dynamics 365 Field Service.
author: vhorvathms
ms.author: vhorvath
ms.reviewer: puneetsingh
ms.date: 03/19/2026
ms.custom: sap:Work Order Management
---

# Troubleshoot a work order that doesn't transition to the next status

## Summary

This article helps you troubleshoot scenarios where a work order doesn't transition to the next status (for example, from **Open** to **Completed**) in Microsoft Dynamics 365 Field Service.

## Symptoms

When you try to change the work order system status or sub-status, you notice one or more of the following issues:

- The status field dropdown doesn't show the expected status options.
- After you change the status and save, the status reverts to its previous value.
- You receive the following error message:

  > The status transition is not valid. Please check the entity's status transition rules.

- The work order shows as **Completed**, but associated bookings remain in an **In Progress** status.

## Cause 1: Status transition rules might limit available options

Custom status reason transitions are configured on the Work Order table, and the transition you need might not be allowed by the current rules.

### Solution: Review status transition rules

1. Go to [make.powerapps.com](https://make.powerapps.com), sign in, and select your environment from the environment picker in the top-right corner.
1. In the left navigation, select **Tables**, search for and open the **Work Order** table, and then select **Columns**.
1. Open the **System Status** (`msdyn_systemstatus`) column.
1. Check whether **Status reason transitions** are enabled. If they are, review the allowed transitions.
1. Add the missing transition, or disable status transitions if your business process doesn't require them.

## Cause 2: Open bookings or sub-records might need to be completed first

Dynamics 365 Field Service might require you to complete associated bookings, work order products, or work order services before you can complete the work order.

### Solution: Close open sub-records

1. In the Dynamics 365 Field Service app, open the work order record and select the **Bookings** tab.
1. Verify that all associated bookings have a **Completed** booking status.
1. On the same work order, go to the **Products and Services** tab and verify that all items are in a **Used** or **Estimated** status (not **Open**).
1. After all sub-records are in a terminal state, change the work order status to **Completed**.

> [!NOTE]
> If you need to complete a work order without completing all sub-records, consider using a Power Automate flow that first updates sub-record statuses and then updates the work order status.

## Cause 3: A custom plug-in might be reverting the status

A synchronous plug-in registered on the work order **Update** message might revert the status change based on custom business logic.

### Solution: Identify and fix the custom plug-in

1. To check plug-in registrations, go to [make.powerapps.com](https://make.powerapps.com), select your environment, and then go to **Tables** > **Work Order** > **Plug-in steps**. Look for plug-ins registered on the **Pre-Operation** or **Post-Operation** step of the **Update** message.
1. Enable the Plug-in Trace Log to capture execution details:
    1. In the Dynamics 365 Field Service app, select **Settings** (gear icon) > **Advanced Settings**.
    1. In the advanced settings area, go to **System** > **Administration** and select **Customization**.
    1. Set **Enable logging to plug-in trace log** to **All**.
1. Reproduce the issue and review the trace log for any plug-in that modifies the `msdyn_systemstatus` field.
1. Update the plug-in logic to allow the intended status transition.

## Related content

- [Work order lifecycle and system statuses](/dynamics365/field-service/work-order-status-booking-status)
- [Set up booking statuses](/dynamics365/field-service/set-up-booking-statuses)
