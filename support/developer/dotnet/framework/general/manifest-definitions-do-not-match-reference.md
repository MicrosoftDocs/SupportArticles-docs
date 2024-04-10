---
title: Assembly Manifest doesn't match reference
description: This article describes a problem that cdf-ms files may be deleted when the Framework 3.5 Service pack 1 is installed and the ClickOnce store is used for the first time, and provides a resolution.
ms.date: 05/06/2020
---
# The located assembly's manifest definition doesn't match the assembly reference

This article helps you resolve an error (The located assembly's manifest definition does not match the assembly reference) that occurs when a ClickOnce application fails to run.

_Original product version:_ &nbsp; .NET Framework 3.5 Service pack 1  
_Original KB number:_ &nbsp; 971052

## Symptoms

When you install update to a ClickOnce application, the application failed to run with clues of some older binaries are used with the following error message:

> System.IO.FileLoadException: Could not load file or assembly XXXX, Version=x.x.x.x, Culture=neutral, PublicKeyToken=... or one of its dependencies. The located assembly's manifest definition does not match the assembly reference. (Exception from HRESULT: 0x80131040)

## Cause

When Microsoft .NET Framework 3.5 Service pack 1 is installed and the ClickOnce store is used for the first time, cdf-ms files may be deleted. This can also be caused by deleting the registry key `HKEY_CURRENT_USER\Software\Classes\Software\Microsoft\Windows\CurrentVersion\Deployment\ClickOnce35SP1Update`. The missing cdf-ms files will cause ClickOnce to wrongly share strong named assembly with the same version but different file hash.

## Resolution

To avoid the problem before it happens, make sure all shared assemblies that you're using in your updated ClickOnce application have a new assembly version.

If the problem has already happened, then you need to clear online cache by running `mage.exe -cc`, uninstall all versions of installed applications that might have a strong named assembly with the same version, and reinstall the application.

[Mage.exe](/dotnet/framework/tools/mage-exe-manifest-generation-and-editing-tool) is available in various locations, including the following ones:

- The .NET Framework 2.0 SDK

    The .NET Framework 2.0 SDK is available as a component of the Visual Studio 2005 setup.

- The Windows SDK for Windows Vista

    The Windows SDK for Windows Vista can be downloaded from the Microsoft Download Center.

- Visual Studio 2008

    Later versions of Mage.exe and MageUI.exe are included as a component of the Visual Studio 2008 setup.
