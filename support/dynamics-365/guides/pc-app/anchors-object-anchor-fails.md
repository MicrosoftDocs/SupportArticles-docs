---
author: alwinv
description: Learn how to fix an issue when trying to detect an Azure Object Anchor in HoloLens 
ms.author: alwinv
ms.date: 09/13/2023
ms.topic: troubleshooting-problem-resolution
title: Troubleshoot Azure Object Anchors
ms.reviewer: v-wendysmith
ms.custom: bap-template
---

# Detect an object anchor on HoloLens fails

## Symptoms

Trying to detect the object anchor in the HoloLens app fails.

## Cause

You might find one or more of the following causes:

- Incorrect **Length Unit** type specified during model conversion

- Incorrect gravity direction specified during model conversion

- The 3D model provided during model conversion doesn't resemble the surfaces of the actual object detected by the HoloLens sensors

## Resolution

1. Confirm object measurements and **Length Unit** type by double-clicking the object anchor in the PC app to open the **Properties** tab.
  
   ![Properties tab with My chair measurements](media/AOA-chair-properties.PNG "Properties tab with My chair measurements")

   - If the dimensions of the object in the **Properties** tab are different from the actual object dimensions by a factor of 2 or more, an incorrect **Length Unit** type was likely used.

   - If the gravity direction of the model in the **Properties** tab (the down direction) is different from the actual orientation of the object in its environment, an incorrect gravity direction was likely used (for example, if the chair in the above example is shown upside down or with its legs pointing to the side instead of pointing down).

   - 3D models that are converted correctly may not be detected on HoloLens if their model geometries differ greatly from the surfaces detected by HoloLens. You can view the object anchor geometry in the **Properties** tab and compare that with the Surface Reconstruction (SR) mesh of the object as seen by HoloLens. To view the object’s SR mesh, air tap while viewing the object in the HoloLens shell. A large difference in geometry between the anchor geometry and SR mesh indicates potential difficulty with object anchoring.

1. Follow [best practices for choosing a target object for your object anchor](/dynamics365/mixed-reality/guides/pc-app-anchor-azure-object#best-practices-for-choosing-a-target-object-for-your-object-anchor).

1. Make any necessary adustments to your model and then [convert the file](/dynamics365/mixed-reality/guides/pc-app-anchor-azure-object#convert-the-file-in-the-guides-model-driven-app).