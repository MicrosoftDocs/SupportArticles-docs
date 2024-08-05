---
title: Install Windows SDK 7.1 in Silent Mode
description: This article describes how to install Microsoft Windows SDK for Windows 7 and .NET Framework 4 (Windows SDK v7.1) in Silent Mode.
ms.date: 10/27/2020
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.topic: how-to
---
# Installing Windows SDK 7.1 in Silent Mode

This article describes how to install Microsoft Windows SDK for Windows 7 and .NET Framework 4 (Windows SDK v7.1) in Silent Mode.

_Original product version:_ &nbsp; Windows SDK  
_Original KB number:_ &nbsp; 2498225

## Summary

Windows SDK for Windows 7 and .NET Framework 4 (Windows SDK v7.1) can be installed in Silent Mode.

Windows SDK v7.1 should be installed before Visual Studio 2010 SP1 (service pack 1) if the installation process is in Silent Mode.

Supported Operating Systems x86 and x64 platforms:  

- Windows XP SP3

- Windows 2003 Server

- Windows 2003 Server R2

- Windows 2008

- Windows 2008 R2

- Windows Vista

- Windows 7

Other prerequisite: .NET Framework 2.0.

The EULA (End User License Agreement) is available in the Release Notes. Using the silent installation does not negate this agreement. Review to ensure compliance.

In order to silently install download the ISO version of the SDK and extract the files. Using the web setup is not supported for silent installation.

The command to perform silent install: `setup.exe -q -params:ADDLOCAL=ALL`.

The .NET Framework 4 is required to install all components in the SDK. If .NET Framework 4 is not installed, the following components will not be installed:

- Compilers

- Intellisense & Reference Assemblies

- .NET Development Tool

- Microsoft Help System

All other components will still install as long as .NET Framework 2.0 is installed prior to installing the SDK.

Installation will fail if Visual Studio 2010 SP1 is installed on the system. No error will be presented during install. You can determine that the installation failed would either by reviewing the SDK setup logfile or through failing functionality. The workaround is to uninstall Visual Studio 2010 SP1 before installing the SDK.
