---
author: davepinch
description: Learn how to resolve a problem when 3D content doesn't load when authoring in the HoloLens app
ms.author: davepinch
ms.date: 08/07/2023
ms.topic: troubleshooting-problem-resolution
title: Step content failed to load message in the HoloLens app
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Step content failed to load message in the HoloLens app

## Symptom

The following message displays in the HoloLens app:

![Screenshot of Step content failed to load message.](media/step-content-failed-load.jpg "Screenshot of Step content failed to load message")

## Cause

The amount and complexity of content added to the step has reached HoloLens' memory limit, which will result in a poor experience for the operators of the guide. You can't place more 3D models at this point. If a model was previously placed in the world, it's represented as an exclamation point icon to authors and operators.

## Resolution

[!INCLUDE [HoloLens-memory-limit](../includes/hololens-memory-limit.md]