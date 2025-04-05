---
title: Assembly version error when importing solution
description: Solves an assembly version error that might occur when importing a Microsoft Dynamics 365 solution.
ms.date: 03/20/2025
ms.custom: sap:Working with Solutions
---
# Assembly version error when importing a Dynamics 365 solution

This article provides a resolution for an assembly version error that might occur when you import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345239

## Symptoms

When you try to import a solution in Dynamics 365, the import might fail with the following error message:

> The import of solution: [solution name] failed

If you select **Download Log File**, you might see a message like this:

```output
An error occurred while importing a Solution. : Microsoft.Crm.CrmException: 
This plugin assembly uses version {0} of the .NET Framework. 
At this time Microsoft Dynamics 365 requires version {1} of the .NET Framework for plugin assemblies. Rebuild this assembly using .NET Framework version {1} and try again.    at  
Microsoft.Crm.ObjectModel.TargetFrameworkVersionValidator.ValidateInternal()    at Microsoft.Crm.ObjectModel.PluginValidatorBase.Validate()    at  
Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal`1.ValidateAssemblyMetadata(ExecutionContext context, IBusinessEntity pluginAssembly, CrmPluginAssemblyMetadata assemblyMetadata)    at  
Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal`1.VerifyRegistrationAbility(IBusinessEntity pluginAssembly, Boolean createCall, ExecutionContext context, CrmPluginAssemblyMetadata assemblyMetadata)    at  
Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal`1.ValidateOperation(String operationName, IBusinessEntity entity, ExecutionContext context)    at  
Microsoft.Crm.ObjectModel.SdkEntityServiceBase.CreateInternal(IBusinessEntity entity, ExecutionContext context, Boolean verifyAction)    at  
Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.CreateOrGetExistingPluginAssembly(PluginAssembly pluginAssembly, String fileContent, BusinessProcessObject bpoService, Boolean skipValidation, BusinessEntityCollection& existingPluginAssemblies)    at  
Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.ImportItem()
```

In the preceding log, `{0}` represents the .NET Framework version used in the plug-in assembly, which is incompatible, and `{1}` represents the .NET Framework version required by Dynamics 365. Additionally, you might receive error codes such as **8004420B**, **8004418B**, or **-2147204725**.

## Cause

This error occurs when the imported solution includes a plug-in assembly compiled using a version of the .NET Framework that's not currently supported by Dynamics 365.

## Resolution

To solve this issue, recompile the plug-in assembly using the specified version of the .NET Framework, and then reimport the solution.

## More information

- For information about the .NET Framework versions currently supported by Dynamics 365, see [Support for .NET Framework versions](/power-apps/developer/data-platform/supported-customizations#support-for-net-framework-versions).
- For guidelines on configuring and building assemblies for Microsoft Dataverse plug-ins, see [Build and package plug-in code](/power-apps/developer/data-platform/build-and-package).
