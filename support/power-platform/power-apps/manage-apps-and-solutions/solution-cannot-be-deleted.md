---
title: Solution cannot be deleted due to dependencies from other components 
description: Describes an issue where the message Solution cannot be deleted due to dependencies from other components in the system is displayed.
ms.reviewer: squassina
ms.topic: troubleshooting
ms.date: 06/18/2021
author: squassina
ms.author: risquass
---
# Solution cannot be deleted due to dependencies from other components

_Applies to:_ &nbsp; Power Platform, Solutions

## Symptoms

Solution cannot be deleted due to dependencies from other components in the system message displayed when uninstalling a solution.

## Cause

This issue can occur when the solution contains components that are referenced by other solutions on top of it in the layer stack.

## Workaround

To work around this issue, either delete the component or remove the dependency from the solution you’re trying to uninstall. More information: [Removing dependencies](/power-platform/alm/removing-dependencies)