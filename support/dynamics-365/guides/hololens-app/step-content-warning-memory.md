---
author: davepinch
description: Learn how to resolve a problem when a high memory usage warning displays when authoring in the HoloLens app
ms.author: davepinch
ms.date: 07/07/2023
ms.topic: troubleshooting-problem-resolution
title: High step memory usage message in the HoloLens app
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# High step memory usage message in the HoloLens app

## Symptom

The following message displays in the HoloLens app:

![Screenshot of warning message.](media/step-content-warning.jpg "Screenshot of warning message about high step memory usage")

## Cause

The 3D models that you placed for the step are reaching HoloLens' memory limit. Models will display but the operator may have a degraded experience. For example, the guide may have low frame rates or there may be noticeable loading times when moving between steps.

If you continue to add 3D models and HoloLens reaches its memory limit, the [Step content failed to load](step-content-fail-load.md) message displays.

## Resolution

[!INCLUDE [HoloLens-memory-limit](../includes/hololens-memory-limit.md]