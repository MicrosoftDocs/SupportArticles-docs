---
title: Bookable Resources Don't Display on the Schedule Board
description: Fix missing bookable resources on the Dynamics 365 Field Service schedule board. Check scheduling methods, board filters, work hours, status, and permissions.
ms.reviewer: mkelleher, puneetsingh, v-shaywood, anclear
ms.date: 09/08/2026
ms.custom: sap:Schedule Board\Issues with usability
ai-usage: ai-assisted
---

# Bookable resources don't display on the schedule board

## Summary

This article helps you resolve issues in which one or more [bookable resources](/dynamics365/field-service/set-up-bookable-resources) don't appear on the Microsoft Dynamics 365 Field Service [schedule board](/dynamics365/field-service/work-with-schedule-board). Common causes include:

- Incorrect scheduling method settings
- Board tab filter configurations
- Missing work hours
- Inactive resource status
- Insufficient security role permissions

## Symptoms

One or more bookable resources are missing from the schedule board, even though the resources exist in the system and have an active status.

## Cause

Resources might not appear on the schedule board for several reasons:

- The resource's **Scheduling Method** isn't set for the schedule board.
- The board tab filters exclude the resource (territory, role, organizational unit, or resource type filters).
- Two or more board tab filters have no resources in common. For example, if the territory filter and the resource category (role) filter don't share any resources, the combined result is empty and no resources appear.
- The resource isn't enabled to display on the schedule board (the **Display on Schedule Board** option is turned off). The default schedule board view shows only resources that are enabled for the board.
- The resource doesn't have work hours configured for the viewed date range.
- The resource's status is **Inactive**.
- The current user doesn't have **Read** access to the resource record.

## Solution

1. In the Dynamics 365 Field Service app, go to **Service** > **Resources**.
1. Open the bookable resource record.
1. Check that the **Scheduling Method** field is set to **Allow** or your organization's expected value.
1. Go to **Scheduling** > **Schedule Board**.
1. On the active board tab, select **Settings** (gear symbol).
1. Review all active filters. Clear filters temporarily to check whether the resource appears. If the resource appears only after you clear filters, check whether two filters (for example, territory and resource category) exclude each other so that no resource satisfies both.
1. On the resource record, check that the resource is enabled to appear on the board (the **Display on Schedule Board** option is turned on).
1. Return to the resource record, and select **Show Work Hours** on the command bar.
1. Check that work hours are defined for the date range you're viewing on the board.
1. On the resource record, check that the **Status** field is set to **Active**.
1. If you use custom security roles:
    1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
    1. Select your environment.
    1. Go to **Settings** > **Users + permissions** > **Security roles**.
    1. Check that the dispatcher's role has **Read** access on the **Bookable Resource** table for the affected resource's business unit.

> [!NOTE]
> Facility-type resources and equipment-type resources follow the same rules. If you schedule a nonuser resource (such as a room or vehicle), make sure that it has work hours, and that the board tab isn't filtered to show only **User** resource types.

## Related content

- [Use the schedule board in Universal Resource Scheduling](/dynamics365/common-scheduler/use-schedule-board)
- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
