---
title: Solution can't be deleted due to dependencies from other components 
description: Works around the Solution cannot be deleted due to dependencies from other components in the system message that occurs when you uninstall a solution.
ms.reviewer: matp
ms.date: 07/26/2023
author: nhelgren
ms.author: nhelgren
ms.custom: sap:Working with Solutions
---
# "Solution cannot be deleted due to dependencies from other components" message when you uninstall a solution

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

When you try to uninstall a solution, you receive the following message:

> Solution cannot be deleted due to dependencies from other components in the system.

## Cause

This issue can occur when the solution contains components that are referenced by other solutions on top of it in the layer stack.

## Workaround

To work around this issue, delete the component or [remove the dependency](/power-platform/alm/removing-dependencies) from the solution you try to uninstall.
