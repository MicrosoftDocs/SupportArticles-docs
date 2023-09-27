---
author: davepinch
description: Learn how to find the Dynamics 365 Remote Assist model-driven app
ms.author: davepinch
ms.date: 09/12/2023
ms.topic: troubleshooting-problem-resolution
title: Can't find the Dynamics 365 Remote Assist model-driven app
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Can't find the Dynamics 365 Remote Assist model-driven app

Learn how to find the Dynamics 365 Remote Assist model-driven app.

## Symptoms

A user can't find the Dynamics 365 Remote Assist model-driven app.

## Cause

The user isn't using the right environment or doesn't have the correct security roles.

## Resolution

1. Check to see whether you're accessing the right environment by checking the environment name in the URL.

2. Ensure that the [app was installed to the right environment.](dynamics365/mixed-reality/remote-assist/ra-webapp-install#install-the-dynamics-365-remote-assist-model-driven-app)

3. Verify that the user has the **Remote Assist - App User** or the **Remote Assist - Administrator** and **Basic User** [security roles assigned.](dynamics365/mixed-reality/remote-assist/asset-capture-add-users#assign-dynamics-365-security-roles)

4. Verify that the [app is enabled](dynamics365/mixed-reality/remote-assist/asset-capture-add-users#manage-app-roles) for the **Remote Assist - App User** and **Remote Assist - Administrator** security roles.