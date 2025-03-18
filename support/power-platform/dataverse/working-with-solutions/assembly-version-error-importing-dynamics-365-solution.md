---
title: Assembly version error when importing solution
description: Solves the assembly version error that might occur when importing a Microsoft Dynamics 365 solution.
ms.reviewer: 
ms.date: 03/31/2021
ms.custom: sap:Working with Solutions
---
# Assembly version error when importing a Dynamics 365 solution

This article provides a resolution for the assembly version error that might occur when you import a solution in Microsoft Dynamics 365 (online).

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4345239

## Symptoms

When you try to [import a solution in Dynamics 365 (online)](/dynamics365/customerengagement/on-premises/customize/import-update-upgrade-solution), the import might fail with the following error message:

> The import of solution: [solution name] failed

If you select **Download Log File**, you might see a message like this:

> An error occurred while importing a Solution. : Microsoft.Crm.CrmException: This plugin assembly uses version {0} of the .NET Framework. At this time Microsoft Dynamics 365 requires version {1} of the .NET Framework for plugin assemblies. Rebuild this assembly using .NET Framework version {1} and try again.    at  Microsoft.Crm.ObjectModel.TargetFrameworkVersionValidator.ValidateInternal()    at Microsoft.Crm.ObjectModel.PluginValidatorBase.Validate()    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.ValidateAssemblyMetadata(ExecutionContext context, IBusinessEntity pluginAssembly, CrmPluginAssemblyMetadata assemblyMetadata)    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.VerifyRegistrationAbility(IBusinessEntity pluginAssembly, Boolean createCall, ExecutionContext context, CrmPluginAssemblyMetadata assemblyMetadata)    at  Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.ValidateOperation(String operationName, IBusinessEntity entity, ExecutionContext context)    at  Microsoft.Crm.ObjectModel.SdkEntityServiceBase.CreateInternal(IBusinessEntity entity, ExecutionContext context, Boolean verifyAction)    at  Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.CreateOrGetExistingPluginAssembly(PluginAssembly pluginAssembly, String fileContent, BusinessProcessObject bpoService, Boolean skipValidation, BusinessEntityCollection& existingPluginAssemblies)    at  Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.ImportItem()

In the above log, {0} represents the .NET Framework version used in the plugin assembly, which is incompatible, and {1} represents the required version of the .NET Framework for Dynamics 365. Additionally, you might receive error codes such as **8004420B**, **8004418B**, or **-2147204725**.

## Cause

This error occurs when the solution being imported includes a plugin assembly compiled using a version of the .NET Framework that's not currently supported by Dynamics 365 (online).

## Resolution

To solve this issue, recompile the plugin assembly using the specified version of the .NET Framework. Then, try to re-import the solution after recompiling the assembly.

## More information

- For information about the .NET Framework version currently supported by Dynamics 365 (online), see [Supported extensions for Microsoft Dynamics 365](/previous-versions/dynamicscrm-2016/developers-guide/gg328350(v=crm.8)).
- [Support considerations for custom code written the Microsoft .NET Framework 4.6.2](/power-apps/developer/data-platform/supported-customizations#support-for-net-framework-versions).
- For guidelines on configuring and building assemblies for Microsoft Dataverse plug-ins, see [Build and package plug-in code](/power-apps/developer/data-platform/build-and-package).
