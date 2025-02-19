---
title: Install an assembly into GAC
description: Describes how to install an assembly into the Global Assembly Cache in Visual C#. This article also gives some sample steps to explain related information.
ms.date: 04/13/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C#
---
# Use Visual C# to install an assembly into the Global Assembly Cache

This article provides information about how to install an assembly into the Global Assembly Cache in Visual C#.

_Original product version:_ &nbsp; Visual C#  
_Original KB number:_ &nbsp; 815808

## Summary

This article describes how to generate a strong name for an assembly, and how to install a .dll file in the Global Assembly Cache (GAC). With the GAC, you can share assemblies across many applications. The GAC is automatically installed with the .NET runtime. Components are typically stored in `C:\WINNT\Assembly`.

To install an assembly in the GAC, you must give the assembly a strong name. The name is a cryptographic hash-key, or signature. This strong name ensures correct component versioning. This helps prevent components that have the same name from conflicting with each other, or from being incorrectly used by a consuming application.

## Requirements

- Administrator rights to the computer where the shared assembly is being installed
- General familiarity with assemblies in .NET.
- General familiarity with the use of tools at the command prompt.

## Global Assembly Cache

To create a small Class Library project by using Visual Studio, to generate a strong name, and to install the .dll file of the project in the GAC, follow these steps:

1. In Visual Studio, create a new Visual C# Class Library project, and name the project *GACDemo*.
2. You must use a strong name. To generate this cryptographic key pair, use the Strong Name tool (Sn.exe). This tool is located in the `\bin` subdirectory where the .NET Framework Solution Developer Kit (SDK) is installed. The Sn.exe tool is easy to use. The command-line statement takes the following

    ```console
    sn -k "[DriveLetter]:\[DirectoryToPlaceKey]\[KeyName].snk"
    ```

    > [!NOTE]
    > In Visual Studio, you can use the IDE project properties to generate a key pair and sign your assembly. Then, you can skip step 3 and step 4 and also skip making any code changes to the *AssemblyInfo.cs* file.

    To use the IDE project properties to generate a key pair and sign your assembly, follow these steps:

    1. In Solution Explorer, right-click **GACDemo**, and then click **Properties**.
    2. Click the **Signing** tab, and then click to select the **Sign the assembly** check box.
    3. In the **Choose a strong name key** list, click **<New...>**.
    4. Type *GACkey.snk* as the key file name, clear the **Protect my key file with a password** check box, and then click **OK**.

    5. Press CTRL+SHIFT+B keyboard shortcut to compile the project.

    After you follow these steps, you still must follow step 5 to install your assembly in the GAC.

3. Create a directory named *GACKey* in `C:\` so that you can easily locate the key, and access the key at the command prompt.

    For most users, the .NET tools are located in `C:\Program Files\Microsoft.NET\FrameworkSDK\Bin`. Before you type the following command, you may want to copy this similar path on your computer to the .NET bin directory. Type `cd` at the command prompt, right-click to paste the path, and then press ENTER to quickly change to the directory where the SN Tool is located.

    Type the following command:

    ```console
    sn -k "C:\GACKey\GACkey.snk"
    ```

4. A key is generated, but it is not yet associated with the assembly of the project. To create this association, double-click the *AssemblyInfo.cs* file in Visual Studio .NET Solution Explorer. This file has the list of assembly attributes that are included by default when a project is created in Visual Studio .NET. Modify the `AssemblyKeyFile` assembly attribute in the code as follows:

    ```csharp
    [assembly: AssemblyKeyFile('C:\\GACKey\\GACKey.snk') ]
    ```

    Compile the project by pressing CTRL+SHIFT+B. You do not have to have any additional code to install a .dll file in the GAC.

5. You can install the .dll file by using the Gacutil tool or by dragging the .dll file to the appropriate folder. If you use the Gacutil tool, you can use a command that resembles the following:

    ```console
    gacutil -I "[DriveLetter]:\[PathToBinDirectoryInVSProject]\gac.dll"
    ```

    To drag the file, open two instances of Windows Explorer. In one instance, find the location of the .dll file output for your console project. In the other instance, find `c:\<SystemRoot>\Assembly`. Then, drag your .dll file to the Assembly folder.

## Complete code listing (AssemblyInfo.cs)

```csharp
using System.Reflection;
using System.Runtime.CompilerServices;

// General Information about an assembly is controlled through the following
// set of attributes. Change these attribute values to modify the information
// that is associated with an assembly.
[assembly: AssemblyTitle("")]
[assembly: AssemblyDescription("")]
[assembly: AssemblyConfiguration("")]
[assembly: AssemblyCompany("")]
[assembly: AssemblyProduct("")]
[assembly: AssemblyCopyright("")]
[assembly: AssemblyTrademark("")]
[assembly: AssemblyCulture("")]

// Version information for an assembly is made up of the following four values:
// Major Version
// Minor Version
// Build Number
// Revision
// You can specify all the values, or you can default the revision and build numbers
// by using the '*' as shown below:
[assembly: AssemblyVersion("1.0.*")]
// To sign your assembly you must specify a key to use. See the
// Microsoft .NET Framework documentation for more information about assembly signing.
// Use the following attributes to control that key is used for signing.
// Notes:
//     (*) If no key is specified, the assembly is not signed.
//     (*) KeyName refers to a key that has been installed in the Crypto Service
//         Provider (CSP) on your computer. KeyFile refers to a file that contains
//         a key.
//     (*) If the KeyFile and the KeyName values are both specified, the
//         following processing occurs:
//         (1) If the KeyName can be found in the CSP, that key is used.
//         (2) If the KeyName does not exist and the KeyFile does exist, the key
//             in the KeyFile is installed to the CSP and used.
//     (*) To create a KeyFile, you can use the sn.exe (Strong Name) utility.
//         When specifying the KeyFile, the location of the KeyFile must be
//         relative to the project output directory which is
//         %Project Directory%\obj\<configuration>. For example, if your KeyFile is
//         located in the project directory, you would specify the AssemblyKeyFile
//         attribute as [assembly: AssemblyKeyFile("..\\..\\mykey.snk")]
//     (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
//         documentation for more information about this.
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyKeyFile("C:\\GACKey\\GACKey.snk")]
[assembly: AssemblyKeyName("")]
```

## Verification

1. Start Windows Explorer.
2. Locate `C:\SystemRoot\assembly`.
3. You see **GACDemo** in the list of installed .dll files.

## References

- [Installing an Assembly into the Global Assembly Cache](/previous-versions/dotnet/netframework-1.1/dkkx7f79(v=vs.71))

- [Global Assembly Cache](/previous-versions/dotnet/netframework-1.1/yf1d93sz(v=vs.71))

- [Global Assembly Cache Tool (Gacutil.exe)](/previous-versions/dotnet/netframework-1.1/ex0ss12c(v=vs.71))
