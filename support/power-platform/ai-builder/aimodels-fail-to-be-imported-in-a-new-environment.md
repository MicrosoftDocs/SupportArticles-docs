---
title: AI models fail to be imported in a new environment
description: Provides a resolution for the error that occurs when AI models fail to be imported in a new environment.
ms.reviewer: angieandrews
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: 
ms.author: angieandrews
author: v-aangie
---

# AI models fail to be imported in a new environment

This article provides a solution to an error that occurs when AI models fail to be imported in a new environment.

_Applies to:_ &nbsp; Power Automate, Power Apps

## Symptoms

Your AI models fail to be imported in a new environment.

## Cause

AI models are in error state after importing them in a new environment.

## Resolution

Here's a sequence of actions you can try to resolve the issue.

1. Uninstall the solution containing the model(s).
1. If your solution is unmanaged, manually delete the models in the AI Builder model page.
1. Reinstall the solution containing the model(s).
1. Wait for the end of the **Importing** state for each model.

If this doesn't resolve, you can try to update to a new version of the model:

1. run a new training in the 'source' environment, and publish the model when trainnig is complete.
1. export the model to a new version of the solution.
1. import the new solution version into the 'target' environment.

If the problem persists (no new model gets fixed by this sequence), contact the support team.
