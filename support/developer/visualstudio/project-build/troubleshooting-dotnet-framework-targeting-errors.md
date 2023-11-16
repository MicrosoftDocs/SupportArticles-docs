---
title: Troubleshoot .NET Framework targeting errors
description: This article provides resolutions for MSBuild errors that might occur because of reference issues.
ms.date: 10/07/2022
f1_keywords:
- vs.FrameworkTargetingErrors
- MSBuild.ResolveAssemblyReference.FailedToResolveReferenceBecausePrimaryAssemblyInExclusionList
ms.reviewer: ghogen, v-jayaramanp
---

# Troubleshoot .NET Framework targeting errors

_Applies to:_&nbsp;Visual Studio

This topic describes [MSBuild](/visualstudio/msbuild/msbuild) errors that might occur because of reference issues and how you can resolve those errors.

## Reference a project or assembly that targets a different version of .NET

You can create applications that reference projects or assemblies that target different versions of .NET. For example, you can create an application that targets .NET 6 but references an assembly that targets .NET Core 3.1. However, you can't set a reference in a project that targets an earlier version of .NET to a project or assembly that targets .NET 6. Here's an example of the error you might see in this case:

```output
error NU1201: Project ClassLibrary-NET6 is not compatible with netcoreapp3.1 (.NETCoreApp,Version=v3.1). Project ClassLibrary-NET6 supports: net6.0 (.NETCoreApp,Version=v6.0)
2>Done building project "ClassLibrary-NET31.csproj" -- FAILED.
```

To resolve the error, make sure that your application targets a .NET version that's compatible with the version that's targeted by the projects or assemblies that your application references.

## Re-target a project to a different version of .NET

If you change the target version of .NET for your application, Visual Studio changes some of the references, but you might have to update some references manually. For example, one of the previously mentioned errors might occur if you change an application to target .NET Core 3.1 and that application has references, resources, or settings that rely on .NET 6.

:::image type="content" source="media/troubleshooting-dotnet-framework-targeting-errors/change-target-framework.png" alt-text="Screenshot that shows changing the target framework in Visual Studio.":::

### Update references in app.config

To work around application settings in .NET Framework applications, follow these steps:

1. Open **Solution Explorer**.
1. Select **Show All Files**, and then edit the _app.config_ file in the XML editor of Visual Studio.
1. Change the version in the settings to match the appropriate version of .NET. For example, you can change the version setting from 4.0.0.0 to 2.0.0.0.

Similarly, for an application that has added resources, follow these steps:

1. Open **Solution Explorer**.
1. Select **Show All Files**.
1. Expand **My Project** (Visual Basic) or **Properties** (C#), and then edit the _Resources.resx_ file in the XML editor of Visual Studio.
1. Change the version setting from 4.0.0.0 to 2.0.0.0.

### Update resources

If your application has resources such as icons or bitmaps or settings such as data connection strings, you can also resolve the error by removing all the items on the **Settings** page of the **Project Designer** and then readding the required settings.

## You re-target a project to a different version of .NET and references aren't resolved

If you re-target a project to a different version of .NET, your references may not resolve properly in some cases. Explicit fully qualified references to assemblies often cause this issue, but you can resolve it by removing the references that don't resolve and then adding them back to the project. As an alternative, you can edit the project file to replace the references. First, remove references of the following form:

```xml
<Reference Include="System.ServiceModel, Version=3.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089, processorArchitecture=MSIL" />
```

Then, replace them with the simple form:

```xml
<Reference Include="System.ServiceModel" />
```

> [!NOTE]
> After you close and reopen your project, you should also rebuild it to ensure that all references resolve correctly.

## References

- [How to: Target a version of the .NET Framework](/visualstudio/ide/visual-studio-multi-targeting-overview)
- [.NET Framework client profile](/dotnet/framework/deployment/client-profile)
- [Framework targeting overview](/visualstudio/ide/visual-studio-multi-targeting-overview)
- [Multitargeting](/visualstudio/msbuild/msbuild-multitargeting-overview)
