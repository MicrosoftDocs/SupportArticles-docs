---
author: alwinv
description: Learn how to fix an issue when loading a step and a hazard sign appears
ms.author: alwinv
ms.date: 09/13/2023
ms.topic: troubleshooting-general
title: Hazard sign appears when trying to load a step
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Hazard sign appears when I load a step

## Symptom

A triangle-shaped hazard sign appears when loading a step.
The hazard sign is a placeholder for 3D models, videos, or images that can't be successfully loaded in the HoloLens app.

## Cause 1: Intermittent connectivity issues or the file is too large

### Resolution

1. Relaunch the HoloLens app.

1. If this doesn't fix the problem, launch the PC app, find the file in question, and open it in preview mode.

1. If the preview loads, reinstall the HoloLens app and try launching the guide again.

1. If the preview doesn't load, there's a problem with the file information in Guides. Upload the file again, and then edit the guide to refer to this new asset wherever applicable.

## Cause 2: Can't find the file in the PC app library

The reference (entity) to the 3D model/video/image is broken.

### Resolution

Upload the file again and re-author the guide.