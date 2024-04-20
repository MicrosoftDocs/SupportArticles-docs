---
title: Solution installation or update fails repeatedly
description: Provides a resolution for an issue where the installation or update of the Dynamics 365 Guides solution fails.
ms.author: davepinch
author: davepinch
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: sap:Setup and configuration
---
# "Installation failed" error occurs during solution installation or update

This article provides a resolution for an issue where you receive an "Installation failed" error when trying to install or update the Microsoft Dynamics 365 Guides solution.

## Symptoms

When you try to [install](/dynamics365/mixed-reality/guides/setup-step-two) or [update](/dynamics365/mixed-reality/guides/upgrade) the Dynamics 365 Guides solution, the "Installation failed" error message occurs.

## Cause

This issue occurs because any of the following requirements isn't met:

- The [System Administrator](/power-platform/admin/database-security) role.
- A [Dynamics 365 Guides license assigned to your account](/dynamics365/mixed-reality/guides/add-users#assign-a-dynamics-365-guides-license-to-an-existing-user).
- A [Power Apps license](/power-platform/admin/signup-question-and-answer) (or a license like a [Dynamics 365 Guides license](/dynamics365/mixed-reality/guides/setup-step-one) that includes a Power Apps license).

## Resolution

1. Make sure you have the [System Administrator](/power-platform/admin/database-security) role and a [Power Apps license](/power-platform/admin/signup-question-and-answer) (or a license that includes a Power Apps license), and then install or update the Guides solution.

   :::image type="content" source="media/install-update-fails/dynamics-365-guides-license.png" alt-text="Screenshot that shows the Dynamics 365 Guides license option that should be selected in the Apps list when you assign the Dynamics 365 Guides license to user accounts.":::

1. Go to the [solution history page](/power-apps/maker/data-platform/solution-history). Review details about solution installations to see if you can find the source of the error.

If the installation still fails, contact [Dynamics 365 support](https://dynamics.microsoft.com/support/).
