---
title: Hazard sign appears when loading a step
description: Provides a resolution for an issue where a triangle-shaped hazard sign shows when you load a step in the HoloLens app.
ms.author: alwinv
author: alwinv
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# A hazard sign appears when you load a step

## Symptoms

A triangle-shaped hazard sign appears when you load a step in the HoloLens app.

The hazard sign is a placeholder for 3D models, videos, or images that can't be successfully loaded in the HoloLens app.

## Cause 1: Intermittent connectivity issues or the file is too large

#### Resolution

To solve this issue, relaunch the HoloLens app.

If this resolution doesn't fix the issue, launch the [Dynamics 365 Guides PC app](/dynamics365/mixed-reality/guides/install-sign-in-pc-app), find the file in question, and open it in preview mode.

- If the preview loads, reinstall the HoloLens app and relaunch the guide.
- If the preview doesn't load, there's a problem with the file information in Guides. Upload the file again, and then edit the guide to refer to this new asset wherever applicable.

## Cause 2: Can't find the file in the PC app library

The reference (entity) to the 3D model, video, or image is broken.

#### Resolution

To solve this issue, upload the file again and reauthor the guide.
