---
title: Incorrect user privileges errors in Dynamics 365 Field Service
description: Resolves privileges errors that occur when a user tries to access work orders in Microsoft Dynamics 365 Field Service.
ms.reviewer: jacoh, v-wendysmith, v-shaywood
ms.date: 04/22/2026
ms.custom: sap:Administration
---
# Incorrect user privileges errors in Dynamics 365 Field Service

## Summary

This article helps frontline managers or administrators resolve privileges errors that occur when a user tries to access [work orders](/dynamics365/field-service/field-service-architecture) in Microsoft Dynamics 365 Field Service.

## Symptoms

When a user tries to access work orders, one of the following error messages appears:

- If the user has no privileges in the environment, the following error message appears:

    > An error has occurred. Please contact your administrator.

- If the user has some privileges but not all required privileges, an error message similar to the following appears:

    > You do not have prvCreatemsdyn_workorder permission to access msdyn_workorder records. Contact your Microsoft Dynamics 365 administrator for help.

## Solution

> [!NOTE]
> You need administrator permissions in Dynamics 365 Field Service to complete this task.

To resolve this issue, [assign the correct security role](/dynamics365/field-service/users-licenses-permissions#assign-security-roles) and [field security profile](/dynamics365/field-service/security-permissions) to the user.

## Related content

- [Create a work order](/dynamics365/field-service/create-work-order)
- [Security roles and privileges for Dataverse](/power-platform/admin/security-roles-privileges)

