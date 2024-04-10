---
title: Assembly version error when importing solution
description: You may receive an assembly version error when importing a Microsoft Dynamics 365 solution. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Assembly version error when importing a Microsoft Dynamics 365 solution

This article provides a resolution for the assembly version error that occurs when you import a solution in Microsoft Dynamics 365 (online).

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345239

## Symptoms

When you attempt to import a solution in Microsoft Dynamics 365 (online), the import fails with the following message:

> The import of solution: [solution name] failed

If you select **Download Log File**, you see details similar to the following message:

> An error occurred while importing a Solution. : Microsoft.Crm.CrmException: This plugin assembly uses version {0} of the .NET Framework. At this time Microsoft Dynamics 365 requires version {1} of the .NET Framework for plugin assemblies. Rebuild this assembly using .NET Framework version {1} and try again.    at  Microsoft.Crm.ObjectModel.TargetFrameworkVersionValidator.ValidateInternal()    at Microsoft.Crm.ObjectModel.PluginValidatorBase.Validate()    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.ValidateAssemblyMetadata(ExecutionContext context, IBusinessEntity pluginAssembly, CrmPluginAssemblyMetadata assemblyMetadata)    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.VerifyRegistrationAbility(IBusinessEntity pluginAssembly, Boolean createCall, ExecutionContext context, CrmPluginAssemblyMetadata assemblyMetadata)    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.ValidateOperation(String operationName, IBusinessEntity entity, ExecutionContext context)    at  Microsoft.Crm.ObjectModel.SdkEntityServiceBase.CreateInternal(IBusinessEntity entity, ExecutionContext context, Boolean verifyAction)    at  Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.CreateOrGetExistingPluginAssembly(PluginAssembly pluginAssembly, String fileContent, BusinessProcessObject bpoService, Boolean skipValidation, BusinessEntityCollection& existingPluginAssemblies)    at  Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.ImportItem()

In the example provided above, {0} is a version that is too high and {1} is the currently supported version. You may also see a reference to error code **8004420B**, **8004418B**, or **-2147204725**.

## Cause

This error can occur if you are trying to import a solution that includes a plugin assembly compiled on a version of the .NET Framework that is not currently supported by Microsoft Dynamics 365 (online).

## Resolution

Recompile the assembly using the mentioned version of the .NET Framework.

For information about the .NET Framework version currently supported by Microsoft Dynamics 365 (online), see [Supported extensions for Microsoft Dynamics 365](/previous-versions/dynamicscrm-2016/developers-guide/gg328350(v=crm.8)).
