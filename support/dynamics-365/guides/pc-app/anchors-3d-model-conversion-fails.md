---
author: alwinv
description: Learn how to fix an issue when trying to convert a 3D model into an object anchor
ms.author: alwinv
ms.date: 09/13/2023
ms.topic: troubleshooting-problem-resolution
title: Convert a 3D model into an object anchor fails
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Convert a 3D model into an object anchor fails

## Symptoms

When converting a 3D model to use as an object anchor in the Guides model-driven app, the conversion fails.

## Cause

You might find one or more of the following causes:

- The 3D model uses an unsupported file format.

- The physical dimensions of the 3D model are larger than 10 meters or smaller than 1 meter.

- The 3D model file is bigger than the maximum supported file size (150 MB).

## Resolution

1. Follow [best practices for choosing a target object for your object anchor](/dynamics365/mixed-reality/guides/pc-app-anchor-azure-object#best-practices-for-choosing-a-target-object-for-your-object-anchor).

1. Make any necessary adustments to your model and then [convert the file](/dynamics365/mixed-reality/guides/pc-app-anchor-azure-object#convert-the-file-in-the-guides-model-driven-app).