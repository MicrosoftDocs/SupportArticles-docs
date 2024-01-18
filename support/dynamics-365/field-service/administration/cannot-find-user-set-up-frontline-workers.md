---
title: Can't find a user when setting up frontline workers in Dynamics 365 Field Service
description: Resolves issues when trying to assign security roles to users in a new Field Service environment and the user can't be found.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/09/2024
---
# Can't find a user when setting up frontline workers in Dynamics 365 Field Service

This article helps resolve an issue when an administrator can't find a user when setting up frontline workers in the Field Service web app.

## Prerequisites

You have administrator permissions in Dynamics 365 Field Service.

## Symptoms

When you try to [assign security roles to their users](/dynamics365/field-service/flw-admin.md#assign-security-roles-and-field-security-profiles) in a new Field Service environment, you can't find a user in the **Users** lookup field.

   :::image type="content" source="media/fsp-assign-roles.png" alt-text="Screenshot of adding frontline workers in Dynamics 365 Field Service.":::

## Resolution

1. Ask the user to sign in to the environment. Continue to the next step whether or not the user succeeds.

1. Reload the page and search for the user again.

1. If the user still doesn't appear in the list, make sure the [user is set up and active](/microsoft-365/admin/add-users/add-users) in the [Microsoft 365 admin center](https://admin.microsoft.com/).
