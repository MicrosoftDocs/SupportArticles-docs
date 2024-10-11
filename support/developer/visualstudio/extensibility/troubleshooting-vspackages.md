---
title: Troubleshoot issues with VSPackages
description: Describes common issues and troubleshooting tips with VSPackages.
ms.date: 11/04/2016
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: maiak
ms.custom: sap:Extensibility - Visual Studio SDK (VS SDK)\Extension and add-in development
---
# Troubleshoot issues with VSPackages

_Applies to:_&nbsp;Visual Studio

This article introduces common issues and troubleshooting tips with your [VSPackages](/visualstudio/extensibility/internals/vspackages).

## A VSPackage keeps Visual Studio from starting

In this scenario, start Visual Studio in safe mode by entering _devenv.exe /safemode_ at a command prompt. During this process, no VSPackages are loaded except the VSPackages that are included with Visual Studio.

## A VSPackage isn't loaded

To troubleshoot this issue, try one or more of the following steps:

- Make sure that you're using the registry root in which the VSPackage is registered to run, usually the experimental registry root. For more information, see [The Experimental Instance](/visualstudio/extensibility/the-experimental-instance).
- If the VSPackage is targeted to run in the experimental registry root, make sure that you're running the experimental version of Visual Studio.

    To run the experimental version, open a Visual Studio Command Prompt and then enter _devenv /rootsuffix exp_.
- Check your VSPackage registry entries. For more information, see [Registering VSPackages](/visualstudio/extensibility/registering-and-unregistering-vspackages) and [Managing VSPackages](/visualstudio/extensibility/managing-vspackages).
- Open the **Output** window of the instance of Visual Studio that is failing to load the VSPackage. Information about why the VSPackage is failing to load may be displayed in that window.

   > [!NOTE]
   > If you are starting the experimental version of Visual Studio from the Visual Studio integrated development environment (IDE), inspect the **Output** window of both versions.
- Examine the activity log. For more information, see [How to: Use the Activity Log](/visualstudio/extensibility/how-to-use-the-activity-log).
- For more information about exceptions thrown by the IDE, select **Exceptions** on the **Debug** menu to enable the exceptions. In the Exceptions dialog box, select the types of exceptions about which you want more information.

## A VSPackage isn't registered

Make sure that the VSPackage assembly resides in a trusted location. [RegPkg](/visualstudio/extensibility/internals/regpkg-utility) can't register assemblies in an untrusted or partially trusted location, such as a network share in the default .NET security configuration. Although a warning appears whenever a user creates a project in an untrusted location, the **Do not show this message again** checkbox can prevent this warning from reoccurring.

## A command isn't visible or it generates an error when it's selected

To solve this issue, try the following steps:

- Merge the new or changed menu commands and those commands already in the IDE by entering _devenv /rootsuffix Exp /setup_ at the Visual Studio Command Prompt.
- Make sure that Visual Studio can find UI.dll for your VSPackage.

   1. Find the CLSID of the VSPackage in the Packages section of the registry:

        `HKLM\Software\Microsoft\Visual Studio\<version>\Packages`
   1. Verify that the path given by the SatelliteDll subkey is correct.

## A VSPackage behaves unexpectedly

To troubleshoot this issue, try one or more of the following steps:

- Set breakpoints in your code.

     Good starting points for debugging are the constructor and the initialization method. You can also set breakpoints in the area you want to evaluate, such as a menu command. To enable breakpoints, you must run under the debugger.

    1. On the **Project** menu, select **Properties**.
    1. On the **Property Pages** dialog box, select the **Debug** tab.
    1. In the **Command line arguments** box, enter the root suffix of the development environment that your VSPackage targets. For example, to select the experimental build, enter: _/RootSuffix Exp_.
    1. On the **Debug** menu, select **Start Debugging** or press F5.

        > [!NOTE]
        > If you are debugging a project, create or load an existing instance of your project now.

- Use the activity log.

     Trace VSPackage behavior by writing information to the activity log at key points. This technique is especially useful when you run a VSPackage in a retail environment. For more information, see [How to: Use the Activity Log](/visualstudio/extensibility/how-to-use-the-activity-log).

- Use public symbols.

    To improve readability while debugging, you can attach symbols to the debugger:

    1. From the **Tools/Options** menu, navigate to the **Debugging/Symbols** dialog box.
    1. Add **Symbol file (.pdb) location**: `https://msdl.microsoft.com/download/symbols`.
    1. To improve performance, specify a symbol cache folder, for example: _C:\symbols_.

## A VSPackage or one of its dependencies is missing

- For managed code, make sure that the reference paths are correct.

   1. On the **Project** menu, select **Properties**.
   1. Select the **References** tab in the **Property Pages** dialog box and make sure all paths are correct. Alternatively, you can use the **Object Browser** to browse for the referenced objects.

        For managed code, you can use the [Fuslogvw.exe (Assembly Binding Log Viewer)](/dotnet/framework/tools/fuslogvw-exe-assembly-binding-log-viewer) to display the details of failed assembly loads.
- For unmanaged code, find the CLSID of the VSPackage in the Visual Studio CLSID registry node:

    `HKLM\Software\Microsoft\Visual Studio\<version>\CLSID`

   Make sure that the InprocServer32 entry has the correct path of the VSPackage DLL.

## References

- [VSPackages](/visualstudio/extensibility/internals/vspackages)
