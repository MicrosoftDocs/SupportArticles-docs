---
title: Failure to install Managed Solution when previously deployed as Unmanaged
description: Works when an unmanaged solution is already installed and attempting to install a newer version of the solution in managed mode in Microsoft Power Apps.
ms.reviewer: jdaly
ms.date: 08/25/2023
author: swatimadhukargit
ms.author: swatim
---
# Failure to install Managed Solution when previously deployed as Unmanaged

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when importing a managed solution, which includes components that already exist in an unmanaged state.

## Symptoms

- An unmanaged component is already present on the target environment and the solution supplied during import is attempting to install as managed.
- The solution may have been previously shipped as unmanaged solution; now the desire is to ship managed solutions.

You receive an error message like the following ones:

> Microsoft.Crm. Tools.ImportExportPublish.ImportSolutionException: Solution manifest import: FAILURE: The solution is already installed on this system as an unmanaged solution and the package supplied is attempting to install it in managed mode. Import can only update solutions when the modes match. Uninstall the current solution and try again.

> Microsoft.Crm.CrmException: A managed solution cannot overwrite the [Component Name] component  with Id=[Component Id] which has an unmanaged base instance.  The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged [Component Name] component on the target system, and now a managed solution from the same publisher is trying to install that same [Component Name] component as managed.  This will cause an invalid layering of solutions on the target system and is not allowed.

> Microsoft.Crm.CrmException: The import has failed because the system cannot transition the entity form [Form Id] from unmanaged to managed. Add at least one full (root) component to the managed solution, and then try to import it again.

## Cause

By design, some solution components don't support automatic conversion of unmanaged to managed state without setting the `ConvertToManaged` property.

## Workaround

To successfully convert the unmanaged component to managed state:

- Either delete the unmanaged component and import the solution again.
- Or import the solution with the *convert to managed* option applied. There are several ways to import a solution using this setting:

   - Use Microsoft Power Platform CLI [pac solution import](/power-platform/developer/cli/reference/solution#pac-solution-import) command with the [convert-to-managed](/power-platform/developer/cli/reference/solution#--convert-to-managed--cm) flag set.
   - Use the Dataverse SDK for .NET [ImportSolutionRequest class](xref:Microsoft.Crm.Sdk.Messages.ImportSolutionRequest) setting the [ConvertToManaged property](xref:Microsoft.Crm.Sdk.Messages.ImportSolutionRequest.ConvertToManaged) to `true`.
   - Use the Dataverse Web API [ImportSolution action](xref:Microsoft.Dynamics.CRM.ImportSolution) with the `ConvertToManaged` parameter set to `true`.
   - Use [Power Platform Import Solution build task](/power-platform/alm/devops-build-tool-tasks#power-platform-import-solution) with `ConvertToManaged` parameter set to true.

### See also

[Learn about moving from unmanaged to managed solutions](/power-platform/alm/move-from-unmanaged-managed-alm)
