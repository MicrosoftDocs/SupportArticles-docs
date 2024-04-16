---
title: Step content failed to load error in the HoloLens app
description: Provides a resolution for an issue where 3D content doesn't load when authoring in the HoloLens app.
ms.author: davepinch
author: davepinch
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: sap:Application Functionality
---
# "Step content failed to load" error occurs in the HoloLens app

## Symptoms

The following error message displays in the HoloLens app:

> Step content failed to load.

:::image type="content" source="media/step-content-fail-load/step-content-failed-to-load-error.png" alt-text="Screenshot that shows the error message about step content failed to load.":::

## Cause

The amount and complexity of content added to the step has reached HoloLens' memory limit, which will result in a poor experience for the operators of the guide. You can't place more 3D models at this point. If a model was previously placed in the world, it's represented as an exclamation point icon to authors and operators.

## Resolution

[!INCLUDE [HoloLens-memory-limit](../includes/hololens-memory-limit.md)]
