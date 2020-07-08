---
title: Visual C++ 2010 toolset supports only .NET 4
description: Visual C++ 2010 toolset only supports .NET Framework 4 as a target framework version.
ms.date: 04/30/2020
ms.prod-support-area-path: 
---
# Visual C++ 2010 toolset supports only .NET Framework 4 as a target

This article provides the supported combinations of `TargetFrameworkVersion` and `PlatformToolset` settings in your Visual C++ project file when you build a C++/CLI project with Microsoft Visual Studio 2010.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2740044

## Supported combinations

When you build a C++/CLI project with Visual Studio 2010, you need to specify following combination of `TargetFrameworkVersion` and `PlatformToolset`:

- TargetFrameworkVersion = v4.0
- PlatformToolset = v100

If you also have Visual Studio 2008 installed on the same machine with Visual Studio 2010, and prefer to use the older toolset to target .NET 3.5, you can use the settings as follows:

- TargetFrameworkVersion = v3.5
- PlatformToolset = v90

Settings other than above aren't tested or supported, and other settings may cause unexpected build errors or behavior. Even if the build itself succeeds, Microsoft doesn't guarantee the specified C++ /.NET Framework version is loaded in the target application.

## References

For other articles on configuration above, visit the PlatformToolset Property section on [MSBuild internals for C++ projects](/cpp/build/reference/msbuild-visual-cpp-overview).
