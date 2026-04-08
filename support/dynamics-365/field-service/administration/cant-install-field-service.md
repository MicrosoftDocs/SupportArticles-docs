---
title: Dynamics 365 Field Service installation troubleshooting
description: Follow this step-by-step guide to resolve Dynamics 365 Field Service installation failures that are caused by missing Dataverse stores, disabled Dynamics 365 apps, or unassigned licenses.
ms.date: 04/08/2026
ms.reviewer: jshotts, v-wendysmith, v-shaywood
ms.custom: sap:Administration
---

# Can't install Dynamics 365 Field Service application

## Summary

This article helps administrators resolve errors that occur when you try to install the [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) application in a Microsoft Power Platform environment. Common issues include a lack of support for the Common Data Service (CDS) instance, and a missing Field Service entry in the list of available Dynamics 365 apps. These errors typically occur if the environment isn't set up to have a Dataverse data store, if **Enable Dynamics 365 apps** isn't turned on, or if the required licenses or roles aren't assigned.

## Symptoms

When you try to install the Dynamics 365 Field Service application in your environment, you experience one or more of the following problems:

- You receive the following error message:

  > Installing Field Service on a CDS instance is not supported

- You can't find "Field Service" in the list of apps.

## CDS instance isn't supported

### Cause

This problem occurs because you try to install Dynamics 365 Field Service in a CDS environment that doesn't have a Dataverse organization provisioned or doesn't have the **Enable Dynamics 365 apps** option turned on.

### Solution

To resolve this problem, follow these steps:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

1. Select **Manage** > **Environments**, and then select your environment.

1. Check whether the environment has a Dataverse data store and the **Enable Dynamics 365 apps** option is turned on.

1. If the settings in the previous step aren't correct, [create an environment that has the correct configuration](/power-platform/admin/create-environment), and then try the installation again.

## Can't find Field Service in the apps list

### Cause

This problem occurs because one or both of the following requirements aren't met:

- You must be assigned the **System Administrator** or **Dynamics 365 admin** role.
- You must have an active Field Service license assigned to your account.

### Solution

1. Check whether you're assigned either the **System Administrator** or **Dynamics 365 admin** role.

1. Check whether you have an active Field Service license assigned to your account. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com), and go to **Billing** > **Licenses**.

1. Check whether the environment has a Dataverse data store, and the **Enable Dynamics 365 apps** option is turned on. See [CDS instance isn't supported](#cds-instance-isnt-supported).

1. If all requirements are met, sign out and then sign back in. Or, clear your browser cache.

## Related content

- [Install Dynamics 365 Field Service](/dynamics365/field-service/install-field-service)
- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Power Platform environments overview](/power-platform/admin/environments-overview)
