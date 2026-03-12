---
title: Resources aren't displayed on the schedule board
description: Resolves issues where bookable resources don't appear on the Dynamics 365 Field Service schedule board.
author: mkelleher-msft
ms.author: mkelleher
ms.reviewer: puneetsingh
ms.date: 03/12/2026
ms.custom: sap:Schedule Board
---

# Resources aren't displayed on the schedule board

This article helps you resolve issues where bookable resources don't appear on the Dynamics 365 Field Service schedule board.

## Symptoms

One or more bookable resources are missing from the schedule board, even though the resources exist in the system and have an active status.

## Cause

Resources might not appear on the schedule board due to the following reasons:

- The resource's **Scheduling Method** isn't set for the schedule board.
- The board tab filters exclude the resource (territory, role, organizational unit, or resource type filters).
- The resource doesn't have work hours configured for the viewed date range.
- The resource's status is **Inactive**.
- The current user doesn't have **Read** access to the resource record.

## Resolution

1. In the Dynamics 365 Field Service app, go to **Service** > **Resources**. Open the bookable resource record and verify the **Scheduling Method** field is set to **Allow** or your organization's expected value.
2. Go to **Scheduling** > **Schedule Board**. On the active board tab, select the **gear icon** to open tab settings and review all active filters. Clear filters temporarily to see if the resource appears.
3. Return to the resource record and select **Show Work Hours** on the command bar. Verify that work hours are defined for the date range you're viewing on the board.
4. On the resource record, confirm the **Status** field is set to **Active**.
5. If you use custom security roles, sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/), select your environment, go to **Settings** > **Users + permissions** > **Security roles**, and verify the dispatcher's role has **Read** access on the **Bookable Resource** table for the affected resource's business unit.

> [!NOTE]
> Facility-type resources and equipment-type resources follow the same rules. If you schedule a non-user resource (such as a room or vehicle), ensure it has work hours, and the board tab isn't filtered to show only **User** resource types.

## More information

- [Set up bookable resources](/dynamics365/field-service/set-up-bookable-resources)
- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
