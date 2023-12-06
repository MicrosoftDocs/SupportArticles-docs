---
title: Fail to convert a 3D model to an object anchor
description: Provides a resolution for an issue where you fail to convert a 3D model to an object anchor in Microsoft Dynamics 365 Guides.
ms.author: alwinv
author: alwinv
ms.date: 11/14/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# Fail to convert a 3D model to an object anchor

This article provides a resolution for an issue where you fail to convert a 3D model to an object anchor in Microsoft Dynamics 365 Guides.

## Symptoms

When you convert a 3D model to use it as an object anchor in the [Guides model-driven app](/dynamics365/mixed-reality/guides/model-driven-app-overview), the conversion fails.

## Cause

You might find one or more of the following causes:

- The 3D model uses an unsupported file format.
- The physical dimensions of the 3D model are larger than 10 meters or smaller than 1 meter.
- The 3D model file is larger than the maximum supported file size (128 MB).

## Resolution

To solve this issue:

1. Follow [best practices for choosing a target object for your object anchor](/dynamics365/mixed-reality/guides/pc-app-anchor-object-best-practices).
1. Make sure the 3D model uses a [supported file format](/dynamics365/mixed-reality/guides/pc-app-supported-file-formats). For more information, see [Optimize your 3D models to use with Dynamics 365 Guides or in mixed-reality components included in apps created with Power Apps](/dynamics365/mixed-reality/guides/3d-content-guidelines/optimize-models).
1. Make any necessary adjustments to your model and then [convert the file](/dynamics365/mixed-reality/guides/pc-app-anchor-object#convert-the-file-in-the-guides-model-driven-app).
