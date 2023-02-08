---
title: Remove partner app deployed by Secondary Installer
description: Describes how to remove third-party applications that the Secondary Installer in Visual Studio 2015 setup lets users deploy to their computer.
ms.date: 04/17/2020
ms.custom: sap:Installation
ms.reviewer: rflaming
ms.topic: troubleshooting
---
# Uninstall third-party applications deployed by the Secondary Installer in Visual Studio 2015

This article explains how to uninstall the third-party applications that are installed when you install the Secondary Installer for Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 3016536

## What's Secondary Installer

Visual Studio 2015 installs a Secondary Installer that lets you install third-party applications. When Visual Studio 2015 or the Secondary Installer is uninstalled, the third-party applications that were installed may not be uninstalled. These third-party applications may have entries in **Add or Remove Programs** item in Control Panel.

The following sections provide more information about the third-party applications that the Secondary Installer lets you deploy on your computer, and instructions about how to uninstall them.

## Uninstall Android Software Development Kit (SDK), Apple iTunes, Git, Google Chrome, joyent Node.js, and Oracle Java Development Kit (JDK)

These apps have entries in the **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Uninstall Android Native Development Kit (NDK)

The Android NDK doesn't have an entry in the **Add or Remove Programs** item in Control Panel. It's installed locally in this folder: `%ProgramFiles%\Microsoft Visual Studio 14.0\Apps`

The Android NDK can be removed by removing the *android-ndk-r10* folder from the hard disk.

## Uninstall Apache Ant

Here is how to uninstall this app:

1. Find the Ant folder on the hard disk by typing `set ant` at a command prompt to see the Ant environment variable. The variable points to the folder.
2. Locate and delete the folder.

## Uninstall Websocket4Net

Websocket4Net is installed as a DLL of Windows 7 operating system only. Here is how to uninstall this app:

1. Locate the Visual Studio 14.0 folder. By default, it's installed in this folder: `%ProgramFiles%\Microsoft Visual Studio 14.0`.

1. In the root folder for Visual Studio, locate the `Common7\IDE\CommonExtensions\Microsoft\WebClient\Diagnostics\ToolWindows` subfolder and delete *WebSocket4Net.dll*.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
