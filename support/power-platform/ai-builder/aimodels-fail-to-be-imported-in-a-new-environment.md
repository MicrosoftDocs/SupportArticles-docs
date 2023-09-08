---
title: AI models fail to be imported in a new environment
description: Provides a resolution for the error that occurs when AI models fail to be imported in a new environment.
ms.reviewer: angieandrews, chplanty
ms.date: 04/20/2023
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

AI models are in an error state after importing them in a new environment.

## Resolution

Follow these steps to try to resolve the issue:

1. Uninstall the solution containing the model(s).
1. If your solution is unmanaged, manually delete the models on the AI Builder model page.
1. Reinstall the solution containing the model(s).
1. Wait for the end of the **Importing** state for each model.

If these steps don't resolve your issue, you can try to update to a new version of the model:

1. Run a new training in the "source" environment.
1. When the training is complete, publish the model.
1. Export the model to a new version of the solution.
1. Import the new solution version into the "target" environment.

If the problem persists (for example, no new model gets fixed by this sequence), contact the support team.
