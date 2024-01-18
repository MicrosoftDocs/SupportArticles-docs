---
title: Caller user does not have Create permissions error when creating work orders
description: Resolves an error that occurs when a dispatcher tries to create Dynamics 365 Field Service work orders in Microsoft Outlook or Teams.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/18/2024
---
# "Caller user does not have Create permissions" error when trying to create work orders in Microsoft Outlook or Teams

This article helps resolve permission issues when a [Field Service – Dispatcher](/dynamics365/field-service/users-licenses-permissions#field-service-security-roles) user tries to create Dynamics 365 Field Service work orders in Microsoft Outlook or Microsoft Teams.

## Symptoms

When a dispatcher tries to create work orders, they receive the following error message:

> An error occurred: Caller user with ID {ID number} does not have Create permissions for the msdyn_timefrompromised attribute in the msdyn_workorder entity. Count secured attributes in entity 11. user has 0 secured attribute privileges.

## Resolution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform the following actions.

Edit the [column-level security](/dynamics365/field-service/flw-admin?tabs=viva#set-up-column-level-security-optional) for the **Field Service – Dispatcher** role, and grant the **Create** permission to the **Time To Promised** (`msdyn_timetopromised`) and **Time From Promised** (`msdyn_timefrompromised`) fields.

If the error persists, follow these steps to check the **Field Service – Dispatcher** security role:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
1. Find the Field Service environment the dispatcher is trying to use in Outlook.
1. Select **Settings** > **Users + permissions** > **Security roles**.
1. Select the **Field Service – Dispatcher** role.
1. Scroll to the **Work Order** table. Change the **Create** permission so that it isn't set to **None**.
