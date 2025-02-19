---
title: Uninstall third-party applications deployed by secondary installer in Visual Studio 2015
description: Describes how to remove third-party applications that the secondary installer in Visual Studio 2015 setup lets users deploy to their computer.
ms.date: 02/20/2023
ms.custom: sap:Installation\Setup, maintenance, or uninstall
ms.reviewer: rflaming, matcav
ms.topic: troubleshooting
---
# Uninstall third-party applications deployed by the secondary installer in Visual Studio 2015

This article explains how to uninstall the third-party applications that are installed using the secondary installer for Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 3016536

## What's secondary installer

Visual Studio 2015 has a secondary installer that lets you install third-party applications that support development of cross platform and mobile applications. When Visual Studio 2015 is uninstalled, the third-party applications may still remain installed. These third-party applications may or may not have entries in **Add or Remove Programs** item in Control Panel.

The following sections provide more information about the third-party applications that the secondary installer lets you deploy on your computer, and instructions about how to uninstall them.

## Uninstall Android Software Development Kit (SDK), Apple iTunes, Git, Google Chrome, Joyent Node.js, and Oracle Java Development Kit (JDK)

These apps have entries in the **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Uninstall Android Native Development Kit (NDK)

The Android NDK doesn't have an entry in the **Add or Remove Programs** item in Control Panel. It's installed locally in this folder: `%ProgramFiles%\Microsoft Visual Studio 14.0\Apps`

The Android NDK can be removed by removing the *android-ndk-r10* folder from the hard disk.

## Uninstall Apache Ant

Ant doesn't have an entry in the **Programs and Features** item in Control Panel. To uninstall this application, follow these steps:

1. Find the Ant installation folder on the hard disk by typing `set ant` at a command prompt to see the Ant environment variable. The variable points to the folder.
2. Locate and delete the folder.

## Uninstall Websocket4Net

Websocket4Net is installed as a DLL of Windows 7 operating system only. To uninstall this application, follow these steps:

1. Locate the Visual Studio 14.0 installation folder. By default, it's installed in this folder: `%ProgramFiles%\Microsoft Visual Studio 14.0`.

1. In the root folder for Visual Studio, locate the `Common7\IDE\CommonExtensions\Microsoft\WebClient\Diagnostics\ToolWindows` subfolder and delete *WebSocket4Net.dll*.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
