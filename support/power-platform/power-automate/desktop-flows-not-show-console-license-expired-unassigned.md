---
title: Desktop flows don't appear in console after license expired or unassigned
description: Provides a resolution for the issue that desktop flows aren't visible if you don't have an active license in Power Automate for desktop.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.subservice: power-automate-desktop-flows
---
# Desktop flows don't show in Power Automate console after the license expired or unassigned

This article provides a resolution to an issue where you can't find desktop flows in Microsoft Power Automate for desktop console after the license expired or unassigned.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 5015380

## Symptoms

You can't find any of your desktop flows that are stored in non-default environments in Microsoft Power Automate for desktop console.

## Verifying issue

Go to any non-default environment and make sure that your flows aren't visible. Then, switch to the default environment and make sure that you have access to your flows.

## Cause

Since you don't have an active license, you no longer have access to desktop flows that are stored within non-default environments. You now only have access to the default environment or Pay-as-you-go enabled environments.

## Resolution

To solve this issue, export the desktop flows from the non-default environment and import them to the default:

1. Go to [Power Automate Portal](https://flow.microsoft.com).
2. Switch to the non-default environment where your missing flows are stored.
3. Go to **Solutions**.
4. If your desktop flows aren't already into a solution, create a new solution and add the existing desktop flows.
5. Export the solution.
6. Switch to the default environment and then import the solution.

Your desktop flows are now available in the default environment.

If you don't have sufficient permission to complete the above steps, contact your administrator.
