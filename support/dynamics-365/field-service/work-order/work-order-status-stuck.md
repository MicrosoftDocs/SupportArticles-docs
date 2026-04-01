---
title: Troubleshoot Work Order Status Transition Issues
description: Work order status stuck or reverting in Dynamics 365 Field Service? Learn how to resolve issues with transition rules, incomplete bookings, and plug-in conflicts.
ms.date: 04/01/2026
ms.reviewer: vhorvath, puneetsingh, v-shaywood
ms.custom: sap:Work Order Management
---

# Work order status doesn't change as expected

## Summary

This article helps you troubleshoot scenarios where a work order doesn't change to the expected status (for example, from **Open** to **Completed**) in Microsoft Dynamics 365 Field Service. It covers status transition rule restrictions, open sub-records that block completion, and custom plug-ins that revert status changes.

## Symptoms

When you try to change the work order system status or substatus, you notice one or more of the following issues:

- The status field dropdown doesn't show the expected status options.
- After you change the status and save, the status reverts to its previous value.
- The work order shows as **Completed**, but associated bookings remain in an **In Progress** status.
- You receive the following error message:

  > The status transition is not valid. Please check the entity's status transition rules.

## Check the status transition rules for missing transitions

Custom status reason transitions that you configure on the Work Order table might not allow the transition you need. If you don't explicitly permit a transition, the target status doesn't appear in the dropdown.

To review and update the status transition rules:

1. Go to [Power Apps](https://make.powerapps.com) and select your environment.
1. In the left navigation, select **Tables**.
1. Search for and open the **Work Order** table.
1. Select **Columns**.
1. Open the **System Status** (`msdyn_systemstatus`) column.
1. Check whether **Status reason transitions** are enabled. If they are, review the allowed transitions.
1. Add the missing transition, or disable status transitions if your business process doesn't require them.

## Verify that all bookings and sub-records are completed

Dynamics 365 Field Service might require you to complete associated bookings, work order products, or work order services before you can complete the work order. For more information about how [booking statuses](/dynamics365/field-service/set-up-booking-statuses) map to work order statuses, see [Work order lifecycle and system statuses](/dynamics365/field-service/work-order-status-booking-status).

To close associated sub-records:

1. In the Dynamics 365 Field Service app, open the work order record.
1. Select the **Bookings** tab.
1. Confirm that all associated bookings have a **Completed** booking status.
1. On the same work order, go to the **Products and Services** tab.
1. Confirm that all items are in a **Used** or **Estimated** status (not **Open**).
1. After all sub-records are in a terminal state, change the work order status to **Completed**.

> [!NOTE]
> If you need to complete a work order without completing all sub-records, consider using a Power Automate flow that first updates sub-record statuses and then updates the work order status.

## Check for a custom plug-in that reverts the status

A synchronous plug-in registered on the work order **Update** message might revert the status change based on custom business logic.

To identify and fix the plug-in:

1. Go to [Power Apps](https://make.powerapps.com) and select your environment.
1. Go to **Tables** > **Work Order** > **Plug-in steps**.
1. Look for plug-ins registered on the **Pre-Operation** or **Post-Operation** step of the **Update** message.
1. Enable the Plug-in Trace Log to capture execution details:
    1. In the Dynamics 365 Field Service app, select **Settings** (gear symbol) > **Advanced Settings**.
    1. Go to **System** > **Administration** and select **Customization**.
    1. Set **Enable logging to plug-in trace log** to **All**.
1. Reproduce the issue and review the trace log for any plug-in that modifies the `msdyn_systemstatus` field.
1. Update the plug-in logic to allow the intended status transition.

## Related content

- [Create a work order](/dynamics365/field-service/create-work-order)
- [Work order architecture](/dynamics365/field-service/field-service-architecture)
