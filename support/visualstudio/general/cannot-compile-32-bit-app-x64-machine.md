---
title: Can't compile 32-bit applications on a x64 machine
description: Provides information about resolving the problem MSBuild 4.0 or Visual Studio 2010 can't compile a 32-bit application that's targeted for .NET Framework 3.5, 3.0 or 2.0 on x64 machine.
ms.date: 04/22/2020
ms.prod-support-area-path: Language or compilers
ms.reviewer: prabhatt, scotbren
---
# MSBuild 4.0 or Visual Studio 2010 may fail to compile a 32-bit application targeted for .NET Framework 3.5, 3.0 or 2.0 on a x64 machine

This article helps you resolve the problem where MSBuild 4.0 or Microsoft Visual Studio 2010 can't compile a 32-bit application that's targeted for .NET Framework 3.5, 3.0 or 2.0 on x64 machine.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2028833

## Symptoms

You're building an application targeted for x86 configuration on a x64 machine with Visual Studio 2010. The project contains a resource file referencing a 32-bit assembly. Target Framework selected is 3.5, 3.0 or 2.0.

You may get the following error:

> Form1.resx(161,5):error RG0000: Could not load file or assembly "<file_name>" or one of its dependencies. An attempt was made to load a program with an incorrect format. Line 161, position 5.  

The diagnostic build-log shows that task *GenerateResource* fails.

## Cause

Resgen.exe in `<system_drive>:\Program Files (x86)\Microsoft SDKs\Windows\vx.x\bin`, which is a part of Windows SDK, is marked as MSIL, so it will run as a 64-bit process. It will try to load a 32-bit assembly and fail.

## Resolution

In order to work around this issue, you need to perform the following steps:

1. Close all instances of Visual Studio.
2. From the Visual Studio Tools sub folder, open an elevated Visual Studio Command Prompt (2010) (using **Run as administrator** option). Change directory to `<system_drive>:\Program Files (x86)\Microsoft SDKs\Windows\v<x.xx>\bin\`.

3. Issue the command:

    ```console
    corflags /32bit+ ResGen.exe /force
    ```

4. Open \<project_name>.csproj in notepad.
5. Add the property `<ResGenToolArchitecture>Managed32Bit</ResGenToolArchitecture>` under the `PropertyGroup` section. Save and close the csproj file.

## More information

If you want to build a .resx file that references a 64-bit assembly targeting v3.5, v3.0 or v2.0, you may have to reverse this workaround before doing so.

[CorFlagsCorFlags.exe (CorFlags Conversion Tool)](/dotnet/framework/tools/corflags-exe-corflags-conversion-tool) may help you.
