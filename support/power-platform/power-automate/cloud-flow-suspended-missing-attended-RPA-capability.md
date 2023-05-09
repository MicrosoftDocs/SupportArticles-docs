---
title: Cloud flow suspended because owner is missing attended RPA capability
description: Provides a resolution for the issue where a cloud flow is suspended because its owner is missing the attended RPA capability.
ms.reviewer: 
ms.author: cvassallo
author: V-Camille
ms.date: 05/09/2023
ms.subservice: power-automate-desktop-flows
---
# Cloud flow suspended - Missing attended RPA capability

This article provides a resolution for the issue where a cloud flow is suspended because its owner is missing the attended RPA capability.

_Applies to:_ &nbsp; Power Automate <br><br>

## Symptoms

You just created a new cloud flow with a desktop flow card in attended mode :

![cloud-flow-with-attended-desktop-flow-card](media/cloud-flow-suspended-missing-attended-RPA-permission/cloud-flow-canvas.png)<br><br>

... after save time you see that the cloud flow can't be triggered (the `Run` button on the top panel is also deactivated) and has the status `Suspended` :

![cloud-flow-suspended](media/cloud-flow-suspended-missing-attended-RPA-permission/cloud-flow-suspended.png)<br><br><br>


## Cause

If you click on the `Flow checker` button, a specfic message informs you that the user owning this cloud flow needs the attended RPA capability : 

![flow-checker](media/cloud-flow-suspended-missing-attended-RPA-permission/flow-checker.png) <br>

You can double check your user capabilities by clicking on `Settings` (the gear icon on top right) >> `View my Licenses` : 

![view-my-licenses](media/cloud-flow-suspended-missing-attended-RPA-permission/view-my-licenses.png) <br><br><br>


## Resolution

There are 3 solutions to solve this licensing issue : 
- The user owning the cloud flow needs to get assigned a "Per user plan with attended RPA" license as described in the flow checker message. To do so, the flow checker offers 2 options : send a license request to the admin or buy your own license.
- Start a trial as offered in the flow checker message
- Assign a "Per flow plan" to the cloud flow by clicked on `Details` > `Edit` : 

![assign-per-flow-plan](media/cloud-flow-suspended-missing-attended-RPA-permission/assign-per-flow-plan.png) 


> If no Per flow plan is available on the environment, you need to contact your admin to get one allocated.

<br><br>
