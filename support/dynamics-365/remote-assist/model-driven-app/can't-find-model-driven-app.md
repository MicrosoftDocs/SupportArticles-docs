---
title: Can't find the Dynamics 365 Remote Assist model-driven app
description: Provides a resolution for an administrator to help find Microsoft Dynamics 365 Remote Assist model-driven app.
ms.author: davepinch
author: davepinch
ms.date: 10/23/2023
ms.reviewer: v-wendysmith
ms.custom: bap-template
---
# Can't find the Dynamics 365 Remote Assist model-driven app

This article provides a resolution for an administrator to make sure a user can find Microsoft Dynamics 365 Remote Assist model-driven app.

## Symptoms

A user can't find the Dynamics 365 Remote Assist model-driven app.

## Cause

The user doesn't use the right environment or doesn't have the correct security role.

## Resolution

> [!NOTE]
> As an administrator, to solve this issue, you need:
>
> - Admin access to the [Microsoft Power Platform admin center](https://admin.powerplatform.microsoft.com/).
> - Admin access to the [Microsoft 365 admin center](https://admin.microsoft.com/AdminPortal).
> - Admin access to the environment Dynamics 365 Remote Assist is installed in.

1. Check the environment name in the URL to make sure that you're accessing the right environment.

2. Ensure that the [app was installed to the right environment](/dynamics365/mixed-reality/remote-assist/ra-webapp-install#install-the-dynamics-365-remote-assist-model-driven-app).

3. Verify that you have the **Remote Assist - App User** or the **Remote Assist - Administrator** and **Basic User** [security roles assigned](/dynamics365/mixed-reality/remote-assist/asset-capture-add-users#assign-dynamics-365-security-roles).

4. Verify that the [app is enabled](/dynamics365/mixed-reality/remote-assist/asset-capture-add-users#manage-app-roles) for the **Remote Assist - App User** and **Remote Assist - Administrator** security roles.
