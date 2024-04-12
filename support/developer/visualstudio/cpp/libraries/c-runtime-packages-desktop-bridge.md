---
title: C++ Runtime packages for Desktop Bridge
description: Describes how Windows desktop applications that have a dependency on the C++ Runtime libraries can't redistribute the version of the libraries that's included with Visual Studio or via the Visual C++ redistributable (VCRedist) packages. Explains how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.
ms.date: 04/13/2020
ms.custom: sap:C and C++ Libraries\C and C++ runtime libraries and Standard Template Library (STL)
ms.reviewer: ericmitt, sherifm
ms.topic: how-to
---
# C++ Runtime framework packages for Desktop Bridge

This article describes how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 3176696

## Summary

Windows desktop applications that have a dependency on the C++ Runtime libraries must specify the corresponding version of the C++ Runtime framework package for Desktop Bridge during creation of the application package. This must be done instead of just redistributing the C++ Runtime libraries that are included with Visual Studio or the Visual C++ Runtime redistributable (VCRedist). Windows desktop applications that run in a Desktop Bridge container cannot use the C++ Runtime libraries that are included with Visual Studio or VCRedist. An application that's running in a Desktop Bridge container and that uses an incorrect version of the C++ runtime libraries might fail when it tries to access resources such as the file system or the registry. This article discusses how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.

## How to install and update Desktop framework packages

Microsoft provides C++ Runtime framework packages to allow applications to reference the C++ runtime from desktop applications distributed through the Windows Store. These packages are distributed and updated through the Windows Store and are handled similarly to C++ UWP framework packages.

For development purposes, the current version (v14.0) of both debug and retail appx packages are included with Visual Studio 2019 when you choose the **Universal Windows Platform Development** workload with the optional **C++ (v142) Universal Windows Tools** component. The packages can be found under `%ProgramFiles(x86)%\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.VCLibs.Desktop\14.0`.

In some scenarios such as [Windows Sandbox](/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview) or where applications run on offline machines, developers may find it easier to download the packages corresponding to their deployment architectures from one of the links below and manually install them using the `Add-AppxPackage` PowerShell cmdlet:

- [Microsoft.VCLibs.arm.14.00.Desktop.appx](https://aka.ms/Microsoft.VCLibs.arm.14.00.Desktop.appx)
- [Microsoft.VCLibs.arm64.14.00.Desktop.appx](https://aka.ms/Microsoft.VCLibs.arm64.14.00.Desktop.appx)
- [Microsoft.VCLibs.x64.14.00.Desktop.appx](https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx)
- [Microsoft.VCLibs.x86.14.00.Desktop.appx](https://aka.ms/Microsoft.VCLibs.x86.14.00.Desktop.appx)

## Legacy Desktop framework packages

Older C++ Runtime framework packages for desktop applications, v11.0 and v12.0, can be downloaded and installed from these locations:

- [C++ Runtime v11.0 framework package for Desktop Bridge (Project Centennial)](https://www.microsoft.com/download/details.aspx?id=53340)
- [C++ Runtime v12 framework package for Desktop Bridge (Project Centennial)](https://www.microsoft.com/download/details.aspx?id=53176)

The C++ Runtime framework packages will be copied to a subfolder under `%ProgramFiles(x86)%\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.VCLibs.Desktop`. You can install the packages manually using the `Add-AppxPackage` PowerShell cmdlet.

## How to reference the Desktop framework packages

In your application's *AppxManifest.xml* file, specify a `PackageDependency` value that corresponds to the appropriate framework package:

- Version 11.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.110.00.UWPDesktop" MinVersion="11.0.61135.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US"/>
    </Dependencies>
    ```

- Version 12.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.120.00.UWPDesktop" MinVersion="120.40653.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
        <PackageDependency Name="Microsoft.VCLibs.120.00.UWPDesktop" MinVersion="12.0.40653.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
    </Dependencies>
    ```

- Version 14.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.140.00.UWPDesktop" MinVersion="14.0.24217.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
    </Dependencies>
    ```

The application will now install the C++ Runtime DLLs from the dependency package when it's deployed.

## References

 [Using Visual C++ Runtime in Centennial project](https://devblogs.microsoft.com/cppblog/using-visual-c-runtime-in-centennial-project/)
