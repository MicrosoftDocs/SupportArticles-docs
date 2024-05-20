---
title: Changes in the TSAware behavior
description: This article describes changes in the TSAware flag behavior in .NET Framework 3.5 SP1.
ms.date: 05/06/2020
ms.reviewer: dougste
ms.topic: article
---
# Change in the TSAware flag behavior in .NET Framework 3.5 SP1

This article describes changes in the TSAware flag behavior in Microsoft .NET Framework 3.5 Service Pack 1 (SP1).

_Original product version:_ &nbsp; .Net 3.5 Framework Service Pack 1  
_Original KB number:_ &nbsp; 2229865

## Changes in the TSAware behavior

From .Net 3.5 Framework SP1 onwards, the [/TSAWARE](/previous-versions/visualstudio/visual-studio-2008/01cfys9z(v=vs.90)) flag is set to ON by default in the PE header of the image produced by the included C# and Visual Basic. NET compilers. It can be verified by running dumpbin.exe on any C#/VB.net assembly built by using those compilers as follows:

```console
Dumpbin /Headers <assembly_name>.exe(dll)
```

Sample output:  

```console
8540 DLL characteristics
Dynamic base
NX compatible
No structured exception handler
Terminal Server Aware
```

> [!NOTE]
> Dumpbin.exe is included in the Windows SDK and is also installed with Visual Studio.

For Visual C++ projects, this flag can be edited through Visual Studio integrated development environment (IDE) as follows:

1. Open the project's **Property Pages** dialog box. For details, see **Setting Visual C++ Project Properties**.
2. Select the **Linker** folder.
3. Select the **System** property page.
4. Modify the **Terminal Server** property.

## More information

As per the [/TSAWARE](/previous-versions/visualstudio/visual-studio-2008/01cfys9z(v=vs.90)) documentation, when an application is not Terminal Server aware (also known as a legacy application), Terminal Server makes certain modifications to the legacy application to make it work properly in a multiuser environment. For example, Terminal Server will create a virtual Windows folder, such that each user gets a Windows folder instead of getting the system's Windows directory. It gives users access to their own INI files. In addition, Terminal Server makes some adjustments to the registry for a legacy application. These modifications slow the loading of the legacy application on Terminal Server.  

It is recommended that you update your application to be **TSAWARE** and not modify this flag.
