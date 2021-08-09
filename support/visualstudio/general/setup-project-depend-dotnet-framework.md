---
title: Setup projects have dependencies on .NET Framework
description: Installing .NET 4.5 (perhaps via VS 2012 installation) will cause setup projects for native applications in Visual Studio 2010 to add a .NET dependency they didn't have before.
ms.date: 04/27/2020
ms.prod-support-area-path: Project/Build system
ms.reviewer: candyc, sbonev, chrmann
---
# Visual Studio 2010 setup projects depend on .NET Framework after you install .NET Framework 4.5

This article helps you resolve a problem where installing Microsoft .NET 4.5 (perhaps via VS 2012 installation) causes a Visual Studio 2010 setup project has a dependency on the .NET Framework.

_Original product version:_ &nbsp; Visual Studio Premium 2010, Visual Studio Professional 2010, Visual Studio Ultimate 2010  
_Original KB number:_ &nbsp; 2735477

## Symptoms

You have a Visual Studio 2010 project that creates an installer for a native Visual C++ (VC++) application. The application doesn't require the .NET Framework to be installed. After installing .NET 4.5 (or Visual Studio 2012, which installs .NET 4.5), you observe your VS 2010 setup project now has a dependency on the .NET Framework.

## Cause

A managed assembly is being incorrectly added to the list of references for the native project, causing the native project to have a dependency on the .NET Framework.

## Resolution

The `AddAdditionalExplicitAssemblyReferences` property needs to be set to **false** for the VC++ project. One direct way to accomplish it would be to edit the .vcxproj file to do so. Before editing the .vcxproj, ensure that you don't have the project opened in any Visual Studio instances. With an Extensible Markup Language (XML) or text editor (such as the one in Visual Studio), you'll observe that the .vcxproj file begins something like this example:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <ItemGroup Label="ProjectConfigurations">
```

Before the `ItemGroup` tag, you'll add a `PropertyGroup` that modifies that property, so the above will have had three lines inserted:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project DefaultTargets="Build" ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
    <PropertyGroup>
        <AddAdditionalExplicitAssemblyReferences>false
        </AddAdditionalExplicitAssemblyReferences>
    </PropertyGroup>
    <ItemGroup Label="ProjectConfigurations">
```

Also, in the setup project, open the Launch Condition editor and remove the Microsoft .NET launch condition.

Once the changes have been made, you'll need to rebuild the setup project.

If you have multiple VC++ projects for which this change would be needed, refer to [How to: Use the Same Target in Multiple Project Files](/visualstudio/msbuild/how-to-use-the-same-target-in-multiple-project-files).
