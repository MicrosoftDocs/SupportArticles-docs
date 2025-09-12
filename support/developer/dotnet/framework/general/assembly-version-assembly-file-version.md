---
title: Use AssemblyVersion and AssemblyFileVersion
description: This article describes how to use AssemblyVersion and AssemblyFileVersion attributes in the AssemblyInfo.cs file.
ms.date: 06/30/2025
ms.topic: how-to
ms.custom: sap:Common Language Runtime (CLR)
---
# Use AssemblyVersion and AssemblyFileVersion attributes

This article introduces how to use `AssemblyVersion` and `AssemblyFileVersion` attributes in the AssemblyInfo.cs file.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 556041

## Summary

AssemblyInfo.cs provides two attributes to define different types of version numbers. This article explains how to use these attributes effectively.

Microsoft .NET Framework allows you to set two different types of version numbers to each assembly.

## AssemblyVersion

AssemblyVersion is the version number used by the framework during build and at runtime to locate, link, and load the assemblies. When you add a reference to an assembly in your project, this version number is embedded. At runtime, Common Language Runtime (CLR) uses this version number to load the assembly.

Note: This version is used along with the assembly's name, public key token, and culture information only if the assembly is strong-named (signed). If the assembly isn't strong-named, only the file name is used for loading.

## AssemblyFileVersion

AssemblyFileVersion is the version number assigned to an assembly file as in file system. It's displayed by Windows Explorer, and never used by .NET Framework or runtime for referencing.

## Attributes in AssemblyInfo.cs

```csharp
// Version information for an assembly consists of the following four values:
// Major Version
// Minor Version
// Build Number
// Revision
[assembly: AssemblyVersion("1.0.0.0")]  
[assembly: AssemblyFileVersion("1.0.0.0")]
```

Using an asterisk (*) in place of a specific number allows the compiler to auto-increment the value with each build.

For example, if you're building a framework assembly that is used by many developers, and you release new versions frequently (for example, daily), and the assemblies are strong-named, developers would need to update their references with each release. It can be cumbersome and may lead to wrong references.

A better approach in such closed-group and volatile scenarios is to keep the `AssemblyVersion` fixed and update only the `AssemblyFileVersion`. It allows developers to overwrite the assembly in the reference path without changing their project references.

For central or final release builds, it's recommended to update the `AssemblyVersion` to reflect significant changes. In these cases, the `AssemblyFileVersion` is typically updated to match the `AssemblyVersion` for consistency.
