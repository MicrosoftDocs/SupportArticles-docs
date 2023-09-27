---
author: davepinch
description: Learn how to resolve a problem when the installation or update of the Dynamics 365 Guides solution fails
ms.author: davepinch
ms.date: 09/07/2023
ms.topic: troubleshooting-problem-resolution
title: The solution installation or update fails repeatedly
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# The solution installation or update fails repeatedly

## Symptom

When trying to install or update the Guides solution, the message "Installation failed" displays.

## Cause

Missing one or all of the following requirements:

- [System Administrator](/power-platform/admin/database-security) role
- A [Dynamics 365 Guides license assigned to your account](dynamics365/mixed-reality/guides/add-users#assign-a-dynamics-365-guides-license-to-an-existing-user)
- [Power Apps license](/power-platform/admin/signup-question-and-answer) (or a license like a [Dynamics 365 Guides license](dynamics365/mixed-reality/guides/setup-step-one) that includes a Power Apps license)

## Resolution

1. Make sure you have the [System Administrator](/power-platform/admin/database-security) role AND a [Power Apps license](/power-platform/admin/signup-question-and-answer) (or a license that includes a Power Apps license) and then try the install.

   ![Dynamics 365 Guides license selected.](media/dynamics-365-guides-license.PNG "Dynamics 365 Guides license selected")

1. Go to the [solution history page](/power-apps/maker/data-platform/solution-history). Review details about solution installations to see if you can find the source of the error.

1. If the installation still fails, contact customer service at <https://dynamics.microsoft.com/support/>.