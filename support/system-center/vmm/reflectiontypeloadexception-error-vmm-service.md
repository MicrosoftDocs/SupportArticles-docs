---
title: ReflectionTypeLoadException error
description: Describes an issue that triggers a ReflectionTypeLoadException error after you apply an update rollup to System Center Virtual Machine Manager.
ms.date: 04/09/2024
ms.reviewer: wenca, ctimon, markstan
---
# VMM service doesn't start and returns ReflectionTypeLoadException after you apply an update rollup

This article helps you fix an issue in which Virtual Machine Manager service doesn't start and returns the **ReflectionTypeLoadException** error after you apply an update rollup.

_Original product version:_ &nbsp; Microsoft System Center Virtual Machine Manager  
_Original KB number:_ &nbsp; 3045931

## Symptoms

After you apply an update rollup for System Center Virtual Machine Manager, the System Center Virtual Machine Manager service may not start as expected. When you try to manually start the service, you receive the following pop-up message:

> The System Center Virtual Machine Manager service local computer started and then stopped. Some services stop automatically if they are not in use by other services or programs.

In this situation, the VirtualMachineManager\Server\Operational log may contain an event that resembles the following example:

> Log Name: Microsoft-VirtualMachineManager-Server/Operational  
> Source: Microsoft-VirtualMachineManager-Server  
> Event ID: 5004  
> Task Category: None  
> Level: Critical  
> Keywords: (2)  
> User: CONTOSO\VMMServiceAccount  
> Computer: VMM2012R2.contoso.com  
> Description:  
> VMM encountered a critical failure and will terminate the process. Check C:\ProgramData\VMMLogs\SCVMM.fcae9dc7-0779-4dce-b873-8ac20370c6fb\report.txt for a detailed report.

Event XML:

> \<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">  
> \<System>  
> \<~snip~>  
> \</System>  
> \<EventData>  
> \<Data Name="ReportPath">C:\ProgramData\VMMLogs\SCVMM.fcae9dc7-0779-4dce-b873-8ac20370c6fb\report.txt\</Data>
> \<Data Name="ExceptionToString">System.Reflection.ReflectionTypeLoadException: Unable to load one or more of the requested types. Retrieve the LoaderExceptions property for more information.  
> at System.Reflection.RuntimeModule.GetTypes(RuntimeModule module)  
> at System.Reflection.RuntimeModule.GetTypes()  
> at System.Reflection.Assembly.GetTypes()  
> at Microsoft.VirtualManager.Remoting.IndigoSerializableObject.BuildKnownAssemblyTypes(Assembly assembly)  
> at Microsoft.VirtualManager.Remoting.IndigoSerializableObject.InitializeKnownTypesCache(List`1 assembliesToExamine)  
> at Microsoft.VirtualManager.Engine.Remoting.IndigoServiceHost.InitializeKnownTypesCache()  
> at Microsoft.VirtualManager.Engine.VirtualManagerService.TimeStartupMethod(String description, TimedStartupMethod methodToTime)  
> at Microsoft.VirtualManager.Engine.VirtualManagerService.OnStart(String[] args)\</Data>  
> \<Data Name="Operation">  
> \</Data>  
> \</EventData>  
> \</Event>

## Cause

Update rollups for VMM may consist of more than one update package. In the most common scenario, an update is released for the VMM server and another is to be installed wherever the VMM console is installed. When server and console components are updated, interdependencies require both to be installed on the VMM server, with the VMM server fix being installed first. In the scenario it's described in the [Symptoms](#symptoms) section, only the VMM console update has been applied to the VMM server.

## Resolution

To resolve this issue, complete the update rollup installation by installing the VMM server update package in addition to the console update. Both the VMM server and VMM Admin Console updates must be at compatible version levels. It will typically be the same update rollup level. For example, a VMM Admin Console should be at the VMM UR5 level if the server is also at UR5.

In some instances, there may not be a comparable update for a component. In that case, the component should be updated to the most recent applicable update. For example, if the VMM server is updated to a post-UR5 hotfix, but there's no corresponding hotfix for the VMM Admin Console, the VMM Admin Console should be updated to UR5.

## More information

Frequently, server updates are deployed manually or through Windows Server Update Services (WSUS). For example, if one component is approved for installation and the other isn't approved for deployment, you may experience the issues that are described in the [Symptoms](#symptoms) section. Also be aware that an update rollup package may be classified as either a security update or an update rollup.

For example, UR5 updates are provided on the Microsoft Update Catalog with the following labels:

- [Security Update for Microsoft System Center 2012 R2 - Virtual Machine Manager UR5 (KB3023195)](https://www.catalog.update.microsoft.com/search.aspx?q=3023195)

- [Administrator Console update package: Update Rollup 5 for Microsoft System Center 2012 R2 - Virtual Machine Manager (KB3023914)](https://www.catalog.update.microsoft.com/search.aspx?q=3023914)

For the latest information about Update Rollup 5, see [Description of the security update for Update Rollup 5 for System Center 2012 R2 Virtual Machine Manager](https://support.microsoft.com/help/3023195).
