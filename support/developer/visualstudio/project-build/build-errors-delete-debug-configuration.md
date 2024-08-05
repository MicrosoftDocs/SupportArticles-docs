---
title: Build errors when you delete the debug configuration
description: This article provides a resolution for the problem that occurs after the debug build configuration is removed from a solution and when a referenced .NET project is unloaded from the same solution.
ms.date: 01/04/2021
ms.custom: sap:Project - Build System\Build Issues
ms.topic: troubleshooting
---
# Build errors when you delete the debug configuration from a solution

This article helps you resolve the problem that occurs after the debug build configuration is removed from a solution and when a referenced .NET project is unloaded from the same solution.

_Applies to:_ &nbsp; Visual Studio  
_Original KB number:_ &nbsp; 3175301

## Symptoms

After you delete the debug build configuration from your solution in Visual Studio, and then you unload one or more referenced projects, you may encounter a build error that resembles the following:

> The `OutputPath` property is not set for project `ClassLibrary1.csproj`. Please check to make sure that you have specified a valid combination of Configuration and Platform for this project. Configuration='Debug' Platform='AnyCPU'. This error may also appear if some other project is trying to follow a project-to-project reference to this project, this project has been unloaded or is not included in the solution, and the referencing project does not build using the same or an equivalent Configuration or Platform.

## Cause

This is a known bug in Visual Studio 2012, 2013, and 2015.

This issue occurs when the configuration is deleted. IN this situation, the debug build configuration is left in the project file, as follows:

`<Configuration Condition=" '$(Configuration)' == '' ">Debug</Configuration>`

## Resolution

To work around this issue, change the name of the configuration from **Debug** to the new configuration name that was created in the csproj file of the unloaded project, as follows:

`<Configuration Condition=" '$(Configuration)' == '' "> Debug </Configuration>`

Change this to the following:

`<Configuration Condition=" '$(Configuration)' == '' "> Dev </Configuration>`

## More information

Microsoft is researching this problem and will post new information in this article it becomes available.
