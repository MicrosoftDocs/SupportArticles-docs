---
title: Can't find a user when setting up frontline workers
description: Resolves an issue where you can't find a user when trying to assign security roles in a new Field Service environment.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/18/2024
---
# Can't find a user when setting up frontline workers in Dynamics 365 Field Service

This article helps resolve an issue where you can't find a user when setting up frontline workers in the Microsoft Dynamics 365 Field Service web app.

## Symptoms

When you try to [assign security roles to a user](/dynamics365/field-service/flw-admin?tabs=viva#assign-security-roles-and-field-security-profiles) when setting up frontline workers in a new Field Service environment, you can't find the user in the **Users** lookup field.

:::image type="content" source="media/cannot-find-user-set-up-frontline-workers/users-field.png" alt-text="Screenshot of adding frontline workers in Dynamics 365 Field Service." lightbox="media/cannot-find-user-set-up-frontline-workers/users-field.png":::

## Resolution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform the steps.

To solve this issue, follow these steps:

1. Ask the user to sign in to the environment. Continue to the next step whether the user succeeds or not.
1. Reload the page and search for the user again.
1. If the user still doesn't appear in the list, go to the [Microsoft 365 admin center](https://admin.microsoft.com/) and make sure [the user is set up and active](/microsoft-365/admin/add-users/add-users).
