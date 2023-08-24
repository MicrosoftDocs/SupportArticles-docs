---
title: Converting to Managed Solution
description: Works when an unmanaged solution is already installed and attempting to install a newer version of the solution in managed mode in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 08/25/2023
author: swatimadhukargit
ms.author: swatim
---
# Converting to Managed Solution

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when trying to convert an unmanaged solution to a managed solution.

## Symptoms

- The solution is already installed on the target environment as an unmanaged solution and the package supplied is attempting to install it in managed mode. Import can only update solutions when the modes match.
- Customer has previously shipped as unmanaged solution; now they want to move it to managed solution.

You receive an error message like the following ones:

> Microsoft.Crm. Tools.ImportExportPublish.ImportSolutionException: Solution manifest import: FAILURE: The solution is already installed on this system as an unmanaged solution and the package supplied is attempting to install it in managed mode. Import can only update solutions when the modes match. Uninstall the current solution and try again.

> Microsoft.Crm.CrmException: A managed solution cannot overwrite the [Component Name] component  with Id=[Component Id] which has an unmanaged base instance.  The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged [Component Name] component on the target system, and now a managed solution from the same publisher is trying to install that same [Component Name] component as managed.  This will cause an invalid layering of solutions on the target system and is not allowed.

> Microsoft.Crm.CrmException: The import has failed because the system cannot transition the entity form {Form Id} from unmanaged to managed. Add at least one full (root) component to the managed solution, and then try to import it again.

## Cause

By design, the Dataverse platform blocks the managed solution import on an environment for which unmanaged solution is present. Blocking helps to avoid overriding unmanaged solution and for customer to lose the ability to further develop on the solution.

## Workaround

To convert the unmanaged solution to managed solution, uninstall the unmanaged solution, import the solution with convert to managed flag using PACCLI.
