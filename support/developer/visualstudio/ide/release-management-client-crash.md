---
title: Release Management Client crashes
description: This article describes a problem in which Release Management Client crashes. This triggers a MissingSatelliteAssemblyException exception. Also provide a resolution.
ms.date: 04/27/2020
ms.custom: sap:Integrated Development Environment (IDE)\Other
ms.reviewer: achand, daleche, muthuk, sriramb, ronai, leov
---
# Release Management Client crashes and logs MissingSatelliteAssemblyException

This article helps you resolve a problem where Release Management Client for Microsoft Visual Studio 2013 crashes with a `MissingSatelliteAssemblyException` exception.

_Original product version:_ &nbsp; Visual Studio 2013  
_Original KB number:_ &nbsp; 2907779

## Symptoms

Release Management Client for Visual Studio 2013 crashes. When this problem occurs, an error event that resembles the following is logged in Event Viewer on the computer that's running Release Management Client:

> Application: ReleaseManagementConsole.exe  
> Framework Version: v4.0.30319  
> Description: The process was terminated due to an unhandled exception.  
> Exception Info: System.Resources.MissingSatelliteAssemblyException

## Resolution

To resolve this problem, download and install the Visual Studio 2013 Shell (Isolated) Redistributable Package from [Visual Studio Isolated Shell](https://visualstudio.microsoft.com/vs/older-downloads/isolated-shell/).

## References

[Known issues when you install Release Management for Visual Studio 2013](https://support.microsoft.com/help/2905736)
