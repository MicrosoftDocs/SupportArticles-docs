---
title: Dismiss All Doesn't Work in Notifications
description: Helps resolve an issue where notifications are cleared temporarily but reappear after a short time in Microsoft Dynamics 365 Customer Service.
ms.reviewer: srreddy
ai-usage: ai-assisted
ms.date: 04/10/2025
ms.custom: sap:Cases or Incidents, DFM
---
# The Dismiss All button doesn't work in the notifications in Dynamics 365 Customer Service

This article addresses an issue with the **Dismiss All** button in the notifications area of Dynamics 365 Customer Service.

## Symptoms

When you select the **Dismiss All** button in the notifications area of Dynamics 365 Customer Service, notifications are temporarily cleared from the interface. However, the notifications reappear after a short period, typically within less than a minute.

## Cause

This issue occurs due to insufficient user privileges on specific entities related to the notification system. Non-system administrators might lack the necessary permissions on the following entities:

- Model-driven app user setting
- Setting definition

> [!IMPORTANT]
>
> - The **Dismiss All** action doesn't delete notifications but prevents fetching notifications created before the action. Notifications will still be automatically deleted by the system as they near their expiry dates.
> - If immediate deletion of notifications is required, users should use the **Delete** action on individual notification cards instead of using the **Dismiss All** functionality.

## Resolution

To resolve this issue, ensure that the affected user has the necessary privileges on the involved entities. Follow these steps to update permissions:

1. Assign the following privileges on the "model-driven app user setting" entity:

    - Create
    - Read
    - Write
    - Append

2. Assign the following privileges on the "setting definition" entity:

    - Read
    - AppendTo

3. Verify that the updated privileges are applied to the user's security role.
4. Test the **Dismiss All** button to confirm that notifications no longer reappear after being dismissed.
