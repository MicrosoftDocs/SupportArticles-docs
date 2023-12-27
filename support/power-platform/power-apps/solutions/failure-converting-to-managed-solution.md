---
title: Can't install a managed solution that's previously deployed as unmanaged in Power Apps
description: Works around an issue that occurs when an unmanaged solution is already installed and you try to install a later version of it in managed mode in Microsoft Power Apps. 
ms.reviewer: jdaly
ms.date: 08/29/2023
author: swatimadhukargit
ms.author: swatim
---
# Can't install a managed solution when it was previously deployed as unmanaged

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when importing a [managed solution](/power-platform/alm/solution-concepts-alm#managed-and-unmanaged-solutions) that includes components that already exist in an unmanaged state in Microsoft Power Apps.

## Symptoms

You see the following errors when installing a managed solution:

- > Microsoft.Crm. Tools.ImportExportPublish.ImportSolutionException: Solution manifest import: FAILURE: The solution is already installed on this system as an unmanaged solution and the package supplied is attempting to install it in managed mode. Import can only update solutions when the modes match. Uninstall the current solution and try again.

- > Microsoft.Crm.CrmException: A managed solution cannot overwrite the [Component Name] component  with Id=[Component ID] which has an unmanaged base instance.  The most likely scenario for this error is that an unmanaged solution has installed a new unmanaged [Component Name] component on the target system, and now a managed solution from the same publisher is trying to install that same [Component Name] component as managed.  This will cause an invalid layering of solutions on the target system and is not allowed.

- > Microsoft.Crm.CrmException: The import has failed because the system cannot transition the entity form [Form ID] from unmanaged to managed. Add at least one full (root) component to the managed solution, and then try to import it again.

## Cause

This behavior is by design. You can't install a managed solution when the following are true:

- A component of the managed solution already exists as part of an unmanaged solution in the target environment.
- The solution has been previously installed as an unmanaged solution, or the managed solution was exported from an unmanaged solution in the target environment.

Some solution components don't support automatic conversion of unmanaged to managed state without setting the `ConvertToManaged` property.

## Workaround

To successfully convert the unmanaged component to a managed state, use one of the following workarounds:

- Delete the unmanaged component and import the solution again.
- Import the solution with the **convert to managed** option applied. There are several ways to import a solution using this setting:
  - Use the Microsoft Power Platform CLI [pac solution import](/power-platform/developer/cli/reference/solution#pac-solution-import) command with the [convert-to-managed](/power-platform/developer/cli/reference/solution#--convert-to-managed--cm) flag set.
  - Use the Dataverse SDK for .NET [ImportSolutionRequest class](xref:Microsoft.Crm.Sdk.Messages.ImportSolutionRequest) to set the [ConvertToManaged property](xref:Microsoft.Crm.Sdk.Messages.ImportSolutionRequest.ConvertToManaged) to `true`.
  - Use the Dataverse Web API [ImportSolution action](xref:Microsoft.Dynamics.CRM.ImportSolution) with the `ConvertToManaged` parameter set to `true`.
  - Use the [Power Platform Import Solution build task](/power-platform/alm/devops-build-tool-tasks#power-platform-import-solution) with the `ConvertToManaged` parameter set to `true`.

### More information

[Learn about moving from unmanaged to managed solutions](/power-platform/alm/move-from-unmanaged-managed-alm)
