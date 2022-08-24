---
title: Uninstall third-party applications
description: This article introduces how to uninstall the third-party applications that are installed together with Visual Studio 2015.
ms.date: 04/22/2020
ms.custom: sap:Installation
ms.topic: how-to
---
# Uninstall third-party applications for Visual Studio 2015

This article describes how to uninstall the third-party applications that are installed together with Microsoft Visual Studio 2015. When you uninstall Visual Studio 2015, the third-party applications that are installed together with Visual Studio 2015 aren't uninstalled.

_Original product version:_ &nbsp; Visual Studio 2015  
_Original KB number:_ &nbsp; 3060695

## Android NDK

The Android Native Development Kit (NDK) doesn't have an entry in the **Programs and Features** item in Control Panel. It is installed locally in the following folder:  
`%ALLUSERSPROFILE%\Microsoft Visual Studio 14.0\Apps`

The Android NDK can be removed by removing the *Android-ndk-r10* folder from the hard disk.

## Android SDK

Android Software Development Kit (SDK) has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Apache Ant

Ant doesn't have an entry in the **Programs and Features** item in Control Panel. To uninstall this application, follow these steps:

1. Locate the Ant installation folder on the hard disk. To do this, inspect the registry for the `ANT_HOME` value name in the following registry path:  
    `SOFTWARE\Wow6432Node\Microsoft\VisualStudio\14.0\Setup\VS\SecondaryInstaller\Ant`  

    Typically, the installation folder value data will be as follows:  
    `C:\Program Files (x86)\Microsoft Visual Studio 14.0\Apps\apache-ant-1.9.3`

2. Delete the installation folder.

## Git CLI

Git has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## GitHub Extension for Visual Studio

GitHub Extension for Visual Studio has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Google Chrome

Chrome has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Joyent Node.js

Node has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Oracle Java Development Kit

Java has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Xamarin

Xamarin has an entry in the **Programs and Features** item in Control Panel and can be uninstalled from there.

## Websocket4Net (for Windows 7 users only)

Websocket4Net doen't have an entry in the **Programs and Features** item in Control Panel and cannot be uninstalled from there.

Websocket4Net is installed as a DLL to your operating system (only in Windows 7). To uninstall this application, follow these steps:

1. Locate the installation folder for Visual Studio 14.0. By default, it is installed to the following folder:  
    `%ProgramFiles%\Microsoft Visual Studio 14.0`

2. In the root folder for Visual Studio, locate the following subfolder:  
    `Common7\IDE\CommonExtensions\Microsoft\WebClient\Diagnostics\ToolWindows`

3. In this folder, locate and delete `WebSocket4Net.dll`.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

## Applies to

- Visual Studio Professional 2015
- Visual Studio Express 2015 for Windows Desktop
- Visual Studio Express 2015 for Web
- Visual Studio Express 2015 for Windows 10
