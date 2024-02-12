---
title: Use AssemblyVersion and AssemblyFileVersion
description: This article describes how to use AssemblyVersion and AssemblyFileVersion attributes in the AssemblyInfo.cs file.
ms.date: 04/14/2020
ms.topic: how-to
---
# Use AssemblyVersion and AssemblyFileVersion attributes

This article introduces how to use `AssemblyVersion` and `AssemblyFileVersion` attributes in the AssemblyInfo.cs file.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 556041

## Summary

AssemblyInfo.cs provides two attributes to set two different types of versions. This tip shows how to use those two attributes.

Microsoft .NET framework provides opportunity to set two different types of version numbers to each assembly.

## AssemblyVersion

It's the version number used by framework during build and at runtime to locate, link, and load the assemblies. When you add reference to any assembly in your project, it's this version number that gets embedded. At runtime, Common Language Runtime (CLR) looks for assembly with this version number to load. But remember this version is used along with name, public key token and culture information only if the assemblies are strong-named signed. If assemblies aren't strong-named signed, only file names are used for loading.

## AssemblyFileVersion

It's the version number given to file as in file system. It's displayed by Windows Explorer, and never used by .NET framework or runtime for referencing.

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

Providing a (*) in place of absolute number makes compiler increase the number by one every time you build.

Suppose you're building a framework assembly for your project that is used by lot of developers while building the application assemblies. If you release new version of assembly frequently, say once every day, and if assemblies are strong named, Developers will have to change the reference every time you release new assembly. It can be cumbersome and may lead to wrong references also. A better option in such closed group and volatile scenarios would be to fix the `AssemblyVersion` and change only the `AssemblyFileVersion`. Use the assembly file version number to communicate the latest release of assembly. In this case, developers won't have to change the references and they can overwrite the assembly in reference path. In central or final release builds it makes more sense to change the `AssemblyVersion` and most keep the `AssemblyFileVersion` same as assembly version.
