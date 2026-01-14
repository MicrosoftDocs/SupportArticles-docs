---
title: Incorrect user privileges errors in Dynamics 365 Field Service
description: Resolves privileges errors that occur when a user tries to access work orders in Microsoft Dynamics 365 Field Service.
ms.author: jacoh
author: jasonccohen
ms.reviewer: v-wendysmith
ms.date: 01/09/2026
ms.custom: sap:Administration
---
# Incorrect user privileges errors in Dynamics 365 Field Service

This article helps frontline managers or administrators resolve privileges errors that occur when a user tries to access [work orders](/dynamics365/field-service/field-service-architecture) in Microsoft Dynamics 365 Field Service.

## Symptoms

When a user tries to access work orders, the following error messages appear, indicating that the user doesn't have the correct privileges.

- If the user has no privileges within the environment, the following error message appears:

    > An error has occurred. Please contact your administrator.

- If the user has some privileges but not all the required ones to complete the user action, an error message like the following appears:

    > You don't have prvCreatemsdyn_workorder permission to access msdyn_workorder records. Contact your Microsoft Dynamics 365 administrator for help.

## Resolution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to perform the following action.

To resolve this issue, [assign the correct security role](/dynamics365/field-service/users-licenses-permissions#assign-security-roles) and [field security profile](/dynamics365/field-service/security-permissions) to the user.

