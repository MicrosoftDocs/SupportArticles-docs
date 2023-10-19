---
title: Fail to convert a 3D model to an object anchor
description: Provides a resoution for an issue where you fail to convert a 3D model to an object anchor in Microsoft Dynamics 365 Guides.
ms.author: alwinv
author: alwinv
ms.date: 10/19/2023
ms.reviewer: v-wendysmith
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
- The 3D model file is bigger than the maximum supported file size (150 MB).

## Resolution

To solve this issue,

1. Follow [best practices for choosing a target object for your object anchor](/dynamics365/mixed-reality/guides/pc-app-anchor-object#best-practices-for-choosing-a-target-object-for-your-object-anchor).

1. Make any necessary adustments to your model and then [convert the file](/dynamics365/mixed-reality/guides/pc-app-anchor-object#convert-the-file-in-the-guides-model-driven-app).
