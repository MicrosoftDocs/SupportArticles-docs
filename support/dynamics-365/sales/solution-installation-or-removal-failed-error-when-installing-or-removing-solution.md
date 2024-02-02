---
title: The solution installation or removal failed error when installing or removing a solution
description: The solution installation or removal failed due to the installation or removal of another solution at the same time - this error occurs when you try to install or remove a solution in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The solution installation or removal failed" when installing or removing a solution

This article provides a resolution to avoid the error **The solution installation or removal failed due to the installation or removal of another solution at the same time** when you try to install or remove a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4343228

## Symptoms

When attempting to install or remove a solution in Microsoft Dynamics 365, you see a message that says:

> The import of solution \<solution name> failed.

If you select **Download Log file**, you see the following error:

> The solution installation or removal failed due to the installation or removal of another solution at the same time. Please try again later.

You may also see a reference to error code **-2147020463** or **80071151**.

## Cause

This error can occur if you try to install or remove a solution but another solution is already in the process of being installed or removed. This may occur if you or another user are doing another install or removal action at the same time.

> [!NOTE]
> If you or someone else in your organization are enabling a feature, that feature may install one or more solutions as part of the deployment process.

## Resolution

If someone is installing or removing another solution, wait for that action to complete before attempting to install or remove another solution.
