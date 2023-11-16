---
title: The solution is installed on this system
description: Provides a solution to an error that occurs when you attempt to import a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The solution is already installed on this system as an unmanaged solution" error in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you attempt to import a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456697

## Symptoms

When you attempt to import a solution in Dynamics 365, the import fails with the following message:

> "The solution is already installed on this system as an unmanaged solution and the package supplied is attempting to install it in managed mode. Import can only update solutions when the modes match. Uninstall the current solution and try again.  
Error code 80048040"

## Cause

This error occurs if you're importing a managed solution into an organization where the solution already exists as unmanaged.

Example: You create a new solution in your Dynamics 365 organization. When you create a new solution, it's an unmanaged solution. If you export this solution and choose to export it as managed and then try to import it into the same organization, you would receive this error. If you had exported the solution as unmanaged, it would import successfully.

As mentioned in the error message, import can only update solutions when the modes match. Which means that if you already have an unmanaged solution installed, you can only install another version of that solution that is also an unmanaged solution.

## Resolution

Import a copy of the solution that is the same mode. In the example provided in the [Cause](#cause) section, import would succeed if the solution being imported was an unmanaged solution.
