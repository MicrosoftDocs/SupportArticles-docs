---
title: Cannot import the patch for the solution
description: Provides a solution to an error that occurs when importing a solution patch in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "You can't import the patch ([patch name]) for the solution ([solution name]) because the solution isn't present" error occurs when importing a solution patch in Microsoft Dynamics 365

This article provides a solution to an error that occurs when importing a solution patch in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471079

## Symptoms

When you attempt to import a solution patch in Dynamics 365, you receive the following error:

> "You can't import the patch ([patch name]) for the solution ([solution name]) because the solution isn't present. The operation has been canceled.  
Error code 80048540."

## Cause

This error occurs if you're trying to import a solution patch for a solution that isn't installed.

For example: Assume you have a solution named SolutionA. If there's a patch created for this solution (SolutionA_Patch1) and you try to import it into an environment that doesn't have SolutionA already installed, you would receive this error.

## Resolution

Verify the solution name mentioned in the error is already installed in the environment where you're trying to import the patch.

Using the example mentioned in the [Cause](#cause) section, you would need to make sure you have SolutionA installed before you can install SolutionA_Patch1. For more information about solution patches, see [Create patches to simplify solution updates](/dynamics365/customerengagement/on-premises/developer/create-patches-simplify-solution-updates).
