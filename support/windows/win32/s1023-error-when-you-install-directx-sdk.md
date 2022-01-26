---
title: S1023 error when you install the DirectX SDK
description: This article provides resolutions for S1023 error that occurs when you install the June 2010 release of DirectX SDK.
ms.date: 10/26/2020
ms.custom: sap:Graphics and multimedia development
ms.reviewer: stevelee
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# 'S1023' error when you install the DirectX SDK

This article helps you resolve 'S1023' error that occurs when you install the June 2010 release of DirectX SDK.

_Original product version:_ &nbsp; Windows 8 Enterprise, Windows 7 Enterprise, Windows 7 Home Basic, Windows 7 Professional  
_Original KB number:_ &nbsp; 2728613

## Symptoms

If you have an existing Microsoft Visual C++ 2010 Redistributable installed on your computer, you may receive an 'S1023' error when you install the June 2010 DirectX SDK.

## Cause

The issue occurs because a newer version of the Visual C++ 2010 Redistributable is present on the computer. The June 2010 DirectX SDK installs version 10.0.30319 of the Visual C++ Redistributable.

## Resolution

To resolve this issue, you must uninstall all versions of the Visual C++ 2010 Redistributable before installing the June 2010 DirectX SDK. You may have one or more of the following products installed:

- Microsoft Visual C++ 2010 x86 Redistributable
- Microsoft Visual C++ 2010 x64 Redistributable

You can use **Add or Remove Programs**  in Control Panel to uninstall the products. Or, you can run the following commands from an administrator command prompt:

```console
MsiExec.exe /passive /X{F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}

MsiExec.exe /passive /X{1D8E6291-B0D5-35EC-8441-6616F567A0F7}
```

After uninstalling the Microsoft Visual C++ 2010 Redistributable products, you may install the [DirectX Software Development Kit](https://www.microsoft.com/download/details.aspx?id=6812).

After installing the June 2010 DirectX SDK, you may then reinstall the most current version of the [Microsoft Visual C++ 2010 Service Pack 1 Redistributable Package MFC Security Update](https://www.microsoft.com/download/details.aspx?id=26999).

## More information

The same issue can prevent installation of the Windows 7 SDK.
