---
title: Assets tab indicates to contact an IT administrator
description: Resolves an issue where the Assets tab informs a user to contact an IT administrator in Microsoft Dynamics 365 Remote Assist.
ms.author: davepinch
author: davepinch
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# Assets tab indicates to contact an IT administrator

This article provides a resolution for an issue where the **Assets** tab informs you to contact an IT administrator in Microsoft Dynamics 365 Remote Assist.

## Symptoms

In the HoloLens app, when a user selects the **Assets** tab, Microsoft Dynamics 365 Remote Assist prompts to contact an IT administrator.

> [!NOTE]
> To solve the issue, you need administrator permissions in Dynamics 365 Remote Assist.

## Cause 1: The app isn't installed on the right environment

#### Resolution

To solve this issue, [install the app into the right environment](/dynamics365/mixed-reality/remote-assist/ra-webapp-install#install-the-dynamics-365-remote-assist-model-driven-app).

## Cause 2: The user doesn't have the correct roles assigned

#### Resolution

To solve this issue, follow the steps:

1. Verify that the user has the **Basic User** and **Remote Assist - App User** or **Remote Assist - Administrator** [security roles assigned](/dynamics365/mixed-reality/remote-assist/asset-capture-add-users#assign-dynamics-365-security-roles).

1. Close the app and the live tile, and then reopen it.
