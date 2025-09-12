---
title: Fail to detect an object anchor in the HoloLens app
description: Provides a resolutin for an issue where you fail to detect an object anchor in the Microsoft HoloLens app.
author: alwinv
ms.author: alwinv
ms.date: 10/27/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: sap:Application Functionality
---
# Fail to detect an object anchor in the HoloLens app

This article provides a resolution for an issue where you fail to detect an object anchor in the Microsoft HoloLens app.

## Symptoms

Trying to detect the object anchor in the HoloLens app fails.

## Cause

You might find one or more of the following causes:

- An incorrect **Length Unit** type is specified during model conversion.
- An incorrect gravity direction is specified during model conversion.
- The 3D model provided during model conversion doesn't resemble the surfaces of the actual object detected by the HoloLens sensors.

## Resolution

To solve this issue,

1. Confirm object measurements and the **Length Unit** type by double-clicking the object anchor in the PC app to open the **Properties** tab.

   :::image type="content" source="media/fail-to-detect-object-anchor/object-anchor-chair-properties.png" alt-text="Screenshot that shows the Properties tab with My chair measurements." border="false":::

   - If the dimensions of the object in the **Properties** tab are different from the actual object dimensions by a factor of two or more, an incorrect **Length Unit** type is likely to be used.

   - If the gravity direction of the model in the **Properties** tab (the down direction) is different from the actual orientation of the object in its environment, an incorrect gravity direction is likely to be used (for example, if the chair in the example above is shown upside down or with its legs pointing to the side instead of pointing down).

   - 3D models that are converted correctly might not be detected on HoloLens if their model geometries differ greatly from the surfaces detected by HoloLens.

   You can view the object anchor geometry in the **Properties** tab and compare that with the Surface Reconstruction (SR) mesh of the object as seen by HoloLens. To view the object's SR mesh, air tap while viewing the object in the HoloLens shell. A large difference in geometry between the anchor geometry and SR mesh indicates potential difficulty with object anchoring.

1. Follow [best practices for choosing a target object for your object anchor](/dynamics365/mixed-reality/guides/pc-app-anchor-object#best-practices-for-choosing-a-target-object-for-your-object-anchor).

1. Make any necessary adjustments to your model and then [convert the file](/dynamics365/mixed-reality/guides/pc-app-anchor-object#convert-the-file-in-the-guides-model-driven-app).
