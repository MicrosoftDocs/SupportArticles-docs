---
title: Determining the version of Visual FoxPro
description: This article provides information on how to determine what version of Visual FoxPro a custom executable is using.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.reviewer: TrevorH
ms.prod: visual-studio-family
---
# Determining the version of Visual FoxPro you are using

This article provides information on how to determine what version of Visual FoxPro a custom executable is using.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 2723045

## Symptoms

You have a copy of Visual FoxPro, or you are running a custom executable complied in Visual FoxPro. You want to determine the version of Visual FoxPro you have or that your executable is using.

## Resolution

If you have the development version of Visual FoxPro, you can determine the version using either of these methods:

- Go to Help> About Microsoft Visual FoxPro. The Version line reports the version of Visual FoxPro you have installed.
- Go to the Command window and type the following: WAIT WINDOW Version()

If you have a custom executable that you believe was created in Visual FoxPro, you can use [ListDLLs](/sysinternals/downloads/listdlls)  on your .EXE. For example, if you have OurCoolApp.exe, running this command would list the DLLs it has loaded: listdlls OurCoolApp. The resulting output pertaining to the VFP runtime files appears as shown here:

```console
0x000000000c000000 0x486000 C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\VFP9r.dll
0x000000000d200000 0x123000 C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\VFP9RENU.DLL
0x000000000e200000 0x542000 C:\Program Files (x86)\Common Files\Microsoft Shared\VFP\VFP9T.DLL
```

> [!NOTE]
> This output is form a 64-bit Windows 7 machine. Therefore, you see the path C:\Program Files (x86). If you are running Visual FoxPro on a 32-bit machine, you will not have this path.

The VFP9t.dll may not be present since it is only needed with multi-threaded COM objects.

## More information

Once you have located where the VFP9R.dll and VFP9RENU.dll reside, you can determine their versions. Open Windows Explorer and navigate to the folder indicated in the ListDLL output. Right-click, choose Properties, and then check file version on Details tab.

The first non-zero integer from the left in the version number is the version number of Visual FoxPro.
