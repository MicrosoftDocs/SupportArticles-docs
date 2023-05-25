---
title: Can't deploy a custom solution with Agentscript solution
description: Provides a resolution for a known issue about deploying an Agentscript custom solution in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: vamullap
ms.date: 05/23/2023
---
# Can't deploy a custom Agentscript solution in Omnichannel for Customer Service

This article provides a resolution for the issue where you can't deploy a custom solution with the `Agentscript` solution in Omnichannel for Customer Service.

## Symptoms

When you try to deploy a custom solution, it fails on account of a dependency on the `Agentscript` solution, which is part of Omnichannel for Customer Service.

## Cause

The `Agentscript` solution has been deprecated and wasn't present in the target environment. It has been replaced by the `msdyn_Agentscripts` solution.

## Resolution

It's recommended that you remove all references to the `Agentscript` solution from the custom solution and then reimport the solution.
