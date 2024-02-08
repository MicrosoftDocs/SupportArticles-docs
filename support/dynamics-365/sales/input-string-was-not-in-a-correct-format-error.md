---
title: Input string was not in a correct format error when importing solution
description: When you import a solution in Microsoft Dynamics 365, you receive an error that states input string was not in a correct format thrown by the application when processing a custom (plug-in) assembly. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-custom-solutions
---
# Input string was not in a correct format error when importing a solution in Microsoft Dynamics 365

This article provides a resolution for the error **Input string was not in a correct format** that may occur when you try to import a solution in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4464324

## Symptoms

When attempting to import a solution in Microsoft Dynamics 365, the solution import fails with the following message:

> The import of solution: [solution name] failed

If you view the details in the grid that is included and select Download Log File, you see details such as the following:

> Input string was not in a correct format thrown by the application when processing a custom (plug-in) assembly.  
0x80048033 Input string was not in a correct format."

The following error details are also included:

> Microsoft.Crm.Tools.ImportExportPublish.ImportSolutionException: Plugin Assemblies import: FAILURE. Error: Plugin: \<ASSEMBLY NAME>, Version=0.0.0.0, Culture=neutral, PublicKeyToken=[token] caused an exception. --->  
System.FormatException: Input string was not in a correct format.  
at System.Text.StringBuilder.AppendFormat(IFormatProvider provider, String format, Object[] args)  
at System.String.Format(IFormatProvider provider, String format, Object[] args)  
at Microsoft.Crm.ObjectModel.TargetFrameworkVersionValidator.ValidateInternal()  
at Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.ValidateAssemblyMetadata(ExecutionContext context, IBusinessEntity pluginAssembly, CrmPluginAssemblyMetadata assemblyMetadata)  
at Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal\`1.VerifyRegistrationAbility(IBusinessEntity pluginAssembly, Boolean createCall, ExecutionContext context)  
at Microsoft.Crm.ObjectModel.SdkEntityServiceBase.UpdateInternal(IBusinessEntity entity, ExecutionContext context, Boolean verifyAction)  
at Microsoft.Crm.ObjectModel.PluginAssemblyServiceInternal`1.Update(IBusinessEntity entity, ExecutionContext context)  
at Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.ImportItem()  
--- End of inner exception stack trace ---  
at Microsoft.Crm.Tools.ImportExportPublish.ImportPluginAssemblyHandler.ImportItem()  
at Microsoft.Crm.Tools.ImportExportPublish.ImportHandler.Import()  
at Microsoft.Crm.Tools.ImportExportPublish.RootImportHandler.ImportAndUpdateProgress(ImportHandler ih)  
at Microsoft.Crm.Tools.ImportExportPublish.RootImportHandler.ProcessNonMetadataHandlers(String[] ImportEntities, ImportHandler& ihForCurrentPath, CounterList listCounters)  
at Microsoft.Crm.Tools.ImportExportPublish.RootImportHandler.RunImport(String[] ImportEntities)  
at Microsoft.Crm.Tools.ImportExportPublish.ImportXml.RunImport(String[] ImportEntities)  
at Microsoft.Crm.Tools.ImportExportPublish.ImportXml.RunImport()  
at Microsoft.Crm.Tools.ImportExportPublish.ImportXml.RunImport(Boolean withSolutionManifest)  
at Microsoft.Crm.WebServices.ImportXmlService.ImportSolutionSkipCapable(Boolean overwriteUnmanagedCustomizations, Boolean publishWorkflows, Byte[] customizationFile, Guid importJobId, Boolean convertToManaged, Boolean skipProductUpdateDependencies, Boolean holdingSolution, ExecutionContext context)

## Cause

This error can occur if the plug-in assembly is using a later version of the .NET Framework such as 4.6.1 and 4.6.2. Currently [Microsoft Dynamics 365 (online) only supports .NET SDK assemblies built on .NET Framework 4.5.2](/dynamics365/customerengagement/on-premises/developer/visual-studio-dot-net-framework).

## Resolution

The affected assembly must be compiled with .NET Framework 4.5.2:

1. Open Visual Studio.
2. Right-click on the project that contains the affected assembly and select **Properties**.
3. Change the Target framework to .NET Framework 4.5.2.
