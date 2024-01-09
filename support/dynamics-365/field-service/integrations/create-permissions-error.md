---
title: Create permissions error when dispatcher tries to create work orders in Microsoft Outlook or Teams
description: Resolves issues when trying to create Dynamics 365 Field Service work orders in Microsoft Outlook or Teams.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/09/2024
---
# Create permissions error occurs when trying to create work orders in Microsoft Outlook or Teams

This article helps resolve permission issues when a dispatcher tries to create Dynamics 365 Field Service work orders in Microsoft Outlook or Teams.

## Prerequisites

You have administrator permissions in Dynamics 365 Field Service.

## Symptom

When a dispatcher tries to create work orders, they get the following error:

> An error occurred: Caller user with ID {ID number} does not have Create permissions for the msdyn_timefrompromised attribute in the msdyn_workorder entity. Count secured attributes in entity 11. user has 0 secured attribute privileges.

## Resolution

Edit the [Column level security](/dynamics365/field-service/flw-admin.md#set-up-column-level-security-optional) for the Field Service - Dispatcher role and allow Create permission to the `Time To Promised`(`msdyn_timetopromised`) and `Time From Promised`(`msdyn_timefrompromised`). If the error persists, check the security role:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).

1. Find the Field Service environment the dispatcher is trying to use in Outlook.

1. Select **Settings** > **Users + permissions** > **Security roles**.

1. Select the Field Service - Dispatcher role.

1. Scroll to the **Work Order** table. Change the **Create** permission so that it isn't set to **None**.
