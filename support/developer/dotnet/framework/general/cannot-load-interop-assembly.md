---
title: Can't build a .NET Framework-based project
description: This article provides a workaround for the problem where you cannot build a .NET Framework-based project in Visual Studio.
ms.date: 10/27/2020
ms.custom: sap:General
ms.reviewer: irfanahm
---
# Error when you build a project in Visual Studio

This article helps you resolve the problem where you cannot build a .NET Framework-based project in Visual Studio.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 2956788

## Symptoms

Consider the following scenario:

- You have an application that is built by using a .NET Framework 4.0-based project in Microsoft Visual Studio.

- This application has a Visual Basic 6.0 ActiveX control.

- This control references an Office primary interop assembly file. For example, an office.dll file.

- You re-target the project to the .NET Framework 4.5.x in Visual Studio.

In this scenario, when you build the project, this build program cannot load the interop assembly for the control. Additionally, you receive an error message that resembles the following:

> AxImp Error: Cannot resolve dependency to assembly 'office, Version=12.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c' because it has not been preloaded. When using the ReflectionOnly APIs, dependent assemblies must be pre-loaded or loaded on demand through the ReflectionOnlyAssemblyResolve event.

> [!NOTE]
> This issue only occurs on the computer that has the .NET Framework 4.0, the .NET Framework 4.5 or the .NET Framework 4.5.1, and the Microsoft Office product installed.

## Cause

This issue occurs because of a design change between common language runtime (CLR) 2.0 and CLR 4.0 on how the type libraries and dependencies are loaded.

The .NET Framework 4.0 needs certain assemblies to be loaded when you resolve types from a type library that references a primary interop assembly. However, that was not the case in the .NET Framework 2.0. The ActiveX importer did not change behavior between the .NET Framework 2.0 and the Framework 4.0. This design change prevents generation of the interop assemblies. Therefore, when ActiveX importer runs in Visual Studio, the importer cannot resolve and preload all references for this ActiveX control.

## Workaround

To work around this issue, create the interop assemblies by using AxImp.exe. For example, the error message that is mentioned in the [Symptoms](#symptoms) section indicates that the required Microsoft office assembly is version 12.0. To resolve this issue, follow these steps:

1. Find the required Office assembly in the Global Assembly Cache (GAC).
2. Select the path of the office version that is mentioned in the error message. It will be something like `C:\Windows\assembly\GAC\office\12.0.0.0__71e9bce111e9429c`.
3. Run the following command from the Visual Studio command prompt to generate the new interop assemblies:

    ```console
    aximp < **Name of Ocx** > /out: < **Interop assembly name** > /rcw: <C:\Windows\assembly\GAC\office\12.0.0.0__71e9bce111e9429c\office.dll>
    ```

4. Add the generated interop assemblies to your Visual Studio project by using the `Add References` feature.

> [!NOTE]
> If Office primary interop assembly is not installed on the computer, the AxImp.exe tool still can resolve the types without any assistance, even when it runs from the Visual Studio build process.

## More information

AxImp.exe is a command-line tool and is available with the Visual Studio. This tool accepts reference assemblies as command-line arguments. Therefore, this tool can load the additional assemblies that are expected by the .NET Framework 4.0.
