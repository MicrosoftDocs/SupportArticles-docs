---
title: Can't install Dynamics 365 Field Service application
description: Troubleshoot common Field Service installation errors, including CDS instance not supported and can't find the Field Service app.
ms.date: 04/03/2026
ms.reviewer: jshotts, v-wendysmith
ms.custom: sap:Administration
---

# Can't install Dynamics 365 Field Service application

## Summary

This article helps administrators resolve problems when trying to install [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview) and see a message stating CDS instance isn't supported or can't find the Field Service app in the app list.

## Symptom

When you try to install the Dynamics 365 Field Service application in your environment, you see the following error message:

> Installing Field Service on a CDS instance is not supported

### Cause

You attempted to install Dynamics 365 Field Service on a bare Common Data Service (CDS) environment that doesn't have a Dataverse organization provisioned or doesn't have **Enable Dynamics 365 apps** turned on.

### Solution

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

1. Select **Manage** > **Environments** and select your environment.

1. Check if the environment has a **Dataverse data store** and if **Enable Dynamics 365 apps** is turned on.

1. If these settings aren't correct, [create a new environment with the correct configuration](/power-platform/admin/create-environment) and retry the installation.

## Symptom

When you try to install the Dynamics 365 Field Service application in your environment, you can't find Field Service in the app list.

### Cause

One or more requirements aren't met.

### Solution

Confirm the following requirements:

- Verify you have a **System Administrator** or **Dynamics 365 admin** role.

- Verify you have an active Field Service license assigned to your account. Sign in to the Microsoft 365 admin center and go to **Billing** > **Licenses**.

- Check if the environment has a **Dataverse data store** and if **Enable Dynamics 365 apps** is turned on. See Symptom 1.

If all requirements are met, try signing out and signing back in, or clear the browser cache.
