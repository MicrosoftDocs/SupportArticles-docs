---
title: Release Management Client crashes 
description: Describes an issue in which Release Management Client crashes. This triggers a MissingSatelliteAssemblyException exception. Also provide a resolution.
ms.date: 04/27/2020
ms.prod-support-area-path: 
ms.reviewer: achand, daleche, muthuk, sriramb, ronai, leov
---
# Release Management Client crashes and logs a MissingSatelliteAssemblyException error

This article provides information about resolving the issue that Release Management Client for Visual Studio 2013 crashes.

_Original product version:_ &nbsp; Microsoft Visual Studio 2013  
_Original KB number:_ &nbsp; 2907779

## Symptoms

Release Management Client for Visual Studio 2013 crashes. When this issue occurs, an error event that resembles the following is logged in Event Viewer on the computer that's running Release Management Client:

> Application: ReleaseManagementConsole.exe  
> Framework Version: v4.0.30319  
> Description: The process was terminated due to an unhandled exception.  
> Exception Info: System.Resources.MissingSatelliteAssemblyException

## Resolution

To resolve this issue, download and install the Microsoft Visual Studio 2013 Shell (Isolated) Redistributable Package from [Visual Studio Isolated Shell](https://visualstudio.microsoft.com/vs/older-downloads/isolated-shell/).

## References

[Known issues when you install Release Management for Visual Studio 2013](https://support.microsoft.com/help/2905736)
