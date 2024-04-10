---
title: The solution is installed as a managed one
description: Provides a solution to the 80048041 error that occurs when attempting to import a solution in Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# "The solution is already installed on this system as a managed solution" error in Microsoft Dynamics 365

This article provides a solution to an error that occurs when attempting to import a solution in Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4456771

## Symptoms

When attempting to import a solution in Dynamics 365, you receive the following error:

> "The solution is already installed on this system as a managed solution and the package supplied is attempting to install it in unmanaged mode. Import can only update solutions when the modes match. Uninstall the current solution and try again.  
Error code 80048041"

## Cause

As mentioned within the error message, the solution is already installed on this system as a managed solution and the package supplied is attempting to install it in unmanaged mode. Import can only update solutions when the modes match.

Example: You create a solution in your development environment and export it as managed. You then import the solution to your production environment. If you later export this solution from your development environment as unmanaged and try to import it into your production environment where the solution is already installed as managed, you'll receive this error.

## Resolution

Once a solution is installed in an environment as managed, you should only import the managed version of the solution into the environment.

Import a copy of the solution that is the same mode. In the example provided in the [Cause](#cause) section, import would succeed if the solution being imported was a managed solution.

## More information

For more information about managed and unmanaged solutions, see [Unmanaged and managed solutions](/dynamics365/customerengagement/on-premises/developer/introduction-solutions#unmanaged-and-managed-solutions).
