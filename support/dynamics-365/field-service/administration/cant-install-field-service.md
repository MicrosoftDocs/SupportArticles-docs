---
title: Dynamics 365 Field Service Installation Troubleshooting
description: Resolve Dynamics 365 Field Service installation failures caused by missing Dataverse stores, disabled Dynamics 365 apps, or unassigned licenses. Follow our step-by-step fix guide.
ms.date: 04/08/2026
ms.reviewer: jshotts, v-wendysmith, v-shaywood
ms.custom: sap:Administration
---

# Can't install Dynamics 365 Field Service application

## Summary

This article helps administrators resolve errors that occur when you try to install the [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) application in a Power Platform environment. Common issues include a message that the Common Data Service (CDS) instance isn't supported or not finding the Field Service app in the list of available Dynamics 365 apps. These errors typically occur when the environment isn't set up with a Dataverse data store, **Enable Dynamics 365 apps** isn't turned on, or the required licenses or roles aren't assigned.

## Symptoms

When you try to install the Dynamics 365 Field Service application in your environment, you experience one or more of the following problems:

- The following error message appears:

  > Installing Field Service on a CDS instance is not supported

- You can't find Field Service in the app list.

## CDS instance isn't supported

You tried to install Dynamics 365 Field Service on a Common Data Service (CDS) environment that doesn't have a Dataverse organization provisioned or doesn't have **Enable Dynamics 365 apps** turned on.

### Solution

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

1. Select **Manage** > **Environments**, and then select your environment.

1. Check if the environment has a Dataverse data store and if **Enable Dynamics 365 apps** is turned on.

1. If these settings aren't correct, [create a new environment with the correct configuration](/power-platform/admin/create-environment) and try the installation again.

## Can't find Field Service in the list of apps

You can't find Field Service in the list of apps to install because one or more of the following requirements aren't met.

### Solution

1. Verify that you're assigned either the **System Administrator** or **Dynamics 365 admin** role.

1. Verify that you have an active Field Service license assigned to your account. Sign in to the [Microsoft 365 admin center](https://admin.microsoft.com) and go to **Billing** > **Licenses**.

1. Check if the environment has a Dataverse data store and if **Enable Dynamics 365 apps** is turned on. For steps, see [CDS instance isn't supported](#cds-instance-isnt-supported).

1. If all requirements are met, try signing out and signing back in, or clear your browser cache.

## Related content

- [Install Dynamics 365 Field Service](/dynamics365/field-service/install-field-service)
- [Set up users, licenses, and security roles](/dynamics365/field-service/users-licenses-permissions)
- [Power Platform environments overview](/power-platform/admin/environments-overview)
