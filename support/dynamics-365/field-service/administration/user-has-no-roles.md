---
title: Incorrect user privileges error in Dynamics 365 Field Service
description: Resolves an error that occurs when a user tries to access work orders in Microsoft Dynamics 365 Field Service.
author: jasonxian-msft
ms.author: jasonxian
ms.reviewer: v-wendysmith
ms.date: 01/18/2024
---
# Incorrect user privileges error in Dynamics 365 Field Service

This article helps frontline managers or administrators resolve the "user hasn't been assigned any roles" error that occurs when a user tries to access [work orders](/dynamics365/field-service/field-service-architecture) in Microsoft Dynamics 365 Field Service.

## Symptoms

When a user tries to access work orders, the following error message appears, indicating that the user doesn't have the correct privileges.

> The user hasn't been assigned any roles

## Resolution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform the following action.

To solve this issue, [assign the correct security role and field security profile](/dynamics365/field-service/flw-admin?tabs=viva#assign-security-roles-and-field-security-profiles) to the user.

## More information

[Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
