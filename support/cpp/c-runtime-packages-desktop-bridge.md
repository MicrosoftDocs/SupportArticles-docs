---
title: C++ Runtime packages for Desktop Bridge
description: Describes how Windows desktop applications that have a dependency on the C++ Runtime libraries can"t redistribute the version of the libraries that's included with Visual Studio or via the Visual C++ redistributable (VCRedist) packages. Explains how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.
ms.date: 04/13/2020
ms.prod-support-area-path: C and C++ Libraries
ms.reviewer: ericmitt
ms.topic: how-to
---
# C++ Runtime framework packages for Desktop Bridge

This article describes how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.

_Original product version:_ &nbsp; Windows 10  
_Original KB number:_ &nbsp; 3176696

## Summary

Windows desktop applications that have a dependency on the C++ Runtime libraries must specify the corresponding version of the C++ Runtime framework package for Desktop Bridge during creation of the application package. This must be done instead of just redistributing the C++ Runtime libraries that are included with Visual Studio or the Visual C++ Runtime redistributable (VCRedist). Windows desktop applications that run in a Desktop Bridge container cannot use the C++ Runtime libraries that are included with Visual Studio or VCRedist. An application that's running in a Desktop Bridge container and that uses an incorrect version of the C++ runtime libraries might fail when it tries to access resources such as the file system or the registry. This article discusses how to create a Desktop Bridge container that includes the correct C++ Runtime libraries.

## How to update a desktop application container

Microsoft provides C++ Runtime framework packages to allow developers to reference the C++ runtime from desktop applications that will be distributed through the Windows Store and to assist developers with converting existing desktop applications to Universal Windows Platform (UWP) applications. Additionally, these packages will eventually be distributed and updated through the Windows Store, similar to the way that C++ UWP framework packages are handled.

1. Download and install the C++ Runtime framework package for the C++ Runtime version used by your application. C++ Runtime framework package can be downloaded for the following C++ Runtime versions:

    - Download [C++ Runtime v11.0 framework package for Desktop Bridge (Project Centennial)](https://www.microsoft.com/download/details.aspx?id=53340).

    - Download [C++ Runtime v12 framework package for Desktop Bridge (Project Centennial)](https://www.microsoft.com/download/details.aspx?id=53176).

    - Download [C++ Runtime v14 framework package for Desktop Bridge (Project Centennial)](https://www.microsoft.com/download/details.aspx?id=53175).

    The C++ Runtime framework packages will be copied to a folder under `%ProgramFiles(x86)%\Microsoft SDKs\Windows Kits\10\ExtensionSDKs\Microsoft.VCLibs.Desktop`. You can install the packages manually using the `Add-AppxPackage` PowerShell cmdlet.

2. In your application's *AppxManifest.xml* file, specify a `PackageDependency` value that corresponds to the appropriate framework package:

    Version 11.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.110.00.UWPDesktop" MinVersion="11.0.61135.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US"/>
    </Dependencies>
    ```

    Version 12.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.120.00.UWPDesktop" MinVersion="120.40653.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
        <PackageDependency Name="Microsoft.VCLibs.120.00.UWPDesktop" MinVersion="12.0.40653.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
    </Dependencies>
    ```

    Version 14.0:

    ```xml
    <Dependencies>
        <PackageDependency Name="Microsoft.VCLibs.140.00.UWPDesktop" MinVersion="14.0.24217.0" Publisher="CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US" />
    </Dependencies>
    ```

    The application will now install the C++ Runtime DLLs from the dependency package when it's deployed.

## References

 [Using Visual C++ Runtime in Centennial project](https://devblogs.microsoft.com/cppblog/using-visual-c-runtime-in-centennial-project/)
