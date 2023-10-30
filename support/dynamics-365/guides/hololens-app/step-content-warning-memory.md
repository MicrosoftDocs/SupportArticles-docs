---
title: High step memory usage warning in the HoloLens app
description: Learn how to resolve a problem when a high memory usage warning message displays when authoring in the HoloLens app.
ms.author: davepinch
author: davepinch
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# "High step memory usage" warning occurs in the HoloLens app

## Symptoms

The following warning message displays in the HoloLens app:

> Warning! High step memory usage.

:::image type="content" source="media/step-content-warning-memory/high-step-memory-usage-warning.png" alt-text="Screenshot that shows the warning message about high step memory usage.":::

## Cause

The 3D models that you place for the step reach HoloLens' memory limit. The 3D models will display, but the operator might have a degraded experience. For example, the guide might have low frame rates or there might be noticeable loading times when moving between steps.

If you continue to add the 3D models and HoloLens, the ["Step content failed to load"](step-content-fail-load.md) error message will occur.

## Resolution

[!INCLUDE [HoloLens-memory-limit](../includes/hololens-memory-limit.md)]
