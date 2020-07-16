---
title: Remove partner applications deployed by Secondary Installer
description: This article describes how to remove third-party applications that the Secondary Installer in Visual Studio 2015 setup lets users deploy to their computer.
ms.date: 04/17/2020
ms.prod-support-area-path:
ms.reviewer: rflaming
ms.topic: how-to
---
# Visual Studio 2015 setup: Secondary Installer uninstall instructions

This article introduces how to uninstall the third-party applications that are installed when you install the Secondary Installer for Microsoft Visual Studio 2015.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 3016536

## Secondary Installer

Visual Studio 2015 installs a Secondary Installer that lets you install third-party applications. When Visual Studio 2015 or the Secondary Installer is uninstalled, the third-party applications that were installed may not be uninstalled. These third-party applications may have entries in **Add or Remove Programs** item in Control Panel.

For more information about the third-party applications that the Secondary Installer lets you deploy to your computer and instructions to uninstall them, see the following sections.

## Android NDK

The Android Native Development Kit (NDK) doesn't have an entry in **Add or Remove Programs** item in Control Panel. It's installed locally in the following folder:  
`%ProgramFiles%\Microsoft Visual Studio 14.0\Apps`

The Android NDK can be removed by removing the *android-ndk-r10* folder from the hard disk.

## Android Software Development Kit (SDK)

Android has an entry in **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Apache Ant

Ant doesn't have an entry in **Programs and Features** item in Control Panel. To uninstall it, follow these steps:

1. Find the Ant folder on the hard disk. To do this, type `set ant` at a command prompt to see the Ant environment variable. The variable points to the folder.
2. Locate the folder, and then delete it.

## Apple iTunes

Apple iTunes has an entry in **Add or Remove Programs** in Control Panel and can be uninstalled from there.

## Git

Git has an entry in **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Google Chrome

Google Chrome has an entry in **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Joyent Node.js

Node has an entry in **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Oracle Java Development Kit (JDK)

Java has an entry in **Add or Remove Programs** item in Control Panel and can be uninstalled from there.

## Websocket4Net

Websocket4Net doesn't have an entry in **Add or Remove Programs** item in Control Panel and can't be uninstalled from there.

Websocket4Net is installed as a DLL to your operating system (only in Windows 7). To remove it, locate where Visual Studio 14.0 is installed. By default, it's installed to the following folder:  
`%ProgramFiles%\Microsoft Visual Studio 14.0`

In the root folder for Visual Studio, locate the `Common7\IDE\CommonExtensions\Microsoft\WebClient\Diagnostics\ToolWindows` subfolder. In that folder, delete *WebSocket4Net.dll*.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
